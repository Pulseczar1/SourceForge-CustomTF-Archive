/*
	TeamFortress V2.1 22/12/96

	TeamFortress Software
*/			
float() CheckExistence;
entity(float gno) Findgoal;

//==============================================================
// A remove function which makes sure the entity hasn't already
// been removed, and that it isn't the world object.
void(entity te) dremove =
{
	if (te == world)
	{
		dprint("***BUG BUG BUG BUG BUG BUG BUG BUG BUG BUG***\n");
		dprint("WORLD has nearly been removed. Don't worry\n");
		dprint("***BUG BUG BUG BUG BUG BUG BUG BUG BUG BUG***\n"); 
		return;
	}
	if (te.is_removed == #TRUE)
	{
	/*
		dprint("***BUG BUG BUG BUG BUG BUG BUG***\n");
		dprint("  Entity has been removed twice. \n");
		dprint("***BUG BUG BUG BUG BUG BUG BUG***\n"); 
	*/
		return;
	}

	te.is_removed = #TRUE;
	remove(te);
};

//==============================================================
// A command which just dumps your current location to the screen
void() display_location =
{
	local string st;

	st = vtos(self.origin);
	sprint (self, #PRINT_HIGH, st);
	sprint (self, #PRINT_HIGH, "\n");
};
