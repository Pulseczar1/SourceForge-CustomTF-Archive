float sb_showscores;

string number[10] = {
	"num_0",
	"num_1",
	"num_2",
	"num_3",
	"num_4",
	"num_5",
	"num_6",
	"num_7",
	"num_8",
	"num_9"
};
string anumber[10] = {
	"anum_0",
	"anum_1",
	"anum_2",
	"anum_3",
	"anum_4",
	"anum_5",
	"anum_6",
	"anum_7",
	"anum_8",
	"anum_9"
};
void Hud_Init(void)
{
	float i;
	precache_pic("sbar", true);
	for (i = 0; i < 10; i++)
	{
		precache_pic(number[i], true);
		precache_pic(anumber[i], true);
	}
};


//q3 models stuff. :D
entity hudent;
void Hud_DrawHead(vector pos, string modelname, float skinnum, float sveff)
{
	clearscene();
	setviewprop(VF_MIN, pos);
	setviewprop(VF_SIZE_X, 24);
	setviewprop(VF_SIZE_Y, 24);

	setviewprop(VF_ORIGIN, '-8 0 0');
	setviewprop(VF_ANGLES, '0 0 0');
	setviewprop(VF_DRAWWORLD, 0);
	setviewprop(VF_PERSPECTIVE, 0);

	if (!hudent)
		hudent = spawn();
	setmodel(hudent, modelname);

	hudent.scale = (1.5*48)/(hudent.maxs_z-hudent.mins_z);
	hudent.origin_z = (hudent.maxs_z+hudent.mins_z)/hudent.scale;
	hudent.angles_y = 180+sin(time*3)*30;

	hudent.skin = skinnum;


	if (sveff & SVE_INVIS)
		hudent.forceshader = shaderforname("powerups/invisibility");
	addentity(hudent);
	if (sveff & SVE_QUAD)
	{
		hudent.fatness = -2;
		hudent.forceshader = shaderforname("powerups/quad");
		addentity(hudent);
	}
	if (sveff & SVE_GOD)
	{
		hudent.fatness = -2;
		hudent.forceshader = shaderforname("powerups/regen");
		addentity(hudent);
	}
	hudent.fatness = 0;
	hudent.forceshader = 0;


	renderscene();
};



vector screensize;
float items, items2;

void Hud_DrawLargeValue(vector pos, float value, float threshhold)
{
	float c;
	float len;
	string s;
	if (value < 0)
		value = 0;	//hrm
	if (value>999)
		value = 999;

	s = ftos(floor(value));
	len = strlen(s);

	pos_x += 24 * (3-len);
	

	if (value <= threshhold)
	{	//use alternate (red) numbers

		while(len>0)
		{
			len--;
			c = str2chr(s, len);

			drawpic(pos+len * '24 0 0', anumber[c-'0'], '24 24 0', '1 1 1', 1, 0);
		}
	}
	else
	{	//use normal numbers

		while(len>0)
		{
			len--;
			c = str2chr(s, len);

			drawpic(pos+len * '24 0 0', number[c-'0'], '24 24 0', '1 1 1', 1, 0);
		}
	}
};

void Hud_DrawAmmoCount(float type, vector pos, float drawback)
{
	string s;
	float value;
	float len;
	float c;
	value = getstati(STAT_SHELLS+type);
	if (value < 0)
		value = 0;	//hrm
	if (value>999)
		value = 999;

	s = ftos(floor(value));
	len = strlen(s);

	pos_x += 8 * (3-len);
	while(len>0)
	{
		len--;
		c = str2chr(s, len);
		drawcharacter(pos+len * '8 0 0', (18-'0') + c, '8 8 0', '1 1 1', 1, 0);
	}
};

string weaponnames[7] = {
	"inv_shotgun",
	"inv_sshotgun",
	"inv_nailgun",
	"inv_sshotgun",
	"inv_rlaunch",
	"inv_srlaunch",
	"inv_lightng"
};
void Hud_DrawWeapon(float num, vector pos)
{
	drawpic(pos, weaponnames[num], '24 16 0', '1 1 1', 1, 0);
};
void Hud_DrawWeaponWide(float num, vector pos)	//for LG
{
	drawpic(pos, weaponnames[num], '48 16 0', '1 1 1', 1, 0);
};

