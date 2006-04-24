/*
 #####################
 ### chase cam mod ###
 Rob Albin, 09 Sep 96

 orig functions modified:
	WEAPONS.QC
		W_SetCurrentAmmo
		ImpulseCommands
	CLIENT.QC
		SetChangeParms
		SetNewParms
		DecodeLevelParms
		PutClientInServer

        Modified by Inferno (waije@titan.oit.umass.edu)
        NOTE:  I "commented" all the water functions so
        the chasecam will work underwater too...
*/

/*
=============
visible

returns 1 if the entity is visible to self, even if not infront ()
=============
*/
float (entity targ) visible =
{
	local vector	spot1, spot2;
	
	spot1 = self.origin + self.view_ofs;
	spot2 = targ.origin + targ.view_ofs;
	traceline (spot1, spot2, TRUE, self);	// see through other monsters
	
	if (trace_inopen && trace_inwater)
                return TRUE;//FALSE;                   // sight line crossed contents

	if (trace_fraction == 1)
		return TRUE;
	return FALSE;
};

// message protocol defines
float SVC_SETVIEWPORT	= 5;
float SVC_SETVIEWANGLES	= 10;

// free player entity variable
// '.float speed'  bit-flag defines:
float CHSCAM_MONSTER  = 8;
float CHSCAM_ON       = 4;
float LASERTARG_LIT   = 2;
float LASERTARG_ON    = 1;


void() Keep_cam_chasing_owner;
void( float opt ) Remove_chase_cam;

// defaults reset every time level starts
float chasecam_dist = 118, chasecam_zofs = 24;


// Resets weapon model after changing view
// called by chase cam or player entities
void( entity player_ent ) Chase_cam_setweapon =
{
	local entity e;

	e = self;
	self = player_ent;
	W_SetCurrentAmmo ();
	self = e;
};

// called either by player or chase cam entities (to restart)
void( entity cam_owner ) Start_chase_cam =
{

	local entity	chase_cam;

	chase_cam = spawn();

	chase_cam.owner=cam_owner;

	// turn on bit-flag
	chase_cam.owner.speed = chase_cam.owner.speed | CHSCAM_ON;

	chase_cam.solid = SOLID_NOT;
	chase_cam.movetype = MOVETYPE_FLY;


	chase_cam.angles = chase_cam.owner.angles;

   setmodel (chase_cam, "progs/eyes.mdl" );
   setsize (chase_cam, '0 0 0', '0 0 0');
	setorigin( chase_cam, chase_cam.owner.origin );
	chase_cam.classname = "chase_cam";

	chase_cam.nextthink = time + 0.1;
	chase_cam.think = Keep_cam_chasing_owner;

	msg_entity = chase_cam.owner;                         // target of message
	WriteByte (MSG_ONE, SVC_SETVIEWPORT);
	WriteEntity (MSG_ONE, chase_cam);           // view port

	Chase_cam_setweapon( cam_owner );

	// distance clipping
	chase_cam.ammo_shells = chasecam_dist / 3; // chasecam_dist;

};

// secondary think for cam entities
void() Reable_chase_cam =
{
	self.nextthink = time + 0.1;

	// debug
	// sprint( self.owner, "Reable_chase_cam was called\n" );

	// clears bug of not being able to hit fire to restart
	// after dying in water
	if (self.owner.health <= 0)
	{
		remove( self );
		return;
	}

//        if (self.owner.waterlevel)
//                return;

	Start_chase_cam( self.owner );
	remove( self );

};

// called only by chase cam entities
// opt values
// TRUE = remove completely
// FALSE = remove view but keep alive with Reable_chase_cam();
void( float opt ) Remove_chase_cam =
{
	// turn off bit-flag
	if ( (self.owner.speed & CHSCAM_ON) )
		self.owner.speed = self.owner.speed - CHSCAM_ON;

	// makes entity appear gone even if going into keep alive state
	setmodel( self, "" );
	self.velocity = '0 0 0';

	// set view-point back to normal
	msg_entity = self.owner;      // target of message
	WriteByte (MSG_ONE, SVC_SETVIEWPORT);
	WriteEntity (MSG_ONE, self.owner);           // view port

	Chase_cam_setweapon( self.owner );

	if ( !opt )
	{
		self.nextthink = time + 0.1;
		self.think = Reable_chase_cam;
	}
	else
		remove( self );

};

