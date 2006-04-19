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

enum {
	BOTH_DEATH1,
	BOTH_DEAD1,
	BOTH_DEATH2,
	BOTH_DEAD2,
	BOTH_DEATH3,
	BOTH_DEAD3,

	TORSO_GESTURE,

	TORSO_ATTACK,
	TORSO_ATTACK2,

	TORSO_DROP,
	TORSO_RAISE,

	TORSO_STAND,
	TORSO_STAND2,

	LEGS_WALKCR,
	LEGS_WALK,
	LEGS_RUN,
	LEGS_BACK,
	LEGS_SWIM,

	LEGS_JUMP,
	LEGS_LAND,

	LEGS_JUMPB,
	LEGS_LANDB,

	LEGS_IDLE,
	LEGS_IDLECR,
	LEGS_TURN,

	NUMANIMS
};

#define MAXMODELS 50	//if progs size becomes an issue, reduce this.

//a size optimisation.
#define anim_firstframe A
#define anim_numframes B
#define anim_loopingframes C
#define anum_framespersecond D

float anim_firstframe[NUMANIMS*MAXMODELS];
float anim_numframes[NUMANIMS*MAXMODELS];
float anim_loopingframes[NUMANIMS*MAXMODELS];
float anum_framespersecond[NUMANIMS*MAXMODELS];

float anim_sex[MAXMODELS];
string anim_name[MAXMODELS];

enum {
	SEX_NEUTER,
	SEX_MALE,
	SEX_FEMALE
};

float(string str) fileexists =
{
	local float search;
	search = search_begin(str, false, true);
	if (search < 0)
	{
		return false;
	}
	search_end(search);
	return true;
};


void(entity ent, string soundname) sexedsound =
{
	string str, full;
	if (self == player_local)
		if (cvar("cg_noselfsounds"))
			return;	//option to disable sounds from local player

	str = strcat("player/", anim_name[self.modelnum], "/", soundname);
	full = strcat("sound/", str);
	if (fileexists(full))
	{
		sound(self, CHAN_VOICE, str, 1, 1);
	}
	else
	{
		str = strcat("player/sarge/", soundname);	// :(
		sound(self, CHAN_VOICE, str, 1, 1);
	}
};

void(float anum) ForceToAnim =
{
	if (anum <= TORSO_STAND2)
	{
		self.torsoent.animnum = anum;
		self.torsoent.framechangetime = time;
	}
	if (anum <= BOTH_DEAD3 || anum >= LEGS_WALKCR)
	{
		self.legsent.animnum = anum;
		self.legsent.framechangetime = time;
	}
};

float(entity ent) animate =
{
//true if looped
	float anum;
	float ft;
	float fnum;
	float numframes;
	float fps;
	float firstframe;
	float loopingframes;
	float ret;

	anum = (ent.modelnum * NUMANIMS) + ent.animnum;

	ft = time - ent.framechangetime;
	numframes = anim_numframes[anum];
	fps = anum_framespersecond[anum];

	ft *= fps;
	fnum = floor(ft);
	ft = ft - fnum;	//time into the frame.
	if (fnum >= numframes)
	{
		loopingframes = anim_loopingframes[anum];

		if (loopingframes)
		{
			fnum -= numframes - loopingframes;
			fnum = fnum - floor(fnum/loopingframes)*loopingframes;
			fnum += numframes - loopingframes;
		}
		else
		{	//stop at the end of it.
			fnum = numframes-1;
			ft = 1;
		}

		if (numframes == 1)
			ent.frame2 = ent.frame;

		ret = true;
	}
	fnum += anim_firstframe[anum];

	if (ent.frame != fnum)
	{
		ent.frame2 = ent.frame;
		ent.frame = fnum;
	}
	ent.lerpfrac = 1-ft;
	if (!ent.lerpfrac)
		ent.frame2 = ent.frame;

	return ret;
};

