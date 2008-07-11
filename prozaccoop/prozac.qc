/*=======================================================//
// prozac.QC - CustomTF 3.2.OfN           - 15/11/2004 - //
// by Sergio Fumaña Grunwaldt - OfteN [cp]               //
=========================================================//
 ProZac Message Of The Day (MOTD) and un/related stuff :)
=========================================================*/

#define MSG_OFTEN_CUTFVERSION "Running progs build C336 Û7¯11¯2008Ý\n"

#define MSG_INFO "\nType ¢cmd help¢ to see additional client commands.\n"

//#define MSG_CUTFVERSION "CustomÔÆ version ö3®2®OfN"
//WK #define MSG_CUTFVERSION   "ÐÒÏÚÁÃ CustomÔÆ ö•®”®OfN˜" //<-- 3.2.OfN6

#ifdef COOP_MODE_ENHANCED
#define MSG_CUTFVERSION		"ÐÒÏÚÁÃ CustomÔÆ COOP VERSION 7-11-08"
#else
#define MSG_CUTFVERSION		"ÐÒÏÚÁÃ CustomÔÆ VERSION 7-11-08"
#endif

#define MSG_INTRO  "Welcome to ÐÒÏÚÁÃ CustomÔÆ\na Quake ÔÆ MOD by ShakaUVM\nwww®telefragged®com¯shaka\nModified for COOP By Ôèå Çéúíï\n\nžžžžžžžžžžžžžžžžžžžžžžžžžžžžŸ\n\n"
#define MSG_INTRO2 "Based on the aussie ver by SB-1\nModified version by Clan Prozac\n\n" // žžžžžžžžžžžžžžžžžžžžžžžžžžŸ\n\n
//#define MSG_INTRO3 "¨Lot of the stuff under test!!©\n\nClan¯Admin issuesº ask Pirivan!\nGeneral bitchingº ask your mom! :P"
//#define MSG_INTRO3 "Send bug reports and comments to:\ngrunwÀcopc®es (àQuakeà as subject¡)"
#define MSG_INTRO3 "Post bug reports and comments on:\nhttp:¯¯www®customtf®org¯forums"
//http:¯¯kickme®to¯customtf"


//WK 152 Default, must be > 6.
#define MOTD_FINISHED 152 //WK 1/7/7 420 //242 		//Delay in 1/10th seconds for motd to show

void() PrintProzacMOTD =
{
    local string st;   

    st = "žŸ Celebrating  years !! žŸ\n\n";
    
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

    //sprint (self, #PRINT_HIGH, #MSG_INFO, "\n",#MSG_OFTEN_CUTFVERSION, "\nžžŸ ", #MSG_CUTFVERSION, " žžžŸ\n       Éîæïòíáôéïî èïíåðáçå:\n     www®telefragged®com¯shaka\nžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžŸ\n\n");
    sprint (self, #PRINT_HIGH, #MSG_INFO, "\n",#MSG_OFTEN_CUTFVERSION, "\nžžŸ ", #MSG_CUTFVERSION, " žžžŸ\n       Éîæïòíáôéïî èïíåðáçå:\n  http:¯¯customtf®sf®net¯prozaccoop\nžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžŸ\n\n");
};