// main think function for cam entities
//  self.ammo_shells = distance clipping
//  self.ammo_nails = hang-up flag

void() Keep_cam_chasing_owner =
{
	local vector goal, dir;
	local float  dist, cap,
					 f_f;
	//debug var
	local string s;

	self.nextthink = time + 0.1;

	// check if player toggled
	// or in water
	if (! (self.owner.speed & CHSCAM_ON))
	{
		Remove_chase_cam( TRUE );
		return;
	}

//        if ( self.owner.waterlevel )
//        {
//                if (self.owner.health > 0)
//                {
//                        Remove_chase_cam( FALSE );
//                        return;
//                }
//        }

        // no chasecam while intermission running...
        if (intermission_running)
        {
                if (self.owner.health > 0)
                {
                        Remove_chase_cam( FALSE );
                        return;
                }
        }


	// get player velocity relative to player's
	// current yaw
	// f_f (based on running calcs (maxspeed = 400)
	//  (back ~= 640, forward ~= 0)
	dir_y = self.owner.v_angle_y;
	makevectors( dir );
	f_f = vlen( (v_forward * 320) - self.owner.velocity );

	// held for use after second makevectors call for
	// v_forward based only on yaw
	dir = v_forward;

//   local string s;
//   sprint( self.owner, "\n\n f_f = " );
//   s = ftos( f_f );
//   sprint( self.owner, s );
//   sprint( self.owner, "\n f_r = " );
//   s = ftos( f_r );
//   sprint( self.owner, s );
//   sprint( self.owner, "\n" );

	makevectors( self.owner.v_angle );

	// set spot before clipping
	goal = self.owner.origin - (v_forward * self.ammo_shells);
	/*
		sprint( self.owner, "shells: " );
		s = ftos( self.ammo_shells );
		sprint( self.owner, s );
		sprint( self.owner, "vang_x: " );
		s = ftos( self.owner.v_angle_x );
		sprint( self.owner, s );
		sprint( self.owner, "\n" );
	*/

	if (self.owner.v_angle_x > 16)
	{
		// dir is first v_forward based on yaw only
		goal = goal + (dir * (self.owner.v_angle_x - 16) );
		cap = chasecam_zofs - ((self.owner.v_angle_x - 16) );// * 0.8);
		//if (cap < 0) cap = 0;
		goal_z = goal_z + cap;
		if (goal_z < self.owner.origin_z + 20)
			goal_z = self.owner.origin_z + 20;
	}
	else
		goal_z = goal_z + chasecam_zofs;


	traceline (self.owner.origin, goal, FALSE, self.owner);

	// for fading from walls and up-aim auto rising
	if (trace_fraction < 1 || self.owner.v_angle_x < -16)
		self.ammo_shells = 8 + vlen(trace_endpos - self.owner.origin);

	// avoids most hang-ups along walls
	goal = trace_endpos + ( v_forward * 2 );



	// clip from ceiling if too close
	traceline (goal, goal + '0 0 32', FALSE, self.owner );
	if (trace_fraction < 1 )
	{
		dir = trace_endpos - '0 0 32';

		traceline (goal, goal - '0 0 32', FALSE, self.owner );
		if (trace_fraction == 1)
			goal = dir;
	}


	dir = normalize(goal - self.origin);
	dist = vlen(goal - self.origin);


	// traceline( self.origin, goal, FALSE, self.owner );
	// if ( trace_fraction == 1 )
	if ( visible(self.owner) )
	{
		self.angles = self.owner.angles;

		cap = dist * 0.2;

		if (cap > 5.2)
			self.velocity = dir * dist * 5.2;
		else if (cap > 1)
			self.velocity = dir * dist * cap;
		else
			self.velocity = dir * dist;

		// tighten up if owner running backwards
		if ( f_f > 560)
		{
			self.velocity = self.velocity * 2;
		}

	}
	else
		setorigin( self, goal );

	// fade back from walls
	self.ammo_shells = self.ammo_shells + 4.5;
	if (self.ammo_shells > chasecam_dist)
		self.ammo_shells = chasecam_dist;

	// respawn if missile ent. get's hung up
	if( self.oldorigin == self.origin )
	{
		if( dist > 30 )
			self.ammo_nails = self.ammo_nails + 1;
		if( self.ammo_nails > 2 )
		{
			Start_chase_cam( self.owner );
			remove( self );
			return;
		}

	}
	self.oldorigin = self.origin;

};


