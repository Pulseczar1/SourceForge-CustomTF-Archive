/*======================================================
	JOBS.QC			Custom TeamFortress v3.2SB1

	(c) William Kerney			2/9/00
	(c) SB-1 Tech				25/10/00
========================================================
Functions for handling the custom class professions
======================================================*/

//WK - all of this

void() DropToCustomClassGen; //Called when starting class generation
void() DropFromCustomClassGen; //Called when finished class generation
void() PrintMoney;
void(float in) PrintRefund;
void(float in) PrintNotEnoughMoney;
void(float cost, float type) BuyItem;
void(float cost, float type) BuyJob;
/*void(float cost, float type) BuyGren1;
void(float cost, float type) BuyGren2;*/
void() FragGrenadeTouch;
void() FragGrenadeExplode;
void() KracGrenadeTouch;
void() KracGrenadeExplode;
void(entity bastard,float threshold) createBastard;
void() UseJobSkill; //Function for handling professions
void (entity targ,float pain) RevealThief;


//Extern
void (vector org, entity death_owner) spawn_tdeath;
//void (string gib, float health) ThrowGib;
void(string gibname, float dm, float makecool, float gibskin, float gibkgs, float randorg) ThrowGib;
float() W_BestWeapon;
void() W_SetCurrentAmmo;
void(entity p) TeamFortress_SetSpeed;
void(entity p) TeamFortress_SetSkin;
void () BecomeExplosion;
void(entity bomb, entity attacker, float rad, entity ignore) T_RadiusDamage;
void() SUB_regen;
float modelindex_eyes, modelindex_player, modelindex_null;
void(float inAuto) W_FireMedikit;
void(float inAuto) TeamFortress_ID;
void(float range,float inAuto) TeamFortress_Scan;
void(float points, float type) custom_demon_create;
void() kill_my_demons;
void() player_assaultcannondown1;
void (entity rhook) Reset_Grapple;
/*void (string temp) DebugSprint;
void (float temp)  DebugSprintFloat;*/
void() TeamFortress_RegenerateCells; // for thief

//- OfN Cyber Interface is now a job itself
//---- OfN
void(entity mine_owner) DetonateMines;
float(entity thing) IsMonsterNonArmy;
float(entity thing) IsMonster; // for mines
void() JobArmy;
void() JobHacker;

void(entity player) ArmyInit;

//==================================================================
// Functions to handle extras on army and warlock jobs (by now)

