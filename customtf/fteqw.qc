/*
==============================================================================

fteqw.qc

Porting effort from cpqwsv -> fteqwsv

Due to longer strings, FTE has less individual temporary strings, so the menus needed to be changed slightly too.
These cvars can be tweeked to mimic cpqwsv string usage:
pr_tempstringcount 128
pr_tempstringsize 256

==============================================================================
*/

#define CSQC

#define func(x) x = fte##x

#ifdef CSQC
#include "csqc_ss.qc"
#endif


void(vector v1, vector v2, float nomonsters, entity forent) ftebi_traceline = #16;
#define MOVE_NORMAL 0
#define MOVE_NOMONSTERS 1	//ignores bsp entities
#define MOVE_MISSILE 2		//a little extra size on bbox entities
#define MOVE_HITMODEL 4
#define MOVE_TRIGGER 16
#define MOVE_EVERYTHING 32

void (vector v1, vector v2, float nomonsters, entity forent) ftetraceline =
{
	if (nomonsters == MOVE_HITMODEL)	// HACK!
	{
		ftebi_traceline(v1, v2, #MOVE_HITMODEL, forent);
		return;
	}
	switch (nomonsters)
	{
	case #TL_ANY_SOLID: // will hit any solid, but not triggers
	default:
		nomonsters = #MOVE_NORMAL;
		break;
	case #TL_BSP_ONLY: // will hit BSP only
		nomonsters = #MOVE_NOMONSTERS;
		break;
	case #TL_TRIGGERS: // Scan for triggers too (findable triggers must be flagged with FL_FINDABLE_NONSOLID)
		nomonsters = #MOVE_TRIGGER;
		break;
	case #TL_EVERYTHING: // Scan for anything (Any NonSolid/Trigger entities must be flagged with FL_FINDABLE_NONSOLID)
		nomonsters = #MOVE_EVERYTHING;
		break;
	}

	ftebi_traceline(v1, v2, nomonsters, forent);
};

float (entity client) ftegetuid =
{
	return stof(infokey(client, "*userid"));
};

string(string s1, string s2) ftestrcat = #115;

string(float len, string str, ...) ftebi_padstr = #225;
string(string st, float len) ftepadstr =
{	//swap the parameters (fte allows multiple combined strings)
	return ftebi_padstr(len, st);
};

string(float ccase, float calpha, float cnumeric, string s, ...) ftebi_strconv = #224;
string(string srcstr, float action) ftecolstr =
{
	switch(action)
	{
	default:
	case #COLSTR_WHITE: // converts any red chars to white
		return ftebi_strconv(0, 1, 1, srcstr);
	case #COLSTR_MIX1: // mix red and white chars
		return ftebi_strconv(0, 5, 5, srcstr);
	case #COLSTR_RED: // converts any white chars to red
		return ftebi_strconv(0, 2, 2, srcstr);
	case #COLSTR_MIX2: // mix red and white chars
		return ftebi_strconv(0, 6, 6, srcstr);
	case #COLSTR_NUMBER: // converts any numbers to special number chars
		return ftebi_strconv(0, 0, 3, srcstr);
	case #COLSTR_NUMBERV: // second variant of special number chars (only different on rare charsets)
		return ftebi_strconv(0, 0, 4, srcstr);
	}
};


float(string st1, string st2) ftestrcasecmp = #229;
float(string st) ftestrlen = #114;

entity(string st) ftegetclient = #241;

float(entity client) ftemutedtime =
{
	dprint("mutedtime is not supported in FTE\n");
	return 0;
};

float frikfile_works;
float(string fname, float mode) ftebi_fopen = #110;
void(float handle) ftebi_fclose = #111;
float(string st) ftevalidatefile =
{
	local float h;

	if (!frikfile_works)
		return #FALSE;

	h = ftebi_fopen(st, 0);
	if (h >= 0)
	{
		ftebi_fclose(h);
		return #TRUE;
	}
	return #FALSE;
};

//acts like floodprot, I suppose.
void(entity client) fteputsaytime =
{
	dprint("putsaytime is not supported in FTE\n");
};

string(string st) ftemakestr = #118;
void(string st) ftedelstr = #119;



//DP_QC_SINCOSSQRTPOW
float(float) sin = #60;
//float(float) cos = #61;
float(float) sqrt = #62;
//float(float x, float y) pow = #97;

/*
==============
PF_getwave

float(float inputnum, float modes, float minnum, float maxnum, float balance, float offset, float shape) getwave
==============
*/

float GetCircleWave (float inputnum)
{
	inputnum = inputnum - floor(inputnum);

	if (inputnum >= 0.75) // -1 to 0
	{
		if (inputnum == 0.75)
			return -1;

		inputnum = inputnum - 0.75;

		inputnum = inputnum * 4;

		return (1 - sqrt(1 - (inputnum*inputnum))) - 1;
	}
	else if (inputnum >= 0.5) // 0 to -1
	{
		if (inputnum == 0.5)
			return 0;

		inputnum = inputnum - 0.5;

		inputnum = 0.25 - inputnum;
		inputnum = inputnum * 4;

		return (1 - sqrt(1 - (inputnum*inputnum))) - 1;
	}
	else if (inputnum >= 0.25) // 1 to 0
	{
		if (inputnum == 0.25)
			return 1;

		inputnum = inputnum - 0.25;

		inputnum = inputnum * 4;

		return sqrt(1 - (inputnum*inputnum));
	}
	else // 0 to 1
	{
		if (inputnum == 0)
			return 0;

		inputnum = 0.25 - inputnum;
		inputnum = inputnum * 4;

		return sqrt(1- (inputnum*inputnum));
	}

	return 0;
}

float GetLinearWave (float inputnum)
{
	inputnum = inputnum - floor(inputnum);

	if (inputnum <= 0.25)
		return inputnum / 0.25;
	else if (inputnum <= 0.5)
		return 1-((inputnum-0.25)/0.25);
	else if (inputnum <= 0.75)
		return - (inputnum-0.5)/0.25;
	else
		return -1 + (inputnum-0.75)/0.25;

	return 0;
}

#define M_PI 3.1415926535897932384626433832795

float(float inputnum, float modes, float minnum, float maxnum, float balance, float offset, float shape) ftegetwave =
{
	float retval, temp;


	if (!(modes & #GWAVE_USEOFFSET))
		offset = 0;

	// Use special shape?
	if (modes & #GWAVE_USESHAPE)
	{
		if (shape >= -1 && shape <= 1 && shape != 0)
		{
			if (shape < 0) // sine/linear mix
			{
				if (shape == -1) // full linear
					retval = GetLinearWave(inputnum+offset);
				else
				{
					// Get standard sinus
					retval = sin(2*#M_PI*(inputnum+offset));

					temp = GetLinearWave(inputnum+offset);
					retval = (retval*(1-fabs(shape))) + (temp*fabs(shape));
				}
			}
			else // sine/circular mix
			{
				if (shape == 1) // full circular
					retval = GetCircleWave(inputnum+offset);
				else
				{
					// Get standard sinus
					retval = sin(2*#M_PI*(inputnum+offset));

					temp = GetCircleWave(inputnum+offset);
					retval = retval*(1-shape) + temp*shape;
				}
			}
		}
		else // 0 or invalid shape
		{
			// Get standard sinus
			retval = sin(2*#M_PI*(inputnum+offset));
		}
	}
	else // dont use shape then..
	{
		// Get standard sinus
		retval = sin(2*#M_PI*(inputnum+offset));
	}

	// Use maximum/minimum values?
	if (modes & #GWAVE_USEMINMAX)
	{
		retval = minnum + ((retval + 1)/2)*(maxnum - minnum);
	}

	// Return it!
	return retval;
}

void(entity e, float chan, string samp, float vol, float atten) fteclientsound =
{
	dprint("clientsound is not supported in FTE\n");
};

void() ftetouchworld =
{
	walkmove(0,0);	//standard stuff, matey.
};

void() FigureOutClientVersion =
{
	local float f;
	f = stof(infokey(self, "*ProzacQW"));
	if (f)
	{
		self.cltype = #CLTYPE_PROZACQW;
		self.clversion = f;
		return;
	}
	f = stof(infokey(self, "*FuhQuake"));
	if (f)
	{
		self.cltype = #CLTYPE_FUHQUAKE;
		self.clversion = f;
		return;
	}
	f = stof(infokey(self, "*QWAMF"));
	if (f)
	{
		self.cltype = #CLTYPE_AMFQUAKE;
		self.clversion = f;
		return;
	}
	f = stof(infokey(self, "*z_ver"));
	if (f)
	{
		self.cltype = #CLTYPE_ZQUAKE;
		self.clversion = f;
		return;
	}
	f = stof(infokey(self, "*qf_version"));
	if (f)
	{
		self.cltype = #CLTYPE_QUAKEFORGE;
		self.clversion = f;
		return;
	}
	f = (infokey(self, "*ver") == "FTE");
	if (f)
	{
		self.cltype = #CLTYPE_FTEQUAKE;
		self.clversion = 0;
		return;
	}
	f = (infokey(self, "*client") == "ezQuake");
	if (f)
	{
		self.cltype = #CLTYPE_EZQUAKE;
		self.clversion = 0;
		return;
	}
	f = stof(infokey(self, "*ver"));
	if (f)
	{
		self.cltype = #CLTYPE_DEFAULT;
		self.clversion = f;
		return;
	}
	f = infokey(self, "*z_ext") != "";	//lets assume it's zquake if it supports the z_ext stuff but doesn't come with a version
	if (f)
	{
		self.cltype = #CLTYPE_ZQUAKE;
		self.clversion = 0;
		return;
	}
};

var void() RealClientConnect;
void() fteClientConnect =
{
	local float f;

	FigureOutClientVersion();

	RealClientConnect();

#ifdef CSQC
	SetupPlayerForCSQC();
#endif
};


float(string extname) ftebi_checkextension = #99;

//fteqwsv calls this function at map start, so it's a nice easy autodetection.
//in an ideal world, for maximum portability, you'd rename this, and call it from worldspawn (note that the renaming is important, as this can only be called once)
void() init =
{

	if (cvar("pr_checkextension"))
	{
		if (!ftebi_checkextension("FRIK_FILE"))
		{
			if (!ftebi_checkextension("ZQ_STRINGS"))
				error("Extension FRIK_FILE/ZQ_STRINGS not supported\n");
		}
		else
			frikfile_works = #TRUE;

		if (!ftebi_checkextension("KRIMZON_SV_PARSECLIENTCOMMAND"))
			error("Extension KRIMZON_SV_PARSECLIENTCOMMAND not supported\n");
		if (!ftebi_checkextension("FTE_STRINGS"))
			error("Extension FTE_STRINGS not supported\n");
		if (!ftebi_checkextension("DP_QC_SINCOSSQRTPOW"))
			error("Extension DP_QC_SINCOSSQRTPOW not supported\n");
#ifdef CSQC
		if (!ftebi_checkextension("EXT_CSQC"))
			error("Extension EXT_CSQC not supported\n");
#endif
	}
	else
		error("Extensions not supported\n");

	RealClientConnect = ClientConnect;

#ifdef CSQC
	SetupFunctionsForCSQC();
#endif

	#func(ClientConnect);

	#func(traceline);	//conflicting extensions, so remap some stuff.

	#func(getuid);
	#func(strcat);
	#func(padstr);
	#func(colstr);
	#func(strcasecmp);
	#func(strlen);
	#func(getclient);
	#func(mutedtime);
	#func(validatefile);
	#func(putsaytime);
	#func(makestr);
	#func(delstr);
	#func(getwave);
	#func(clientsound);
	#func(touchworld);
};

//KRIMZON_SV_PARSECLIENTCOMMAND
void(entity e, string s) ftebi_clientcommand = #440;
float(string s) ftebi_tokenize = #441;
string(float n) ftebi_argv = #442;
void(string in) SV_ParseClientCommand =
{
	float argcount;
	string s1,s2,s3,s4,s5,s6,s7;
	argcount = ftebi_tokenize(in);
	s1 = ftebi_argv(0);
	s2 = ftebi_argv(1);
	s3 = ftebi_argv(2);
	s4 = ftebi_argv(3);
	s5 = ftebi_argv(4);
	s6 = ftebi_argv(5);
	s7 = ftebi_argv(6);

	if (s1 == "rate" || s1 == "pings" || s1 == "say" || s1 == "say_team" || s1 == "nextdl" || s1 == "download" || s1 == "setinfo" || s1 == "serverinfo" || s1 == "drop" || s1 == "snap" || s1 == "msg" || s1 == "new" || s1 == "modellist" || s1 == "soundlist" || s1 == "prespawn" || s1 == "spawn" || s1 == "begin" || s1 == "ptrack" || s1 == "pause")
	{	//don't pass it on to the mod
		ftebi_clientcommand(self, in);
		return;
	}
	if (!ClientCommand(argcount, s1, s2, s3, s4, s5, s6, s7))
		ftebi_clientcommand(self, in);
};

//NQ-style rules.
.float items2;
var .float runes_owned = items2;