// called by player only
void() Toggle_chase_cam =
{

//        if (self.waterlevel)
//                return;

	if( (self.speed & CHSCAM_ON) )
	{
		// will be noticed by next think
		// of player's chase cam entity
		self.speed = self.speed - CHSCAM_ON;
	}
	else
		Start_chase_cam( self );

};

////////////////////////////////////////////
// laser targeter functions

// targeter ent. think function

void() LaserTargeterTrack =
{
	local vector src;

	if (! (self.owner.speed & LASERTARG_ON))
	{
                if (self.owner.speed & LASERTARG_LIT) 
		{
			self.owner.speed = self.owner.speed | LASERTARG_ON;
			self.effects = self.effects | EF_DIMLIGHT;
		}
		else
		{
			remove( self );
			return;
		}
	}

	makevectors( self.owner.v_angle );

	src = self.owner.origin + v_forward * 10;
	src_z = self.owner.absmin_z + self.owner.size_z * 0.7;

	traceline( src,  src + v_forward * 2048, FALSE, self.owner);

	setorigin( self, (0.1 * src + 0.9 * trace_endpos) );

        self.nextthink = time + 0.1;

};

void( entity targ_owner ) LaserTargeterToggle =
{

	local entity e;

        if (targ_owner.speed & LASERTARG_ON)
	{
                if (targ_owner.speed & LASERTARG_LIT)
			targ_owner.speed = targ_owner.speed - LASERTARG_LIT;
		else
			targ_owner.speed = targ_owner.speed | LASERTARG_LIT;

		targ_owner.speed = targ_owner.speed - LASERTARG_ON;
	}
	else
	{
		targ_owner.speed = targ_owner.speed | LASERTARG_ON;

		e = spawn();
		e.owner = targ_owner;

		e.movetype = MOVETYPE_NONE;
		e.solid = SOLID_NOT;

		setmodel( e, "progs/s_bubble.spr" );
		setsize( e, VEC_ORIGIN, VEC_ORIGIN );
		setorigin( e, e.owner.origin );

                if (e.owner.speed & LASERTARG_LIT)
			e.effects = e.effects | EF_DIMLIGHT;

		e.nextthink = time + 0.1;
		e.think = LaserTargeterTrack;

	}

};
////////////////////////////////////////////


void() Chase_cam_lvlstart_think =
{

	if ( (self.owner.speed & CHSCAM_ON) )
		Start_chase_cam( self.owner );

	if ( (self.owner.speed & LASERTARG_ON) )
	{
		self.owner.speed = self.owner.speed - LASERTARG_ON;
		LaserTargeterToggle( self.owner );
	}

	remove( self );

};


// called in CLIENT.QC by void() PutClientInServer
// player.speed is set and saved between levels using parm16
// in CLIENT.QC
void() Chase_cam_level_start =
{

	local entity e;

		e = spawn();
		e.owner = self;

		e.movetype = MOVETYPE_NONE;
		e.solid = SOLID_NOT;

		setmodel( e, "" );
		setsize( e, VEC_ORIGIN, VEC_ORIGIN );
		setorigin( e, e.owner.origin );

		e.nextthink = time + 0.2;
		e.think = Chase_cam_lvlstart_think;

};

