/*
	TeamFortress V2.5

	TeamFortress Software
	Robin Walker, John Cook, Ian Caughley
*/			
void (entity targ, entity inflictor, entity attacker, float damage) T_Damage;
void (entity targ, entity inflictor, entity attacker, float damage, float T_flags, float T_AttackType) TF_T_Damage;
void () player_run;
void(entity bomb, entity attacker, float rad, entity ignore) T_RadiusDamage;
void() TeamFortress_DisplayDetectionItems;
float(vector veca, vector vecb) crossproduct;
void(vector org, float damage) SpawnBlood;
void(entity rhook) Reset_Grapple;
void() SuperDamageSound;
float() W_BestWeapon;
void() ConcussionGrenadeTimer;
void() W_PrintWeaponMessage;
void() button_touch;
void() button_fire;

// TeamFortress Impulse Commands
void() TeamFortress_ChangeClass;
void() TeamFortress_DisplayLegalClasses;
void() TeamFortress_Inventory;
void() TeamFortress_SaveMe;
void() TeamFortress_ID;
void() TeamFortress_ShowTF;
void() TeamFortress_SniperWeapon;
void() TeamFortress_AssaultWeapon;
void() TeamFortress_IncendiaryCannon;
void() TeamFortress_FlameThrower;
void() TeamFortress_PrimeGrenade;
void() TeamFortress_ThrowGrenade;
void() TeamFortress_Discard;
void(entity p) TeamFortress_SetSpeed;
void() TeamFortress_DetonatePipebombs;
void() PipebombTouch;
void() TeamFortress_DetpackStop;
void() SniperSight_Create;
void(float zoom_level) TF_zoom;
void() TeamFortress_ReloadCurrentWeapon;
void() TeamFortress_AutoZoomToggle;
void() TeamFortress_StatusQuery;
void() TeamFortress_SpyGoUndercover;
void() TeamFortress_SpyFeignDeath;
void() TeamFortress_EngineerBuild;
void() DropKey;
void() UseSpecialSkill;

// TeamFortress Pre-Impulse Commands
void(float scanrange) TeamFortress_Scan;
void(float timer) TeamFortress_SetDetpack;

// Team Functions
float(float tno) TeamFortress_TeamSet;
void(float tno) TeamFortress_TeamShowScores;
void(entity Player) TeamFortress_TeamShowMemberClasses;

// Camera Functions
void() CamLock;
void() CamDistLock;
void() CamVecLock; 
void() CamAngleLock;
void() CamRevAngleLock;
void() CamProjectileLock;
void() CamProjectileZoom;
void() CamProjectileLockOn;
void() CamProjectileLockOff;
void() CamOffset;
void() CamDrop;
void() fadetoblack;
void() fadefromblack;
void() fadetowhite;
void() fadefromwhite;

// Engineer Functions
void(entity disp) Engineer_UseDispenser;
void(entity gun) Engineer_UseSentryGun;
void(entity mortar) Engineer_UseMortar;

void(entity spy) Spy_RemoveDisguise;

// Help functions
void() TeamFortress_MOTD;
void() TeamFortress_HelpMap;
void(float res) StatusRes;

// BioInfection functions
void() BioInfection_Decay;
void() BioInfection_MonsterDecay;

// Attacking functions
void() W_FireFlame;
void() W_FireIncendiaryCannon;
void() W_FireTranq;
void() W_FireLaser;

// Timer Functions
void() HallucinationTimer;
void() TranquiliserTimer;

// CTF Support functions
void() TeamFortress_CTF_FlagInfo;

// #PC_UNDEFINED viewing functions
void() TF_MovePlayer;

// called by worldspawn
void() W_Precache =
{
	precache_sound ("weapons/r_exp3.wav");	// new rocket explosion
	precache_sound ("weapons/rocket1i.wav");// spike gun
	precache_sound ("weapons/sgun1.wav");
	precache_sound ("weapons/guncock.wav");	// player shotgun
	precache_sound ("weapons/ric1.wav");	// ricochet (used in c code)
	precache_sound ("weapons/ric2.wav");	// ricochet (used in c code)
	precache_sound ("weapons/ric3.wav");	// ricochet (used in c code)
	precache_sound ("weapons/spike2.wav");	// super spikes
	precache_sound ("weapons/tink1.wav");	// spikes tink (used in c code)
	precache_sound ("weapons/grenade.wav");	// grenade launcher
	precache_sound ("weapons/bounce.wav");	// grenade bounce
	precache_sound ("weapons/shotgn2.wav");	// super shotgun
	precache_sound ("wizard/wattack.wav");  // sniper rifle
	precache_sound ("items/r_item1.wav");	// Medikit
	precache_sound ("items/r_item2.wav");	// Medikit
    precache_model ("progs/flame2.mdl");  	// Flamethrower
	precache_sound ("ambience/fire1.wav");
	precache_sound2("blob/land1.wav");      // Hook
	precache_model2("progs/v_spike.mdl");	// Hook
	precache_sound ("hknight/hit.wav");		// Hook
// NEW FILES
	precache_sound ("weapons/turrset.wav");	  // Sentry Gun Setup
	precache_sound ("weapons/turrspot.wav");  // Sentry Gun Spot 
	precache_sound ("weapons/turridle.wav");  // Sentry Gun Idle
    precache_sound ("weapons/sniper.wav");	  // sniper rifle
    precache_sound ("weapons/flmfire2.wav");  // flamethrower
    precache_sound ("weapons/flmgrexp.wav");  // flamethrower
	precache_sound ("misc/vapeur2.wav");	  // flamethrower
	precache_sound ("weapons/asscan1.wav");	  // Assault Cannon Powerup
	precache_sound ("weapons/asscan2.wav");	  // Assault Cannon Churning
	precache_sound ("weapons/asscan3.wav");	  // Assault Cannon Powerdown
	precache_sound ("weapons/railgun.wav");	  // Railgun
	precache_sound ("weapons/dartgun.wav");   // Spy's dart gun
};

float() crandom =
{
	return 2*(random() - 0.5);
};

