/*=======================================================//
// prozac.QC - CustomTF 3.2.OfN           - 15/11/2004 - //
// by Sergio Fumaña Grunwaldt - OfteN [cp]               //
=========================================================//
 ProZac Message Of The Day (MOTD) and un/related stuff :)
=========================================================*/

#define MSG_OFTEN_CUTFVERSION "Running progs build C268 Û04¯??¯2007İ\n"

#define MSG_INFO "\nType ¢cmd help¢ to see additional client commands.\n"

//#define MSG_CUTFVERSION "CustomÔÆ version ö3®2®OfN"
//WK #define MSG_CUTFVERSION   "ĞÒÏÚÁÃ CustomÔÆ ö•®”®OfN˜" //<-- 3.2.OfN6

#ifdef COOP_MODE_ENHANCED
#define MSG_CUTFVERSION		"ĞÒÏÚÁÃ CustomÔÆ COOP VERSION 3-??-07"
#else
#define MSG_CUTFVERSION		"ĞÒÏÚÁÃ CustomÔÆ VERSION 3-??-07"
#endif

#define MSG_INTRO  "Welcome to ĞÒÏÚÁÃ CustomÔÆ\na Quake ÔÆ MOD by ShakaUVM\nwww®telefragged®com¯shaka\nModified for COOP By Ôèå Çéúíï\n\nŸ\n\n"
#define MSG_INTRO2 "Based on the aussie ver by SB-1\nModified version by Clan Prozac\n\n" // Ÿ\n\n
//#define MSG_INTRO3 "¨Lot of the stuff under test!!©\n\nClan¯Admin issuesº ask Pirivan!\nGeneral bitchingº ask your mom! :P"
//#define MSG_INTRO3 "Send bug reports and comments to:\ngrunwÀcopc®es (àQuakeà as subject¡)"
#define MSG_INTRO3 "Post bug reports and comments on:\nhttp:¯¯www®customtf®com¯forums"
//http:¯¯kickme®to¯customtf"


//WK 152 Default, must be > 6.
#define MOTD_FINISHED 152 //WK 1/7/7 420 //242 		//Delay in 1/10th seconds for motd to show

void() PrintProzacMOTD =
{
    local string st;   

    st = "Ÿ Celebrating  years !! Ÿ\n\n";
    
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
        sprint(self,#PRINT_HIGH,"\nVoting You can issue a vote by using the ¢VoteMap¢ and ¢Punish¢ aliases.\n");
    else
    {
        if (!no_punish)
            sprint(self,#PRINT_HIGH,"\nVoting You can issue a vote by using ¢VoteMap¢ alias.\n");
        else if (!no_votemap)
            sprint(self,#PRINT_HIGH,"\nVoting You can issue a vote by using ¢Punish¢ alias.\n");
    }

    //sprint (self, #PRINT_HIGH, #MSG_INFO, "\n",#MSG_OFTEN_CUTFVERSION, "\nŸ ", #MSG_CUTFVERSION, " Ÿ\n       Éîæïòíáôéïî èïíåğáçå:\n     www®telefragged®com¯shaka\nŸ\n\n");
    sprint (self, #PRINT_HIGH, #MSG_INFO, "\n",#MSG_OFTEN_CUTFVERSION, "\nŸ ", #MSG_CUTFVERSION, " Ÿ\n       Éîæïòíáôéïî èïíåğáçå:\n  http:¯¯customtf®sf®net¯prozaccoop\nŸ\n\n");
};