float(entity player) GetJobExtras =
{
    if (player.job & #JOB_EXTRA1)
    {
        if (player.job & #JOB_EXTRA2)
            return 3; // For future extra item

        return 1;
    }

    if (player.job & #JOB_EXTRA2)
        return 2;

    return 0;
};

void(entity player, float extras) SetJobExtras =
{
    if (!extras)
    {
        player.job = player.job - (player.job & (#JOB_EXTRA1 | #JOB_EXTRA2));
        return;
    }

    if (extras == 1)
    {
        player.job = player.job - (player.job & #JOB_EXTRA2);
        player.job = player.job | #JOB_EXTRA1;
        return;
    }

    if (extras == 2)
    {
        player.job = player.job - (player.job & #JOB_EXTRA1);
        player.job = player.job | #JOB_EXTRA2;
        return;
    }

    if (extras == 3) // Unused by now
    {
        player.job = player.job | #JOB_EXTRA2 | #JOB_EXTRA1;
        return;
    }
};

//
//	Functions for handling our "professions"
//	which add some class-like behavior to this
//	unclassy version of TF
//

/*
** Thief Profession -
** Hides in shadows, can become fully hidden, leaves shadows if attacks or attacked
*/
void() JobThief =
{
	// don't hide if we are looking down our scope.
	local entity sniperdot;

	sniperdot = find(world, classname, "timer");

	while(sniperdot) {
		if(sniperdot.netname == "sniperdot" && sniperdot.owner == self) {
			return;
		}
		sniperdot = find(sniperdot, classname, "timer");
	}

	//local float vel;
	local entity te;
	//local string st;
	if (self.job & #JOB_ACTIVE) { //We are hiding
		//If we hit "skill" again and we are moving, we leave shadows
		//vel = vlen(self.velocity);
		/*if (vel > 100) { //Leave shadows
		//	sprint(self,#PRINT_HIGH,"Leaving shadows...\n");
		//}
		else { //Become fully hidden
			//RJM - Can't hide while carrying flags.
			if (self.effects & (#EF_DIMLIGHT | #EF_BRIGHTLIGHT)) {
				sprint(self,#PRINT_HIGH,"Not while glowing, idiot.\n");
				return;
			}
			sprint(self,#PRINT_HIGH,"You are fully hidden\n");
			self.frame = 0;
			self.weaponframe = 0;
			self.modelindex = modelindex_null;
			self.job = self.job | #JOB_FULL_HIDE;
		} */
		sprint(self, #PRINT_HIGH, "??????? ???????...\n");
		self.modelindex = modelindex_player;
		self.job = self.job - #JOB_ACTIVE;
		self.job = self.job - (self.job & #JOB_FULL_HIDE);
		self.job_finished = time + 2;
		TeamFortress_SetSpeed(self);
	}
	/*else if (self.job & #JOB_FULL_HIDE) {
		RevealThief(self,#FALSE);
	} */
	else { //Start hiding
		//RJM - Can't hide while carrying flags.
		//WK  - Allow them to go eyes invisible but not full hide
		/*
		if (self.effects & (#EF_DIMLIGHT | #EF_BRIGHTLIGHT)) {
			sprint(self, #PRINT_HIGH, "Not while glowing, gimp.\n");
			return;
		}
		*/
		sprint(self,#PRINT_HIGH,"???????? ???????...\n");
		self.frame = 0;
		self.weaponframe = 0;
		self.modelindex = modelindex_eyes;
		self.job = self.job | #JOB_ACTIVE;
		self.job_finished = time + 2;
		TeamFortress_SetSpeed(self);

		te = spawn();
		te.nextthink = time + #PC_SPY_CELL_REGEN_TIME;
		te.think = TeamFortress_RegenerateCells;
		te.owner = self;
		te.classname = "timer";
	}
};



/*
** Runner Profession -
** Sprints at +200 speed for a while, then has to rest (half speed)
*/
#define PHASE1 5
#define PHASE2 5
#define PHASE3 5
void() RunnerThink =
{
	self.heat = self.heat + 1;
	if (self.heat == 1) { //Initial Phase
		sprint(self.owner,#PRINT_HIGH,"Sprinting...\n");
		TeamFortress_SetSpeed(self.owner);
		self.nextthink = time + #PHASE1;
	}
	else if (self.heat == 2) {
		sprint(self.owner,#PRINT_HIGH,"Recovering...\n");
		self.owner.job = self.owner.job | #JOB_TIRED;
		TeamFortress_SetSpeed(self.owner);
		self.nextthink = time + #PHASE2;
	}
	else if (self.heat == 3) {
		self.owner.job = self.owner.job - (self.owner.job & #JOB_ACTIVE);
		self.owner.job = self.owner.job - (self.owner.job & #JOB_TIRED);
		TeamFortress_SetSpeed(self.owner);
		self.nextthink = time + #PHASE3;
	}
	else {
		dremove(self);
	}
};
void() JobRunner =
{
	local entity RunnerTimer;

	self.job = self.job | #JOB_ACTIVE; //Timer will remove this

	RunnerTimer = spawn ();
	RunnerTimer.classname = "timer";
	RunnerTimer.owner = self;
	RunnerTimer.nextthink = time + 0.5; //Small delays are cool
	RunnerTimer.think = RunnerThink;
	RunnerTimer.heat = 0;
	self.job_finished = time + #PHASE1 + #PHASE2 + #PHASE3 + 0.6;
};





void() JobWarlock =
{
	if (self.attack_finished > time)
	{
		sprint(self,#PRINT_HIGH,"You can't shoot and summon at the same time\n");
		self.job_finished = time + 2;
		return;
	}

    if (self.current_menu == #MENU_DEMON)
    {
        Menu_Demon_Input(7);
        return;
    }

	self.current_menu = #MENU_DEMON;
	self.menu_count = #MENU_REFRESH_RATE;
};

/*
** Chaplan Profession -
** Dispels demons, inspires teammates to do x2 damage, but can't attack himself
** Timer triggers every so often, checking to see if you want to resume inspire
*/
#define GUIDE_TIME 1 //Period of how often lightning guides are shown. Must be less than...
#define CHAPLAN_TIME 1 //Period of seconds how often it fires
#define INSPIRE_TIME 6 //How long someone stays inspired
#define CHAPLAN_RADIUS 320 //About the radius of brightglow
#define CHAPLAN_HEAL 50    //If you have a medikit you'll heal friends this much
#define CHAPLAN_HEAL_DELAY 3 //You can't have been shot in last three seconds to be healed

//Hunt for all friendlies and power them up
//Take special care to coexist with Quad damage
void() ChaplanInspire = {
	local entity head;
	local float take;
	head = findradius(self.origin, #CHAPLAN_RADIUS);

	while (head)
	{
		//Dispel enemy demons
		//- OfN - if (head.classname == "monster_demon1" || head.classname == "monster_shambler")
        if (IsMonsterNonArmy(head))
		{ //No short circuit evaluation, so...
		      if (!Teammate(head.real_owner.team_no,self.team_no))
		      { //...to avoid a crash from deref
				/*if ((head.health <= 200 && head.classname == "monster_demon1") || head.health < 500 && head.classname == "monster_shambler") {
					sprint(self,#PRINT_HIGH,"You dispel a demon\n");
					self.real_frags = self.real_frags + 1;
	 				if (!(toggleflags & #TFLAG_TEAMFRAGS))
						self.frags = self.real_frags;
				}
				if (head.classname == "monster_shambler")
					TF_T_Damage(head, self, self, 500, 0, 0);
				else if (head.classname == "monster_demon1")
					TF_T_Damage(head, self, self, 200, 0, 0);*/
                TF_T_Damage(head, self, self, 220, 0, 0); // OfN
			}
		}
		else if (head.classname == "player" &&	//Person who is...
               head.health > 0 && // OfN Alive
			   Teammate(head.team_no,self.team_no) && //Same Team
			   head != self &&			//Not me
			   !(head.is_undercover)  &&		//Not a spy
			   !(head.job & #JOB_CHAPLAN)  &&	//Not a chaplan
			   head.playerclass != #PC_CIVILIAN &&  //KK
			   //... and not Quadded
			   !(head.items & #IT_QUAD && !(head.tfstate & #TFSTATE_INSPIRED))
			)
		{
			head.items = head.items | #IT_QUAD;
			head.inspirator = self; //We are their designated preacherman
			head.super_time = 1;
			if (head.super_damage_finished < time + #INSPIRE_TIME)
				head.super_damage_finished = time + #INSPIRE_TIME;
			head.tfstate = head.tfstate | #TFSTATE_INSPIRED;
			//Heal them if we have automedic too
			//SB amended to medikit since there is no automedic now
			if ((self.weapons_carried & #WEAP_MEDIKIT) && (self.last_attacked_time < time + #CHAPLAN_HEAL_DELAY)) {
				take = head.max_health - head.health;
				if (take > #CHAPLAN_HEAL) take = #CHAPLAN_HEAL;
				if (take < 0) take = 0;
				head.health = head.health + take;
			}
		}
		head = head.chain;
	}

};


//Draws lightning bolts towards all the friendlies we're inspiring
//entity(entity start, .string fld, string match) find = #18;
void() ChaplanGuides = {
	local entity head;
	head = find(world,classname,"player");
	while (head) {
		if (head.inspirator == self) {
			// Create the Lightning
			msg_entity = self;
			WriteByte (#MSG_ONE, #SVC_TEMPENTITY);
			WriteByte (#MSG_ONE, #TE_LIGHTNING1);
			WriteEntity (#MSG_ONE, self);
			WriteCoord (#MSG_ONE, self.origin_x);
			WriteCoord (#MSG_ONE, self.origin_y);
			WriteCoord (#MSG_ONE, self.origin_z + 8);
			WriteCoord (#MSG_ONE, head.origin_x);
			WriteCoord (#MSG_ONE, head.origin_y);
			WriteCoord (#MSG_ONE, head.origin_z + 8);
			head = world;
		}
		else //We can only draw one lightning. :p
			head = find(head,classname,"player");
	}
};

void() ChaplanThink = {
	local entity oself;
	//local string temp; //REMOVEME
	oself = self;
	self = self.owner;

	ChaplanGuides();
	oself.nextthink = time + #GUIDE_TIME;
	oself.frags = oself.frags + #GUIDE_TIME;
	if (oself.frags >= #CHAPLAN_TIME) { //Do the full thing every second
		oself.frags = 0;
		if (self.heat == #TRUE) { //Inspire everyone again
			//sprint(self,#PRINT_HIGH,"Chaplan: Still Preaching\n");
			ChaplanInspire();
		}
		else { //We stopped preaching
			sprint(self,#PRINT_HIGH,"You finish your sermon\n");
			//Sync CHAN_MUSIC with disconnect and sound below
			self.job = self.job - (self.job & #JOB_ACTIVE);
			//sound (self, #CHAN_MUSIC, "items/r_item1.wav", 0.1, #ATTN_NORM);
			sound (self, #CHAN_MUSIC, "misc/null.wav", 0.1, #ATTN_NORM);
            self.effects = self.effects - (self.effects & #EF_BRIGHTLIGHT);
			//self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_RELOADING);
			self.current_weapon = self.weapon;
			W_SetCurrentAmmo();
			oself.nextthink = time + 0.1;
			oself.think = SUB_Remove;
		}
	}
	self = oself;
};

void() JobChaplan =
{
	local entity tWeapon;
	if (self.job & #JOB_ACTIVE) {
		//self.job = self.job - #JOB_ACTIVE;
		if (self.heat == #TRUE) //Only print this once
			sprint(self,#PRINT_HIGH,"You gradually stop preaching...\n");
		self.heat = #FALSE; //Bad to turn off active, since technically job is still on.
		self.job_finished = time + 0.7; //Don't allow them to trigger too often
		return;
	}
	if (self.tfstate & #TFSTATE_RELOADING || self.is_feigning || self.heat) {
		sprint(self,#PRINT_HIGH,"You can't preach while doing other stuff\n");
		self.job_finished = time + 0.5; //Don't allow them to trigger too often
		return;
	}

	sprint(self,#PRINT_HIGH,"You begin preaching. Hit skill again to stop.\n");
	tWeapon = spawn();
	tWeapon.frags = 0; //Clear guides counter
	tWeapon.owner = self;
	tWeapon.classname = "timer";
	tWeapon.nextthink = time + #GUIDE_TIME;
	tWeapon.think = ChaplanThink;
	self.job = self.job | #JOB_ACTIVE;
	self.job_finished = time + 0.3; //Don't allow them to trigger too often

	//Hide our weapon. Can't shoot while preaching.
	self.weapon = self.current_weapon;
	self.current_weapon = 0;
	self.weaponmodel = "";
	self.weaponframe = 0;
	self.heat = #TRUE; //We're actively preaching.
	//self.tfstate = self.tfstate | #TFSTATE_RELOADING;

	//Start playing preacher music, glow and inspire!
	//sound (self, #CHAN_VOICE, "ambience/orff.wav", 0.75, #ATTN_NORM);
	sound (self, #CHAN_MUSIC, "ambience/orff.wav", 0.75, #ATTN_NORM);
	self.effects = self.effects | #EF_BRIGHTLIGHT;
	ChaplanInspire();
};



/*
** Martyr Proficiency -
** Becomes invincible, but dies after a few seconds
*/
#define MARTYR_TIME 3.5
void() MartyrThink =
{
	//Self.owner is the guy who became a martyr
	//local entity oself;

	//Clean these up so we can kill him
	//self.job = self.job - (self.job & #JOB_ACTIVE);
	self.owner.items = self.items - (self.items & #IT_INVULNERABILITY);
	self.owner.invincible_time = 0;
	self.owner.invincible_finished = 0;
	self.owner.effects = self.owner.effects - (self.owner.effects & #EF_DIMLIGHT);

	//if (self.owner.martyr_enemy == self.owner)
		deathmsg = #DMSG_MARTYR;
	//else
	//	deathmsg = self.owner.stored_deathmsg;
	                                                                                          //- OfN was 20
	TF_T_Damage(self.owner, self.owner.martyr_enemy, self.owner.martyr_enemy, self.owner.health + 20, #TF_TD_IGNOREARMOUR, #TF_TD_OTHER);

	self.think = SUB_Remove;
	self.nextthink = time + 0.1;
};

// SB I'll leave this here since it's still close to a job
void() JobMartyr =
{
	local entity tWeapon;
	local float martyr_time;

	if (self.is_abouttodie)
		return;

	martyr_time = #MARTYR_TIME; // don't need FORCED stuff since it's always automatic

	sprint(self,#PRINT_HIGH,"Beginning your suicide run...\n");
	self.items = self.items | #IT_INVULNERABILITY;
	self.invincible_time = 1;
	self.invincible_finished = time + martyr_time + 1; //Overlap so we can't die till end
	//self.job = self.job | #JOB_ACTIVE;
	//self.job_finished = time + martyr_time + 1;

	tWeapon = spawn();
	tWeapon.owner = self;
	tWeapon.classname = "timer";
	tWeapon.nextthink = time + martyr_time;
	tWeapon.think = MartyrThink;
};

/* Berserker Profession -
** A simple soul that just likes killing things
** Takes 50 self inflicted damage and gets Quad for 5 seconds
** If he can't pay up with the 50 health he gets reduced to 1 and dies after his 5 seconds
*/

// now takes #BERSERKER_HP_COST hp

#define BERSERK_TIME 4

void() BerserkerKillTimer =
{
	if (!self.tfstate & #TFSTATE_CONCUSSIONED)
		stuffcmd(self.owner, "v_idlescale 0\n");

	if (self.has_sensor)
	{
		deathmsg = #DMSG_BERSERK;
		TF_T_Damage(self.owner, self.owner, self.owner, self.owner.health, #TF_TD_IGNOREARMOUR, #TF_TD_OTHER);
	}


    self.job = self.job - (self.job & #JOB_ACTIVE); //- OfN
    self.owner.is_abouttodie = #FALSE;
	dremove(self);
};

void() JobBerserker =
{
	if (self.super_damage_finished > 0)
		return;
	if (self.is_abouttodie)
		return;

	newmis = spawn();
	newmis.classname = "timer";
	newmis.nextthink = time + #BERSERK_TIME + 1;
	newmis.think = BerserkerKillTimer;
	newmis.owner = self;

	if (self.health > #BERSERKER_HP_COST)
		TF_T_Damage(self, self, self, #BERSERKER_HP_COST, #TF_TD_IGNOREARMOUR, #TF_TD_OTHER);
	else
	{
		self.health = 1;
		newmis.has_sensor = 1;
	}
	self.super_time = 1;
	self.super_damage_finished = time + #BERSERK_TIME + 1;
	self.items = self.items | #IT_QUAD;
	self.is_abouttodie = #TRUE;
    self.job = self.job | #JOB_ACTIVE; //- OfN
	self.job_finished = time + #BERSERK_TIME * 3;

	stuffcmd(self, "v_idlescale 30\n");
};


/*
** Judoka Profession -
** Disarms opponents so they cannot attack
*/
//This is guaranteed to be removed if either target or owner dies or disconnects
//So we don't have to do error checking on those situations
//Four special cases, Rifle, Medikit, AC and Grapple, have side effects
// when you remove them. Need special cases to handle their theft
#define DISARM_TIME 10
#define CANT_ATTACK_TIME 5
#define HIT_DELAY 8
#define MISS_DELAY 1
void() JudokaRearm =
{
	//Self.owner is the guy who had his weapon taken away
	//Self.enemy is the guy who took it away
	local entity oself,te;

	self.enemy.job = self.enemy.job - (self.enemy.job & #JOB_ACTIVE);
	if (self.heat == 1) { //We have their weapon
		////Fix feign while stolen
		self.enemy.weapon = 0;
		////Fix reloading
		te = find(world, netname, "reloadtimer");
		while (te != world)
		{
			if (te.classname == "timer" && te.owner == self.enemy) {
				oself = self;
				self = te;
				self.think();
				self = oself;
				te.think = SUB_Remove;
				te.nextthink = time + 0.1;
			}
			te = find(te, netname, "reloadtimer");
		}
		////Fix double weapons
		if (self.current_weapon == #WEAP_SNIPER_RIFLE) {
			self.owner.weapons_carried = self.owner.weapons_carried | #WEAP_AUTO_RIFLE;
			self.enemy.weapons_carried = self.enemy.weapons_carried - (self.enemy.weapons_carried & #WEAP_AUTO_RIFLE);
		}
		////Fix weird weapons
		if (self.current_weapon == #WEAP_ASSAULT_CANNON && self.enemy.current_weapon == #WEAP_ASSAULT_CANNON) {
			oself = self;
			self = self.enemy;
			stuffcmd(self, "v_idlescale 0\n");
			self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_CANT_MOVE);
			TeamFortress_SetSpeed(self);
			self.weaponframe = 0;
			self.count = 1;
			self.heat = 0;
			self.button0 = 0;
			self.fire_held_down = #FALSE;
			player_assaultcannondown1();
			self = oself;
		}
		if (self.current_weapon == #WEAP_HOOK && self.enemy.hook_out) {
			oself = self;
			self = self.enemy;
			Reset_Grapple (self.hook);
			self.weaponframe = 0;
			self = oself;
		}

		sprint(self.owner,#PRINT_HIGH,"You get your weapon back\n");
		self.owner.weapons_carried = self.owner.weapons_carried | self.current_weapon;

		sprint(self.enemy,#PRINT_HIGH,"You lose your stolen weapon\n");
		self.enemy.weapons_carried = self.enemy.weapons_carried - (self.enemy.weapons_carried & self.current_weapon);
		//Fix for a bug that would let someone keep their weapon if they switched to autorifle before
		//the weapon returned.
		if (self.enemy.current_weapon == self.current_weapon || self.current_weapon == #WEAP_SNIPER_RIFLE || self.current_weapon == #WEAP_MEDIKIT) {
			oself = self;
			self = self.enemy;
			self.weaponframe = 0;
			self.current_weapon = W_BestWeapon ();
			W_SetCurrentAmmo();
			self = oself;
		}
		//TODO: Is this really a Fix for diving?
		//Should we even do this? Might cause firing skip. Evaluate
		self.enemy.weaponframe = 0;
	}

	self.think = SUB_Remove;
	self.nextthink = time + 0.1;
};
void() JobJudoka =
{
	//Take the weapon of any person in front of you and force a reload
	self.job_finished = time + #MISS_DELAY; //Delay if we don't hit
	local vector	source;
	local entity tWeapon,oself;
	local entity te;

	makevectors(self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*96, #TL_ANY_SOLID, self);
	if (trace_fraction == 1.0) {
		sprint (self, #PRINT_HIGH, "You miss.\n");
		return;
	}


    if (trace_ent)
    if (trace_ent.classname == "player")
    if (trace_ent.#runes & #RUNE_RESIS || trace_ent.invincible_finished > time)
    {
        sprint (self, #PRINT_HIGH, "He is protected with a misterious power!\n");
        return;
    }

	if (trace_ent.classname == "player" && !Teammate(trace_ent.team_no, self.team_no) && trace_ent.playerclass != #PC_UNDEFINED)
	{
		if (self.is_undercover) //Taking someone's weapon should give you away
			Spy_RemoveDisguise(self);

		sprint (trace_ent, #PRINT_HIGH, "You have been disarmed by ");
		sprint (trace_ent, #PRINT_HIGH, self.netname);
		sprint (trace_ent, #PRINT_HIGH, "\n");

		self.job = self.job | #JOB_ACTIVE;
		//Simplify the dual-weapon problem
		if (trace_ent.current_weapon == #WEAP_AUTO_RIFLE)
			trace_ent.current_weapon = #WEAP_SNIPER_RIFLE;

		//If already reloading, remove that timer
		te = find(world, netname, "reloadtimer");
		while (te != world)
		{
			if (te.classname == "timer" && te.owner == trace_ent) {
				oself = self;
				self = te;
				self.think();
				self = oself;
				te.think = SUB_Remove;
				te.nextthink = time + 0.1;
			}
			te = find(te, netname, "reloadtimer");
		}

		tWeapon = spawn();
		tWeapon.owner = trace_ent;
		tWeapon.enemy = self;
		tWeapon.current_weapon = trace_ent.current_weapon;
		tWeapon.classname = "timer";
		tWeapon.netname = "judokatimer";
		tWeapon.nextthink = time + #DISARM_TIME;
		tWeapon.think = JudokaRearm;

		//Remove the weapon
		trace_ent.attack_finished = time + #CANT_ATTACK_TIME;
		trace_ent.weaponmodel = string_null;
		trace_ent.weaponframe = 0;
		trace_ent.currentammo = 0;


		if ((trace_ent.job & #JOB_JUDOKA && trace_ent.job_finished > time) || trace_ent.current_weapon == 0) {
			//Hit fellow judoka or chaplan
			sprint (self, #PRINT_HIGH, "You throw him with a mighty Seoi Otoshi\n");
			deathmsg = #DMSG_JUDOKA;
			TF_T_Damage (trace_ent, self, self, 150, #TF_TD_NOTTEAM, #TF_TD_OTHER);
		}
		else if (self.weapons_carried & trace_ent.current_weapon) {
			sprint (self, #PRINT_HIGH, "You knock his weapon out of his hands\n");
			tWeapon.heat = 0; //I.e., we didn't take a weapon
			trace_ent.attack_finished = time + #DISARM_TIME;
			deathmsg = #DMSG_JUDOKA;
			TF_T_Damage (trace_ent, self, self, 100, #TF_TD_NOTTEAM, #TF_TD_OTHER);
		}
		else if (trace_ent.current_weapon != 0 && trace_ent.current_weapon != #WEAP_AXE){
			//Steal their weapon if they have one
			sprint (self, #PRINT_HIGH, "You rip his weapon from his hands!\n");
			tWeapon.heat = 1;

			//Fix double weapons
			if (trace_ent.current_weapon == #WEAP_SNIPER_RIFLE) {
				self.weapons_carried = self.weapons_carried | #WEAP_AUTO_RIFLE;
				trace_ent.weapons_carried = trace_ent.weapons_carried - (trace_ent.weapons_carried & #WEAP_AUTO_RIFLE);
			}
			if (trace_ent.current_weapon == #WEAP_MEDIKIT) {
				self.health = self.max_health; //You heal yourself. :)
			}
			////Fix weird weapons
			if (trace_ent.current_weapon == #WEAP_ASSAULT_CANNON) {
				oself = self;
				self = trace_ent;
				stuffcmd(self, "-attack;v_idlescale 0\n");
				self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_CANT_MOVE);
				TeamFortress_SetSpeed(self);
				self.weaponframe = 0;
				self.count = 1;
				self.heat = 0;
				self.button0 = 0;
				self.fire_held_down = #FALSE;
				player_assaultcannondown1();
				self = oself;
			}
			if (trace_ent.current_weapon == #WEAP_HOOK && trace_ent.hook_out) {
				oself = self;
				self = trace_ent;
				Reset_Grapple (self.hook);
				self = oself;
			}

			self.weapons_carried = self.weapons_carried | trace_ent.current_weapon;
			self.current_weapon = trace_ent.current_weapon;
			W_SetCurrentAmmo();

			trace_ent.weapons_carried = trace_ent.weapons_carried - (trace_ent.weapons_carried & trace_ent.current_weapon);
			trace_ent.current_weapon = 0;

			deathmsg = #DMSG_JUDOKA;
			TF_T_Damage (trace_ent, self, self, 65, #TF_TD_NOTTEAM, #TF_TD_OTHER);
		}

		self.job_finished = time + #HIT_DELAY;
	}
	else
		sprint (self, #PRINT_HIGH, "You miss.\n");
};

void() JobCrusader;
void() JobGuerilla;

void() UseJobSkill =
{
	local float myjob;
	//local string sx,sy,sz;

	//Make sure they can do it
	if (self.done_custom & #CUSTOM_BUILDING) return;
	if (self.job_finished > time) return;

    // OfN - Psionized guys can't use skill
    if (self.tfstate & #TFSTATE_PSIONIZED)
    {
        sprint(self,#PRINT_HIGH,"You hardly can do anything psionized!\n");
        self.job_finished = time + 1;
        return;
    }

	myjob = self.job;
	if (myjob & #JOB_THIEF)
		JobThief();
	else if (myjob & #JOB_RUNNER)
		JobRunner();
	else if (myjob & #JOB_WARLOCK)
	{
		if (HasFlag(self.team_no) == #FALSE)
		{
			CenterPrint(self, "No demons until your team has the flag!\n");
			return;
		}
		JobWarlock();
	}
	else if (myjob & #JOB_CHAPLAN)
		JobChaplan();
	else if (myjob & #JOB_BERSERKER)
		JobBerserker();
	else if (myjob & #JOB_GUERILLA)
		JobGuerilla();
	else if (myjob & #JOB_JUDOKA)
		JobJudoka();
   	else if (myjob & #JOB_HACKER)
		JobHacker();
    else if (myjob & #JOB_MARTYR)
		JobMartyr();
    else if (myjob & #JOB_ARMY)
		JobArmy();
    else if (myjob & #JOB_CRUSADER)
		JobCrusader();
	else {
		sprint(self,#PRINT_HIGH,"You don't have a job. Go get employed.\n");
		self.job_finished = time + 5; //Don't let them print this message that often
	}
};

#define NOHIDE_TIME 8
#define EXPOSURE_NOHIDE_TIME 20
#define EXPOSURE_NORELOAD_TIME 7
#define FULLH_NORELOAD_TIME 1.5
void (entity targ, float pain) RevealThief = {
	if (targ.classname != "player") return;
	targ.modelindex = modelindex_player;
	if (pain) {
		sprint(targ,#PRINT_HIGH,"You have been uncovered!\n");
		targ.attack_finished = time + #EXPOSURE_NORELOAD_TIME;
		targ.job_finished = time + #EXPOSURE_NOHIDE_TIME;
	}
	else {
		sprint(targ,#PRINT_HIGH,"??????? ???????...\n");
		targ.job_finished = time + #NOHIDE_TIME;
		if (targ.job & #JOB_FULL_HIDE)
			targ.attack_finished = time + #FULLH_NORELOAD_TIME;
	}
	targ.job = targ.job - (targ.job & #JOB_FULL_HIDE);
	targ.job = targ.job - (targ.job & #JOB_ACTIVE);
	TeamFortress_SetSpeed(targ);
};

//===============================================================================
// Initializes any needed job stuff

void() InitJobStuff =
{
    // Abort if already initialized
    if (self.goal_activation) return;

    // Initialize respective jobs
    if (self.job & #JOB_ARMY)
        ArmyInit(self);
    else if (self.job & #JOB_GUERILLA)
        GuerillaInit(self);
    else
        return; // If nothing done just return

    // Set our "initialization done" flag to true
    self.goal_activation = #TRUE;
};