void Hud_DrawSBar(void)
{
	vector sbar;
	sbar = screensize_y * ' 0 1 0' - '0 24 0';
	drawpic(sbar, "sbar", '320 24 0', '1 1 1', 0.333, 0);

	if (items & IT_INVULNERABILITY)
	{
		drawpic(sbar, "disc", '24 24 0', '1 1 1', 1, 0);
		Hud_DrawLargeValue(sbar+'24 0 0', 999, 25);
	}
	else
	{
		Hud_DrawLargeValue(sbar+'24 0 0', getstati(STAT_ARMOR), 25);
		if (items & IT_ARMOR3)
			drawpic(sbar, "sb_armor3", '24 24 0', '1 1 1', 1, 0);
		else if (items & IT_ARMOR2)
			drawpic(sbar, "sb_armor2", '24 24 0', '1 1 1', 1, 0);
		else if (items & IT_ARMOR1)
			drawpic(sbar, "sb_armor1", '24 24 0', '1 1 1', 1, 0);
	}

	if (player_local)
		Hud_DrawHead(sbar+'112 0 0', player_local.headent.model, player_local.headent.skin, player_local.sveffects);
	Hud_DrawLargeValue(sbar+'136 0 0', getstati(STAT_HEALTH), 25);

	if (items & IT_SHELLS)
		drawpic(sbar+'224 0 0', "sb_shells", '24 24 0', '1 1 1', 1, 0);
	else if (items & IT_NAILS)
		drawpic(sbar+'224 0 0', "sb_nails", '24 24 0', '1 1 1', 1, 0);
	else if (items & IT_ROCKETS)
		drawpic(sbar+'224 0 0', "sb_rocket", '24 24 0', '1 1 1', 1, 0);
	else if (items & IT_CELLS)
		drawpic(sbar+'224 0 0', "sb_cells", '24 24 0', '1 1 1', 1, 0);
	Hud_DrawLargeValue(sbar+'248 0 0', getstati(STAT_AMMO), 10);
};

void Hud_DrawIBar(void)
{
	vector pos;
	pos= screensize_y * ' 0 1 0' - '0 48 0';
	drawpic(pos, "ibar", '320 24 0', '1 1 1', 0.333, 0);

	if (items & IT_SHOTGUN)
		Hud_DrawWeapon(0, pos+'0 8 0');
	if (items & IT_SUPER_SHOTGUN)
		Hud_DrawWeapon(1, pos+'24 8 0');
	if (items & IT_NAILGUN)
		Hud_DrawWeapon(2, pos+'48 8 0');
	if (items & IT_SUPER_NAILGUN)
		Hud_DrawWeapon(3, pos+'72 8 0');
	if (items & IT_GRENADE_LAUNCHER)
		Hud_DrawWeapon(4, pos+'96 8 0');
	if (items & IT_ROCKET_LAUNCHER)
		Hud_DrawWeapon(5, pos+'120 8 0');
	if (items & IT_LIGHTNING)
		Hud_DrawWeaponWide(6, pos+'144 8 0');

	Hud_DrawAmmoCount(0, pos + '6 0 0', false);
	Hud_DrawAmmoCount(1, pos + '54 0 0', false);
	Hud_DrawAmmoCount(2, pos + '102 0 0', false);
	Hud_DrawAmmoCount(3, pos + '150 0 0', false);

	if (items & IT_KEY1)
		drawpic(pos+'192 8 0', "sb_key1", '16 16 0', '1 1 1', 1, 0);
	if (items & IT_KEY2)
		drawpic(pos+'208 8 0', "sb_key2", '16 16 0', '1 1 1', 1, 0);

	if (items & IT_INVISIBILITY)
		drawpic(pos+'224 8 0', "sb_invis", '16 16 0', '1 1 1', 1, 0);
	if (items & IT_INVULNERABILITY)
		drawpic(pos+'240 8 0', "sb_invuln", '16 16 0', '1 1 1', 1, 0);
	if (items & IT_SUIT)
		drawpic(pos+'256 8 0', "sb_suit", '16 16 0', '1 1 1', 1, 0);
	if (items & IT_QUAD)
		drawpic(pos+'272 8 0', "sb_quad", '16 16 0', '1 1 1', 1, 0);

	if (items2 & 32)
		drawpic(pos+'288 8 0', "sb_sigil1", '8 16 0', '1 1 1', 1, 0);
	if (items2 & 64)
		drawpic(pos+'296 8 0', "sb_sigil2", '8 16 0', '1 1 1', 1, 0);
	if (items2 & 128)
		drawpic(pos+'304 8 0', "sb_sigil3", '8 16 0', '1 1 1', 1, 0);
	if (items2 & 256)
		drawpic(pos+'312 8 0', "sb_sigil4", '8 16 0', '1 1 1', 1, 0);
};

