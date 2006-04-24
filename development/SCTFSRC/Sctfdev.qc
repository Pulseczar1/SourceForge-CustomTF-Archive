void() W_Attack;
void (
   vector selfangles, 
   entity myself, 
   string cloneName, 
   float cloneIndex, 
   void() cloneThink
) testCreateClone =
{

   // make sure there is room to place him
   makevectors(selfangles);
   local vector v;

// xxx
   v = myself.origin - v_forward * 80;

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
   e.count_count = 6;
   setsize (e, VEC_HULL_MIN, VEC_HULL_MAX);

   // give him something to think about
   e.think = cloneThink;  
   e.nextthink = time + 0.1;

   // make him face your back
   e.angles = selfangles;
   e.angles_y = e.angles_y; 
   
   // toss him out like a rune
   e.movetype = MOVETYPE_TOSS;
   e.origin = myself.origin - '0 0 24';
   e.velocity = v_forward * (-100);
   e.velocity_z = 400;
	
   // give him a physical presence
   e.flags = FL_ITEM;
   e.solid = SOLID_BBOX;

};



// Players, observers and admins will all call this function
// when checking impulses.
// Use it for testing new cmds
// Usage: if you handle an impulse locally, then set self.impulse to 0,
// and set rc to 1.
float() CheckDevCmd =
{
   local float rc;
   rc = 0;

   /********** DIAGNOSITICS ***********/
   // // for testing only, to determine when the entity variables are cleared.
   // else if (self.impulse == 98)
   // {
   //    self.test = "98";
   //    self.impulse = 0;
   // }
   if (self.impulse == 97)
   {
      bprint("self.fly [");
      local string s1;
      s1 = ftos(self.fly);
      bprint(s1);
      bprint("] flags&FL_FLY [");
      s1 = ftos(self.flags & FL_FLY);
      bprint(s1);
      bprint("]\n");
      self.impulse = 0;
      return 1;
   }

   return rc;
};


