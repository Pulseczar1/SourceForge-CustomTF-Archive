/* client.qc originally by IDSoftware, deals with clients (when
   they connect, disconnect, and level changes...)
*/

// see release.txt for a description of how the parm vars work

// prototypes
void() checkForGodMode;
void() checkForM4dSk1llzRune;
void () ThrowM4D;
string(float runekind) RuneDescription;
void () W_WeaponFrame;
void() W_SetCurrentAmmo;
void() player_pain;
void() player_stand1;
void (vector org) spawn_tfog;
void (vector org, entity death_owner) spawn_tdeath;
void (entity e) BreakChain;
void () CheckBot;

/** INFERNO: some model stuff that will be used **/
void() dog_pain;  // die as a dog
void() f_pain1;  // pain for fish
void() hknight_pain1;  // hell knight's pain
void() knight_pain;  // knight's pain
void() zombie_pain;  // zombie's pain
void() army_pain;  // soldier's pain
void() sham_pain;  // shambler's pain
void() shalrath_pain; // shalrath's pain frames

void() enf_pain;
void() RuneApplyPowers;

void (entity targ, entity attacker, string causeDeath) DiagObit = {
   dprint("DiagObit: cause[");
   dprint(causeDeath);
   dprint("] targ[");
   dprint(targ.netname);
   dprint("] attacker[");
   dprint(attacker.netname);
   dprint("] rune[");
   local string s1;
   s1 = ftos(attacker.rune);
   dprint(s1);
   if (attacker.status_flag & ITEM_SECOND_RUNE)
      dprint("] power[2]\n");
   else
      dprint("] power[1]\n");
   
};

float modelindex_eyes, modelindex_player;
float pregameover;

// so you could use this void later on

void() MOTD =
{
   if (self.motd_count < 4) {
      self.motd_time = time + 1;                                                                                                                    
      self.motd_count = self.motd_count + 1;
      centerprint(self, "Welcome!\nThis server is running Super Capture,\nSCTFv7.51 by Clan of the Camper\n\nFor info:\nhttp://www.campquake.com/sctf\nNo bots please!");
   } else if (self.motd_count < 8) {
      self.motd_count = self.motd_count + 1;
      self.motd_time = time + 1;
      if (teamplay & TEAM_CAPTURE_FLAG)
         if (self.team == TEAM_COLOR1 + 1)
               centerprint(self, "SUPER цаптуре тхе флаг!\n\nYou are ред team\n\nInfo: http://www.campquake.com/sctf\nNo bots please!\nType IMPULSE 70 for help");
            else                                                                 
               centerprint(self, "SUPER цаптуре тхе флаг!\n\nYou are блуе team\n\nInfo: http://www.campquake.com/sctf\nNo bots please!\nType IMPULSE 70 for help");
      else if (teamplay)
         centerprint(self, "Super Deathmatch\nTEAMPLAY IS ACTIVE\n\nInfo: http://www.campquake.com/sctf\nNo bots please!\nType IMPULSE 70 for help");
      else
         centerprint(self, "Super Deathmatch\n\nInfo: http://www.campquake.com/sctf\nNo bots please!\nType IMPULSE 70 for help");
   } else if (self.motd_count < 9) {
      self.motd_count = self.motd_count + 1;
      self.motd_time = time + 1;
      sprint(self, "Info: http://www.campquake.com/sctf\nSCTF Version 7.51\n");
      if (teamplay & TEAM_CAPTURE_FLAG) {
         if (teamplay & TEAM_CAPTURE_CUSTOM)
            sprint(self, "You are playing\nCUSTOM SUPER цаптуре тхе флаг!\n"); // CAPTURE THE FLAG
         else
            sprint(self, "You are playing\nSUPER цаптуре тхе флаг!\n"); // CAPTURE THE FLAG
         sprint(self, "  Version 7.51\n");
      }
   } else {
      // this way you dont have to toggle an expired motd
      self.motd_time = 0;
      self.motdDisplay = 0;
   }
};

void() MOTD_ChooseTeam =
{
   self.motd_time = time + 1;
   local float timeLeft;
   timeLeft = self.observerTime - time;
   local string s1;
   local string s2;
   local string s3;
   if (self.observerTime) {
      s1 = "\n\nObserver Time Remaining [";
      timeLeft = floor(timeLeft);
      s2 = ftos (timeLeft);
      s3 = "]";
   }
   else { s1 = ""; s2 = ""; s3 = ""; }
   

   if (self.inferno_flag & CLEAR_OBSERVER_FLAG)
      UpdatePlayerStatus(self, "", "", "");
   else {
      if (self.inferno_flag & DIE_OBSERVER_FLAG)
         centerprint(self, "SCTF, v7.51\n\nPress jump, 1 or 2 to get back\ninto the game\n");
      else if (teamplay & TEAM_CAPTURE_FLAG)
         ncenterprint(self, "Welcome!\nClan of the Camper SCTF v7.51\n\nhttp://www.campquake.com/sctf\nNo bots please!\nSUPER цаптуре тхе флаг!\nPress 1 for ред team\nPress 2 for блуе team\nOr Press Jump for automatic team\nPress 4 to Chase Player\nPress 3 to toggle the screen\nPress attack to change observer views",s1,s2,s3,"","","");
      else ncenterprint(self, "Welcome!\nRunning Clan of the Camper SDM v7.51\n\nhttp://www.campquake.com/sctf\nNo bots please!\nPress 1 or 2 or Jump for to enter\nPress 4 to Chase Player\nPress 3 to toggle the screen\nPress attack to change observer views",s1,s2,s3,"","","");
   }
};

// ZOID: with several effects doing the dimlight thing, they just can't
// turn it off.  Do not set self.effects with EF_DIMLIGHT directly.  This
// will automatically do it when CheckPowerups is called
// EF_DIMLIGHT is used;
// 1. Invincible (Pentagram)
// 2. Super Damage (Quad Power)
// 3. Having Flag in Capture
// self is player
void () CheckDimLight = {
   local float flag;

   flag = 0;
   // invincable
   if (self.invincible_finished > time)
      flag = 1;
   // quad
   if (self.super_damage_finished > time)
      flag = 1;
   // flag
//   if (self.player_flag & ITEM_ENEMY_FLAG)
//      flag = 1;
   if (self.rune == RUNE_M4D_SK1LLZ)
      flag = 1;

   if (flag)
      self.effects = self.effects | EF_DIMLIGHT;
   else
      self.effects = self.effects - (self.effects & EF_DIMLIGHT);
};

/*
=============================================================================

            LEVEL CHANGING / INTERMISSION

=============================================================================
*/

float   intermission_running;
float   intermission_exittime;

/*QUAKED info_intermission (1 0.5 0.5) (-16 -16 -16) (16 16 16)
This is the camera point for the intermission.
Use mangle instead of angle, so you can set pitch or roll as well as yaw.  'pitch roll yaw'
*/
void() info_intermission =
{
};



void() SetChangeParms =
{
   // dprint("SetChangeParms() ");
   // dprint(self.netname);
   // dprint("\n");

   // if (self.health <= 0)
   // {
   //    SetNewParms ();
   //    self.rune = self.team = self.lastteam = self.accesslvl = 0;  
   //    return;
   // }

   // we only pass the locked flag to the next level if there is
   // at least one admin there to support it.
   if (locked_flag && (self.accesslvl == 9)) {
      parm12 = 1;
   }
   else parm12 = 0;


   // remove items
   self.items = self.items - (self.items & 
      (IT_KEY1 | IT_KEY2 | IT_INVISIBILITY | IT_INVULNERABILITY | 
      IT_SUIT | IT_QUAD) );

   // cap super health
   if (self.health > 100)
      self.health = 100;
   if (self.health < 50)
      self.health = 50;
   if ((teamplay & TEAM_CAPTURE_FLAG) ) 
   {  // don't carry items between levels in CTF
      SetNewParms();
      if (gamestart || (self.inferno_flag & OBSERVER_FLAG))
         parm10 = -1;
      else if(self.lastteam)
         parm10 = self.lastteam;  
      else parm10 = -1;  // Save the current team of the player
   }
   else {
      parm1 = self.items;
      parm2 = self.health;
      parm3 = self.armorvalue;
      if (self.ammo_shells < 25)
         parm4 = 25;
      else
         parm4 = self.ammo_shells;
      parm5 = self.ammo_nails;
      parm6 = self.ammo_rockets;
      parm7 = self.ammo_cells;
      parm8 = self.weapon;
      parm9 = self.armortype * 100;
      parm13 = self.nweapon;  // carry the new weapons in

   }
   // *TEAMPLAY*
   parm14 = self.status_flag - (self.status_flag & STATUS_FL);  // take away torch (cause bugs)

   // parm10 = self.lastteam;   // Save the current team of the player

   parm16 = self.player_flag;

   parm15 = self.accesslvl;

   // chasecam
   parm20 = self.speed;

   // debugging the level changes
   parm11 = 1;
   
   self.rune = self.team = self.lastteam = self.accesslvl = 0;  
 
};

void() SetNewParms =
{
   // dprint("SetNewParms() ");
   // dprint(self.netname);
   // dprint("\n");
   // local string ps;
   // dprint("parm1  ["); ps = ftos(parm1); dprint(ps); dprint("]\n");   
   // dprint("parm2  ["); ps = ftos(parm2); dprint(ps); dprint("]\n");   
   // dprint("parm3  ["); ps = ftos(parm3); dprint(ps); dprint("]\n");   
   // dprint("parm4  ["); ps = ftos(parm4); dprint(ps); dprint("]\n");   
   // dprint("parm5  ["); ps = ftos(parm5); dprint(ps); dprint("]\n");   
   // dprint("parm6  ["); ps = ftos(parm6); dprint(ps); dprint("]\n");   
   // dprint("parm7  ["); ps = ftos(parm7); dprint(ps); dprint("]\n");   
   // dprint("parm8  ["); ps = ftos(parm8); dprint(ps); dprint("]\n");   
   // dprint("parm9  ["); ps = ftos(parm9); dprint(ps); dprint("]\n");   
   // dprint("parm10 ["); ps = ftos(parm10); dprint(ps); dprint("]\n");   
   // dprint("parm11 ["); ps = ftos(parm11); dprint(ps); dprint("]\n");   
   // dprint("parm12 ["); ps = ftos(parm12); dprint(ps); dprint("]\n");   
   // dprint("parm13 ["); ps = ftos(parm13); dprint(ps); dprint("]\n");   
   // dprint("parm14 ["); ps = ftos(parm14); dprint(ps); dprint("]\n");   
   // dprint("parm15 ["); ps = ftos(parm15); dprint(ps); dprint("]\n");   
   // dprint("parm16 ["); ps = ftos(parm16); dprint(ps); dprint("]\n");   
   // dprint("parm20 ["); ps = ftos(parm20); dprint(ps); dprint("]\n");   
    
   parm1 = IT_SHOTGUN | IT_AXE | IT_DOG_LAUNCHER;
   parm2 = 100;
   if ((teamplay & TEAM_CAPTURE_FLAG) ) {
      parm3 = 50;
      parm9 = 30;
      parm1 = parm1 + IT_ARMOR1;
   } else {
      parm3 = 0;
      parm9 = 0;
   }
   parm4 = 40;
   parm5 = 0;
   parm6 = 0;
   parm7 = 0;
   parm8 = IT_SHOTGUN;
   // *TEAMPLAY*
   if (self.lastteam > 0)
      parm10 = self.lastteam;
   else
      parm10 = -1;    // Reset
   parm16 = 0;

   parm15 = self.accesslvl;
   parm13 = NEW_SHOTGUN;  // passes weapons onto the next level
   parm14 = self.status_flag - (self.status_flag & STATUS_FL);

   // chasecam
   parm20 = self.speed;

   if (gamestart) {
      parm1 = IT_AXE|IT_SHOTGUN;
      parm2 = 100;
      parm4 = 0;
      parm8 = IT_SHOTGUN;
      // parm10 = 1;
      parm13 = NEW_AXE;
   }

};

void() DecodeLevelParms =
{
   // dprint("decodeLevelParms() ");
   // dprint(self.netname);
   // dprint("\n");

   self.player_flag = self.player_flag | parm16;
   self.player_flag = self.player_flag - (self.player_flag & ITEM_ENEMY_FLAG);
   self.skin = (self.player_flag & 65280)/256;

   if (gamestart)
       SetNewParms ();
   if (serverflags)
   {
      if (world.model == "maps/start.bsp")
         flag_lockdown = 0;   // reset the server to it's starting state
         SetNewParms ();      // take away all stuff on starting new episode
   }
   
   self.items = parm1;
   self.health = parm2;
   self.armorvalue = parm3;
   self.ammo_shells = parm4;
   self.ammo_nails = parm5;
   self.ammo_rockets = parm6;
   self.ammo_cells = parm7;
   self.weapon = parm8;
   self.armortype = parm9 * 0.01;

   if (self.status_flag & STATUS_PLAYER_FLAG)
      self.status_flag = parm14 | STATUS_PLAYER_FLAG;
   else self.status_flag = parm14;

   self.accesslvl = parm15;
   self.nweapon = parm13;

   // *XXX* EXPERT CTF

   // Reset times for additional scoring system on level change and server join
   // dprint("decode level parms\n");
   self.last_returned_flag = -10;
   self.last_fragged_carrier = -10;
   self.flag_since = -10;
   self.last_hurt_carrier = -10;

   // give the chasecam variable
   self.speed = parm20;

   // *TEAMPLAY*
   if(TeamColorIsLegal(parm10 - 1))
      self.lastteam = parm10;

   // man, the powerlevel has to go back down to 0 :(
   self.powerlevel=self.powerhealth=0;

   // only the presence of an admin allows the server to remain locked
   if (parm12 && (self.accesslvl == 9))
      locked_flag = 1;

   if (parm11 == 1) {
      local string s1;
      parm11 = 0;
      dprint("DDT: (dlp) ");
      dprint(self.netname);
      dprint (" team [");
      s1 = ftos (self.team);
      dprint(s1);
      dprint ("] lastteam [");
      s1 = ftos (self.lastteam);
      dprint(s1);
      dprint ("] accesslvl [");
      s1 = ftos (self.accesslvl);
      dprint(s1);
      dprint("]\n");
   }
   
};

