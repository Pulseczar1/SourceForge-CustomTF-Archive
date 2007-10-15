/*
	tfdefs.qc - to keep defs.qc a little cleaner, place teamfortress specific defs.qc stuff in here instead
*/


// player only fields
#define team_damage_dealt			cnt				// total amount of team damage this player has dealt


// FIXME: a QC implementation of tracebox
/*
void(vector v1, vector v2, vector bbox_mins, vector bbox_maxs, entity forent) tracebox =
{
	local entity	tent, oself;
	local vector	vec;
	local float		dist;

	vec = v2 - v1;
	dist = vlen (vec);

	// create an entity to perform the tracebox with
	tent = spawn ();

	// setup the starting position
	tent.owner		= forent;
	tent.solid		= #SOLID_SLIDEBOX;
	tent.movetype	= #MOVETYPE_STEP;
	tent.flags		= #FL_ONGROUND | #FL_PARTIALGROUND;
	setsize (tent, bbox_mins, bbox_maxs);
	setorigin (tent, v1);

	// move tent in the direction of 'vec' with a distance of 'dist'
	oself = self;
	self = tent;
	walkmove (
*/
