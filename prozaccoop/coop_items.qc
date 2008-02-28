/*
	coop_items.qc
*/

#ifndef COOP_MODE_ENHANCED
#pragma DONT_COMPILE_THIS_FILE
#else

/*
	weapon_dummy - only exists when the weapon has targets it needs to fire when picked up, since some maps depend upon that
*/

void () weapon_dummy_touch =
{
	if (!(other.flags & #FL_CLIENT))
		return;

	sound (other, #CHAN_ITEM, self.noise, 1, #ATTN_NORM);

	Respawn_Item(self, other);
	remove (self);
};

float () weapon_dummy =
{
	if (!self.killtarget && !self.target) {
		remove (self);
		return #FALSE;
	}

//	bprint (#PRINT_HIGH, "!! There's a special weapon on this level !!\n");
//	bprint (#PRINT_HIGH, "Origin: ", vtos(self.origin), "\n");

	// grenade3.mdl is the gift model from the birthday mode
	// couldn't think of a better model, didn't want to just use the weapon
	// because it's not really a weapon, nor does it give you any ammo
	// a spinning model that says 'pick me up' would be the best
	precache_model ("progs/grenade3.mdl");
	setmodel (self, "progs/grenade3.mdl");
	self.touch = weapon_dummy_touch;
	self.noise = "misc/medkey.wav";
	precache_sound (self.noise);

	return #TRUE;
};

#endif