/*
============
FindIntermission

Returns the entity to view from
============
*/
entity() FindIntermission =
{
   local   entity spot;
   local   float cyc;

// look for info_intermission first
   spot = find (world, classname, "info_intermission");
   if (spot)
   {   // pick a random one
      cyc = random() * 4;
      while (cyc > 1)
      {
         spot = find (spot, classname, "info_intermission");
         if (!spot)
            spot = find (spot, classname, "info_intermission");
         cyc = cyc - 1;
      }
      return spot;
   }

// then look for the start position
   spot = find (world, classname, "info_player_start");
   if (spot)
      return spot;
   
// testinfo_player_start is only found in regioned levels
   spot = find (world, classname, "testplayerstart");
   if (spot)
      return spot;
   
   objerror ("FindIntermission: no spot");
};


string nextmap;
void() GotoNextMap =
{
   // we are going to use samelevel for something else
   // if (cvar("samelevel"))   // if samelevel is set, stay on same level
   //    changelevel (mapname);
   // else {
      // if (nextmap == "e1m7") // skip House of Chthon
      //    nextmap = "e1m8";
      //           else if (nextmap == "start" && (teamplay & TEAM_CAPTURE_CUSTOM))
      //    nextmap = "ctfstart";
      if (nextmap == "start" && (teamplay & TEAM_CAPTURE_CUSTOM))
         nextmap = "ctfstart";
      else if (nextmap == "ctf9")
         nextmap = "ctf2m1";
      else if (nextmap == "end")
         nextmap = "dm1";
      // else if (nextmap == "e1m8") {
      //         if (teamplay & TEAM_CAPTURE_CUSTOM)
      //                 nextmap = "ctfstart";
      //         else nextmap = "start";
      // }
      // removed to allow admin to change to the CTF Start Maps
      // else if ((nextmap == "ctfstart") && !(teamplay & TEAM_CAPTURE_CUSTOM))
      //   nextmap = "start";
      changelevel (nextmap);
   // }
};


void() ExitIntermission =
{
   GotoNextMap ();
};

/*
============
IntermissionThink

When the player presses attack or jump, change to the next level
============
*/
void() IntermissionThink =
{
   if (time < intermission_exittime)
      return;

   if (!self.button0 && !self.button1 && !self.button2)
      return;
   
   ExitIntermission ();
};

void() intermission_t={WriteByte(MSG_ALL,SVC_INTERMISSION);};
void() execute_changelevel =
{
  local entity    pos;

  local float total1, total2;
  local string s1, s2;

   intermission_running = 1;
   
   // enforce a wait time before allowing changelevel
   intermission_exittime = time + 8;

   WriteByte (MSG_ALL, SVC_CDTRACK);
   WriteByte (MSG_ALL, 3);
   WriteByte (MSG_ALL, 3);
   
   pos = FindIntermission ();

   other = find (world, classname, "player");
   while (other != world)
   {
      // get them so they're not in the chasecam

      if (other.team == TEAM_COLOR1 + 1)
         total1 = total1 + other.frags;
      else if (other.team == TEAM_COLOR2 + 1)
         total2 = total2 + other.frags;

      other.view_ofs = '0 0 0';
      other.angles = other.v_angle = pos.mangle;
      other.fixangle = TRUE;      // turn this way immediately
      other.nextthink = time + 0.5;
      other.takedamage = DAMAGE_NO;
      other.solid = SOLID_NOT;
      other.movetype = MOVETYPE_NONE;
      other.modelindex = 0;
      setorigin (other, pos.origin);

      other = find (other, classname, "player");
   }

/*
//        WriteByte (MSG_ALL, SVC_FINALE);
//        WriteString (MSG_ALL, "\n");

        if (total1 > total2) {
                s2 = "Red Team wins by ";
                s1 = ftos(total1 - total2);
        } else if (total2 > total1) {
                s2 = "Blue Team wins by ";
                s1 = ftos(total2 - total1);
        } else if (total1 == total2) {
                s2 = "Both teams tied with ";
                s1 = "0";
        }

        other = find(world, classname , "player");
        while (other != world)
        {
                msg_entity = other;
                WriteByte(MSG_ONE, SVC_FINALE);
                WriteString(MSG_ONE, "\n");
                ncenterprint(other, "Congratulations!!!!\n\nFrom the deep depths of Quake\n", s2, s1, "\n\n\n\n\n\n\n\n\n\n\n\n\n\nSuper Capture The Flag\nhttp://www.campquake.com/sctf","","","");
                other = find(other,classname, "player");
        }


        pos = spawn();
        pos.nextthink = time + 25;
        pos.think = intermission_t;*/
        WriteByte (MSG_ALL, SVC_INTERMISSION);
};


void() changelevel_touch =
{
   local entity   pos;
        local float noexit;

        // set noexit
   if (other.classname != "player")
      return;

// *XXX* EXPERT CTF
// Removed code that made exits do nothing in CTF games

        noexit = cvar("noexit");

        if (((noexit == 1) || (noexit == 2 && !gamestart)) && ((teamplay & TEAM_CAPTURE_FLAG) ))
      return;

        // if noexit is 4, the person won't get killed, nothing will happen
        if(noexit==4)
                return;

        if (((noexit == 1) || (noexit == 2)) && (mapname != "start"))
   {
      T_Damage (other, self, self, 50000);
      return;
   }

   bprint (other.netname);
   bprint (" exited the level\n");
   
   nextmap = self.map;

   SUB_UseTargets ();

   self.touch = SUB_Null;

// we can't move people right now, because touch functions are called
// in the middle of C movement code, so set a think time to do it
   self.think = execute_changelevel;
   self.nextthink = time + 0.1;
};

/*QUAKED trigger_changelevel (0.5 0.5 0.5) ? NO_INTERMISSION
When the player touches this, he gets sent to the map listed in the "map" variable.  Unless the NO_INTERMISSION flag is set, the view will go to the info_intermission spot and display stats.
*/
void() trigger_changelevel =
{
// ZOID:  If we are in CTF on start map, but not custom, change these
// info trigger vote exits
   if (gamestart && !(teamplay & TEAM_CAPTURE_CUSTOM)) {
                InitTrigger ();
      if (self.map == "e1m1")
         self.message = "E1 Dimension of the Doomed";
      else if (self.map == "e2m1")
         self.message = "E2 The Realm of Black Magic";
      else if (self.map == "e3m1")
         self.message = "E3 The Netherworld";
      else if (self.map == "e4m1")
         self.message = "E4 The Elder World";
      else if (self.map == "end")
         self.message = "The Deathmatch Arenas";
      else
         self.message = "Unknown";
      self.classname = "trigger_voteexit";
//                trigger_voteexit();

                // change what it touches
                self.touch = voteexit_touch;
      return;
   }

   if (!self.map)
                objerror ("changelevel trigger doesn't have map");
   
        InitTrigger ();
   self.touch = changelevel_touch;
};


/*
=============================================================================

            PLAYER GAME EDGE FUNCTIONS

=============================================================================
*/

void() set_suicide_frame;

// called by ClientKill and DeadThink
void() respawn =
{
   // dprint("respawn() ");
   // dprint(self.netname);
   // dprint("\n");

   // make a copy of the dead body for appearances sake
   CopyToBodyQue (self);
   // set default spawn parms
   SetNewParms ();
   // respawn      
   PutClientInServer ();
};


/*
============
ClientKill

Player entered the suicide command
============
*/
void() ClientKill =
{
   // dprint("clientkill() ");
   // dprint(self.netname);
   // dprint("\n");

        local string pppp;
        local float ppp;

        if (self.inferno_flag & OBSERVER_FLAG)
                return;  // you can't suicide when you're just an observer

        if (gamestart) {
                sprint(self, "Life just started.\n");
                return;
        }
   if (self.suicide_count > 3) {
      sprint(self, "You have suicided too much already.\n");
      return;
   }
   bprint (self.netname);
   bprint (" suicides\n");
   DropRune();
        TeamCaptureDropFlagOfPlayer(self);
   set_suicide_frame ();
   self.modelindex = modelindex_player;
   self.frags = self.frags - 2;   // extra penalty

        self.died = self.died + 2;  // update number of deaths

        ppp = 3 - self.suicide_count;

        pppp = ftos(ppp);

        sprint(self, "You have ");
        sprint(self, pppp);
        sprint(self, " chances of suiciding left\n");
   self.suicide_count = self.suicide_count + 1;
   respawn ();
};

void() SilentKill =
{
   set_suicide_frame ();
   self.modelindex = modelindex_player;
   respawn ();
};

float(vector v) CheckSpawnPoint = {return FALSE;};

/*
============
SelectSpawnPoint

Returns the entity to spawn at
============
*/
entity() SelectSpawnPoint =
{
   local   entity spot;
   
// testinfo_player_start is only found in regioned levels
   spot = find (world, classname, "testplayerstart");
   if (spot)
      return spot;
      
// choose a info_player_deathmatch point
   if (!self.killed) {
      spot = TeamCaptureSpawn();
      if (spot != world) 
         return spot;
   } else if (gamestart && self.killed && (teamplay & TEAM_CAPTURE_CUSTOM)) {
                     lastvotespawn = find(lastvotespawn, classname, "info_vote_destination");
                     if (lastvotespawn == world)
                             lastvotespawn = find(lastvotespawn, classname, "info_vote_destination");
      return lastvotespawn;
   }
   
   lastspawn = find(lastspawn, classname, "info_player_deathmatch");
   if (lastspawn == world)
      lastspawn = find (lastspawn, classname, "info_player_deathmatch");
   if (lastspawn != world)
      return lastspawn;
   

   if (serverflags)
   {   // return with a rune to start
      spot = find (world, classname, "info_player_start2");
      if (spot)
         return spot;
   }
   
   spot = find (world, classname, "info_player_start");
   if (!spot)
      error ("SelectSpawnPoint: no info_player_start on level");
   
   return spot;
   
// testinfo_player_start is only found in regioned levels
   spot = find (world, classname, "testplayerstart");
   if (spot)
      return spot;      
};

void() DecodeLevelParms;
void() PlayerDie;


// INFERNO:  Touch added here
void() PlayerTouch =
{
   local entity e;
   local float f1;

   // person has raiden rune, push the enemy
   if (self.inferno_flag & FR_RAIDEN) {
       if (other.classname == "player") {
          other.velocity = self.velocity;
          if (self.regen_time < time) {
               other.reason_died = "raiden move";
               T_Damage(other, self, self, 25);
               other.reason_died = "";
               self.regen_time = time + 0.2;
          }
       }
       return;
   }

   // person has kano rune, push the enemy
   if (self.inferno_flag & FR_KANO) {
      if (other.classname == "player") {
         other.velocity = self.velocity;
         if (self.regen_time < time) {
            other.reason_died = "cannonball";
            T_Damage(other, self, self, 50);
            other.reason_died = "";
            self.rune_count = time;  // remove the cannonball
         }
      }
      return;
   }

   // person has kang rune, push the enemy
   if (self.inferno_flag & FR_KANG) {
      if (other.classname == "player") {
         other.velocity = self.velocity;
         if (self.regen_time < time) {
            other.reason_died = "flying kick";
            T_Damage(other, self, self, 55);
            other.reason_died = "";
            self.rune_count = time;  // remove the cannonball
         }
      }
      return;
   }

   // person has johnny cage rune, push the enemy too (shadow ram)
   if (self.inferno_flag & FR_JCAGE) {
      if (other.classname == "player") {
         other.velocity = self.velocity;
         if (self.regen_time < time) {
               other.reason_died = "shadow ram";
               T_Damage(other, self, self, 30);
               other.reason_died = "";
               self.regen_time = time + 0.2;
         }
      } 
      return;
   }

   // werewolf rune, the bite!
   if (self.rune == RUNE_WEREWOLF) {
      if (!(self.status_flag & ITEM_SECOND_RUNE)) {
         if (other.health) {
            if (other.takedamage == DAMAGE_AIM) {
              if (self.rune_count < time) {
                  other.reason_died = "werewolf bite";
                  T_Damage(other, self, self, 25);
                  other.reason_died = "";
                  self.rune_count = time + 0.3;
               }
            }
         }
      }
      return;
   }

   // kung lao rune, damage them a lot!!
   // if (self.rune == RUNE_LAO) {
   //    if (self.status_flag & ITEM_SECOND_RUNE) {
   //       if (other.health) {
   //          if (other.takedamage == DAMAGE_AIM) {
   //             f1 = 0;
   //             e = find(world, classname, "whirlwind spin");
   //             while (e != world)
   //             {
   //                if (e.owner == self && !e.cnt)
   //                   f1 = 1;
   //                e = find(e,classname,"whirlwind spin");
   //             }
   //          }
   //       }
   //     }
   //     if (self.rune_count < time && f1) {
   //        other.reason_died = "whirlwind spin";
   //        T_Damage(other, self, self, 50);
   //        other.reason_died = "";
   //        self.rune_count = time + 0.4;
   //     }
   //     return;
   // }
};

// chasecam
void() Chase_cam_level_start;

