/************************************************************\
* These are the SCTF Easter Eggs.  All easter eggs should
* be level and rune independent.  Its ok to have them triggered
* by a particular weapon, or morph of that weapon.
* The trigger should be designed such that hitting it
* accidentally is nearly impossible, but it should be easy
* to explain how in a few words.
*
* Current triggers:
* CotC : fire a proxy mine, switch to axe, and touch mine in 3 seconds.
* HOC : fire a flare, shoot the flare wtih acid gun.
* NP : fire a pipe bomb, switch to axe, and touch pipe bomb.
* ANARCHY : fire a lava bomb, then fire a rocket at it.
*
* HOW TO CREATE AN EGG
* Eggs only last 15 seconds, and consist of 4 components:
*   Egg-specific entities (you must write this code)
*   A marquee description (you must write the text of
*     your message, it will be attached to the player)
*   Lavasplash around the player (provided by eemanager)
*   A nice restful surf noise (provided by eemanager)
*
* To add a new Egg:
*
* settings.qc   add a new constant to identify your egg.
*    this value will be cached in the eeManager.eeFlag field.
*
* In your trigger code, you can start up your egg simply
* by calling startEEManager (entity, flag).  Where entity
* is the player who has triggered the egg, and flag is 
* your new egg identifier.
* Always check to see if an egg is already active for this
* player, and dont allow multiple eggs per player.  Check for 
* nonzero self.eeFlag.  We don't want server crashes because of too 
* many entities.
* Always check for a rune.  Standard behavior is never to 
* start an egg if the player holds a rune.
*
* sctfegg.qc.  Edit startEEManager(), and add your initialization
* and startup code.  If you only create one set of entities
* for the duration of the effect, this is the place to do it.
* The egg manager uses the eeManager() function to think every
* 5 seconds.  Here you will get a free lava splash effect
* around the player, and also a nice restful surf noise.
* These are the trademark effects of any egg, so dont change them.
* If you need to manage the effect outside of the manager, make
* sure that your entities check for the same termination
* conditions as the egg manager, and check every 5 seconds
* or less. Edit eeMarquee(), and add the marquee display
* for your new egg.  Be careful to retain the dual-message
* format, which causes the marquee motion, and to format
* your messages appropriately (centered, same text in both
* messages).  Do not change the marquee outline, size, etc,
* these are standard egg attributes.
*
\************************************************************/

void ( entity e )  startEggNP = {};
void ( entity e, float eggType )  startEggClone;
void(entity e) startEggNP;


/*
   generic egg functions
*/
void(entity e, float eeflag) startEEManager =
{
   // sprint(other,"ee triggered\n");
   // create an eeManager
   local entity eeman;
   eeman = spawn();
   eeman.owner = e;
   eeman.nextthink = time + 0.1;
   eeman.think = eeManager;
   e.eeFlag = eeflag;
   e.eeTime = time + 15;

   if (eeflag == HOC_EGG)
      startEggClone (e, eeflag);
   else if (eeflag == ANARCHY_EGG)
      startEggClone (e, eeflag);
   else if (eeflag == NP_EGG)
      startEggNP (e);
};


// this is the think for a nonvisible entity which
// creates and maintains the easter egg while it exists.
// when this entity is removed, the effect is ended.
void() eeManager =
{
   if (intermission_running)
   {
      remove(self);
      return;
   }
   if (time > self.owner.eeTime)
   {
      self.owner.eeFlag = 0;
      self.owner.eeTime = 0;
      self.owner.eeMsg = 0;
      remove(self);
      return;
   }

   // create 12 unit vectors, every 30 degrees around the circle
   local vector v1, v2, v3, v4;
   local vector v5, v6, v7, v8;
   local vector v9, v10, v11, v12;

   // init the v_forward and v_right player directional vectors
   makevectors(self.owner.angles);

   local string s1;  s1 = vtos(v_forward);
   // sprint(self.owner,s1); sprint(self.owner,"\n");

   // create fancy effects
   if (self.owner.eeFlag == 1) {
      // our vectors will be on the XY plane
      local vector myForward, myRight;
      myForward = v_forward;   myForward_z = 0;
      myRight = v_right;   myRight_z = 0;

      // get all the directions, starting at 0 (right), and moving
      // counterclockwise
      v1 = myRight;
      v2 = myForward + 2 * myRight;
      v3 = 2 * myForward + myRight;
      v4 = myForward;
      v5 = 2 * myForward - myRight;
      v6 = myForward - 2 * myRight;
      v7 = -1 * myRight;
      v8 = -1 * myForward - 2 * myRight;
      v9 = -2 * myForward - myRight;
      v10 = -1 * myForward;
      v11 = -2 * myForward + myRight;
      v12 = -1 * myForward + 2 * myRight;

      MakeBall (v1);            MakeBall (v2);            MakeBall (v3);         
      MakeBall (v4);            MakeBall (v5);            MakeBall (v6);         
      MakeBall (v7);            MakeBall (v8);            MakeBall (v9);
      MakeBall (v10);           MakeBall (v11);           MakeBall (v12);
   }
   // else if (self.owner.eeFlag == 2) 
   // For the sound, try boss1\out1.wav
   sound (self.owner, CHAN_BODY, "boss1/out1.wav", 1, ATTN_NORM);

   // lava splash
   WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
   WriteByte (MSG_BROADCAST, TE_LAVASPLASH);
   WriteCoord (MSG_BROADCAST, self.owner.origin_x);
   WriteCoord (MSG_BROADCAST, self.owner.origin_y);
   WriteCoord (MSG_BROADCAST, self.owner.origin_z);

   self.nextthink = time + 5;

};