// opt:
// 0 = minus
// 1 = plus
void(float opt) Chase_cam_change_dist =
{
	local string s;

	if (!opt)
	{
                chasecam_dist = chasecam_dist - 15;//2;
		if (chasecam_dist < 10)
			chasecam_dist = 10;
	}
	else
	{
                chasecam_dist = chasecam_dist + 15;//2;
	}
	sprint( self, "chasecam distance = " );
	s = ftos( chasecam_dist );
	sprint( self, s );
	sprint( self, "\n" );


};

// ### chase view spy mod ###
// uses free player variable .vector dest1 to hold current
// origin for switching back.

void() MKeep_cam_chasing_owner;

float	modelindex_eyes, modelindex_player;

void() MFake_player_think =
{
	self.nextthink = time + 0.1;

	if ((self.owner.speed & CHSCAM_ON))
		return;

	self.solid = SOLID_NOT;

	// player appear
	self.owner.solid = SOLID_SLIDEBOX;
	self.owner.movetype = MOVETYPE_WALK;
	setmodel (self.owner, "progs/eyes.mdl");
	modelindex_eyes = self.owner.modelindex;
//        setmodel(self.owner, "progs/enforcer.mdl");
//        modelindex_enforcer = self.owner.modelindex;
	setmodel (self.owner, "progs/player.mdl");
	modelindex_player = self.owner.modelindex;
	setsize (self.owner, VEC_HULL_MIN, VEC_HULL_MAX);
		//setorigin( self.owner, self.owner.dest1 );
	setorigin( self.owner, self.origin );
	////////////////

	if ((self.owner.flags & FL_NOTARGET))
		self.owner.flags = self.owner.flags - FL_NOTARGET;

	remove( self );

};

/*
void() MFake_player_pain =
{
	local float d;

	if (self.owner.health > self.health)
	{
		d = self.owner.health - self.health;
		T_Damage(self.owner, self, self, d);
	}

};

void() MFake_player_die =
{
	if ((self.owner.speed & CHSCAM_ON))
		self.owner.speed = self.owner.speed - CHSCAM_ON;
	MFake_player_pain();
	MFake_player_think();

};
*/

void( entity cam_owner, vector cam_pos ) MFake_player_appear =
{
	local entity e;
	local vector plr_pos;

	plr_pos = cam_owner.origin;

	// player vanish
		//cam_owner.dest1 = cam_owner.origin;
	cam_owner.flags = cam_owner.flags | FL_NOTARGET;
	cam_owner.solid = SOLID_NOT;
	cam_owner.movetype = MOVETYPE_NONE;
	setmodel (cam_owner, "");
	modelindex_eyes = cam_owner.modelindex;
	modelindex_player = cam_owner.modelindex;

	cam_owner.angles = cam_owner.goalentity.angles;
	cam_owner.fixangle = 1;
		// position player to chase view's location
	setsize (cam_owner, VEC_ORIGIN, VEC_ORIGIN);
	setorigin( cam_owner, cam_pos );
	////////////////


	e = spawn();
	e.owner = cam_owner;

	e.classname = "fake_player";
	e.solid = SOLID_BBOX;
	e.movetype = MOVETYPE_STEP;
	e.health = cam_owner.health;
	e.takedamage = DAMAGE_AIM;
	e.angles = cam_owner.angles;

	e.nextthink = time + 0.1;
	e.think = MFake_player_think;
	//e.th_pain = MFake_player_pain;
	//e.th_die = MFake_player_die;

	setmodel (e, "progs/player.mdl");
	setsize (e, VEC_HULL_MIN, VEC_HULL_MAX);
	// position fake player on player's original spot
	setorigin( e, plr_pos );


};

