/*
	Heavily Modified for TeamFortress V1.21
	TeamFortress Software
	Robin Walker, John Cook, Ian Caughley
*/
// Prototypes
void() bubble_bob;
void() W_FireAssaultCannon;

void() Throw_Grapple;

// TeamFortress Prototypes
void() BioInfection_Decay;
void() TeamFortress_RemoveTimers;
void() T_Dispenser;
void() Headless_Think;

/*
==============================================================================

PLAYER

==============================================================================
*/

$cd /raid/quake/id1/models/player_4
$origin 0 -6 24
$base base		
$skin skin

//
// running
//
$frame axrun1 axrun2 axrun3 axrun4 axrun5 axrun6

$frame rockrun1 rockrun2 rockrun3 rockrun4 rockrun5 rockrun6

//
// standing
//
$frame stand1 stand2 stand3 stand4 stand5

$frame axstnd1 axstnd2 axstnd3 axstnd4 axstnd5 axstnd6
$frame axstnd7 axstnd8 axstnd9 axstnd10 axstnd11 axstnd12


//
// pain
//
$frame axpain1 axpain2 axpain3 axpain4 axpain5 axpain6

$frame pain1 pain2 pain3 pain4 pain5 pain6


//
// death
//

$frame axdeth1 axdeth2 axdeth3 axdeth4 axdeth5 axdeth6
$frame axdeth7 axdeth8 axdeth9

$frame deatha1 deatha2 deatha3 deatha4 deatha5 deatha6 deatha7 deatha8
$frame deatha9 deatha10 deatha11

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8
$frame deathc9 deathc10 deathc11 deathc12 deathc13 deathc14 deathc15

$frame deathd1 deathd2 deathd3 deathd4 deathd5 deathd6 deathd7
$frame deathd8 deathd9

$frame deathe1 deathe2 deathe3 deathe4 deathe5 deathe6 deathe7
$frame deathe8 deathe9

//
// attacks
//
$frame nailatt1 nailatt2

$frame light1 light2

$frame rockatt1 rockatt2 rockatt3 rockatt4 rockatt5 rockatt6

$frame shotatt1 shotatt2 shotatt3 shotatt4 shotatt5 shotatt6

$frame axatt1 axatt2 axatt3 axatt4 axatt5 axatt6

$frame axattb1 axattb2 axattb3 axattb4 axattb5 axattb6

$frame axattc1 axattc2 axattc3 axattc4 axattc5 axattc6

$frame axattd1 axattd2 axattd3 axattd4 axattd5 axattd6