/*
===========
PutClientInServer
called each time a player is spawned
============
*/
void() PutClientInServer =
{
   // dprint("putclientinserver() ");
   // dprint(self.netname);
   // dprint("\n");

   local   entity spot;
   local float f1;

   spot = SelectSpawnPoint (); 

   //ZOID: Minimize chance of telefragging someone, from Johannes Plass
   //(plass@dipmza.physik.uni-mainz.de) ServerModules package
   spot = TelefragSelectSpawnPoint(spot);

   if (self.hooker != world)
   {
      dprint(self.netname);
      dprint(" HOOK found active in putclientinserver()!\n");
      // sprint(self," HOOK found active in putclientinserver()!\n");
      BreakChain (self.hooker);
      remove (self.hooker);
   }
   //  self.clone1 = world;    
   // self.clone2 = world;
   self.hooker = world;
   self.hook_out = 0;
   self.proxiCount = 0;
   self.boobCount = 0;
   self.mentalHound = 0;
   self.mentalHoundTime = 0;
   self.motdDisplay = 1;
   self.entityType = PLAYER_TYPE; // 0 = other, 1 = player, 2 = clone, 
   self.eeTime = 0;
   self.eeFlag = 0;
   self.eeMsg = 0;
   self.granted_flag = 0; // admin can change clear server is locked
   if (self.plagueEntity != world)
      remove(self.plagueEntity);
   self.plagueEntity = world;
   if (self.MedicEntity != world)
      remove(self.MedicEntity);
   self.MedicEntity = world;
   self.classname = "player";
   self.health = 100;
   RuneApplyPowers();  

   self.takedamage = DAMAGE_AIM;
   self.solid = SOLID_SLIDEBOX;

   self.movetype = MOVETYPE_WALK;
   self.show_hostile = 0;
   self.max_health = 100;

   if (self.accesslvl == 9)
           self.status_flag = self.status_flag | ADMIN_PLAYER_FLAG;

   self.weapon = IT_SHOTGUN;
   self.nweapon = NEW_SHOTGUN;
   // set inferno_flag to 0
   if (!(self.inferno_flag & DO_OBSERVER_FLAG))// || !(self.inferno_flag & OBSERVER_FLAG))
           self.inferno_flag = 0;
   self.runeb_rune = 0;

   self.pq_finished = self.pq_time = self.rs_finished = self.rs_time = self.nitems = 0;

   self.flags = FL_CLIENT;
   self.air_finished = time + 12;
   self.dmg = 2;                   // initial water damage
   self.super_damage_finished = 0;
   self.radsuit_finished = 0;
   self.invisible_finished = 0;
   self.invincible_finished = 0;
   self.effects = 0;
   self.invincible_time = 0;
   self.staydeadtime = 0;
   self.regen_time = 0;
   self.rune_notice_time = 0;
   self.bigHead = 0;
   self.last_hurt_carrier = -10;

   DecodeLevelParms ();

   W_SetCurrentAmmo ();
   self.attack_finished = time;
   self.th_pain = player_pain;
   self.th_die = PlayerDie;
   
   self.deadflag = DEAD_NO;

   // paustime is set by teleporters to keep the player from moving a while
   self.pausetime = 0;
   
   self.origin = spot.origin + '0 0 1';
   self.angles = spot.angles;
   self.fixangle = TRUE;           // turn this way immediately

   // oh, this is a hack!
   setmodel (self, "progs/eyes.mdl");
   modelindex_eyes = self.modelindex;

   if (runespawned) {  // works only when deathmatch is on
      // *** Here Goes Nothing; The Ghost Rune *** //
      setmodel (self, "progs/v_axe.mdl");
      modelindex_v_axe = self.modelindex;
      if (teamplay & TEAM_CAPTURE_CUSTOM) {
              setmodel (self, "progs/v_star.mdl");
              modelindex_v_star = self.modelindex;
      } else modelindex_v_star = self.modelindex;
      setmodel (self, "progs/v_shot.mdl");
      modelindex_v_shot = self.modelindex;
      setmodel (self, "progs/v_shot2.mdl");
      modelindex_v_shot2 = self.modelindex;
      setmodel (self, "progs/v_nail.mdl");
      modelindex_v_nail = self.modelindex;
      setmodel (self, "progs/v_nail2.mdl");
      modelindex_v_nail2 = self.modelindex;
      setmodel (self, "progs/v_rock.mdl");
      modelindex_v_rock = self.modelindex;
      setmodel (self, "progs/v_rock2.mdl");
      modelindex_v_rock2 = self.modelindex;
      setmodel (self, "progs/v_light.mdl");
      modelindex_v_light = self.modelindex;
      // *** end of the Ghost modelindex's *** //

      // probably the smallest object in quake, the bubble
      setmodel (self, "progs/flame2.mdl");
      modelindex_flame2 = self.modelindex;

      // just a rocket
      setmodel (self, "progs/missile.mdl");
      modelindex_rocket = self.modelindex;

      // soldier
      setmodel (self, "progs/soldier.mdl");
      modelindex_soldier = self.modelindex;

      // here we go, so the person can turn into an enforcer
      setmodel (self, "progs/enforcer.mdl");
      modelindex_enforcer = self.modelindex;

      // turn into a fish by poseidon
      setmodel (self, "progs/fish.mdl");
      modelindex_fish = self.modelindex;

      // turn into a boss (illusion)
      setmodel (self, "progs/boss.mdl");
      modelindex_boss = self.modelindex;

      // turn into a dog by a curse
      setmodel (self, "progs/dog.mdl");
      modelindex_dog = self.modelindex;

      // the zombie
      setmodel (self, "progs/zombie.mdl");
      modelindex_zombie = self.modelindex;

      // player's head
      setmodel (self, "progs/h_player.mdl");
      modelindex_player_head = self.modelindex;

      // hell knight
      setmodel (self, "progs/hknight.mdl");
      modelindex_hknight = self.modelindex;

      // rebel
      setmodel (self, "progs/knight.mdl");
      modelindex_knight = self.modelindex;

      // oldone
      setmodel (self, "progs/oldone.mdl");
      modelindex_oldone = self.modelindex;

      // hades' gib2
      setmodel (self, "progs/gib2.mdl");
      modelindex_gib2 = self.modelindex;

      // frankenstein's pet
      setmodel (self, "progs/shambler.mdl");
      modelindex_shambler = self.modelindex;

      // trantula
      setmodel (self, "progs/shalrath.mdl");
      modelindex_shalrath = self.modelindex;                
   }

   // for the observer
   setmodel (self, "progs/v_spike.mdl");
   modelindex_v_spike = self.modelindex;

   setmodel (self, "progs/player.mdl");
   modelindex_player = self.modelindex;

   setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);

   self.view_ofs = '0 0 22';

   self.origin = spot.origin + '0 0 1';
   self.angles = spot.angles;
   player_stand1 ();
   
   if (self.inferno_flag & DO_OBSERVER_FLAG && !gamestart) {
      BecomeObserver(self);
      return;
   }

   makevectors(self.angles);
   spawn_tfog (self.origin + v_forward*20);

   spawn_tdeath (self.origin, self);

   f1 = random()*10;
   // now for randomly getting your flag
   if (f1 <= 1)
           self.pick_flag = 1;
   else if (f1 <= 3)
           self.pick_flag = 2;
   else if (f1 <= 5)
           self.pick_flag = 3;
   else if (f1 <= 7)
           self.pick_flag = 4;
   else
           self.pick_flag = 5;

   // check for the m4d sk1llz rune
   checkForM4dSk1llzRune();

   checkForGodMode();

   // initial respawn invincibility
   self.respawnInvincibleFlag = 1;
	self.invincible_time = 1;
	self.invincible_finished = time + RESPAWN_INVINCIBLE_TIME;

};


void() checkForM4dSk1llzRune =
{
   local float okRune;
   okRune = 0;

   // you gotta be 2 minutes into the game before anything can happen
   if (m4dTimer > time)
      return;

   // only 1 player at a time can have it
   if (m4dToken)
      return;

   // DM rules are simple, and will probably need to be tuned.
   if (!(teamplay & TEAM_CAPTURE_FLAG)) {
      // not teamplay, must be DM.
      local entity frinder;
      if (self.consecutiveFragged >= M4D_FRAGGED) {
         // no one can have fewer frags than you
         frinder = find(world, classname, "player");
         okRune = 1;
         while (frinder)
         {
            if (frinder.frags < self.frags) {
               okRune = 0;
               frinder = world;
            }
            else
               frinder = find(frinder, classname, "player");
         }
      }
   }

   else {
      // for teamplay, the algorithm is:
      // (((teamtotal / teamplayer) * killed) / fraglimit) = 
      // chance of getting rune.
      // Constraints: 
      //    Player must be on the losing team.
      //    Player must have the lowest score on his team.

      // get the scores
      local entity frinder;
      local float okRune;
      okRune = 0;
      if ((teamplay & TEAM_CAPTURE_FLAG)) {
         local float total1;
         local float total2;
         local float team1Size;
         local float team2Size;
         local float lowScoreTeam1;
         local float lowScoreTeam2;
         team1Size = 0;
         team2Size = 0;
         total1 = 0;
         total2 = 0;
         
         frinder = find(world, classname, "player");
         while (frinder)
         {
            if (frinder.team == TEAM_COLOR1 + 1) {
               team1Size = team1Size + 1;
               total1 = total1 + frinder.frags;
            }
            if (frinder.team == TEAM_COLOR2 + 1) {
               team2Size = team2Size + 1;
               total2 = total2 + frinder.frags;
            }
            frinder = find(frinder, classname, "player");
         }

         local float teamDelta;
         local float teamSize;
         teamDelta = 0;
         if (total1 > total2) {
            if (self.team == (TEAM_COLOR2+1)) {
               teamSize = team2Size;
               teamDelta = total1 - total2;
            }
         } else if (total2 > total1) {
            if (self.team == (TEAM_COLOR1+1)) {
               teamSize = team1Size;
               teamDelta = total2 - total1;
            }
         }
         if (teamDelta >= M4D_DELTA) {
            // Ok player is on a losing team.  

            // The chance of getting the rune is the product
            // of two ratios...
            local float loseRatio;
            local float fraglimit;
            fraglimit = cvar("fraglimit");
            loseRatio = teamDelta / fraglimit;
               
            local float teamRatio;
            teamRatio = self.consecutiveFragged / teamSize;

            local float runeChance;
            runeChance = loseRatio * teamRatio;
            local float chance;
            if (runeChance >= 1)
               okRune = 1;
            else {
               chance = random();
               if (chance <= runeChance)
                  okRune = 1;
            }
            // local string s1;
            // bprint ("lrat["); s1 = ftos(loseRatio); bprint(s1); bprint("] ");
            // bprint ("trat["); s1 = ftos(teamRatio); bprint(s1); bprint("]\n");
            // bprint ("rc["); s1 = ftos(runeChance); bprint(s1); bprint("] ");
            // bprint ("c["); s1 = ftos(chance); bprint(s1); bprint("]\n");
            // endif self is low scorer for his/her team
         }  // endif delta score is enough
      }  // endif teamplay   (redundant)
   }  // endif else teamplay 
   if (okRune) {
      bprint(self.netname);
      bprint(" becomes a l33t player!\n");
      self.fragTotal = 0;
      self.m4dTime = time + M4D_TIME;
      self.m4dFrags = 0;
      self.m4dShots = 0;
      self.rune = RUNE_M4D_SK1LLZ;
      self.message = RuneDescription (RUNE_M4D_SK1LLZ);
      GetRuneNames (self);
      m4dToken = 1;
   }

};

/*
=============================================================================

            QUAKED FUNCTIONS

=============================================================================
*/


/*QUAKED info_player_start (1 0 0) (-16 -16 -24) (16 16 24)
The normal starting point for a level.
*/
void() info_player_start =
{
};


/*QUAKED info_player_start2 (1 0 0) (-16 -16 -24) (16 16 24)
Only used on start map for the return point from an episode.
*/
void() info_player_start2 =
{
};


/*
saved out by quaked in region mode
*/
void() testplayerstart =
{
};

/*QUAKED info_player_deathmatch (1 0 1) (-16 -16 -24) (16 16 24)
potential spawning position for deathmatch games
*/
void() info_player_deathmatch =
{
   // spawn the runes
   StartRuneSpawn();
};

void() info_player_team1 =
{
};

void() info_player_team2 =
{
};

/*QUAKED info_player_coop (1 0 1) (-16 -16 -24) (16 16 24)
potential spawning position for coop games
*/
void() info_player_coop =
{
};

/*
===============================================================================

RULES

===============================================================================
*/