.float wasinair;
void() LegsUpdateAnim =
{
	float inair;
	float onground;
	tracebox(self.origin, self.mins+'0 0 1', self.maxs- '0 0 1', self.origin-'0 0 2', FALSE, self);	//shrink the box a bit, so we're not so sensative to slopes and imprecision

	if (trace_fraction >= 1)
		inair = 1;

	if ((self.wasinair!=0) != (inair!=0))
	{
		if (trace_fraction >= 1)	//in air
		{
			if (self.velocity_z > 5)
			{
				makevectors(self.angles);
				if (v_forward * self.velocity >= 0)
					ForceToAnim(LEGS_JUMP);
				else
					ForceToAnim(LEGS_JUMPB);
			}
		}
		else
		{
			if (inair < -5 || self.wasinair < -5)
			{
				if (self.animnum == LEGS_JUMPB)
					ForceToAnim(LEGS_LANDB);
				else
					ForceToAnim(LEGS_LAND);
			}
		}
		self.wasinair = inair;
	}

	if (vlen(self.velocity) > 0.1)
	{
		if (self.legsent.animnum == LEGS_IDLE)
		{
			if (self.velocity * v_forward > 0)
				ForceToAnim(LEGS_RUN);
			else
				ForceToAnim(LEGS_BACK);
		}
	}
	else
	{
		if (self.legsent.animnum == LEGS_RUN || self.legsent.animnum == LEGS_BACK)
			ForceToAnim(LEGS_IDLE);
	}

	if (animate(self.legsent))
	{
		if (self.legsent.animnum <= BOTH_DEAD3)
		{
			return;	//don't play the idle anim when dead.
		}
		if (self.wasinair)
		{
			return;	//don't change the legs anim whilst flying.
		}

		if (self.velocity_x || self.velocity_y)
		{
			if (self.velocity * v_forward > 0)
				ForceToAnim(LEGS_RUN);
			else
				ForceToAnim(LEGS_BACK);
		}
		else
		{
			ForceToAnim(LEGS_IDLE);
		}

		animate(self.legsent);
	}
};

void() TorsoUpdateAnim =
{
	if (animate(self.torsoent))
	{
		if (self.frame >= $axdeth1 && self.frame <= $deathe9)
			return;	//dead.

		if (self.frame == $nailatt1 || self.frame == $nailatt2 ||
		    self.frame == $light1 || self.frame == $light2)
			ForceToAnim(TORSO_ATTACK);	//these ones loop
		else if (random() < 0.005 && !(self.velocity_x || self.velocity_y) && (chasecam || self != player_local))
		{	//randomly taunt, when standing still, when not first-person (making the sounds is just confusing when first person)
			sexedsound(self, "taunt.wav");
			ForceToAnim(TORSO_GESTURE);
		}
		else if ((self.frame >= $axrun1 && self.frame <= $axrun6) ||
			 (self.frame >= $axstnd1 && self.frame <= $axstnd12) ||
			 (self.frame >= $axpain1 && self.frame <= $axpain6))
			ForceToAnim(TORSO_STAND2);
		else
			ForceToAnim(TORSO_STAND);
		animate(self.legsent);
	}
};

void(entity ent) AddModelWithEffects =
{
	if (self.sveffects & SVE_INVIS)
		ent.forceshader = shaderforname("powerups/invisibility");

	addentity(ent);
	if (self.sveffects & SVE_QUAD)
	{
		ent.fatness = -2;
		ent.forceshader = shaderforname("powerups/quad");
		addentity(ent);
	}
	if (self.sveffects & SVE_GOD)
	{
		ent.fatness = -2;
		ent.forceshader = shaderforname("powerups/regen");
		addentity(ent);
	}
	ent.fatness = 0;
	ent.forceshader = 0;
};

