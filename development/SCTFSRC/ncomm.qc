/* ncomm.qc (inferno commands) - by Inferno (waije@titan.oit.umass.edu)
    This is a script file that handles commands for things, it also acts
    like a client.
*/


// here's a void that shows whose on (status)
void() ShowWhoOn =
{
        local entity pppp;

        pppp = find(world, classname, "player");
        while (pppp != world) {
                if ((pppp.status_flag & OP_PLAYER_FLAG) && !(pppp.status_flag & ADMIN_PLAYER_FLAG))
                        sprint(self, "@ ");
                else if (pppp.status_flag & ADMIN_PLAYER_FLAG)
                        sprint(self, "* ");
                sprint(self, pppp.netname);
                sprint(self, "\n");
                pppp = find(pppp, classname, "player");
        }
};

// this will show the person the current teamplay variable
void() ShowTeamplay =
{
        local string pp;

        pp = ftos(teamplay);
        sprint(self, "The current teamplay value is\n");
        sprint(self, "set to '");
        sprint(self, pp);
        sprint(self, "'\n");
};

// this will show the person the current deathmatch variable
void() ShowDeathmatch =
{
        local string pp;

        pp = ftos(deathmatch);
        sprint(self, "The current deathmatch value is\n");
        sprint(self, "set to '");
        sprint(self, pp);
        sprint(self, "'\n");
};

// this will show the person the current timelimit variable
void() ShowTimelimit =
{
        local string pp;

        pp = ftos(cvar("timelimit"));
        sprint(self, "The current timlimit value is\n");
        sprint(self, "set to '");
        sprint(self, pp);
        sprint(self, "'\n");
};

// this will show the person the current fraglimit variable
void() ShowFraglimit =
{
        local string pp;

        pp = ftos(cvar("fraglimit"));
        sprint(self, "The current fraglimit value is\n");
        sprint(self, "set to '");
        sprint(self, pp);
        sprint(self, "'\n");
};

// voting for exit
void() VoteForExit =
{
        local float totalfor, totalnot;
        local entity pp;

        totalfor = totalnot = 0;
        if (self.voting == 1) {
                self.voting = 2;
                sprint(self, "Voting against exiting accepted\n");
        } else if (self.voting == 2) {
                self.voting = 1;
                sprint(self, "Voting for exiting accepted\n");
        }

        pp = find(world, classname, "player");
        while (pp)
        {
                if (pp.voting == 1) {
                        totalfor = totalfor + 1;
                        // bprint(pp.netname);
                        // bprint(" has voted to exit the level\n");
                        }
                if (pp.voting == 2) {
                        totalnot = totalnot + 1;
                        // bprint(pp.netname);
                        // bprint(" has voted against exit\n");
                        }                        
                pp = find(pp, classname, "player");
        }
        if (totalfor > totalnot) {
                     // The majority of people wanted to exit
                bprint("Ôטו םבךןעיפש ןז נוןנלו קבמפוה פן וריפ\n");
                NextLevel();
        }
};

// flag lock down - keeps team mates from picking their flag up
void() VoteLockDownFlags =
{
        local float totalfor, totalnot, total_on;
        local entity pp;
        local string t, f, a;
        total_on= totalfor = totalnot = 0;
        
        if (!(teamplay & PICK_UP_OWN_FLAG)) { // see if your vote will count
                sprint(self, "The flags are locked by the administrator\n");
                return;
        }
        
        if (self.voting == 1) {
                self.voting = 2;  // vote twice to vote against lock down
                sprint(self, "Voting בחבימףפ flag lock-down accepted\n");  // against
        } else if (self.voting == 2) {
                self.voting = 1;  // vote once to lock down the flag
                sprint(self, "Voting for flag lock-down accepted\n");
        }

        pp = find(world, classname, "player");
        while (pp)
        {
               if (pp.voting == 1) {
                        totalfor = totalfor + 1;
                        // bprint(pp.netname);
                        // bprint(" has voted to lock down the flags\n");
               }
               if (pp.voting == 2) {
                        totalnot = totalnot + 1;
                        // bprint(pp.netname);
                        // bprint(" has voted against flag lock down\n");
               }                        
               total_on = totalfor + totalnot;
               pp = find(pp, classname, "player");
        }
        
        if (totalfor > totalnot) {
                     // The people voted to lock down the flags
                bprint("פטו נוןנלו צןפוה פן לןדכ הןקמ פטו זלבחף\n"); 
                flag_lockdown = 1;
                pp = find(world, classname, "player");
                while (pp) {
                if (pp.inferno_flag & ITEM_YOUR_FLAG) 
                        ReturnFlag();  // return what you've stolen from me
                        
                pp = find(pp, classname, "player");
                }
        } else {
                       // The people voted against flag lock down
               // bprint("פטו נוןנלו צןפוה בחבימףפ זלבח לןדכ הןקמ\n"); 
                flag_lockdown = 0;
        }        
        
};