//======================================================================
// Calculate the attack_finished time
void(float att_delay) Attack_Finished =
{
	if (self.tfstate & #TFSTATE_TRANQUILISED)
		self.attack_finished = time + (att_delay * 1.5);
	else 
		self.attack_finished = time + att_delay;
};

/*
================
W_FireAxe
================
*/
void() W_FireAxe =
{
	local	vector	source;
	local	vector	org, def;

	makevectors(self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*64, #FALSE, self);
	if (trace_fraction == 1.0)
		return;
	
	org = trace_endpos - v_forward*4;

	if (trace_ent.takedamage)
	{
		trace_ent.axhitme = 1;

		SpawnBlood (org, 20);

		if (self.playerclass != #PC_SPY || trace_ent.classname != "player")
		{
			deathmsg = #DMSG_AXE;
			TF_T_Damage (trace_ent, self, self, 20, #TF_TD_NOTTEAM, #TF_TD_OTHER);
		}
		else	// spy can try for the backstab!
		{
			self.weaponmode = 1; // Put blood on the knife
  			self.weaponmodel = "progs/v_knife2.mdl";

			// Check direction of Attack
			makevectors(trace_ent.v_angle);
			def = v_right;
			makevectors(self.v_angle);

			// Backstab
			if (crossproduct(def,v_forward) > 0)
			{
				deathmsg = #DMSG_BACKSTAB;
				TF_T_Damage (trace_ent, self, self, 120, #TF_TD_NOTTEAM, #TF_TD_OTHER);
			}
			else
			{
				deathmsg = #DMSG_AXE;
				TF_T_Damage (trace_ent, self, self, 40, #TF_TD_NOTTEAM, #TF_TD_OTHER);
			}
		}
	}
	else
	{	// hit wall
		sound (self, #CHAN_WEAPON, "player/axhit2.wav", 1, #ATTN_NORM);
		WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
		WriteByte (#MSG_BROADCAST, #TE_GUNSHOT);
	#ifdef QUAKE_WORLD
		WriteByte (#MSG_MULTICAST, 3);
	#endif
		WriteCoord (#MSG_BROADCAST, org_x);
		WriteCoord (#MSG_BROADCAST, org_y);
		WriteCoord (#MSG_BROADCAST, org_z);
	#ifdef QUAKE_WORLD
		multicast (org, #MULTICAST_PVS);
	#endif
	}
};

/*
================
W_FireSpanner
================
*/
void() W_FireSpanner =
{
	local vector source;
	local vector org, def;
	local float healam;
	local entity te;

	makevectors(self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*64, #FALSE, self);
	if (trace_fraction == 1.0)
		return;
	
	org = trace_endpos - v_forward*4;

	// It may be a trigger that can be activated by the engineer's spanner
	if (trace_ent.goal_activation & #TFGA_SPANNER)
	{
		// Does the AP match the AP Criteria?
		if (Activated(trace_ent,self))
		{
			DoResults(trace_ent, self, #TRUE);

			if (trace_ent.classname == "func_button")
			{
				trace_ent.enemy = self;
				other = self;
				self = trace_ent;
				self.dont_do_triggerwork = #TRUE;	// Already done in DoResults
				button_fire();
				self = other;
			}
		}
		else
		{
			// If an else goal should be activated, activate it
			if (trace_ent.else_goal != 0)
			{
				te = Findgoal(trace_ent.else_goal);
				if (te)
					DoResults(te, self, (trace_ent.goal_result & #TFGR_ADD_BONUSES));
			}
			else
			{
				sound (self, #CHAN_WEAPON, "player/axhit2.wav", 1, #ATTN_NORM);
				WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
				WriteByte (#MSG_BROADCAST, #TE_GUNSHOT);
			#ifdef QUAKE_WORLD
				WriteByte (#MSG_MULTICAST, 3);
			#endif
				WriteCoord (#MSG_BROADCAST, org_x);
				WriteCoord (#MSG_BROADCAST, org_y);
				WriteCoord (#MSG_BROADCAST, org_z);
			#ifdef QUAKE_WORLD
				multicast (org, #MULTICAST_PVS);
			#endif
			}
		}

		return;
	}

	if (trace_ent.takedamage)
	{
		// Engineer can repair/use his buildings
		if (trace_ent.classname == "building_dispenser")
		{
			Engineer_UseDispenser(trace_ent);
			return;
		}
		else if (trace_ent.classname == "building_sentrygun")
		{
			Engineer_UseSentryGun(trace_ent);
			return;
		}
		else if (trace_ent.classname == "building_sentrygun_base")
		{
			if (trace_ent.oldenemy)
				Engineer_UseSentryGun(trace_ent.oldenemy);
			return;
		}
		else if (trace_ent.classname == "building_mortar")
		{
			Engineer_UseMortar(trace_ent);
			return;
		}
		else
		{
			if (trace_ent.classname == "player")
			{
				if ((trace_ent.team_no == self.team_no && self.team_no != 0 && teamplay) || (coop))
				{
					healam = #WEAP_SPANNER_REPAIR;
					if (self.ammo_cells < healam)
						healam = self.ammo_cells;

					// Only fix armor if they've got some
					if (trace_ent.armortype == 0)
						return;

					if (trace_ent.maxarmor - trace_ent.armorvalue < (healam * 4))
						healam = ceil((trace_ent.maxarmor - trace_ent.armorvalue) / 4);
						
					if (healam > 0)
					{
						trace_ent.armorvalue = trace_ent.armorvalue + (healam * 4);
						if (trace_ent.armorvalue > trace_ent.maxarmor)
							trace_ent.armorvalue = trace_ent.maxarmor;

						self.ammo_cells = self.ammo_cells - healam;

						sound(trace_ent, #CHAN_WEAPON, "items/r_item1.wav", 1, #ATTN_NORM);
						WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
						WriteByte (#MSG_BROADCAST, #TE_GUNSHOT);
					#ifdef QUAKE_WORLD
						WriteByte (#MSG_MULTICAST, 3);
					#endif
						WriteCoord (#MSG_BROADCAST, org_x);
						WriteCoord (#MSG_BROADCAST, org_y);
						WriteCoord (#MSG_BROADCAST, org_z);
					#ifdef QUAKE_WORLD
						multicast (org, #MULTICAST_PVS);
					#endif

						W_SetCurrentAmmo ();
					}
					return;
				}
			}

			trace_ent.axhitme = 1;
			SpawnBlood (org, 20);

			deathmsg = #DMSG_SPANNER;
			TF_T_Damage (trace_ent, self, self, 20, #TF_TD_NOTTEAM, #TF_TD_OTHER);
		}
	}
	else // hit wall
	{	
		sound (self, #CHAN_WEAPON, "player/axhit2.wav", 1, #ATTN_NORM);
		WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
		WriteByte (#MSG_BROADCAST, #TE_GUNSHOT);
	#ifdef QUAKE_WORLD
		WriteByte (#MSG_MULTICAST, 3);
	#endif
		WriteCoord (#MSG_BROADCAST, org_x);
		WriteCoord (#MSG_BROADCAST, org_y);
		WriteCoord (#MSG_BROADCAST, org_z);
	#ifdef QUAKE_WORLD
		multicast (org, #MULTICAST_PVS);
	#endif
	}
};

/*
================
W_FireMedikit  
================
*/

void() W_FireMedikit =
{
	local	vector	source;
	local	vector	org;
	local	float healam;	
	local 	entity te, BioInfection;

	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*64, #FALSE, self);
	if (trace_fraction == 1.0)
		return;
	
	org = trace_endpos - v_forward*4;

	if (trace_ent.takedamage)
	{
		if (trace_ent.classname == "player")
		{
			if ((trace_ent.team_no == self.team_no && self.team_no != 0) || (coop))
			{
				healam = #WEAP_MEDIKIT_HEAL;

				// remove concussion from player
				// Try to find a concusstimer entity for this player
				te = find(world, classname, "timer");
				while (((te.owner != trace_ent) || (te.think != ConcussionGrenadeTimer)) && (te != world))
				{
					te = find(te, classname, "timer");
				}

				if (te != world)
				{
					stuffcmd(trace_ent ,"v_idlescale 0\n");
					SpawnBlood(org, 20);
					sprint(trace_ent, #PRINT_HIGH, "you have been healed of your concussion\n");

					// Give the medic a frag for doing it, only if it was caused by an enemy
					if (te.team_no != self.team_no)
					{
						self.real_frags = self.real_frags + 1;
			 			if (!(toggleflags & #TFLAG_TEAMFRAGS))
							self.frags = self.real_frags;
					}

					dremove(te);
				}

				// remove hallucination from player
				// Try to find a hallucination timer entity for this player
				if (trace_ent.tfstate & #TFSTATE_HALLUCINATING)
				{
					te = find(world, classname, "timer");
					while (((te.owner != trace_ent) || (te.think != HallucinationTimer)) && (te != world))
					{
						te = find(te, classname, "timer");
					}

					if (te != world)
					{
						trace_ent.tfstate = trace_ent.tfstate - (trace_ent.tfstate & #TFSTATE_HALLUCINATING);

						SpawnBlood(org, 20);
						sprint(trace_ent, #PRINT_HIGH, "you have been healed of your hallucinations\n");

						// Give the medic a frag for doing it, only if it was caused by an enemy
						if (te.team_no != self.team_no)
						{
							self.real_frags = self.real_frags + 1;
				 			if (!(toggleflags & #TFLAG_TEAMFRAGS))
								self.frags = self.real_frags;
						}

						dremove(te);
					}
					else
					{
						dprint("Warning: Error in Hallucination Timer logic.\n");
					}
				}

				// remove tranquilisation from player
				// Try to find a tranquilisation timer entity for this player
				if (trace_ent.tfstate & #TFSTATE_TRANQUILISED)
				{
					te = find(world, classname, "timer");
					while (((te.owner != trace_ent) || (te.think != TranquiliserTimer)) && (te != world))
					{
						te = find(te, classname, "timer");
					}

					if (te != world)
					{
						trace_ent.tfstate = trace_ent.tfstate - (trace_ent.tfstate & #TFSTATE_TRANQUILISED);
						TeamFortress_SetSpeed(trace_ent);

						SpawnBlood(org, 20);
						sprint(trace_ent, #PRINT_HIGH, "you have been healed of your tranquilisation\n");

						// Give the medic a frag for doing it, only if it was caused by an enemy
						if (te.team_no != self.team_no)
						{
							self.real_frags = self.real_frags + 1;
				 			if (!(toggleflags & #TFLAG_TEAMFRAGS))
								self.frags = self.real_frags;
						}

						dremove(te);
					}
					else
					{
						dprint("Warning: Error in Tranquilisation Timer logic.\n");
					}
				}

				// check if the healed player is blinded
				if (trace_ent.FlashTime > 0)
				{
					te = find(world, netname, "flashtimer");
					while ((te.owner != trace_ent || te.classname != "timer") && (te != world))
						te = find(te, netname, "flashtimer");

					if (te != world)
					{
						trace_ent.FlashTime = 0;
						SpawnBlood(org, 20);

						// Give the medic a frag for doing it, only if it was caused by an enemy
						if (te.team_no != self.team_no)
						{
							self.real_frags = self.real_frags + 1;
				 			if (!(toggleflags & #TFLAG_TEAMFRAGS))
								self.frags = self.real_frags;
						}

						dremove(te);
					}
					else
					{
						dprint("Warning: Error in Flash Timer logic.\n");
						trace_ent.FlashTime = 0;
					}
				}

				// check if the healed player is infected
				if (trace_ent.tfstate & #TFSTATE_INFECTED)
				{
					healam = rint(trace_ent.health / 2);

					// remove the infection
					trace_ent.tfstate = trace_ent.tfstate - (trace_ent.tfstate & #TFSTATE_INFECTED);

					// some damage is caused (because of the use of leeches!)
					// remove half their remaining health
					deathmsg = #DMSG_MEDIKIT;
					T_Damage(trace_ent, self, self, healam);

					SpawnBlood(org, 30);
					sprint(trace_ent, #PRINT_HIGH, "Your infection is cured!\n");

					if (self.classname == "player")
					{
						sprint(self, #PRINT_HIGH, "You have healed ");
						sprint(self, #PRINT_HIGH, trace_ent.netname);
						sprint(self, #PRINT_HIGH, " of the infection.\n");

						// Give the medic a frag for doing it, only if it was caused by an enemy
						if (trace_ent.infection_team_no != self.team_no)
						{
							self.real_frags = self.real_frags + 1;
				 			if (!(toggleflags & #TFLAG_TEAMFRAGS))
								self.frags = self.real_frags;
						}
					}

					return;
				}

				// put out the fire if they are burning
				if (trace_ent.numflames > 0)
				{
					sound(trace_ent, #CHAN_WEAPON, "items/r_item1.wav", 1, #ATTN_NORM);

					trace_ent.numflames = 0;

					sprint(trace_ent, #PRINT_HIGH, "The flames have been doused!\n");

					if (self.classname == "player")
					{		
						sprint(self, #PRINT_MEDIUM, "You have put out ");
						sprint(self, #PRINT_MEDIUM, trace_ent.netname);
						sprint(self, #PRINT_MEDIUM, "'s fire.\n");	
					}
					
					return;
				}

				if (healam > 0 && trace_ent.health < trace_ent.max_health)
				{
					sound(trace_ent, #CHAN_WEAPON, "items/r_item1.wav", 1, #ATTN_NORM);
					trace_ent.axhitme = 1;
					SpawnBlood (org, 20);

					T_Heal(trace_ent, healam, 0);
				}
				else if (trace_ent.health >= trace_ent.max_health && trace_ent.health < (trace_ent.max_health + #WEAP_MEDIKIT_OVERHEAL))
				{
					healam = 5;
					if (healam > (self.ammo_medikit * 5))
						healam = (self.ammo_medikit * 5);
					if (healam > 0)
					{
						sound(trace_ent, #CHAN_ITEM, "items/r_item2.wav", 1, #ATTN_NORM);
						T_Heal(trace_ent, healam, 1);
						self.ammo_medikit = self.ammo_medikit - rint(healam / 5);
						if (!(trace_ent.items & #IT_SUPERHEALTH))
						{
							trace_ent.items = trace_ent.items | #IT_SUPERHEALTH;
							newmis = spawn();
							newmis.classname == "medikit_rot";
							newmis.nextthink = time + 5;
							newmis.think = item_megahealth_rot;
							newmis.owner = trace_ent;
						}
					}
				}
			}

#ifdef MEDIKIT_IS_BIOWEAPON
			else  // musn't be on their team, so we infect them
			{
				trace_ent.axhitme = 1;
				SpawnBlood (org, 20);

				deathmsg = #DMSG_BIOWEAPON_ATT;
				T_Damage (trace_ent, self, self, 10);

				if (trace_ent.playerclass == #PC_MEDIC)
					return;

				trace_ent.tfstate = trace_ent.tfstate | #TFSTATE_INFECTED;

				BioInfection = spawn ();
				BioInfection.classname = "timer";
				BioInfection.owner = trace_ent;
				BioInfection.nextthink = time + 2;
				BioInfection.think = BioInfection_Decay;
				BioInfection.enemy = self;

				trace_ent.infection_team_no = self.team_no;
			}
#endif

  		}
	}
	else
	{	// hit wall
		sound (self, #CHAN_WEAPON, "player/axhit2.wav", 1, #ATTN_NORM);
		WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
		WriteByte (#MSG_BROADCAST, #TE_GUNSHOT);
	#ifdef QUAKE_WORLD
		WriteByte (#MSG_MULTICAST, 3);
	#endif
		WriteCoord (#MSG_BROADCAST, org_x);
		WriteCoord (#MSG_BROADCAST, org_y);
		WriteCoord (#MSG_BROADCAST, org_z);
	#ifdef QUAKE_WORLD
		multicast (org, #MULTICAST_PVS);
	#endif
	}
};

/*
================
W_FireBioweapon
================
*/

void() W_FireBioweapon =
{
	local	vector	source;
	local	vector	org;
	local	float healam;	

	local 	entity BioInfection;

	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*64, #FALSE, self);
	if (trace_fraction == 1.0)
		return;
	
	org = trace_endpos - v_forward*4;

	if (trace_ent.takedamage)
	{
		if (trace_ent.classname == "player")
		{
			if ((trace_ent.team_no != self.team_no && self.team_no != 0 && teamplay) || teamplay == 0)
			{
				trace_ent.axhitme = 1;
				SpawnBlood (org, 20);
		
				deathmsg = #DMSG_BIOWEAPON_ATT;
				T_Damage (trace_ent, self, self, 10);

				if (trace_ent.playerclass == #PC_MEDIC)
					return;

				trace_ent.tfstate = trace_ent.tfstate | #TFSTATE_INFECTED;

				BioInfection = spawn ();
				BioInfection.classname = "timer";
				BioInfection.owner = trace_ent;
				BioInfection.nextthink = time + 2;
				BioInfection.think = BioInfection_Decay;
				BioInfection.enemy = self;

				trace_ent.infection_team_no = self.team_no;
			}
		}
		else if (trace_ent.flags & #FL_MONSTER)
		{
			if (trace_ent.classname == "monster_zombie")
			{
				// zombie slayer!
				T_Damage (trace_ent, self, self, 200);
			}

			trace_ent.axhitme = 1;
			SpawnBlood(org, 20);
			T_Damage (trace_ent, self, self, 10);

			BioInfection = spawn ();
			BioInfection.classname = "timer";
			BioInfection.nextthink = time + 2;
			BioInfection.think = BioInfection_MonsterDecay;
			BioInfection.owner = self;
			BioInfection.enemy = trace_ent;
		}
		else // must be a switch
		{
			trace_ent.axhitme = 1;
			SpawnBlood (org, 30);

			T_Damage(trace_ent, self, self, 40);
		}
	}
	else
	{	// hit wall
		sound (self, #CHAN_WEAPON, "player/axhit2.wav", 1, #ATTN_NORM);
		WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
		WriteByte (#MSG_BROADCAST, #TE_GUNSHOT);
	#ifdef QUAKE_WORLD
		WriteByte (#MSG_MULTICAST, 3);
	#endif
		WriteCoord (#MSG_BROADCAST, org_x);
		WriteCoord (#MSG_BROADCAST, org_y);
		WriteCoord (#MSG_BROADCAST, org_z);
	#ifdef QUAKE_WORLD
		multicast (org, #MULTICAST_PVS);
	#endif
	}
};


//============================================================================


vector() wall_velocity =
{
	local vector	vel;
	
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
	local	entity missile;
	local	vector	org;

	missile = spawn ();
	missile.owner = self;
	missile.movetype = #MOVETYPE_BOUNCE;
	missile.solid = #SOLID_NOT;

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

void(vector org, float damage) SpawnBlood =
{
#ifndef QUAKE_WORLD
	particle (org, #VEC_ORIGIN, 73, damage*2);
#else
	WriteByte (#MSG_MULTICAST, #SVC_TEMPENTITY);
	WriteByte (#MSG_MULTICAST, #TE_BLOOD);
	WriteByte (#MSG_MULTICAST, 1);
	WriteCoord (#MSG_MULTICAST, org_x);
	WriteCoord (#MSG_MULTICAST, org_y);
	WriteCoord (#MSG_MULTICAST, org_z);
	multicast (org, #MULTICAST_PVS);
#endif
};



/*
================
spawn_touchblood
================
*/
void(float damage) spawn_touchblood =
{
	local vector	vel;

	vel = wall_velocity () * 0.2;
	SpawnBlood (self.origin + vel*0.01, damage);
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

entity	multi_ent;
float	multi_damage;

#ifdef QUAKE_WORLD
vector  blood_org;
float   blood_count;

vector  puff_org;
float   puff_count;
#endif

void() ClearMultiDamage =
{
	multi_ent = world;
	multi_damage = 0;
#ifdef QUAKE_WORLD
	blood_count = 0;
	puff_count = 0;
#endif
};

void() ApplyMultiDamage =
{
	if (!multi_ent)
		return;
	// don't set deathmsg here, since it'll be set by the weapon that fired
	TF_T_Damage (multi_ent, self, self, multi_damage, #TF_TD_NOTTEAM, #TF_TD_SHOT);
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
	else
		multi_damage = multi_damage + damage;
};

#ifdef QUAKE_WORLD
void() Multi_Finish =
{
	if (puff_count)
	{
		WriteByte (#MSG_MULTICAST, #SVC_TEMPENTITY);
		WriteByte (#MSG_MULTICAST, #TE_GUNSHOT);
		WriteByte (#MSG_MULTICAST, puff_count);
		WriteCoord (#MSG_MULTICAST, puff_org_x);
		WriteCoord (#MSG_MULTICAST, puff_org_y);
		WriteCoord (#MSG_MULTICAST, puff_org_z);
		multicast (puff_org, #MULTICAST_PVS);
	}

	if (blood_count)
	{
		WriteByte (#MSG_MULTICAST, #SVC_TEMPENTITY);
		WriteByte (#MSG_MULTICAST, #TE_BLOOD);
		WriteByte (#MSG_MULTICAST, blood_count);
		WriteCoord (#MSG_MULTICAST, blood_org_x);
		WriteCoord (#MSG_MULTICAST, blood_org_y);
		WriteCoord (#MSG_MULTICAST, blood_org_z);
		multicast (puff_org, #MULTICAST_PVS);
	}
};
#endif

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
	local	vector	vel, org;
	
	vel = normalize(dir + v_up*crandom() + v_right*crandom());
	vel = vel + 2*trace_plane_normal;
	vel = vel * 200;

	org = trace_endpos - dir*4;

	if (trace_ent.takedamage)
	{
		#ifndef QUAKE_WORLD
			SpawnBlood (org, damage);
		#else
			blood_count = blood_count + 1;
			blood_org = org;
		#endif

		AddMultiDamage (trace_ent, damage);
	}
	else
	{
#ifndef QUAKE_WORLD
		WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
		WriteByte (#MSG_BROADCAST, #TE_GUNSHOT);
		WriteCoord (#MSG_BROADCAST, org_x);
		WriteCoord (#MSG_BROADCAST, org_y);
		WriteCoord (#MSG_BROADCAST, org_z);
#else
		puff_count = puff_count + 1;
#endif
	}
};

/*
================
FireBullets

Used by shotgun, super shotgun, assault cannon, and enemy soldier firing
Go to the trouble of combining multiple pellets into a single damage call.
================
*/
void(float shotcount, vector dir, vector spread) FireBullets =
{
	local	vector direction;
	local	vector	src;
	
	makevectors(self.v_angle);

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;

	ClearMultiDamage ();

#ifdef QUAKE_WORLD
	traceline (src, src + dir*2048, #FALSE, self);
	puff_org = trace_endpos - dir*4;
#endif

	while (shotcount > 0)
	{
		direction = dir + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		traceline (src, src + direction*2048, #FALSE, self);
		if (trace_fraction != 1.0)
		{
			if (self.weapon != #WEAP_ASSAULT_CANNON)
				TraceAttack (4, direction);
			else
				TraceAttack (9, direction);
		}

		shotcount = shotcount - 1;
	}
	ApplyMultiDamage ();
#ifdef QUAKE_WORLD
	Multi_Finish ();
#endif
};

/*
================
W_FireShotgun
================
*/
void() W_FireShotgun =
{
	local vector dir;

	sound (self, #CHAN_WEAPON, "weapons/guncock.wav", 1, #ATTN_NORM);	

	KickPlayer(-2, self);
				 
	self.currentammo = self.ammo_shells = self.ammo_shells - 1;
	dir = aim (self, 100000);

	deathmsg = #DMSG_SHOTGUN;
	FireBullets (6, dir, '0.04 0.04 0');
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
		
	sound (self ,#CHAN_WEAPON, "weapons/shotgn2.wav", 1, #ATTN_NORM);	

	KickPlayer(-4, self);

	self.currentammo = self.ammo_shells = self.ammo_shells - 2;
	dir = aim (self, 100000);
	deathmsg = #DMSG_SSHOTGUN;
	FireBullets (14, dir, '0.14 0.08 0');
};


/*
================
FireSniperBullet
Used by sniper rifle firing (W_FireSniperRifle)
================
*/
void(vector direction, float damage) FireSniperBullet =
{
	local	vector	src;

	makevectors(self.v_angle);

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;

	ClearMultiDamage ();

    traceline (src, src + direction*4096, #FALSE, self);

	if (trace_fraction != 1.0)
   		TraceAttack (damage, direction);

	ApplyMultiDamage ();
};


/*
=================================
TeamFortress : W_FireSniperRifle
=================================
*/
void() W_FireSniperRifle =
{
	local vector dir, src;
	local float dam_mult, zdif, use_this;

	sound (self ,#CHAN_WEAPON, "weapons/sniper.wav", 1, #ATTN_NORM);
	KickPlayer(-2, self);
	self.currentammo = self.ammo_shells = self.ammo_shells - 1;

	makevectors(self.v_angle);
	src = self.origin + v_forward * 10;
	src_z = self.absmin_z + self.size_z * 0.7;

	use_this = #FALSE;
    traceline (src, src + dir*8092, #FALSE, self);
	if (trace_fraction != 1.0)
	{
		if (trace_ent != world)
		{
			if (trace_ent.classname == "player")
			{
				use_this = #TRUE;
			}
		}
	}

	KickPlayer(-4, self);

	if (!use_this)
	{
		// aim, 'cause no entity in sights
		dir = aim (self, 10000);	// this corrects the aiming slightly, for bad players
	    traceline (src, src + dir*3072, #FALSE, self);
	}

	deathmsg = #DMSG_SNIPERRIFLE;
	dam_mult = 1;
	if (trace_ent)
	{
		if (trace_ent.classname == "player")
		{
			local float x;
			local vector f, g, h;

			f = trace_endpos - src;

			g_x = trace_endpos_x;
			g_y = trace_endpos_y;
			g_z = 0;

			h_x = trace_ent.origin_x;
			h_y = trace_ent.origin_y;
			h_z = 0;

			x = vlen(g - h);

			f = (normalize(f) * x) + trace_endpos;

			zdif = f_z - trace_ent.origin_z;
  			deathmsg = #DMSG_SNIPERRIFLE;

			trace_ent.head_shot_vector = '0 0 0';
			if (zdif < 0)
			{
				// leg shot
				dam_mult = 0.5;

				trace_ent.leg_damage = trace_ent.leg_damage + 1;
				TeamFortress_SetSpeed(trace_ent); 
				deathmsg = #DMSG_SNIPERLEGSHOT;
				T_Damage(trace_ent, self, self, self.heat * dam_mult);

				if (trace_ent.health > 0)
				{
					sprint(trace_ent, #PRINT_LOW, "Leg injury!\n");
					sprint(self, #PRINT_MEDIUM, "Leg shot - that'll slow him down!\n");
				}

				return;
			}
			else if (zdif > 20)
			{
				// head shot
				dam_mult = 2;
				stuffcmd(trace_ent, "bf\n");

				trace_ent.head_shot_vector = trace_ent.origin - self.origin;
				deathmsg = #DMSG_SNIPERHEADSHOT;
//				T_Damage(trace_ent, self, self, self.heat * dam_mult, 1);
				T_Damage(trace_ent, self, self, self.heat * dam_mult);

				if (trace_ent.health > 0)
				{
					sprint(trace_ent, #PRINT_LOW, "Head injury!\n");
					sprint(self, #PRINT_MEDIUM, "Head shot - that's gotta hurt!\n");
				}

				return;
			}
			else
				deathmsg = #DMSG_SNIPERRIFLE;

		}
	}

	ClearMultiDamage ();

	if (trace_fraction != 1.0)	// if it hit something
   		TraceAttack (self.heat * dam_mult, dir);

	ApplyMultiDamage ();

};

/*
===================================
TeamFortress : W_FireAutoRifle
===================================
*/
void() W_FireAutoRifle =
{
	local vector dir;

	sound (self ,#CHAN_WEAPON, "weapons/sniper.wav", 1, #ATTN_NORM);

	KickPlayer(-1, self);

	self.currentammo = self.ammo_shells = self.ammo_shells - 1;
	makevectors(self.v_angle);
	dir = v_forward;
	deathmsg = #DMSG_AUTORIFLE;
	FireSniperBullet (dir, 8);
};

/*
================
TeamFortress : W_FireAssaultCannon
================
*/
void() W_FireAssaultCannon =
{
	local vector dir;

	KickPlayer(-4, self);
	
	self.currentammo = self.ammo_shells = self.ammo_shells - 1;
	dir = aim (self, 100000);
	deathmsg = #DMSG_ASSAULTCANNON;
	FireBullets (5, dir, '0.04 0.04 0');
};

/*
==============================================================================

ROCKETS

==============================================================================
*/

void()	s_explode1	=	[0,		s_explode2] {};
void()	s_explode2	=	[1,		s_explode3] {};
void()	s_explode3	=	[2,		s_explode4] {};
void()	s_explode4	=	[3,		s_explode5] {};
void()	s_explode5	=	[4,		s_explode6] {};
void()	s_explode6	=	[5,		SUB_Remove] {};

void() BecomeExplosion =
{
#ifndef QUAKE_WORLD
	self.movetype = #MOVETYPE_NONE;
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = #SOLID_NOT;
	s_explode1 ();
#else
	dremove(self);
#endif
};

void() T_MissileTouch =
{
	local float	damg;

	if (pointcontents(self.origin) == #CONTENT_SKY)
	{
		dremove(self);
		return;
	}

	// Lowered from 120
	damg = 92 + random()*20;
	
	deathmsg = self.weapon;
	if (other.health)
	{
	/*
		if (other.classname == "monster_shambler")
			damg = damg * 0.5;	// mostly immune
	*/
		TF_T_Damage (other, self, self.owner, damg, 0, #TF_TD_EXPLOSION);
	}

	// don't do radius damage to the other, because all the damage
	// was done in the impact
	// Lowered from 120
	T_RadiusDamage (self, self.owner, 92, other);

	self.origin = self.origin - 8*normalize(self.velocity);

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



/*
================
W_FireRocket
================
*/
void() W_FireRocket =
{
	self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
	sound (self, #CHAN_WEAPON, "weapons/sgun1.wav", 1, #ATTN_NORM);
	KickPlayer(-2, self);
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = #MOVETYPE_FLYMISSILE;
	newmis.solid = #SOLID_BBOX;
		
	// set newmis speed	
	makevectors (self.v_angle);
	newmis.velocity = v_forward;
	newmis.velocity = newmis.velocity * 900;
	newmis.angles = vectoangles(newmis.velocity);

	newmis.touch = T_MissileTouch;

	// set newmis duration
	newmis.nextthink = time + 5;
	newmis.think = SUB_Remove;

	newmis.weapon = #DMSG_ROCKETL;
	setmodel (newmis, "progs/missile.mdl");
	setsize (newmis, '0 0 0', '0 0 0');		
	setorigin (newmis, self.origin + v_forward*8 + '0 0 16');

#ifdef DEMO_STUFF
	// Have we got a live camera in projectile mode?
	if (live_camera)
		CamProjectileLockOn();
#endif
};

/*
===============================================================================

LIGHTNING

===============================================================================
*/

#ifdef QUAKE_WORLD
void(entity from, float damage) LightningHit =
{
	WriteByte (#MSG_MULTICAST, #SVC_TEMPENTITY);
	WriteByte (#MSG_MULTICAST, #TE_LIGHTNINGBLOOD);
	WriteCoord (#MSG_MULTICAST, trace_endpos_x);
	WriteCoord (#MSG_MULTICAST, trace_endpos_y);
	WriteCoord (#MSG_MULTICAST, trace_endpos_z);
	multicast (trace_endpos, #MULTICAST_PVS);

	TF_T_Damage (trace_ent, from, from, damage, #TF_TD_NOTTEAM, #TF_TD_ELECTRICITY);
};
#endif

/*
=================
LightningDamage
=================
*/
void(vector p1, vector p2, entity from, float damage) LightningDamage =
{
	local entity		e1, e2;
	local vector		f;
	
	f = p2 - p1;
	normalize (f);
	f_x = 0 - f_y;
	f_y = f_x;
	f_z = 0;
	f = f*16;

	e1 = e2 = world;

	traceline (p1, p2, #FALSE, self);
	if (trace_ent.takedamage)
	{
		#ifdef QUAKE_WORLD
			LightningHit (from, damage);
		#else
			particle (trace_endpos, '0 0 100', 225, damage*4);
			TF_T_Damage (trace_ent, from, from, damage, #TF_TD_NOTTEAM, #TF_TD_ELECTRICITY);
		#endif
		if (self.classname == "player")
		{
			if (other.classname == "player")
				trace_ent.velocity_z = trace_ent.velocity_z + 400;
		}
	}
	e1 = trace_ent;

	traceline (p1 + f, p2 + f, #FALSE, self);
	if (trace_ent != e1 && trace_ent.takedamage)
	{
	#ifdef QUAKE_WORLD
		LightningHit (from, damage);
	#else
		particle (trace_endpos, '0 0 100', 225, damage*4);
		TF_T_Damage (trace_ent, from, from, damage, #TF_TD_NOTTEAM, #TF_TD_ELECTRICITY);
	#endif
	}
	e2 = trace_ent;

	traceline (p1 - f, p2 - f, #FALSE, self);
	if (trace_ent != e1 && trace_ent != e2 && trace_ent.takedamage)
	{
	#ifdef QUAKE_WORLD
		LightningHit (from, damage);
	#else
		particle (trace_endpos, '0 0 100', 225, damage*4);
		TF_T_Damage (trace_ent, from, from, damage, #TF_TD_NOTTEAM, #TF_TD_ELECTRICITY);
	#endif
	}
};


void() W_FireLightning =
{
	local	vector		org;
	local 	float		cells;

	if (self.ammo_cells < 1)
	{
		self.current_weapon = W_BestWeapon ();
		W_SetCurrentAmmo ();
		W_PrintWeaponMessage();
		return;
	}

// explode if under water
	if (self.waterlevel > 1)
	{
		cells = self.ammo_cells;
		self.ammo_cells = 0;
		W_SetCurrentAmmo ();
		deathmsg = #DMSG_LIGHTNING;
		T_RadiusDamage (self, self, 35*cells, world);
		return;
	}

	if (self.t_width < time)
	{
		sound (self, #CHAN_WEAPON, "weapons/lhit.wav", 1, #ATTN_NORM);
		self.t_width = time + 0.6;
	}

	KickPlayer(-2, self);

	self.currentammo = self.ammo_cells = self.ammo_cells - 1;

	org = self.origin + '0 0 16';
	
	traceline (org, org + v_forward*600, #TRUE, self);

	WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
	WriteByte (#MSG_BROADCAST, #TE_LIGHTNING2);
	WriteEntity (#MSG_BROADCAST, self);
	WriteCoord (#MSG_BROADCAST, org_x);
	WriteCoord (#MSG_BROADCAST, org_y);
	WriteCoord (#MSG_BROADCAST, org_z);
	WriteCoord (#MSG_BROADCAST, trace_endpos_x);
	WriteCoord (#MSG_BROADCAST, trace_endpos_y);
	WriteCoord (#MSG_BROADCAST, trace_endpos_z);
#ifdef QUAKE_WORLD
	multicast (org, #MULTICAST_PHS);
#endif

	LightningDamage (self.origin, trace_endpos + v_forward*4, self, 30);
};

//=============================================================================

float (float tno) num_team_pipebombs =
{
	if (tno == 1)
		return num_team_pipebombs_1;
	else if (tno == 2)
		return num_team_pipebombs_2;
	else if (tno == 3)
		return num_team_pipebombs_3;
	else if (tno == 4)
		return num_team_pipebombs_4;

	return 0;
};

void(float tno) ExplodeOldPipebomb =
{
	local entity old;
	local float index;

	if (tno != 0)
	{
		index = num_team_pipebombs(tno);
		index = index - (#MAX_WORLD_PIPEBOMBS / number_of_teams);
	}
	else
	{
		index = num_world_pipebombs - #MAX_WORLD_PIPEBOMBS;
	}

	old = find(world, classname, "pipebomb");
	while (index > 0)
	{
		if (old == world)
		{
			dprint("*** ERROR: ExplodeOldPipebomb. ***\n");
			dprint("*** Please report this.        ***\n");
			num_world_pipebombs = 0;
			num_team_pipebombs_1 = 0;
			num_team_pipebombs_2 = 0;
			num_team_pipebombs_3 = 0;
			num_team_pipebombs_4 = 0;
			return;
		}

		if (old.owner.team_no == tno || tno == 0)
		{
			old.nextthink = time + 0.5;
			index = index - 1;
		}

		old = find(old, classname, "pipebomb");
	}
};

void(float tno) increment_team_pipebombs =
{
	if (tno == 1)
		num_team_pipebombs_1 = num_team_pipebombs_1 + 1;
	else if (tno == 2)
		num_team_pipebombs_2 = num_team_pipebombs_2 + 1;
	else if (tno == 3)
		num_team_pipebombs_3 = num_team_pipebombs_3 + 1;
	else if (tno == 4)
		num_team_pipebombs_4 = num_team_pipebombs_4 + 1;
};

void(float tno) decrement_team_pipebombs =
{
	if (tno == 1)
		num_team_pipebombs_1 = num_team_pipebombs_1 - 1;
	else if (tno == 2)
		num_team_pipebombs_2 = num_team_pipebombs_2 - 1;
	else if (tno == 3)
		num_team_pipebombs_3 = num_team_pipebombs_3 - 1;
	else if (tno == 4)
		num_team_pipebombs_4 = num_team_pipebombs_4 - 1;
};

//=============================================================================


void() GrenadeExplode =
{
	if (self.classname == "pipebomb")
	{
		num_world_pipebombs = num_world_pipebombs - 1;
		decrement_team_pipebombs(self.owner.team_no);
	}

	deathmsg = self.weapon;
	T_RadiusDamage (self, self.owner, 120, world);

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

void() GrenadeTouch =
{
	if (other == self.owner)
		return;		// don't explode on owner
	if (other.takedamage == #DAMAGE_AIM)
	{
		GrenadeExplode();
		return;
	}
	sound (self, #CHAN_WEAPON, "weapons/bounce.wav", 1, #ATTN_NORM);	// bounce sound
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
	self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
	sound (self, #CHAN_WEAPON, "weapons/grenade.wav", 1, #ATTN_NORM);
	KickPlayer(-2, self);
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = #MOVETYPE_BOUNCE;
	newmis.solid = #SOLID_BBOX;

	// Set grenade type based on firing mode
	if (self.weaponmode == #GL_NORMAL)
	{
		newmis.weapon = #DMSG_GRENADEL;
		newmis.classname = "grenade";
		newmis.skin = 1;
		newmis.touch = GrenadeTouch;
		newmis.nextthink = time + 2.5;
	}
	else // if (self.weaponmode == #GL_PIPEBOMB)
	{
		if (self.team_no != 0)
		{
			increment_team_pipebombs(self.team_no);
			if (num_team_pipebombs(self.team_no) > (#MAX_WORLD_PIPEBOMBS / number_of_teams))
				ExplodeOldPipebomb(self.team_no);
		}
		else 
		{
			num_world_pipebombs = num_world_pipebombs + 1;
			if (num_world_pipebombs > #MAX_WORLD_PIPEBOMBS)
				ExplodeOldPipebomb(0);
		}

		newmis.classname = "pipebomb";
		newmis.skin = 2;
		newmis.touch = PipebombTouch;
		newmis.nextthink = time + 120;		// Remove pipebombs older than 2 minutes
		newmis.weapon = #DMSG_GREN_PIPE;
	}
		
	// set newmis speed	
	makevectors (self.v_angle);
	if (self.v_angle_x)
		newmis.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
	else
	{
		newmis.velocity = aim(self, 10000);
		newmis.velocity = newmis.velocity * 600;
		newmis.velocity_z = 200;
	}
	newmis.avelocity = '300 300 300';
	newmis.angles = vectoangles(newmis.velocity);

	newmis.think = GrenadeExplode;
	setmodel (newmis, "progs/grenade2.mdl");
	setsize (newmis, '0 0 0', '0 0 0');		
	setorigin (newmis, self.origin);

#ifdef DEMO_STUFF
	// Have we got a live camera in projectile mode?
	if (live_camera)
		CamProjectileLockOn();
#endif
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
	newmis.movetype = #MOVETYPE_FLYMISSILE;
	newmis.solid = #SOLID_BBOX;

	newmis.angles = vectoangles(dir);

	newmis.touch = spike_touch;
	newmis.weapon = #DMSG_NAILGUN;
	newmis.classname = "spike";
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;
	setmodel (newmis, "progs/spike.mdl");
	setsize (newmis, #VEC_ORIGIN, #VEC_ORIGIN);		
	setorigin (newmis, org);

	newmis.velocity = dir * 1000;

#ifdef DEMO_STUFF
	// Have we got a live camera in projectile mode?
	if (live_camera)
		CamProjectileLockOn();
#endif
};

void() W_FireSuperSpikes =
{
	local vector	dir;
	local entity	old;
	
	sound (self, #CHAN_WEAPON, "weapons/spike2.wav", 1, #ATTN_NORM);
	Attack_Finished(0.2);
	self.currentammo = self.ammo_nails = self.ammo_nails - 2;
	dir = aim (self, 1000);
	launch_spike (self.origin + '0 0 16', dir);
	newmis.touch = superspike_touch;
	newmis.weapon = #DMSG_SNAILGUN;
	setmodel (newmis, "progs/s_spike.mdl");
	setsize (newmis, #VEC_ORIGIN, #VEC_ORIGIN);		

	KickPlayer(-2, self);
};

void(float ox) W_FireSpikes =
{
	local vector	dir;
	local entity	old;
	
	makevectors (self.v_angle);
	
	if (self.ammo_nails >= 2 && self.current_weapon == #WEAP_SUPER_NAILGUN)
	{
		W_FireSuperSpikes ();
		return;
	}

	if (self.ammo_nails < 1)
	{
		self.current_weapon = W_BestWeapon ();
		W_SetCurrentAmmo ();
		W_PrintWeaponMessage();
		return;
	}

	sound (self, #CHAN_WEAPON, "weapons/rocket1i.wav", 1, #ATTN_NORM);
	Attack_Finished(0.2);
	self.currentammo = self.ammo_nails = self.ammo_nails - 1;
	dir = aim (self, 1000);
	launch_spike (self.origin + '0 0 16' + v_right*ox, dir);

	KickPlayer(-2, self);
};



.float hit_z;
void() spike_touch =
{
	if (other.solid == #SOLID_TRIGGER)
		return;	// trigger field, do nothing

	if (pointcontents(self.origin) == #CONTENT_SKY)
	{
		dremove(self);
		return;
	}
	
	// hit something that bleeds
	if (other.takedamage)
	{
		spawn_touchblood (9);
		deathmsg = self.weapon;

		if (self.owner.classname == "grenade")
			TF_T_Damage (other, self, self.owner.owner, 9, #TF_TD_NOTTEAM, #TF_TD_NAIL);
		else 
			TF_T_Damage (other, self, self.owner, 9, #TF_TD_NOTTEAM, #TF_TD_NAIL);
	}
	else
	{
		WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
		
		if (self.classname == "wizspike")
			WriteByte (#MSG_BROADCAST, #TE_WIZSPIKE);
		else if (self.classname == "knightspike")
			WriteByte (#MSG_BROADCAST, #TE_KNIGHTSPIKE);
		else
			WriteByte (#MSG_BROADCAST, #TE_SPIKE);
		WriteCoord (#MSG_BROADCAST, self.origin_x);
		WriteCoord (#MSG_BROADCAST, self.origin_y);
		WriteCoord (#MSG_BROADCAST, self.origin_z);
	#ifdef QUAKE_WORLD
		multicast (self.origin, #MULTICAST_PHS);
	#endif
	}

#ifdef DEMO_STUFF
	// Remove any camera's locks on this missile
	if (self.enemy)
		CamProjectileLockOff();
#endif

	dremove(self);
};

void() superspike_touch =
{
	local float ndmg;

	if (other == self.owner)
		return;

	if (other.solid == #SOLID_TRIGGER)
		return;	// trigger field, do nothing

	if (pointcontents(self.origin) == #CONTENT_SKY)
	{
		dremove(self);
		return;
	}
	
// hit something that bleeds
	if (other.takedamage)
	{
		spawn_touchblood (18);
		deathmsg = self.weapon;

#ifdef QUAKE_WORLD
		// In QW, nail grens only launch 1 nail, and it does more damage.
		if (deathmsg == #DMSG_GREN_NAIL)
			ndmg = 40;
		else
#endif
		ndmg = 13;

		if (self.owner.classname == "grenade")
			TF_T_Damage (other, self, self.owner.owner, ndmg, #TF_TD_NOTTEAM, #TF_TD_NAIL);
		else
			TF_T_Damage (other, self, self.owner, ndmg, #TF_TD_NOTTEAM, #TF_TD_NAIL);
	}
	else
	{
		WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
		WriteByte (#MSG_BROADCAST, #TE_SUPERSPIKE);
		WriteCoord (#MSG_BROADCAST, self.origin_x);
		WriteCoord (#MSG_BROADCAST, self.origin_y);
		WriteCoord (#MSG_BROADCAST, self.origin_z);
	#ifdef QUAKE_WORLD
		multicast (self.origin, #MULTICAST_PHS);
	#endif						
	}

#ifdef DEMO_STUFF
	// Remove any camera's locks on this missile
	if (self.enemy)
		CamProjectileLockOff();
#endif

	dremove(self);
};

/*
===============================================================================

PLAYER WEAPON USE

===============================================================================
*/

void() W_SetCurrentAmmo =
{

	local string st;

	if (self.health <= 0 || self.current_weapon == 0)
		return;		// get out of any weapon firing states

	player_run();

	self.items = self.items - ( self.items & (#IT_SHELLS | #IT_NAILS | #IT_ROCKETS | #IT_CELLS) );
	self.weapon = 0;

	if (self.current_weapon == #WEAP_AXE)
	{
		self.currentammo = 0;

		if (self.playerclass == #PC_SPY)
		{
			if (self.weaponmode == 0)
				self.weaponmodel = "progs/v_knife.mdl";
			else
				self.weaponmodel = "progs/v_knife2.mdl";
		}
		else
			self.weaponmodel = "progs/v_axe.mdl";

		self.weaponframe = 0;
	}
	else if (self.current_weapon == #WEAP_HOOK)
	{
		self.currentammo = 0;
		self.weaponmodel = "progs/v_grap.mdl";
		self.weaponframe = 0;
	}
	else if (self.current_weapon == #WEAP_SPANNER)
	{
		self.currentammo = self.ammo_cells;
		self.weaponmodel = "progs/v_span.mdl";
		self.weaponframe = 0;
	}
	else if (self.current_weapon == #WEAP_SHOTGUN)
	{
		self.currentammo = self.ammo_shells;
		self.items = self.items | #IT_CELLS;
		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
			self.weaponmodel = "progs/v_shot.mdl";
			self.weaponframe = 0;
		}
		self.items = self.items | #IT_SHELLS;
		self.weapon = #IT_SHOTGUN;
	}
	else if (self.current_weapon == #WEAP_SUPER_SHOTGUN)
	{
		self.currentammo = self.ammo_shells;
		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
			self.weaponmodel = "progs/v_shot2.mdl";
			self.weaponframe = 0;
		}
		self.items = self.items | #IT_SHELLS;
		self.weapon = #IT_SUPER_SHOTGUN;
	}
	else if (self.current_weapon == #WEAP_NAILGUN)
	{
		self.currentammo = self.ammo_nails;
		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
			self.weaponmodel = "progs/v_nail.mdl";
			self.weaponframe = 0;
		}

		self.items = self.items | #IT_NAILS;
		self.weapon = #IT_NAILGUN;
	}
	else if (self.current_weapon == #WEAP_SUPER_NAILGUN)
	{
		self.currentammo = self.ammo_nails;
		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
			self.weaponmodel = "progs/v_nail2.mdl";
			self.weaponframe = 0;
		}
		self.items = self.items | #IT_NAILS;
		self.weapon = #IT_SUPER_NAILGUN;
	}
	else if (self.current_weapon == #WEAP_GRENADE_LAUNCHER)
	{
		self.currentammo = self.ammo_rockets;
		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
			self.weaponmodel = "progs/v_rock.mdl";
			self.weaponframe = 0;
		}

		self.weapon = #IT_GRENADE_LAUNCHER;
		self.items = self.items | #IT_ROCKETS;
	}
	else if (self.current_weapon == #WEAP_ROCKET_LAUNCHER)
	{
		self.currentammo = self.ammo_rockets;
		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
			self.weaponmodel = "progs/v_rock2.mdl";
			self.weaponframe = 0;
		}
		self.items = self.items | #IT_ROCKETS;
		self.weapon = #IT_ROCKET_LAUNCHER;
	}
	else if (self.current_weapon == #WEAP_LIGHTNING)
	{
		self.currentammo = self.ammo_cells;
		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
			self.weaponmodel = "progs/v_light.mdl";
			self.weaponframe = 0;
		}
		self.items = self.items | #IT_CELLS;
		self.weapon = #IT_LIGHTNING;
	}
	else if (self.current_weapon == #WEAP_SNIPER_RIFLE)
  	{
    	self.currentammo = self.ammo_shells;
		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
	    	self.weaponmodel = "progs/v_srifle.mdl";

         	self.weaponframe = 0;
		}
		self.items = self.items | #IT_SHELLS;
		self.weapon = #IT_SHOTGUN;
    }
	else if (self.current_weapon == #WEAP_AUTO_RIFLE)
 	{
  		self.currentammo = self.ammo_shells;
		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
	    	self.weaponmodel = "progs/v_srifle.mdl";
	    	self.weaponframe = 0;
		}
		self.items = self.items | #IT_SHELLS;
		self.weapon = #IT_SUPER_SHOTGUN;
	}
	else if (self.current_weapon == #WEAP_ASSAULT_CANNON)
 	{
  		self.currentammo = self.ammo_shells;
		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
			self.weaponmodel = "progs/v_asscan.mdl";
	    	self.weaponframe = 0;
		}
		self.items = self.items | #IT_SHELLS;
		self.weapon = #IT_ROCKET_LAUNCHER;
	}
	else if (self.current_weapon == #WEAP_FLAMETHROWER)
 	{
  		self.currentammo = self.ammo_cells;
		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
	    	self.weaponmodel = "progs/v_rock.mdl";
	    	self.weaponframe = 0;
		}
		self.items = self.items | #IT_CELLS;
		self.weapon = #IT_GRENADE_LAUNCHER;
	}
	else if (self.current_weapon == #WEAP_INCENDIARY)
 	{
  		self.currentammo = self.ammo_rockets;
		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
	    	self.weaponmodel = "progs/v_rock2.mdl";
	    	self.weaponframe = 0;
		}
		self.items = self.items | #IT_ROCKETS;
		self.weapon = #IT_ROCKET_LAUNCHER;
	}
	else if (self.current_weapon == #WEAP_MEDIKIT)
	{
		self.currentammo = 0;
		self.weaponmodel = "progs/v_medi.mdl";
		self.weaponframe = 0;
   	}
	else if (self.current_weapon == #WEAP_BIOWEAPON)
	{
		self.currentammo = 0;
		self.weaponmodel = "progs/v_bio.mdl";
		self.weaponframe = 0;
	}
	else if (self.current_weapon == #WEAP_TRANQ)
	{
		self.currentammo = self.ammo_shells;
		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
			self.weaponmodel = "progs/v_shot.mdl";
			self.weaponframe = 0;
		}
		self.items = self.items | #IT_SHELLS;
		self.weapon = #IT_SHOTGUN;
	}
	else if (self.current_weapon == #WEAP_LASER)
	{
		self.currentammo = self.ammo_nails;

		if (!(self.tfstate & #TFSTATE_RELOADING))
		{
			self.weaponmodel = "progs/v_rail.mdl";
			self.weaponframe = 0;
		}

		self.items = self.items | #IT_NAILS;
		self.weapon = #IT_SHOTGUN;
	}
	else
	{
		self.currentammo = 0;
		self.weaponmodel = "";
		self.weaponframe = 0;
	}
};

float() W_BestWeapon =
{
	local	float	it;
	
	it = self.weapons_carried;

	if (self.ammo_cells >= 1 && (it & #WEAP_LIGHTNING) && self.waterlevel <= 1)
		return #WEAP_LIGHTNING;
	else if (self.ammo_cells >= 6 && (self.ammo_shells >= 1) && (it  & #WEAP_ASSAULT_CANNON))
		return #WEAP_ASSAULT_CANNON;
	else if (self.ammo_cells >= 1 && (it & #WEAP_FLAMETHROWER))
		return #WEAP_FLAMETHROWER;
	else if(self.ammo_nails >= 2 && (it & #WEAP_SUPER_NAILGUN) )
		return #WEAP_SUPER_NAILGUN;
	else if(self.ammo_shells >= 2 && (it & #WEAP_SUPER_SHOTGUN) )
		return #WEAP_SUPER_SHOTGUN;
	else if (self.ammo_nails >= 1 && (it & #WEAP_LASER) )
		return #WEAP_LASER;
	else if(self.ammo_nails >= 1 && (it & #WEAP_NAILGUN) )
		return #WEAP_NAILGUN;
	else if(self.ammo_shells >= 1 && (it & #WEAP_SHOTGUN) )
		return #WEAP_SHOTGUN;
	else if (self.ammo_shells >= 1 && (it & #WEAP_TRANQ) )
		return #WEAP_TRANQ;

	else if (it & #WEAP_MEDIKIT)
		return #WEAP_MEDIKIT;
	else if (it & #WEAP_SPANNER)
		return #WEAP_SPANNER;
	else if (it & #WEAP_AXE)
		return #WEAP_AXE;

	return 0;
};

float() W_CheckNoAmmo =
{
	if (self.current_weapon == #WEAP_MEDIKIT)
		return #TRUE;
	else if (self.current_weapon == #WEAP_BIOWEAPON)
		return #TRUE;
	else if (self.current_weapon == #WEAP_AXE || self.current_weapon == #WEAP_HOOK || self.current_weapon == #WEAP_SPANNER)
		return #TRUE;
	else if (self.current_weapon == #WEAP_INCENDIARY)
	{
		if (self.currentammo >= 3)
			return #TRUE;
	}
	else if (self.currentammo > 0)
		return #TRUE;

	self.current_weapon = W_BestWeapon ();
	W_SetCurrentAmmo ();
	W_PrintWeaponMessage();
	
// drop the weapon down
	return #FALSE;
};

/*====================
W_Reload
Is called when weapon has finished reloading
====================*/
void() W_Reload_shotgun =
{
	self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & #TFSTATE_RELOADING);
    self.owner.weaponmodel = "progs/v_shot.mdl";
    sprint(self.owner, #PRINT_LOW, "finished reloading\n");

    dremove(self);

	self.owner.StatusRefreshTime = time + 0.1;
};

void() W_Reload_super_shotgun =
{
	self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & #TFSTATE_RELOADING);
    self.owner.weaponmodel = "progs/v_shot2.mdl";
    sprint(self.owner, #PRINT_LOW, "finished reloading\n");
    dremove(self);

	self.owner.StatusRefreshTime = time + 0.1;
};

void() W_Reload_grenade_launcher =
{
	self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & #TFSTATE_RELOADING);
    self.owner.weaponmodel = "progs/v_rock.mdl";
    sprint(self.owner, #PRINT_LOW, "finished reloading\n");
    dremove(self);

	self.owner.StatusRefreshTime = time + 0.1;
};

void() W_Reload_rocket_launcher =
{
	self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & #TFSTATE_RELOADING);
    self.owner.weaponmodel = "progs/v_rock2.mdl";
    sprint(self.owner, #PRINT_LOW, "finished reloading\n");
    dremove(self);

	self.owner.StatusRefreshTime = time + 0.1;
};

float() CheckForReload =
{
	local entity tWeapon;

	if (self.current_weapon == #WEAP_SHOTGUN)
	{
        if (self.reload_shotgun >= #RE_SHOTGUN && self.ammo_shells > 0)
        {
			self.reload_shotgun = 0;
			if (self.ammo_shells < #RE_SHOTGUN)
				self.reload_shotgun = #RE_SHOTGUN - self.ammo_shells;

			sprint (self, #PRINT_HIGH, "reloading...\n");
			self.tfstate = (self.tfstate | #TFSTATE_RELOADING);
			tWeapon = spawn();
			tWeapon.owner = self;
			tWeapon.classname = "timer";
			tWeapon.nextthink = time + #RE_SHOTGUN_TIME;
			tWeapon.think = W_Reload_shotgun;

			self.weaponmodel = "";
			self.weaponframe = 0;

			return #TRUE;
        }
	}
	else if (self.current_weapon == #WEAP_SUPER_SHOTGUN)
	{
		if (self.reload_super_shotgun > #RE_SUPER_SHOTGUN)
			self.reload_super_shotgun = #RE_SUPER_SHOTGUN;
        if (self.reload_super_shotgun >= #RE_SUPER_SHOTGUN && self.ammo_shells > 0)
        {
            self.reload_super_shotgun = 0;
			if (self.ammo_shells < #RE_SUPER_SHOTGUN)
				self.reload_super_shotgun = #RE_SUPER_SHOTGUN - self.ammo_shells;

	      	sprint (self, #PRINT_HIGH, "reloading...\n");
            self.tfstate = (self.tfstate | #TFSTATE_RELOADING);
	        tWeapon = spawn();
    	    tWeapon.owner = self;
 		    tWeapon.classname = "timer";
        	tWeapon.nextthink = time + #RE_SUPER_SHOTGUN_TIME;
         	tWeapon.think = W_Reload_super_shotgun;

         	self.weaponmodel = "";
         	self.weaponframe = 0;

			return #TRUE;
	  	}
	}
	else if (self.current_weapon == #WEAP_GRENADE_LAUNCHER)
	{
        if (self.reload_grenade_launcher >= #RE_GRENADE_LAUNCHER && self.ammo_rockets > 0)
        {
    	  	self.reload_grenade_launcher = 0;
			if (self.ammo_rockets < #RE_GRENADE_LAUNCHER)
				self.reload_grenade_launcher = #RE_GRENADE_LAUNCHER - self.ammo_rockets;

      	  	sprint (self, #PRINT_HIGH, "reloading...\n");
			self.tfstate = (self.tfstate | #TFSTATE_RELOADING);
          	tWeapon = spawn();
          	tWeapon.owner = self;
 		    tWeapon.classname = "timer";
          	tWeapon.nextthink = time + #RE_GRENADE_LAUNCHER_TIME;
         	tWeapon.think = W_Reload_grenade_launcher;

         	self.weaponmodel = "";
         	self.weaponframe = 0;

			return #TRUE;
      	}
	}
	else if (self.current_weapon == #WEAP_ROCKET_LAUNCHER)
	{
 	    if (self.reload_rocket_launcher >= #RE_ROCKET_LAUNCHER && self.ammo_rockets > 0)
      	{
        	self.reload_rocket_launcher = 0;
			if (self.ammo_rockets < #RE_ROCKET_LAUNCHER)
				self.reload_rocket_launcher = #RE_ROCKET_LAUNCHER - self.ammo_rockets;

      		sprint (self, #PRINT_HIGH, "reloading...\n");
			self.tfstate = (self.tfstate | #TFSTATE_RELOADING);
         	tWeapon = spawn();
         	tWeapon.owner = self;
 		    tWeapon.classname = "timer";
         	tWeapon.nextthink = time + #RE_ROCKET_LAUNCHER_TIME;
         	tWeapon.think = W_Reload_rocket_launcher;

         	self.weaponmodel = "";
         	self.weaponframe = 0;

			return #TRUE;
      	}
	}

	return #FALSE;
};

/*
============
W_Attack

An attack impulse can be triggered now
============
*/
void()	player_axe1;
void()	player_axeb1;
void()	player_axec1;
void()	player_axed1;
void()	player_shot1;
void()	player_nail1;
void()	player_light1;
void()	player_rocket1;

void()	player_autorifle1;
void()  player_assaultcannon1;
void()  player_assaultcannonup1;
void()  player_assaultcannondown1;
void()	player_medikit1;
void()	player_medikitb1;
void()	player_medikitc1;
void()	player_medikitd1;
void()	player_bioweapon1;
void()	player_bioweaponb1;
void()	player_bioweaponc1;
void()	player_bioweapond1;
void()  player_chain1;
void()  player_chain2;
void()  player_chain3;
void()  player_chain4;
void()  player_chain5;


void() W_Attack =
{
	local float	 r, tc;
	local entity tcool;
	local string st;

	if (!W_CheckNoAmmo ())
		return;

	if (self.tfstate & #TFSTATE_RELOADING)
		return;

	if (self.is_undercover)
		Spy_RemoveDisguise(self);

	makevectors	(self.v_angle);			// calculate forward angle for velocity
	self.show_hostile = time + 1;	// wake monsters up

	if (self.current_weapon == #WEAP_AXE)
	{
		Attack_Finished(0.5);
		sound (self, #CHAN_WEAPON, "weapons/ax1.wav", 1, #ATTN_NORM);
		r = random();
		if (r < 0.25)
			player_axe1 ();
		else if (r<0.5)
			player_axeb1 ();
		else if (r<0.75)
			player_axec1 ();
		else
			player_axed1 ();
	}
	else if (self.current_weapon == #WEAP_SPANNER)
	{
		Attack_Finished(0.5);
		sound (self, #CHAN_WEAPON, "weapons/ax1.wav", 1, #ATTN_NORM);
		player_axe1 ();
	}
	else if (self.current_weapon == #WEAP_HOOK)
	{
		if (!self.hook_out)
	    	player_chain1 ();

		Attack_Finished(0.1);
	}
	else if (self.current_weapon == #WEAP_SHOTGUN)
	{
		if (CheckForReload() == #TRUE)
			return;

		player_shot1 ();
		W_FireShotgun ();

   	    self.reload_shotgun = self.reload_shotgun + 1;
		self.StatusRefreshTime = time + 0.1;

		CheckForReload();
		Attack_Finished(0.5);
	}
	else if (self.current_weapon == #WEAP_SUPER_SHOTGUN)
	{
		if (CheckForReload() == #TRUE)
			return;

		player_shot1 ();
		W_FireSuperShotgun ();
 
       	self.reload_super_shotgun = self.reload_super_shotgun + 2;
			
		self.StatusRefreshTime = time + 0.1;

		CheckForReload();
		Attack_Finished(0.7);
	}
	else if (self.current_weapon == #WEAP_NAILGUN)
	{
		player_nail1 ();
	}
	else if (self.current_weapon == #WEAP_SUPER_NAILGUN)
	{
		player_nail1 ();
	}
	else if (self.current_weapon == #WEAP_GRENADE_LAUNCHER)
	{
		if (CheckForReload() == #TRUE)
			return;

		player_rocket1();
		W_FireGrenade();

       	self.reload_grenade_launcher = self.reload_grenade_launcher + 1;
		self.StatusRefreshTime = time + 0.1;

		CheckForReload();
		Attack_Finished(0.6);
	}
	else if (self.current_weapon == #WEAP_ROCKET_LAUNCHER)
	{
		if (CheckForReload() == #TRUE)
			return;

		player_rocket1();
		W_FireRocket();
    
       	self.reload_rocket_launcher = self.reload_rocket_launcher + 1;
		self.StatusRefreshTime = time + 0.1;

		CheckForReload();
        Attack_Finished(0.8);
	}
	else if (self.current_weapon == #WEAP_LIGHTNING)
	{
		player_light1();
		Attack_Finished(0.1);
		sound (self, #CHAN_AUTO, "weapons/lstart.wav", 1, #ATTN_NORM);
	}
	if (self.current_weapon == #WEAP_SNIPER_RIFLE)
    {
		// Can't fire while jumping
		if ((self.flags & #FL_ONGROUND) || (self.hook_out))
		{
	  		player_shot1();
	      	W_FireSniperRifle();
	     	Attack_Finished(#SNIPER_RIFLE_RELOAD_TIME);
		}
  	}
  	else if (self.current_weapon == #WEAP_AUTO_RIFLE)
  	{
		// player_sniper1 (); (TBD?)
  		player_autorifle1();
     	W_FireAutoRifle();
     	Attack_Finished(0.1);
  	}
  	else if (self.current_weapon == #WEAP_ASSAULT_CANNON)
  	{
		// Need 4 cells to power up the Assault Cannon
		if (self.ammo_cells < 4)
		{
			sprint (self, #PRINT_MEDIUM, "Insufficient cells to power up the Assault Cannon.\n");
		}
		else
		{
			self.ammo_cells = self.ammo_cells - 4;

			// Can't move while firing the Assault Cannon :)
			self.heat = 1;
			self.immune_to_check = time + 2;
			self.tfstate = self.tfstate | #TFSTATE_CANT_MOVE;
			TeamFortress_SetSpeed(self);
 			player_assaultcannonup1();
		}
  	}
	else if (self.current_weapon == #WEAP_FLAMETHROWER)
	{
    	player_shot1();
        W_FireFlame();
        if (self.waterlevel >2)
            Attack_Finished(1);
        else
        	Attack_Finished(0.15);
	}
	else if (self.current_weapon == #WEAP_INCENDIARY)
	{
		player_rocket1();
		W_FireIncendiaryCannon();
		Attack_Finished(1.2);
	}
	else if (self.current_weapon == #WEAP_MEDIKIT)
	{
		sound (self, #CHAN_WEAPON, "weapons/ax1.wav", 1, #ATTN_NORM);
		r = random();
		if (r < 0.25)
			player_medikit1 ();
		else if (r<0.5)
			player_medikitb1 ();
		else if (r<0.75)
			player_medikitc1 ();
		else
			player_medikitd1 ();
		Attack_Finished(0.5);

	}
	else if (self.current_weapon == #WEAP_BIOWEAPON)
	{
		sound (self, #CHAN_WEAPON, "weapons/ax1.wav", 1, #ATTN_NORM);
		r = random();
		if (r < 0.25)
			player_bioweapon1 ();
		else if (r<0.5)
			player_bioweaponb1 ();
		else if (r<0.75)
			player_bioweaponc1 ();
		else
			player_bioweapond1 ();
		Attack_Finished(0.5);
	}
	else if (self.current_weapon == #WEAP_TRANQ)
	{
		sound (self, #CHAN_WEAPON, "weapons/dartgun.wav", 1, #ATTN_NORM);
		player_shot1 ();
		W_FireTranq ();
     	Attack_Finished(1.5);
	}
	else if (self.current_weapon == #WEAP_LASER)
	{
		sound (self, #CHAN_WEAPON, "weapons/railgun.wav", 1, #ATTN_NORM);
		player_shot1();
		W_FireLaser();
		Attack_Finished(0.4);
	}
};

/*=========================
	W_PrintWeaponMessage

Prints a message indicating
the current selected weapon,
if needed.
=========================*/
void() W_PrintWeaponMessage =
{
	if (self.current_weapon == #WEAP_AXE && allow_hook)
	{
		if (self.playerclass != #PC_SPY)
			sprint(self, #PRINT_MEDIUM, "Axe selected\n");
	}
	else if (self.current_weapon == #WEAP_HOOK)
		sprint(self, #PRINT_MEDIUM, "grappling hook selected\n");
	else if (self.current_weapon == #WEAP_GRENADE_LAUNCHER)
	{
		if (self.weaponmode == #GL_NORMAL)
			sprint(self, #PRINT_MEDIUM, "Normal grenade mode\n");
		else if (self.weaponmode == #GL_PIPEBOMB)
			sprint(self, #PRINT_MEDIUM, "Pipebomb mode\n");
	}
	else if (self.current_weapon == #WEAP_SNIPER_RIFLE)
		sprint(self, #PRINT_MEDIUM, "Sniper rifle ready\n");
	else if (self.current_weapon == #WEAP_AUTO_RIFLE)
		sprint(self, #PRINT_MEDIUM, "rifle on fully auto\n");
	else if (self.current_weapon == #WEAP_TRANQ)
		sprint(self, #PRINT_MEDIUM, "Tranquiliser gun selected\n");
	else if (self.current_weapon == #WEAP_BIOWEAPON)
		sprint(self, #PRINT_MEDIUM, "BioWeapon readied\n");
	else if (self.current_weapon == #WEAP_MEDIKIT)
	#ifndef MEDIKIT_IS_BIOWEAPON
		sprint(self, #PRINT_MEDIUM, "Medikit readied\n");
	#else
		sprint(self, #PRINT_MEDIUM, "Medikit/Bioweapon readied\n");
	#endif
};


/*
============
W_ChangeWeapon

============
*/
void() W_ChangeWeapon =
{
	local	float	it, am, fl;
	local 	float 	have_weapon, usable;
	
    if (self.tfstate & #TFSTATE_RELOADING)
   		return;

	it = self.weapons_carried;
	fl = self.current_weapon;
	am = 0;
	usable = 0;
	have_weapon = #TRUE;

	if (self.impulse == 1)
	{
		if (!(it & (#WEAP_HOOK | #WEAP_BIOWEAPON | #WEAP_MEDIKIT | #WEAP_AXE | #WEAP_SPANNER)))
			have_weapon = #FALSE;			

		while (!usable && have_weapon)
		{
			if (fl == #WEAP_SPANNER)
			{
				fl = #WEAP_BIOWEAPON;
	
				if (it & #WEAP_BIOWEAPON)
					usable = 1;
							
				#ifdef MEDIKIT_IS_BIOWEAPON
					usable = 0;
				#endif

			}
			else if (fl == #WEAP_BIOWEAPON)
			{
				fl = #WEAP_MEDIKIT;

				if (it & #WEAP_MEDIKIT)
					usable = 1;
			}
			else if (fl == #WEAP_MEDIKIT)
			{
				fl = #WEAP_HOOK;

				if (allow_hook && (fl & #WEAP_HOOK))
					usable = 1;

                if (self.hook_out)
                	Reset_Grapple(self.hook);
			}
			else if (fl == #WEAP_HOOK)
			{
				fl = #WEAP_AXE;

				if (it & #WEAP_AXE)
					usable = 1;
			}
			else
			{
				fl = #WEAP_SPANNER;

				if (it & #WEAP_SPANNER)
					usable = 1;
			}
		}
	}
	else if (allow_hook && (self.impulse == #HOOK_IMP1 || self.impulse == #HOOK_IMP2)) 
	{
		fl = #WEAP_HOOK;		
	}
	else if (self.impulse == #AXE_IMP)
	{
		if (!(it & (#WEAP_BIOWEAPON | #WEAP_MEDIKIT | #WEAP_AXE | #WEAP_SPANNER)))
			have_weapon = #FALSE;			

		while (!usable && have_weapon)
		{
			if (fl == #WEAP_SPANNER)
			{
				fl = #WEAP_BIOWEAPON;

				if (it & #WEAP_BIOWEAPON)
					usable = 1;
							
				#ifdef MEDIKIT_IS_BIOWEAPON
					usable = 0;
				#endif

			}
			else if (fl == #WEAP_BIOWEAPON)
			{
	#ifdef MEDIKIT_IS_BIOWEAPON
				fl = #WEAP_MEDIKIT;

				if (it & #WEAP_MEDIKIT)
					usable = 1;
			}
			else if (fl == #WEAP_MEDIKIT)
			{
	#endif
				fl = #WEAP_AXE;

				if (it & #WEAP_AXE)
					usable = 1;
			}
			else
			{
				fl = #WEAP_SPANNER;

				if (it & #WEAP_SPANNER)
					usable = 1;
			}
		}
	}
	else if (self.impulse == 2)
	{
		if (it & #WEAP_SNIPER_RIFLE)
		{
			fl = #WEAP_SNIPER_RIFLE;
			if (self.ammo_shells < 1)
				am = 1;
		}
		else if (it & #WEAP_SHOTGUN)
		{
			fl = #WEAP_SHOTGUN;
			if (self.ammo_shells < 1)
				am = 1;
		}
		else if (it & #WEAP_TRANQ)
		{
			fl = #WEAP_TRANQ;
			if (self.ammo_shells < 1)
				am = 1;
		}
		else if (it & #WEAP_LASER)
		{
			fl = #WEAP_LASER;
			if (self.ammo_nails < 1)
				am = 1;
		}
		else
		{
			have_weapon = #FALSE;
		}
	}
	else if (self.impulse == 3)
	{
		if (it & #WEAP_AUTO_RIFLE)
		{
			fl = #WEAP_AUTO_RIFLE;
			if (self.ammo_shells < 1)
				am = 1;
		}
		else
		{
			fl = #WEAP_SUPER_SHOTGUN;
			if (self.ammo_shells < 2)
				am = 1;
		}
	}		
	else if (self.impulse == 4)
	{
		fl = #WEAP_NAILGUN;
		if (self.ammo_nails < 1)
			am = 1;
	}
	else if (self.impulse == 5)
	{
		fl = #WEAP_SUPER_NAILGUN;
		if (self.ammo_nails < 2)
			am = 1;
	}
	else if (self.impulse == 6)
	{
		if (it & #WEAP_FLAMETHROWER)
		{
			fl = #WEAP_FLAMETHROWER;

			if (self.ammo_cells < 1)
				am = 1;
		}
		else if (it & #WEAP_GRENADE_LAUNCHER)
		{
			fl = #WEAP_GRENADE_LAUNCHER;
	
			if (self.ammo_rockets < 1)
				am = 1;
			
			self.weaponmode = #GL_NORMAL;
		}
		else
		{
			have_weapon = #FALSE;
		}
	}
	else if (self.impulse == 7)
	{
		if (it & #WEAP_INCENDIARY)
		{
			fl = #WEAP_INCENDIARY;
			if (self.ammo_rockets < 3)
				am = 1;
		}
		else if (it & #WEAP_ROCKET_LAUNCHER)
		{
			fl = #WEAP_ROCKET_LAUNCHER;
			if (self.ammo_rockets < 1)
				am = 1;
		}
		else if (it & #WEAP_ASSAULT_CANNON)
		{
			fl = #WEAP_ASSAULT_CANNON;
			if (self.ammo_shells < 1)
				am = 1;
			else if (self.ammo_cells < 4)
				am = 2;
		}
		else if (it & #WEAP_GRENADE_LAUNCHER)
		{
			fl = #WEAP_GRENADE_LAUNCHER;
			self.weaponmode = #GL_PIPEBOMB;
			if (self.ammo_rockets < 1)
				am = 1;
		}
		else
		{
			have_weapon = #FALSE;
		}
	}
	else if (self.impulse == 8)
	{
		fl = #WEAP_LIGHTNING;
		if (self.ammo_cells < 1)
			am = 1;
	}
	else if (self.impulse == #TF_MEDIKIT)
	{
		fl = #WEAP_MEDIKIT;

		if (it & #WEAP_MEDIKIT)
			usable = 1;
	}

	self.impulse = 0;
	
	// don't have the weapon
	if (!have_weapon || (!(it & fl)))
	{	
		sprint (self, #PRINT_HIGH, "no weapon.\n");
		return;
	}
	
	// don't have the ammo
	if (am == 1)
	{	
		sprint(self, #PRINT_HIGH, "not enough ammo.\n");
		return;
	}

	// don't have the cells for the cannon
	if (am == 2)
	{
		sprint(self, #PRINT_HIGH, "not enough cells to power assault cannon.\n");
		return;
	}

	// set weapon, set ammo
	self.current_weapon = fl;
	W_SetCurrentAmmo ();
	W_PrintWeaponMessage();

	self.StatusRefreshTime = time + 0.1;
};

/*
============
CycleWeaponCommand

Go to the next weapon with ammo
============
*/
void() CycleWeaponCommand =
{
	local	float	it, am, cont, loopcount;
	
	// Some safety code
	if (self.weaponmodel == string_null || self.current_weapon == 0)
		return;

    if (self.tfstate & #TFSTATE_RELOADING)
  		return;

	it = self.weapons_carried;
	self.impulse = 0;
	loopcount = 0;
	
	while (1)
	{
		am = 0;
		cont = #FALSE;

		if (self.current_weapon == #WEAP_AXE)
		{
			self.current_weapon = #WEAP_SPANNER;
		}
		else if (self.current_weapon == #WEAP_SPANNER)
		{
			self.current_weapon = #WEAP_SHOTGUN;
			if (self.ammo_shells < 1)
				am = 1;
		}
		else if (self.current_weapon == #WEAP_SHOTGUN)
		{
			self.current_weapon = #WEAP_LASER;
			if (self.ammo_nails < 1)
				am = 1;
		}		
		else if (self.current_weapon == #WEAP_LASER)
		{
			self.current_weapon = #WEAP_TRANQ;
			if (self.ammo_shells < 1)
				am = 1;
		}		
		else if (self.current_weapon == #WEAP_TRANQ)
		{
			self.current_weapon = #WEAP_SNIPER_RIFLE;
			if (self.ammo_shells < 1)
				am = 1;
		}		
  		else if (self.current_weapon == #WEAP_SNIPER_RIFLE)
     	{
     		self.current_weapon = #WEAP_AUTO_RIFLE;
        	if (self.ammo_shells < 1)
        		am = 1;
     	}
     	else if (self.current_weapon == #WEAP_AUTO_RIFLE)
     	{
			self.current_weapon = #WEAP_SUPER_SHOTGUN;
			if (self.ammo_shells < 2)
				am = 1;
     	}
		else if (self.current_weapon == #WEAP_SUPER_SHOTGUN)
		{
			self.current_weapon = #WEAP_NAILGUN;
			if (self.ammo_nails < 1)
				am = 1;
		}
		else if (self.current_weapon == #WEAP_NAILGUN)
		{
			self.current_weapon = #WEAP_SUPER_NAILGUN;
			if (self.ammo_nails < 2)
				am = 1;
		}
		else if (self.current_weapon == #WEAP_SUPER_NAILGUN)
		{
			self.current_weapon = #WEAP_GRENADE_LAUNCHER;
			self.weaponmode = #GL_NORMAL;
			if (self.ammo_rockets < 1)
				am = 1;
		}
		else if (self.current_weapon == #WEAP_GRENADE_LAUNCHER && self.weaponmode == #GL_NORMAL)
		{
			self.current_weapon = #WEAP_GRENADE_LAUNCHER;
			self.weaponmode = #GL_PIPEBOMB;
			if (self.ammo_rockets < 1)
				am = 1;
		}
		else if (self.current_weapon == #WEAP_GRENADE_LAUNCHER && self.weaponmode == #GL_PIPEBOMB)
		{
			self.current_weapon = #WEAP_ROCKET_LAUNCHER;
			if (self.ammo_rockets < 1)
				am = 1;
		}
		else if (self.current_weapon == #WEAP_ROCKET_LAUNCHER)
		{
			self.current_weapon = #WEAP_LIGHTNING;
			if (self.ammo_cells < 1)
				am = 1;
		}
		else if (self.current_weapon == #WEAP_LIGHTNING)
	    {
         	self.current_weapon = #WEAP_FLAMETHROWER;
         	if (self.ammo_cells < 1)
         		am = 1;
      	}
		else if (self.current_weapon == #WEAP_FLAMETHROWER)
		{
			self.current_weapon = #WEAP_INCENDIARY;
			if (self.ammo_rockets < 3)
				am = 1;
		}
		else if (self.current_weapon == #WEAP_INCENDIARY)
		{
     		self.current_weapon = #WEAP_ASSAULT_CANNON;
			if (self.ammo_cells < 6)
				am = 1;
        	if (self.ammo_shells < 1)
        		am = 1;
     	}
     	else if (self.current_weapon == #WEAP_ASSAULT_CANNON)
     	{
			self.current_weapon = #WEAP_HOOK;

			if (!allow_hook)
				am = 1;
     	}
		else if (self.current_weapon == #WEAP_HOOK)
		{
#ifndef MEDIKIT_IS_BIOWEAPON
			self.current_weapon = #WEAP_BIOWEAPON;
#endif

#ifdef MEDIKIT_IS_BIOWEAPON
			self.current_weapon = #WEAP_MEDIKIT;
#endif	
		}
		else if (self.current_weapon == #WEAP_BIOWEAPON)
		{
			self.current_weapon = #WEAP_MEDIKIT;
		}
		else if (self.current_weapon == #WEAP_MEDIKIT)
		{
			self.current_weapon = #WEAP_AXE;
		}

		// Safety precaution
		if (loopcount > 30)
			return;

		loopcount = loopcount + 1;

	    // check if player actually has the weapon
	   	// if not, loop again
		if ((self.weapons_carried & self.current_weapon) && (am == 0))
		{
			if (self.current_weapon != #WEAP_GRENADE_LAUNCHER)
				self.weaponmode = #GL_NORMAL;	// reset the pipebombs

			W_SetCurrentAmmo ();
			W_PrintWeaponMessage();

			self.StatusRefreshTime = time + 0.1;
			return;
		}
	}
};



#ifndef QUAKE_WORLD
void() QuadCheat =
{
	if (deathmatch || coop)
		return;
	self.super_time = 1;
	self.super_damage_finished = time + 30;
	self.items = self.items | #IT_QUAD;
	dprint ("quad cheat\n");
};
#endif

/*
============
ImpulseCommands

============
*/
void() DeadImpulses;

void() ImpulseCommands =
{
	local entity te;

	/*=====================
	These Impulse commands rely on the use of self.last_impulse. Since they use 
	self.impulse for their own purposes, they _must_ be placed before the other 
	self.impulse tests, and they _must_ set self.impulse = 0 when they're done. 
	=====================*/
	// TeamFortress Detpack
	if (self.last_impulse == #TF_DETPACK && self.impulse)
		TeamFortress_SetDetpack(self.impulse);
	// TeamFortress Scan
	else if (self.last_impulse == #TF_SCAN && self.impulse)
		TeamFortress_Scan(self.impulse);

	/*=====================
    The rest of these Impulse Commands don't use self.last_impulse. They _must_
	be placed _after_ the Impulse Commands that do require self.last_impulse 
	=====================*/

	// Catch the 8 key to reprint the classhelp.
	// Remove this when we return the lightning gun
	if (self.impulse == 8 && self.current_menu != #MENU_CLASSHELP)
	{
		self.current_menu = #MENU_CLASSHELP;
		self.menu_count = #MENU_REFRESH_RATE;
		self.menu_displaytime = 0;
	}

	// uses the special skill of the player's class
	if (self.impulse == #TF_SPECIAL_SKILL)
		UseSpecialSkill();

	// No weapon related impulses can be done when setting detpacks or building
	if (!self.is_building && !self.is_detpacking && !self.is_feigning)
	{
		if ((self.impulse >= 1 && self.impulse < 8) || (self.impulse == #TF_MEDIKIT))
			W_ChangeWeapon ();

		// Grappling Hook
		else if ((allow_hook) && (self.impulse == #HOOK_IMP1 || self.impulse == #HOOK_IMP2))
			W_ChangeWeapon ();

		// Axe 
		else if (self.impulse == #AXE_IMP)
			W_ChangeWeapon ();

		// cycle weapon reverse and cycle weapon do the same thing
		// TBD: make CycleWeaponReverseCommand()
		else if (self.impulse == 10 || self.impulse == 12)
			CycleWeaponCommand ();

		// TeamFortress Prime Grenade Type 1
		else if (self.impulse == #TF_GRENADE_1)
			TeamFortress_PrimeGrenade();
		// TeamFortress Prime Grenade Type 2
		else if (self.impulse == #TF_GRENADE_2)
			TeamFortress_PrimeGrenade();

		// TeamFortress Reload current weapon
		else if (self.impulse == #TF_RELOAD)
			TeamFortress_ReloadCurrentWeapon();

		// Scanning impulses
		else if (self.impulse == #TF_SCAN_10)
			TeamFortress_Scan(10);
		else if (self.impulse == #TF_SCAN_30)
			TeamFortress_Scan(30);
		else if (self.impulse == #TF_SCAN_100)
			TeamFortress_Scan(100);

		// TeamFortress Set Detpack Impulses
		else if (self.impulse == #TF_DETPACK_5)
			TeamFortress_SetDetpack(5);
		else if (self.impulse == #TF_DETPACK_20)
			TeamFortress_SetDetpack(20);
		else if (self.impulse == #TF_DETPACK_50)
			TeamFortress_SetDetpack(50);
		else if (self.impulse == #TF_DROP_AMMO)
		{
			self.current_menu = #MENU_DROP;
			self.menu_count = #MENU_REFRESH_RATE - 5;
		}
		else if (self.impulse == #TF_DISCARD)
			TeamFortress_Discard();
#ifdef COOP_MODE
		else if (self.impulse == #TF_DROPKEY && coop)
			DropKey();
#endif
	}

	// TeamFortress Inventory
	if (self.impulse == #TF_INVENTORY)
		TeamFortress_Inventory();

	else if (self.impulse == #TF_MEDIC_HELPME)
		TeamFortress_SaveMe();

	// TeamFortress Throw Grenade 
	else if (self.impulse == #TF_GRENADE_T)
		TeamFortress_ThrowGrenade();

	else if (self.impulse == #TF_ID)
		TeamFortress_ID();

	// TeamFortress Detonate Pipebombs  (yep, can be done while setting a detpack :)
	else if (self.impulse == #TF_PB_DETONATE)
		TeamFortress_DetonatePipebombs();

	// TeamFortress Stop Setting Detpack
	else if (self.impulse == #TF_DETPACK_STOP)
		TeamFortress_DetpackStop();

	// TeamFortress Class Impulses
	else if (self.impulse == #TF_SPY_SPY && self.playerclass == #PC_SPY)
		TeamFortress_SpyGoUndercover();
	else if (self.impulse == #TF_SPY_DIE && self.playerclass == #PC_SPY)
		TeamFortress_SpyFeignDeath();
	else if (self.impulse == #TF_ENGINEER_BUILD && self.playerclass == #PC_ENGINEER)
		TeamFortress_EngineerBuild();

	// CTF Support Impulses
	else if (self.impulse == #FLAG_INFO)
	{
		if (CTF_Map == #TRUE)	
			TeamFortress_CTF_FlagInfo();
		else
			TeamFortress_DisplayDetectionItems();
	}
	else if (self.impulse == #TF_DISPLAYLOCATION)
		display_location();

#ifdef DEMO_STUFF
	// Camera Impulses
	else if (self.playerclass == #PC_UNDEFINED && self.impulse == #TF_CAM_TARGET)
		CamLock();
	else if (self.playerclass == #PC_UNDEFINED && self.impulse == #TF_CAM_ZOOM)
		CamDistLock();
	else if (self.playerclass == #PC_UNDEFINED && self.impulse == #TF_CAM_VEC)
		CamVecLock();
	else if (self.playerclass == #PC_UNDEFINED && self.impulse == #TF_CAM_ANGLE)
		CamAngleLock();
	else if (self.playerclass == #PC_UNDEFINED && self.impulse == #TF_CAM_REVANGLE)
		CamRevAngleLock();
	else if (self.playerclass == #PC_UNDEFINED && self.impulse == #TF_CAM_PROJECTILE)
		CamProjectileLock();
	else if (self.playerclass == #PC_UNDEFINED && self.impulse == #TF_CAM_PROJECTILE_Z)
		CamProjectileZoom();
	else if (self.playerclass == #PC_UNDEFINED && self.impulse == #TF_CAM_OFFSET)
		CamOffset();
	else if (self.playerclass == #PC_UNDEFINED && self.impulse == #TF_CAM_DROP)
		CamDrop();
	else if (self.playerclass == #PC_UNDEFINED && self.impulse == #TF_CAM_FADETOBLACK)
		fadetoblack();
	else if (self.playerclass == #PC_UNDEFINED && self.impulse == #TF_CAM_FADEFROMBLACK)
		fadefromblack();
	else if (self.playerclass == #PC_UNDEFINED && self.impulse == #TF_CAM_FADETOWHITE)
		fadetowhite();
	else if (self.playerclass == #PC_UNDEFINED && self.impulse == #TF_CAM_FADEFROMWHITE)
		fadefromwhite();
#endif

	else
		DeadImpulses();

	/*=====================
	TeamFortress Pre-Impulse Commands
	=====================*/
	if (self.impulse == #TF_DETPACK)
		self.last_impulse = self.impulse;
	if (self.impulse == #TF_SCAN)
		self.last_impulse = self.impulse;
		
	self.impulse = 0;
};

/*====================
	DeadImpulses

Impulse commands that
are allowable if the
player is dead
====================*/
void() DeadImpulses =
{
	// TeamFortress Show Toggleflag State
	if (self.impulse == #TF_SHOWTF)
		TeamFortress_ShowTF();
	// TeamFortress Show Legal PlayerClasses 
	// Toggle autozoom on/off
	else if (self.impulse == #TF_AUTOZOOM)
		TeamFortress_AutoZoomToggle();
	else if (self.impulse == #TF_SHOWLEGALCLASSES)
		TeamFortress_DisplayLegalClasses();

	// TeamFortress Change PlayerClass
    else if (self.impulse >= #TF_CHANGEPC && self.impulse <= (#TF_CHANGEPC + #PC_RANDOM) )
    	TeamFortress_ChangeClass();

	// TeamFortress Help Impulses
	else if (self.impulse == #TF_HELP_MAP)
		TeamFortress_HelpMap();
	else if (self.impulse == #TF_STATUS_QUERY)
		TeamFortress_StatusQuery();
	// TeamFortress Team Impulse
	else if (self.impulse == #TF_TEAM_1)
		TeamFortress_TeamSet(1);
	else if (self.impulse == #TF_TEAM_2)
		TeamFortress_TeamSet(2);
	else if (self.impulse == #TF_TEAM_3)
		TeamFortress_TeamSet(3);
	else if (self.impulse == #TF_TEAM_4)
		TeamFortress_TeamSet(4);
	else if (self.impulse == #TF_TEAM_SCORES)
		TeamFortress_TeamShowScores(0);
	else if (self.impulse == #TF_TEAM_CLASSES)
		TeamFortress_TeamShowMemberClasses(self);
	else if (self.impulse == #TF_STATUSBAR_ON)
	{
		self.StatusRefreshTime = time + 0.2;
		self.StatusBarSize = self.StatusBarSize + 1;
		if (self.StatusBarSize > 2)
			self.StatusBarSize = 1;
	}
	else if (self.impulse == #TF_STATUSBAR_OFF)
	{
		self.StatusRefreshTime = time + 60;
		self.StatusBarSize = 0;
	}
	else if (self.impulse >= #TF_STATUSBAR_RES_START && self.impulse <= #TF_STATUSBAR_RES_END)
	{
		StatusRes(self.impulse - 71);
	}

	// TeamFortress Alias checking
	else if (self.impulse == #TF_ALIAS_CHECK)
	{
		sprint (self, #PRINT_HIGH, "Aliases checked.\n");
		self.got_aliases = #TRUE;
		self.impulse = 0;
	}

};


/*
============
W_WeaponFrame

Called every frame so impulse events can be handled as well as possible
============
*/
void() W_WeaponFrame =
{
	local vector tv;

	if (!(self.tfstate & #TFSTATE_AIMING))
	{
		if (self.height > 29 && self.height < 90)
		{
			self.height = self.height + 8;
			if (self.height > 90)
				self.height = 90;

			TF_zoom(self.height);
		}
	}

	if (self.current_menu > 0)
	{
		Player_Menu();		

		if (self.impulse > 0 && self.impulse < 11)
		{
  			Menu_Input(self.impulse);

			if (self.impulse != 0)
			{
				if (self.team_no == 0 && teamplay && (self.lives != 0))
				{
					Menu_Team_Input(self.impulse);
				}
				else if (self.playerclass == #PC_UNDEFINED && (self.lives != 0))
				{
					Menu_Class_Input(self.impulse);
				}
			}
		}
	}

	if (time < self.attack_finished)
		return;

	// Stop calling this function so much
	if (self.impulse != 0)
		ImpulseCommands ();

	// Can't fire while setting a detpack or building something
	if ((self.is_building != 0) || (self.is_detpacking != 0) || (self.is_feigning != 0))
		return;

	// Check for release
	if (!self.button0 && self.fire_held_down && self.current_weapon == #WEAP_ASSAULT_CANNON)
	{
	    self.fire_held_down = #FALSE;

		// Let him/her walk again
		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_CANT_MOVE);
		TeamFortress_SetSpeed(self);

		player_run ();
	}

	// check for attack
    if (self.button0 && !(self.fire_held_down))
	{
		if ((self.current_menu == #MENU_CLASSHELP) || (self.current_menu == #MENU_CLASSHELP2))
		{
			self.current_menu = #MENU_REPEATHELP;
			self.menu_count = #MENU_REFRESH_RATE;
			Attack_Finished(0.2);
		}
		else if (self.current_weapon == #WEAP_SNIPER_RIFLE)
		{
			if (self.tfstate & #TFSTATE_AIMING)
			{
				if (self.heat < 400)
					self.heat = self.heat + 3;

				if (self.height > 30)
				{
					self.height = self.height - 5;
					TF_zoom(self.height);
				}

			}
			else
			{
				tv = self.velocity;
				tv_z = 0;

				if (vlen(tv) <= #WEAP_SNIPER_RIFLE_MAX_MOVE)
				{
					// create the laser sight
					SniperSight_Create();
					self.heat = 50; // damage done
					#ifdef WEINER_SNIPER
						self.heat = 80;
					#endif
					
					self.height = 90;
					self.tfstate = self.tfstate | #TFSTATE_AIMING;
	
					TeamFortress_SetSpeed(self);
				}
			}
		}
		else if (self.current_weapon == #WEAP_ASSAULT_CANNON)
		{
			// Only fire the Assault Cannon if the player is on the ground
			if (self.flags & #FL_ONGROUND)
			{
				SuperDamageSound ();
				W_Attack ();
			}
			else
			{
				sprint(self, #PRINT_MEDIUM, "You cannot fire the assault cannon without\nyour feet on the ground...\n");
			}
		}
		else
		{
			SuperDamageSound ();
			W_Attack ();
		}
	}
	else if (self.playerclass == #PC_UNDEFINED)
	{
		self.weaponmode = 0;
	}
	else if (self.tfstate & #TFSTATE_AIMING)
	{
		W_Attack();
		self.tfstate = self.tfstate - #TFSTATE_AIMING;
		TeamFortress_SetSpeed(self);
		self.heat = 0;
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
	if (self.super_damage_finished > time)
	{
		if (self.super_sound < time)
		{
			self.super_sound = time + 1;
			sound (self, #CHAN_BODY, "items/damage3.wav", 1, #ATTN_NORM);
		}
	}
	return;
};
