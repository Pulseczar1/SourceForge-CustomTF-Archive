/*
==============================================================================

Vote.QC
CustomTF 3.2.OfN

 Voting system functions and stuff...
 (Requires PROZAC qwsv, uses special built-ins)
 (FTEWQ hack prevents some punishments from occuring)
==============================================================================
*/

// Flag defines

// vote entity types
#define VOTE_PUNISH 		0
#define VOTE_NEXTMAP		1
#define VOTE_SWITCHMAP		2

// punish types
#define PUNISH_CURSE		0
#define PUNISH_KICK 		1
#define PUNISH_BAN			2
#define PUNISH_MUTE 		3
#define PUNISH_CUFF 		4

// player voting status
#define VOTED_JUSTJOINED	0
#define VOTED_READY 		1
#define VOTED_YES			2
#define VOTED_NO			3

// Settings defines

#define VOTE_TIME			40
#define VOTE_TIME_REFRESH	25
#define VOTE_DELAY			240 // seconds to wait until another vote from same user is allowed

// Number of votes required for each action

#define VOTESNEEDED_CURSE	4
#define VOTESNEEDED_MUTE	4
#define VOTESNEEDED_KICK	5
#define VOTESNEEDED_CUFF	5
#define VOTESNEEDED_BAN 	6
#define VOTESNEEDED_MAP 	6
#define VOTESNEEDED_NEXTMAP 4

#define NEEDEDVOTES_NEXTMAP_FACTOR	0.51 // 0.50
#define NEEDEDVOTES_MAP_FACTOR		0.51 // 0.60  // 0.65

//#define BAN_VOTED_TIME		0 // permanent ban
#define BAN_VOTED_TIME		 60 // 60 minutes
#define MUTE_VOTED_TIME 	 30
#define CUFF_VOTED_TIME 	 15

#ifdef VOTING_TEST
#define VOTE_DELAY			0 // for testing
#endif

#define VOTESLEEP_RATECHECK   5 // Rate in seconds of the think for sleeping votes
#define VOTESLEEP_DURATION	 10 // Maximum minutes for a vote to be sleeping before getting discarded

/*===============================================================================================

EXPLANATION OF HOW THE ENTITY FIELDS ARE USED (thnx? np.. :P)
---------------------------------------------

Global vars used:
-----------------

current_voteent   - Points to current vote entity, if any, if not it points to world

For player entity:
------------------

.g_a			  - Contains the type of punishment selected on menu
.goal_no		  - Controls delay between same client votes
.group_no		  - Flag determines if we are choosing next map, or switch to modes
.goal_state 	  - Determines what page of maps to be shown for voting
.owned_by		  - Contains #VOTED_XXXX, yes, no or NOT_VOTED

For vote entity:
----------------

.has_sentry 		 - Type of vote
.g_a				 - Type of punishment to vote
.admin_kick 		 - Player to be punished
.all_active 		 - Number of affirmative votes
.has_holo			 - Number of negative votes
.group_no			 - Type of votemap, nextmap or switchmap
.has_tesla			 - Number of map beeing voted
.dont_do_triggerwork - If TRUE, means the player to be banned has left
	(when banning a user that left)
.t_s_h				 - Permanent string containing IP to be banned
.t_s_m				 - Permanent string with the name of user to be banned
	(when map voting)
.netname			 - Permanent string that is the name of map

===============================================================================================*/

void() PunishClientCycle;
void() StartPunishmentVote;
void() CleanClientVotes;
void() ResetClientsMenu;
float() ValidVoteEnt;
float() CheckVoting;
void(float nummap, string themap) StartVoteMap;
string(float themap) GetMapString;
void() bprintVotesLeft;
float() GetRemainingVotes;
void() CleanUpSleepVote;
void() VoteSleep_think;

// External
void(string text) CmdMsg;

//====================================================================================================
// both player and spectators share the same menu handlers for voting, so we need this

void() AllResetMenu =
{
	if (self.classname == "spec")
		SpecResetMenu();
	else if (self.classname == "player")
		ResetMenu();
};

