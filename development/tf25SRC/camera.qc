/*======================================================
	CAMERA.QC			TeamFortress v2.5	

	(c) TeamFortress Software Pty Ltd 	29/2/97
========================================================
Functions for the CAMERA behaviour
========================================================*/
// Functions outside this file

// Functions inside this file
void() CamLock;
void() CamDistLock;
void() CamVecLock; 
void() CamAngleLock;
void() CamRevAngleLock;
void() CamProjectileLock;
void() CamProjectileZoom;
void() CamProjectileLockOn;
void() CamProjectileLockOff;
void() CamOffset;
void() CamDrop;
void() fadetoblack;
void() fadefromblack;
void() fadetowhite;
void() fadefromwhite;

//======================================================
void() CamLock = 
{
	local entity te;

	// CameraMan special locks onto an entity
	if (self.enemy == world)
	{
		// Find the entity which matches our netname
		te = find(world, netname, self.netname);
		while (te)
		{
			if (te != self)
			{
				sprint3(self, #PRINT_HIGH, "Locked onto ", te.netname, "\n");
				self.enemy = te;
				self.heat = vlen(self.enemy.origin - self.origin);
			}

			te = find(te, netname, self.netname);
		}

		if (self.enemy == world)
			sprint2(self, #PRINT_HIGH, te.netname, " not found.\n");
	}
	else
	{
		sprint(self, #PRINT_HIGH, "Removed Lock\n");
		self.enemy = world;
	}
};

//======================================================
void() CamDistLock = 
{
	if (self.tfstate & #TFSTATE_ZOOMOFF)
	{
		sprint(self, #PRINT_HIGH, "Distance Lock OFF.\n");
		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_ZOOMOFF);
	}
	else
	{
		sprint(self, #PRINT_HIGH, "Distance Lock ON.\n");
		self.tfstate = self.tfstate | #TFSTATE_ZOOMOFF;
		if (self.enemy)
			self.camdist = vlen(self.enemy.origin - self.origin);
	}
};

//======================================================
void() CamVecLock =
{
	if (self.tfstate & #TFSTATE_AIMING)
	{
		sprint(self, #PRINT_HIGH, "Vector Lock OFF.\n");
		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_AIMING);
	}
	else
	{
		// Make sure Vector Lock isn't on
		if (self.tfstate & #TFSTATE_TRANQUILISED)
		{
			sprint(self, #PRINT_HIGH, "Angle Lock OFF.\n");
			self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_TRANQUILISED);
		}
		// Make sure Distance Lock is on
		if (!(self.tfstate & #TFSTATE_ZOOMOFF))
		{
			sprint(self, #PRINT_HIGH, "Vector And Distance Lock ON.\n");
			self.tfstate = self.tfstate | #TFSTATE_ZOOMOFF;
			if (self.enemy)
				self.camdist = vlen(self.enemy.origin - self.origin);
		}
		else
		{
			sprint(self, #PRINT_HIGH, "Vector Lock ON.\n");
		}
		self.tfstate = self.tfstate | #TFSTATE_AIMING;
		if (self.enemy)
		{
			self.camangle = self.origin - self.enemy.origin;
			self.camangle_z = 0 - self.camangle_z;
			self.camangle = vectoangles(self.camangle);
		}
	}
};

//======================================================
void() CamAngleLock = 
{
	local vector enemyang;

	if (self.tfstate & #TFSTATE_TRANQUILISED)
	{
		sprint(self, #PRINT_HIGH, "Angle Lock OFF.\n");
		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_TRANQUILISED);
	}
	else
	{
		// Make sure Vector Lock isn't on
		if (self.tfstate & #TFSTATE_AIMING)
		{
			sprint(self, #PRINT_HIGH, "Vector Lock OFF.\n");
			self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_AIMING);
		}
		// Make sure Distance Lock is on
		if (!(self.tfstate & #TFSTATE_ZOOMOFF))
		{
			sprint(self, #PRINT_HIGH, "Angle And Distance Lock ON.\n");
			self.tfstate = self.tfstate | #TFSTATE_ZOOMOFF;
			if (self.enemy)
				self.camdist = vlen(self.enemy.origin - self.origin);
		}
		else
		{
			sprint(self, #PRINT_HIGH, "Angle Lock ON.\n");
		}
		self.tfstate = self.tfstate | #TFSTATE_TRANQUILISED;
		if (self.enemy)
		{
			enemyang = self.enemy.angles;
			enemyang_z = 0 - enemyang_z;
			self.camangle = self.origin - self.enemy.origin;
			self.camangle_z = 0 - self.camangle_z;
			self.camangle = vectoangles(self.camangle);
			self.camangle = self.camangle - enemyang;
		}
	}
};

//======================================================
void() CamRevAngleLock = 
{
	local vector enemyang;

	if (self.tfstate & #TFSTATE_INVINCIBLE)
	{
		sprint(self, #PRINT_HIGH, "Reverse Angle Lock OFF.\n");
		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_INVINCIBLE);
	}
	else
	{
		// Make sure Vector Lock isn't on
		if (self.tfstate & #TFSTATE_AIMING)
		{
			sprint(self, #PRINT_HIGH, "Vector Lock OFF.\n");
			self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_AIMING);
		}
		// Make sure Angle Lock isn't on
		if (self.tfstate & #TFSTATE_TRANQUILISED)
		{
			sprint(self, #PRINT_HIGH, "Angle Lock OFF.\n");
			self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_TRANQUILISED);
		}
		// Make sure Distance Lock is on
		if (!(self.tfstate & #TFSTATE_ZOOMOFF))
		{
			sprint(self, #PRINT_HIGH, "Reverse Angle And Distance Lock ON.\n");
			self.tfstate = self.tfstate | #TFSTATE_ZOOMOFF;
			if (self.enemy)
				self.camdist = vlen(self.enemy.origin - self.origin);
		}
		else
		{
			sprint(self, #PRINT_HIGH, "Reverse Angle Lock ON.\n");
		}
		self.tfstate = self.tfstate | #TFSTATE_INVINCIBLE;
		if (self.enemy)
		{
			enemyang = self.enemy.angles;
			enemyang_z = 0 - enemyang_z;
			self.camangle = self.origin - self.enemy.origin;
			self.camangle_z = 0 - self.camangle_z;
			self.camangle = vectoangles(self.camangle);
			self.camangle = self.camangle - enemyang;
		}
	}
};

//======================================================
void() CamProjectileLock = 
{
	local entity te;

	if (self.tfstate & #TFSTATE_BURNING)
	{
		sprint(self, #PRINT_HIGH, "Projectile Lock OFF.\n");
		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_BURNING);

		live_camera = #FALSE;
		te = find(world, classname, "player");
		while ((te != world) && (live_camera == #FALSE))
		{
			if (te.playerclass == #PC_UNDEFINED && te.tfstate & #TFSTATE_BURNING)
				live_camera = #TRUE;

			te = find(te, classname, "player");
		}
	}
	else
	{
		sprint(self, #PRINT_HIGH, "Projectile Lock ON.\n");
		self.tfstate = self.tfstate | #TFSTATE_BURNING;
		live_camera = #TRUE;
	}
};

//======================================================
void() CamProjectileZoom =
{
	if (self.tfstate & #TFSTATE_RADSUIT)
	{
		sprint(self, #PRINT_HIGH, "Projectile Zoom OFF.\n");
		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_RADSUIT);
	}
	else
	{
		sprint(self, #PRINT_HIGH, "Projectile Zoom ON.\n");
		self.tfstate = self.tfstate | #TFSTATE_RADSUIT;
	}
};

//======================================================
void() CamProjectileLockOn =
{
	local entity te;
	local float lockon;
	local vector enemyang;
	
	lockon = #FALSE;
	te = find(world, classname, "player");
	while (te)
	{
		// Is it a camera wih projectile lock on?
		if (te.playerclass == #PC_UNDEFINED && te.tfstate & #TFSTATE_BURNING)
		{
			if (te.enemy != world)
			{
				if (te.enemy == self)
					lockon = #TRUE;
			}
			else
			{
				// See if the camera is within sight
				traceline(te.origin, self.origin, #FALSE, te);
				if (trace_ent == self)
					lockon = #TRUE;
			}

			if (lockon)
			{
				// Turn off the camera's projectile lock
				te.tfstate = te.tfstate - (te.tfstate & #TFSTATE_BURNING);
				sprint(te, #PRINT_HIGH, "Projectile Locked!\n");
				te.enemy = newmis;
				newmis.enemy = te;

				// If Projectile Zoom is on, get into position
				if (te.tfstate & #TFSTATE_RADSUIT)
				{
					// Move the camera 
					enemyang = normalize(te.enemy.velocity) * 20;
					enemyang_z = 0 - enemyang_z;
					setorigin(te, te.enemy.origin - enemyang);

					// Turn on Distance Lock
					te.tfstate = te.tfstate | #TFSTATE_ZOOMOFF;
					te.camdist = 20;

					// Angle
					te.camangle = vectoangles(te.enemy.velocity);
					te.camangle_z = 0 - te.camangle_z;
				}
			}
		}

		te = find(te, classname, "player");
	}
};

//======================================================
void() CamProjectileLockOff =
{
	sprint(self.enemy, #PRINT_HIGH, "Removed Lock\n");
	self.enemy.enemy = world;
};

//======================================================
void() CamOffset =
{
	if (self.view_ofs == '0 0 22')
		self.view_ofs = '0 0 18';
	else if (self.view_ofs == '0 0 18')
		self.view_ofs = '0 0 13';
	else if (self.view_ofs == '0 0 13')
		self.view_ofs = '0 0 7';
	else if (self.view_ofs == '0 0 7')
		self.view_ofs = '0 0 1';
	else if (self.view_ofs == '0 0 1')
		self.view_ofs = '0 0 -10';
	else if (self.view_ofs == '0 0 -10')
		self.view_ofs = '0 0 -18';
	else
		self.view_ofs = '0 0 22';
};

//======================================================
void() CamDrop =
{
	local entity te, prevte, cam;
	local float tf;
	local string st;

	cam = spawn();
	cam.classname = "camera";
	cam.origin = self.origin + self.view_ofs;
	cam.angles = self.angles;
	setmodel(cam,"progs/spike.mdl");

	tf = 1;
	prevte = self;
	te = self.camera_list;
	while (te != world)
	{
		tf = tf + 1;
		prevte = te;
		te = te.camera_list;
	}
	prevte.camera_list = cam;

	st = ftos(tf);
	sprint3(self, #PRINT_HIGH, "Camera ", st, " dropped.\n");
};

//======================================================
// Fade functions from the brilliant 
// Operation Bayshield movie, by the Undead Clan.
// Cameraman must be the server to use them.
void() fadetoblack =
{
	local float fade;
	local string x;

	fade = 10;
	while( fade <= 250 )
	{
		x = ftos( fade );
		stuffcmd( self, "v_cshift 0 0 0 " );
		stuffcmd( self, x );
		stuffcmd( self, ";wait\n" );
		fade = fade + 10;
	}
	stuffcmd( self, "v_cshift 0 0 0 255\n" );
};

void() fadefromblack =
{
	local float fade;
	local string x;

	fade = 250;
	while( fade >= 0 )
	{
		x = ftos( fade );
		stuffcmd( self, "v_cshift 0 0 0 " );
		stuffcmd( self, x );
		stuffcmd( self, ";wait\n" );
		fade = fade - 10;
	}
	stuffcmd( self, "v_cshift 0 0 0 0\n" );
};


void() fadetowhite =
{
	local float fade;
	local string x;

	fade = 10;
	while( fade <= 250 )
	{
		x = ftos( fade );
		stuffcmd( self, "v_cshift 255 255 255 " );
		stuffcmd( self, x );
		stuffcmd( self, ";wait\n" );
		fade = fade + 10;
	}
	stuffcmd( self, "v_cshift 255 255 255 255\n" );
};

void() fadefromwhite =
{
	local float fade;
	local string x;

	fade = 250;
	while( fade >= 0 )
	{
		x = ftos( fade );
		stuffcmd( self, "v_cshift 255 255 255 " );
		stuffcmd( self, x );
		stuffcmd( self, ";wait\n" );
		fade = fade - 10;
	}
	stuffcmd( self, "v_cshift 0 0 0 0\n" );
};