/*
go to the next level for deathmatch
only called if a time or frag limit has expired
*/
void() NextLevel =
{
   local entity o;
   local float reg;
   local string s;

   reg = cvar("registered");

   // episode one
   if (mapname == "e1m1") nextmap = "e1m2";
   else if (mapname == "e1m2") nextmap = "e1m3";
   else if (mapname == "e1m3") nextmap = "e1m4";
   else if (mapname == "e1m4") nextmap = "e1m5";
   else if (mapname == "e1m5") nextmap = "e1m6";
   // Insert PLevel code
   else if (mapname == "e1m6") {
      if (teamplay & TEAM_CAPTURE_CUSTOM)
         nextmap = "ctfstart";
      else nextmap = "start";
      if ((teamplay & TEAM_PLEVELS) || (reg & TEAM_PLEVELS)) nextmap = "e2m1";
   }
   else if (mapname == "e1m8") nextmap = "e2m1";
   else if (mapname == "e1m7") nextmap = "e1m8";
   else if (mapname == "e1m8") {
      if (teamplay & TEAM_CAPTURE_CUSTOM)
         nextmap = "ctfstart";
      else nextmap = "start";
   }

   // Next seven lines removed to include PLevels
   //   else if (mapname == "e1m6") nextmap = "e1m7";
   //   else if (mapname == "e1m7") nextmap = "e1m8";
   //   else if (mapname == "e1m8") {
   //      if (teamplay & TEAM_CAPTURE_CUSTOM)
   //         nextmap = "ctfstart";
   //      else nextmap = "start";
   //   }
   
   // episode two
   else if (mapname == "e2m1") nextmap = "e2m2";
   else if (mapname == "e2m2") nextmap = "e2m3";
   // Insert PLevel Code
   else if (mapname == "e2m3") {
      if ((teamplay & TEAM_PLEVELS) || (reg & TEAM_PLEVELS)) nextmap = "e2m5";
      else nextmap = "e2m4";
   } else if (mapname == "e2m4") nextmap = "e2m5";
      else if (mapname == "e2m5") {
         if ((teamplay & TEAM_PLEVELS) || (reg & TEAM_PLEVELS)) nextmap = "e4m3";
      else nextmap = "e2m6";
   }
	else if (mapname == "e2m6") nextmap = "e2m7";
   else if (mapname == "e2m7") {
      if (teamplay & TEAM_CAPTURE_CUSTOM)
         nextmap = "ctfstart";
      else nextmap = "start";
   }

   // Next nine lines removed to include PLevels
   // else if (mapname == "e2m3") nextmap = "e2m4";
   // else if (mapname == "e2m4") nextmap = "e2m5";
   // else if (mapname == "e2m5") nextmap = "e2m6";      
   // else if (mapname == "e2m6") nextmap = "e2m7";      
   // else if (mapname == "e2m7") { 
   //    if (teamplay & TEAM_CAPTURE_CUSTOM)
   //       nextmap = "ctfstart";
   //    else nextmap = "start";   
   //  }

   // episode three
   else if (mapname == "e3m1") nextmap = "e3m2";
   else if (mapname == "e3m2") nextmap = "e3m3";
   else if (mapname == "e3m3") nextmap = "e3m4";
   else if (mapname == "e3m4") nextmap = "e3m5";
   else if (mapname == "e3m5") nextmap = "e3m6";
   else if (mapname == "e3m6") nextmap = "e3m7";
   else if (mapname == "e3m7") {
      if (teamplay & TEAM_CAPTURE_CUSTOM)
         nextmap = "ctfstart";
      else nextmap = "start";
   }

   // episode four
   else if (mapname == "e4m1") nextmap = "e4m2";
   else if (mapname == "e4m2") nextmap = "e4m3";
   else if (mapname == "e4m3") nextmap = "e4m4";
   else if (mapname == "e4m4") nextmap = "e4m5";
   else if (mapname == "e4m5") nextmap = "e4m6";
   // Insert PLevel code
   else if (mapname == "e4m6") {
      if ((teamplay & TEAM_PLEVELS) || (reg & TEAM_PLEVELS)) nextmap = "dm3";
      else nextmap = "e4m7";
   } 
   else if (mapname == "e4m7") nextmap = "e4m8";
   else if (mapname == "e4m8") {
      if (teamplay & TEAM_CAPTURE_CUSTOM)
         nextmap = "ctfstart";
      else nextmap = "start";
      if ((teamplay & TEAM_PLEVELS) || (reg & TEAM_PLEVELS)) nextmap = "dm2";
   }
           
   // Next seven lines removed to include PLevels
   // else if (mapname == "e4m6") nextmap = "e4m7";
   // else if (mapname == "e4m7") nextmap = "e4m8";
   // else if (mapname == "e4m8") {
   //    if (teamplay & TEAM_CAPTURE_CUSTOM)
   //       nextmap = "ctfstart";
   //    else nextmap = "start";
   // }   

   // the deathmatch arenas
   else if (mapname == "dm1") nextmap = "dm2";
   else if (mapname == "dm2") nextmap = "dm3";
   // insert PLevel code
   else if (mapname == "dm3") {
      if ((teamplay & TEAM_PLEVELS) || (reg & TEAM_PLEVELS)) nextmap = "dm6";
      else nextmap = "dm4";
   } 
   else if (mapname == "dm4") nextmap = "dm5";
	else if (mapname == "dm5") nextmap = "dm6";
   else if (mapname == "dm6") {
      if (teamplay & TEAM_CAPTURE_CUSTOM)
         nextmap = "ctfstart";
      else nextmap = "start";
      reg = reg - (reg & TEAM_PLEVELS);
      s = ftos(reg);
      cvar_set("registered", s);
   }   
   
   // next eight lines removed for PLeves
   // else if (mapname == "dm3") nextmap = "dm4";
   // else if (mapname == "dm4") nextmap = "dm5";
   // else if (mapname == "dm5") nextmap = "dm6";
   // else if (mapname == "dm6") {
   //    if (teamplay & TEAM_CAPTURE_CUSTOM)
   //       nextmap = "ctfstart";
   //    else nextmap = "start";
   // }

   // INFERNO: the rest are CTF Custom, so there is no need to
   // put the original start level there

   // ctf episode one
   else if (mapname == "ctf1") nextmap = "ctf2";
   else if (mapname == "ctf2") nextmap = "ctf3";
   else if (mapname == "ctf3") nextmap = "ctf4";
   else if (mapname == "ctf4") nextmap = "ctf5";
   else if (mapname == "ctf5") nextmap = "ctf6";
   else if (mapname == "ctf6") nextmap = "ctf7";
   else if (mapname == "ctf7") nextmap = "ctf8";
   else if (mapname == "ctf8") nextmap = "ctfstart";
   else if (mapname == "idctf1") nextmap = "ctfstart";

   // ctf episode two
   else if (mapname == "ctf2m1") nextmap = "ctf2m2";
   else if (mapname == "ctf2m2") nextmap = "ctf2m3";
   else if (mapname == "ctf2m3") nextmap = "ctf2m4";
   else if (mapname == "ctf2m4") nextmap = "ctf2m5";
   else if (mapname == "ctf2m5") nextmap = "ctf2m6";
   else if (mapname == "ctf2m6") nextmap = "ctf2m7";
   else if (mapname == "ctf2m7") nextmap = "ctf2m8";
   else if (mapname == "ctf2m8") nextmap = "ctfstart";
   
   else if (mapname == "ctfstart") nextmap = "ctfstart";  // ctfstart, must loop back
   else if (mapname == "start") nextmap = "start";  // start level, have to go back
   // default go to start
   else  nextmap = "start";  

   o = spawn();
   o.map = nextmap;
   o.think = execute_changelevel;
   o.nextthink = time + 0.1;

   return;

   // DISABLED from here

   // find a trigger changelevel
   o = find(world, classname, "trigger_changelevel");

   // go back to start if no trigger_changelevel
   if (!o)
   {
      mapname = "start";
      o = spawn();
      o.map = mapname;
   }

   nextmap = o.map;
   gameover = TRUE;
   
   if (o.nextthink < time)
   {
      o.think = execute_changelevel;
      o.nextthink = time + 0.1;
   }

};



// Return a new random level, that doesn't match old

// Rewriten for CTF
// uses the server temp1 cvar for level tracking
// temp1 is mapped out as:
//  bit 16 to 12 for id level num 0xf800, 63488
//  bit 11 to 7 for Custom level num 0x0f80, 3968
//  bit 6 to 0 for percent of custom CTF levels 0x007f, 127
// server ops should just set temp1 to the percent and the start id/ctf
// levels will be zero (first level)
// 1 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536
// ---------------- --------------------- ---------------------------
// x x x x  x  x  x
//                  x   x   x   x    x
//                                        x    x    x     x     x
//

/* Lets get rid of the Random Levels - runes are much more fun!
string(string old) RandomLevel =
{
        local float idlvl, ctflvl, percent, r, randdy;
        local string smap, s;

   r = random();
        randdy = random();
//        if (cvar("registered") == 101)
//                return;  // disabled

   if (teamplay & TEAM_CAPTURE_FLAG) {
      // extract stuff from temp1
                percent = 60 & 127;
                idlvl = (60 & 3968) / 128;
                ctflvl = (60 & 126976) / 4096;
//                percent = 60 & 127;
//                idlvl = (60 & 3968) / 128;
//                ctflvl = (60 & 126976) / 4096;

      if ((random() < percent / 100.0) && (teamplay & TEAM_CAPTURE_CUSTOM)) {
         ctflvl = ctflvl + 1;
                        if (ctflvl == 1) {
                                if (randdy < 0.5) smap = "ctf2";
                                else smap = "ctf2m2";
                        }
                        else if (ctflvl == 2) {
                                if (randdy < 0.5) smap = "ctf3";
                                else smap = "ctf2m3";
                        }
                        else if (ctflvl == 3) {
                                if (randdy < 0.5) smap = "ctf4";
                                else smap = "ctf2m4";
                        }
                        else if (ctflvl == 4) {
                                if (randdy < 0.5) smap = "ctf5";
                                else smap = "ctf2m5";
                        }
                        else if (ctflvl == 5) {
                                if (randdy < 0.5) smap = "ctf6";
                                else smap = "ctf2m6";
                        }
                        else if (ctflvl == 6) {
                                if (randdy < 0.5) smap = "ctf7";
                                else smap = "ctf2m7";
                        }
                        else if (ctflvl == 7) {
                                if (randdy < 0.5) smap = "ctf8";
                                else smap = "ctf2m8";
                        }
         else {
                                if (randdy < 0.5) smap = "ctf1";
                                else smap = "ctf2m1";
            ctflvl = 0;
         }
                } else {
         // capture levels
         idlvl = idlvl + 1;
                        if (idlvl == 1) {
                                if (randdy < 0.5) smap = "e1m2";
                                else smap == "e1m3";
                        }
                        else if (idlvl == 2) {
                                if (randdy < 0.5) smap = "e1m4";
                                else smap = "e1m5";
                        }
                        else if (idlvl == 3) {
                                if (randdy < 0.5) smap = "e1m6";
                                else smap = "e1m8";
                        }
                        else if (idlvl == 4) {
                                if (randdy < 0.5) smap = "e2m1";
                                else smap = "e2m2";
                        }
                        else if (idlvl == 5) {
                                if (randdy < 0.5) smap = "e2m3";
                                else smap = "e2m4";
                        }
                        else if (idlvl == 6) {
                                if (randdy < 0.5) smap = "e2m5";
                                else smap = "e2m6";
                        }
                        else if (idlvl == 7) {
                                if (randdy < 0.5) smap = "e2m7";
                                else smap = "e3m1";
                        }
                        else if (idlvl == 8) {
                                if (randdy < 0.5) smap = "e3m2";
                                else smap = "e3m3";
                        }
                        else if (idlvl == 9) {
                                if (randdy < 0.5) smap = "e3m4";
                                else smap = "e3m5";
                        }
                        else if (idlvl == 10) {
                                if (randdy < 0.5) smap = "e3m6";
                                else smap = "e3m7";
                        }
                        else if (idlvl == 11) {
                                if (randdy < 0.5) smap = "e4m1";
                                else smap = "e4m2";
                        }
                        else if (idlvl == 12) {
                                if (randdy < 0.5) smap = "e4m3";
                                else smap = "e4m4";
                        }
                        else if (idlvl == 13) {
                                if (randdy < 0.5) smap = "e4m5";
                                else smap = "e4m6";
                        }
                        else if (idlvl == 14) {
                                //if (randdy < 0.5)
                                smap = "e4m7";
                                //else smap = "e4m8";
                        }
                        else if (idlvl == 15) {
                                if (randdy < 0.3) smap = "dm2";
                                else smap = "dm3";
                        }
                        else if (idlvl == 16) {
                                if (randdy < 0.5) smap = "dm4";
                                else smap = "dm5";
                        }
         else {
                                if (randdy < 0.3) smap = "dm6";
                                else smap = "e1m1";
            idlvl = 0;
         }
      }
      // recombine the cvar
                s = ftos(ctflvl * 4096 + idlvl * 128 + percent);
//                cvar_set("registered", s);
      return smap;
   }
   if (r > 0.8) {
      r = random() * 7;
      if ((r >= 6) && (old != "e1m1")) return ("e1m1"); // e1m1: Slipgate Complex -- by John Romero
      if ((r >= 5) && (old != "e1m2")) return ("e1m2"); // e1m2: Castle of the Damned -- by Tim Willits
      if ((r >= 4) && (old != "e1m3")) return ("e1m3"); // e1m3: The Necropolis -- by Tim Willits
      if ((r >= 3) && (old != "e1m4")) return ("e1m4"); // e1m4: The Grisly Grotto -- by Tim Willits
      if ((r >= 2) && (old != "e1m5")) return ("e1m5"); // e1m5: Gloom Keep -- by Tim Willits
      if ((r >= 1) && (old != "e1m6")) return ("e1m6"); // e1m6: The Door To Chthon -- by American McGee
// e1m7: The House of Chthon -- removed because of lag problems
      return ("e1m8"); // e1m8: Ziggurat Vertigo --by American McGee
   } else if (r > 0.6) {
      r = random() * 6;
      if ((r >= 5) && (old != "e2m1")) return ("e2m1"); // e2m1: The Installation -- by John Romero
      if ((r >= 4) && (old != "e2m2")) return ("e2m2"); // e2m2: Ogre Citadel -- by John Romero
      if ((r >= 3) && (old != "e2m3")) return ("e2m3"); // e2m3: Crypt of Decay -- by John Romero
      if ((r >= 2) && (old != "e2m4")) return ("e2m4"); // e2m4: The Ebon Fortress  -- by John Romero
      if ((r >= 1) && (old != "e2m5")) return ("e2m5"); // e2m5: The Wizard's Manse -- by John Romero
// e2m6: The Dismal Oubliette -- removed because it sucks for dm
      return ("e2m7"); // e2m7: Underearth --by Tim Willits
   } else if (r > 0.4) {
      r = random() * 6;
      if ((r >= 5) && (old != "e3m1")) return ("e3m1"); // e3m1: Termination Central -- by John Romero
      if ((r >= 4) && (old != "e3m2")) return ("e3m2"); // e3m2: The Vaults of Zin -- by American McGee
      if ((r >= 3) && (old != "e3m3")) return ("e3m3"); // e3m3: The Tomb of Terror -- by American McGee
// e3m4 (Satan's Dark Delight) removed because it sucks for dm
      if ((r >= 2) && (old != "e3m5")) return ("e3m5"); // e3m5: Wind Tunnels --by Tim Willits
      if ((r >= 1) && (old != "e3m6")) return ("e3m6"); // e3m6: Chambers of Torment -- by American McGee & Tim Willits
      return ("e3m7"); // e3m7: The Haunted Halls -- by American McGee
   } else if (r > 0.2) {
      r = random() * 8;
      if ((r >= 7) && (old != "e4m1")) return ("e4m1"); // e4m1: The Sewage System -- by Tim Willits
      if ((r >= 6) && (old != "e4m2")) return ("e4m2"); // e4m2: The Tower of Despair --by Sandy Petersen
      if ((r >= 5) && (old != "e4m3")) return ("e4m3"); // e4m3: The Elder God Shrine --by Sandy Petersen
      if ((r >= 4) && (old != "e4m4")) return ("e4m4"); // e4m4: The Palace of Hate --by Sandy Petersen
      if ((r >= 3) && (old != "e4m5")) return ("e4m5"); // e4m5: Hell's Atrium --by Sandy Petersen
      if ((r >= 2) && (old != "e4m6")) return ("e4m6"); // e4m6: The Pain Maze --by Sandy Petersen
      if ((r >= 1) && (old != "e4m7")) return ("e4m7"); // e4m7: Azure Agony --by Sandy Petersen
      return ("e4m8"); // e4m8: The Nameless City -- by Sandy Petersen
   } else {
      r = random() * 6;
      if ((r >= 5) && (old != "dm1")) return ("dm1"); // dm1: Place of Two Deaths --by Tim Willits
      if ((r >= 4) && (old != "dm2")) return ("dm2"); // dm2: Claustrophobopolis --by American McGee
      if ((r >= 3) && (old != "dm3")) return ("dm3"); // dm3: The Abandoned Base --by John Romero
      if ((r >= 2) && (old != "dm4")) return ("dm4"); // dm4: The Bad Place --by American McGee
      if ((r >= 1) && (old != "dm5")) return ("dm5"); // dm5: The Cistern --by Tim Willits
      return ("dm6"); // dm6: The Dark Zone --by Tim Willits
   }
   return("start");
};
*/