// called either by player or chase cam entities (to restart)
//opt:
// 0 = don't make fake player
// 1 = make fake player
void( entity cam_owner, entity g_e, float opt ) MStart_chase_cam =
{

	local entity	chase_cam;

	cam_owner.goalentity = g_e;

	chase_cam = spawn();

	chase_cam.owner = cam_owner;

	// turn on bit-flags
	chase_cam.owner.speed = chase_cam.owner.speed | CHSCAM_ON;
	chase_cam.owner.speed = chase_cam.owner.speed | CHSCAM_MONSTER;

	chase_cam.solid = SOLID_NOT;
	chase_cam.movetype = MOVETYPE_FLY;

	chase_cam.angles = cam_owner.goalentity.angles;

	setmodel (chase_cam, "progs/eyes.mdl" );
	setsize (chase_cam, VEC_ORIGIN, VEC_ORIGIN);
	setorigin( chase_cam, cam_owner.goalentity.origin );

	if (opt > 0)
		MFake_player_appear( cam_owner, chase_cam.origin );

	chase_cam.classname = "chase_cam";

	chase_cam.nextthink = time + 0.1;
	chase_cam.think = MKeep_cam_chasing_owner;

	msg_entity = chase_cam.owner;                         // target of message
	WriteByte (MSG_ONE, SVC_SETVIEWPORT);
	WriteEntity (MSG_ONE, chase_cam);           // view port

	Chase_cam_setweapon( cam_owner );

	// distance clipping
	chase_cam.ammo_shells = chasecam_dist / 3; // chasecam_dist;

};

// called only by chase cam entities
// opt values
// TRUE = remove completely
// FALSE = remove view but keep alive with Reable_chase_cam();
void( float opt ) MRemove_chase_cam =
{
	// turn off bit-flag
	if ( (self.owner.speed & CHSCAM_ON) )
		self.owner.speed = self.owner.speed - CHSCAM_ON;
	if ( (self.owner.speed & CHSCAM_MONSTER) )
		self.owner.speed = self.owner.speed - CHSCAM_MONSTER;

	// makes entity appear gone even if going into keep alive state
	setmodel( self, "" );
	self.velocity = '0 0 0';


	// set view-point back to normal
	msg_entity = self.owner;      // target of message
	WriteByte (MSG_ONE, SVC_SETVIEWPORT);
	WriteEntity (MSG_ONE, self.owner);           // view port


	sprint( self.owner.goalentity, self.owner.netname );
	sprint( self.owner.goalentity, " quit tracking\n" );

	Chase_cam_setweapon( self.owner );


	remove( self );

};

// main think function for cam entities
//  self.ammo_shells = distance clipping
//  self.ammo_nails = hang-up flag

void() MKeep_cam_chasing_owner =
{
	local vector goal, dir;
	local float  dist, cap,
					 f_f;
	//debug var
	local string s;

	self.nextthink = time + 0.1;

	// check if player toggled
	// or in water
	if (! (self.owner.speed & CHSCAM_ON))
	{
		MRemove_chase_cam( TRUE );
		return;
	}

	makevectors( self.owner.goalentity.angles );

	// set spot before clipping
	goal = self.owner.goalentity.origin - (v_forward * self.ammo_shells);
	goal_z = goal_z + chasecam_zofs;


	traceline (self.owner.goalentity.origin, goal, FALSE, self.owner.goalentity);

	// for fading from walls and up-aim auto rising
	if (trace_fraction < 1)
		self.ammo_shells = 8 + vlen(trace_endpos - self.owner.goalentity.origin);

	// avoids most hang-ups along walls
	goal = trace_endpos + ( v_forward * 2 );

	// clip from ceiling if too close
	traceline (goal, goal + '0 0 32', FALSE, self.owner.goalentity );
	if (trace_fraction < 1 )
	{
		dir = trace_endpos - '0 0 32';

		traceline (goal, goal - '0 0 32', FALSE, self.owner.goalentity );
		if (trace_fraction == 1)
			goal = dir;
	}

	dir = normalize(goal - self.origin);
	dist = vlen(goal - self.origin);


	if ( visible(self.owner.goalentity) )
	{
		self.angles = self.owner.goalentity.angles;

		cap = dist * 0.2;

		if (cap > 5.2)
			self.velocity = dir * dist * 5.2;
		else if (cap > 1)
			self.velocity = dir * dist * cap;
		else
			self.velocity = dir * dist;
	}
	else
		setorigin( self, goal );

	setorigin( self.owner, self.origin );

	// fade back from walls
	self.ammo_shells = self.ammo_shells + 4.5;
	if (self.ammo_shells > chasecam_dist)
		self.ammo_shells = chasecam_dist;

	// respawn if missile ent. get's hung up
	if( self.oldorigin == self.origin )
	{
		if( dist > 30 )
			self.ammo_nails = self.ammo_nails + 1;
		if( self.ammo_nails > 2 )
		{
			MStart_chase_cam( self.owner, self.owner.goalentity, 0 );
			remove( self );
			return;
		}

	}
	self.oldorigin = self.origin;

};


