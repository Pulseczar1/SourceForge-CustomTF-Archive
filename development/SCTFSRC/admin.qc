/*
New Admin.Qc Code Copyright (c) 1997 by Inferno (waije@titan.oit.umass.edu)
Source of admin code came from:
*/
//---------------------------------------------------------------------------
//Quake
//
//Copyright (c) 1995-96 by Dave Kirsch
//---------------------------------------------------------------------------
//admin - remove server admin functions
//---------------------------------------------------------------------------

// NOTE:  THE FOLLOWING VALUES ARE THE PASSWORD USED TO ENABLE
// REMOTE ACCESS.
//
// The have the following properties and requirements:
// a. Must not be an existing impulse
// b. Must be entered in the specified order
// c. Must be in the range 1 to 255 excluding previously used impulses
//
// They must be entered in the correct order which gives 256*256*256 or
// 16777216 possible passwords.  If a specified order wasn't given, it
// would only be 768 possibilities.
//
// BY DEFAULT, REMOTE ADMIN ACCESS IS DISABLED
// This is done by setting the admin passwords all to -1.
//
// If you wanted to enable it, pick three random numbers (that aren't
// existing impulses) and put 'em here, for example:
//
//      float   ADMIN_PWD_1   = 179;
//      float   ADMIN_PWD_2   = 131;
//      float   ADMIN_PWD_3   = 157;
//
// which would give you a password of 179, 131 and 157.  To send this from
// a Quake client, do a bind like this:
//
// bind p "impulse 179;wait;impulse 131;wait;impulse 157"
//
// When you hit p, you'll be granted remote admin functionality.
//
// Currently the only admin functions available right now are kick
// team change, and level change.  They are bound to impulse 151, 
// impulse 152 and impuluse 153 respectively.
//
// The way it works is after you enter the admin password, do an
// impulse 151/152/153.  You'll get a list of players on the server with their
// numbers.  Send the next impulse with the number of the player
// to act the command on.

// CHANGE THE FOLLOWING THREE -1 NUMBERS TO YOUR ADMIN PASSWD
float   ADMIN_PWD_1     = -1;//119;  // change me to first number of the passwd
float   ADMIN_PWD_2     = -1;//130;  // change me to second number of the passwd
float   ADMIN_PWD_3     = -1;//114;  // change me to third number of the passwd

float   OP_PWD_1     = -1;//113;  // change me to first number of the passwd
float   OP_PWD_2     = -1;//131;  // change me to second number of the passwd
float   OP_PWD_3     = -1;//115;  // change me to third number of the passwd

float   ADMIN_KICK = 151;
float   ADMIN_TEAMCHANGE = 155;
float   ADMIN_CHANGEMAP = 156;

void(entity y) startDogPatrol;
float () HandleDigitInput;
void (float accessParm) StartSelectPlayer;

// used for admin to change maps
void(string nmap) AdminChangeLevel =
{
   local entity o;

   bprint(self.netname);
   bprint(" has changed the level to ");
   bprint(nmap);
   bprint("\n");

   o = spawn();
   o.map = nmap;
   nextmap = o.map;
   gameover = TRUE;

   o.think = execute_changelevel;
   o.nextthink = time + 0.1;
};

/*
void() WrongPassword =
{
        if (!(self.owner.status_flag & OP_PLAYER_FLAG)) {
                sprint(self.owner, "Invalid password.\n");
                self.owner.accesslvl = 0;
        }

        // remove the binding
//        stuffcmd(self.owner, "bind 9 \"impulse 22\"");

        self.owner.opercheck = 0;
        self.owner.count_count = 0;
        remove(self);
};
*/

void() OperChk =
{
        if (self.status_flag & ADMIN_PLAYER_FLAG) {
                sprint(self, "You're already admin!\n");
                return;
        }
        sprint(self, "Enter password: \n");
        self.opercheck = 1;
        self.accesslvl=0;

};

// admin impulses:
// impulse   accessParm   desc
// n           1           kick player n
// n           2           change player n team
// 1-9         3           change level
//   1         4           choose e1mx level
//   2         5           choose e2mx level
//   3         6           choose e3mx level
//   4         7           choose e4mx level
//   5         8           choose dmx level
//   6         9           choose ctfx level
//   7         18          choose ctf2x level
//   8         21          choose cotc level
//             23          choose misc level
//   9         30          choose start level
// n           10          ban player
// n           11          teamplay flag
// n           12          deathmatch flag
// n           13          gib player
// n           14          observer player
//             15          op player
//             16          de-op player
//             17          registered flag
// 7           18          choose ctfmx level
//             19          timelimit
//             20          fraglimit
// 8           30          choose start map
// n           31          create rune (developers only)
// 59          59          start start wild dogs
// 60          60          start stop wild dogs
// 85          14          start put player in observer
// 151         1           start kick player
// 155         2           start team change player
// 156         3           start change level
// 157         10          start ban (commented out)
// 158         11          start teamplay change
// 159         12          start deathmatch change
// 152         13          start gib player
// 160         14          start observer
// 153         15          start op
// 154         16          start deop
// 161                     restart server
// 162         17          start percent choose ctf
// 163         19          start timelimit
// 164         20          start fraglimit
// 165         65          server lock command
// 166         66          grant join server privs when locked
// 167         67          allow player(s) to stay observer unlimited time
// 170         31          start create rune 
// 178         (none)      give all weaps/ammo (I got tired
//                         of searching for weapons during testing).


/****************************************************************\
*
* HOW TO GET MULTIKEY NUMERIC INPUT FROM THE USER
* This applies primarily to admin users, in checkAdminCmd().
* Define an impulse, < 256, which will be used to signal user 
* input.
* When the player sends the impulse, set an access parm to
* uniquely id the input, clear the impulse, and set the 
* count_count2 to 1, for first digit.  
* When the access parm is set, bump count_count2 for each digit,
* and save the accumulated value in count_count.  But return 
* from this function before it sets accessparm to 0.  When input
* is complete, clear the access parm and counts.
* When checking digit input, the user is expected to type 
* impulse 10 for 0 and impulse 22 for 9.
*
* Special case, when you want to get a 2 digit player id:
*  
*  From the initial impulse code, 
*     sprint a impulse description line
*     call StartSelectPlayer(p)
*     return.
*  Parm= a unique accessparm value to handle the input
*
*  In CheckAdminCmd(), when checking that access parm, first
*  call HandleDigitInput(), which returns 0 when the 2nd char has
*  been entered.  The input value is in self.count_count.
*
* If you want 2 digit input without the player list, then
* dont call StartSelectPlayer().  Instead, code:
*    sprint(self, "Enter the first digit : ");
* 
*    self.impulse = 0;
*    self.accessparm = accessParm;   // the unique access parm value
*    self.count_count = 0;
*    self.count_count2 = 1;
*    return;
*
\****************************************************************/