.float ideal_yaw;
.float yaw_speed;
.float tag_index;
void() DrawPlayerModel =
{
	vector tf, tr, tu;
	vector ang;
	float move;
	string weaponname;

	self.modelindex = 0;	//should never have been anything else.


	if (player_local == self && !chasecam)	//reuse file as renderflags to use
	{
		//we still add the local player entity, although only to mirrors.
		self.legsent.renderflags = RF_USEAXIS|RF_EXTERNALMODEL;
		self.torsoent.renderflags = RF_USEAXIS|RF_EXTERNALMODEL;
		self.headent.renderflags = RF_USEAXIS|RF_EXTERNALMODEL;
		self.weaponent.renderflags = RF_USEAXIS|RF_EXTERNALMODEL;
	}
	else
	{
		self.legsent.renderflags = RF_USEAXIS;
		self.torsoent.renderflags = RF_USEAXIS;
		self.headent.renderflags = RF_USEAXIS;
		self.weaponent.renderflags = RF_USEAXIS;
	}

	if (!(self.frame >= $axdeth1 && self.frame <= $deathe9))
	{
		ang_y = self.angles_y;
		if (self.velocity_x||self.velocity_y)
		{
			makevectors(ang);
			tf = self.velocity;
			tf_z = 0;
			tf = normalize(tf);
			if (v_forward*tf > -0.01)
				self.legsent.ideal_yaw = vectoyaw(tf);
			else
				self.legsent.ideal_yaw = vectoyaw(tf)+180;
		}
		else
		{
			move = ang_y - self.legsent.ideal_yaw;
			if (move < -180)
				move += 360;
			if (move > 180)
				move -= 360;

			if (move*move > 30*30)
				ForceToAnim(LEGS_TURN);

			if (self.legsent.animnum == LEGS_TURN || self.legsent.animnum == LEGS_JUMP)
				self.legsent.ideal_yaw = ang_y;
		}
		other = self;
		self = self.legsent;
		self.yaw_speed = 5;
		ChangeYaw();
		self = other;
	}
	
	

	self.legsent.origin = self.origin;

	if (self.frame != self.frame2)
	{
	//see if the player changed to any animations.
		if (self.frame >= $axdeth1 && self.frame <= $axdeth8 && self.legsent.animnum != BOTH_DEATH1)
		{
			sexedsound(self, "death1.wav");
			ForceToAnim(BOTH_DEATH1);
		}
		else if (self.frame == $axdeth9 && self.frame2 != $axdeth8)
			ForceToAnim(BOTH_DEAD1);	//suddenly appeared with this frame (otherwise we just flow into it)

		else if (self.frame == $deatha1 && self.frame <= $deatha10 && self.legsent.animnum != BOTH_DEATH2)
		{
			sexedsound(self, "death2.wav");
			ForceToAnim(BOTH_DEATH2);
		}
		else if (self.frame == $deatha11 && self.frame2 != $deatha10)
			ForceToAnim(BOTH_DEAD2);	//suddenly appeared with this frame (otherwise we just flow into it)

		else if (self.frame == $deathb1 && self.frame <= $deathb8 && self.legsent.animnum != BOTH_DEATH3)
		{
			sexedsound(self, "death3.wav");
			ForceToAnim(BOTH_DEATH3);
		}
		else if (self.frame == $deathb9 && self.frame2 != $deathb8)
			ForceToAnim(BOTH_DEAD3);	//suddenly appeared with this frame (otherwise we just flow into it)

		else if (self.frame == $deathc1 && self.frame <= $deathc14 && self.legsent.animnum != BOTH_DEATH1)
		{
			sexedsound(self, "death1.wav");
			ForceToAnim(BOTH_DEATH1);
		}
		else if (self.frame == $deathc15 && self.frame2 != $deathc14)
			ForceToAnim(BOTH_DEAD1);	//suddenly appeared with this frame (otherwise we just flow into it)

		else if (self.frame == $deathd1 && self.frame <= $deathd8 && self.legsent.animnum != BOTH_DEATH2)
		{
			sexedsound(self, "death2.wav");
			ForceToAnim(BOTH_DEATH2);
		}
		else if (self.frame == $deathd9 && self.frame2 != $deathd8)
			ForceToAnim(BOTH_DEAD2);	//suddenly appeared with this frame (otherwise we just flow into it)

		else if (self.frame == $deathe1 && self.frame <= $deathe8 && self.legsent.animnum != BOTH_DEATH3)
		{
			sexedsound(self, "death3.wav");
			ForceToAnim(BOTH_DEATH3);
		}
		else if (self.frame == $deathe9 && self.frame2 != $deathe8)
			ForceToAnim(BOTH_DEAD3);	//suddenly appeared with this frame (otherwise we just flow into it)

		else if ((self.frame  == $nailatt1 || self.frame  == $nailatt2) &&
			 (self.frame2 != $nailatt1 && self.frame2 != $nailatt2))
			ForceToAnim(TORSO_ATTACK);
		else if ((self.frame  == $light1 || self.frame  == $light2) &&
			 (self.frame2 != $light1 && self.frame2 != $light2))
			ForceToAnim(TORSO_ATTACK);
		else if (self.frame == $rockatt1)
			ForceToAnim(TORSO_ATTACK);
		else if (self.frame == $shotatt1)
			ForceToAnim(TORSO_ATTACK);
		else if (self.frame == $axatt1)
			ForceToAnim(TORSO_ATTACK2);
		else if (self.frame == $axattb1)
			ForceToAnim(TORSO_ATTACK2);
		else if (self.frame == $axattc1)
			ForceToAnim(TORSO_ATTACK2);
		else if (self.frame == $axattd1)
			ForceToAnim(TORSO_ATTACK2);
		else if (self.frame2 >= $axdeth1 && self.frame2 <= $deathe9 && !(self.frame >= $axdeth1 && self.frame <= $deathe9))
		{	//respawned
			ForceToAnim(LEGS_IDLE);
			ForceToAnim(TORSO_STAND);
		}
		self.frame2 = self.frame;
	}

	makevectors(self.legsent.angles);
	v_forward = v_forward * 0.75;
	v_right = v_right * 0.75;
	v_up = v_up * 0.75;

	LegsUpdateAnim();
	TorsoUpdateAnim();

	self.legsent.alpha = self.torsoent.alpha = self.headent.alpha = self.weaponent.alpha = self.alpha;
	if (self.sveffects & SVE_QUAD)
		ang_z = 1;
	if (self.sveffects & SVE_GOD)
		ang_x = 1;
	ang_y = 0;
	if (ang != '0 0 0')
	{
		adddynamiclight(self.origin, 400, ang);
	}

	AddModelWithEffects(self.legsent);
	self.torsoent.origin = RotateVectorsByTag(self.legsent, self.torsoent.tag_index);//figure out the torso position
	ang = self.angles;
	ang_y = self.angles_y - self.legsent.angles_y;	//keep the angle on the legs
	ang_x*=2;
	if (self.legsent.animnum > BOTH_DEAD3)
		RotateVectorsByAngle(ang);	//rotate the torso
	AddModelWithEffects(self.torsoent);
	tf = v_forward;
	tr = v_right;
	tu = v_up;
	self.headent.origin = RotateVectorsByTag(self.torsoent, self.headent.tag_index);//
if (cvar("cg_nolook"))
{
	ang_y = 0;
	ang_x = 0;
}
else
{
	ang_y = sin(time)*22.5;
	ang_x = cos(time*0.4532)*11.25;
}

	if (self.legsent.animnum > BOTH_DEAD3)
		RotateVectorsByAngle(ang);	//make the head around a bit

	if (self == player_local && getserverinfo("*cheats")!="")
	if (cvar("cg_fromeyes"))
	{	//place the view where the eyes are. :)
		local vector org;
		org = RotateVectorsByTag(self.headent, gettagindex(self.weaponent, "tag_eyes"));
		org = org+v_forward*cvar("cg_forward");
		org = org+v_up*cvar("cg_up");
		org = org+v_right*cvar("cg_right");
		org_z += cvar("cg_vertical");
		setviewprop(VF_ORIGIN, org);
		if (cvar("cg_fromeyes")>1)
		{	//change the angles too.
			org = vectoangles(v_forward);
			org_x *= -1;
			setviewprop(VF_ANGLES, org);
		}
		self.headent.renderflags = RF_USEAXIS|RF_EXTERNALMODEL;
	}

	AddModelWithEffects(self.headent);

	if (self.frame >= $axdeth1 && self.frame <= $deathe9)
		return;	//don't show the weapon in death frames.

	move = self.sveffects&15;
	switch (move)
	{
	case 12:	//axe
		weaponname = "models/weapons2/gauntlet/gauntlet";
		break;
	default:
	case 0:	//shotgun
		weaponname = "models/weapons2/railgun/railgun";	//well... the sniper's prefered weapon, at least. :p
		break;
	case 1:	//super shotgun
		weaponname = "models/weapons2/shotgun/shotgun";
		break;
	case 2:	//nailgun
		weaponname = "models/weapons2/machinegun/machinegun";
		break;
	case 3:	//super nailgun
		weaponname = "models/weapons2/plasma/plasma";
		break;
	case 4: //grenade launcher
		weaponname = "models/weapons2/grenadel/grenadel";
		break;
	case 5: //rocket launcher
		weaponname = "models/weapons2/rocketl/rocketl";
		break;
	case 6: //lightning gun
		weaponname = "models/weapons2/lightning/lightning";
		break;
	}

	setmodel(self.weaponent, strcat(weaponname, ".md3"));

	v_forward = tf;
	v_right = tr;
	v_up = tu;
	self.weaponent.origin = RotateVectorsByTag(self.torsoent, self.weaponent.tag_index);//place the weapon in the hand
	AddModelWithEffects(self.weaponent);

	if (self.torsoent.animnum == TORSO_ATTACK || self.torsoent.animnum == TORSO_ATTACK2)
	{
		move = gettagindex(self.weaponent, "tag_flash");
		if (move)
		{
			self.weaponent.origin = RotateVectorsByTag(self.weaponent, move);
			setmodel(self.weaponent, strcat(weaponname, "_flash.md3"));
			AddModelWithEffects(self.weaponent);
		}
	}
};