float Mcam_monster_count = 0;
float Mcam_monster_maxcount;

entity() MChasecam_get_maxcount =
{
	local entity e, ret_e;
	local float flg2;

	e = world;
	ret_e = world;
	Mcam_monster_maxcount = 0;

	do
	{
		e = nextent( e );
		if (e)
		{
			if (e.health > 0)
			{
				flg2 = 0;
				if (e.classname == "player")
				{
					if (e.netname != self.netname) flg2 = 1;
				}

				if (flg2 == 1)
				{
					Mcam_monster_maxcount = Mcam_monster_maxcount + 1;
					if (Mcam_monster_count == Mcam_monster_maxcount)
						ret_e = e;
				}
			}
		}
	}while (e);

	return ret_e;
	
};


//opt:
//0 = back
//1 = forward
void(float opt) Chasecam_find_monster =
{
	local entity e;
	local string s;

	if( (self.speed & CHSCAM_ON) )
	{
		// will be noticed by next think
		// of player's chase cam and fake player entities
		self.speed = self.speed - CHSCAM_ON;


		return;
	}

	// don't run unless on the ground
	if (! (self.flags & FL_ONGROUND) )
		return;


	e = MChasecam_get_maxcount();
	if (opt == 0)
	{
		Mcam_monster_count = Mcam_monster_count - 1;
		if (Mcam_monster_count < 1)
			Mcam_monster_count = Mcam_monster_maxcount;
	}
	else
		Mcam_monster_count = Mcam_monster_count + 1;

	if (Mcam_monster_count > Mcam_monster_maxcount)
		Mcam_monster_count = 1;
	e = MChasecam_get_maxcount();

	if (e != world)
	{
		s = ftos( Mcam_monster_count );
		sprint( self, s );
		sprint( self, " of " );
		s = ftos( Mcam_monster_maxcount );
		sprint( self, s );
		sprint( self, ": " );
		sprint( e, "You are being tracked by " );
		sprint( e, self.netname );
		sprint( e, "\n" );

		sprint( self, e.netname );
		sprint( self, "\n" );

		MStart_chase_cam( self, e, 1 );
	}
	else
	{
		sprint( self, "No other living players in level...\n" );
	}

};

// ### chase cam mod ###
// #####################



/*
 ######################
 ### Multiskin v1.1 ###

 Orig. functions modifyed:
	WEAPONS.QC
		ImpulseCommands
	CLIENT.QC
		PutClientInServer
*/

