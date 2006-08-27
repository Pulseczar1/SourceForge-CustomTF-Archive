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



vector player_org, vieworg;
float player_updateseq;
vector player_vel;
entity player_local;	//refers to the local player
float player_localentnum;
float recframe;

vector pmove_error;
float pmove_errortime;

float pmove_steperror;
float pmove_steperrortime;

#define STEPTIME 10
#define ERRORTIME 20

.void() removefunc;

float pmoveframe;
void() ResetPlayerPrediction = 
{
//reset the pmove to lerp from the new position
	pmove_org = player_org;
	pmove_vel = player_vel;
	pmoveframe = player_updateseq+1;	//the recieved frame has the move already done (server side)
	if (pmoveframe < clientcommandframe-128)
		pmoveframe = clientcommandframe-128;	//avoid an infinate loop
};

void() RunMovement =
{
	float oz;
//	ResetPlayerPrediction();
	if (getstati(STAT_HEALTH) <= 0)
	{
		pmoveframe = clientcommandframe;
		getinputstate(pmoveframe-1);
		return;	//dead, so don't run prediction. :D
	}

	if (cvar("cg_nopred") || cvar("cl_nopred"))
	{
		pmoveframe = clientcommandframe;
		getinputstate(pmoveframe-1);
		return;
	}

	oz = pmove_org_z;
	while(pmoveframe < clientcommandframe)
	{
		getinputstate(pmoveframe);
		runstandardplayerphysics();
		pmoveframe++;
	}

	if (pmove_org_z > oz+8 && pmove_org_z < oz + 24)
	{
		pmove_steperror = (pmove_errortime - time)*STEPTIME * pmove_steperror + (oz-pmove_org_z);
		pmove_steperrortime = time + 1/STEPTIME;
	}
};

void() UpdateLocalMovement =
{
	local float viewheight;

	RunMovement();

	//allow the user to move the viewheight down 6 units so it's at +16, where projectiles come from.
	viewheight = cvar("v_viewheight");
	if (viewheight < -7)
		viewheight = -7;
	if (viewheight > 7)
		viewheight = 7;

	vieworg = pmove_org;	//the default view height
	vieworg_z +=  22 + viewheight;

	//correct the view position to compensate for any errors, slowly over time, 0.1 seconds.
	if (pmove_errortime - time > 0)
		vieworg += (pmove_errortime - time)*ERRORTIME * pmove_error;

	if (pmove_steperrortime - time > 0)
		vieworg_z += (pmove_steperrortime - time)*STEPTIME * pmove_steperror;

	if (chasecam)
	{
		makevectors(input_angles);
		traceline(pmove_org, vieworg - v_forward * 72+v_up*32, FALSE, self);
		vieworg = trace_endpos + v_forward*8;
	}
};

.string oldskin;
void() RemovePlayer =
{
	strunzone(self.oldskin);
	self.oldskin = "";
	Anim_UnsetModel();

	self.predraw = __NULL__;
};

void() Player_Interpolate =
{	//do some frame interpolation.

	if (self.modelnum != -1)
		DrawPlayerModel();
	else
	{
		self.lerpfrac = 1-(time-self.lerptime)*10;

		if (chasecam || self.entnum != player_localentnum)
			self.renderflags = 0;
		else
			self.renderflags = RF_EXTERNALMODEL;

		if (self.sveffects & SVE_INVIS)
			self.forceshader = shaderforname("powerups/invisibility");
		else
			self.forceshader = 0;
		self.fatness = 0;

		self.predraw = __NULL__;
		if (self.sveffects & SVE_QUAD)
		{
			addentity(self);

			self.fatness = -2;
			self.forceshader = shaderforname("powerups/quad");
		}
		if (self.sveffects & SVE_GOD)
		{
			addentity(self);

			self.fatness = -2.8;
			self.forceshader = shaderforname("powerups/regen");
		}
		self.predraw = Player_Interpolate;
	}
	self.origin += self.velocity*frametime;
};

void() BounceProject;
.float removetime;
.float finalframe;
void() bodythink =
{
	local float final;
	if (self.frame >= $axdeth1 && self.frame <= $axdeth9)
		final = $axdeth9;
	else if (self.frame == $deatha1 && self.frame <= $deatha11)
		final = $deatha11;
	else if (self.frame == $deathb1 && self.frame <= $deathb9)
		final = $deathb9;
	else if (self.frame == $deathc1 && self.frame <= $deathc15)
		final = $deathc15;
	else if (self.frame == $deathd1 && self.frame <= $deathd9)
		final = $deathd9;
	else if (self.frame == $deathe1 && self.frame <= $deathe9)
		final = $deathe9;

	self.frame = self.frame+1;

	if (self.frame > self.finalframe)
		self.frame = self.finalframe;

	self.lerptime = time;

	self.nextthink = time + 0.1;
};
void() DeadBodyPredraw =
{
	if (self.removetime < time)
	{
		Anim_UnsetModel();
		remove(self);
		return;
	}

	BounceProject();

	Player_Interpolate();
	self.origin_z -= frametime;
};

void() BecomeDead =
{
	local entity e;
	e = Anim_DupModel();
	e.predraw = DeadBodyPredraw;
	e.removetime = time + 20;

	e.nextthink = time + 0.1;
	e.think = bodythink;
};