void() Anim_UnsetModel =
{
	if (self.torsoent)
		remove(self.torsoent);
	if (self.headent)
		remove(self.headent);
	if (self.legsent)
		remove(self.legsent);
	if (self.weaponent)
		remove(self.weaponent);

	self.torsoent = world;
	self.headent = world;
	self.legsent = world;
	self.weaponent = world;
	self.modelnum = -1;

	setmodel(self, "progs/player.mdl");
};

//skinname is of the form: ranger/default
float(string skinname) Anim_SetModel =
{
	local string basemodelname;
	local string baseskinname;
	local string str;
	local float slashpos;
	local float file;
	local float modnum;
	local float sequencenum;
	local float stupid;

	if (!self.torsoent)
		self.torsoent = spawn();
	if (!self.headent)
		self.headent = spawn();
	if (!self.legsent)
		self.legsent = spawn();
	if (!self.weaponent)
		self.weaponent = spawn();

	slashpos = strstrofs(skinname, "/");
	basemodelname = substring(skinname, 0, slashpos);
	if (!basemodelname)
		return false;	//no model set?..


	for (modnum = 0; modnum < MAXMODELS; modnum++)
	{
		if (anim_name[modnum] == basemodelname)
			break;
	}
	if (modnum == MAXMODELS)
	{	//couldn't find it, we need to load one.
		for (modnum = 0; modnum < MAXMODELS; modnum++)
		{
			if (anim_name[modnum] == "")
				break;	//empty slot
		}
		if (modnum == MAXMODELS)
		{	//aww crap
			modnum = 0;	//use the very first one we found
		}
		else
		{
			str = strcat("models/players/", basemodelname, "/animation.cfg");
//print("Loading ", str, "\n");

			file = fopen(str, FILE_READ);
			if (file < 0)
			{
//				print("failed\n");
				return false;
			}

			basemodelname = strzone(basemodelname);
			anim_name[modnum] = basemodelname;

			precache_model(strcat("models/players/", basemodelname, "/upper.md3"));
			precache_model(strcat("models/players/", basemodelname, "/lower.md3"));
			precache_model(strcat("models/players/", basemodelname, "/head.md3"));

			anim_sex[modnum] = SEX_NEUTER;

			for (;;)
			{
				str = fgets(file);
				if (str) {} else break;

				tokenize(str);
				str = argv(0);
				if (str == "")
					continue;
				else if (str == "sex")
				{
					str = argv(1);
					if (str == "m" || str == "M")
						anim_sex[modnum] = SEX_MALE;
					else if (str == "f" || str == "F")
						anim_sex[modnum] = SEX_FEMALE;
					else	//n or N
						anim_sex[modnum] = SEX_NEUTER;
				}
				else if (str == "headoffset")
				{
					//whu ??
				}
				else if (str == "footsteps")
				{
					//we don't play footsteps anyway
				}
				else
				{
					if (sequencenum == NUMANIMS)
						print("animation file \"" "models/players/", basemodelname, "/animation.cfg" "\" contains too many animations\n");
					else
					{	
						if (sequencenum == LEGS_WALKCR)	//for some stupid reason, the leg frames start where the torso leaves
						{
							stupid = stof(str);
							stupid = stupid - anim_firstframe[(modnum * NUMANIMS) + TORSO_GESTURE];
						}
						anim_firstframe[(modnum * NUMANIMS) + sequencenum] = stof(str) - stupid;
						anim_numframes[(modnum * NUMANIMS) + sequencenum] = stof(argv(1));
						anim_loopingframes[(modnum * NUMANIMS) + sequencenum] = stof(argv(2));
						anum_framespersecond[(modnum * NUMANIMS) + sequencenum] = stof(argv(3));
						sequencenum++;
					}
				}
			}

			fclose(file);


			if (sequencenum != NUMANIMS)
				print("animation.cfg is incompleate\n");

		}
	}

	setmodel(self.legsent, strcat("models/players/", anim_name[modnum], "/lower.md3"));
	setmodel(self.torsoent, strcat("models/players/", anim_name[modnum], "/upper.md3"));
	setmodel(self.headent, strcat("models/players/", anim_name[modnum], "/head.md3"));

//	precache_model(AXEMODELNAME);
//	precache_model(WEAPONMODELNAME);


	self.legsent.owner = self;
	self.headent.owner = self;
	self.torsoent.owner = self;
	self.weaponent.owner = self;

	self.drawmask = MASK_NORMAL;	//general view.

	self.torsoent.tag_index = gettagindex(self.legsent, "tag_torso");
	self.headent.tag_index = gettagindex(self.torsoent, "tag_head");
	self.weaponent.tag_index = gettagindex(self.torsoent, "tag_weapon");

	self.modelnum = modnum;
	self.legsent.modelnum = modnum;
	self.headent.modelnum = modnum;
	self.torsoent.modelnum = modnum;
	self.weaponent.modelnum = modnum;

	self.legsent.colormap = self.colormap;
	self.headent.colormap = self.colormap;
	self.torsoent.colormap = self.colormap;
	self.weaponent.colormap = self.colormap;

	skinname = substring(skinname, slashpos+1, -1);
	if (!skinname)
		skinname = "default";

	self.legsent.skin = skinforname(self.legsent.modelindex, strcat("models/players/", anim_name[modnum], "/lower_", skinname, ".skin"));
	self.headent.skin = skinforname(self.headent.modelindex, strcat("models/players/", anim_name[modnum], "/head_", skinname, ".skin"));
	self.torsoent.skin = skinforname(self.torsoent.modelindex, strcat("models/players/", anim_name[modnum], "/upper_", skinname, ".skin"));

	ForceToAnim(LEGS_IDLE);
	ForceToAnim(TORSO_STAND);
	animate(self.torsoent);
	animate(self.legsent);

	self.frame2 = self.frame;

	return true;
};