void (entity item, float runeNo) UpdateRuneModel;
void() finishRuneCmd;
void() CheckAdminCmd =
{
        local float n, pp, ppp;
   local entity p;
   local string st;

   if (self.opercheck == 1) {
      if (cvar("temp1") < 1) {
              self.opercheck=0;
              self.accesslvl=0;
              return; // disabled
      }

      if (self.impulse == 10)
              self.impulse = 0;

      if (self.impulse == 22)
              self.impulse = 9;

      if (self.accesslvl == 0) {
              sprint(self, "Enter the second digit:\n");
              self.accesslvl = self.accesslvl + 1;
              self.count_count = self.impulse * 10000000;
      }

      else if (self.accesslvl == 1) {
              sprint(self, "Enter the third digit:\n");
              self.accesslvl = self.accesslvl + 1;
              self.count_count = self.count_count + (self.impulse * 1000000);
      }

      else if (self.accesslvl == 2) {
              sprint(self, "Enter the fourth digit:\n");
              self.count_count = self.count_count + (self.impulse * 100000);
              self.accesslvl = self.accesslvl + 1;
      }

      else if (self.accesslvl == 3) {
              sprint(self, "Enter the fifth digit:\n");
              self.count_count = self.count_count + (self.impulse * 10000);
              self.accesslvl = self.accesslvl + 1;
      }

      else if (self.accesslvl == 4) {
              sprint(self, "Enter the sixth digit:\n");
              self.count_count = self.count_count + (self.impulse * 1000);
              self.accesslvl = self.accesslvl + 1;
      }

      else if (self.accesslvl == 5) {
              sprint(self, "Enter the seventh digit:\n");
              self.count_count = self.count_count + (self.impulse * 100);
              self.accesslvl = self.accesslvl + 1;
      }

      else if (self.accesslvl == 6) {
              sprint(self, "Enter last digit:\n");
              self.count_count = self.count_count + (self.impulse * 10);
              self.accesslvl = self.accesslvl + 1;
      }

      else if (self.accesslvl == 7) {
              self.count_count = self.count_count + self.impulse;
              self.accesslvl = self.accesslvl + 1;
      }

      if (self.accesslvl == 8) {
         if (self.count_count == cvar("temp1")) {
                 self.accesslvl = self.accesslvl + 1;
                 self.status_flag = self.status_flag | OP_PLAYER_FLAG | ADMIN_PLAYER_FLAG;
                 bprint(self.netname);
                 bprint(" has become an admin\n");
                 dprint(self.netname);
                 dprint(" has become an admin\n");
                 sprint(self, "Type impulse 70 to get help\n");
                 self.accessparm = 0;
                 self.opercheck = 0;
                 return;
         } else {
            if (!(self.status_flag & OP_PLAYER_FLAG) || !(self.status_flag & ADMIN_PLAYER_FLAG)) {
                    self.accesslvl = 0;
                    sprint(self, "Invalid Password\n");
                    self.opercheck = 0;
            }
         }
      }
   }
        
   if (self.accesslvl < 9) {
      self.accessparm = 0;
      return; // must be a sysop beyond this point
   }

   if (self.accessparm == 1) { // kick cmd

      // the function returns nonzero when input is incomplete
      if (HandleDigitInput())
         return;

      n = self.count_count - 1;
      p = find(world, classname, "player");
      while (p != world && n > 0) {
         p = find(p, classname, "player");
         n = n - 1;
      }

      if (p != world) {
         if ((p.status_flag & ADMIN_PLAYER_FLAG) && !self.defcon) {
              sprint(self, "You cannot kick ");
              sprint(self, p.netname);
              sprint(self, "because he/she is an admin!\n");
         } else {
              sprint(p, "\nYou have been kicked.\nGo abuse somewhere else.\n");
              stuffcmd(p, "disconnect\n");
              bprint(p.netname);
              bprint(" was kicked by ");
              bprint(self.netname);
              bprint("\n");
         }
      } else {
         sprint(self, "Can't kick #");
         st = ftos(self.impulse);
         sprint(self, st);
         sprint(self, "\n");
      }
      
      self.impulse = 0;
      return;
   } else if (self.accessparm == 2) { // switch teams

      // the function returns nonzero when input is incomplete
      if (HandleDigitInput())
         return;

      n = self.count_count - 1;
      p = find(world, classname, "player");
      while (p != world && n > 0) {
         p = find(p, classname, "player");
         n = n - 1;
      }

      if (p != world) {
         if ((p.status_flag & ADMIN_PLAYER_FLAG) && p != self) {
              sprint(self, "Can't change an admin's teams!\n");
              self.accessparm = 0;
              return;
         }
         TeamCaptureDropFlagOfPlayer(p);
         centerprint(p, "YOU HAVE SWITCHED TEAMS!");
         if (p.lastteam == TEAM_COLOR1 + 1) {
            p.team = p.lastteam = TEAM_COLOR2 + 1;
            st = ftos(TEAM_COLOR2);
         } else {
            p.team = p.lastteam = TEAM_COLOR1 + 1;
            st = ftos(TEAM_COLOR1);
         }
         stuffcmd(p, "color ");
         stuffcmd(p, st);
         stuffcmd(p, "\n");
         bprint(p.netname);
         bprint(" changed teams (by ");
         bprint(self.netname);
         bprint(")\n");
      } else {
         sprint(self, "Can't change #");
         st = ftos(self.impulse);
         sprint(self, st);
         sprint(self, "\n");
      }

      self.accessparm = 0;
      return;

   } else if (self.accessparm == 3) { // select episode

      if (self.impulse == 1) {
         self.accessparm = 4;

         sprint(self, "€Ãèïïóå Ìåöåì‚\n");  // Choose Level
         sprint(self, " ÅÍ …………………………Slipgate Complex\n");             // E1M1
         sprint(self, " ÅÍ ………………Castle of the Damned\n");         // E1M2
         sprint(self, " ÅÍ ………………………………The Necropolis\n");               // E1M3
         sprint(self, " ÅÍ ………………………The Grisly Grotto\n");            // E1M4
         sprint(self, " ÅÍ …………………………………………Gloom Keep\n");                   // E1M5
         sprint(self, " ÅÍ ……………………The Door To Chthon\n");           // E1M6
         sprint(self, " ÅÍ …………………The House of Chthon\n");          // E1M7
         sprint(self, " ÅÍ …………………………Ziggurat Vertigo\n");             // E1M8

         self.impulse = 0;
         return;

      } else if (self.impulse == 2) {
         self.accessparm = 5;

         sprint(self, "€Ãèïïóå Ìåöåì‚\n");
         sprint(self, " ÅÍ …………………………The Installation\n");
         sprint(self, " ÅÍ ……………………………………Ogre Citadel\n");
         sprint(self, " ÅÍ ………………………………Crypt of Decay\n");
         sprint(self, " ÅÍ ………………………The Ebon Fortress\n");
         sprint(self, " ÅÍ ……………………The Wizard's Manse\n");
         sprint(self, " ÅÍ ………………The Dismal Oubliette\n");
         sprint(self, " ÅÍ …………………………………………Underearth\n");

         self.impulse = 0;
         return;

      } else if (self.impulse == 3) {
         self.accessparm = 6;

         sprint(self, "€Ãèïïóå Ìåöåì‚\n");
         sprint(self, " ÅÍ …………………Termination Central\n");
         sprint(self, " ÅÍ ………………………The Vaults of Zin\n");
         sprint(self, " ÅÍ ……………………The Tomb of Terror\n");
         sprint(self, " ÅÍ ………………Satan's Dark Delight\n");
         sprint(self, " ÅÍ ……………………………………Wind Tunnels\n");
         sprint(self, " ÅÍ …………………Chambers of Torment\n");
         sprint(self, " ÅÍ ………………………The Haunted Halls\n");

         self.impulse = 0;
         return;

      } else if (self.impulse == 4) {
         self.accessparm = 7;

         sprint(self, "€Ãèïïóå Ìåöåì‚\n");
         sprint(self, " Åm ………………………The Sewage System\n");
         sprint(self, " Åm ………………The Tower of Despair\n");
         sprint(self, " Åm ………………The Elder God Shrine\n");
         sprint(self, " Åm ……………………The Palace of Hate\n");
         sprint(self, " Åm …………………………………Hell's Atrium\n");
         sprint(self, " Åm …………………………………The Pain Maze\n");
         sprint(self, " Åm ………………………………………Azure Agony\n");
         sprint(self, " Åm ………………………The Nameless City\n");

         self.impulse = 0;
         return;

      } else if (self.impulse == 5) {
         self.accessparm = 8;

         sprint(self, "€Ãèïïóå Ìåöåì‚\n");
         sprint(self, " ÄÍ ……………………Place of Two Deaths\n");
         sprint(self, " ÄÍ ………………………Claustrophobopolis\n");
         sprint(self, " ÄÍ ………………………The Abandoned Base\n");
         sprint(self, " ÄÍ ……………………………………The Bad Place\n");
         sprint(self, " ÄÍ …………………………………………The Cistern\n");
         sprint(self, " ÄÍ ……………………………………The Dark Zone\n");

         self.impulse = 0;
         return;

      } else if (self.impulse == 6) {
         self.accessparm = 9;

         sprint(self, "€Ãèïïóå Ìåöåì‚\n");
         sprint(self, " ÃÔÆ …………………………………McKinley Base\n");
         sprint(self, " ÃÔÆ ………………………………………………The Kiln\n");
         sprint(self, " ÃÔÆ ……………………………………………Dysphoria\n");
         sprint(self, " ÃÔÆ …………………The Forgotten Mines\n");
         sprint(self, " ÃÔÆ …………Da Ancient War Grounds\n");
         sprint(self, " ÃÔÆ …………………………………………………Vertigo\n");
         sprint(self, " ÃÔÆ ……………………Tale of Two Cities\n");
         sprint(self, " ÃÔÆ …………………………………The Strongbox\n");
         sprint(self, " idÃÔÆ ……………………………Gloom Castles\n");

         self.impulse = 0;
         return;

      } else if (self.impulse == 7) {
         self.accessparm = 18;

         sprint(self, "€Ãèïïóå Ìåöåì‚\n");
         sprint(self, " ÃÔÆÍ ……………………McKinley Station\n");
         sprint(self, " ÃÔÆÍ …………………………………The Warzone\n");
         sprint(self, " ÃÔÆÍ ………………………Spill the Blood\n");
         sprint(self, " ÃÔÆÍ ………………Ruins of NeoMinonk\n");
         sprint(self, " ÃÔÆÍ …………Disciple War Grounds\n");
         sprint(self, " ÃÔÆÍ …………………………The Two Towers\n");
         sprint(self, " ÃÔÆÍ ……………………………Gloom Castles\n");
         sprint(self, " ÃÔÆÍ ………………………Capturephobolis\n");

         self.impulse = 0;
         return;
         
      } else if (self.impulse == 8) {
         self.accessparm = 21;

         sprint(self, "€Ãèïïóå Ìåöåì‚\n");
         sprint(self, " ÃÏÔÃ …………………………………The LavaRoom\n");
         sprint(self, " ÃÏÔÃ ……………………………………The Killbox\n");
         sprint(self, " ÃÏÔÃ ……………………………………The Killbox\n");
         sprint(self, " ÃÏÔÃ ……………………………………The Killbox\n");
         sprint(self, " ÃÏÔÃ ……………………………………The Killbox\n");
         sprint(self, " ÃÏÔÃ ……………………………………The Killbox\n");
         sprint(self, " ÃÏÔÃ ……………………………………The Killbox\n");
         sprint(self, " Miscellaneous Maps\n");
         self.impulse = 0;
         return; 
         
      } else if (self.impulse == 9) {
         self.accessparm = 30;

         sprint(self, "€Ãèïïóå Ìåöåì‚\n");
         sprint(self, " ÓÔÁÒÔ ………………………………ID Start Map\n");
         sprint(self, " ÃÔÆÓÔÁÒÔ ……………………CTF Start Map\n");

         self.impulse = 0;
         return;
     }         
     
     sprint(self, "Invalid episode\n");
     self.accessparm = 0;
     return;
      
   } else if (self.accessparm == 18) {
      if (self.impulse == 1)          AdminChangeLevel("ctf2m1");
      else if (self.impulse == 2)     AdminChangeLevel("ctf2m2");
      else if (self.impulse == 3)     AdminChangeLevel("ctf2m3");
      else if (self.impulse == 4)     AdminChangeLevel("ctf2m4");
      else if (self.impulse == 5)     AdminChangeLevel("ctf2m5");
      else if (self.impulse == 6)     AdminChangeLevel("ctf2m6");
      else if (self.impulse == 7)     AdminChangeLevel("ctf2m7");
      else if (self.impulse == 8)     AdminChangeLevel("ctf2m8");
      else sprint(self, "Invalid map\n");
      self.impulse = 0;
      self.accessparm = 0;
      return;
      
   } else if (self.accessparm == 21) {
      if (self.impulse == 1)          AdminChangeLevel("cotc1");
      else if (self.impulse == 2)     AdminChangeLevel("cotc2");
      else if (self.impulse == 3)     AdminChangeLevel("cotc2");
      else if (self.impulse == 4)     AdminChangeLevel("cotc2");
      else if (self.impulse == 5)     AdminChangeLevel("cotc2");
      else if (self.impulse == 6)     AdminChangeLevel("cotc2");
      else if (self.impulse == 7)     AdminChangeLevel("cotc2");
      else if (self.impulse == 8) { 
         sprint(self, "Choose Level:\n");
         sprint(self, "1 cheatc   The Cheat Complex\n");
         sprint(self, "2 ctfgold1 CTFGOLD1 - Gold Edition\n");
         sprint(self, "3 qzictf2  QZI CTF \n");
         sprint(self, "4 remix    CTF1 McKinley Base(remix)\n");
         sprint(self, "5 hqvideo  DM-XXX Time To Die\n");
         sprint(self, "6 pornshow DM-XXX Porn Show\n");
         self.accessparm = 23;
         self.impulse = 0;
         return;    
      }
      else sprint(self, "Invalid map\n");
      self.impulse = 0;
      self.accessparm = 0;
      return;    

   } else if (self.accessparm == 23) {
      if (self.impulse == 1)          AdminChangeLevel("cheatc");
      else if (self.impulse == 2)     AdminChangeLevel("ctfgold1");
      else if (self.impulse == 3)     AdminChangeLevel("qzictf2");
      else if (self.impulse == 4)     AdminChangeLevel("remix");
      else if (self.impulse == 5)     AdminChangeLevel("hqvideo");
      else if (self.impulse == 6)     AdminChangeLevel("pornshow");
      else sprint(self, "Invalid map\n");
      self.impulse = 0;
      self.accessparm = 0;
      return;        
      
   } else if (self.accessparm == 30) {
      if (self.impulse == 1)          AdminChangeLevel("start");
      else if (self.impulse == 2)     AdminChangeLevel("ctfstart");
      else sprint(self, "Invalid map\n");
      self.impulse = 0;
      self.accessparm = 0;
      return;  
       
   } else if (self.accessparm == 4) {

      if (self.impulse == 1)      AdminChangeLevel("e1m1");
      else if (self.impulse == 2)   AdminChangeLevel("e1m2");
      else if (self.impulse == 3)   AdminChangeLevel("e1m3");
      else if (self.impulse == 4)   AdminChangeLevel("e1m4");
      else if (self.impulse == 5)   AdminChangeLevel("e1m5");
      else if (self.impulse == 6)   AdminChangeLevel("e1m6");
      else if (self.impulse == 7)   AdminChangeLevel("e1m7");
      else if (self.impulse == 8)   AdminChangeLevel("e1m8");
      else sprint(self, "Invalid map\n");
      self.impulse = 0;
      self.accessparm = 0;
      return;
         
   } else if (self.accessparm == 5) {

      if (self.impulse == 1)      AdminChangeLevel("e2m1");
      else if (self.impulse == 2)   AdminChangeLevel("e2m2");
      else if (self.impulse == 3)   AdminChangeLevel("e2m3");
      else if (self.impulse == 4)   AdminChangeLevel("e2m4");
      else if (self.impulse == 5)   AdminChangeLevel("e2m5");
      else if (self.impulse == 6)   AdminChangeLevel("e2m6");
      else if (self.impulse == 7)   AdminChangeLevel("e2m7");
      else sprint(self, "Invalid map\n");
      self.impulse = 0;
      self.accessparm = 0;
      return;
         
   } else if (self.accessparm == 6) {

      if (self.impulse == 1)      AdminChangeLevel("e3m1");
      else if (self.impulse == 2)   AdminChangeLevel("e3m2");
      else if (self.impulse == 3)   AdminChangeLevel("e3m3");
      else if (self.impulse == 4)   AdminChangeLevel("e3m4");
      else if (self.impulse == 5)   AdminChangeLevel("e3m5");
      else if (self.impulse == 6)   AdminChangeLevel("e3m6");
      else if (self.impulse == 7)   AdminChangeLevel("e3m7");
      else sprint(self, "Invalid map\n");
      self.impulse = 0;
      self.accessparm = 0;
      return;
         
   } else if (self.accessparm == 7) {

      if (self.impulse == 1)      AdminChangeLevel("e4m1");
      else if (self.impulse == 2)   AdminChangeLevel("e4m2");
      else if (self.impulse == 3)   AdminChangeLevel("e4m3");
      else if (self.impulse == 4)   AdminChangeLevel("e4m4");
      else if (self.impulse == 5)   AdminChangeLevel("e4m5");
      else if (self.impulse == 6)   AdminChangeLevel("e4m6");
      else if (self.impulse == 7)   AdminChangeLevel("e4m7");
      else if (self.impulse == 8)   AdminChangeLevel("e4m8");
      else sprint(self, "Invalid map\n");
      self.impulse = 0;
      self.accessparm = 0;
      return;
         
   } else if (self.accessparm == 8) {

      if (self.impulse == 1)        AdminChangeLevel("dm1");
      else if (self.impulse == 2)   AdminChangeLevel("dm2");
      else if (self.impulse == 3)   AdminChangeLevel("dm3");
      else if (self.impulse == 4)   AdminChangeLevel("dm4");
      else if (self.impulse == 5)   AdminChangeLevel("dm5");
      else if (self.impulse == 6)   AdminChangeLevel("dm6");
      else sprint(self, "Invalid map\n");
      self.impulse = 0;
      self.accessparm = 0;
      return;
         
   } else if (self.accessparm == 9) {

      if (self.impulse == 1)        AdminChangeLevel("ctf1");
      else if (self.impulse == 2)   AdminChangeLevel("ctf2");
      else if (self.impulse == 3)   AdminChangeLevel("ctf3");
      else if (self.impulse == 4)   AdminChangeLevel("ctf4");
      else if (self.impulse == 5)   AdminChangeLevel("ctf5");
      else if (self.impulse == 6)   AdminChangeLevel("ctf6");
      else if (self.impulse == 7)   AdminChangeLevel("ctf7");
      else if (self.impulse == 8)   AdminChangeLevel("ctf8");
      else if (self.impulse == 9)   AdminChangeLevel("idctf1");
      else sprint(self, "Invalid map\n");
      self.impulse = 0;
      self.accessparm = 0;
      return;
   } else if (self.accessparm == 10) { // ban cmd

      n = self.impulse - 1;
      p = find(world, classname, "player");
      while (p != world && n > 0) {
         p = find(p, classname, "player");
         n = n - 1;
      }

      if (p != world) {
         if (p.status_flag & ADMIN_PLAYER_FLAG) {
              sprint(self, "You cannot ban ");
              sprint(self, p.netname);
              sprint(self, " because he/she is an admin!\n");
         } else {
              sprint(p, "\nYou have been banned!\nGo abuse somewhere else.\n");
              p.status_flag = p.status_flag | PLAYER_BAN_FLAG;
              stuffcmd(p, "disconnect\n");
              bprint(p.netname);
              bprint(" was banned by ");
              bprint(self.netname);
              bprint("\n");
         }
      } else {
         sprint(self, "Can't ban #");
         st = ftos(self.impulse);
         sprint(self, st);
         sprint(self, "\n");
      }

      self.accessparm = 0;
      return;
   } else if (self.accessparm == 11) { // Teamplay 
      if (self.impulse == 10)
              self.impulse = 0;
      if (self.impulse == 22)
              self.impulse = 9;
      // cancel when necessary
      if (self.impulse == 220) {
              self.count_count2 = 9;
              self.count_count = teamplay;
      }
      st = ftos(self.impulse);
      if (self.count_count2 == 1) {
              self.count_count = self.impulse * 10000000;
              sprint(self, st);
              sprint(self, ", enter the second digit:\n");
      } else if (self.count_count2 == 2) {
              self.count_count = self.count_count + (self.impulse * 1000000);
              sprint(self, st);
              sprint(self, ", enter the third digit:\n");
      } else if (self.count_count2 == 3) {
              self.count_count = self.count_count + (self.impulse * 100000);
              sprint(self, st);
              sprint(self, ", enter the fourth digit:\n");
      } else if (self.count_count2 == 4) {
              self.count_count = self.count_count + (self.impulse * 10000);
              sprint(self, st);
              sprint(self, ", enter the fifth digit:\n");
      } else if (self.count_count2 == 5) {
              self.count_count = self.count_count + (self.impulse * 1000);
              sprint(self, st);
              sprint(self, ", enter the sixth digit:\n");
      } else if (self.count_count2 == 6) {
              self.count_count = self.count_count + (self.impulse * 100);
              sprint(self, st);
              sprint(self, ", enter the seventh digit:\n");
      } else if (self.count_count2 == 7) {
              self.count_count = self.count_count + (self.impulse * 10);
              sprint(self, st);
              sprint(self, ", enter the last digit:\n");
      } else if (self.count_count2 == 8) {
              self.count_count = self.count_count + self.impulse;
              st = ftos(self.count_count);
              self.count_count2 = 9;
      }
      if (self.count_count2 == 9) {
              if (self.count_count >= (BIGGEST_TEAMPLAY_BIT * 2)) {
                  sprint(self, "Number too large!!\n");
                  sprint(self, "Press the impulse and try again.\n");
                  sprint(self, "REMEMBER! 8 digits with leading zeros1\n");
                  self.count_count = self.count_count2 = self.accessparm = 0;
              } else {
                 st = ftos(self.count_count);
                 pp = 0;
                 if (teamplay & TEAM_CAPTURE_CUSTOM)
                      pp = 1;

                 cvar_set("teamplay", st);//, "?SCTF3.5");
                 ppp = self.count_count;  // store it in a local float
                 self.count_count = self.count_count2 = self.accessparm = 0;
                 if ((ppp & TEAM_CAPTURE_CUSTOM) && (pp == 0))
                      localcmd("restart\n");
              }
              return;
      }


      self.impulse = 0;
      self.count_count2 = self.count_count2 + 1;
      return;
   } else if (self.accessparm == 12) {
      st = ftos(self.impulse);
      if ((self.impulse < 1) || (self.impulse > 3))
         self.impulse = 1;
      sprint(self, "Now deathmatch is set to '");
      sprint(self, st);
      sprint(self, "'\n");
      cvar_set("deathmatch", st);
      self.accessparm = 0;
      return;
   } else if (self.accessparm == 13) { // gib cmd
      // the function returns nonzero when input is incomplete
      if (HandleDigitInput())
         return;

      n = self.count_count - 1;
      p = find(world, classname, "player");
      while (p != world && n > 0) {
         p = find(p, classname, "player");
         n = n - 1;
      }
      
      if (p != world) {
         if (p.status_flag & ADMIN_PLAYER_FLAG) {
                 sprint(self, "You cannot gib ");
                 sprint(self, p.netname);
                 sprint(self, " because he/she is an admin!\n");
         } else {
                 sprint(p, "***POOF!!***\nYou have been gibbed!\n");
                 local entity pppp;
                 pppp = spawn();
                 pppp.classname = "op gib";
                 pppp.owner = self;
                 T_Damage(p, pppp, p, 10000);
                 remove(pppp);
         }
      } else {
         sprint(self, "Can't gib #");
         st = ftos(self.impulse);
         sprint(self, st);
         sprint(self, "\n");
      }
   } else if (self.accessparm == 14) { // observer cmd
      // the function returns nonzero when input is incomplete
      if (HandleDigitInput())
         return;

      n = self.count_count - 1;

      p = find(world, classname, "player");
      while (p != world && n > 0) {
         p = find(p, classname, "player");
         n = n - 1;
      }

      if (p != world) {
         if (p.status_flag & ADMIN_PLAYER_FLAG) {
                 sprint(self, "You cannot observer ");
                 sprint(self, p.netname);
                 sprint(self, " because he/she is an admin!\n");
         } else {
            sprint(p, "You have been changed into an observer\n");
            p.inferno_flag = 0;
            p.inferno_flag = DO_OBSERVER_FLAG;
            local entity oself;
            oself = self;
            self = p;
            DropBackpack();
            DropRune();
            TeamCaptureDropFlagOfPlayer(self);
            self = oself;
            BecomeObserver(p);
            bprint(p.netname);
            bprint(" was changed into an observer by ");
            bprint(self.netname);
            bprint("\n");
         }
      } else {
         sprint(self, "Can't observer #");
         st = ftos(self.impulse);
         sprint(self, st);
         sprint(self, "\n");
      }

      self.accessparm = 0;
      return;
   } else if (self.accessparm == 15) { // op cmd
      // the function returns nonzero when input is incomplete
      if (HandleDigitInput())
         return;
         
      n = self.impulse - 1;
      p = find(world, classname, "player");
      while (p != world && n > 0) {
         p = find(p, classname, "player");
         n = n - 1;
      }

      if (p != world) {
         if (p.status_flag & ADMIN_PLAYER_FLAG) {
                 sprint(self, p.netname);
                 sprint(self, " is an admin!\n");
         } else {
                 sprint(p, "***POOF!!***\nYou have become an op!\n");
                 p.status_flag = p.status_flag | OP_PLAYER_FLAG;
                 bprint(" was opped ");
                 bprint(self.netname);
                 bprint("\n");
         }
      } else {
         sprint(self, "Can't op #");
         st = ftos(self.impulse);
         sprint(self, st);
         sprint(self, "\n");
      }

      self.accessparm = 0;
      return;
   } else if (self.accessparm == 16) { // deop cmd
      // the function returns nonzero when input is incomplete
      if (HandleDigitInput())
         return;

      n = self.impulse - 1;
      p = find(world, classname, "player");
      while (p != world && n > 0) {
         p = find(p, classname, "player");
         n = n - 1;
      }

      if (p != world) {
         if (p.status_flag & ADMIN_PLAYER_FLAG) {
                 sprint(self, "You can't deop an admin!\n");
         } else {
            if (!(p.status_flag & OP_PLAYER_FLAG)) {
                    sprint(self, p.netname);
                    sprint(self, " isn't even an op!\n");
            } else {
                    sprint(p, "@@@POOF!!@@@\nThere goes your ops!!\n");
                    p.status_flag = p.status_flag | OP_PLAYER_FLAG;
                    bprint(" was opped ");
                    bprint(self.netname);
                    bprint("\n");
            }
         }
      } else {
         sprint(self, "Can't deop #");
         st = ftos(self.impulse);
         sprint(self, st);
         sprint(self, "\n");
      }

      self.accessparm = 0;
      return;
   } /*else if (self.accessparm == 17) {               // Give iD some credit
           st = ftos(self.impulse);                    // and use registered
           sprint(self, "Now registered is set to '"); // software!
           sprint(self, st);
           sprint(self, "'\n");
           cvar_set("registered", st);
           self.accessparm = 0;
           return; 
   }*/
    else if (self.accessparm == 19) {  // Timelimit Command
      sprint(self, "Enter the first digit of your 3 digit code:\n");
      if (self.impulse == 10)
              self.impulse = 0;
      if (self.impulse == 22)
              self.impulse = 9;
      // cancel when necessary
      if (self.impulse == 220) {
              self.count_count2 = 4;
              self.count_count = cvar("timelimit");
      }
      st = ftos(self.impulse);
      if (self.count_count2 == 1) {
              self.count_count = self.impulse * 100;
              sprint(self, st);
              sprint(self, ", enter the second digit:\n");
      } else if (self.count_count2 == 2) {
              self.count_count = self.count_count + (self.impulse * 10);
              sprint(self, st);
              sprint(self, ", enter the last digit:\n");
      } else if (self.count_count2 == 3) {
              self.count_count = self.count_count + self.impulse;
              st = ftos(self.count_count);
              self.count_count2 = 4;
      }
      if (self.count_count2 == 4) {
              st = ftos(self.count_count);
              cvar_set("timelimit", st);//, "?SCTF3.5");
              self.count_count = self.count_count2 = self.accessparm = 0;
              return;
      }

      self.impulse = 0;
      self.count_count2 = self.count_count2 + 1;
      return;
   } else if (self.accessparm == 20) { // FragLimit Command
      sprint(self, "Enter the first digit of your 3 digit code:\n");
      if (self.impulse == 10)
              self.impulse = 0;
      if (self.impulse == 22)
              self.impulse = 9;
      // cancel when necessary
      if (self.impulse == 220) {
              self.count_count2 = 9;
              self.count_count = cvar("fraglimit");
      }
      st = ftos(self.impulse);
      if (self.count_count2 == 1) {
              self.count_count = self.impulse * 100;
              sprint(self, st);
              sprint(self, ", enter the second digit:\n");
      } else if (self.count_count2 == 2) {
              self.count_count = self.count_count + (self.impulse * 10);
              sprint(self, st);
              sprint(self, ", enter the last digit:\n");
      } else if (self.count_count2 == 3) {
              self.count_count = self.count_count + self.impulse;
              st = ftos(self.count_count);
              self.count_count2 = 4;
      }
      if (self.count_count2 == 4) {
              st = ftos(self.count_count);
              cvar_set("fraglimit", st);//, "?SCTF3.5");
              self.count_count = self.count_count2 = self.accessparm = 0;
              return;
      }


      self.impulse = 0;
      self.count_count2 = self.count_count2 + 1;
      return;
   }
   else if (self.accessparm == 31)
   {
      finishRuneCmd();
      return;
   }

   else if (self.accessparm == 59) { // dog patrol

      // the function returns nonzero when input is incomplete
      if (HandleDigitInput())
         return;

      n = self.count_count - 1;
      p = find(world, classname, "player");
      while (p != world && n > 0) {
         p = find(p, classname, "player");
         n = n - 1;
      }

      if (p != world) {
         if (p.sicHound)
         {
            // player already has dogs dispatched on him
            sprint(self, "Player already has dogs\n");
            self.impulse = 0;
            self.accessparm = 0;
            return;
         }

         // if (p.status_flag & ADMIN_PLAYER_FLAG) {
         //         sprint(self, "You can't sic the dogs on an admin!\n");
         // } else 
         {
            if (sicHoundCount >= MAX_SIC)
            {
               sprint(self, "Max targets for dogs already reached\n");
               self.impulse = 0;
               self.accessparm = 0;
               return;
            }
            sicHoundCount = sicHoundCount + 1;
            // this is how we know the target player.  This field
            // will get zeroed out between levels and connects.
            p.sicHound = 1;

            startDogPatrol(p);
            self.impulse = 0;
            self.accessparm = 0;
            return;
         }
      }
      self.impulse = 0;
      self.accessparm = 0;
      return;
   } else if (self.accessparm == 65) { // lock server cmd

      if (self.impulse == 1) // admin is locking things down
         locked_flag = 1;
      else 
         locked_flag = 0;
         
      if (locked_flag == 1)
         sprint(self, "The server is LOCKED\n");
      else
         sprint(self, "The server is unlocked\n");
      self.impulse = 0; // stop looking for input
      self.accessparm = 0; // finish admin command
      return;
   } else if (self.accessparm == 66) { // grant cmd
      // the function returns nonzero when input is incomplete
      if (HandleDigitInput())
         return;

      n = self.count_count - 1;
      p = find(world, classname, "player");
      while (p != world && n > 0) {
         p = find(p, classname, "player");
         n = n - 1;
      }
      
      if (p != world) {
         sprint(p, "ªªªÍáôãè Áããåóó Çòáîôåä¡¡ªªª\nYour team waits for you!\n");
         p.granted_flag = 1; // set the access flag
                 
         sprint(self, "Access Granted to "); // courtesy message to the admin
         sprint(self, p.netname);
         sprint(self, "\n");
      } else {
         sprint(self, "Can't grant #");
         st = ftos(self.impulse);
         sprint(self, st);
         sprint(self, "\n");
      }
      self.impulse = 0; // complete input, assign grant flag
      return;
   } else if (self.accessparm == 67) { // unlimited observer time
      // the function returns nonzero when input is incomplete
      if (HandleDigitInput())
         return;

      n = self.count_count - 1;
      if (n) {
         p = find(world, classname, "player");
         while (p != world && n > 0) {
            p = find(p, classname, "player");
            n = n - 1;
         }
      
         if (p != world) {
            sprint(p, "You may stay observer as long as you want\n");
            p.observerTime = 0; // time does not count for them
                    
            sprint(self, "unlimited observer Granted to "); // courtesy message to the admin
            sprint(self, p.netname);
            sprint(self, "\n");
         } else {
            sprint(self, "Can't grant #");
            st = ftos(n);
            sprint(self, st);
            sprint(self, "\n");
         }
      }
      else {
         p = find(world, classname, "player");
      
         if (p != world) {
            sprint(p, "You may stay observer as long as you want\n");
            p.observerTime = 0; // time does not count for them
                    
            sprint(self, "unlimited observer Granted to "); // courtesy message to the admin
            sprint(self, p.netname);
            sprint(self, "\n");
         } 
      }
      self.impulse = 0; // complete input, assign grant flag
      return;
   }

   self.accessparm = 0;

   if (self.impulse == 59) // patrol dogs
   {
      sprint(self, "START DOG PATROL. Select a player\n");
      StartSelectPlayer(59);
      return;  
   }   
   if (self.impulse == 60) // patrol dogs
   {
      if (!sicHoundCount)
      {
         self.impulse = 0;       
         self.accessparm = 0;
         return;
      }
      sprint(self, "STOPPING DOG PATROL.\n");
      p = find(world, classname, "player");
      while (p != world) {
         if (p.sicHound)
         {
            p.sicHound = 0;
            p.mentalHound = 0;
            p.mentalHoundTime = 0;
            sicHoundCount = sicHoundCount - 1;

            bprint(p.netname);
            bprint(" has been freed from the dogs!\n");
            self.impulse = 0;
            self.accessparm = 0;
            return;
         }
         p = find(p, classname, "player");
      }
      sprint(self,"no player found!\n");
      self.impulse = 0;
      self.accessparm = 0;
      return;
   }   


   else if (self.impulse == ADMIN_KICK) {

      sprint(self, "Kick a Player\n");
      StartSelectPlayer(1);
      return;

   } else if (self.impulse == ADMIN_TEAMCHANGE) {

      sprint(self, "Change a Player's team\n");
      StartSelectPlayer(2);
      return;

   } else if (self.impulse == 85) {

      sprint(self, "Force a Player to Observer\n");
      StartSelectPlayer(14);
      return;

   } else if (self.impulse == ADMIN_CHANGEMAP) {
      sprint(self, "€Óåìåãô Åğéóïäå‚\n");
      sprint(self, " ……………………Dimension of the Doomed\n");
      sprint(self, " ……………………………Realm of Black Magic\n");
      sprint(self, " ……………………………………………………Netherworld\n");
      sprint(self, " …………………………………………The Elder World\n");
      sprint(self, " …………………………The Deathmatch Arenas\n");
      sprint(self, " ……………………………………………Capture Levels\n");
      sprint(self, " …………………Capture Episode 2 Levels\n");
      sprint(self, " …………………………………………………………COTC Maps\n");
      sprint(self, " ………………………………………………………Start Maps\n");
      self.accessparm = 3;

      self.accessparm = 3;
   } else if (self.impulse == 158) {
      sprint(self, "Make sure console is not pulled down!\n");
      sprint(self, "Then type your number from the\n");
      sprint(self, "keyboard, left to right of the digits.\n");
      sprint(self, "ENTER 8 DIGITS, WITH LEADING ZEROS!!!!\n");
      sprint(self, "Press cancel to cancel\n");
      sprint(self, "Enter the first digit:\n");
      self.count_count2 = 1;
      self.accessparm = 11;
   } else if (self.impulse == 159) {
           sprint(self, "Now type impulse <number> to\n");
           sprint(self, "set deathmatch\n");
           self.accessparm = 12;
   } else if (self.impulse == 152) {
      sprint(self, "Gib a Player\n");
      StartSelectPlayer(13);
      return;
   } else if (self.impulse == 160) {
      self.impulse = 0;
      if (self.inferno_flag & 
       (DO_OBSERVER_FLAG | OBSERVER_FLAG))
      {
         sprint(self,"You are already Observer!\n");
         return;
      }
      sprint(self, "You have been changed into an observer\n");
      self.inferno_flag = DO_OBSERVER_FLAG;
      DropBackpack();
      DropRune();
      TeamCaptureDropFlagOfPlayer(self);
      BecomeObserver(self);
      bprint(self.netname);
      bprint(" became observer\n");

   } else if (self.impulse == 153) {

      sprint(self, "Sorry, unavailable, still debugging\n");
      self.impulse = 0;
   } else if (self.impulse == 154) {

      sprint(self, "Sorry, unavailable, still debugging\n");
      self.impulse = 0;
   } else if (self.impulse == 161) {
           bprint("Warning:server restarting!\n");
           bprint("Warning:server restarting!\n");
           bprint("Warning:server restarting!\n");
           bprint("Warning:server restarting!\n");
           bprint(self.netname);
           bprint(" is restarting the server!\n");

           sprint(self, "Restarting server...\n");
           localcmd("restart");
           LogMsg(self, "Restart server");
           self.impulse = 0;
   } else if (self.impulse == 162) {
           sprint(self, "Now type impulse <number> in\n");
           sprint(self, "the number is the percentage of\n");
           sprint(self, "how the game should choose ctf levels\n");
           self.impulse = 0;
           self.accessparm = 17;
   } else if (self.impulse == 163) {
           sprint(self, "Now type the numbers on your\n");
           sprint(self, "keyboard, for the timelimit\n");
           sprint(self, "Enter the first digit:\n");
           self.impulse = 0;
           self.count_count2 = 1;
           self.accessparm = 19;
   } else if (self.impulse == 164) {
           sprint(self, "Now type the numbers on your\n");
           sprint(self, "keyboard, for the fraglimit\n");
           sprint(self, "Enter the first digit:\n");
           self.impulse = 0;
           self.count_count2 = 1;
           self.accessparm = 20;
   } else if (self.impulse == 165) { // server lock command
           if (locked_flag == 1)
              sprint(self, "The server is LOCKED!\n");
           
           sprint(self, "   Use Impulse 166 to grant access\n");
           sprint(self, "...Press  to LOCK, any other to unlock.\n"); // press 1

           self.impulse = 0;
           self.accessparm = 65;          
   } else if (self.impulse == 166) { // lock - player grant command
           sprint(self, "Grant an observer join privileges\n");
           StartSelectPlayer(66);
           return;           
   } else if (self.impulse == 167) { // observer unlimited time for this level
           sprint(self, "Grant an observer unlimited time\n");
           sprint(self, "Press 00 for all observers\n");
           StartSelectPlayer(67);
           return;           
   } 

   else if (self.impulse == 170) {
      sprint(self, "Create A Rune.\n");
      sprint(self, "Enter 2-digit Rune id:\n");
      sprint(self, "Enter the first digit : ");

      self.impulse = 0;
      self.accessparm = 31;
      self.count_count = 0;
      self.count_count2 = 1;
      return;
   }
   else if (self.impulse == 178) {
      bprint(self.netname);
      bprint(" gave himself all weaps/ammo\n");
      self.items=self.items|IT_SUPER_SHOTGUN|IT_NAILGUN|IT_SUPER_NAILGUN|IT_GRENADE_LAUNCHER|IT_ROCKET_LAUNCHER|IT_LIGHTNING|IT_DOG_LAUNCHER;
      self.ammo_shells=self.ammo_shells + 200;
      self.ammo_nails=self.ammo_nails + 200;
      self.ammo_rockets=self.ammo_rockets + 200;
      self.ammo_cells=self.ammo_cells + 200;
      other=self;
      bound_other_ammo();
      self.impulse = 0;
      self.accessparm = 0;
      return;
   }

   self.impulse = 0;
   return;
};


