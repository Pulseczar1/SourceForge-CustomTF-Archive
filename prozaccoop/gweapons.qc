/*
	gweapons.qc - Gizmo's new Coop weapons

	FIXME: rename file?
*/


//==============================================================

/*
=============================
Zero-Gravity gun
=============================
*/

#define ZG_PICKUPDIST_EXTRA			48				// extra distance added to pickupee's maxs, was 32

// FIXME: change some of these to macros
.entity pickedupobject_hands;
.entity pickupthink_hands;
.entity _oldowner;
.float oldmovetype;

void (entity pickuper, float toss) zg_drop;
float (entity pickupee) zg_getpickupdist;


void (entity pickuper, entity pickupee, vector destt) zg_movetowards =
{
	local float vel, distfrompickuper;

	vel = vlen (pickupee.origin - destt);
	distfrompickuper = vlen(pickuper.origin - pickupee.origin);

	if (distfrompickuper > zg_getpickupdist(pickupee) + 32) {
		pickupee.velocity = '0 0 0';
		zg_drop (pickuper, #FALSE);
		return;
	}

	if (pickupee.origin != destt)
		pickupee.velocity = pickuper.velocity + ((normalize(destt - pickupee.origin) * vel) * 10);
	else
		pickupee.velocity = pickuper.velocity;
};


float (entity pickupee) zg_getpickupdist =
{
	local float sizex, sizey;

	if (pickupee.solid == #SOLID_NOT || pickupee.solid == #SOLID_TRIGGER || (!pickupee.mins_x && !pickupee.maxs_x))
		return #ZG_PICKUPDIST_EXTRA;

	sizex = pickupee.maxs_x + #ZG_PICKUPDIST_EXTRA/*(pickupee.mins_x * -1) + pickupee.maxs_x*/;
	sizey = pickupee.maxs_y + #ZG_PICKUPDIST_EXTRA/*(pickupee.mins_y * -1) + pickupee.maxs_y*/;

	// go for the biggest side
	if (sizex >= sizey)
		return sizex;
	else
		return sizey;
};


float (entity source, entity targ) zg_infront =
{
	local vector	vec;
	local float		dot;
	
	makevectors (source.angles);

	vec = normalize (targ.origin - source.origin);
	dot = vec * v_forward;
	
	if ( dot > 0.3)
	{
		return #TRUE;
	}
	return #FALSE;
};


float (entity tester, entity test) zg_invalidtarget =
{
	if (test.solid == #SOLID_BSP || test == world || test.movetype == #MOVETYPE_NONE)
		return #TRUE;
	if (test.flags & #FL_MONSTER || !zg_infront(tester, test))
		return #TRUE;
	if (IsBuilding(test) && test.real_owner != tester)
		return 2;
	if (test.flags & #FL_ITEM)
		return 3;
	if (test.flags & #FL_CLIENT)
		return #TRUE;

	return #FALSE;
};

entity (entity source) zg_findtarget =
{
	local entity radiusent;
	local float ret, badpickup;

	makevectors (source.v_angle);

	// try directly at what we're looking at
	traceline (source.origin, (source.origin + '0 0 16') + v_forward*64, #TL_ANY_SOLID, source);

	if (trace_fraction != 1.0 && !(ret = zg_invalidtarget(source, trace_ent)))
		return trace_ent;

	if (ret > 1)
		badpickup = ret;

	// if nothing's directly infront try scanning for something
	radiusent = findradius (source.origin, 64);

	while (radiusent) {
		if (!(ret = zg_invalidtarget(source, radiusent)))
			return radiusent;

		if (ret > 1)
			badpickup = ret;

		radiusent = radiusent.chain;
	}

	if (source.flags & #FL_CLIENT) {
		if (badpickup == 2)
			sprint (source, #PRINT_HIGH, "Sorry, only the owner can pickup his builds!\n");
		else if (badpickup == 3)
			sprint (source, #PRINT_HIGH, "Sorry, picking up items is disabled!\n");
		else
			sprint (source, #PRINT_HIGH, "There's nothing there to pickup\n");
	}

	return world;
};


void () zg_think =
{
	local entity pickuper, pickupee;

	pickuper = self.owner;
	pickupee = self.owner.pickedupobject_hands;

	// if the pickuper doesn't have anything picked up then remove ourself
	if (pickupee == world)
		remove (self);

	// check if the pickuper is dead, FIXME: change if pickuper left
	if (pickuper.health <= 0 || (pickupee.takedamage && pickupee.health <= 0) || pickupee.model == "" || !pickuper.is_connected)	// *
		zg_drop (pickuper, #FALSE);

	makevectors (pickuper.v_angle);

	// this is based upon the entity's size
/*
	// there's a bug in cpqwsv, for some reason the trace_endpos is screwed on this, works fine on other qwsv's
	traceline (pickuper.origin, (pickuper.origin + '0 0 16') + v_forward*zg_getpickupdist(pickupee), #TL_BSP_ONLY, pickuper);
*/
	trace_endpos = (pickuper.origin + '0 0 16') + v_forward*zg_getpickupdist(pickupee);

	zg_movetowards (pickuper, pickupee, trace_endpos);

	self.nextthink = time + 0.05;
	self.think = zg_think;
};


void (entity pickuper, float toss) zg_drop =
{
	local entity pickupee, oldself;

	pickupee = pickuper.pickedupobject_hands;

	makevectors (pickuper.v_angle);

	// checked based upon the entity's size
	//traceline (pickuper.origin, (pickuper.origin + '0 0 16') + v_forward*64, #TL_ANY_SOLID, pickuper);

	// make sure we have something picked up
	if (pickuper.pickedupobject_hands == world)
		return;

	/*
	if ((trace_fraction != 1.0 || zg_insolid(pickupee)) && !(pickuper.health <= 0 || (pickupee.takedamage && pickupee.health <= 0) || pickupee.model == "")) {
		if (pickuper.flags & #FL_CLIENT)
			sprint (pickuper, #PRINT_HIGH, "Not enough room here\n");

		return;
	}
	*/

	// fix pickuper and pickupee
	remove (pickuper.pickupthink_hands);

	if (toss) {
		pickupee.velocity = v_forward * 500;

		if (pickupee.oldmovetype != #MOVETYPE_FLY && pickupee.oldmovetype != #MOVETYPE_FLYMISSILE)
			pickupee.velocity = pickupee.velocity + v_up * 200;
	} else
		pickupee.velocity_z = pickupee.velocity_z + 10;	// *

	pickuper.owner = pickuper._oldowner;
	pickupee.movetype = pickupee.oldmovetype;


	pickuper.pickedupobject_hands = world;

	// reset weaponmodel
	if (pickuper.health > 0) {
		oldself = self;
		self = pickuper;
		W_SetCurrentAmmo ();
		self = oldself;
	}
};


void (entity pickuper) zg_pickup =
{
	local entity thinker;

	trace_ent = zg_findtarget (pickuper);

	if (!trace_ent)
		return;

	// make sure we're not already picking something up
	if (pickuper.pickedupobject_hands != world)
		return;

/*
	// check if there's nothing within reach
	if (trace_fraction == 1.0 || trace_ent.solid == #SOLID_BSP || trace_ent == world || trace_ent.movetype == #MOVETYPE_NONE) {
		if (pickuper.flags & #FL_CLIENT)
			sprint (pickuper, #PRINT_HIGH, "There's nothing there to pickup\n");

		return;
	}
*/

	// check if it's too heavy
	/*
	if (trace_ent.size_x > 32 || trace_ent.size_y > 32) {
		if (pickuper.flags & #FL_CLIENT)
			sprint (pickuper, #PRINT_HIGH, "It's too heavy to lift\n");

		return;
	}
	*/

	// setup pickuper and pickupee
	pickuper._oldowner = pickuper.owner;			// *
	pickuper.owner = trace_ent;					// *

	trace_ent.oldmovetype = trace_ent.movetype;
	trace_ent.movetype = #MOVETYPE_FLY;

	trace_ent.flags = trace_ent.flags - #FL_ONGROUND;	// *

	// fire the onpickup event on the pickupee
	//if (trace_ent.onpickup)
	//	trace_ent.onpickup (pickuper, trace_ent);


	pickuper.pickedupobject_hands = trace_ent;

	// create the thinker
	thinker = spawn ();
	thinker.owner = pickuper;

	thinker.nextthink = time + 0.01;			// TODO: raise this?
	thinker.think = zg_think;

	pickuper.pickupthink_hands = thinker;
};


void (entity pickuper, float toss) zg_togglepickup =
{
	if (pickuper.pickedupobject_hands == world)
		zg_pickup (pickuper);
	else
		zg_drop (pickuper, toss);
};