void(entity who) eeMarquee =
{
   local string s1, s2, s3, s4, s5, s6, s7;
   local string eeMsg1, eeMsg2;
   if (who.eeFlag == COTC_EGG)
   {
      eeMsg1 = "ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*\n*  YOU HAVE FOUND A COTC EASTER EGG!   ª\nª€‚*\n*                                      ª\nª       For Ïòçáî Äïîïò COTC‘         *\n*        Vaya Con Dios, Bro!           ª\nª                                      *\n*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª";
      eeMsg2 = "*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª\nª  YOU HAVE FOUND A COTC EASTER EGG!   *\n*€‚ª\nª                                      *\n*       For Ïòçáî Äïîïò COTC‘         ª\nª        Vaya Con Dios, Bro!           *\n*                                      ª\nª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*";
   }
   else if (who.eeFlag == HOC_EGG)
   {
      eeMsg1 = "ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*\n*    YOU HAVE FOUND AN EASTER EGG!     ª\nª€‚*\n*                                      ª\nª          The Clans Of SCTF           *\n*     HOC:  The Hand Of Cthulhu        ª\nª                                      *\n*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª";
      eeMsg2 = "*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª\nª    YOU HAVE FOUND AN EASTER EGG!     *\n*€‚ª\nª                                      *\n*          The Clans Of SCTF           ª\nª     HOC:  The Hand Of Cthulhu        *\n*                                      ª\nª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*";
   }
   else if (who.eeFlag == NP_EGG)
   {
      eeMsg1 = "ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*\n*    YOU HAVE FOUND AN EASTER EGG!     ª\nª€‚*\n*                                      ª\nª          The Clans Of SCTF           *\n*          NP:   NuckaPatrol           ª\nª                                      *\n*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª";
      eeMsg2 = "*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª\nª    YOU HAVE FOUND AN EASTER EGG!     *\n*€‚ª\nª                                      *\n*          The Clans Of SCTF           ª\nª          NP:   NuckaPatrol           *\n*                                      ª\nª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*";
   }
   else if (who.eeFlag == ANARCHY_EGG)
   {
      eeMsg1 = "ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*\n*    YOU HAVE FOUND AN EASTER EGG!     ª\nª€‚*\n*                                      ª\nª          The Clans Of SCTF           *\n*            Clan Anarchy              ª\nª                                      *\n*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª";
      eeMsg2 = "*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª\nª    YOU HAVE FOUND AN EASTER EGG!     *\n*€‚ª\nª                                      *\n*          The Clans Of SCTF           ª\nª            Clan Anarchy              *\n*                                      ª\nª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*ª*";
   }
   
   if (!who.eeMsg) {
      who.eeMsg = 1;
      s4 = eeMsg1;
   }
   else if (who.eeMsg == 1) {
      who.eeMsg = 2;
      s4 = eeMsg2;
   }
   else if (who.eeMsg == 2) {
      who.eeMsg = 1;
      s4 = eeMsg1;
   }

   s5 = s7 = "";

   ncenterprint(who, s4, s5, s7, s1, s6, s3, s2);
};



/*
   hoc egg and anarchy egg functions
*/

void () eeSham;
void () eeKnight;
void (
   vector selfangles, 
   entity myself, 
   string cloneName, 
   float cloneIndex, 
   void() cloneThink
) eeCreateClone =
{

   // make sure there is room to place him
   makevectors(selfangles);
   local vector v;
   v = v_forward * 80 + myself.origin;
   traceline(myself.origin,v,TRUE,myself);
   if (trace_fraction < 1.0) {
      return;
   }

   // spawn a pet clone who will live for 15 seconds
   local entity e;
   e = spawn();
   e.modelindex = cloneIndex;
   setmodel (e, cloneName);
   e.classname = "clone";
   e.count_count = time + 10;
   setsize (e, VEC_HULL_MIN, VEC_HULL_MAX);

   // give him something to think about
   e.think = cloneThink;  
   e.nextthink = time + 0.1;

   // make him face you
   e.angles = selfangles;
   e.angles_y = e.angles_y + 180;
   
   // toss him out like a rune
   e.movetype = MOVETYPE_TOSS;
   e.origin = myself.origin - '0 0 24';
   e.velocity = v_forward * 500;
   e.velocity_z = 400;
	
   // give him a physical presence
   e.flags = FL_ITEM;
   e.solid = SOLID_BBOX;

};

void ( entity e, float eggType )  startEggClone =
{
   // point forwards
   local vector v;
   v = aim(e, 1000);
   local vector selfangles;
   selfangles = vectoangles(v);
   local float i;
   i = 0;
   local float cloneMax;      // how many to create
   local float cloneAngle;    // rotation about self for 
                              // direction to toss each clone

   // default clone params
   // Requirement! max * angle <= 360
   cloneMax = 12;
   cloneAngle = 30;   

   // these vary with the egg
   local string cloneName; 
   local float cloneIndex; 

   if (eggType == ANARCHY_EGG) {
      // give them some more clones, knight model is smaller
      cloneMax = 30;
      cloneAngle = 12;
      cloneName = "progs/knight.mdl"; 
      cloneIndex = modelindex_knight; 
   }
   else if (eggType == HOC_EGG) {
      cloneName = "progs/shambler.mdl"; 
      cloneIndex = modelindex_shambler; 
   }
   else return;

   while (i < cloneMax)
   {
      i = i + 1;
      // oops we cant have local vars of type function
      if (eggType == ANARCHY_EGG) 
         eeCreateClone (selfangles,e, cloneName, cloneIndex, eeKnight);
      else if (eggType == HOC_EGG) 
         eeCreateClone (selfangles,e, cloneName, cloneIndex, eeSham);
      selfangles_y = selfangles_y + cloneAngle;
   }
   
};   