// opt:
// 0 = up
// 1 = down
/*
void( float opt ) Choose_multiskin =
{
   if (opt == 0)
   {
		self.skin = self.skin + 1;
		if (self.skin == 19)
         self.skin = 0;
   }
   else
   {
		self.skin = self.skin - 1;
      if (self.skin == -1)
         self.skin = 18;
   }

   if (self.skin == 0)
		centerprint(self, "SKIN: the Good Guy Himself (1)");
	else if (self.skin == 1)
      centerprint(self, "SKIN: Duke Nukem 3d (2)");
   else if (self.skin == 2)
      centerprint(self, "SKIN: Mr. Toad (3)");
   else if (self.skin == 3)
      centerprint(self, "SKIN: the Stormtrooper (4)");
   else if (self.skin == 4)
      centerprint(self, "SKIN: Max (5)");
   else if (self.skin == 5)
      centerprint(self, "SKIN: the Terminator (6)");
   else if (self.skin == 6)
      centerprint(self, "SKIN: Judge Dredd (7)");
   else if (self.skin == 7)
      centerprint(self, "SKIN: Camouflaged soldier (8)");
   else if (self.skin == 8)
      centerprint(self, "SKIN: Captain Picard (9)");
   else if (self.skin == 9)
      centerprint(self, "SKIN: the Wizzard (10)");
   else if (self.skin == 10)
      centerprint(self,"SKIN: the Predator (11)");
   else if (self.skin == 11)
      centerprint(self,"SKIN: Skeleton (12)");
   else if (self.skin == 12)
      centerprint(self,"SKIN: Wan-Fu (13)");
   else if (self.skin == 13)
      centerprint(self,"SKIN: Henry Rollins (14)");
   else if (self.skin == 14)
      centerprint(self,"SKIN: He-Man (15)");
   else if (self.skin == 15)
      centerprint(self,"SKIN: Boba (16)");
   else if (self.skin == 16)
      centerprint(self,"SKIN: Superman (17)");
   else if (self.skin == 17)
      centerprint(self,"SKIN: NYPD Cop (18)");
   else if (self.skin == 18)
      centerprint(self,"SKIN: Red/Yellow women dude (19)");
};

// ### Multiskin v1.1 ###
// ######################
*/

/*
 #######################
 ### Hot Key Weapons ###

 Rob Albin, Oct 7 96

 Orig. functions modifyed:
	WEAPONS.QC
		ImpulseCommands

 Abstract:
	Provides hot-key impulses for axe, grenade, and rocket launcher
	that return to previous weapon.
	New cycle weapons impulses that don't select these weapons.

	uses free entity variable (float point of vector) dest_x
	(only used for doors)


 CFG file use:

 alias +axe_hotkey "impulse 41; +attack"
 alias -axe_hotkey "impulse 40; -attack"

 alias +grenade_hotkey "impulse 42; +attack"
 alias -grenade_hotkey "impulse 40; -attack"

 alias +rocket_hotkey "impulse 43; +attack"
 alias -rocket_hotkey "impulse 40; -attack"

 bind "<key>" "+axe_hotkey"
 bind "<key>" "+grenade_hotkey"
 bind "<key>" "+rocket_hotkey"

 // new weapons cycle commands (skips hot-key weapons)
 bind "<key>" "impulse 44"
 bind "<key>" "impulse 45"

*/


