/*=======================================================//
// prozac.QC - CustomTF 3.2.OfN           - 15/11/2004 - //
// by Sergio Fuma馻 Grunwaldt - OfteN [cp]               //
=========================================================//
 ProZac Message Of The Day (MOTD) and un/related stuff :)
=========================================================*/

#define MSG_OFTEN_CUTFVERSION "Running progs version 1.2 󸃥?2010輁n"

#define MSG_INFO "\nType md help? to see additional client commands.\n"

//#define MSG_CUTFVERSION "Custom云 version ?3?2甇fN"
//WK #define MSG_CUTFVERSION   "幸馅撩 Custom云 鰰當甇fN?" //<-- 3.2.OfN6

#ifdef COOP_MODE_ENHANCED
#define MSG_CUTFVERSION		"幸馅撩 Custom云 COOP VERSION 1.2 (4-1-2010)"
#else
#define MSG_CUTFVERSION		"幸馅撩 Custom云 VERSION 1.2 (4-1-2010)"
#endif

#define MSG_INTRO  "Welcome to 幸馅撩 Custom云\na Quake 云 MOD by ShakaUVM\nwww畉elefragged甤om痵haka\nModified for COOP By 澡? 情颸n\n潪灋灋灋灋灋灋灋灋灋灋灋灋灋灍\n\n"
#define MSG_INTRO2 "Based on the aussie ver by SB-1\nModified version by Clan Prozac\n\n" // 潪灋灋灋灋灋灋灋灋灋灋灋灋灍\n\n
//#define MSG_INTRO3 "↙ot of the stuff under test!!‐n\nClan疉dmin issues? ask Pirivan!\nGeneral bitching? ask your mom! :P"
//#define MSG_INTRO3 "Send bug reports and comments to:\ngrunw纁opc甧s (郠uake? as subject?)"
#define MSG_INTRO3 "Post bug reports and comments on:\nhttp:www甤ustomtf畂rg痜orums"
//http:kickme畉o痗ustomtf"


//WK 152 Default, must be > 6.
#define MOTD_FINISHED 152 //WK 1/7/7 420 //242 		//Delay in 1/10th seconds for motd to show

void() PrintProzacMOTD =
{
    local string st;   

    st = "潪? Celebrating  years !! 潪焅n\n";
    
    if ((self.#cprint_fx & 3) == 3)
        st = colstr(st,#COLSTR_MIX1);
    else if (self.#cprint_fx & 2)
        st = colstr(st,#COLSTR_RED);
    else if (self.#cprint_fx & 1)
        st = colstr(st,#COLSTR_MIX2);
    
    CenterPrint4(self,#MSG_INTRO,#MSG_INTRO2,st,#MSG_INTRO3);

    self.#cprint_fx = self.#cprint_fx + 1;
};

void() PrintProzacIntro =
{
    if (!no_votemap && !no_punish)
        sprint(self,#PRINT_HIGH,"\nVoting? You can issue a vote by using the oteMap? and unish? aliases.\n");
    else
    {
        if (!no_punish)
            sprint(self,#PRINT_HIGH,"\nVoting? You can issue a vote by using oteMap? alias.\n");
        else if (!no_votemap)
            sprint(self,#PRINT_HIGH,"\nVoting? You can issue a vote by using unish? alias.\n");
    }

    //sprint (self, #PRINT_HIGH, #MSG_INFO, "\n",#MSG_OFTEN_CUTFVERSION, "\n潪灍 ", #MSG_CUTFVERSION, " 潪灋焅n       深骘蝽狒轱? 栾礤疳珏:\n     www畉elefragged甤om痵haka\n潪灋灋灋灋灋灋灋灋灋灋灋灋灋灋灋灋灍\n\n");
    sprint (self, #PRINT_HIGH, #MSG_INFO, "\n",#MSG_OFTEN_CUTFVERSION, "\n潪灍 ", #MSG_CUTFVERSION, " 潪灋焅n       深骘蝽狒轱? 栾礤疳珏:\n  http:customtf畇f畁et痯rozaccoop\n潪灋灋灋灋灋灋灋灋灋灋灋灋灋灋灋灋灍\n\n");

	// Gizmo
#ifdef COOP_MODE_ENHANCED
	if ( coop == 3 && !deathmatch ) {
		local string	str;

		str = colstr( "淭his server is in Insane Coop mode淺n", #COLSTR_RED );
		sprint( self, #PRINT_HIGH, str );
	}
#endif
};
