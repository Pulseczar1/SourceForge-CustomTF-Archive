/*=======================================================//
// prozac.QC - CustomTF 3.2.OfN           - 15/11/2004 - //
// by Sergio Fuma?a Grunwaldt - OfteN [cp]               //
=========================================================//
 ProZac Message Of The Day (MOTD) and un/related stuff :)
=========================================================*/

#define MSG_OFTEN_CUTFVERSION "Running progs build 243 ?26?06?2005?\n"

#define MSG_INFO "\nType ?cmd help? to see additional client commands.\n"

//#define MSG_CUTFVERSION "Custom?? version ?3?2?OfN"
#define MSG_CUTFVERSION   "?????? Custom?? ?????OfN?" //<-- 3.2.OfN6

#define MSG_INTRO  "Welcome to ?????? Custom??\na Quake ?? MOD by ShakaUVM\nwww?telefragged?com?shaka\n\n??????????????????????????????\n\n"
#define MSG_INTRO2 "Based on the aussie ver by SB-1\nModified version by Clan Prozac\n\n" // ????????????????????????????\n\n
//#define MSG_INTRO3 "?Lot of the stuff under test!!?\n\nClan?Admin issues? ask Pirivan!\nGeneral bitching? ask your mom! :P"
//#define MSG_INTRO3 "Send bug reports and comments to:\ngrunw?copc?es (?Quake? as subject?)"
#define MSG_INTRO3 "Post bug reports and comments on:\nhttp:??www?customtf?com?forums"
//http:??kickme?to?customtf"


//WK 152 Default, must be > 6.
#define MOTD_FINISHED 242 //420//242 		//Delay in 1/10th seconds for motd to show

void() PrintProzacMOTD =
{
    local string st;   

    st = "??? Celebrating  years !! ???\n\n";
    
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
        sprint(self,#PRINT_HIGH,"\nVoting? You can issue a vote by using the ?VoteMap? and ?Punish? aliases.\n");
    else
    {
        if (!no_punish)
            sprint(self,#PRINT_HIGH,"\nVoting? You can issue a vote by using ?VoteMap? alias.\n");
        else if (!no_votemap)
            sprint(self,#PRINT_HIGH,"\nVoting? You can issue a vote by using ?Punish? alias.\n");
    }

    //sprint (self, #PRINT_HIGH, #MSG_INFO, "\n",#MSG_OFTEN_CUTFVERSION, "\n???? ", #MSG_CUTFVERSION, " ?????\n       ??????????? ????????:\n     www?telefragged?com?shaka\n????????????????????????????????????\n\n");
    sprint (self, #PRINT_HIGH, #MSG_INFO, "\n",#MSG_OFTEN_CUTFVERSION, "\n???? ", #MSG_CUTFVERSION, " ?????\n       ??????????? ????????:\n  http:??www?customtf?com?forums\n????????????????????????????????????\n\n");
};