/*
============
CheckRules

Exit deathmatch games upon conditions
============
*/
void() CheckRules =
{
   local   float           timelimit, fraglimit, total1, total2;
   local   entity          p, o;
   local string s;

        // *XXX* EXPERT CTF variables for team frag count
   local string   s;

   if (gameover || pregameover)   // someone else quit the game already
      return;
      
   if (gamestart) {
      if ((vote_leader != world) && voteexit_time && (time > voteexit_time)) {
         pregameover = 1;
         o = spawn();
         nextmap = vote_leader.map;
         o.map = nextmap;
         o.think = execute_changelevel;
         o.nextthink = time + 0.1;
         gamestart = 0;

         // change this if necessary
//         if(vote_leader.message=="Old ID CTF Levels") {
//            reg=cvar("registered");
//            reg=reg|TEAM_PLEVELS;
//            s=ftos(reg);
//            cvar_set("registered",s);
//         }
         return;
      }
      return;
   }
                
   timelimit = cvar("timelimit") * 60;
   fraglimit = cvar("fraglimit");
   
   if ((timelimit && time >= timelimit) ||
      (fraglimit && (self.frags >= fraglimit))) {
                pregameover = 1;
      // count up total
      if (!teamplay) {
         local entity maxFrag;
         maxFrag = world;
         total1 = 0;
         p = find(world, classname, "player");
         while (p != world) {
            if (p.frags > total1) {
               maxFrag = p;
               total1 = p.frags;
            }
            p = find(p, classname, "player");
         }
         if (maxFrag != world) {
            bprint(maxFrag.netname);
            bprint(" won this level with ");
            s = ftos(total1);
            bprint(s);
            bprint(" points!\n");
         }         
      }
      else {
         total1 = total2 = 0;
         p = find(world, classname, "player");
         while (p != world) {
            if (p.lastteam == TEAM_COLOR1 + 1)
               total1 = total1 + p.frags;
            else if (p.lastteam == TEAM_COLOR2 + 1)
               total2 = total2 + p.frags;
            p = find(p, classname, "player");
         }
         if (total1 > total2) {
                        bprint("ред team won the level with ");
                        s = ftos(total1);
                        bprint(s);
                        bprint(" points!\n");
                        bprint("блуе team lost with ");
                        s = ftos(total2);
                        bprint(s);
                        bprint(" points.\n");
         } else if (total2 > total1) {
            bprint("блуе team won the level with ");
                        s = ftos(total2);
            bprint(s);
            bprint(" points!\n");
            bprint("ред team lost with ");
                        s = ftos(total1);
            bprint(s);
            bprint(" points.\n");
         } else {
            bprint("блуе and ред team tied level with ");
            s = ftos(total1);
            bprint(s);
            bprint(" points!\n");
         }
      }
      NextLevel ();
      return;
   }

   // update team scores? 
//        TeamCaptureCheckUpdate();

};

//============================================================================

