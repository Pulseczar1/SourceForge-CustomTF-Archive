/*
	tfdefs.qc - to keep defs.qc a little cleaner, place teamfortress specific defs.qc stuff in here instead
*/


// player only fields
#define team_damage_dealt			cnt				// total amount of team damage this player has dealt
#define enemy_damage_dealt			volume			// total amount of damage done to enemies only
#define damage_taken				distance			// player that took the most amount of damage from enemies

// grunt.qc
#define allowed_weapons				wait				// weapons the grunt can use

// prototypes
float (entity ent) InSolid;


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


/*
	qc_droptofloor - allows drops that aren't bound to 256 down, though it cannot be negative
*/

#define DROPDIST 256
float(entity e, float dist, float nodrop) qc_droptofloor =
{
	local entity	oself;
	local vector	oldorg;
	local float		destz;

	oself = self;
	self = e;

	destz = self.origin_z - dist;
	oldorg = self.origin;

	do {
		if (droptofloor()) {
			self = oself;
			if (e.origin_z >= destz) {
				if (nodrop) {
					e.flags = e.flags - #FL_ONGROUND;
					setorigin (e, oldorg);
				}
				return #TRUE;
			} else {
				// droptofloor() always sets FL_ONGROUND when it returns TRUE, so no need for '- (e.flags & FL_ONGROUND)'
				e.flags = e.flags - #FL_ONGROUND;
				setorigin (e, oldorg);
				return #FALSE;
			}
		}

		// if droptofloor() failed, check if we started in a solid, and if so abort right away
		if (InSolid(self)) {
			setorigin (self, oldorg);
			self = oself;
			return #FALSE;
		}
		// no need to call setorigin() here, because droptofloor() uses current origin and links if successful
		self.origin_z = self.origin_z - #DROPDIST;
	} while (self.origin_z > destz);

	setorigin (self, oldorg);
	self = oself;
	return #FALSE;
};


#ifdef NEVER_DEFINED
/*
	precache_sound - prevents precache_*** overflow crashes
*/

float precached_sounds;

string( string s ) precache_sound = {
	local string mp;

	// check if it's already precached
	mp = infokey( world, s );
	if ( mp == "1" )
		return;

	if ( precached_sounds + 1 > 256 ) {
		dprint( "WARNING: precache_sound: attempted to precache more than 256 sounds\n" );
		return "";
	}

	localcmd( "localinfo \"" );
	localcmd( s );
	localcmd( "\" 1\n" );

	precached_sounds = precached_sounds + 1;

	precache_sound_C( s );
	return s;
};


/*
	precache_model
*/

float precached_models;

string( string s ) precache_model = {
	local string mp;

	// check if it's already precached
	mp = infokey( world, s );
	if ( mp == "1" )
		return;

	if ( precached_models + 1 > 256 ) {
		dprint( "WARNING: precache_model: attempted to precache more than 256 models\n" );
		return "";
	}

	localcmd( "localinfo \"" );
	localcmd( s );
	localcmd( "\" 1\n" );

	precached_models = precached_models + 1;

	precache_model_C( s );
	return s;
};


/*
	setmodel
*/

void( entity e, string m ) setmodel = {
	local string s;

	if ( m == "" ) {
		setmodel_C( e, m );
		return;
	}

	s = infokey( world, m );

	if ( s != "1" ) {
		dprint( "WARNING: setmodel: " );
		dprint( m );
		dprint( " not precached\n" );
		setmodel_C( e, "progs/player.mdl" );
		return;
	}

	setmodel_C( e, m );
};
#endif
