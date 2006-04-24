// Identify the player you are pointed towards
// By Suck (Nat Friedman)
// This code falls under the GNU public license, and cannot be 
// redistributed without my name attached.

// hacked by Zoid for CTF4

// This is called with the player who wants to know whose in front
// of him as "self."  I call it with an impulse in weapons.qc

// modified by [inferno] (waije@titan.oit.umass.edu) for SCTF use and to
// identify runes!
entity(float disp, string ent) identify =
{
	// e is a temp entity; guy is our current best guess
	// as to at whom the player is pointing
	local entity e, guy;

	// The best "closeness" heuristic so far.
	local float closeness = -1;

	// Temp vars.
	local vector diff, point;
	local float currclose;
	local string s1, s2, s3;

   // Walk the list of players...(or runes)
   e=find(world, classname, ent);
	while (e!=world)
	{
		// Get a vector pointing from the viewer to the current
		// player under consideration
		diff=self.origin - e.origin;

		// Normalize it since we only care where he's pointing,
		// not how far away the guy is.
		diff=normalize(diff);

		// Normalize self.angles so we can do a length-independent
		// consideration
		point=normalize(self.angles);

		// Find the different between the current player's angle
		// and the viewer's vision angle
		diff=diff - point;

		// The length is going to be our definition of closeness
		currclose=vlen(diff);
		traceline(self.origin, e.origin, FALSE, self);
		if (trace_ent == e) {
			if (closeness == -1) {
				closeness = currclose;
				guy = e;
			} else if (currclose < closeness) {
				closeness = currclose;
				guy = e;
			}
		}
      e=find(e, classname, ent);
	}

	// Now we display.
	if (disp==0)
		return guy;
   if (guy == world && ent=="player")
	{
      UpdatePlayerStatus(self, "You're not looking at anyone!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
		return world;
	}
   if (guy == world && ent=="rune")
	{
      UpdatePlayerStatus(self, "You're not looking at a rune!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
		return world;
	}
   if(ent=="player") UpdatePlayerStatus(self, "You are looking at ", guy.netname, "\n\n\n\n\n\n\n\n\n\n\n\n");//, "", "", "", "");
   if(ent=="rune")UpdatePlayerStatus(self, "You are looking at the rune - ",
      guy.runeName,"\n\n\n\n\n\n\n\n\n\n\n\n");
	return guy;
};	 