// used everytime a player dies
void() PlayerDeathThink =
{
        local entity old_self;
        local float forward;

//        self.inferno_flag = self.inferno_flag - (self.inferno_flag & INFERNO_HELP_CHECK);

        if ((self.status_flag & STATUS_PLAYER_FLAG) && !self.motd_time) {//(self.status_flag_count < time)) {
//        if ((self.sctfstatus) && !(self.motd_time && self.motd_time <! time)) {
                if (self.update_time < time)
                        UpdatePlayerStatus(self, "\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
        }

   if (self.rune == RUNE_M4D_SK1LLZ)
      ThrowM4D();

   if (self.pl_duck == 1) { // remove ducking
      // sprint(self, "duck and wine, yummy!\n");
      self.pl_duck = 4; // stop ducking
      self.pl_duck_time = 0;
   }

   if ((self.flags & FL_ONGROUND))
   {
      forward = vlen (self.velocity);
      forward = forward - 20;
      if (forward <= 0)
         self.velocity = '0 0 0';
      else   
         self.velocity = forward * normalize(self.velocity);
   }

// wait for all buttons released
   if (self.deadflag == DEAD_DEAD)
   {
      if (self.button2 || self.button1 || self.button0)
         return;
      self.deadflag = DEAD_RESPAWNABLE;
      return;
   }

// wait for any button down
   if (!self.button2 && !self.button1 && !self.button0)
      return;

        // check if the person dies as an observer...
        if (self.inferno_flag & DIE_OBSERVER_FLAG)
                self.inferno_flag = DO_OBSERVER_FLAG;

   self.button0 = 0;
   self.button1 = 0;
   self.button2 = 0;

        if (!(self.inferno_flag & DIE_OBSERVER_FLAG))
                respawn();
};

void() PlayerJump =
{
   local vector start, end;
        local float hasrune;

        // strong rune
        if (((self.rune == RUNE_STRONG) && !(self.status_flag & ITEM_SECOND_RUNE)) ||
        (self.rune == RUNE_ANT && (self.status_flag & ITEM_SECOND_RUNE)) ||
        ((self.nitems & NITEM_CONV)&&(teamplay&TEAM_CUSTOM_SCTF)))
                hasrune = 1;

   if (self.flags & FL_WATERJUMP)
      return;
   
        if (self.waterlevel >= 2)
   {
                // has the power of flying
//                if (self.player_flag & ITEM_RUNE2_FLAG)
//                        self.velocity_z = 150;
//                else
                if (self.watertype == CONTENT_WATER) {
                        if (hasrune)
                                self.velocity_z = 200;
                        else
                                self.velocity_z = 100;
                } else if (self.watertype == CONTENT_SLIME) {
                        if (hasrune)
                                self.velocity_z = 160;
                        else
                                self.velocity_z = 80;
                } else {
                        if (hasrune)
                                self.velocity_z = 100;
                        else
                                self.velocity_z = 50;
                }

// play swiming sound
      if (self.swim_flag < time)
      {
         self.swim_flag = time + 1;
         if (random() < 0.5)
            sound (self, CHAN_BODY, "misc/water1.wav", 1, ATTN_NORM);
         else
            sound (self, CHAN_BODY, "misc/water2.wav", 1, ATTN_NORM);
      }

      return;
   }

        if (!(self.flags & FL_ONGROUND))
      return;

        if ( !(self.flags & FL_JUMPRELEASED) )
                return;         // don't pogo stick

   self.flags = self.flags - (self.flags & FL_JUMPRELEASED);

   self.flags = self.flags - FL_ONGROUND;   // don't stairwalk
   
   self.button2 = 0;
// player jumping sound
        if ((self.runeb_rune == RUNE_WITCH && self.runeb_time >= time) ||
        (self.rune == RUNE_WEREWOLF))
                sound (self, CHAN_BODY, "dog/dattack1.wav", 1, ATTN_NORM);
        else if (self.rune == RUNE_LIQUID)
                sound (self, CHAN_BODY, "misc/water2.wav", 1, ATTN_NORM);
        else if (self.rune == RUNE_KNIGHT)
                sound (self, CHAN_BODY, "hknight/sight1.wav", 1, ATTN_NORM);
        else if (self.rune == RUNE_FUTURE)
                sound (self, CHAN_BODY, "enforcer/idle1.wav", 1, ATTN_NORM);
        else if ((self.rune == RUNE_ZOMBIE) || 
         (self.runeb_rune == RUNE_DEATH && self.runeb_time >= time) ||
         (self.runeb_rune == RUNE_ZOMBIE && self.runeb_time >= time) 
         )
                sound (self, CHAN_BODY, "zombie/z_idle.wav", 1, ATTN_NORM);
        else if (self.rune == RUNE_ILLUSION && !(self.status_flag & ITEM_SECOND_RUNE))
                sound (self, CHAN_BODY, "boss1/pain.wav", 1, ATTN_NORM);
        else if (self.rune == RUNE_HERMES && (self.status_flag & ITEM_SECOND_RUNE))
                sound (self, CHAN_BODY, "boss2/idle.wav", 1, ATTN_NORM);
        else if (self.rune == RUNE_FP)
                sound (self, CHAN_BODY, "shambler/sidle.wav", 1, ATTN_NORM);
        else if (self.rune == RUNE_TARANTULA)
                sound (self, CHAN_BODY, "shalrath/idle.wav", 1, ATTN_NORM);                
        else if (self.nitems&NITEM_CONV)
                sound (self, CHAN_BODY, "weapons/bounce.wav", 1, ATTN_NORM);
        else
                sound (self, CHAN_BODY, "player/plyrjmp8.wav", 1, ATTN_NORM);

        if (hasrune) {
//                makevectors(self.v_angle);
                self.velocity_z = self.velocity_z + 540;    
//                self.velocity = self.velocity + self.v_angle*1000;
        }
        else 
                self.velocity_z = self.velocity_z + 270;


        // when you're ducking, you don't jump as high
        if(self.pl_duck)self.velocity_z=self.velocity_z*0.8;
};


/*
===========
WaterMove

============
*/
.float   dmgtime;

void() WaterMove =
{
        local float f1;

   if (self.inferno_flag & OBSERVER_FLAG)
      return;

//dprint (ftos(self.waterlevel));
   if (self.movetype == MOVETYPE_NOCLIP)
      return;
        if (self.health < 0)
                return;

        f1=0;
        if ((self.rune == RUNE_LIQUID && !(self.status_flag & ITEM_SECOND_RUNE)) ||
        (self.rune == RUNE_POSEIDON && !(self.status_flag & ITEM_SECOND_RUNE)) ||
        (self.runeb_rune == RUNE_POSEIDON && self.runeb_time >= time) ||
        (self.rune == RUNE_WATER && !(self.status_flag & ITEM_SECOND_RUNE)))
                f1 = 1;

        if (self.waterlevel != 3 && !f1)
   {
         if (self.air_finished < time)
              sound (self, CHAN_VOICE, "player/gasp2.wav", 1, ATTN_NORM);
         else if (self.air_finished < time + 9)
            sound (self, CHAN_VOICE, "player/gasp1.wav", 1, ATTN_NORM);
      self.air_finished = time + 12;
      self.dmg = 2;
   }
        else if (self.air_finished < time && !f1)
        {       // drown!
                if (self.pain_finished < time)
      {
         self.dmg = self.dmg + 2;
         if (self.dmg > 15)
            self.dmg = 10;
         T_Damage (self, world, world, self.dmg);
         self.pain_finished = time + 1;
      }
   }
   
   if (!self.waterlevel)
   {
      if (self.flags & FL_INWATER)
      {
         // play leave water sound
         sound (self, CHAN_BODY, "misc/outwater.wav", 1, ATTN_NORM);
         self.flags = self.flags - (self.flags & FL_INWATER);
      }
       return;
   }

   if (self.watertype == CONTENT_LAVA)
   {   // do damage
      // cure the plague induced by rune medic 2nd power
      if (self.plagueEntity != world) {
         remove(self.plagueEntity);
         self.plagueEntity = world;
      }
          
                if (self.dmgtime < time && (!f1 || (self.rune == RUNE_WATER && !(self.status_flag & ITEM_SECOND_RUNE))))
      {
         if (self.radsuit_finished > time)
            self.dmgtime = time + 1;
         else
            self.dmgtime = time + 0.2;

         T_Damage (self, world, world, 10*self.waterlevel);
      }
   }
   else if (self.watertype == CONTENT_SLIME)
   {   // do damage
      if (self.plagueEntity != world) {
         remove(self.plagueEntity);
         self.plagueEntity = world;
      }
                if (self.dmgtime < time && self.radsuit_finished < time &&
                (!f1 || (self.rune == RUNE_WATER && !(self.status_flag & ITEM_SECOND_RUNE))))
      {
         self.dmgtime = time + 1;
         T_Damage (self, world, world, 4*self.waterlevel);
      }
   }
   else { // must be regular water
      if (self.plagueEntity != world) {
         remove(self.plagueEntity);
         self.plagueEntity = world;
      }
   }
   
        if ( !(self.flags & FL_INWATER) )
   {   

// player enter water sound

                if (self.watertype == CONTENT_LAVA)
         sound (self, CHAN_BODY, "player/inlava.wav", 1, ATTN_NORM);
                if (self.watertype == CONTENT_WATER)
         sound (self, CHAN_BODY, "player/inh2o.wav", 1, ATTN_NORM);
                if (self.watertype == CONTENT_SLIME)
         sound (self, CHAN_BODY, "player/slimbrn2.wav", 1, ATTN_NORM);

//                if (!(self.player_flag & ITEM_RUNE2_FLAG) && !(self.status_flag & ITEM_SECOND_RUNE))
                        self.flags = self.flags | FL_INWATER;
      self.dmgtime = 0;
   }
   
        if ((self.rune != RUNE_PORTAL_MASTER) || !(self.status_flag & ITEM_SECOND_RUNE))
                self.velocity = self.velocity - 0.8*self.waterlevel*frametime*self.velocity;
};

void() CheckWaterJump =
{
   local vector start, end;

// check for a jump-out-of-water
   makevectors (self.angles);
   start = self.origin;
   start_z = start_z + 8; 
        v_forward_z = 0;
   normalize(v_forward);
   end = start + v_forward*24;
   traceline (start, end, TRUE, self);
   if (trace_fraction < 1)
   {   // solid at waist
      start_z = start_z + self.maxs_z - 8;
      end = start + v_forward*24;
      self.movedir = trace_plane_normal * -50;
      traceline (start, end, TRUE, self);
      if (trace_fraction == 1)
      {   // open at eye level
         self.flags = self.flags | FL_WATERJUMP;
         self.velocity_z = 225;
         self.flags = self.flags - (self.flags & FL_JUMPRELEASED);
         self.teleport_time = time + 2;   // safety net
         return;
      }
   }

};

/*
================
PlayerPreThink

Called every frame before physics are run
================
*/
void() PlayerPreThink =
{
        local   float   mspeed, aspeed, r;
        local entity e, ppp;

   if (intermission_running)
   {
      IntermissionThink ();   // otherwise a button could be missed between
      return;               // the think tics
   }
   if (self.staydeadtime && self.staydeadtime > time)
      return;// wait a bit before respawn

   // (inferno) - this person's time is up on picking a spot!
   if((self.flag_picked_time<time)&&(teamplay&TEAM_PICK_BASE)&&
      (self.pick_flag_base))
   {
      UpdatePlayerStatus(self, "Your time is up!!\n\n\n\n\n\n\n\n\n\n\n\n","","");
      if(self.team==TEAM_COLOR1+1)team1_flag_pick=0;
      if(self.team==TEAM_COLOR2+1)team2_flag_pick=0;
      self.pick_flag_base=0;
      self.flag_picked_time=0;
   }

   if (self.inferno_flag & ABLE_KEY2_FLAG) {
      self.velocity = '0 0 0';
      return;
   }

   // *TEAMPLAY*

   if (self.view_ofs == '0 0 0')
      return;      // intermission or finale

        
   // observer_chasing people can't use it!
   makevectors (self.v_angle);             // is this still used

   CheckRules ();
   WaterMove ();

   // *TEAMPLAY*
   // TeamCheckLock performs all necessary teamlock checking, and performs all
   // actions needed.
   // don't do this if spy power is enabled
   TeamCheckLock();

   if (self.waterlevel == 2)
      CheckWaterJump ();

   if (self.deadflag >= DEAD_DEAD)
   {
      PlayerDeathThink ();
      return;
   }
   
   // is the person an observer?
   if (self.inferno_flag & OBSERVER_FLAG) {
      if (self.motdDisplay) {
         if (self.motd_time < time)
            MOTD_ChooseTeam();
      }
      ObserverThink();
      return;
   }

   if (self.motd_time && self.motd_time < time)
      MOTD();

   if (self.deadflag == DEAD_DYING)
      return;   // dying, so do nothing

   if (self.rune == RUNE_M4D_SK1LLZ) {
      // is it time to take away the m4d sk1llsz rune?
      if (self.m4dTime < time) {
         ThrowNRunes (self.rune);
         sprint (self, "M4D SK1LLZ rune fades, timed out...\n");
         self.effects = self.effects - (self.effects & EF_DIMLIGHT);
      }
      // have they had enough fun yet?
      if (self.m4dFrags >= M4D_FRAGS) {
         ThrowNRunes (self.rune);
         sprint (self, "M4D SK1LLZ rune fades, max kills...\n");
         self.effects = self.effects - (self.effects & EF_DIMLIGHT);
      }
      // have they takenenough shots yet?
      if (self.m4dShots >= M4D_SHOTS) {
         ThrowNRunes (self.rune);
         sprint (self, "M4D SK1LLZ rune fades, max shots...\n");
         self.effects = self.effects - (self.effects & EF_DIMLIGHT);
      }
   }
   CheckInfPowerups();  // check the inferno powerups (new keys, runes, etc..)


   if (self.button2) {
      // see if this person has second power rune or not..
      PlayerJump ();
   } else
      self.flags = self.flags | FL_JUMPRELEASED;

   // teleporters can force a non-moving pause time   
   if (time < self.pausetime)
      self.velocity = '0 0 0';

   if (self.status_flag & STATUS_PLAYER_FLAG) {
      if (self.update_time < time && 
         !self.motd_time)
         UpdatePlayerStatus(self, "\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
   }

   // RUNE
   if (time > self.attack_finished && self.currentammo == 0 && 
      self.weapon != IT_AXE)
   {
      self.weapon = W_BestWeapon ();
      self.nweapon = W_BestNWeapon(self.weapon);
      W_SetCurrentAmmo ();
   }
};
   
/*
================
CheckPowerups

Check for turning off powerups
================
*/
void() CheckPowerups =
{
   if (self.health <= 0)
      return;

   if ((gamestart) && (self.flags&FL_GODMODE))
      self.flags=self.flags - FL_GODMODE;

   if (self.inferno_flag & OBSERVER_FLAG)
       self.modelindex = modelindex_v_spike;
   else {

   // invisibility
   if (self.invisible_finished)
   {
      // sound and screen flash when items starts to run out
      if (self.invisible_sound < time)
      {
         sound (self, CHAN_AUTO, "items/inv3.wav", 0.5, ATTN_IDLE);
         self.invisible_sound = time + ((random() * 3) + 1);
      }


      if (self.invisible_finished < time + 3)
      {
         if (self.invisible_time == 1)
         {
            sprint (self, "Ring of Shadows magic is fading\n");
            stuffcmd (self, "bf\n");
            sound (self, CHAN_AUTO, "items/inv2.wav", 1, ATTN_NORM);
            self.invisible_time = time + 1;
         }
         
         if (self.invisible_time < time)
         {
            self.invisible_time = time + 1;
            stuffcmd (self, "bf\n");
         }
      }

      if (self.invisible_finished < time)
      {   // just stopped
         self.items = self.items - IT_INVISIBILITY;
         self.invisible_finished = 0;
         self.invisible_time = 0;
      }
      
      // use the eyes
      self.frame = 0;
      self.modelindex = modelindex_eyes;
   } else if (((self.runeb_rune == RUNE_WITCH) && 
      (self.runeb_time >= time)) ||
      self.rune == RUNE_WEREWOLF || 
      self.monster_type=="Hound") 
   {
      self.modelindex = modelindex_dog;
      setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);

      // die as a dog
      if (self.th_pain != dog_pain)
         self.th_pain = dog_pain;
   }
   else if (self.rune == RUNE_LIQUID || (self.runeb_time >= time && self.runeb_rune == RUNE_POSEIDON)||
      self.monster_type=="Fish") 
   {
      self.modelindex = modelindex_fish;
      setsize(self, '-16 -16 -24', '16 16 24');
      if (self.th_pain != f_pain1)
         self.th_pain = f_pain1;
   } else if (self.monster_type=="Soldier") {
        self.modelindex = modelindex_soldier;
        self.weaponmodel = "";
        if (self.th_pain != army_pain)
           self.th_pain = army_pain;
   } else if (self.rune == RUNE_DISAPEAR && 
      !(self.status_flag & ITEM_SECOND_RUNE)) {
      self.modelindex = modelindex_flame2;
      // setsize(self, '-8 -8 -8', '8 8 8');
      self.weaponmodel = "";
      self.frame = 0;
   } else if (self.rune == RUNE_KNIGHT || self.monster_type=="Hell Knight") {
      self.modelindex = modelindex_hknight;
      if (self.th_pain != hknight_pain1)
         self.th_pain = hknight_pain1;
   } else if (self.rune == RUNE_POSSESSER && (self.status_flag & ITEM_SECOND_RUNE)) {
      self.modelindex = modelindex_rocket;
      self.weaponmodel = "";
   } else if (self.rune == RUNE_FUTURE || self.monster_type=="Enforcer") {
      self.modelindex = modelindex_enforcer;
      self.weaponmodel = "";
      if (self.th_pain != enf_pain)
         self.th_pain = enf_pain;
   } else if (self.rune == RUNE_ILLUSION && 
      !(self.status_flag & ITEM_SECOND_RUNE)) {
      self.modelindex = modelindex_boss;
   } else if (self.monster_type=="Knight") {
      self.modelindex = modelindex_knight;
      self.weaponmodel = "";
      if (self.th_pain != knight_pain)
              self.th_pain = knight_pain;
   } else if ((self.rune == RUNE_GHOST) && !(self.status_flag & ITEM_SECOND_RUNE)) {
      if (self.nweapon == NEW_AXE)
              self.modelindex = modelindex_v_axe;
      if (self.nweapon == NEW_HOOK)
              self.modelindex = modelindex_v_star;
      if (self.weapon == IT_SHOTGUN)
              self.modelindex = modelindex_v_shot;
      if (self.weapon == IT_SUPER_SHOTGUN)
              self.modelindex = modelindex_v_shot2;
      if (self.weapon == IT_NAILGUN)
              self.modelindex = modelindex_v_nail;
      if (self.weapon == IT_SUPER_NAILGUN)
              self.modelindex = modelindex_v_nail2;
      if (self.weapon == IT_GRENADE_LAUNCHER)
              self.modelindex = modelindex_v_rock;
      if (self.weapon == IT_ROCKET_LAUNCHER)
              self.modelindex = modelindex_v_rock2;
      if (self.weapon == IT_LIGHTNING)
              self.modelindex = modelindex_v_light;
      self.frame = self.weaponframe;
      self.weaponmodel = "";
   } else if (self.inferno_flag & OBSERVER_FLAG) {//&& (self.modelindex != modelindex_v_spike) && (self.modelindex != modelindex_player_head)) {
      self.modelindex = modelindex_v_spike;
   } else if ((self.runeb_rune == RUNE_DEATH && self.runeb_time >= time) || 
      (self.runeb_rune == RUNE_ZOMBIE && self.runeb_time >= time) || 
      (self.rune == RUNE_ZOMBIE)) {
      self.modelindex = modelindex_zombie;
      if (self.th_pain != zombie_pain)
              self.th_pain = zombie_pain;
      if (self.rune == RUNE_ZOMBIE)
              self.weaponmodel = "";
   } else if (self.rune == RUNE_HERMES && (self.status_flag & ITEM_SECOND_RUNE))
      self.modelindex = modelindex_oldone;
   else if (self.rune == RUNE_FP) {
      self.modelindex = modelindex_shambler;
      self.weaponmodel = "";
      if (self.th_pain != sham_pain)
              self.th_pain=sham_pain;
    } else if (self.rune == RUNE_TARANTULA) {
      self.modelindex = modelindex_shalrath;
      self.weaponmodel = "";
            if (self.th_pain != shalrath_pain)
              self.th_pain=shalrath_pain;
   } else {
      self.modelindex = modelindex_player;    // don't use eyes

      setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
      // die as human
      if (self.th_pain != player_pain)
              self.th_pain = player_pain;
   }

   // INFERNO:  No matter what, the person WILL DUCK!
   if(self.pl_duck) {
      setsize(self, '-16 -16 0', '16 16 32');
      if (self.pl_duck_time < time && self.pl_duck != 1) 
      {
         //local string s;
         if (self.pl_duck==3)
            self.pl_duck=0;
         else {
            self.pl_duck=3;
            self.pl_duck_time = time + 0.2;
            self.velocity_z=450;
         }
         //s = ftos(self.pl_duck);
         //sprint (self, "Self duckstate = (");
         //sprint (self, s);
         //sprint (self, ")\n");
      }
   }

   // invincibility
   if (self.invincible_finished)
   {
      // sound and screen flash when items starts to run out
      if (self.invincible_finished < time + 3)
      {
         if (self.invincible_time == 1)
         {
            sprint (self, "Protection is almost burned out\n");
            stuffcmd (self, "bf\n");
            sound (self, CHAN_AUTO, "items/protect2.wav", 1, ATTN_NORM);
            self.invincible_time = time + 1;
         }
         
         if (self.invincible_time < time)
         {
            self.invincible_time = time + 1;
            stuffcmd (self, "bf\n");
         }
      }
      
      if (self.invincible_finished < time)
      {   // just stopped
         self.respawnInvincibleFlag = 0; 
         self.items = self.items - (self.items & IT_INVULNERABILITY);
         self.invincible_time = 0;
         self.invincible_finished = 0;
      }

      // ZOID, next line isn't needed, EF_DIMLIGHT is handled by
      // client.qc:CheckDimLight
      //      if (self.invincible_finished > time)
      //         self.effects = self.effects | EF_DIMLIGHT;
      //      else
      //         self.effects = self.effects - (self.effects & EF_DIMLIGHT);
   }

   // super damage
   if (self.super_damage_finished)
   {
      // sound and screen flash when items starts to run out
      if (self.super_damage_finished < time + 3)
      {
         if (self.super_time == 1)
         {
            sprint (self, "Quad Damage is wearing off\n");
            stuffcmd (self, "bf\n");
            sound (self, CHAN_AUTO, "items/damage2.wav", 1, ATTN_NORM);
            self.super_time = time + 1;
         }     
         
         if (self.super_time < time)
         {
            self.super_time = time + 1;
            stuffcmd (self, "bf\n");
         }
      }

      if (self.super_damage_finished < time)
      {   // just stopped
         self.items = self.items - IT_QUAD;
         self.super_damage_finished = 0;
         self.super_time = 0;
      }

      // ZOID, next line isn't needed, EF_DIMLIGHT is handled by
      // client.qc:CheckDimLight
      //      if (self.super_damage_finished > time)
      //         self.effects = self.effects | EF_DIMLIGHT;
      //      else
      //         self.effects = self.effects - (self.effects & EF_DIMLIGHT);
   }   

   // rs
   if (self.rs_finished)
   {
      // sound and screen flash when items starts to run out
      if (self.rs_finished < time + 3)
      {
         if (self.rs_time == 1)
         {
            sprint (self, "Shield is almost burned out\n");
            stuffcmd (self, "bf\n");
            sound (self, CHAN_AUTO, "shambler/melee1.wav", 1, ATTN_NORM);
            self.rs_time = time + 1;
         }
         
         if (self.rs_time < time)
         {
            self.rs_time = time + 1;
            stuffcmd (self, "bf\n");
         }
      }
      
      if (self.rs_finished < time)
      {   // just stopped
         self.nitems = self.nitems - NITEM_RSHIELD;
         self.rs_time = 0;
         self.rs_finished = 0;
      }
   }
   // pq
   if (self.pq_finished)
   {
      // sound and screen flash when items starts to run out
      if (self.pq_finished < time + 3)
      {
         if (self.pq_time == 1)
         {
            sprint (self, "PentaQuad is wearing off\n");
            stuffcmd (self, "bf\n");
            sound (self, CHAN_AUTO, "ogre/ogdrag.wav", 1, ATTN_NORM);
            self.pq_time = time + 1;
         }     
         if (self.pq_time < time)
         {
            sound (self, CHAN_AUTO, "ogre/ogdrag.wav", 1, ATTN_NORM);
            self.pq_time = time + 1;
            stuffcmd (self, "bf\n");
         }
      }

      if (self.pq_finished < time)
      {   // just stopped
         self.nitems = self.nitems - NITEM_PQ;
         self.pq_finished = 0;
         self.pq_time = 0;
      }

      // ZOID, next line isn't needed, EF_DIMLIGHT is handled by
      // client.qc:CheckDimLight
      //      if (self.super_damage_finished > time)
      //         self.effects = self.effects | EF_DIMLIGHT;
      //      else
      //         self.effects = self.effects - (self.effects & EF_DIMLIGHT);
   }

   // suit
   if (self.radsuit_finished)
   {
      self.air_finished = time + 12;      // don't drown

      // sound and screen flash when items starts to run out
      if (self.radsuit_finished < time + 3)
      {
         if (self.rad_time == 1)
         {
            sprint (self, "Air supply in Biosuit expiring\n");
            stuffcmd (self, "bf\n");
            sound (self, CHAN_AUTO, "items/suit2.wav", 1, ATTN_NORM);
            self.rad_time = time + 1;
         }
         
         if (self.rad_time < time)
         {
            self.rad_time = time + 1;
            stuffcmd (self, "bf\n");
         }
      }

      if (self.radsuit_finished < time)
      {   // just stopped
         self.items = self.items - IT_SUIT;
         self.rad_time = 0;
         self.radsuit_finished = 0;
      }
   }   

   // Check to see about DIMLIGHT effects
   CheckDimLight();

   }
};


/*
================
PlayerPostThink

Called every frame after physics are run
================
*/
void() PlayerPostThink =
{
   local   float   mspeed, aspeed, r;
   local   string  num;

   // This code will kick a stoogebot
   CheckBot();

   if (self.view_ofs == '0 0 0')
      return;      // intermission or finale

   if (self.inferno_flag & OBSERVER_FLAG)
   {
      self.modelindex = modelindex_v_spike;
      return;
   }
   if (self.deadflag)
      return;
      
   if (self.inferno_flag & ABLE_KEY2_FLAG) {
       self.velocity = '0 0 0';
       return;
   }

   // check if they should turn off the rune

   // do weapon stuff

   W_WeaponFrame ();

   // check to see if player landed and play landing sound
   if ((self.jump_flag < -300) && (self.flags & FL_ONGROUND) && (self.health > 0))
   {
      if (self.watertype == CONTENT_WATER)
         sound (self, CHAN_BODY, "player/h2ojump.wav", 1, ATTN_NORM);
      else if (self.jump_flag < -650)
      {
         T_Damage (self, world, world, 5); 
         sound (self, CHAN_VOICE, "player/land2.wav", 1, ATTN_NORM);
         self.deathtype = "falling";
      }
      else
         sound (self, CHAN_VOICE, "player/land.wav", 1, ATTN_NORM);

      self.jump_flag = 0;
   }

   if (!(self.flags & FL_ONGROUND))
      self.jump_flag = self.velocity_z;

   CheckPowerups ();
   if ((self.items & IT_INVISIBILITY) && (self.invisible_finished < time))// && (!(self.key_flag & ITEM_KEY6_FLAG) || (self.status_flag & ITEM_SECOND_RUNE)) && (!(self.key_flag & ITEM_KEY5_FLAG) || (self.status_flag & ITEM_SECOND_RUNE) || (self.waterlevel < 2)))
      self.items = self.items - IT_INVISIBILITY;
};


/*
===========
ClientConnect

called when a player connects to a server
============
*/
void() ClientConnect =
{
   // dprint("clientconnect() ");
   // dprint(self.netname);
   // dprint("\n");
   // local string ps;
   // dprint("parm1  ["); ps = ftos(parm1); dprint(ps); dprint("]\n");   
   // dprint("parm2  ["); ps = ftos(parm2); dprint(ps); dprint("]\n");   
   // dprint("parm3  ["); ps = ftos(parm3); dprint(ps); dprint("]\n");   
   // dprint("parm4  ["); ps = ftos(parm4); dprint(ps); dprint("]\n");   
   // dprint("parm5  ["); ps = ftos(parm5); dprint(ps); dprint("]\n");   
   // dprint("parm6  ["); ps = ftos(parm6); dprint(ps); dprint("]\n");   
   // dprint("parm7  ["); ps = ftos(parm7); dprint(ps); dprint("]\n");   
   // dprint("parm8  ["); ps = ftos(parm8); dprint(ps); dprint("]\n");   
   // dprint("parm9  ["); ps = ftos(parm9); dprint(ps); dprint("]\n");   
   // dprint("parm10 ["); ps = ftos(parm10); dprint(ps); dprint("]\n");   
   // dprint("parm11 ["); ps = ftos(parm11); dprint(ps); dprint("]\n");   
   // dprint("parm12 ["); ps = ftos(parm12); dprint(ps); dprint("]\n");   
   // dprint("parm13 ["); ps = ftos(parm13); dprint(ps); dprint("]\n");   
   // dprint("parm14 ["); ps = ftos(parm14); dprint(ps); dprint("]\n");   
   // dprint("parm15 ["); ps = ftos(parm15); dprint(ps); dprint("]\n");   
   // dprint("parm16 ["); ps = ftos(parm16); dprint(ps); dprint("]\n");   
   // dprint("parm20 ["); ps = ftos(parm20); dprint(ps); dprint("]\n");   
    

   local string ft;
   bprint (self.netname);
   bprint (" has entered the game\n");
   LogMsg(self, "CONNECT");

   // self.team = 0;
   self.accesslvl = 0;
   self.lastteam = 0;

   // the person is a player right?
   self.monster_type = "player";

   self.motd_time = time + 3;
   self.motd_count = 0;
   self.suicide_count = 0;
   self.killed = 0;
   self.status_flag = self.status_flag | STATUS_PLAYER_FLAG;
   self.inferno_flag = 0;
   self.count_count = 0;

   // check for voting
   if (!(self.voting))
           self.voting = 2;

   // *TEAMPLAY*
   // If this is our first connection, parm10 is < 0
   // Set lastteam negative.
   // If we have configured server to force observer at the start of
   // each level, then go here too.
   if (
       ((parm10 < 0) && (teamplay > 0))
      ) 
   {
      self.lastteam = -50;
      if ((teamplay & TEAM_OBSERVER_MODE) && !gamestart) {
         self.inferno_flag = DO_OBSERVER_FLAG;
         if (teamplay & OBSERVER_TIMELIMIT)
            self.observerTime = time + OBSERVER_MAX_TIME;
      }
      else {
         TeamCheckLock();
         if (teamplay & TEAM_LOCK_COLORS) // force a stuff cmd in think
            self.player_flag = self.player_flag | TEAM_STUFF_COLOR;
         if ((teamplay & TEAM_CAPTURE_CUSTOM) && (teamplay & TEAM_CAPTURE_FLAG)) {
            if (self.lastteam == TEAM_COLOR1 + 1)
               self.skin = 1;
            else
               self.skin = 3;
            if (random() < 0.5)
               self.skin = self.skin + 1; // visor dude
            self.player_flag = self.player_flag - (self.player_flag & 65280);
            self.player_flag = self.player_flag | (self.skin * 256);  
         }
      }
   }

   // a client connecting during an intermission can cause problems
   if (intermission_running)
      ExitIntermission ();
};


/*
===========
ClientDisconnect

called when a player disconnects from a server
============
*/
void() ClientDisconnect =
{
   // dprint("ClientDisconnect() ");
   // dprint(self.netname);
   // dprint("\n");

   if (gameover)
      return;
   // if the level end trigger has been activated, just return
   // since they aren't *really* leaving

   if (self.sicHound)
   {
      sicHoundCount = sicHoundCount - 1;
      bprint("The hounds have chased ");
      bprint(self.netname);
      bprint(" off the server!\n");
   }

   // let everyone else know
   bprint (self.netname);
   bprint (" left the game with ");
   bprint (ftos(self.frags));
   bprint (" frags\n");
   sound (self, CHAN_BODY, "player/tornoff2.wav", 1, ATTN_NONE);
   DropRune();
   TeamCaptureDropFlagOfPlayer(self);
   set_suicide_frame ();

   self.lastteam = -50;
   self.team = -50;
   self.inferno_flag = 0;

   LogMsg(self, "DISCONNECT");
};

// *TEAMPLAY*
// Prototypes

float(entity targ, entity attacker) TeamFragPenalty;
void(entity targ, entity attacker) TeamDeathPenalty;

/*
===========
ClientObituary

called when a player dies
============
*/
void(entity targ, entity attacker, entity inflictor) ClientObituary =
{

   // *XXX* EXPERT CTF variable for 
   // flag/flag carrier defense bonus determination
   local   entity head, flag1, flag2, ppp;
   local float flag_radius, flag_carrier_radius, rnum;
   local   string deathstring, deathstring2, what, s, generic;
   rnum = random();
   generic=" "; 
   if (targ.classname == "player")
   {

      // *XXX* EXPERT CTF: 
      // When the flag carrier dies, reset the last_hurt_carrier field in
      // all players on the opposite team from the flag carrier.  The carrier
      // has been killed, so there is no longer a reason to award points for
      // killing off his assailants

      if (targ.inferno_flag & ITEM_YOUR_FLAG) {
         flag1 = find(world, classname, "item_flag_team1");
         flag2 = find(world, classname, "item_flag_team2");
         head = find(world, classname, "player");

      // what happens when someone frags you and you have the flag?
         if (targ != attacker && attacker.classname == "player") {
            attacker.frags = attacker.frags + INFERNO_GET_FLAG;
            sprint(attacker, "You get a bonus for fragging a red person\n");
            sprint(attacker, "that has the red flag!\n");
         }
         ppp = find(world,classname, "player");
         while (ppp != world) {
            if (attacker.team == ppp.team && ppp != attacker)
               ppp.frags = ppp.frags + INFERNO_TEAM_GET_FLAG;

         // tell the other team the good news
            if (attacker.team == ppp.team)
               UpdatePlayerStatus(ppp, "The red holding the red flag got fragged!\nYou get a bonus!\n\n\n\n\n\n\n\n\n\n\n", "", "");
            ppp = find(ppp,classname, "player");
         }
         head = find(world, classname, "player");
         while (head != world) {
            if (head.team != targ.team) {
               head.last_hurt_carrier = -10;
            }
            head = find(head, classname, "player");
         }
      }

      if (targ.player_flag & ITEM_ENEMY_FLAG) {
         head = find(world, classname, "player");
         while (head != world) {   
            if (head.team != targ.team) {
               head.last_hurt_carrier = -10;
            }
            head = find(head, classname, "player");
         }
      }
      // END EXPERT CTF

      if (attacker.classname == "teledeath")
      {
         bprint (targ.netname);
         bprint (" was telefragged by ");
         bprint (attacker.owner.netname);
         bprint ("\n");

         attacker.owner.frags = attacker.owner.frags + 1;
         LogPlayerDMDeath(targ, attacker.owner, "telefrag");
         return;
      }

      if (attacker.classname == "teledeath2")
      {
         bprint ("Satan's power deflects ");
         bprint (targ.netname);
         bprint ("'s telefrag\n");

         targ.frags = targ.frags - 1;
         targ.died = targ.died + 1;  // update number of deaths
         LogPlayerDeath(targ, "telefrag");
         return;
      }

      if (attacker.classname == "player")
      {
         if (targ == attacker)
         {
            // killed self
            attacker.frags = attacker.frags - 1;
            attacker.died = attacker.died + 1;  // update number of deaths
            bprint (targ.netname);
            // Warf:  use inflictor classname to print generic kill yourself
            if (inflictor.classname == "op gib") {
               bprint(" was automatically gibbed by ");
               bprint(inflictor.owner.netname);
               bprint("\n");
               what = "op gib";
            }
            else if (inflictor.classname == "teamdeath") {
               //ZOID: try if player was gibbed for changing teams
               if (teamplay & TEAM_STATIC_TEAMS)
                  bprint (" tried to change teams\n");
               else
                  bprint (" changed teams\n");
               LogPlayerDeath(targ, "teamchange");
               return;
            }
            else if (inflictor.classname != "player")  {
                bprint (" needs to be more careful with their ");
                bprint (inflictor.classname); 
                bprint ("\n");
                LogPlayerDeath(targ, inflictor.classname);
            }
            else {
                bprint (" died from self inflicted wounds\n");
                LogPlayerDeath(targ, inflictor.classname);
            }

            return;
         }
         else if ( (teamplay == 2) && (targ.team > 0)&&(targ.team == attacker.team) )
         {
            if (rnum < 0.25)
               deathstring = " mows down a teammate\n";
            else if (rnum < 0.50)
               deathstring = " checks his glasses\n";
            else if (rnum < 0.75)
               deathstring = " gets a frag for the other team\n";
            else
               deathstring = " loses another friend\n";
            bprint (attacker.netname);
            bprint (deathstring);

            attacker.frags = attacker.frags - 1;
            attacker.died = attacker.died + 1;  // update number of deaths

            return;
         }
         else
         {
            // *TEAMPLAY*
            // TeamFragPenalty returns true if the attacker gets a frag penalty for
            // killing this target.  It also deducts frags as needed.
            if (!TeamFragPenalty(targ, attacker)) {

               // The attacker is going to get a point, so update each
               // players performance
               attacker.fragTotal = attacker.fragTotal + 1;
               attacker.consecutiveFragged = 0;
               targ.fraggedTotal = targ.fraggedTotal + 1;
               targ.consecutiveFragged = 
                  targ.consecutiveFragged + 1;

               // the attacker is award the normal one frag.. now we 
               // determine if he gets any bonuses
               attacker.frags = attacker.frags + 1;
   
               if ((targ.player_flag & ITEM_ENEMY_FLAG) &&
                  (targ.team != attacker.team)) {
                  //ZOID: one team fragged the other team's flag carrier
 
                  // *XXX* EXPERT CTF
                  // Mark the attacker with the time at which he killed the flag
                  // carrier, for awarding assist points
 
                  attacker.last_fragged_carrier = time;
 
                  // *XXX* EXPERT CTF: give player only the normal amount of frags
                  // if the carrier has only had the flag for a few seconds, to
                  // prevent ppl intentionally allowing enemies to grab the flag,
                  // then immediately fragging them
                  if (targ.flag_since + TEAM_CAPTURE_CARRIER_FLAG_SINCE_TIMEOUT > time) {
                     sprint(attacker, "Enemy flag carrier killed, no bonus\n");
                  } else {

                     attacker.frags = attacker.frags + TEAM_CAPTURE_FRAG_CARRIER_BONUS;
                     // TeamScore (attacker, TEAM_CAPTURE_FRAG_CARRIER_BONUS);
                     sprint(attacker, "Enemy flag carrier killed: ");
                     s = ftos(TEAM_CAPTURE_FRAG_CARRIER_BONUS);
                     sprint(attacker, s);
                     sprint(attacker, " bonus frags\n");
                  }
                  // END FLAG CARRIER FRAG CODE
               }
                
               // *XXX* EXPERT CTF
               // This code checks for all game-critical kills OTHER THAN fragging the enemy
               // flag carrier, like killing players who are trying to kill your flag carrier
               // or trying to grab your flag, and hands out bonus frags.
 
               // The two variables below track whether special bonus frags have already
               // been awarded for the attacker or target being near the flag or flag carrier.  
 
               flag_radius = 0;
               flag_carrier_radius = 0;
 
               // get a string for the attacker's team now, for later announcements
               s = GetCTFTeam(attacker.team);
 
               if ((targ.last_hurt_carrier + TEAM_CAPTURE_CARRIER_DANGER_PROTECT_TIMEOUT > time) &&
                  !(attacker.player_flag & ITEM_ENEMY_FLAG) ) {
                  // a player on the same team as the flag carrier killed 
                  // someone who recently shot the flag carrier
                  attacker.frags = attacker.frags + 
                     TEAM_CAPTURE_CARRIER_DANGER_PROTECT_BONUS;
                  flag_carrier_radius = 1;
                  // NOTE: getting CARRIER_DANGER_PROTECT_BONUS precludes getting
                  // other kinds of bonuses for defending the flag carrier, since
                  // it's worth more points
                  bprint(attacker.netname);
                  bprint(" defends ");
                  bprint(s);
                  bprint("'s flag carrier against an agressive enemy\n");
               }
 
               // *XXX* EXPERT CTF
               // Bonusus for defending the flag carrier or the flag itself.
               // Extra frags are awarded if either the attacker or the target are
               // 1. within 40 feet of a flag carrier on the same team as the attacker
               // 2. within 40 feet of the attacker's flag
               // These bonuses are cumulative with respect to defending both the
               // flag and the flag carrier at the same time, but not cumulative with
               // respect to both the target and attacker being near the object being defended
 
               // find flags or flag carriers within a radius of the attacker
               head = findradius(attacker.origin, TEAM_CAPTURE_ATTACKER_PROTECT_RADIUS);
 
               while (head) {
                  if (head.classname == "player") {
                     if ( (head.team == attacker.team) &&
                        ((head.player_flag & ITEM_ENEMY_FLAG) || (head.inferno_flag & ITEM_YOUR_FLAG)) &&
                        (head != attacker) && // self defense
                        (!flag_carrier_radius) ) { 
                        // attacker was near his own flag carrier
                        attacker.frags = attacker.frags + 
                           TEAM_CAPTURE_CARRIER_PROTECT_BONUS;

                        flag_carrier_radius = 1;
                        bprint(attacker.netname);
                        bprint(" defends ");
                        bprint(s);
                        bprint("'s flag carrier\n");
                     }
                  }
                  if ( (head.classname == "item_flag_team1") ||
                     (head.classname == "item_flag_team2")) {
                     if (((attacker.team == (TEAM_COLOR1 + 1)) &&
                        (head.classname == "item_flag_team1")) ||
                        ((attacker.team == (TEAM_COLOR2 + 1)) &&
                        (head.classname == "item_flag_team2"))) { 
                        // attacker was near his own flag
                        attacker.frags = attacker.frags + 
                           TEAM_CAPTURE_FLAG_DEFENSE_BONUS;

                        flag_radius = 1; 
                        bprint(attacker.netname);
                        bprint(" defends the ");
                        bprint(s);
                        bprint(" flag\n");
                     }
                  }
                  head = head.chain;
               }
 
               // find flags or flag carriers within a radius from the target
               head = findradius(targ.origin, TEAM_CAPTURE_TARGET_PROTECT_RADIUS);
               while (head) {
                  if (head.classname == "player") {
                     if ( (head.team == attacker.team) &&
                        ((head.player_flag & ITEM_ENEMY_FLAG) || (head.inferno_flag & ITEM_YOUR_FLAG)) &&
                        (head != attacker) &&
                        (!flag_carrier_radius)) { // prevents redundant points awarded
      
                        // target was near attacker's flag carrier
                        attacker.frags = attacker.frags + 
                           TEAM_CAPTURE_CARRIER_PROTECT_BONUS;
                        flag_carrier_radius = 1;
                        bprint(attacker.netname);
                        bprint(" defends ");
                        bprint(s);
                        bprint("'s flag carrier\n");
                     }
                  }
                  if (((attacker.team == (TEAM_COLOR1 + 1)) &&
                     (head.classname == "item_flag_team1")) ||
                     ((attacker.team == (TEAM_COLOR2 + 1)) &&
                     (head.classname == "item_flag_team2"))
                     && (!flag_radius)) { // prevents redundant points awarded
                     // target was near attacker's flag
                     attacker.frags = attacker.frags + 
                     TEAM_CAPTURE_FLAG_DEFENSE_BONUS;
                     flag_radius = 1;
                     bprint(attacker.netname);
                     bprint(" defends the ");
                     bprint(s);
                     bprint(" flag\n");
                  }
                  head = head.chain;
               }
            }   
           
            // *XXX* EXPERT CTF 
            // End frag determination code.  Now determine death text for
            // a member of one team killing a member of the other
           
            // *TEAMPLAY*
            // TeamDeathPenalty kills the attacker if necessary and adjusts frags to
            // offset the one frag penalty for dying.
            TeamDeathPenalty(targ, attacker);

            rnum = attacker.weapon;

            if (attacker.rune == RUNE_M4D_SK1LLZ) {
               deathstring = " is 0wned by ";
               deathstring2 = "'s m4d sk1llz";
               what = "super super shotgun";
               attacker.m4dFrags = attacker.m4dFrags + 1;
            }
            else if (attacker.nweapon == NEW_LIGHTNING) {
               if (attacker.items & IT_QUAD) {
                  deathstring = " was touched by ";
                  deathstring2 = "'s Quad lightning";
               } else {
                  deathstring = " accepts ";
                  if (attacker.waterlevel > 1)
                     deathstring2 = "'s discharge";
                  else
                     deathstring2 = "'s shaft";
               }
               what = "lightning";
               if (attacker.rune == RUNE_POSEIDON && !(attacker.status_flag & ITEM_SECOND_RUNE)) {
                  deathstring = " was stabbed to death by ";
                  deathstring2 = "'s trident";
                  what = "trident";
               }
               if (attacker.rune == RUNE_RAIDEN && !(attacker.status_flag & ITEM_SECOND_RUNE)) {
                  deathstring = " was electrocuted by ";
                  deathstring2 = " ";
                  what = "raiden-lightning";
               }
               if (attacker.rune == RUNE_THUNDER && !(attacker.status_flag & ITEM_SECOND_RUNE)) {
                  deathstring = " was zapped by ";
                  deathstring2 = "'s lightning bolt";
                  what = "thunder-lightning";
               }
               if (attacker.rune == RUNE_FP && !(attacker.status_flag & ITEM_SECOND_RUNE) && self.nweapon == NEW_AXE) {
                  deathstring = " was lighten by ";
                  deathstring2 = " ";
                  what = "frankie's pet's lightning";
               }
            }
            else if (rnum == IT_AXE && inflictor.classname == "player")
            {
               if (attacker.nweapon == NEW_AXE) {
                  if (attacker.rune == RUNE_EARTH_MAGIC) {
                     deathstring = " tries to go through ";
                     deathstring2 = "'s firewall";
                     what = "fire wall";
                  } else if (attacker.rune == RUNE_KINTARO && !(attacker.status_flag & ITEM_SECOND_RUNE)) {
                     deathstring = " became outarmed by ";
                     deathstring2 = " ";
                     what = "four-axe power";
                  } else if (attacker.rune == RUNE_TARANTULA && (attacker.status_flag & ITEM_SECOND_RUNE)) {
                     deathstring = " couldn't wait to get ";
                     deathstring2 = " suprise";
                     what = "trick-trap";
                  } else {
                     deathstring = " was ax-murdered by ";
                     deathstring2 = " ";
                     what = "axe";
                  }
               }
            }
            else if (rnum == IT_SHOTGUN && targ.reason_died == "bullets")
            {
               if (attacker.rune == RUNE_PUNISHER && (attacker.status_flag & ITEM_SECOND_RUNE)) {
                  deathstring = " was punished by ";
                  deathstring2 = " ";
                  what = "super super shotgun";
               } else {
                  deathstring = " chewed on ";
                  deathstring2 = "'s boomstick";
                  what = "shotgun";
               }
            }
            else if (rnum == IT_SUPER_SHOTGUN && targ.reason_died == "bullets")
            {
               deathstring = " ate 2 loads of ";
               deathstring2 = "'s buckshot";
               if (targ.health < -40) {
                  deathstring = " ate a box of ";
                  what = "supershotgun";
               }
            }
            // Warf: Generic obit mod (not pretty)
            // Warf: Generic obit mod (not pretty)
            else if (targ.reason_died != "") {
               bprint (attacker.netname);
               bprint (deathstring);
               if (attacker.items & IT_QUAD) {
                  deathstring = " felt the quad power of ";
               } 
               else if (rnum < 2)  // SG and NG
                  deathstring = " check's ";
               else if (rnum < 8)  // SNG and GL
                  deathstring = " is raw meat served by ";
               else if (rnum < 64) // RL and TB
                  deathstring = " was given a funeral by ";
               else
                  deathstring = " is defeated by "; // axe
                deathstring2 = targ.reason_died;
                generic = "y";
                what = targ.reason_died;
            }
            else if (inflictor.classname != " ") {
               if (attacker.items & IT_QUAD) {
                  deathstring = " felt the quad damage of ";
               } 
               else if (rnum < 2)  // SG and NG
                  deathstring = " was ripped to pieces from ";
               else if (rnum < 8)  // SNG and GL
                  deathstring = " learns the danger of ";
               else if (rnum < 64) // RL and TB
                  deathstring = " becomes puppy chow by ";
               else
                  deathstring = " was defeated by "; // axe
               deathstring2 = inflictor.classname;
               generic = "y";
               what = inflictor.classname;
            }    
            // what the hell??  no message??  well, assign something
            if (deathstring == "") {
               deathstring = " was beaten by ";
               deathstring2 = " ";
               what = "???";
               DiagObit (targ, attacker, "beaten");
            }
            bprint (targ.netname);
            bprint (deathstring);
            bprint (attacker.netname);
            if (generic == "y") bprint ("'s ");
            bprint (deathstring2);
            // s = ftos (rnum);  // debug rnum flags
            // bprint(" [");     // debug rnum flags
            // bprint(s);        // debug rnum flags  
            // bprint("]");      // debug rnum flags
            bprint ("\n");
            LogPlayerDMDeath(targ, attacker, what);
            targ.reason_died = ""; 
         }
         return;
      }
      else
      {
         targ.frags = targ.frags - 1;
         targ.died = targ.died + 1;  // update number of deaths
         bprint (targ.netname);

         // tricks and traps
         if (inflictor.classname == "Hound")
         {
            bprint(" was mauled by Wild Dogs!\n");
            LogPlayerDeath(targ, "Hound");
            return;
         }
         if (attacker.classname == "explo_box")
         {
            bprint (" blew up\n");
            LogPlayerDeath(targ, "explosion");
            return;
         }
         else if (attacker.solid == SOLID_BSP && attacker != world)
         {   
            bprint (" was squished\n");
            LogPlayerDeath(targ, "squished");
            return;
         }
         else if (attacker.classname == "trap_shooter" || attacker.classname == "trap_spikeshooter")
         {
            bprint (" was spiked\n");
            LogPlayerDeath(targ, "spiked");
            return;
         }
         else if (attacker.classname == "fireball")
         {
            bprint (" ate a lavaball\n");
            LogPlayerDeath(targ, "fireball");
            return;
         }
         else if (attacker.classname == "trigger_changelevel")
         {
            bprint (" tried to leave\n");
            LogPlayerDeath(targ, "noexit");
            return;
         }
         else if ((attacker.classname == "homing missile") ||
            (attacker.classname == "life missile"))
         {
                 bprint (" was bombarded by a rocket\n");
                 LogPlayerDeath(targ, "rocket");
                 return;
         }
         else if (inflictor.classname == "ODFire") {
                 bprint (" was consumed by Napalm\n");
                 LogPlayerDeath(targ, "Napalm");
                 return;
         }

         // in-water deaths
         rnum = targ.watertype;
         if (rnum == -3)
         {
            if (random() < 0.5)
               bprint (" sleeps with the fishes\n");
            else
               bprint (" sucks it down\n");
            LogPlayerDeath(targ, "drowned");
            return;
         }
         else if (rnum == -4)
         {
            if (random() < 0.5)
               bprint (" gulped a load of slime\n");
            else
               bprint (" can't exist on slime alone\n");
            LogPlayerDeath(targ, "slimed");
                                return;
         }
         else if (rnum == -5)
         {
            if (targ.health < -15)
            {
               bprint (" burst into flames\n");
               LogPlayerDeath(targ, "melted");
                                        return;
                                }
                                if (random() < 0.5)
                                        bprint (" turned into hot slag\n");
                                else
                                        bprint (" visits the Volcano God\n");
                                LogPlayerDeath(targ, "melted");
                                return;
         }

         // fell to their death?
         if (targ.deathtype == "falling")
         {
            targ.deathtype = "";
            bprint (" fell to his/her death\n");
            LogPlayerDeath(targ, "falling");
            DiagObit (targ, attacker, "fallen");
            return;
         }

         // hell if I know; he's just dead!!!
         LogPlayerDeath(targ, "died");
         bprint (" died\n");
         return;
      }

      self.rune = 0;  // they dont need a rune anymore
      RuneApplyPowers();  
   }
};

void (entity e) takeOffInitialInvincibility =
{
   if (e.respawnInvincibleFlag) {
      e.respawnInvincibleFlag = 0;
   	e.invincible_time = 0;
	   e.invincible_finished = 0;
   }
};
