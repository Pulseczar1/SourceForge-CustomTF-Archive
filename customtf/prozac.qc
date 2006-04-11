/*
==============================================================================

prozac.QC
CustomTF 3.2.OfN

 ProZac Message Of The Day (MOTD) and un/related stuff :)

==============================================================================
*/


#define MSG_OFTEN_CUTFVERSION strcat("Running progs built \{16}", #__DATE__, "\{17}\n")

#define MSG_INFO "\nType \{162}cmd help\{162} to see additional client commands.\n"

//#define MSG_CUTFVERSION "Custom云 version �3�2甇fN"
#define MSG_CUTFVERSION   "\sProzac\s Custom\sTF\s \sV\s\3\s.\s\2\s.\sOfN\6" //<-- 3.2.OfN6

#define MSG_INTRO  "Welcome to \sProzac\s Custom\sTF\s\na Quake \sTF\s MOD by ShakaUVM\nwww\s.\stelefragged\s.\scom\s/\sshaka\n\n"
#define MSG_INTRO2 "Based on the aussie ver by SB-1\nFurther modified by Clan Prozac\n\n"
#define MSG_INTRO3 "\{29}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{31}\n\n"
#define MSG_INTRO4 "Now maintained by:\nImprove Custom\sTF\s Project\nsee customtf\s.\ssf\s.\snet"


//WK 152 Default, must be > 6.
#define MOTD_FINISHED 420//242 		//Delay in 1/10th seconds for motd to show

void() PrintProzacMOTD =
{
	local string st;

	st = "\{29}\{30}\{31} Celebrating \5 years !! \{29}\{30}\{31}\n\n";

	if ((self.#cprint_fx & 3) == 3)
		st = colstr(st,#COLSTR_MIX1);
	else if (self.#cprint_fx & 2)
		st = colstr(st,#COLSTR_RED);
	else if (self.#cprint_fx & 1)
		st = colstr(st,#COLSTR_MIX2);

	CenterPrint5(self,#MSG_INTRO,#MSG_INTRO2,#MSG_INTRO3,st,#MSG_INTRO4);

	self.#cprint_fx = self.#cprint_fx + 1;
};

void() PrintProzacIntro =
{
	if (!no_votemap && !no_punish)
		sprint(self,#PRINT_HIGH,"\nVoting\{141} You can issue a vote by using the \{162}VoteMap\{162} and \{162}Punish\{162} aliases.\n");
	else
	{
		if (!no_punish)
			sprint(self,#PRINT_HIGH,"\nVoting\{141} You can issue a vote by using \{162}VoteMap\{162} alias.\n");
		else if (!no_votemap)
			sprint(self,#PRINT_HIGH,"\nVoting\{141} You can issue a vote by using \{162}Punish\{162} alias.\n");
	}

	sprint (self, #PRINT_HIGH, #MSG_INFO, "\n",#MSG_OFTEN_CUTFVERSION, "\n\{29}\{30}\{30}\{31} ", #MSG_CUTFVERSION, " \{29}\{30}\{30}\{31}\n       \sInformation Homepage\s:\n  http:\s//\swww\s.\scustomtf\s.\scom\s/\sforums\n\{29}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{30}\{31}\n\n");
};