void(float cmap) ApplyModel =
{
	local string newskin;
	local float sep, f;
	local float forceteam;

	newskin = cvar_string("cg_forcemodel");
	forceteam = 0;
	if (newskin == "")
	{
		newskin = getplayerkeyvalue(cmap-1, "model");
		forceteam = 2;	//strip off any slash in teamplay
	}
	if (newskin == "")
	{
		forceteam = 1;
		newskin = getplayerkeyvalue(cmap-1, "skin");
		if (newskin == "tf_scout")
			newskin = "slash";
		else if (newskin == "tf_snipe")
			newskin = "xaero";
		else if (newskin == "tf_sold")
			newskin = "sarge";
		else if (newskin == "tf_demo")
			newskin = "doom";
		else if (newskin == "tf_medic")
			newskin = "mynx";	//what else do the wounded want?
		else if (newskin == "tf_hwguy")
			newskin = "tankjr";
		else if (newskin == "tf_pyro")
			newskin = "anarki";
		else if (newskin == "tf_spy")
			newskin = "orbb";
		else if (newskin == "tf_eng")
			newskin = "crash";
		else
			newskin = "visor";
	}

	if (forceteam && stof(getserverinfo("teamplay")))	//in teamplay, use team skins.
	{
		f = stof(getplayerkeyvalue(cmap-1, "bottomcolor"));
		switch(f)
		{
		case 4:
			if (forceteam == 2)
			{
				sep = strstrofs(newskin, "/");
				if (sep>=0)
					newskin = substring(newskin, 0, sep);
			}

			newskin = strcat(newskin, "/red");
			break;
		case 13:
			if (forceteam == 2)
			{
				sep = strstrofs(newskin, "/");
				if (sep>=0)
					newskin = substring(newskin, 0, sep);
			}
			newskin = strcat(newskin, "/blue");
			break;
		default:
			newskin = strcat(newskin, "/default");
			break;
		}
	}


	if (newskin != self.oldskin)
	{
		self.oldskin = strzone(newskin);
		if (!Anim_SetModel(self.oldskin))
		{
			Anim_UnsetModel();
		}
	}

	self.colormap = cmap;
};

void(float isnew) ParseBody =
{
	local float cmap;
	
	self.frame2 = -1;
	self.frame = readbyte();	//for clientside animation selection, in a way compatable with not having csqc.
	self.angles_x = readbyte();
	self.angles_y = readbyte();
	self.angles_z = readbyte();
	self.origin_x = readcoord();
	self.origin_y = readcoord();
	self.origin_z = readcoord();
	self.velocity_x = readshort()/4;
	self.velocity_y = readshort()/4;
	self.velocity_z = readshort()/4;
	cmap = readbyte();

	if (isnew)
	{
		self.oldskin = strzone("");
		self.drawmask = MASK_NORMAL;
		self.predraw = DeadBodyPredraw;
		self.removefunc = RemovePlayer;
	}
	ApplyModel(cmap);

	if (self.legsent)
	{
		self.legsent.framechangetime = time-50;
		self.torsoent.framechangetime = time-50;
	}
};

//this is sent after the server has run our movement command.
void(float isnew) ParsePlayer =
{
	local vector o;
	local string newskin;
	local float f;
//	local float wasdead;

//	if (self.frame >= $axdeth1 && self.frame <= $deathe9)
//		wasdead = true;

	f = readbyte();
	if (f != self.frame)
	{
		self.frame2 = self.frame;
		self.lerptime = time;
		self.frame = f;

//		if (!isnew && self.frame >= $axdeth1 && self.frame <= $deathe9 && !wasdead)
//			BecomeDead();

//		if (self.frame >= $axdeth1 && self.frame <= $deathe9)
//			self.predraw = __NULL__;
//		else
			self.predraw = Player_Interpolate;
	}

//	if (self.entnum != player_localentnum)
	{
		self.angles_x = readbyte()*(360/256);
		self.angles_y = readbyte()*(360/256);
	}
	self.origin_x = readcoord();
	self.origin_y = readcoord();
	self.origin_z = readcoord();
//	if (self.entnum == player_localentnum)
	{
		self.velocity_x = readshort()/4;
		self.velocity_y = readshort()/4;
		self.velocity_z = readshort()/4;
	}

	self.sveffects = readbyte();

	self.removefunc = RemovePlayer;
	setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);

	if (isnew)
	{
		if (self.entnum == player_localentnum)
		{
			player_local = self;
			pmove_mins = self.mins;
			pmove_maxs = self.maxs;
		}

		self.oldskin = strzone("");
		Anim_UnsetModel();
		self.drawmask = MASK_NORMAL;
	}

	ApplyModel(self.entnum);

	if (self.entnum != player_localentnum)
		return;

	RunMovement();	//make sure we're up to date
	o = pmove_org;	//save off the old for the teleport check below.
	player_org = self.origin;
	player_vel = self.velocity;
	player_updateseq = servercommandframe;
	ResetPlayerPrediction();
	RunMovement();
	//we're now up to date with the old movement value applied.

	if (vlen(o - pmove_org) > 64 || cvar("cg_noerror"))
	{//teleport
		pmove_error = '0 0 0';
		pmove_errortime = time;
	}
	else
	{	//figure out the error ammount, and lerp back to it, without forgetting about any current inaccuracies.
		o_z = pmove_org_z;
		pmove_error = (pmove_errortime - time)*ERRORTIME * pmove_error + (o - pmove_org);
		if (vlen(pmove_error) < 1)
			pmove_error = '0 0 0';
		pmove_errortime = time + 1/ERRORTIME;
	}
};