/*
==============================================================================
PLAYER
==============================================================================
*/
void() player_touch =
{
	local entity Bio;
	local float v1, v2;

	// Spies and Scouts can uncloak enemy spies
	if (invis_only == #FALSE && (self.playerclass == #PC_SPY || other.playerclass == #PC_SPY))
	{
		if (other.classname == "player")
		{
			if (self.undercover_team != 0 || self.undercover_skin != 0)
			{
				if ((other.playerclass == #PC_SPY || other.playerclass == #PC_SCOUT) && (other.team_no != self.team_no))
				{
					sprint(other, #PRINT_HIGH, "Wait a minute... he's a Spy!\n");
					sprint(self, #PRINT_HIGH, "The enemy sees through your disguise!\n");
					Spy_RemoveDisguise(self);
				}
			}
			if (other.undercover_team != 0 || other.undercover_skin != 0)
			{
				if ((self.playerclass == #PC_SPY || self.playerclass == #PC_SCOUT) && (self.team_no != other.team_no))
				{
					sprint(self, #PRINT_HIGH, "Wait a minute... he's a Spy!\n");
					sprint(other, #PRINT_HIGH, "The enemy sees through your disguise!\n");
					Spy_RemoveDisguise(other);
				}
			}
		}
	}

	// Pass on infections
	if (self.tfstate & #TFSTATE_INFECTED)
	{
		if (other.classname == "player")
		{
			// may sure other player is not already infected
			if (!(other.tfstate & #TFSTATE_INFECTED))
			{
				// can't infect the medic
				if (other.playerclass != #PC_MEDIC)
				{
					// infect 'em
					Bio = spawn ();
					Bio.nextthink = 2;
					Bio.think = BioInfection_Decay;
					Bio.owner = other;
					Bio.classname = "timer";
					Bio.enemy = self;
					
					other.tfstate = other.tfstate | #TFSTATE_INFECTED;
					other.infection_team_no = self.infection_team_no;

					sprint(other, #PRINT_MEDIUM, "You have been infected by ");
					sprint(other, #PRINT_MEDIUM, self.netname);
					sprint(other, #PRINT_MEDIUM, "!\n");
					sprint(self, #PRINT_MEDIUM, "You have infected ");
					sprint(self, #PRINT_MEDIUM, other.netname);
					sprint(self, #PRINT_MEDIUM, "!\n");
				}				
			}
		}
	}

#ifdef PLAYER_PUSHING
	if (other.classname == "player")
	{
		if ((self.team_no == other.team_no) && (self.team_no != 0))
		{
			v1 = vlen(other.velocity);
			if (v1 < 50)
			{
				v2 = vlen(self.velocity);
				if (v2 > 55 || (self.items & (#IT_KEY1 | #IT_KEY2)))
				{
					makevectors(self.angles);
					traceline (self.origin, self.origin + v_forward*32, #FALSE, self);
					if (trace_ent == other)
					{
						if (self.items & (#IT_KEY1 | #IT_KEY2))
							other.velocity = other.velocity + (normalize(self.velocity) * 120);
						else if (!(other.items & (#IT_KEY1 | #IT_KEY2)))
							other.velocity = other.velocity + (normalize(self.velocity) * 30);
					}
				}
			}
		}
	}
#endif
};

void() player_run;

void()	player_stand1 =[	$axstnd1,	player_stand1	]
{
	self.weaponframe=0;
	if (self.velocity_x || self.velocity_y)
	{
		self.walkframe=0;
		player_run();
		return;
	}

	if (self.current_weapon <= #WEAP_AXE)
	{
		if (self.walkframe >= 12)
			self.walkframe = 0;
		self.frame = $axstnd1 + self.walkframe;
	}
	else
	{
		if (self.walkframe >= 5)
			self.walkframe = 0;
		self.frame = $stand1 + self.walkframe;
	}
	self.walkframe = self.walkframe + 1;	
};

void()	player_run =[	$rockrun1,	player_run	]
{
	self.weaponframe=0;
	if (!self.velocity_x && !self.velocity_y)
	{
		self.walkframe=0;
		player_stand1();
		return;
	}

	if (self.current_weapon <= #WEAP_AXE)
	{
		if (self.walkframe == 6)
			self.walkframe = 0;
		self.frame = $axrun1 + self.walkframe;
	}
	else
	{
		if (self.walkframe == 6)
			self.walkframe = 0;
		self.frame = self.frame + self.walkframe;
	}
	self.walkframe = self.walkframe + 1;
};


void()	player_shot1 =	[$shotatt1, player_shot2	] {self.weaponframe=1;muzzleflash();};
void()	player_shot2 =	[$shotatt2, player_shot3	] {self.weaponframe=2;};
void()	player_shot3 =	[$shotatt3, player_shot4	] {self.weaponframe=3;};
void()	player_shot4 =	[$shotatt4, player_shot5	] {self.weaponframe=4;};
void()	player_shot5 =	[$shotatt5, player_shot6	] {self.weaponframe=5;};
void()	player_shot6 =	[$shotatt6, player_run	] {self.weaponframe=6;};

void()	player_autorifle1 =	[$shotatt1, player_autorifle2	] {self.weaponframe=1; muzzleflash(); };
void()	player_autorifle2 =	[$shotatt2, player_autorifle3	] {self.weaponframe=2;};
void()	player_autorifle3 =	[$shotatt6, player_run	] {self.weaponframe=6;};

void()	player_axe1 =	[$axatt1, player_axe2	] {self.weaponframe=1;};
void()	player_axe2 =	[$axatt2, player_axe3	] {self.weaponframe=2;};
void()	player_axe3 =	[$axatt3, player_axe4	] 
{
	self.weaponframe=3;
	if (self.current_weapon == #WEAP_AXE)
		W_FireAxe();
	else // if (self.current_weapon == #WEAP_SPANNER)
		W_FireSpanner();
};
void()	player_axe4 =	[$axatt4, player_run	] {self.weaponframe=4;};

void()	player_axeb1 =	[$axattb1, player_axeb2	] {self.weaponframe=5;};
void()	player_axeb2 =	[$axattb2, player_axeb3	] {self.weaponframe=6;};
void()	player_axeb3 =	[$axattb3, player_axeb4	] 
{
	self.weaponframe=7;
	if (self.current_weapon == #WEAP_AXE)
		W_FireAxe();
	else // if (self.current_weapon == #WEAP_SPANNER)
		W_FireSpanner();
};
void()	player_axeb4 =	[$axattb4, player_run	] {self.weaponframe=8;};

void()	player_axec1 =	[$axattc1, player_axec2	] {self.weaponframe=1;};
void()	player_axec2 =	[$axattc2, player_axec3	] {self.weaponframe=2;};
void()	player_axec3 =	[$axattc3, player_axec4	] 
{
	self.weaponframe=3;
	if (self.current_weapon == #WEAP_AXE)
		W_FireAxe();
	else // if (self.current_weapon == #WEAP_SPANNER)
		W_FireSpanner();
};
void()	player_axec4 =	[$axattc4, player_run	] {self.weaponframe=4;};

void()	player_axed1 =	[$axattd1, player_axed2	] {self.weaponframe=5;};
void()	player_axed2 =	[$axattd2, player_axed3	] {self.weaponframe=6;};
void()	player_axed3 =	[$axattd3, player_axed4	] 
{
	self.weaponframe=7;
	if (self.current_weapon == #WEAP_AXE)
		W_FireAxe();
	else // if (self.current_weapon == #WEAP_SPANNER)
		W_FireSpanner();
};
void()	player_axed4 =	[$axattd4, player_run	] {self.weaponframe=8;};

//=========================
// QW Grappling hook frames
void()  player_chain1=  [$axattd1, player_chain1a] {self.weaponframe=1;Throw_Grapple();};
void()  player_chain1a= [$axattd1, player_chain2 ] {self.weaponframe=2;};
void()  player_chain2=  [$axattd2, player_chain2a] {self.weaponframe=3;};
void()  player_chain2a= [$axattd2, player_chain3 ] {self.weaponframe=4;};
void()  player_chain3=  [$axattd3, player_chain3 ]
{
        self.weaponframe=6;
        if (!self.hook_out)
        {
                player_chain5();
                return;
        }
        if (vlen(self.velocity) >= 750)
        {
                player_chain4();
                return;
        }
};

void() player_chain4=  [$deathc4, player_chain4 ]
{
        self.weaponframe=6;
        if (!self.hook_out)
        {
                player_chain5();
                return;
        }
        if (vlen(self.velocity) < 750)
        {
                player_chain3();
                return;
        }
};

void()  player_chain5=  [$axattd4, player_run    ] {self.weaponframe=0;};

// newstuff

void()	player_medikit1 =	[$axatt1, player_medikit2	] {self.weaponframe=1;};
void()	player_medikit2 =	[$axatt2, player_medikit3	] {self.weaponframe=2;};
void()	player_medikit3 =	[$axatt3, player_medikit4	] {self.weaponframe=3;W_FireMedikit();};
void()	player_medikit4 =	[$axatt4, player_run		] {self.weaponframe=4;};

void()	player_medikitb1 =	[$axattb1, player_medikitb2	] {self.weaponframe=5;};
void()	player_medikitb2 =	[$axattb2, player_medikitb3	] {self.weaponframe=6;};
void()	player_medikitb3 =	[$axattb3, player_medikitb4	] {self.weaponframe=7;W_FireMedikit();};
void()	player_medikitb4 =	[$axattb4, player_run		] {self.weaponframe=8;};

void()	player_medikitc1 =	[$axattc1, player_medikitc2	] {self.weaponframe=1;};
void()	player_medikitc2 =	[$axattc2, player_medikitc3	] {self.weaponframe=2;};
void()	player_medikitc3 =	[$axattc3, player_medikitc4	] {self.weaponframe=3;W_FireMedikit();};
void()	player_medikitc4 =	[$axattc4, player_run		] {self.weaponframe=4;};

void()	player_medikitd1 =	[$axattd1, player_medikitd2	] {self.weaponframe=5;};
void()	player_medikitd2 =	[$axattd2, player_medikitd3	] {self.weaponframe=6;};
void()	player_medikitd3 =	[$axattd3, player_medikitd4	] {self.weaponframe=7;W_FireMedikit();};
void()	player_medikitd4 =	[$axattd4, player_run		] {self.weaponframe=8;};

void()	player_bioweapon1 =	[$axatt1, player_bioweapon2	] {self.weaponframe=1;};
void()	player_bioweapon2 =	[$axatt2, player_bioweapon3	] {self.weaponframe=2;};
void()	player_bioweapon3 =	[$axatt3, player_bioweapon4	] {self.weaponframe=3;W_FireBioweapon();};
void()	player_bioweapon4 =	[$axatt4, player_run		] {self.weaponframe=4;};

void()	player_bioweaponb1 =	[$axattb1, player_bioweaponb2	] {self.weaponframe=5;};
void()	player_bioweaponb2 =	[$axattb2, player_bioweaponb3	] {self.weaponframe=6;};
void()	player_bioweaponb3 =	[$axattb3, player_bioweaponb4	] {self.weaponframe=7;W_FireBioweapon();};
void()	player_bioweaponb4 =	[$axattb4, player_run	] {self.weaponframe=8;};

void()	player_bioweaponc1 =	[$axattc1, player_bioweaponc2	] {self.weaponframe=1;};
void()	player_bioweaponc2 =	[$axattc2, player_bioweaponc3	] {self.weaponframe=2;};
void()	player_bioweaponc3 =	[$axattc3, player_bioweaponc4	] {self.weaponframe=3;W_FireBioweapon();};
void()	player_bioweaponc4 =	[$axattc4, player_run	] {self.weaponframe=4;};

void()	player_bioweapond1 =	[$axattd1, player_bioweapond2	] {self.weaponframe=5;};
void()	player_bioweapond2 =	[$axattd2, player_bioweapond3	] {self.weaponframe=6;};
void()	player_bioweapond3 =	[$axattd3, player_bioweapond4	] {self.weaponframe=7;W_FireBioweapon();};
void()	player_bioweapond4 =	[$axattd4, player_run	] {self.weaponframe=8;};
 
//============================================================================

void() player_nail1   =[ $nailatt1, player_nail2  ] 
{
	muzzleflash();

	if (!self.button0 || intermission_running)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 9)
		self.weaponframe = 1;
	SuperDamageSound();
	W_FireSpikes (4);
	Attack_Finished(0.2);
};
void() player_nail2   =[ $nailatt2, player_nail1  ]
{
	if (!self.button0 || intermission_running)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 9)
		self.weaponframe = 1;
	SuperDamageSound();
	W_FireSpikes (-4);
	Attack_Finished(0.2);
};


//============================================================================
// ASSAULT CANNON FRAMES
// Cannon powering up
void() player_assaultcannonup1   =[$nailatt1, player_assaultcannonup2  ] 
{
	if ((!self.button0) || (self.ammo_shells < 1) || intermission_running)
	{
		// Let him/her walk again
		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_CANT_MOVE);
		TeamFortress_SetSpeed(self);

		self.count = 1;
		self.heat = 0;
		player_assaultcannondown1();
		return;
	}

    self.fire_held_down = #TRUE;

	if (self.heat == 1)
		sound (self, #CHAN_WEAPON, "weapons/asscan1.wav", 1, #ATTN_NORM);

	SuperDamageSound();
	Attack_Finished(0.1);

	if (self.heat != 2 && self.heat != 4)
	{
		if (self.weaponframe >= 3)
			self.weaponframe = 0;
		else
			self.weaponframe = self.weaponframe + 1;
	}

	self.heat = self.heat + 1;
	if (self.heat >= 7)
	{
		self.heat = 0;
		player_assaultcannon1();
	}
};

// Cannon powering up 2
void() player_assaultcannonup2   =[$nailatt1, player_assaultcannonup1  ] 
{
	if ((!self.button0) || (self.ammo_shells < 1) || intermission_running)
	{
		// Let him/her walk again
		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_CANT_MOVE);
		TeamFortress_SetSpeed(self);

		self.count = 1;
		self.heat = 0;
		player_assaultcannondown1();
		return;
	}

	SuperDamageSound();
	Attack_Finished(0.1);

	if (self.heat != 2 && self.heat != 4 && self.heat != 7)
	{
		if (self.weaponframe == 2 && self.heat >= 9)
			self.weaponframe = 0;
		else if (self.weaponframe >= 3)
			self.weaponframe = 0;
		else
			self.weaponframe = self.weaponframe + 1;
	}

	self.heat = self.heat + 1;
	if (self.heat >= 13)
	{
		self.heat = 0;
		player_assaultcannon1();
	}
};

// Cannon Firing 
void() player_assaultcannon1   =[$nailatt1, player_assaultcannon2  ] 
{
	local string st;

	muzzleflash();

	sound (self, #CHAN_WEAPON, "weapons/asscan2.wav", 1, #ATTN_NORM);

	if ((!self.button0) || (self.ammo_shells < 1) || intermission_running)
	{
		stuffcmd(self, "v_idlescale 0\n");
		// Let him/her walk again
		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_CANT_MOVE);
		TeamFortress_SetSpeed(self);

		self.weaponframe = 0;
		self.count = 1;
		player_assaultcannondown1();
		return;
	}

	if (self.weaponframe == 2)
		self.weaponframe = 4;
	else
		self.weaponframe = 2;
	SuperDamageSound();
	W_FireAssaultCannon();

	// Shake the screen
	stuffcmd(self, "v_idlescale ");
	if (self.heat < 5)
		st = ftos(self.heat * 4);
	else
		st = "20";
	stuffcmd(self, st);
	stuffcmd(self, "\n");
	Attack_Finished(0.1);
};

// Cannon Firing 2
void() player_assaultcannon2   =[$nailatt2, player_assaultcannon1  ]
{
	local string st;

	if ((!self.button0) || (self.ammo_shells < 1) || intermission_running)
	{
		stuffcmd(self, "v_idlescale 0\n");
		// Let him/her walk again
		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_CANT_MOVE);
		TeamFortress_SetSpeed(self);

		self.weaponframe = 0;
		self.count = 1;
		player_assaultcannondown1();
		return;
	}

	if (self.weaponframe == 2)
		self.weaponframe = 4;
	else
		self.weaponframe = 2;
	SuperDamageSound();
	W_FireAssaultCannon();

	// increase the heat of the cannon
	self.heat = self.heat + 0.1;
	// Shake the screen
	stuffcmd(self, "v_idlescale 0\n");
	stuffcmd(self, "bf\n");

	Attack_Finished(0.1);
};

// Cannon powering down
void() player_assaultcannondown1   =[$nailatt1, player_assaultcannondown1  ] 
{
	local entity tcool;

	if (self.count == 1)
		sound (self, #CHAN_WEAPON, "weapons/asscan3.wav", 1, #ATTN_NORM);

	if (self.count >= 15)
	{
		self.heat = 0;
	    self.fire_held_down = #FALSE;

		// Let him/her walk again
		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_CANT_MOVE);
		TeamFortress_SetSpeed(self);

		if (self.ammo_shells < 1 || self.ammo_cells < 6)
		{
			self.current_weapon = W_BestWeapon();
			W_SetCurrentAmmo();
			W_PrintWeaponMessage();
			return;
		}

		player_run ();
		return;
	}

	if (self.count != 8 && self.count != 10 && self.count != 12 && self.count != 14)  
	{
		if (self.weaponframe == 3)
			self.weaponframe = 0;
		else
			self.weaponframe = self.weaponframe + 1;
	}

	self.count = self.count + 1;
	Attack_Finished(0.1);
};

//============================================================================

void() player_light1   =[$light1, player_light2  ] 
{
	muzzleflash();

	if (!self.button0 || intermission_running)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
	SuperDamageSound();
	W_FireLightning();
	Attack_Finished(0.2);
};
void() player_light2   =[$light2, player_light1  ]
{
	if (!self.button0 || intermission_running)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
	SuperDamageSound();
	W_FireLightning();
	Attack_Finished(0.2);
};

//============================================================================


void() player_rocket1   =[$rockatt1, player_rocket2  ] {self.weaponframe=1;	muzzleflash();};
void() player_rocket2   =[$rockatt2, player_rocket3  ] {self.weaponframe=2;};
void() player_rocket3   =[$rockatt3, player_rocket4  ] {self.weaponframe=3;};
void() player_rocket4   =[$rockatt4, player_rocket5  ] {self.weaponframe=4;};
void() player_rocket5   =[$rockatt5, player_rocket6  ] {self.weaponframe=5;};
void() player_rocket6   =[$rockatt6, player_run  ] {self.weaponframe=6;};
void(float num_bubbles) DeathBubbles;

void() PainSound =
{
local float		rs;

	if (self.health < 0)
		return;

	if (damage_attacker.classname == "teledeath")
	{
		sound (self, #CHAN_VOICE, "player/teledth1.wav", 1, #ATTN_NONE);
		return;
	}

	// water pain sounds
	if (self.watertype == #CONTENT_WATER && self.waterlevel == 3)
	{
		DeathBubbles(1);
		if (random() > 0.5)
			sound (self, #CHAN_VOICE, "player/drown1.wav", 1, #ATTN_NORM);
		else
			sound (self, #CHAN_VOICE, "player/drown2.wav", 1, #ATTN_NORM);
		return;
	}
	
	// slime pain sounds
	if (self.watertype == #CONTENT_SLIME)
	{
		// FIX ME	put in some steam here
		if (random() > 0.5)
			sound (self, #CHAN_VOICE, "player/lburn1.wav", 1, #ATTN_NORM);
		else
			sound (self, #CHAN_VOICE, "player/lburn2.wav", 1, #ATTN_NORM);
		return;
	}

	if (self.watertype == #CONTENT_LAVA)
	{
		if (random() > 0.5)
			sound (self, #CHAN_VOICE, "player/lburn1.wav", 1, #ATTN_NORM);
		else
			sound (self, #CHAN_VOICE, "player/lburn2.wav", 1, #ATTN_NORM);
		return;
	}

	if (self.pain_finished > time)
	{
		self.axhitme = 0;
		return;
	}
	self.pain_finished = time + 0.5;

// don't make multiple pain sounds right after each other

// ax pain sound
	if (self.axhitme == 1)
	{
		self.axhitme = 0;
		sound (self, #CHAN_VOICE, "player/axhit1.wav", 1, #ATTN_NORM);
		return;
	}

	rs = rint((random() * 5) + 1);

	self.noise = "";
	if (rs == 1)
		self.noise = "player/pain1.wav";
	else if (rs == 2)
		self.noise = "player/pain2.wav";
	else if (rs == 3)
		self.noise = "player/pain3.wav";
	else if (rs == 4)
		self.noise = "player/pain4.wav";
	else if (rs == 5)
		self.noise = "player/pain5.wav";
	else
		self.noise = "player/pain6.wav";

	sound (self, #CHAN_VOICE, self.noise, 1, #ATTN_NORM);
	return;
};

void()	player_pain1 =	[	$pain1,	player_pain2	] {PainSound();self.weaponframe=0;};
void()	player_pain2 =	[	$pain2,	player_pain3	] {};
void()	player_pain3 =	[	$pain3,	player_pain4	] {};
void()	player_pain4 =	[	$pain4,	player_pain5	] {};
void()	player_pain5 =	[	$pain5,	player_pain6	] {};
void()	player_pain6 =	[	$pain6,	player_run		] {};

void()	player_axpain1 =	[	$axpain1,	player_axpain2	] {PainSound();self.weaponframe=0;};
void()	player_axpain2 =	[	$axpain2,	player_axpain3	] {};
void()	player_axpain3 =	[	$axpain3,	player_axpain4	] {};
void()	player_axpain4 =	[	$axpain4,	player_axpain5	] {};
void()	player_axpain5 =	[	$axpain5,	player_axpain6	] {};
void()	player_axpain6 =	[	$axpain6,	player_run		] {};

void() player_pain =
{
	if (self.weaponframe)
		return;

	// eyes don't have pain frames
	if (self.invisible_finished > time)
		return;		

	// feigning players don't have pain frames
	if (self.is_feigning)
	{
		PainSound();
		return;
	}

	// HvyWeap Guys firing assault cannon don't have pain frames
	if (self.button0 && self.current_weapon == #WEAP_ASSAULT_CANNON)
		return;

	if (self.current_weapon <= #WEAP_AXE)
		player_axpain1 ();
	else
		player_pain1 ();
};

void() player_diea1;
void() player_dieb1;
void() player_diec1;
void() player_died1;
void() player_diee1;
void() player_die_ax1;

void() DeathBubblesSpawn =
{
	if (self.owner.waterlevel != 3)
		return;
	newmis = spawn();
	setmodel (newmis, "progs/s_bubble.spr");
	setorigin (newmis, self.owner.origin + '0 0 24');
	newmis.movetype = #MOVETYPE_NOCLIP;
	newmis.solid = #SOLID_NOT;
	newmis.velocity = '0 0 15';
	newmis.nextthink = time + 0.5;
	newmis.think = bubble_bob;
	newmis.classname = "bubble";
	newmis.frame = 0;
	newmis.cnt = 0;
	setsize (newmis, '-8 -8 -8', '8 8 8');
	self.nextthink = time + 0.1;
	self.think = DeathBubblesSpawn;
	self.air_finished = self.air_finished + 1;
	if (self.air_finished >= self.bubble_count)
		dremove(self);
};

void(float num_bubbles) DeathBubbles =
{
local entity	bubble_spawner;
	
	bubble_spawner = spawn();
	setorigin (bubble_spawner, self.origin);
	bubble_spawner.movetype = #MOVETYPE_NONE;
	bubble_spawner.solid = #SOLID_NOT;
	bubble_spawner.nextthink = time + 0.1;
	bubble_spawner.think = DeathBubblesSpawn;
	bubble_spawner.air_finished = 0;
	bubble_spawner.owner = self;
	bubble_spawner.bubble_count = num_bubbles;
	return;
};

void() DeathSound =
{
	local float		rs;

	// water death sounds
	if (self.waterlevel == 3)
	{
		if (self.is_feigning)
			DeathBubbles(2);
		else
			DeathBubbles(10);
		sound (self, #CHAN_VOICE, "player/h2odeath.wav", 1, #ATTN_NONE);
		return;
	}
	
	rs = rint ((random() * 4) + 1);
	if (rs == 1)
		self.noise = "player/death1.wav";
	if (rs == 2)
		self.noise = "player/death2.wav";
	if (rs == 3)
		self.noise = "player/death3.wav";
	if (rs == 4)
		self.noise = "player/death4.wav";
	if (rs == 5)
		self.noise = "player/death5.wav";

	sound (self, #CHAN_VOICE, self.noise, 1, #ATTN_NONE);
	return;
};


void() PlayerDead =
{
	self.nextthink = -1;
	// allow respawn after a certain time
	self.deadflag = #DEAD_DEAD;
};

vector(float dm) VelocityForDamage =
{
	local vector v;

	v_x = 100 * crandom();
	v_y = 100 * crandom();
	v_z = 200 + 100 * random();

	if (dm > -50)
	{
//		dprint ("level 1\n");
		v = v * 0.7;
	}
	else if (dm > -200)
	{
//		dprint ("level 3\n");
		v = v * 2;
	}
	else
		v = v * 10;

	return v;
};

void(string gibname, float dm) ThrowGib =
{
	newmis = spawn();
	newmis.origin = self.origin;
	setmodel (newmis, gibname);
	setsize (newmis, '0 0 0', '0 0 0');
	newmis.velocity = VelocityForDamage (dm);
	newmis.movetype = #MOVETYPE_BOUNCE;
	newmis.solid = #SOLID_NOT;
	newmis.avelocity_x = random()*600;
	newmis.avelocity_y = random()*600;
	newmis.avelocity_z = random()*600;
	newmis.think = SUB_Remove;
	newmis.ltime = time;
	newmis.nextthink = time + 10 + random()*10;
	newmis.frame = 0;
	newmis.flags = 0;
};

void(string gibname, float dm) ThrowHead =
{
	setmodel (self, gibname);
	self.skin = 0;
	self.frame = 0;
	self.nextthink = -1;
	self.movetype = #MOVETYPE_BOUNCE;
	self.takedamage = #DAMAGE_NO;
	self.solid = #SOLID_NOT;
	self.view_ofs = '0 0 8';
	setsize (self, '-16 -16 0', '16 16 56');
	self.velocity = VelocityForDamage (dm);
	self.origin_z = self.origin_z - 24;
	self.flags = self.flags - (self.flags & #FL_ONGROUND);
	self.avelocity = crandom() * '0 600 0';
};

void(string gibname) HeadShotThrowHead =
{
	setmodel (self, gibname);
	self.frame = 0;
	self.nextthink = -1;
	self.movetype = #MOVETYPE_BOUNCE;
	self.takedamage = #DAMAGE_NO;
	self.solid = #SOLID_NOT;
	self.view_ofs = '0 0 8';
	setsize (self, '-16 -16 0', '16 16 56');
	self.velocity = normalize(self.head_shot_vector) * 600;
	self.origin_z = self.origin_z + 24;
	self.flags = self.flags - (self.flags & #FL_ONGROUND);
	self.avelocity = '0 0 0';
};

void() KillPlayer =
{
	self.owner.deadflag = #DEAD_DEAD;
	dremove(self);
};

void() GibPlayer =
{
#ifndef QUAKE_WORLD
	// Decapitation
	if (deathmsg == #DMSG_SNIPERHEADSHOT || deathmsg == #DMSG_BACKSTAB)
	{
		if (deathmsg == #DMSG_SNIPERHEADSHOT)
			HeadShotThrowHead("progs/h_player.mdl");
		else
			ThrowHead("progs/h_player.mdl", -60);

		newmis = spawn();
		newmis.solid = #SOLID_NOT;
		setmodel(newmis, "progs/headless.mdl");
		setsize(newmis, '0 0 0', '0 0 0');
		setorigin(newmis, self.origin);
		newmis.movetype = #MOVETYPE_STEP;
		newmis.angles = self.angles;
		newmis.colormap = self.colormap;
		newmis.skin = self.skin;
		newmis.think = Headless_Think;
		newmis.nextthink = time + 0.1;
		if (self.current_weapon <= #WEAP_AXE)
			newmis.frame = 0;
		else
			newmis.frame = 8; 
	}
	else
	{
#endif
		ThrowHead ("progs/h_player.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
#ifndef QUAKE_WORLD
	}
#endif
	// Why do we need this? What are we doing that's clobbering _something_
	// within a second after a trigger_hurt kills the player?
	if (deathmsg == #DMSG_TRIGGER)
	{
		newmis = spawn();
		newmis.owner = self;
		newmis.think = KillPlayer;
		newmis.nextthink = time + 1;
	}
	else
	{
		self.deadflag = #DEAD_DEAD;
	}

	TeamFortress_SetupRespawn(#FALSE);

	if (damage_attacker.classname == "teledeath")
	{
		sound (self, #CHAN_VOICE, "player/teledth1.wav", 1, #ATTN_NONE);

		// if telefragged, extend respawn delay to prevent chaining telefrags
		self.respawn_time = self.respawn_time + 2;

		return;
	}

	if (damage_attacker.classname == "teledeath2")
	{
		sound (self, #CHAN_VOICE, "player/teledth1.wav", 1, #ATTN_NONE);

		// if telefragged, extend respawn delay to prevent chaining telefrags
		self.respawn_time = self.respawn_time + 2;

		return;
	}
		
	if (random() < 0.5)
		sound (self, #CHAN_VOICE, "player/gib.wav", 1, #ATTN_NONE);
	else
		sound (self, #CHAN_VOICE, "player/udeath.wav", 1, #ATTN_NONE);
};

void() PlayerDie =
{
	local float	 i;
	local entity te;
	
    // make dead guy release hook (wedge)
    if (self.hook_out)
    {
	    Reset_Grapple (self.hook);
    	Attack_Finished(0.75);
	    self.hook_out = #TRUE;	// PutClientInServer will reset this
    }

	self.items = self.items - (self.items & #IT_INVISIBILITY);
	self.invisible_finished = 0;	// don't die as eyes
	self.invincible_finished = 0;
	self.super_damage_finished = 0;
	self.radsuit_finished = 0;
	self.modelindex = modelindex_player;	// don't use eyes

	// If infected, give the medic a frag
	if (self.tfstate & #TFSTATE_INFECTED && self == self.enemy)
	{
		te = find(world, classname, "timer");
		while (te)
		{
			if (te.owner == self && te.think == BioInfection_Decay)
			{
			#ifdef QUAKE_WORLD
				logfrag(te.enemy, self);
			#endif
				te.enemy.real_frags = te.enemy.real_frags + 1;
			 	if (!(toggleflags & #TFLAG_TEAMFRAGS))
					te.enemy.frags = te.enemy.real_frags;
			}

			te = find(te, classname, "timer");
		}
	}

	// Remove all the timer entities for this player
	TeamFortress_RemoveTimers();

	// Restore player's speed
#ifdef RESTORE_DEAD_SPEEDS
	stuffcmd(self,"cl_backspeed 1000\n");
	stuffcmd(self,"cl_forwardspeed 1000\n");
	stuffcmd(self,"cl_sidespeed 1000\n");
	stuffcmd(self,"cl_movespeedkey 2\n");
#endif

	if (deathmatch || coop)
		DropBackpack();
	
	self.weaponmodel="";
	self.view_ofs = '0 0 -8';
	self.deadflag = #DEAD_DYING;
	self.solid = #SOLID_NOT;
	self.flags = self.flags - (self.flags & #FL_ONGROUND);
	self.movetype = #MOVETYPE_TOSS;

	if (self.velocity_z < 10)
		self.velocity_z = self.velocity_z + random()*300;
	if (self.health < -40)
	{
		GibPlayer ();
		return;
	}

	DeathSound();
	
	self.angles_x = 0;
	self.angles_z = 0;

	if (self.current_weapon <= #WEAP_AXE)
	{
		player_die_ax1 ();
		TeamFortress_SetupRespawn(#FALSE);
		return;
	}

	i = 1 + floor(random()*6);
	
	if (i == 1)
		player_diea1();
	else if (i == 2)
		player_dieb1();
	else if (i == 3)
		player_diec1();
	else if (i == 4)
		player_died1();
	else
		player_diee1();
	
	// get ready to spawn!
	TeamFortress_SetupRespawn(#FALSE);
};

void() set_suicide_frame =
{	// used by kill command and diconnect command
	if (self.model != "progs/player.mdl")
		return;	// allready gibbed

/*
	self.frame = $deatha11;
	self.solid = #SOLID_NOT;
	self.movetype = #MOVETYPE_TOSS;
	self.deadflag = #DEAD_DEAD;
	self.nextthink = -1;
*/
	setmodel(self, string_null);
	setsize (self, #VEC_HULL_MIN, #VEC_HULL_MAX);
};


void()	player_diea1	=	[	$deatha1,	player_diea2	] {};
void()	player_diea2	=	[	$deatha2,	player_diea3	] {};
void()	player_diea3	=	[	$deatha3,	player_diea4	] {};
void()	player_diea4	=	[	$deatha4,	player_diea5	] {};
void()	player_diea5	=	[	$deatha5,	player_diea6	] {};
void()	player_diea6	=	[	$deatha6,	player_diea7	] {};
void()	player_diea7	=	[	$deatha7,	player_diea8	] {};
void()	player_diea8	=	[	$deatha8,	player_diea9	] {};
void()	player_diea9	=	[	$deatha9,	player_diea10	] {};
void()	player_diea10	=	[	$deatha10,	player_diea11	] {};
void()	player_diea11	=	[	$deatha11,	player_diea11 ] {PlayerDead();};

void()	player_dieb1	=	[	$deathb1,	player_dieb2	] {};
void()	player_dieb2	=	[	$deathb2,	player_dieb3	] {};
void()	player_dieb3	=	[	$deathb3,	player_dieb4	] {};
void()	player_dieb4	=	[	$deathb4,	player_dieb5	] {};
void()	player_dieb5	=	[	$deathb5,	player_dieb6	] {};
void()	player_dieb6	=	[	$deathb6,	player_dieb7	] {};
void()	player_dieb7	=	[	$deathb7,	player_dieb8	] {};
void()	player_dieb8	=	[	$deathb8,	player_dieb9	] {};
void()	player_dieb9	=	[	$deathb9,	player_dieb9	] {PlayerDead();};

void()	player_diec1	=	[	$deathc1,	player_diec2	] {};
void()	player_diec2	=	[	$deathc2,	player_diec3	] {};
void()	player_diec3	=	[	$deathc3,	player_diec4	] {};
void()	player_diec4	=	[	$deathc4,	player_diec5	] {};
void()	player_diec5	=	[	$deathc5,	player_diec6	] {};
void()	player_diec6	=	[	$deathc6,	player_diec7	] {};
void()	player_diec7	=	[	$deathc7,	player_diec8	] {};
void()	player_diec8	=	[	$deathc8,	player_diec9	] {};
void()	player_diec9	=	[	$deathc9,	player_diec10	] {};
void()	player_diec10	=	[	$deathc10,	player_diec11	] {};
void()	player_diec11	=	[	$deathc11,	player_diec12	] {};
void()	player_diec12	=	[	$deathc12,	player_diec13	] {};
void()	player_diec13	=	[	$deathc13,	player_diec14	] {};
void()	player_diec14	=	[	$deathc14,	player_diec15	] {};
void()	player_diec15	=	[	$deathc15,	player_diec15 ] {PlayerDead();};

void()	player_died1	=	[	$deathd1,	player_died2	] {};
void()	player_died2	=	[	$deathd2,	player_died3	] {};
void()	player_died3	=	[	$deathd3,	player_died4	] {};
void()	player_died4	=	[	$deathd4,	player_died5	] {};
void()	player_died5	=	[	$deathd5,	player_died6	] {};
void()	player_died6	=	[	$deathd6,	player_died7	] {};
void()	player_died7	=	[	$deathd7,	player_died8	] {};
void()	player_died8	=	[	$deathd8,	player_died9	] {};
void()	player_died9	=	[	$deathd9,	player_died9	] {PlayerDead();};

void()	player_diee1	=	[	$deathe1,	player_diee2	] {};
void()	player_diee2	=	[	$deathe2,	player_diee3	] {};
void()	player_diee3	=	[	$deathe3,	player_diee4	] {};
void()	player_diee4	=	[	$deathe4,	player_diee5	] {};
void()	player_diee5	=	[	$deathe5,	player_diee6	] {};
void()	player_diee6	=	[	$deathe6,	player_diee7	] {};
void()	player_diee7	=	[	$deathe7,	player_diee8	] {};
void()	player_diee8	=	[	$deathe8,	player_diee9	] {};
void()	player_diee9	=	[	$deathe9,	player_diee9	] {PlayerDead();};

void()	player_die_ax1	=	[	$axdeth1,	player_die_ax2	] {};
void()	player_die_ax2	=	[	$axdeth2,	player_die_ax3	] {};
void()	player_die_ax3	=	[	$axdeth3,	player_die_ax4	] {};
void()	player_die_ax4	=	[	$axdeth4,	player_die_ax5	] {};
void()	player_die_ax5	=	[	$axdeth5,	player_die_ax6	] {};
void()	player_die_ax6	=	[	$axdeth6,	player_die_ax7	] {};
void()	player_die_ax7	=	[	$axdeth7,	player_die_ax8	] {};
void()	player_die_ax8	=	[	$axdeth8,	player_die_ax9	] {};
void()	player_die_ax9	=	[	$axdeth9,	player_die_ax9	] {PlayerDead();};

void() Headless_Think =
{
	self.frame = self.frame + 1;

	if (self.frame == 7 || self.frame == 18)
	{
		self.nextthink = time + 10 + random()*10;
		self.think = SUB_Remove;
		return;
	}
	
	self.nextthink = time + 0.1;
};