string q3numbers[10] =
{
	"gfx/2d/numbers/zero_32b.tga",
	"gfx/2d/numbers/one_32b.tga",
	"gfx/2d/numbers/two_32b.tga",
	"gfx/2d/numbers/three_32b.tga",
	"gfx/2d/numbers/four_32b.tga",
	"gfx/2d/numbers/five_32b.tga",
	"gfx/2d/numbers/six_32b.tga",
	"gfx/2d/numbers/seven_32b.tga",
	"gfx/2d/numbers/eight_32b.tga",
	"gfx/2d/numbers/nine_32b.tga"
};
void Hud_DrawQ3Number(vector pos, float value, vector colours)
{
	float c;
	float len;
	string s;
	if (value < 0)
		value = 0;	//hrm
	if (value>999)
		value = 999;

	s = ftos(floor(value));
	len = strlen(s);

	pos_x += 24 * (3-len);
	
	while(len>0)
	{
		len--;
		c = str2chr(s, len);

		drawpic(pos+len * '24 0 0', q3numbers[c-'0'], '24 24 0', colours, 1, 0);
	}
};

void Hud_Draw3dIcon(vector pos, string modelname)
{
	clearscene();
	setviewprop(VF_MIN, pos);
	setviewprop(VF_SIZE_X, 24);
	setviewprop(VF_SIZE_Y, 24);

	setviewprop(VF_ORIGIN, '-16 0 0');
	setviewprop(VF_ANGLES, '0 0 0');
	setviewprop(VF_DRAWWORLD, 0);
	setviewprop(VF_PERSPECTIVE, 0);

	if (!hudent)
		hudent = spawn();
	setmodel(hudent, modelname);
	hudent.origin_z = -16;
	hudent.scale = 2;
	hudent.angles_y = time*180;
	addentity(hudent);
	renderscene();
};

//basic q3 sbar
void Hud_Q3(void)
{
	vector sbar;
	sbar = screensize_y * ' 0 1 0' - '0 24 0';
	Hud_DrawQ3Number(sbar+'24 0 0', getstati(STAT_ARMOR), '1 1 1');
	Hud_DrawQ3Number(sbar+'136 0 0', getstati(STAT_HEALTH), '1 1 1');
	Hud_DrawQ3Number(sbar+'248 0 0', getstati(STAT_AMMO), '1 1 1');

	Hud_Draw3dIcon(sbar+'8 0 0', "models/powerups/armor/armor_red.md3");
	if (player_local)
		Hud_DrawHead(sbar+'112 0 0', player_local.headent.model, player_local.skin);
};





void(vector top, float value) EngineerSlot =
{
	if (!value)
		return;

	if (value >= 201)
	{	//sentry
		drawstring(top, "sent", '8 8 0', '1 1 1', 1);
		value -= 201;
	}
	else
	{	//tesla
		drawstring(top, "tesla", '8 8 0', '1 1 1', 1);
	}
	if (value >= 101)
	{
		value-=101;
		drawstring(top+'0 8 0', "attacking", '8 8 0', '1 1 1', 1);
	}
	if (value)	//health of turret
		Hud_DrawLargeValue(top+'24 0 0', value, 25);
};

void(vector top, float value) WarlockSlot =
{
	if (!value)
		return;

	if (value >= 701)
	{
		drawstring(top, "grem", '8 8 0', '1 1 1', 1);
		value -= 701;
	}
	else if (value >= 601)
	{
		drawstring(top, "fish", '8 8 0', '1 1 1', 1);
		value -= 601;
	}
	else if (value >= 501)
	{
		drawstring(top, "fiend", '8 8 0', '1 1 1', 1);
		value -= 501;
	}
	else if (value >= 401)
	{
		drawstring(top, "scrag", '8 8 0', '1 1 1', 1);
		value -= 401;
	}
	else if (value >= 301)
	{
		drawstring(top, "sham", '8 8 0', '1 1 1', 1);
		value -= 301;
	}
	else
	{	//tesla
		drawstring(top, "army", '8 8 0', '1 1 1', 1);
	}

	if (value >= 101)
	{
		value-=101;
		drawstring(top+'0 8 0', "attacking", '8 8 0', '1 1 1', 1);
	}

	if (value)	//health of creature
		Hud_DrawLargeValue(top+'24 0 0', value, 25);
};

void(vector top, float value) UnknownSlot =
{
	if (value)
		Hud_DrawLargeValue(top, value, 25);
};

