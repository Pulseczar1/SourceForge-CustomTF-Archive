//clientside quakec extension, serverside compontant.
//invoked directly from the fteqw compatability layer.

#ifdef CSQC

.float(entity to) SendEntity;
.float Version;

void(float type, float num, string fieldname) clientstat = #232;
#define EV_FLOAT 2

#define CLASS_PLAYER 1
#define MSG_ENTITY 5

float(entity to) SendPlayer =
{
	float ef;
	float f;

//	if (!to.usingcsqc)
//		to.usingcsqc = 1;

//encode the current weapon in the lower 4 bits.
	for (f = 1, ef = 0; ef < 16; ef=ef+1,f*=2)
	{
		if (self.weapon == f)
			break;
	}
//and put effects in the upper 3
	if (self.items & #IT_INVISIBILITY)
		ef |= 128;
	if (self.items & #IT_INVULNERABILITY || self.flags & #FL_GODMODE)
		ef |= 64;
	if (self.items & #IT_QUAD)
		ef |= 32;
//and the final bit takes an indication to switch of prediction.
	if (self.movetype != #MOVETYPE_WALK)
		ef |= 16;	//tells the csqc to stop trying to predict (I can't be bothered to send the real movetype)

	WriteByte(#MSG_ENTITY, 1);
	WriteByte(#MSG_ENTITY, self.frame);	//for clientside animation selection, in a way compatable with not having csqc.
//	if (to != self)
	{
		WriteByte(#MSG_ENTITY, self.angles_x*(256/360));
		WriteByte(#MSG_ENTITY, self.angles_y*(256/360));
	}
	WriteCoord(#MSG_ENTITY, self.origin_x);
	WriteCoord(#MSG_ENTITY, self.origin_y);
	WriteCoord(#MSG_ENTITY, self.origin_z);
//	if (to == self)
	{
		WriteShort(#MSG_ENTITY, self.velocity_x*4);
		WriteShort(#MSG_ENTITY, self.velocity_y*4);
		WriteShort(#MSG_ENTITY, self.velocity_z*4);
	}
	WriteByte(#MSG_ENTITY, ef);
	return #TRUE;
};

void() SetupPlayerForCSQC =
{
//	self.usingcsqc = false;
	self.SendEntity = SendPlayer;
};

var void() RealPlayerPostThink;
void() ftePlayerPostThink =
{
	RealPlayerPostThink();

	self.Version++;
};

float(entity to) SendCorpse =
{
	WriteByte(#MSG_ENTITY, 2);
	WriteByte(#MSG_ENTITY, self.frame);	//for clientside animation selection, in a way compatable with not having csqc.
	WriteByte(#MSG_ENTITY, self.angles_x*(256/360));
	WriteByte(#MSG_ENTITY, self.angles_y*(256/360));
	WriteByte(#MSG_ENTITY, self.angles_z*(256/360));
	WriteCoord(#MSG_ENTITY, self.origin_x);
	WriteCoord(#MSG_ENTITY, self.origin_y);
	WriteCoord(#MSG_ENTITY, self.origin_z);
	WriteShort(#MSG_ENTITY, self.velocity_x*4);
	WriteShort(#MSG_ENTITY, self.velocity_y*4);
	WriteShort(#MSG_ENTITY, self.velocity_z*4);
	WriteByte(#MSG_ENTITY, self.colormap);

	return #TRUE;
};

void() incverifoffground =
{
	self.nextthink = time + 0.1;
	if (!self.flags & #FL_ONGROUND)
		self.Version++;
}

var entity(entity deadone) RealCopyToBodyQue;
entity(entity deadone) fteCopyToBodyQue =
{
	local entity ent;

	ent = RealCopyToBodyQue(deadone);

	if (deadone.classname == "player" && ent != world)
	{	//only players use q3 models.
		ent.SendEntity = SendCorpse;
		ent.Version++;

		ent.think = incverifoffground;
		ent.nextthink = time+0.1;
	}
	return ent;
};

//engineer device 1
float() SetPlayerStat32 =
{
	local entity te;
	if (self.tf_items & #NIT_DOUBLETESLA)
	{//look for the second tesla
//searching against a name is ugly, FIXME: search against the realowner and then check the name.
		te = find(world, classname, "building_tesla");
		while(te)
		{
			if (te.real_owner == self)
			if (te.dont_do_triggerwork & 2)
			{
				return te.health/te.max_health*100 + 101*(te.enemy != world);
			}
			te = find(te, classname, "building_tesla");
		}
	}
	else
	{//look for the first sentry
		te = find(world, classname, "building_sentrygun");
		while(te)
		{
			if (te.real_owner == self)
			if (te.dont_do_triggerwork & 1)
			{
				return te.health/te.max_health*100 + 101*(te.enemy != world)+201;
			}
			te = find(te, classname, "building_sentrygun");
		}
	}
	return 0;
};
//engineer device 2
float() SetPlayerStat33 =
{
	local entity te;
	if (self.cutf_items & #CUTF_DOUBLESENTRY)
	{//look for the second sentry
//searching against a name is ugly, FIXME: search against the realowner and then check the name.
		te = find(world, classname, "building_sentrygun");
		while(te)
		{
			if (te.real_owner == self)
			if (te.dont_do_triggerwork & 2)
			{
				return te.health/te.max_health*100 + 101*(te.enemy != world)+201;
			}
			te = find(te, classname, "building_sentrygun");
		}
	}
	else
	{//look for the first tesla
		te = find(world, classname, "building_tesla");
		while(te)
		{
			if (te.real_owner == self)
			if (te.dont_do_triggerwork & 1)
			{
				return te.health/te.max_health*100 + 101*(te.enemy != world);
			}
			te = find(te, classname, "building_tesla");
		}
	}
	return 0;
};

//mutually exclusive things (actions)
float() SetPlayerStat34 =
{
	if (self.is_haxxxoring && self.job & #JOB_HACKER)
	{	//player is hacking
	    	if (self.demon_two.has_camera == -2)
		{	//aborting
			return 101;
		}
		else
		{	//progress
			return 100 - floor((self.demon_two.heat/self.demon_two.ltime)*100);
		}
	}
	if (self.is_detpacking)
	{	//setting up a bomb
		return 102;
	}
	if (self.is_building)
	{	//building something
		return 103;
	}

	return 0;
};

//spy
float() SetPlayerStat35 =
{
	float ret;
	if (!self.is_undercover)
		return 0;

	ret |= self.undercover_skin;
	ret |= (self.is_undercover)*20;
	return ret;
};

float(float soulnum) SetPlayerStatWarlockOrArmy =
{
	local entity targ;
	local float ret;
	targ = GetSummon(self, soulnum);
	if (!targ)
		return 0;

	if (targ.classname == "monster_shambler")
		ret = 301;
	else if (targ.classname == "monster_wizard")
		ret = 401;
	else if (targ.classname == "monster_demon1")
		ret = 501;
	else if (targ.classname == "monster_fish")
		ret = 601;
	else if (targ.classname == "monster_gremlin")
		ret = 701;
	//else assume monster_army

	return floor((targ.health / targ.max_health) * 100) + ret;
};

//warlock/army 1
float() SetPlayerStat36 =
{
	return SetPlayerStatWarlockOrArmy (0);
};

//warlock/army 2
float() SetPlayerStat37 =
{
	return SetPlayerStatWarlockOrArmy (1);
};

//warlock/army 3
float() SetPlayerStat38 =
{
	return SetPlayerStatWarlockOrArmy (2);
};

void() SetupFunctionsForCSQC =
{
	RealPlayerPostThink = PlayerPostThink;
	#func(PlayerPostThink);

	RealCopyToBodyQue = CopyToBodyQue;
	#func(CopyToBodyQue);
};
#endif