// Impulses must be less than 256.

void() finishRuneCmd =
{
   local string s1, s2;
   local entity item;
   local float runeNo;

   // the function returns nonzero when input is incomplete
   if (HandleDigitInput())
      return;

   // ok got a 2 digit rune number
   runeNo = self.count_count;
   self.count_count = 0;
   s2 = ftos(runeNo);

   if ((runeNo < 1) || 
   (runeNo > (MAX_RUNES - 1)))
   {
      sprint(self,"invalid rune [");
      sprint(self,s2);
      sprint(self,"]\n");
      return;
   }


   item = spawn();
   item.rune = runeNo;
   GetRuneNames(item);
   bprint(self.netname);
   bprint(" created rune [");
   bprint(s2);  bprint("] name [");
   bprint(item.runeName); bprint("]\n");
   
   item.velocity = aim(self, 10000);
   item.velocity = item.velocity * 450;
   
   item.classname="rune";
   item.flags = FL_ITEM;
   item.solid = SOLID_TRIGGER;
   item.movetype = MOVETYPE_BOUNCE;
   item.message = RuneDescription (item.rune);
   
   // we need a separate function for models
   UpdateRuneModel(item, runeNo);
   
   setmodel (item, item.runemodel);
   setsize (item, '-16 -16 0', '16 16 56');
   setorigin(item, self.origin + v_forward*8 + '0 0 16');
   item.think = NextNRunesThing;
   item.nextthink = time + 0.5;
   
};

