/*
 *  QWProgs-MegaTF_C
 *  Copyright (C) 2006  XavioR
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *
 *  $Id: common.c,v 1.00 2006/09/15 XavioR Exp $
 */

/*	=========
	Common MTF Functions
				========  */
#include "g_local.h"

// lay mode sizes
void lay ( )
{
	setsize ( self, -16, -16, -24, 16, 16, 8 );
};

void unlay ( )
{
	setsize ( self, -16, -16, -24, 16, 16, 32 );
};

// Death message wrapper
void mtf_deathmsg ( float dmsg )
{
	// add function here
}

// explosion stuff
// explosion sequence (used by proxi explosion funct)
void    s2_explode1(  );
void    s2_explode2(  );
void    s2_explode3(  );
void    s2_explode4(  );
void    s2_explode5(  );
void    s2_explode6(  );
void    s2_explode7(  );
void    s2_explode8(  );
void	check_water(  );
void s2_explode1(  )
{
	self->s.v.frame = 0;
	self->s.v.think = ( func_t ) s2_explode2;
	self->s.v.nextthink = g_globalvars.time + 0.1;
	check_water();
}

void s2_explode2(  )
{
	self->s.v.frame = 1;
	self->s.v.think = ( func_t ) s2_explode3;
	self->s.v.nextthink = g_globalvars.time + 0.1;
	check_water();
}

void s2_explode3(  )
{
	self->s.v.frame = 2;
	self->s.v.think = ( func_t ) s2_explode4;
	self->s.v.nextthink = g_globalvars.time + 0.1;
	check_water();
}

void s2_explode4(  )
{
	self->s.v.frame = 3;
	self->s.v.think = ( func_t ) s2_explode5;
	self->s.v.nextthink = g_globalvars.time + 0.1;
	check_water();
}

void s2_explode5(  )
{
	self->s.v.frame = 4;
	self->s.v.think = ( func_t ) s2_explode6;
	self->s.v.nextthink = g_globalvars.time + 0.1;
	check_water();
}

void s2_explode6(  )
{
	self->s.v.frame = 5;
	self->s.v.think = ( func_t ) s2_explode7;
	self->s.v.nextthink = g_globalvars.time + 0.1;
	check_water();
}

void s2_explode7(  )
{
	self->s.v.frame = 5;
	self->s.v.think = ( func_t ) s2_explode8;
	self->s.v.nextthink = g_globalvars.time + 0.1;
	check_water();
}

void s2_explode8(  )
{
	self->s.v.frame = 5;
	self->s.v.think = ( func_t ) SUB_Remove;
	self->s.v.nextthink = g_globalvars.time + 0.1;
	check_water();
}

void make_explosion ( )
{

	newmis = spawn ( );
	setmodel( newmis, "progs/s_expl.spr" );
	setorigin( newmis, PASSVEC3( self->s.v.origin ) );
	newmis->s.v.movetype = 8;
	newmis->s.v.solid = SOLID_NOT;
	sound ( newmis, 0, "weapons/flmfire2.wav", 1, 1 );
	newmis->s.v.effects = 8;
	newmis->s.v.velocity[2] = ( g_random () * 250.000000 );
	newmis->s.v.nextthink = g_globalvars.time + 0.05;
	newmis->s.v.think = ( func_t ) s2_explode1;
	newmis->s.v.nextthink = g_globalvars.time + 0.05;
};