// opt:
// 1 = axe
// 2 = grenade launcher
// 3 = rocket launcher
/*
void( float opt ) HotKey_weapon =
{
	local float w;

	if (self.weapon != IT_GRENADE_LAUNCHER &&
		 self.weapon != IT_ROCKET_LAUNCHER  &&
       self.weapon != IT_AXE)
		self.dest_x = self.weapon;

   if (opt == 1)
   {
      w = IT_AXE;
   }
   else if (opt == 2)
   {
      if (! (self.items & IT_GRENADE_LAUNCHER) )
         return;
      w = IT_GRENADE_LAUNCHER;
   }
   else
   {
      if (! (self.items & IT_ROCKET_LAUNCHER) )
         return;
      w = IT_ROCKET_LAUNCHER;
   }

   self.weapon = w;
   W_SetCurrentAmmo();
};

void() HotKey_previous_weapon =
{
   if (! self.dest_x)
      return;

   self.weapon = self.dest_x;
   W_SetCurrentAmmo();
};

void() HotKey_CycleWeaponCommand =
{
   local float w, it, am, c;
   local string s;

   s = " ";
   c = 0;
   w = self.weapon;

   it = self.items;
	self.impulse = 0;
	
	while (1)
	{
		am = 0;

      if (w == IT_LIGHTNING)
		{
         s = "Shotgun";
         w = IT_SHOTGUN;
			if (self.ammo_shells < 1)
				am = 1;
		}
      else if (w == IT_AXE)
		{
         s = "Shotgun";
         w = IT_SHOTGUN;
			if (self.ammo_shells < 1)
				am = 1;
		}
      else if (w == IT_SHOTGUN)
		{
         s = "Super Shotgun";
         w = IT_SUPER_SHOTGUN;
			if (self.ammo_shells < 2)
				am = 1;
		}		
      else if (w == IT_SUPER_SHOTGUN)
		{
         s = "Nailgun";
         w = IT_NAILGUN;
			if (self.ammo_nails < 1)
				am = 1;
		}
      else if (w == IT_NAILGUN)
		{
         s = "Super Nailgun";
         w = IT_SUPER_NAILGUN;
			if (self.ammo_nails < 2)
				am = 1;
		}
      else if (w == IT_SUPER_NAILGUN)
		{
         s = "Lightning Gun";
         w = IT_LIGHTNING;
			if (self.ammo_cells < 1)
				am = 1;
		}
		else if (w == IT_GRENADE_LAUNCHER)
		{
			s = "Lightning Gun";
			w = IT_LIGHTNING;
			if (self.ammo_cells < 1)
				am = 1;
		}
		else if (w == IT_ROCKET_LAUNCHER)
		{
			s = "Lightning Gun";
			w = IT_LIGHTNING;
			if (self.ammo_cells < 1)
				am = 1;
		}

		if ( (it & w) && am == 0)
		{
			self.weapon = w;
			W_SetCurrentAmmo ();

			if ( (self.speed & CHSCAM_ON) )
				centerprint( self, s );

			return;
		}

		if (c > 8) return;
		c = c + 1;
	}

};


void() HotKey_CycleWeaponReverseCommand =
{
	local float w, it, am, c;
	local string s;

	s = " ";
	c = 0;
	w = self.weapon;

	it = self.items;
	self.impulse = 0;

	while (1)
	{
		am = 0;

		if (w == IT_LIGHTNING)
		{
			s = "Super Nailgun";
			w = IT_SUPER_NAILGUN;
			if (self.ammo_nails < 2)
				am = 1;
		}
		else if (w == IT_ROCKET_LAUNCHER)
		{
			s = "Super Nailgun";
			w = IT_SUPER_NAILGUN;
			if (self.ammo_nails < 2)
				am = 1;
		}
		else if (w == IT_GRENADE_LAUNCHER)
		{
			s = "Super Nailgun";
			w = IT_SUPER_NAILGUN;
			if (self.ammo_nails < 2)
				am = 1;
		}
		else if (w == IT_SUPER_NAILGUN)
		{
			s = "Nailgun";
			w = IT_NAILGUN;
			if (self.ammo_nails < 1)
				am = 1;
		}
		else if (w == IT_NAILGUN)
		{
			s = "Super Shotgun";
			w = IT_SUPER_SHOTGUN;
			if (self.ammo_shells < 2)
				am = 1;
		}
		else if (w == IT_SUPER_SHOTGUN)
		{
			s = "Shotgun";
			w = IT_SHOTGUN;
			if (self.ammo_shells < 1)
				am = 1;
		}
		else if (w == IT_SHOTGUN)
		{
			s = "Lightning Gun";
			w = IT_LIGHTNING;
			if (self.ammo_cells < 1)
				am = 1;
		}
		else if (w == IT_AXE)
		{
			s = "Lightning Gun";
			w = IT_LIGHTNING;
			if (self.ammo_cells < 1)
				am = 1;
		}

		if ( (it & w) && am == 0)
		{
			self.weapon = w;
			W_SetCurrentAmmo ();
			if ( (self.speed & CHSCAM_ON) )
				centerprint( self, s );
			return;
		}

		if (c > 8) return;
		c = c + 1;
	}

};
*/
// ### Hot Key Weapons mod ###
// ###########################


// ######################
// ### rune cheat mod ###

/*
void() GiveFirstThreeRunes =
{
	serverflags = serverflags | 14;

};*/

// ### rune cheat mod ###
// ######################