void() Player_Punish =
{
	if (self.playerclass == #PC_UNDEFINED && self.classname == "player") // Observers
		return;

	if (current_voteent != world)
	{
		sprint(self,#PRINT_HIGH,"Already running a vote!\n");
		return;
	}

	if (self.goal_no > time)
	{
		sprint(self,#PRINT_HIGH,"You just ran a vote!\n");
		return;
	}

	if (self.classname == "player")
		self.current_menu = #MENU_PUNISH;
	else if (self.classname == "spec")
		self.current_menu = #SPEC_MENU_PUNISH;
	else
		return;
		//RPrint("BUG: Non-spec/player on Player_Punish()\n");

	CuTFMenuSound(#MENUSOUND_BUY);
	Menu_Punish();
	BackFlash(self,1);
};

void() Menu_Punish =
{
	local string st, st2, st3;

	// if we didn't disconnect and we are a valid class, player or spectator..
	if (HasValidAdminTarget2(self))
	{
		st2 = self.admin_kick.netname;

		if (self.admin_kick.classname == "spec")
			st="\sUser\s: \{188}spectator\{190} \n\n";
		else
			st="\sUser\s:             \n\n";
	}
	else
		st2 = "\sUser\s:             \n\nNo user selected! ";

	if (self.g_a == #PUNISH_BAN)
		st3 = "\3.. Ban\{161}          ";
	else if (self.g_a == #PUNISH_KICK)
		st3 = "\3.. Kick\{161}         ";
	else if (self.g_a == #PUNISH_MUTE)
		st3 = "\3.. Mute\{161}         ";
	else if (self.g_a == #PUNISH_CUFF)
		st3 = "\3.. Cuff\{161}         ";
	else
		st3 = "\3.. Curse\{161}        ";

	CenterPrint5(self,st,st2,"\n\n\1.. Next User\s...\s  \n\n\2.. \sChoose Action\s:\n\n",st3,"\n\n\0\s.. Exit\s          \n");

};

void(float input) Menu_Punish_Input =
{
	if (input == 1)
	{
		PunishClientCycle();
		CuTFMenuSound(#MENUSOUND_BROWSE);
		Menu_Punish();
		self.impulse = 0;
		return;
	}
	else if (input == 2)
	{
		if (self.g_a == #PUNISH_CURSE)
			self.g_a = #PUNISH_KICK;
		else if (self.g_a == #PUNISH_KICK)
			self.g_a = #PUNISH_MUTE;
		else if (self.g_a == #PUNISH_MUTE)
			self.g_a = #PUNISH_BAN;
		else if (self.g_a == #PUNISH_BAN)
			self.g_a = #PUNISH_CUFF;
		else self.g_a = #PUNISH_CURSE;

		CuTFMenuSound(#MENUSOUND_BUY);
		Menu_Punish();
		self.impulse = 0;
		return;
	}
	else if (input == 3)
	{
		self.impulse = 0;

		if (current_voteent != world)
		{
			sprint(self,#PRINT_HIGH,"Already running a vote!\n");
			AllResetMenu();
			return;
		}
		else if (self.admin_kick == world)
			sprint(self,#PRINT_HIGH,"No user selected!\n");
		else if (!self.admin_kick.is_connected)
		{
			sprint(self,#PRINT_HIGH,"User has left the server!\n");
			PunishClientCycle();
		}
		else if (self.admin_kick.classname=="spec" && self.g_a == #PUNISH_CURSE)
			sprint(self,#PRINT_HIGH,"Can't curse spectators!\n");
		else if (self.admin_kick.classname=="spec" && self.g_a == #PUNISH_CUFF)
			sprint(self,#PRINT_HIGH,"Can't cuff spectators!\n");
		else if (self.admin_kick.classname != "spec" && self.admin_kick.classname != "player")
			sprint(self,#PRINT_HIGH,"Invalid user selected!\n");
		else
		{
			StartPunishmentVote();
			AllResetMenu();
			return;
		}

		CuTFMenuSound(#MENUSOUND_WRONG);
	}
	else if (input == 10)
	{
		AllResetMenu();
		CuTFMenuSound(#MENUSOUND_SELL);
		BackFlash(self,1);
		self.impulse = 0;
		return;
	}

	self.impulse = 0;
};

void() Player_VoteMap =
{
	if (self.playerclass == #PC_UNDEFINED && self.classname == "player") // Observers
		return;

	if (current_voteent != world)
	{
		sprint(self,#PRINT_HIGH,"Already running a vote!\n");
		return;
	}

	if (time/60 < 1)
	{
		sprint(self,#PRINT_HIGH,"Too early for a map vote!\n");
		return;
	}

	if (self.goal_no > time)
	{
		sprint(self,#PRINT_HIGH,"You just ran a vote!\n");
		return;
	}

	if (ServerUpdating())
	{
		sprint(self,#PRINT_HIGH,"Server update is taking place, no map changes are allowed!\n");
		return;
	}

	if (self.classname == "player")
		self.current_menu = #MENU_VOTEMAP;
	else if (self.classname == "spec")
		self.current_menu = #SPEC_MENU_VOTEMAP;
	else
		return;
	//RPrint("BUG: Non-spec/player on Player_VoteMap()\n");

	CuTFMenuSound(#MENUSOUND_BUY);
	Menu_VoteMap();
	BackFlash(self,1);
};

void() Menu_VoteMap =
{
	local string paddedstr,st1,st2,st3,st4,st5,st6,st7,keyst,color;

	keyst = GetMapString(self.goal_state*6+1);
	if (mapname == keyst)
	{
		color = colstr(keyst,#COLSTR_RED);
		if (self.#cprint_fx & 1)
			keyst = strcat(color," [\sPlaying\s]");
		else
			keyst = strcat(color," \{144}playing\{145}");
		color = keyst;
	}
	else
		color = keyst;
	paddedstr = padstr(color,18);
	if (self.goal_state == 0)
		st1 = strcat("\sAvaliable Maps\s: \{168}page 1\{175}6\{169}\n\n\1.. ",paddedstr);
	else if (self.goal_state == 1)
		st1 = strcat("\sAvaliable Maps\s: \{168}page 2\{175}6\{169}\n\n\1.. ",paddedstr);
	else if (self.goal_state == 2)
		st1 = strcat("\sAvaliable Maps\s: \{168}page 3\{175}6\{169}\n\n\1.. ",paddedstr);
	else if (self.goal_state == 3)
		st1 = strcat("\sAvaliable Maps\s: \{168}page 4\{175}6\{169}\n\n\1.. ",paddedstr);
	else if (self.goal_state == 4)
		st1 = strcat("\sAvaliable Maps\s: \{168}page 5\{175}6\{169}\n\n\1.. ",paddedstr);
	else
		st1 = strcat("\sAvaliable Maps\s: \{168}page 6\{175}6\{169}\n\n\1.. ",paddedstr);

	keyst = GetMapString(self.goal_state*6+2);
	if (mapname == keyst)
	{
		color = colstr(keyst,#COLSTR_RED);
		if (self.#cprint_fx & 1)
			keyst = strcat(color," [\sPlaying\s]");
		else
			keyst = strcat(color," \{144}playing\{145}");
		color = keyst;
	}
	else
		color = keyst;
	paddedstr = padstr(color,18);
	st2 = strcat(st1, "\n\2.. ");
	st2 = strcat(st2,paddedstr);

	keyst = GetMapString(self.goal_state*6+3);
	if (mapname == keyst)
	{
		color = colstr(keyst,#COLSTR_RED);
		if (self.#cprint_fx & 1)
			keyst = strcat(color," [\sPlaying\s]");
		else
			keyst = strcat(color," \{144}playing\{145}");
		color = keyst;
	}
	else
		color = keyst;
	paddedstr = padstr(color,18);
	st3 = strcat(st2, "\n\3.. ");
	st3 = strcat(st3, paddedstr);

	keyst = GetMapString(self.goal_state*6+4);
	if (mapname == keyst)
	{
		color = colstr(keyst,#COLSTR_RED);
		if (self.#cprint_fx & 1)
			keyst = strcat(color," [\sPlaying\s]");
		else
			keyst = strcat(color," \{144}playing\{145}Ý");
		color = keyst;
	}
	else
		color = keyst;
	paddedstr = padstr(color,18);
	st4 = strcat(st3, "\n\4.. ");
	st4 = strcat(st4, paddedstr);

	keyst = GetMapString(self.goal_state*6+5);
	if (mapname == keyst)
	{
		color = colstr(keyst,#COLSTR_RED);
		if (self.#cprint_fx & 1)
			keyst = strcat(color," [\sPlaying\s]");
		else
			keyst = strcat(color," \{144}playing\{145}");
		color = keyst;
	}
	else
		color = keyst;
	paddedstr = padstr(color,18);
	st5 = strcat(st4, "\n\5.. ");
	st5 = strcat(st5, paddedstr);

	keyst = GetMapString(self.goal_state*6+6);
	if (mapname == keyst)
	{
		color = colstr(keyst,#COLSTR_RED);
		if (self.#cprint_fx & 1)
			keyst = strcat(color," [\sPlaying\s]");
		else
			keyst = strcat(color," \{144}playing\{145}");
		color = keyst;
	}
	else
		color = keyst;
	paddedstr = padstr(color,18);
	st6 = strcat(st5, "\n\6.. ");
	st6 = strcat(st6,paddedstr);

	if (self.group_no == 0)
		st7 ="\n\n\7.. \sMode\s: as next map \n\n\8.. \sPrev Page\s         \n\9.. \sNext Page\s         \n\n\0\s.. Exit\s              \n";
	else
		st7 ="\n\n\7.. \sMode\s: play now¡  \n\n\8.. \sPrev Page\s         \n\9.. \sNext Page\s         \n\n\0\s.. Exit\s               \n";

	CenterPrint2(self,st6,st7);

	self.#cprint_fx = self.#cprint_fx + 1;
};

void(float input) Menu_VoteMap_Input =
{
	if (input >= 1 && input <= 6)
	{
		if (current_voteent != world)
		{
			sprint(self,#PRINT_HIGH,"Already running a vote!\n");
			AllResetMenu();
			self.impulse = 0;
			return;
		}

		local float nummap;

		nummap = input + (self.goal_state*6);

		StartVoteMap(nummap,"");
		AllResetMenu();
	}
	else if (input == 7)
	{
		if (self.group_no == 0)
			self.group_no = 1;
		else self.group_no = 0;

		CuTFMenuSound(#MENUSOUND_BUY);

		NoCprintFX();
		Menu_VoteMap();
	}
	else if (input == 8)
	{
		self.goal_state = self.goal_state - 1;
		if (self.goal_state < 0)
			self.goal_state = 5;

		CuTFMenuSound(#MENUSOUND_BROWSE);

		NoCprintFX();
		Menu_VoteMap();
	}
	else if (input == 9)
	{
		self.goal_state = self.goal_state + 1;
		if (self.goal_state > 5)
			self.goal_state = 0;

		CuTFMenuSound(#MENUSOUND_BROWSE);

		NoCprintFX();
		Menu_VoteMap();
	}
	else if (input == 10)
	{
		AllResetMenu();
		CuTFMenuSound(#MENUSOUND_SELL);
		BackFlash(self,1);
	}

	self.impulse = 0;
};

//===============================================================
// bprints the current voting issue

void() bprintVoteIssue =
{
	if (current_voteent.has_sentry == #VOTE_PUNISH)
	{
		if (current_voteent.dont_do_triggerwork) // Special ban (client has left)
		{
			bprint(#PRINT_HIGH," \{168}ban ");
			bprint(#PRINT_HIGH,current_voteent.t_s_m);
			bprint(#PRINT_HIGH,"\{169}");
		}
		else
		{
			if (current_voteent.g_a == #PUNISH_CURSE)
				bprint(#PRINT_HIGH," \{168}curse ");
			else if (current_voteent.g_a == #PUNISH_KICK)
				bprint(#PRINT_HIGH," \{168}kick ");
			else if (current_voteent.g_a == #PUNISH_BAN)
				bprint(#PRINT_HIGH," \{168}ban ");
			else if (current_voteent.g_a == #PUNISH_MUTE)
				bprint(#PRINT_HIGH," \{168}mute ");
			else if (current_voteent.g_a == #PUNISH_CUFF)
				bprint(#PRINT_HIGH," \{168}cuff ");

			bprint(#PRINT_HIGH,current_voteent.admin_kick.netname);
			bprint(#PRINT_HIGH,"\{169}");
		}
	}
	else if (current_voteent.has_sentry == #VOTE_NEXTMAP) // as next map
	{
		bprint(#PRINT_HIGH," \{168}"); // FIXME: CPQCCX compiler says 'Not a name' if only "(" is used ???
		bprint(#PRINT_HIGH, current_voteent.netname);
		bprint(#PRINT_HIGH," as next map\{169}");
	}
	else if (current_voteent.has_sentry == #VOTE_SWITCHMAP)
	{
		bprint(#PRINT_HIGH," \{168}switch to ");
		bprint(#PRINT_HIGH,current_voteent.netname);
		bprint(#PRINT_HIGH,"\{169}");
	}
};

//==============================================================
// user has used the VoteYes impulse command

void() Player_VoteYes =
{
	if (self.playerclass == #PC_UNDEFINED && self.classname == "player") // Observers
		return;

	if (current_voteent == world)
	{
		sprint(self,#PRINT_HIGH,"Not voting currently!\n");
		return;
	}

	//if (current_voteent.has_sentry == #VOTE_PUNISH)
	if (self.owned_by == #VOTED_JUSTJOINED)
	{
		sprint(self,#PRINT_HIGH,"You weren't in game when this vote started!\n");
		return;
	}
	#ifndef VOTING_TEST
	else if (current_voteent.admin_kick == self)
	{
		sprint(self,#PRINT_HIGH,"You are not allowed to vote!\n");
		return;
	}
	else if (self.owned_by == #VOTED_NO || self.owned_by == #VOTED_YES)
	{
		sprint(self,#PRINT_HIGH,"You already voted!\n");
	}
	else
	{
	#endif
		BackFlash(self,1);

		bprint(#PRINT_HIGH,"Voting\{141} ");
		bprint(#PRINT_HIGH,self.netname);
		bprint(#PRINT_HIGH," agrees");

		self.owned_by = #VOTED_YES;

		bprintVoteIssue();

		BroadcastSound("misc/basekey");

		current_voteent.all_active = current_voteent.all_active + 1;

		if (current_voteent.nextthink < time + #VOTE_TIME_REFRESH)
			current_voteent.nextthink = time + #VOTE_TIME_REFRESH;

		if (!CheckVoting())
			bprintVotesLeft();
	#ifndef VOTING_TEST
	}
	#endif
};

//==============================================================
// user has used the VoteNo impulse command

void() Player_VoteNo =
{
	if (self.playerclass == #PC_UNDEFINED && self.classname == "player") // Observers
		return;

	if (current_voteent == world)
	{
		sprint(self,#PRINT_HIGH,"Not voting currently!\n");
		return;
	}

	//if (current_voteent.has_sentry == #VOTE_PUNISH)
	if (self.owned_by == #VOTED_JUSTJOINED)
	{
		sprint(self,#PRINT_HIGH,"You weren't in game when this vote started!\n");
		return;
	}

	#ifndef VOTING_TEST
	else if (current_voteent.admin_kick == self)
	{
		sprint(self,#PRINT_HIGH,"You are not allowed to vote!\n");
		return;
	}
	else if (self.owned_by == #VOTED_NO || self.owned_by == #VOTED_YES)
	{
		sprint(self,#PRINT_HIGH,"You already voted!\n");
	}
	else
	{
	#endif
		BackFlash(self,1);

		bprint(#PRINT_HIGH,"Voting\{141} ");
		bprint(#PRINT_HIGH,self.netname);
		bprint(#PRINT_HIGH," disagrees");

		self.owned_by = #VOTED_NO;

		bprintVoteIssue();

		BroadcastSound("misc/basekey");

		current_voteent.has_holo = current_voteent.has_holo +1;

		if (current_voteent.nextthink < time + #VOTE_TIME_REFRESH)
			current_voteent.nextthink = time + #VOTE_TIME_REFRESH;

		if (!CheckVoting())
			bprintVotesLeft();

	#ifndef VOTING_TEST
	}
	#endif
};

//========================================================================
// cycles through all clients as target for punishment

void() PunishClientCycle =
{
	local entity te;
	local float num;
	num = #FALSE;

	te = world; // none

	te = find(self.admin_kick, classname, "player");
	while (te != world && num == #FALSE)
	{
		num = #TRUE;

		if (!te.is_connected)
			num = #FALSE;

		if (self.admin_kick==te)
			num = #FALSE;

		#ifndef VOTING_TEST
		if (te == self)
			num = #FALSE;
		#endif

		if (num == #FALSE) te = find(te, classname, "player");
	}

	if (te == world) // if out of players on our search lets scan for spectators
	{
		te = find(self.admin_kick, classname, "spec");
		while (te != world && num == #FALSE)
		{
			num = #TRUE;

			if (!te.is_connected)
				num = #FALSE;

			if (self.admin_kick==te)
				num = #FALSE;

			#ifndef VOTING_TEST
			if (te == self)
				num = #FALSE;
			#endif

			if (num == #FALSE) te = find(te, classname, "spec");
		}
	}

	if (te == world)
		self.admin_kick=world; // No clients found!
	else
		self.admin_kick = te;
};

//========================================================================
// deletes current vote entity, if it exists, and performs clean up

void() ResetVoteEnt =
{
	if (current_voteent.classname == "voteent")
	{
		if (current_voteent.has_sentry == #VOTE_NEXTMAP || current_voteent.has_sentry == #VOTE_SWITCHMAP)
			delstr(current_voteent.netname);

		if (current_voteent.dont_do_triggerwork)
		{
			delstr(current_voteent.t_s_h);
			delstr(current_voteent.t_s_m);
		}

		dremove(current_voteent);
		current_voteent = world;
	}
	else current_voteent = world;
};

//==========================================================================
// gets number of clients currently on server, including spectators

float() GetNoClients =
{
	return num_players + num_specs;

	/*local entity te;
	local float clients;
	clients = 0;

	te = find(world, classname, "player");
	while (te != world)
	{
		if (!te.has_disconnected)
			clients = clients + 1;

		te = find(te, classname, "player");
	}

	te = find(world, classname, "spec");
	while (te != world)
	{
		if (!te.has_disconnected)
			clients = clients + 1;

		te = find(te, classname, "spec");
	}

	return clients;*/
};

void() PunishVote_Think;

//=================================================================
// Start punishment voting, self = player issuer of vote

void() StartPunishmentVote =
{
	if (no_punish)
	{
		CmdMsg("Punishment votes are disabled, sorry!\n");
		return;
	}

	if (self.classname != "player" && self.classname != "spec")
	{
		sprint(self,#PRINT_HIGH,"You can't vote still, join the game first!\n");
		return;
	}

	if (mutedtime(self))
	{
		sprint(self,#PRINT_HIGH,"You can't start a vote while muted!\n");
		return;
	}

	BackFlash(self,1);

	CleanClientVotes();

	local entity voteent;

	voteent = spawn();
	voteent.g_a = self.g_a;
	voteent.think = PunishVote_Think;
	voteent.nextthink = time + #VOTE_TIME;
	voteent.classname = "voteent";
	voteent.owner = world; // ADDED

	voteent.all_active = 1;
	voteent.has_holo = 0;

	voteent.demon_one = self;

	voteent.admin_kick = self.admin_kick;

	voteent.has_sentry = #VOTE_PUNISH;

	self.goal_no = time + #VOTE_DELAY;

	self.owned_by = #VOTED_YES; // we already voted yes

	BroadcastSound("misc/medkey");

	bprint(#PRINT_HIGH,"Voting\{141} ");

	bprint(#PRINT_HIGH,self.netname);
	bprint(#PRINT_HIGH," proposes to ");

	if (self.g_a == #PUNISH_CURSE)
		bprint(#PRINT_HIGH,"curse ");
	else if (self.g_a == #PUNISH_KICK)
		bprint(#PRINT_HIGH,"kick ");
	else if (self.g_a == #PUNISH_MUTE)
		bprint(#PRINT_HIGH,"mute ");
	else if (self.g_a == #PUNISH_BAN)
		bprint(#PRINT_HIGH,"ban ");
	else if (self.g_a == #PUNISH_CUFF)
		bprint(#PRINT_HIGH,"cuff ");

	bprint(#PRINT_HIGH,self.admin_kick.netname);

	bprint(#PRINT_HIGH,", type \{162}VoteYes\{162} or \{162}VoteNo\{162} to vote\n");

	current_voteent = voteent;

	current_voteent.dont_do_triggerwork = #FALSE;

	ResetClientsMenu(); // reset menus on players/specs which r on MENU_PUNISH or MENU_VOTEMAP

	CheckVoting(); // If we are the only player on server, checks
};

void() PunishVote_Think =
{
	bprint(#PRINT_HIGH,"Voting\{141} Punishment vote has failed");
	bprintVoteIssue();
	bprint(#PRINT_HIGH,"\n");

	BroadcastSound("misc/runekey");

	ResetVoteEnt();
};

void() VoteMap_Think;

//=================================================================
// Start map voting, self = player issuer of vote

void(float nummap, string themap) StartVoteMap =
{
	if (no_votemap)
	{
		CmdMsg("Map voting within the mod is disabled, sorry!\n");
		return;
	}

	if (self.classname != "player" && self.classname != "spec")
	{
		sprint(self,#PRINT_HIGH,"You can't vote still, join the game first!\n");
		return;
	}

	if (time/60 < #MIN_MINUTES_TOVOTEMAP)
	{
		sprint(self,#PRINT_HIGH,"Too early for a map change!\n");
		return;
	}

	if (mutedtime(self))
	{
		sprint(self,#PRINT_HIGH,"You can't start a vote while muted!\n");
		return;
	}

	if (ServerUpdating())
	{
		sprint(self,#PRINT_HIGH,"Server update is taking place, no map changes are allowed!\n");
		return;
	}

	BackFlash(self,1);

	local entity voteent;

	voteent = spawn();
	voteent.g_a = self.g_a;
	voteent.think = VoteMap_Think;
	voteent.nextthink = time + #VOTE_TIME;
	voteent.classname = "voteent";
	voteent.owner = world; // ADDED

	if (!nummap)
	{
		voteent.netname = themap;

		#ifdef UNABLE_TOVOTE_FORSAME_MAP
		// Don't let votes to switch to current map
		if (voteent.netname == mapname && self.group_no == 1)
		{
			sprint(self,#PRINT_HIGH,"You can't start voting for a map that is currently being played!\n");
			CuTFMenuSound(#MENUSOUND_WRONG);
			dremove(voteent);
			voteent = world;
			return;
		}
		#endif

		voteent.netname = makestr(voteent.netname);
		voteent.has_tesla = 0;
	}
	else
	{
		voteent.netname = GetMapString(nummap);

		// Abort if empty map name on localinfo
		if (voteent.netname == "")
		{
			sprint(self,#PRINT_HIGH,"You can't choose an empty map slot!\n");
			CuTFMenuSound(#MENUSOUND_WRONG);
			dremove(voteent);
			voteent = world;
			return;
		}

		#ifdef UNABLE_TOVOTE_FORSAME_MAP
		// Don't let votes to switch to current map
		if (voteent.netname == mapname && self.group_no == 1)
		{
			sprint(self,#PRINT_HIGH,"You can't start voting for a map that is currently being played!\n");
			CuTFMenuSound(#MENUSOUND_WRONG);
			dremove(voteent);
			voteent = world;
			return;
		}
		#endif

		voteent.netname = makestr(voteent.netname);
		voteent.has_tesla = nummap;
	}

	CleanClientVotes();

	voteent.all_active = 1;
	voteent.has_holo = 0;

	if (self.group_no == 0)
		voteent.has_sentry = #VOTE_NEXTMAP;
	else
		voteent.has_sentry = #VOTE_SWITCHMAP;

	current_voteent = voteent;

	self.goal_no = time + #VOTE_DELAY;

	self.owned_by = #VOTED_YES; // we already voted yes

	voteent.group_no = self.group_no;

	current_voteent.dont_do_triggerwork = #FALSE;

	BroadcastSound("misc/medkey");

	themap = colstr(current_voteent.netname,#COLSTR_RED);

	bprint(#PRINT_HIGH,"Voting\{141} ",self.netname);

	if (self.group_no == 0)
		bprint(#PRINT_HIGH," suggests ",themap," as next map");
	else
		bprint(#PRINT_HIGH," wants to play ",themap," right now");

	bprint(#PRINT_HIGH,", type \{162}VoteYes\{162} or \{162}VoteNo\{162} to vote\n");

	ResetClientsMenu(); // reset menus on players/specs which r on MENU_PUNISH or MENU_VOTEMAP

	CheckVoting(); // If we are the only player on server must check
};

void() VoteMap_Think =
{
	bprint(#PRINT_HIGH,"Voting\{141} Map voting failed");

	bprintVoteIssue();

	bprint(#PRINT_HIGH,"\n");

	BroadcastSound("misc/runekey");

	ResetVoteEnt();
};

//==================================================================
// resets all clients to ready-to-vote state

void() CleanClientVotes =
{
	local entity te;

	te = find(world, classname, "player");
	while (te != world)
	{
		if (te.is_connected)
			te.owned_by = #VOTED_READY;

		te = find(te, classname, "player");
	}

	te = find(world, classname, "spec");
	while (te != world)
	{
		if (te.is_connected)
			te.owned_by = #VOTED_READY;

		te = find(te, classname, "spec");
	}
};

//=============================================================================
// clear menus of clients that have vote menus on - WATCHOUT - Using self

void() ResetClientsMenu =
{
	local entity te;

	te = find(world, classname, "player");
	while (te != world)
	{
		if (te.is_connected)
		if (te != self)
		if (te.current_menu == #MENU_PUNISH || te.current_menu == #MENU_VOTEMAP)
		{
			sprint(te,#PRINT_HIGH,"Already running a vote!\n");
			CenterPrint(te,"\n");
			te.current_menu = #MENU_DEFAULT;
		}

		te = find(te, classname, "player");
	}

	te = find(world, classname, "spec");
	while (te != world)
	{
		if (te.is_connected)
		if (te != self)
		if (te.current_menu == #SPEC_MENU_PUNISH || te.current_menu == #SPEC_MENU_VOTEMAP)
		{
			sprint(te,#PRINT_HIGH,"Already running a vote!\n");
			CenterPrint(te,"\n");
			te.current_menu = #SPEC_MENU_NONE;
		}

		te = find(te, classname, "spec");
	}
};

//==========================================================================
// called after each vote (yes or no) to see if its a succesfull vote

float() CheckVoting =
{
	// this shouldn't be needed
	if (current_voteent == world || current_voteent.classname!="voteent")
	{
		bprint(#PRINT_HIGH,"\nVoting\{141} Error in voting system!\n");
		ResetVoteEnt();
		return #TRUE;
	}

	// If an update is taking place, dont allow map voting
	if (current_voteent.has_sentry == #VOTE_NEXTMAP || current_voteent.has_sentry == #VOTE_SWITCHMAP)
	if (ServerUpdating())
	{
		bprint(#PRINT_HIGH,"\nVoting\{141} Server update is taking place, no map changes are allowed\n");
		ResetVoteEnt();
		return #TRUE;
	}

	local float numclients;
	local string st;

	numclients = GetNoClients();

	if (current_voteent.has_sentry == #VOTE_PUNISH) // Punishment voting
	{
		// Check for a valid client as target
		if (!current_voteent.dont_do_triggerwork) // only if not a special ban (user left)
		if ((current_voteent.admin_kick.classname != "player" && current_voteent.admin_kick.classname != "spec") || !current_voteent.admin_kick.is_connected)
		{
			bprint(#PRINT_HIGH,"\nVoting\{141} Invalid client as target for vote!\n");
			ResetVoteEnt();
			return #TRUE;
		}

		if (current_voteent.g_a == #PUNISH_CURSE) // Curse
		{
			if (current_voteent.all_active - current_voteent.has_holo >= #VOTESNEEDED_CURSE) // success?
			{
				local float tf;

				tf = 0;
				st = infokey(world, "curse");

				if (st == string_null)
					tf = stof(st);

				bprint(#PRINT_HIGH,"\nVoting\{141} Democracy says ");
				bprint(#PRINT_HIGH,current_voteent.admin_kick.netname);
				bprint(#PRINT_HIGH," must be cursed\n");

				BroadcastSound("doors/runeuse");

				createBastard(current_voteent.admin_kick,tf);

				ResetVoteEnt(); // removes current vote entity

				return #TRUE;
			}
		}
		else if (current_voteent.g_a == #PUNISH_KICK) // Kick
		{
			if (current_voteent.all_active - current_voteent.has_holo >= #VOTESNEEDED_KICK) // success?
			{
				bprint(#PRINT_HIGH,"\nVoting\{141} Democracy says ");
				bprint(#PRINT_HIGH,current_voteent.admin_kick.netname);
				bprint(#PRINT_HIGH," must be kicked\n");

				bprint(#PRINT_HIGH, current_voteent.admin_kick.netname);
				bprint(#PRINT_HIGH, " is \sKICKED\s from the server\n");

				sprint(current_voteent.admin_kick,#PRINT_HIGH,"\nYou have been \sKICKED\s from the server!\n");

				stuffcmd(current_voteent.admin_kick, "disconnect\n"); //Kick them!

				BroadcastSound("player/teledth1");

				ResetVoteEnt(); // removes current vote entity

				return #TRUE;
			}
		}
		else if (current_voteent.g_a == #PUNISH_BAN) // Ban!
		{
			if (current_voteent.all_active - current_voteent.has_holo >= #VOTESNEEDED_BAN) // success?
			{
				bprint(#PRINT_HIGH,"\nVoting\{141} Democracy says ");

				if (current_voteent.dont_do_triggerwork) // Special ban (user has left)
				{
					bprint(#PRINT_HIGH,current_voteent.t_s_m);
					bprint(#PRINT_HIGH," must be banned\n");

					bprint(#PRINT_HIGH, current_voteent.t_s_m);
					bprint(#PRINT_HIGH, " is \sBANNED\s from the server\n");

					localcmd("addip ");
					localcmd(current_voteent.t_s_h);
					localcmd(" #BAN_VOTED_TIME");
					localcmd("\n");

					BroadcastSound("doors/runeuse");
				}
				else
				{
					bprint(#PRINT_HIGH,current_voteent.admin_kick.netname);
					bprint(#PRINT_HIGH," must be banned\n");

					bprint(#PRINT_HIGH, current_voteent.admin_kick.netname);
					bprint(#PRINT_HIGH, " is \sBANNED\s from the server\n");

					sprint(current_voteent.admin_kick,#PRINT_HIGH,"\nYou have been \sBANNED\s from the server!\n");

					stuffcmd(current_voteent.admin_kick, "disconnect\n"); //Kick them!

					st = infokey(current_voteent.admin_kick,"ip");
					localcmd("addip ");
					localcmd(st);
					localcmd(" #BAN_VOTED_TIME");
					localcmd("\n");

					BroadcastSound("player/teledth1");
				}

				ResetVoteEnt(); // removes current vote entity

				return #TRUE;
			}
		}
		else if (current_voteent.g_a == #PUNISH_MUTE) // Mute
		{
			if (current_voteent.all_active - current_voteent.has_holo >= #VOTESNEEDED_MUTE) // success?
			{
				bprint(#PRINT_HIGH,"\nVoting\{141} Democracy says ");
				bprint(#PRINT_HIGH,current_voteent.admin_kick.netname);
				bprint(#PRINT_HIGH," must be muted =)\n");

				bprint(#PRINT_HIGH, current_voteent.admin_kick.netname);
				bprint(#PRINT_HIGH, " is muted.\n");

				BroadcastSound("doors/runeuse");

				sprint(current_voteent.admin_kick,#PRINT_HIGH,"\nYou have been muted!\n");

				local float uid;

				uid = getuid(current_voteent.admin_kick);
				st = ftos(uid);

				localcmd("mute 00");
				localcmd(st);
				localcmd(" #MUTE_VOTED_TIME");
				localcmd("\n");

				ResetVoteEnt(); // removes current vote entity

				return #TRUE;
			}
		}
		else if (current_voteent.g_a == #PUNISH_CUFF) // Cuff
		{
			if (current_voteent.all_active - current_voteent.has_holo >= #VOTESNEEDED_CUFF) // success?
			{
				bprint(#PRINT_HIGH,"\nVoting\{141} Democracy says ");
				bprint(#PRINT_HIGH,current_voteent.admin_kick.netname);
				bprint(#PRINT_HIGH," is annoying\n");

				bprint(#PRINT_HIGH, current_voteent.admin_kick.netname);
				bprint(#PRINT_HIGH, " is cuffed.\n");

				BroadcastSound("doors/runeuse");

				sprint(current_voteent.admin_kick,#PRINT_HIGH,"\nYou have been cuffed!\n");

				local float uid;

				uid = getuid(current_voteent.admin_kick);
				st = ftos(uid);

				localcmd("cuff 00");
				localcmd(st);
				localcmd(" #CUFF_VOTED_TIME");
				localcmd("\n");

				ResetVoteEnt(); // removes current vote entity

				return #TRUE;
			}
		}
	}
	else if (current_voteent.has_sentry == #VOTE_NEXTMAP)
	{
		if (current_voteent.all_active - current_voteent.has_holo >= #VOTESNEEDED_NEXTMAP || (((current_voteent.all_active - current_voteent.has_holo) / numclients)> #NEEDEDVOTES_NEXTMAP_FACTOR )) // success?
		{
			st = colstr(current_voteent.netname,#COLSTR_RED);

			bprint(#PRINT_HIGH,"\nVoting\{141} Success¡ Setting ",st," as next map\n");

			localcmd("localinfo nmap \"");
			localcmd(current_voteent.netname);
			localcmd("\"\n");

			BroadcastSound("misc/runekey");

			ResetVoteEnt(); // removes current vote entity

			return #TRUE;
	   }
	}
	else if (current_voteent.has_sentry == #VOTE_SWITCHMAP)
	{
		if (current_voteent.all_active - current_voteent.has_holo >= #VOTESNEEDED_MAP || (((current_voteent.all_active - current_voteent.has_holo) / numclients)> #NEEDEDVOTES_MAP_FACTOR )) // success?
		{
			st = colstr(current_voteent.netname,#COLSTR_RED);

			bprint(#PRINT_HIGH,"\nVoting\{141} Success¡ Switching map to ",st,"\n");

			BroadcastSound("misc/runekey");

			LaunchMap(current_voteent.netname);

			ResetVoteEnt(); // removes current vote entity

			return #TRUE;
		}
	}

	return #FALSE;
};

//==========================================================================
// Checks if valid vote entity

float() ValidVoteEnt =
{
	if (current_voteent == world)
		return #FALSE;

	if (current_voteent.classname != "voteent")
		return #FALSE;

	return #TRUE;
};


//============================================================
// gets the map localinfo string for the number passed in

string(float themap) GetMapString =
{
	local string st, mapnum, temp;

	mapnum = ftos(themap);

	temp = strcat("m",mapnum);
	st = infokey(world,temp);

	return st;
};

//===============================================================
// Prints remaining votes for success

void() bprintVotesLeft =
{
	local string st;
	local float tmp;

	tmp = GetRemainingVotes();
	tmp = floor(tmp);
	st = ftos(tmp);
	st = colstr(st,#COLSTR_NUMBER);

	if (tmp > 1)
		bprint(#PRINT_HIGH," \{144}",st," votes left\{144}\n");
	else
		bprint(#PRINT_HIGH," \{144}\1 vote left!\{144}\n");
};

//======================================================================================
// The current punsihment vote goes to sleep (player to be muted/cuffed hides away)

// Warning: here we assume self is the player leaving server to be punished
void() VoteToSleep =
{
	local string st;

	// First clean up any sleeping vote
	CleanUpSleepVote();

	current_voteent.think = VoteSleep_think;
	current_voteent.nextthink = time + #VOTESLEEP_RATECHECK;
	current_voteent.classname = "sleepvote";

	st = infokey(self,"ip");

	current_voteent.message = makestr(st);
	current_voteent.admin_kick = world;
	current_voteent.ltime = time;

	current_voteent = world;

	votesleeping = #TRUE;
};

void() VoteSleep_think =
{
	self.nextthink = time + #VOTESLEEP_RATECHECK;

	if (!ValidVoteEnt())
	{
		if (self.admin_kick != world)
		{
			if (!self.admin_kick.is_connected) // He tries to hide again? lol
				self.admin_kick = world; // reset
			else
				SleepVoteResume(self, self.admin_kick);
		}
	}

	// Check if we should discard this sleeping vote
	if (floor((time - self.ltime) / 60) > #VOTESLEEP_DURATION)
	{
		delstr(self.message);
		dremove(self);
		votesleeping = #FALSE;
	}
};

void() CleanUpSleepVote =
{
	local entity te;

	te = find(world,classname,"sleepvote");

	while (te)
	{
		delstr(te.message);
		dremove(te);

		te = find(te,classname,"sleepvote");
	}

	votesleeping = #FALSE;
};

entity() GetSleepVote =
{
	local entity te;

	te = find(world,classname,"sleepvote");

	return te;
};

void(entity sleepent, entity targetclient) SleepVoteResume =
{
	delstr(sleepent.message);

	current_voteent = sleepent;
	current_voteent.think = PunishVote_Think;
	current_voteent.nextthink = time + #VOTE_TIME;
	current_voteent.classname = "voteent";
	current_voteent.admin_kick = targetclient;

	votesleeping = #FALSE;

	BroadcastSound("misc/medkey");

	bprint(#PRINT_HIGH,"Voting\{141} Resuming vote to ");
	if (current_voteent.g_a == #PUNISH_MUTE)
		bprint(#PRINT_HIGH,"mute ");
	else if (current_voteent.g_a == #PUNISH_CUFF)
		bprint(#PRINT_HIGH,"cuff ");
	bprint(#PRINT_HIGH,current_voteent.admin_kick.netname);
	bprintVotesLeft();
};

//========================================================================
// Returns number of votes remaining for a success

float() GetRemainingVotes =
{
	if (!current_voteent)
		return 666; // BUG

	if (current_voteent.has_sentry == #VOTE_PUNISH)
	{
		if (current_voteent.g_a == #PUNISH_CURSE)
			return #VOTESNEEDED_CURSE - (current_voteent.all_active - current_voteent.has_holo);
		else if (current_voteent.g_a == #PUNISH_MUTE)
			return #VOTESNEEDED_MUTE - (current_voteent.all_active - current_voteent.has_holo);
		else if (current_voteent.g_a == #PUNISH_KICK)
			return #VOTESNEEDED_KICK - (current_voteent.all_active - current_voteent.has_holo);
		else if (current_voteent.g_a == #PUNISH_BAN)
			return #VOTESNEEDED_BAN - (current_voteent.all_active - current_voteent.has_holo);
		else if (current_voteent.g_a == #PUNISH_CUFF)
			return #VOTESNEEDED_CUFF - (current_voteent.all_active - current_voteent.has_holo);
	}
	else if (current_voteent.has_sentry == #VOTE_NEXTMAP)
		return #VOTESNEEDED_NEXTMAP - (current_voteent.all_active - current_voteent.has_holo);
	else if (current_voteent.has_sentry == #VOTE_SWITCHMAP)
		return #VOTESNEEDED_MAP - (current_voteent.all_active - current_voteent.has_holo);

	return 666; // If this happens, its a bug.. and evil!
};
