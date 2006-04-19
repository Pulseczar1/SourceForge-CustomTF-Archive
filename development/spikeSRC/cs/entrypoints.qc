
float(string centertext) centerprinted =
{
//warning!
//centertext is a temporary string!
//warning!

	return false;	//we don't want to handle it, let the engine do it.
};

.float classnum;

void(float isnew) CSQC_Ent_Update =
{
	local float classtype;
	local var void(float isnew) fnc;

	classtype = readbyte();

//remove if the class changed.
	if (self.classnum != classtype)
	{
		if (self.removefunc)
			self.removefunc();
		isnew = true;
		self.classnum = classtype;
	}

	fnc = ParseEntityClass[classtype];
	if (!fnc)
		error("Unrecognised entity class: Your csqc needs updating");
	fnc(isnew);
};

float sb_showscores;

float(string str) CSQC_ConsoleCommand =
{
	local float args;
	args = tokenize(str);
	if (argv(0) == "tetris")
		Menu_Tetris();
	else if (argv(0) == "skinchooser")
		Menu_SkinChooser();
	else if (argv(0) == "randomskin")
		SelectRandomSkin();
	else if (argv(0) == "test")
		test();
	else if (argv(0) == "+showscores")
		sb_showscores = true;
	else if (argv(0) == "-showscores")
		sb_showscores = false;
	else if (argv(0) == "+showteamscores")
		sb_showscores = true;
	else if (argv(0) == "-showteamscoresscores")
		sb_showscores = false;
	else
	{
/*		localcmd("cmd ");
		localcmd(str);
		localcmd("\n");
		return true;
*/
		return false;
	}

	return true;
};

void() CSQC_Ent_Remove =	//the ent disappeared on the server.
{
	if (self == player_local)
		print("WARNING: Player disappeared!\n");
	if (self.removefunc)
		self.removefunc();
	remove(self);
};

entity viewentity;
//note that a better way of animating weapon firing would be as a response to an event, or as a clientside predicted thing.
void() DoThatViewModelThing =
{
	float newframe, newmodel;

	newframe = getstati(STAT_WEAPONFRAME);
	newmodel = getstati(STAT_WEAPONMODEL);

	if (newmodel != self.modelindex)
	{	//changed entirly.
		self.modelindex = newmodel;
		self.frame2 = self.frame = newframe;
		self.lerptime = time;
	}
	else if (newframe != self.frame)
	{
		self.frame2 = self.frame;
		self.frame = newframe;
		self.lerptime = time;
	}
	self.lerpfrac = 1-(time-self.lerptime)*10;

	if (player_local)
	{
//		self.origin = vieworg;
//		self.angles = input_angles;
//		self.angles_x *= -1;
	}
};

void() CSQC_Init =
{
	viewentity = spawn();
	viewentity.predraw = DoThatViewModelThing;
	viewentity.renderflags = RF_VIEWMODEL;
};

void(entity ent) CSQC_DrawViewModel =
{
	if (player_local.sveffects & SVE_INVIS)
		ent.forceshader = shaderforname("powerups/invisibility");
	else
		ent.forceshader = 0;

	ent.fatness = 0;
	addentity(ent);
	if (player_local.sveffects & SVE_QUAD)
	{
		ent.fatness = -2;
		ent.forceshader = shaderforname("powerups/quad");
		addentity(ent);
	}
	if (player_local.sveffects & SVE_GOD)
	{
		ent.fatness = -2.8;
		ent.forceshader = shaderforname("powerups/regen");
		addentity(ent);
	}
}

vector(vector angles, float scale) V_IdleScale =
{
	//defaults: for use if idlescale is locked and the var isn't.
	#define yaw_cycle	2
	#define roll_cycle	0.5
	#define pitch_cycle	1
	#define yaw_level	0.3
	#define roll_level	0.1
	#define pitch_level	0.3

	angles_z += scale * sin(time*roll_cycle) * roll_level;
	angles_x += scale * sin(time*pitch_cycle) * pitch_level;
	angles_y += scale * sin(time*yaw_cycle) * yaw_level;

	return angles;
};

void(float do2d) CSQC_UpdateView =
{
	float idle;
	float lagged;
	float i;
	float width,height;
	float usehud;
	width = cvar("vid_conwidth");
	height = cvar("vid_conheight");

	clearscene();

	if (!cvar("cg_usehud"))
	{
		setviewprop(VF_DRAWENGINESBAR, 0);
		usehud = true;
	}
	else
	{
		setviewprop(VF_DRAWENGINESBAR, 1);
	}

	setviewprop(VF_DRAWCROSSHAIR, 1);

	//force fullscreen views.
	setviewprop(VF_MIN, '0 0 0');	
	setviewprop(VF_SIZE_X, width);	
	setviewprop(VF_SIZE_Y, height);

	addentities(MASK_ENGINE | MASK_NORMAL);


	if (player_local)
	{
		UpdateLocalMovement();

		setviewprop(VF_ORIGIN, vieworg);
		idle = cvar("v_idlescale");
		if (idle)
			setviewprop(VF_ANGLES, V_IdleScale(input_angles, idle));
		else
			setviewprop(VF_ANGLES, input_angles);

		if (!chasecam)
			CSQC_DrawViewModel(viewentity);
	}
	else
		CSQC_DrawViewModel(viewentity);

	renderscene();

	if (usehud)
		Hud_Draw();


	chasecam = cvar("cg_thirdPerson");
	Menu_Think();

	makevectors(input_angles);
	SetListener(vieworg, v_forward, v_right, v_up);
};