entity(entity src) CloneModel =
{
	local entity dest;
	dest = spawn();

	dest.modelnum = src.modelnum;
	dest.animnum = src.animnum;
	dest.colormap = src.colormap;
	dest.tag_index = src.tag_index;
	dest.skin = src.skin;
	dest.predraw = src.predraw;
	dest.frame = src.frame;
	dest.frame2 = src.frame2;
	dest.model = src.model;
	dest.modelindex = src.modelindex;
	dest.drawmask = src.drawmask;
	dest.origin = src.origin;
	dest.angles = src.angles;
	dest.mins = src.mins;
	dest.maxs = src.maxs;
	
	return dest;
};

entity() Anim_DupModel =
{
	local entity o, n;
	o = self;

	n = self = CloneModel(o);

	self.legsent = CloneModel(o.legsent);
	self.legsent.scale = o.scale;	//only scaledown the legs, as the rest will inherit the scale from the tags.
	self.headent = CloneModel(o.headent);
	self.torsoent = CloneModel(o.torsoent);
	self.weaponent = CloneModel(o.weaponent);
	self.velocity = o.velocity;


	self = o;
	return n;
};

float(float channel, string soundname, vector pos, float vol, float attenuation) CSQC_ServerSound =
{	//the server started a sound on an entity that the csqc has control over.
	if (!self.headent)
		return false;

	if (soundname == "player/plyrjmp8.wav")
	{
		if (self == player_local)
			if (cvar("cg_noselfjumpsound"))
				return true;	//option to disable jump noise for local player.
		sexedsound(self, "jump1.wav");
		return true;
	}
	if (soundname == "player/gasp1.wav")
	{
		sexedsound(self, "gasp.wav");
		return true;
	}
	if (soundname == "player/gasp2.wav")
	{
		sexedsound(self, "gasp.wav");
		return true;
	}
	if (soundname == "player/land.wav")
	{
		sexedsound(self, "fall1.wav");
		return true;
	}
	if (soundname == "player/land2.wav")
	{
		sexedsound(self, "fall1.wav");
		return true;
	}

	if (soundname == "player/pain1.wav")
	{
		sexedsound(self, "pain25_1.wav");
		return true;
	}
	if (soundname == "player/pain2.wav")
	{
		sexedsound(self, "pain50_1.wav");
		return true;
	}
	if (soundname == "player/pain3.wav")
	{
		sexedsound(self, "pain75_1.wav");
		return true;
	}
	if (soundname == "player/pain4.wav")
	{
		sexedsound(self, "pain100_1.wav");
		return true;
	}
	if (soundname == "player/pain5.wav")
	{
		sexedsound(self, "pain75_1.wav");
		return true;
	}
	if (soundname == "player/pain6.wav")
	{
		sexedsound(self, "pain100_1.wav");
		return true;
	}

	if (soundname == "player/h2odeath.wav")
	{
		sexedsound(self, "drown.wav");
		return true;
	}
	if (soundname == "player/death1.wav")	//normal deaths come from the player animations.
		return true;
	if (soundname == "player/death2.wav")
		return true;
	if (soundname == "player/death3.wav")
		return true;
	if (soundname == "player/death4.wav")
		return true;
	if (soundname == "player/death5.wav")
		return true;

	return false;
};