void(vector top, float value) ActionSlot =
{
	if (!value)
		return;

	else if (value == 101)
	{
		drawstring(top, "Aborting ...", '8 8 0', '1 1 1', 1);
		return;
	}
	else if (value == 102)
	{
		drawstring(top, "Placing detpack ...", '8 8 0', '1 1 1', 1);
		return;
	}
	else if (value == 103)
	{
		drawstring(top, "Building ...", '8 8 0', '1 1 1', 1);
		return;
	}
	else if (value>100)
		drawstring(top, ftos(value), '8 8 0', '1 1 1', 1);
	else
		drawstring(top, strcat("Hacking ", ftos(value), "% ..."), '8 8 0', '1 1 1', 1);
};

void(vector top, float value) SpySlot =
{
	float uc;
	if (!value)
		return;

	uc = floor(value/20);
	switch (uc)
	{
	case 2:
		drawstring(top, "disguising", '8 8 0', '1 1 1', 1);
		break;
	case 1:
		drawstring(top, "disguised", '8 8 0', '1 1 1', 1);
		break;
	case 0:
		drawstring(top, "uncovered", '8 8 0', '1 1 1', 1);
		break;
	}
	value -= uc*20;
	switch (value)
	{
	case 1:
		drawstring(top+'0 8 0', "scout", '8 8 0', '1 1 1', 1);
		break;
	case 2:
		drawstring(top+'0 8 0', "Sniper", '8 8 0', '1 1 1', 1);
		break;
	case 3:
		drawstring(top+'0 8 0', "Soldier", '8 8 0', '1 1 1', 1);
		break;
	case 4:
		drawstring(top+'0 8 0', "Demoman", '8 8 0', '1 1 1', 1);
		break;
	case 5:
		drawstring(top+'0 8 0', "Medic", '8 8 0', '1 1 1', 1);
		break;
	case 6:
		drawstring(top+'0 8 0', "Hvy Wpns", '8 8 0', '1 1 1', 1);
		break;
	case 7:
		drawstring(top+'0 8 0', "Pyro", '8 8 0', '1 1 1', 1);
		break;
	case 8:
		drawstring(top+'0 8 0', "Spy", '8 8 0', '1 1 1', 1);
		break;
	case 9:
		drawstring(top+'0 8 0', "Engineer", '8 8 0', '1 1 1', 1);
		break;
	}
};

void() Hud_DrawCUTF =
{
	vector sbar;

	sbar = screensize_y * '0 1 0' - '0 48 0';

	ActionSlot(sbar+'96 -8 0', getstati(34));	//action

	//engineer stuff
	sbar -= '0 24 0';
	EngineerSlot(sbar, getstati(32));	//turret 1
	sbar -= '0 24 0';
	EngineerSlot(sbar, getstati(33));	//turret 2

	sbar -= '0 24 0';
	SpySlot(sbar, getstati(35));	//spy

	sbar -= '0 24 0';
	WarlockSlot(sbar, getstati(36));	//warlock1
	sbar -= '0 24 0';
	WarlockSlot(sbar, getstati(37));	//warlock2
	sbar -= '0 24 0';
	WarlockSlot(sbar, getstati(38));	//warlock3
};





void ScoreBoard_DrawTeamFortress(void)
{
	vector top; top = '0 0 0';
	vector colour;
	string pname;
	string pfrags;
	string team;
	float pnum;
	for (pnum = 0; ; pnum++)
	{
		pname = getplayerkeyvalue(-(pnum+1), "name");
		if (pname == "")
			break;
		pfrags = getplayerkeyvalue(-(pnum+1), "frags");
		team = getplayerkeyvalue(-(pnum+1), "team");
		if (team == "red")
			colour = '1 0.1 0.1';
		else if (team == "blue")
			colour = '0.2 0.2 1';	//pure blue is dark
		else
			colour = '1 1 1';
		drawstring(top, pfrags, '8 8 0', colour, 1);
		drawstring(top+'32 0 0', team, '8 8 0', colour, 1);
		drawstring(top+'72 0 0', pname, '8 8 0', colour, 1);

		top_z += 8;
	}
}



void Hud_Draw(void)
{
	vector sbar;
	screensize_x = cvar("vid_conwidth");
	screensize_y = cvar("vid_conheight");
	screensize_z = 0;

	items = getstatbits(STAT_ITEMS, 0, 23);
	items2 = getstatbits(STAT_ITEMS, 23, 9);

	Hud_DrawCUTF();

	if (sb_showscores)
	{
		ScoreBoard_DrawTeamFortress();
	}
	else if (cvar("cg_q3hud"))
	{
		Hud_Q3();
	}
	else
	{
		Hud_DrawSBar();
		Hud_DrawIBar();
	}
};
