/*=======================================================//
// prozac.QC - CustomTF 3.2.OfN           - 15/11/2004 - //
// by Sergio Fuma馻 Grunwaldt - OfteN [cp]               //
=========================================================//
 ProZac Message Of The Day (MOTD) and un/related stuff :)
=========================================================*/

#define MSG_OFTEN_CUTFVERSION "Running Coop progs version 1.0.9.0 󷈣0?2009輁n"

#define MSG_INFO "\nType md help? to see additional client commands.\n"

//#define MSG_CUTFVERSION "Custom云 version ?3?2甇fN"
//WK #define MSG_CUTFVERSION   "幸馅撩 Custom云 鰰當甇fN?" //<-- 3.2.OfN6

//#ifdef COOP_MODE_ENHANCED
//#define MSG_CUTFVERSION		"幸馅撩 Custom云 COOP VERSION 1.0.9.0 (1-30-09)"
//#else
#define MSG_CUTFVERSION		"CustomTF 骑? 澡? 绣镳戾"
//#endif

// Welcome to CustomTF For The People\nwhere the PLAYERS decide how the game is played!\n
#define MSG_INTRO  "Welcome to CustomTF 骑? 澡? 绣镳戾\nwhere the 刑临乓? decide\nhow the game is played!\n\nPlease give your input at:\n\n沲篝镯翩弭矧蹴\n\n潪灋灋灋灋灋灋灋灋灋灋灋灋灋灍\n\n"
#define MSG_INTRO2 "Based on 澡? 情?'s Coop mod\nwhich is based on Prozac CuTF Classic\n\nHosted by PhoenixLabs.org\n\n" // 潪灋灋灋灋灋灋灋灋灋灋灋灋灍\n\n
#define MSG_INTRO3 "\nPress '' to skip"
//http:kickme畉o痗ustomtf"


//WK 152 Default, must be > 6.
#define MOTD_FINISHED 1600 //WK 1/7/7 420 //242 		//Delay in 1/10th seconds for motd to show

void() PrintProzacMOTD =
{
    local string st;
    local string st2; 
    local float x;

    st = "Celebrating 摃 years of CustomTF!!\n\n";
    
    if ((self.#cprint_fx & 3) == 3)
        st = colstr(st,#COLSTR_MIX1);
    else if (self.#cprint_fx & 2)
        st = colstr(st,#COLSTR_RED);
    else if (self.#cprint_fx & 1)
        st = colstr(st,#COLSTR_MIX2);

    st2 = #MSG_INTRO3;
    x = floor(time);
    if (x - (2 * floor(x / 2)) == 0) // x mod 2 == 0
        st2 = colstr(st2, #COLSTR_RED);
    
    CenterPrint4(self,#MSG_INTRO,#MSG_INTRO2,st,st2);

    self.#cprint_fx = self.#cprint_fx + 1;
};

void() PrintProzacIntro =
{
    if (!no_votemap && !no_punish)
        sprint(self,#PRINT_HIGH,"\nVoting? You can issue a vote by using the oteMap? and unish? commands.\n");
    else
    {
        if (!no_punish)
            sprint(self,#PRINT_HIGH,"\nVoting? You can issue a vote by using oteMap? command.\n");
        else if (!no_votemap)
            sprint(self,#PRINT_HIGH,"\nVoting? You can issue a vote by using unish? command.\n");
    }

    //sprint (self, #PRINT_HIGH, #MSG_INFO, "\n",#MSG_OFTEN_CUTFVERSION, "\n潪灍 ", #MSG_CUTFVERSION, " 潪灋焅n       深骘蝽狒轱? 栾礤疳珏:\n     www畉elefragged甤om痵haka\n潪灋灋灋灋灋灋灋灋灋灋灋灋灋灋灋灋灍\n\n");
    sprint (self, #PRINT_HIGH, #MSG_INFO, "\n",#MSG_OFTEN_CUTFVERSION, "\n潪灍 ", #MSG_CUTFVERSION, " 潪灍\n    Please give your input at:\n       customtf畁et痜orum\n潪灋灋灋灋灋灋灋灋灋灋灋灋灋灋灋焅n\n");

	// Gizmo
#ifdef COOP_MODE_ENHANCED
	if ( coop == 3 && !deathmatch ) {
		local string	str;

		str = colstr( "淭his server is in Insane Coop mode淺n", #COLSTR_RED );
		sprint( self, #PRINT_HIGH, str );
	}
#endif

	// PZ - Attackers Go Red mode
	if (agr) { AGR_introducePlayer(); sprint(self, #PRINT_HIGH, "\n"); }
};
