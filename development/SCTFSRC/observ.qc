/* observ.qc -- by someone but taken from the threewave ctf mods
this makes the person an observer who cannot interfere with the
fighting going on, modified by inferno
*/

float intermission_running;
void() togglePlayerId;
void() respawn;
entity() SelectSpawnPoint;
void() CheckAdminCmd;
void () ShowWhoOn;
void () OperChk;
void () VoteForExit;
float() CheckDevCmd;
//void () Toggle_chase_cam;  // yes, you can be one when you're an observer
float modelindex_player, modelindex_player_head;

void () ObserverThink =
{
   local entity e;
   local float cont;
   local string ppp;

	self.weaponmodel = "";
	self.weaponframe = 0;
   self.flags = self.flags | FL_ONGROUND;

   // has the player exceeded their time? for nonadmins only
   // an admin can grant unlimited observer access via impulse 167 
   if (self.accesslvl != 9) {
      if (self.observerTime) {
         if (time > self.observerTime) {
            sprint(self, "\nYou can only observe for [");
            local string s1;
            s1 = ftos(OBSERVER_MAX_TIME);
            sprint(self,s1);
            sprint(self,"] seconds.  Bye-bye!\n");
            stuffcmd(self, "disconnect\n");
            bprint(self.netname);
            bprint(" was kicked for observing too long\n");
            self.observerTime = 0;
         }
      }
   }
   

   // fly
   PlayerFlight();

   if ((self.inferno_flag & CHASE_OBSERVER_FLAG) && (self.chase_observer != world)) {
           // if (self.chase_observer.model == "")
           setmodel(self, string_null);
	   setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
           setorigin(self, self.chase_observer.origin);
           self.origin = self.chase_observer.origin;

           self.ammo_rockets = self.chase_observer.ammo_rockets;
           self.ammo_shells = self.chase_observer.ammo_shells;
           self.ammo_cells = self.chase_observer.ammo_cells;
           self.ammo_nails = self.chase_observer.ammo_nails;
           self.items = self.chase_observer.items;
           self.weapon = self.chase_observer.weapon;
           self.health = self.chase_observer.health;
           self.armortype = self.chase_observer.armortype;
           self.armorvalue = self.chase_observer.armorvalue;
           // if (self.view_ofs == '0 0 10')//22';//10';
                   self.view_ofs = '-99 -99 30';
   } else setmodel(self, "progs/player.mdl");

   // make sure frags always stay 0
   if (self.frags)
           self.frags = 0;

   // development test impulses
   CheckDevCmd();

   if (self.impulse == 73)
   {
       if (self.motdDisplay) {
          sprint(self,"MOTD display is now OFF\n");
          self.motdDisplay = 0;
          self.motd_time = 0;
          self.motd_count = 10;
       }
       else  {
          sprint(self,"MOTD display is now ON\n");
          self.motdDisplay = 1;
          self.motd_time = time + 3;
          self.motd_count = 0;
       }
       self.impulse = 0;
   }
   else if ((self.impulse || self.button2) && (intermission_running))
           return;
   else if (self.impulse && self.accessparm) { // admin functions
		CheckAdminCmd();
		self.impulse = 0;
   } else if (self.impulse && self.opercheck) {
        CheckAdminCmd();
        self.impulse = 0;
   } else if (self.impulse == 1 || self.impulse == 2 || self.button2) {
	   if ((locked_flag == 1) & (self.granted_flag == 0)) { // can't join, the server is locked
            sprint(self,"The server is LOCKED. You can not join.\n");
            self.impulse = 0;
            return;
   	} else {
         // destroy model
         dprint("DDT: ( ot) ");
         dprint(self.netname);
         dprint(" chooses a team \n");
         if (self.impulse == 1)
	         self.team = self.lastteam = TEAM_COLOR1 + 1;
   	   else if (self.impulse == 2)
	   	   self.team = self.lastteam = TEAM_COLOR2 + 1;
         else {
   	      self.lastteam = -50;
  	         TeamCheckTeam();
         }
         local string s1;
         dprint("DDT: ( ot) ");
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
         setmodel(self, string_null);

         self.inferno_flag = self.inferno_flag - 
           (self.inferno_flag & OBSERVER_FLAG);

         // SetChangeParms ();
      	self.killed = 0;

         self.chase_observer = world;

         // if the person just died and respawned in observer
         if ((self.inferno_flag & DIE_OBSERVER_FLAG) && !(self.button0)) {
            ppp = ftos(self.lastteam);
            stuffcmd(self, "color ");
            stuffcmd(self, ppp);
            stuffcmd(self, "\n");
            self.weapon = W_BestWeapon();
            respawn();
            W_SetCurrentAmmo();
            return;
         }
         if (!(teamplay & TEAM_CAPTURE_FLAG)) {
            ppp = ftos(self.lastteam);
            stuffcmd(self, "color ");
            stuffcmd(self, ppp);
            stuffcmd(self, "\n");
            self.weapon = W_BestWeapon();
            respawn();
            W_SetCurrentAmmo();
            return;
         }
 		   if (self.lastteam == TEAM_COLOR1 + 1)  {
            bprint(self.netname);
            bprint(" joined ред team!\n"); // red
  	   	} else if (self.lastteam == TEAM_COLOR2 + 1) {
	         bprint(self.netname);
		      bprint(" joined блуе team!\n"); // blue
		   }
 
      	self.impulse = 0;
      	self.player_flag = self.player_flag | TEAM_STUFF_COLOR;
         self.chase_observer = world;
	   
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
   	  	self.weapon = W_BestWeapon();
	      respawn();
   	   W_SetCurrentAmmo();
      	return;
		}
   } else if (self.button0) {
           self.inferno_flag = self.inferno_flag | OBSERVER_CHANGE_FLAG;
   // lets only check impulses if one exists
   } else if (self.impulse) {
      if (self.impulse == 3) {
                if (self.inferno_flag & CLEAR_OBSERVER_FLAG)
                        self.inferno_flag = self.inferno_flag - CLEAR_OBSERVER_FLAG;
                else
                        self.inferno_flag = self.inferno_flag | CLEAR_OBSERVER_FLAG;  // clear the observer
                self.impulse = 0;
      } else if (self.impulse == 171) {
         ShowWhoOn();
   		self.impulse = 0;
      } else if ((self.impulse >= 151 && 
          self.impulse <= 170) ||
          self.impulse == 178) {
                if (self.status_flag & ADMIN_PLAYER_FLAG)
                        CheckAdminCmd();
                self.impulse = 0;
      } else if (self.impulse == 110) {
           OperChk();
           self.impulse = 0;
      } else if (self.impulse == 112) {
            togglePlayerId();
            self.impulse = 0;
      } else if (self.impulse == 174) {
           VoteForExit();
           self.impulse = 0;
      } else if (self.impulse == 4) {
         if (self.inferno_flag & CHASE_OBSERVER_FLAG) {
              if (self.view_ofs == '0 0 22')
                      self.view_ofs = '0 0 10';
              self.chase_observer = world;
              self.inferno_flag = self.inferno_flag - CHASE_OBSERVER_FLAG;
              self.impulse = 0;
              self.armortype = 0.3;
              self.armorvalue = 50;
              self.ammo_shells = 40;
              self.ammo_nails = self.ammo_rockets = self.ammo_cells = 0;
              self.health = 999;
              self.items = IT_AXE | IT_SHOTGUN | IT_ARMOR1;
              self.weapon = 0;
              self.weaponframe = 0;
              self.weaponmodel = "";
              return;
         } else {
              self.chase_observer=find(self.chase_observer,classname,"player");
              if(self.chase_observer==world||self.chase_observer==self)self.chase_observer=find(self.chase_observer,classname,"player");
              if(self.chase_observer==world||self.chase_observer==self)self.chase_observer=find(self.chase_observer,classname,"player");
              if(self.chase_observer==world||self.chase_observer==self){self.chase_observer=world;sprint(self,"No one the chase!\n");self.impulse=0;return;}
              else{
                      sprint(self, "Now chasing ");sprint(self,self.chase_observer.netname);sprint(self,"\n");
                      self.inferno_flag = self.inferno_flag | CHASE_OBSERVER_FLAG;
                      self.impulse = 0;
              }
         }
      }
   }  // endif some impulse was pressed
   if (!(self.button0) && (self.inferno_flag & OBSERVER_CHANGE_FLAG)) {
      if(self.inferno_flag&CHASE_OBSERVER_FLAG){
         self.chase_observer=find(self.chase_observer,classname,"player");
         if(self.chase_observer==world||self.chase_observer==self)self.chase_observer=find(self.chase_observer,classname,"player");
         if(self.chase_observer==world||self.chase_observer==self)self.chase_observer=find(self.chase_observer,classname,"player");
         if(self.inferno_flag&OBSERVER_CHANGE_FLAG)
                 self.inferno_flag=self.inferno_flag - OBSERVER_CHANGE_FLAG;
         if(self.chase_observer==world||self.chase_observer==self){sprint(self,"No one else to chase!\n");return;}
         else {
                 sprint(self, "Now chasing ");sprint(self,self.chase_observer.netname);sprint(self,"\n");
                 setorigin(self,self.chase_observer.origin);
                 self.origin=self.chase_observer.origin;
         }
         if (!(self.inferno_flag&CHASE_OBSERVER_FLAG))
                 self.inferno_flag=self.inferno_flag | CHASE_OBSERVER_FLAG;
      } else {
         if(self.inferno_flag&OBSERVER_CHANGE_FLAG)
                 self.inferno_flag = self.inferno_flag - OBSERVER_CHANGE_FLAG;
         e = SelectRuneSpawnPoint();
         setorigin(self, e.origin);
      }
   }

   // keep the head looking good
   if (self.modelindex == modelindex_player_head)
           self.angles = self.angles + '90 0 0';
};

void(entity player) BecomeObserver =
{
   // here is a check, just in case the player entered and picked up something
   self = player;
   DropRune();
   player = self;

   // done with the check
	player.health           = 999;
	player.takedamage       = DAMAGE_NO;
	player.solid            = SOLID_NOT;
   // player.movetype         = MOVETYPE_FLY;
   player.movetype         = MOVETYPE_NOCLIP;
	player.deadflag         = DEAD_NO;

   if (!(teamplay & TEAM_CAPTURE_FLAG))
      setmodel (player, "progs/h_player.mdl");

   player.weaponmodel      = "";
	player.weaponframe      = 0;
	player.weapon           = 0;

   if (!teamplay & TEAM_CAPTURE_FLAG)
      setsize(player, '-12 -12 -12', '12 12 12');

   player.view_ofs = '0 0 10';//22';//10';

   player.inferno_flag = player.inferno_flag | OBSERVER_FLAG;
   player.inferno_flag = player.inferno_flag - 
      (player.inferno_flag & DO_OBSERVER_FLAG);
};