void (float accessParm) StartSelectPlayer = 
{
   local entity p;
   local float n;
   local string st;

   sprint(self, "Enter 2-digit player id:\n");
   p = find(world, classname, "player");
   n = 1;
   while (p != world) {
      st = ftos(n);
      if (n < 10)
         sprint(self, " ");
      sprint(self, st);
      sprint(self, " ");
      sprint(self, p.netname);
      sprint(self, "\n");
      p = find(p, classname, "player");
      n = n + 1;
   }
   sprint(self, "Enter the first digit : ");

   self.impulse = 0;
   self.accessparm = accessParm;
   self.count_count = 0;
   self.count_count2 = 1;
};

// returns accessparm 0 when input is complete
float () HandleDigitInput =
{
   local float retVal;
   retVal = 0;

   // for some reason, pressing 0, 9 keys are not detected as impulses.
   // so use impulse 10 for 0, and impulse 22 for 9.

   if (self.impulse == 10)
       self.impulse = 0;

   if (self.impulse == 22)
      self.impulse = 9;

   if (self.count_count2 == 1)
   {
      self.count_count = self.impulse * 10;
      self.count_count2 = 2;
      sprint(self,"\nEnter second digit : ");
   }
   else 
   {
      sprint(self,"\n");
      self.count_count = self.count_count + self.impulse;
      self.accessparm = 0;
      self.impulse = 0;
   }
   return self.accessparm;
};
