export Reset_Grapple
code
proc Reset_Grapple 4 20
file "..\src\hook.c"
line 41
;1:/*
;2: *  QWProgs-TF2003
;3: *  Copyright (C) 2004  [sd] angel
;4: *
;5: *
;6: *  This program is free software; you can redistribute it and/or modify
;7: *  it under the terms of the GNU General Public License as published by
;8: *  the Free Software Foundation; either version 2 of the License, or
;9: *  (at your option) any later version.
;10: *
;11: *  This program is distributed in the hope that it will be useful,
;12: *  but WITHOUT ANY WARRANTY; without even the implied warranty of
;13: *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;14: *  GNU General Public License for more details.
;15: *
;16: *  You should have received a copy of the GNU General Public License
;17: *  along with this program; if not, write to the Free Software
;18: *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;19: *
;20: *
;21: *  $Id: hook.c,v 1.4 2005/05/16 06:31:38 AngelD Exp $
;22: */
;23:/*
;24:===========================================================================
;25:Quakeworld-friendly grapple hook code by Wedge (Steve Bond)
;26:           visit Quake Command http://www.nuc.net/quake 
;27:
;28:
;29:Original 'Morning Star' (Grapple Hook) by "Mike" <amichael@asu.alasu.edu> 
;30:I took care to preserve the speed and damage values of the original
;31:Morning Star. Depending on latency, performance should be near exact.
;32:===========================================================================
;33:*/
;34:
;35:#include "g_local.h"
;36://
;37:// Reset_Grapple - Removes the hook and resets its owner's state.
;38://                 expects a pointer to the hook
;39://
;40:void Reset_Grapple( gedict_t * rhook )
;41:{
line 42
;42:	gedict_t *owner = PROG_TO_EDICT( rhook->s.v.owner );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 44
;43:
;44:	sound( owner, 1, "doors/ddoor2.wav", 1, 0 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $12
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 45
;45:	owner->on_hook = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1444
ADDP4
CNSTI4 0
ASGNI4
line 46
;46:	owner->hook_out = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1436
ADDP4
CNSTI4 0
ASGNI4
line 47
;47:	owner->fire_held_down = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1448
ADDP4
CNSTI4 0
ASGNI4
line 48
;48:	owner->s.v.weaponframe = 0;
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 49
;49:	rhook->s.v.think = ( func_t ) SUB_Remove;
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 50
;50:	rhook->s.v.nextthink = g_globalvars.time;
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 51
;51:}
LABELV $11
endproc Reset_Grapple 4 20
export Reset_My_Grapple
proc Reset_My_Grapple 8 20
line 54
;52:
;53:void Reset_My_Grapple ( )
;54:{
line 55
;55:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 57
;56:
;57:	sound( owner, 1, "doors/ddoor2.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $12
ARGP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 58
;58:	owner->on_hook = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1444
ADDP4
CNSTI4 0
ASGNI4
line 59
;59:	owner->hook_out = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1436
ADDP4
CNSTI4 0
ASGNI4
line 60
;60:	owner->fire_held_down = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1448
ADDP4
CNSTI4 0
ASGNI4
line 61
;61:	owner->s.v.weaponframe = 0;
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 63
;62://	self.owner.off_hook = time + 1;
;63:	self->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 64
;64:	self->s.v.nextthink = g_globalvars.time;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 65
;65:}
LABELV $14
endproc Reset_My_Grapple 8 20
export Grapple_Track
proc Grapple_Track 28 8
line 74
;66:
;67://
;68:// Grapple_Track - Constantly updates the hook's position relative to
;69://                 what it's hooked to. Inflicts damage if attached to
;70://                 a player that is not on the same team as the hook's
;71://                 owner.
;72://
;73:void Grapple_Track(  )
;74:{
line 76
;75://	vec3_t  spray;
;76:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 77
;77:	gedict_t *enemy = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 80
;78:
;79:	// drop the hook if owner is dead or has released the button
;80:	if ( !owner->on_hook || owner->s.v.health <= 0 )
ADDRLP4 4
INDIRP4
CNSTI4 1444
ADDP4
INDIRI4
CNSTI4 0
EQI4 $19
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $17
LABELV $19
line 81
;81:	{
line 82
;82:		Reset_Grapple( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 Reset_Grapple
CALLV
pop
line 83
;83:		return;
ADDRGP4 $16
JUMPV
LABELV $17
line 88
;84:	}
;85:        // If the hook is not attached to the player, constantly copy
;86:        // copy the target's velocity. Velocity copying DOES NOT work properly
;87:        // for a hooked client. 
;88:	if ( strneq( enemy->s.v.classname, "player" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $22
ARGP4
ADDRLP4 12
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $20
line 89
;89:		VectorCopy( enemy->s.v.velocity, self->s.v.velocity );
ADDRLP4 16
CNSTI4 180
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
CNSTI4 184
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
CNSTI4 188
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ASGNF4
LABELV $20
line 90
;90:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 91
;91:}
LABELV $16
endproc Grapple_Track 28 8
export MakeLink
proc MakeLink 12 28
line 97
;92:
;93://
;94:// MakeLink - spawns the chain link entities
;95://
;96:gedict_t *MakeLink( )
;97:{
line 98
;98:	newmis = spawn(  );
ADDRLP4 0
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 0
INDIRP4
ASGNP4
line 100
;99:
;100:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 101
;101:	newmis->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 102
;102:	newmis->s.v.solid = SOLID_NOT;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 103
;103:	newmis->s.v.owner = EDICT_TO_PROG( self ); // SELF is the hook!
ADDRGP4 newmis
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 107
;104:
;105:	//SetVector( newmis->s.v.avelocity, 200, 200, 200 );
;106:
;107:	setmodel( newmis, "progs/rope.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $26
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 108
;108:	vectoangles( self->s.v.velocity, newmis->s.v.angles );
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 newmis
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 110
;109:
;110:	setorigin( newmis, PASSVEC3( self->s.v.origin ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 111
;111:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 113
;112:
;113:	return newmis;
ADDRGP4 newmis
INDIRP4
RETP4
LABELV $24
endproc MakeLink 12 28
export Remove_Chain
proc Remove_Chain 4 0
line 123
;114:}
;115:
;116://
;117:// Remove_Chain - Removes all chain link entities; this is a separate
;118://                function because CLIENT also needs to be able
;119://                to remove the chain. Only one function required to
;120://                remove all links.
;121://
;122:void Remove_Chain(  )
;123:{
line 126
;124:	gedict_t *goalentity;
;125:
;126:	self->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 127
;127:	self->s.v.nextthink = g_globalvars.time;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 128
;128:	if ( self->s.v.goalentity )
ADDRGP4 self
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 0
EQI4 $29
line 129
;129:	{
line 130
;130:		goalentity = PROG_TO_EDICT( self->s.v.goalentity );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 131
;131:		goalentity->s.v.think = ( func_t ) SUB_Remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 132
;132:		goalentity->s.v.nextthink = g_globalvars.time;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 133
;133:		if ( goalentity->s.v.goalentity )
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 0
EQI4 $32
line 134
;134:		{
line 135
;135:			goalentity = PROG_TO_EDICT( goalentity->s.v.goalentity );
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 136
;136:			goalentity->s.v.think = ( func_t ) SUB_Remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 137
;137:			goalentity->s.v.nextthink = g_globalvars.time;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 138
;138:		}
LABELV $32
line 139
;139:	}
LABELV $29
line 140
;140:}
LABELV $27
endproc Remove_Chain 4 0
export Update_Chain
proc Update_Chain 76 16
line 148
;141:
;142://
;143:// Update_Chain - Repositions the chain links each frame. This single function
;144://                maintains the positions of all of the links. Only one link
;145://                is thinking every frame. 
;146://
;147:void Update_Chain(  )
;148:{
line 151
;149:	vec3_t	t1,t2,t3;
;150:	vec3_t  temp/*, v*/;
;151:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 153
;152:
;153:	if ( !owner->hook_out )
ADDRLP4 0
INDIRP4
CNSTI4 1436
ADDP4
INDIRI4
CNSTI4 0
NEI4 $36
line 154
;154:	{
line 155
;155:		self->s.v.think = ( func_t ) Remove_Chain;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 Remove_Chain
CVPU4 4
CVUI4 4
ASGNI4
line 156
;156:		self->s.v.nextthink = g_globalvars.time;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 157
;157:		return;
ADDRGP4 $35
JUMPV
LABELV $36
line 159
;158:	}
;159:	VectorSubtract( owner->hook->s.v.origin, owner->s.v.origin, temp );
ADDRLP4 56
CNSTI4 156
ASGNI4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1440
ADDP4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64
CNSTI4 160
ASGNI4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 1440
ADDP4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 72
CNSTI4 164
ASGNI4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 1440
ADDP4
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 163
;160:
;161:        // These numbers are correct assuming 3 links.
;162:        // 4 links would be *20 *40 *60 and *80
;163:	t1[0] = temp[0] * 0.3 + owner->s.v.origin[0];t1[1] = temp[1] * 0.3 + owner->s.v.origin[1];t1[2] = temp[2] * 0.3 + owner->s.v.origin[2];
ADDRLP4 16
CNSTF4 1050253722
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+4
CNSTF4 1050253722
ADDRLP4 4+4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+8
CNSTF4 1050253722
ADDRLP4 4+8
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDF4
ASGNF4
line 164
;164:	t2[0] = temp[0] * 0.6 + owner->s.v.origin[0];t2[1] = temp[1] * 0.6 + owner->s.v.origin[1];t2[2] = temp[2] * 0.6 + owner->s.v.origin[2];
ADDRLP4 28
CNSTF4 1058642330
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28+4
CNSTF4 1058642330
ADDRLP4 4+4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28+8
CNSTF4 1058642330
ADDRLP4 4+8
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDF4
ASGNF4
line 165
;165:	t3[0] = temp[0] * 0.9 + owner->s.v.origin[0];t3[1] = temp[1] * 0.9 + owner->s.v.origin[1];t3[2] = temp[2] * 0.9 + owner->s.v.origin[2];
ADDRLP4 40
CNSTF4 1063675494
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 40+4
CNSTF4 1063675494
ADDRLP4 4+4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 40+8
CNSTF4 1063675494
ADDRLP4 4+8
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDF4
ASGNF4
line 166
;166:	setorigin( self, PASSVEC3( t1 ) );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16+4
INDIRF4
ARGF4
ADDRLP4 16+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 167
;167:	setorigin( PROG_TO_EDICT( self->s.v.goalentity ), PASSVEC3( t2 ) );
ADDRGP4 self
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28+4
INDIRF4
ARGF4
ADDRLP4 28+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 168
;168:	setorigin( PROG_TO_EDICT( PROG_TO_EDICT(self->s.v.goalentity)->s.v.goalentity ), PASSVEC3( t3 ) );
ADDRGP4 self
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+340
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40+4
INDIRF4
ARGF4
ADDRLP4 40+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 169
;169:	vectoangles( temp, self->s.v.angles );
ADDRLP4 4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 170
;170:	vectoangles( temp, PROG_TO_EDICT( self->s.v.goalentity )->s.v.angles );
ADDRLP4 4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+80
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 171
;171:	vectoangles( temp, PROG_TO_EDICT( PROG_TO_EDICT(self->s.v.goalentity)->s.v.goalentity )->s.v.angles );
ADDRLP4 4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+340
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+80
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 174
;172:
;173:	//self.nextthink = time + 0.2;
;174:	self->s.v.nextthink = g_globalvars.time + 0.2;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 190
;175:/*	VectorScale( temp, 0.25, v );
;176:	VectorAdd( v, owner->s.v.origin, v );
;177:	setorigin( self, PASSVEC3( v ) );
;178:
;179:	VectorScale( temp, 0.5, v );
;180:	VectorAdd( v, owner->s.v.origin, v );
;181:	setorigin( self, PASSVEC3( v ) );
;182:
;183:	VectorScale( temp, 0.75, v );
;184:	VectorAdd( v, owner->s.v.origin, v );
;185:	setorigin( self, PASSVEC3( v ) );
;186:
;187:	vectoangles( temp, newmis->s.v.angles );
;188:
;189:	self->s.v.nextthink = g_globalvars.time + 0.1;*/
;190:}
LABELV $35
endproc Update_Chain 76 16
export Build_Chain
proc Build_Chain 20 0
line 196
;191:
;192://
;193:// Build_Chain - Builds the chain (linked list)
;194://
;195:void Build_Chain(  )
;196:{
line 199
;197:	gedict_t *goalentity;
;198:
;199:	goalentity = MakeLink(  );
ADDRLP4 4
ADDRGP4 MakeLink
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 200
;200:	self->s.v.goalentity = EDICT_TO_PROG( goalentity );
ADDRGP4 self
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 201
;201:	goalentity->s.v.think = ( func_t ) Update_Chain;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 Update_Chain
CVPU4 4
CVUI4 4
ASGNI4
line 202
;202:	goalentity->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 203
;203:	goalentity->s.v.owner = self->s.v.owner;
ADDRLP4 8
CNSTI4 480
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 205
;204:
;205:	goalentity->s.v.goalentity = EDICT_TO_PROG( MakeLink(  ) );
ADDRLP4 12
ADDRGP4 MakeLink
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 206
;206:	PROG_TO_EDICT( goalentity->s.v.goalentity )->s.v.goalentity = EDICT_TO_PROG( MakeLink(  ) );
ADDRLP4 16
ADDRGP4 MakeLink
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+340
ADDP4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 207
;207:}
LABELV $68
endproc Build_Chain 20 0
export Check_Overhead
proc Check_Overhead 40 32
line 215
;208:
;209://
;210:// Check_Overhead - Makes sure there is sufficient headroom above the player
;211://                  so that setorigin doesn't stick them into a wall. I tried
;212://                  to compare pointcontents, but that was too flaky.
;213://
;214:int Check_Overhead(  )
;215:{
line 219
;216:	vec3_t  src;
;217:	vec3_t  end;
;218:	vec3_t  tmp;
;219:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 221
;220:
;221:	makevectors( owner->s.v.angles );
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 229
;222:
;223:        // The following comparisons could be optimized by doing away with
;224:        // SRC and END, and plugging the values directly into the traceline
;225:        // function calls. Using SRC and END made debugging easier. You
;226:        // decide if it's worth it.
;227:
;228:        // quick check right above head
;229:	VectorCopy( owner->s.v.origin, src );
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 230
;230:	VectorCopy( owner->s.v.origin, end );
ADDRLP4 12
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 231
;231:	src[2] -= 24;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 232
;232:	end[2] -= 24;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 234
;233:
;234:	traceline( PASSVEC3( src ), PASSVEC3( end ), 0, owner );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 235
;235:	if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $83
line 236
;236:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $72
JUMPV
LABELV $83
line 238
;237:
;238:	VectorCopy( owner->s.v.origin, src );
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 239
;239:	VectorCopy( owner->s.v.origin, end );
ADDRLP4 12
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 240
;240:	src[2] -= 24;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 241
;241:	end[2] -= 24;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 242
;242:	VectorScale( g_globalvars.v_forward, 16, tmp );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1098907648
ARGF4
ADDRLP4 28
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 243
;243:	VectorSubtract( src, tmp, src );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 28+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 28+8
INDIRF4
SUBF4
ASGNF4
line 244
;244:	VectorCopy( src, end );
ADDRLP4 12
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 0+8
INDIRF4
ASGNF4
line 245
;245:	end[2] += 58;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1114112000
ADDF4
ASGNF4
line 246
;246:	traceline( PASSVEC3( src ), PASSVEC3( end ), 0, owner );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 247
;247:	if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $108
line 248
;248:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $72
JUMPV
LABELV $108
line 250
;249:
;250:	VectorCopy( owner->s.v.origin, src );
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 251
;251:	VectorCopy( owner->s.v.origin, end );
ADDRLP4 12
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 252
;252:	src[2] -= 24;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 253
;253:	end[2] -= 24;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 254
;254:	VectorScale( g_globalvars.v_forward, 16, tmp );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1098907648
ARGF4
ADDRLP4 28
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 255
;255:	VectorAdd( src, tmp, src );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDF4
ASGNF4
line 256
;256:	VectorCopy( src, end );
ADDRLP4 12
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 0+8
INDIRF4
ASGNF4
line 257
;257:	end[2] += 58;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1114112000
ADDF4
ASGNF4
line 258
;258:	traceline( PASSVEC3( src ), PASSVEC3( end ), 0, owner );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 259
;259:	if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $133
line 260
;260:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $72
JUMPV
LABELV $133
line 262
;261:
;262:	VectorCopy( owner->s.v.origin, src );
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 263
;263:	VectorCopy( owner->s.v.origin, end );
ADDRLP4 12
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 264
;264:	src[2] -= 24;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 265
;265:	end[2] -= 24;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 266
;266:	VectorScale( g_globalvars.v_right, 16, tmp );
ADDRGP4 g_globalvars+252
ARGP4
CNSTF4 1098907648
ARGF4
ADDRLP4 28
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 267
;267:	VectorSubtract( src, tmp, src );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 28+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 28+8
INDIRF4
SUBF4
ASGNF4
line 268
;268:	VectorCopy( src, end );
ADDRLP4 12
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 0+8
INDIRF4
ASGNF4
line 269
;269:	end[2] += 58;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1114112000
ADDF4
ASGNF4
line 270
;270:	traceline( PASSVEC3( src ), PASSVEC3( end ), 0, owner );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 271
;271:	if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $158
line 272
;272:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $72
JUMPV
LABELV $158
line 274
;273:
;274:	VectorCopy( owner->s.v.origin, src );
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 275
;275:	VectorCopy( owner->s.v.origin, end );
ADDRLP4 12
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 276
;276:	src[2] -= 24;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 277
;277:	end[2] -= 24;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 278
;278:	VectorScale( g_globalvars.v_right, 16, tmp );
ADDRGP4 g_globalvars+252
ARGP4
CNSTF4 1098907648
ARGF4
ADDRLP4 28
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 279
;279:	VectorAdd( src, tmp, src );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDF4
ASGNF4
line 280
;280:	VectorCopy( src, end );
ADDRLP4 12
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 0+8
INDIRF4
ASGNF4
line 281
;281:	end[2] += 58;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1114112000
ADDF4
ASGNF4
line 282
;282:	traceline( PASSVEC3( src ), PASSVEC3( end ), 0, owner );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 283
;283:	if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $183
line 284
;284:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $72
JUMPV
LABELV $183
line 286
;285:
;286:	return 1;
CNSTI4 1
RETI4
LABELV $72
endproc Check_Overhead 40 32
export Anchor_Grapple
proc Anchor_Grapple 48 20
line 293
;287:}
;288:
;289://
;290:// Anchor_Grapple - Tries to anchor the grapple to whatever it touches
;291://
;292:void Anchor_Grapple(  )
;293:{
line 294
;294:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 297
;295:	int     test;
;296:
;297:	if ( other == owner )
ADDRGP4 other
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
NEU4 $187
line 298
;298:		return;
ADDRGP4 $186
JUMPV
LABELV $187
line 304
;299:
;300:        // DO NOT allow the grapple to hook to any projectiles, no matter WHAT!
;301:        // if you create new types of projectiles, make sure you use one of the
;302:        // classnames below or write code to exclude your new classname so
;303:        // grapples will not stick to them.
;304:	if ( streq( other->s.v.classname, "missile" ) || streq( other->s.v.classname, "grenade" )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $191
ARGP4
ADDRLP4 8
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $197
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $192
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $197
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $193
ARGP4
ADDRLP4 16
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $197
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRLP4 20
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $189
LABELV $197
line 306
;305:	     || streq( other->s.v.classname, "spike" ) || streq( other->s.v.classname, "hook" ) )
;306:		return;
ADDRGP4 $186
JUMPV
LABELV $189
line 309
;307:
;308:        // Don't stick the the sky.
;309:	if ( trap_pointcontents( PASSVEC3( self->s.v.origin ) ) == CONTENT_SKY )
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 -6
NEI4 $198
line 310
;310:	{
line 311
;311:		Reset_Grapple( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 Reset_Grapple
CALLV
pop
line 312
;312:		return;
ADDRGP4 $186
JUMPV
LABELV $198
line 320
;313:	}
;314:	// Cannot hurt players with the grapple
;315://	if ( streq( other->s.v.classname, "player" ) )
;316://	{
;317://		Reset_Grapple( self );
;318://		return;
;319://	} else
;320:	{
line 325
;321:		
;322:                // One point of damage inflicted upon impact. Subsequent
;323:                // damage will only be done to PLAYERS... this way secret
;324:                // doors and triggers will only be damaged once.
;325:		if ( other->s.v.takedamage ) {
ADDRGP4 other
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $200
line 326
;326:			T_Damage( other, self, owner, 1 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 327
;327:			sound( self, 1, "shambler/smack.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $202
ARGP4
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 328
;328:		}
ADDRGP4 $201
JUMPV
LABELV $200
line 330
;329:		else
;330:			sound( self, 1, "player/axhit2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $203
ARGP4
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
LABELV $201
line 332
;331:
;332:		SetVector( self->s.v.velocity, 0, 0, 0 );
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 0
ASGNF4
line 333
;333:		SetVector( self->s.v.avelocity, 0, 0, 0 );
ADDRGP4 self
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 0
ASGNF4
line 334
;334:	}
line 339
;335:        // conveniently clears the sound channel of the CHAIN1 sound,
;336:        // which is a looping sample and would continue to play. Tink1 is
;337:        // the least offensive choice, as NULL.WAV loops and clogs the
;338:        // channel with silence
;339:	sound( self, 1, "weapons/bounce.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $204
ARGP4
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 340
;340:	sound( owner, 0, "weapons/retract.wav", 0.8, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $205
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 341
;341:	owner->s.v.ammo_cells = 0;
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
CNSTF4 0
ASGNF4
line 342
;342:	if ( !owner->s.v.button0 )
ADDRLP4 0
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
CNSTF4 0
NEF4 $206
line 343
;343:	{
line 344
;344:		Reset_Grapple( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 Reset_Grapple
CALLV
pop
line 345
;345:		return;
ADDRGP4 $186
JUMPV
LABELV $206
line 350
;346:	}
;347:        // our last chance to avoid being picked up off of the ground.
;348:        // check over the client's head to make sure there is one unit
;349:        // clearance so we can lift him off of the ground.
;350:	test = Check_Overhead(  );
ADDRLP4 36
ADDRGP4 Check_Overhead
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 36
INDIRI4
ASGNI4
line 351
;351:	if ( !test )
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $208
line 352
;352:	{
line 353
;353:		Reset_Grapple( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 Reset_Grapple
CALLV
pop
line 354
;354:		return;
ADDRGP4 $186
JUMPV
LABELV $208
line 356
;355:	}
;356:	owner->on_hook = 1;
ADDRLP4 0
INDIRP4
CNSTI4 1444
ADDP4
CNSTI4 1
ASGNI4
line 357
;357:	if ( ( int ) owner->s.v.flags & 512 )
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $210
line 358
;358:	{
line 359
;359:		owner->s.v.flags = ( int ) owner->s.v.flags - 512;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 512
SUBI4
CVIF4 4
ASGNF4
line 360
;360:		setorigin( owner, PASSVEC3( owner->s.v.origin ) + 1 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 361
;361:	}
LABELV $210
line 366
;362:        // CHAIN2 is a looping sample. Use LEFTY as a flag so that client.qc
;363:        // will know to only play the tink sound ONCE to clear the weapons
;364:        // sound channel. (Lefty is a leftover from AI.QC, so I reused it to
;365:        // avoid adding a field)
;366:	owner->lefty = 1;
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
CNSTI4 1
ASGNI4
line 367
;367:	self->s.v.classname = "bot";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $212
ASGNP4
line 368
;368:	self->team_no = 0;
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
CNSTI4 0
ASGNI4
line 369
;369:	self->s.v.takedamage = 1;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1065353216
ASGNF4
line 370
;370:	self->s.v.health = 1;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1065353216
ASGNF4
line 371
;371:	self->th_die = Reset_My_Grapple;
ADDRGP4 self
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 Reset_My_Grapple
ASGNP4
line 372
;372:	self->s.v.enemy = EDICT_TO_PROG( other );// remember this guy!
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 other
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 373
;373:	self->s.v.think = ( func_t ) Grapple_Track;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 Grapple_Track
CVPU4 4
CVUI4 4
ASGNI4
line 374
;374:	self->s.v.nextthink = g_globalvars.time;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 376
;375:	//self->s.v.solid = SOLID_NOT;
;376:	self->s.v.touch = ( func_t ) SUB_Null;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 377
;377:}
LABELV $186
endproc Anchor_Grapple 48 20
export Throw_Grapple
proc Throw_Grapple 28 28
line 383
;378:
;379://
;380:// Throw_Grapple - called from WEAPONS.QC, 'fires' the grapple
;381://
;382:void Throw_Grapple(  )
;383:{
line 386
;384:	vec3_t  v;
;385:
;386:	if ( self->hook_out )// reject subsequent calls from player.qc
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
INDIRI4
CNSTI4 0
EQI4 $215
line 387
;387:		return;
ADDRGP4 $214
JUMPV
LABELV $215
line 389
;388:
;389:	KickPlayer( -1, self );
CNSTI4 -1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 391
;390:
;391:	newmis = spawn(  );
ADDRLP4 12
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 12
INDIRP4
ASGNP4
line 392
;392:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 393
;393:	newmis->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 394
;394:	newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 395
;395:	newmis->s.v.owner = EDICT_TO_PROG( self );// newmis belongs to me
ADDRGP4 newmis
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 396
;396:	self->hook = newmis;// This is my newmis
ADDRGP4 self
INDIRP4
CNSTI4 1440
ADDP4
ADDRGP4 newmis
INDIRP4
ASGNP4
line 397
;397:	newmis->s.v.classname = "hook";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $194
ASGNP4
line 399
;398:
;399:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 400
;400:	if (self->playerclass == PC_SPY)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $218
line 401
;401:		VectorScale( g_globalvars.v_forward, 2000, newmis->s.v.velocity );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1157234688
ARGF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
ADDRGP4 $219
JUMPV
LABELV $218
line 403
;402:	else
;403:		VectorScale( g_globalvars.v_forward, 800, newmis->s.v.velocity );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1145569280
ARGF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
LABELV $219
line 405
;404:	// set the facing of the grapple
;405:	vectoangles( newmis->s.v.velocity, newmis->s.v.angles );
ADDRLP4 16
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 407
;406:
;407:	newmis->s.v.touch = ( func_t ) Anchor_Grapple;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 Anchor_Grapple
CVPU4 4
CVUI4 4
ASGNI4
line 408
;408:	newmis->s.v.think = ( func_t ) Build_Chain;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 Build_Chain
CVPU4 4
CVUI4 4
ASGNI4
line 409
;409:	newmis->s.v.nextthink = g_globalvars.time + 0.1; // don't jam newmis and links into same packet
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 411
;410:
;411:	setmodel( newmis, "progs/hook.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $223
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 412
;412:	VectorScale( g_globalvars.v_forward, 16, v );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1098907648
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 413
;413:	VectorAdd( self->s.v.origin, v, v );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 414
;414:	v[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 415
;415:	setorigin( newmis, PASSVEC3( v ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 417
;416://	setsize( newmis, 0, 0, 0, 0, 0, 0 );
;417:	setsize( newmis, -1, -1, -1, 1, 1, 1 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 20
CNSTF4 3212836864
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 419
;418:
;419:	self->hook_out = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
CNSTI4 1
ASGNI4
line 420
;420:	self->fire_held_down = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1448
ADDP4
CNSTI4 1
ASGNI4
line 421
;421:}
LABELV $214
endproc Throw_Grapple 28 28
export Service_Grapple
proc Service_Grapple 52 12
line 427
;422:
;423://
;424:// Service_Grapple - called each frame by CLIENT.QC if client is ON_HOOK
;425://
;426:void Service_Grapple(  )
;427:{
line 433
;428:	vec3_t  hook_dir;
;429:	gedict_t *enemy;
;430:	gedict_t *goalentity;
;431:
;432:	// drop the hook if player lets go of button
;433:	if ( !self->s.v.button0 )
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
CNSTF4 0
NEF4 $233
line 434
;434:	{
line 435
;435:		self->fire_held_down = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1448
ADDP4
CNSTI4 0
ASGNI4
line 436
;436:		if ( self->current_weapon == WEAP_HOOK )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 1
NEI4 $235
line 437
;437:			Reset_Grapple( self->hook );
ADDRGP4 self
INDIRP4
CNSTI4 1440
ADDP4
INDIRP4
ARGP4
ADDRGP4 Reset_Grapple
CALLV
pop
LABELV $235
line 438
;438:	}
LABELV $233
line 439
;439:	enemy = PROG_TO_EDICT( self->hook->s.v.enemy );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 1440
ADDP4
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 441
;440:	// If hooked to a player, track them directly!
;441:	if ( streq( enemy->s.v.classname, "player" ) )
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $22
ARGP4
ADDRLP4 20
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $237
line 442
;442:	{
line 443
;443:		VectorSubtract( enemy->s.v.origin, self->s.v.origin, hook_dir );
ADDRLP4 24
CNSTI4 156
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28
CNSTI4 160
ASGNI4
ADDRLP4 0+4
ADDRLP4 12
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32
CNSTI4 164
ASGNI4
ADDRLP4 0+8
ADDRLP4 12
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 444
;444:	}
ADDRGP4 $238
JUMPV
LABELV $237
line 447
;445:	// else, track to hook
;446:	else
;447:	{
line 448
;448:		if ( strneq( enemy->s.v.classname, "player" ) )
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $22
ARGP4
ADDRLP4 24
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $241
line 449
;449:			VectorSubtract( self->hook->s.v.origin, self->s.v.origin, hook_dir );
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
CNSTI4 156
ASGNI4
ADDRLP4 0
ADDRLP4 28
INDIRP4
CNSTI4 1440
ADDP4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
CNSTI4 160
ASGNI4
ADDRLP4 0+4
ADDRLP4 36
INDIRP4
CNSTI4 1440
ADDP4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
CNSTI4 164
ASGNI4
ADDRLP4 0+8
ADDRLP4 44
INDIRP4
CNSTI4 1440
ADDP4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $241
line 450
;450:	}
LABELV $238
line 451
;451:	normalize( hook_dir, self->s.v.velocity );
ADDRLP4 0
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 normalize
CALLV
pop
line 452
;452:	VectorScale( self->s.v.velocity, self->maxfbspeed * 2, self->s.v.velocity );
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 932
ADDP4
INDIRI4
CNSTI4 1
LSHI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 453
;453:	if ( vlen( hook_dir ) <= 100 && self->lefty )
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
GTF4 $245
ADDRGP4 self
INDIRP4
CNSTI4 712
ADDP4
INDIRI4
CNSTI4 0
EQI4 $245
line 454
;454:	{
line 458
;455:                // If there is a chain, ditch it now. We're
;456:                // close enough. Having extra entities lying around
;457:                // is never a good idea.
;458:		if ( self->hook->s.v.goalentity )
ADDRGP4 self
INDIRP4
CNSTI4 1440
ADDP4
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 0
EQI4 $247
line 459
;459:		{
line 460
;460:			goalentity = PROG_TO_EDICT( self->hook->s.v.goalentity );
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 1440
ADDP4
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 461
;461:			goalentity->s.v.think = ( func_t ) Remove_Chain;
ADDRLP4 16
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 Remove_Chain
CVPU4 4
CVUI4 4
ASGNI4
line 462
;462:			goalentity->s.v.nextthink = g_globalvars.time;
ADDRLP4 16
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 463
;463:		}
LABELV $247
line 464
;464:		self->lefty = 0;// we've reset the sound channel.
ADDRGP4 self
INDIRP4
CNSTI4 712
ADDP4
CNSTI4 0
ASGNI4
line 465
;465:	}
LABELV $245
line 466
;466:	if ( self->grappleupdatetime < g_globalvars.time ) {
ADDRGP4 self
INDIRP4
CNSTI4 1020
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $250
line 467
;467:		self->s.v.currentammo = self->s.v.ammo_cells;
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ASGNF4
line 468
;468:		self->grappleupdatetime = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 1020
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 469
;469:	}
ADDRGP4 $251
JUMPV
LABELV $250
line 471
;470:	else
;471:		self->grappleupdatetime = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 1020
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $251
line 472
;472:}
LABELV $232
endproc Service_Grapple 52 12
import ambient_sound
import sandball_goal
import ballstart
import ball
import func_glass
import trigger_jumper
import TeamFortress_NightVision
import s2_explode1
import EjectShell
import FlashTimer
import BalloonMIRV
import player_mtf_nail1
import unlay
import lay
import mtf_deathmsg
import ModCommand
import CheckAutoKick
import Menu_Class_Input
import Menu_Team_Input
import Menu_Input
import Player_Menu
import StatusRes
import RefreshStatusBar
import crossproduct
import CenterPrint
import bubble_bob
import bubble_remove
import make_bubbles
import infront
import range
import visible
import muzzleflash
import KickPlayer
import GetInfokeyInt
import GetInfokeyString
import GetSVInfokeyFloat
import GetSVInfokeyInt
import GetSVInfokeyString
import build_number
import ANGEL_VERSION
import display_location
import dremove
import spawn_tdeath
import spawn_tfog
import Respawn_Item
import bound_other_ammo
import DropBackpack
import DropRing
import DropQuad
import T_Heal
import CanDamage
import TF_T_Damage
import T_BeamDamage
import T_RadiusDamage
import T_Damage
import damage_inflictor
import damage_attacker
import launch_spike
import T_MissileTouch
import W_PrintWeaponMessage
import Attack_Finished
import Multi_Finish
import AddMultiDamage
import ApplyMultiDamage
import TraceAttack
import ClearMultiDamage
import BecomeExplosion
import W_FireLaser
import W_FireTranq
import W_FireIncendiaryCannon
import W_FireFlame
import W_FireSpikes
import W_FireSuperSpikes
import W_FireGrenade
import W_FireLightning
import W_FireRocket
import W_FireAssaultCannon
import W_FireAutoRifle
import W_FireSniperRifle
import W_FireSuperShotgun
import W_FireShotgun
import W_FireBioweapon
import W_FireMedikit
import W_FireSpanner
import W_FireAxe
import W_WeaponFrame
import DeadImpulses
import PreMatchImpulses
import SpawnBlood
import W_SetCurrentAmmo
import W_Precache
import W_BestWeapon
import puff_org
import SpectatorThink
import SpectatorDisconnect
import SpectatorConnect
import SuperDamageSound
import PlayerPostThink
import PlayerPreThink
import ClientDisconnect
import PutClientInServer
import ClientConnect
import SetNewParms
import SetChangeParms
import modelindex_null
import modelindex_player
import modelindex_eyes
import intermission_exittime
import intermission_running
import CopyToBodyQue
import SUB_Null
import SUB_Remove
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
import G_SpawnEntitiesFromString
import G_Alloc
import activator
import SUB_AttackFinished
import InitTrigger
import SetMovedir
import SUB_UseTargets
import SUB_CalcMoveEnt
import SUB_CalcMove
import disableupdates
import WriteEntity
import infokey
import logfrag
import setspawnparam
import makestatic
import checkbottom
import walkmove
import droptofloor
import TraceCapsule
import traceline
import checkclient
import sound
import setmodel
import setsize
import setorigin
import aim
import strneq
import streq
import stuffcmd
import localcmd
import G_centerprint
import G_bprint
import G_sprint
import makevectors
import changeyaw
import vectoangles
import vectoyaw
import vlen
import normalize
import findradius
import nextent
import ent_remove
import spawn
import rint
import crandom
import g_random
import crc32
import G_conprintf
import G_Error
import G_dprintf
import api_ver
import coop
import framecount
import deathmatch
import teamplay
import fraglimit
import timelimit
import newmis
import other
import self
import world
import g_globalvars
import g_edicts
import tf_data
import NUM_FOR_EDICT
import Eng_DispUnload
import Eng_DispLoad
import Eng_SGReload
import Eng_SGUp
import Eng_StaticSG_Activate
import TG_LoadSettings
import TG_Eff_Remove
import TG_Eff_Flash
import TG_Eff_Conc
import tg_data
import current_vote
import votes
import bot_frametime
import BotImpulseMenu
import BotImpulse
import GoForResupply
import CheckForResupply
import AttackTargets
import AttackVisible
import UseGren
import DitchGrens
import HandleGrens
import DodgeEnemyGrenades
import DodgeEnemy
import LeadAim
import InstantAim
import AimHere
import FindTargets
import PickBestWeapon
import ClearAllTargets
import ClearTarget
import AddTarget
import AllTargetsFull
import ReloadWeapons
import DoMovement
import MoveToLocation
import GotoLocation
import GetKeysByLoc
import GetKeysByDir
import StrafeRight
import StrafeLeft
import PickAName
import ClearAllWaypoints
import Bot_AI
import botDisconnect
import botConnect
import BotFrame
import WaypointFindPath
import FreePath
import AddLink
import AddWaypoint
import WaypointFindNearest
import WaypointFindNearestVisible
import WaypointFindByType
import WaypointFindVisible
import WaypointFindInRadius
import default_link
import TeamFortress_PrepareForArenaRespawn
import TeamFortress_isTeamsAllied
import TeamFortress_CanGetWeapon
import TeamFortress_GetMaxAmmo
import DoGroupWork
import DoGoalWork
import TeamFortress_AutoID
import decrement_team_ammoboxes
import increment_team_ammoboxes
import TeamFortress_TeamGetIllegalClasses
import CanisterTouch
import ScatterCaltrops
import CaltropTouch
import FlashGrenadeExplode
import FlashGrenadeTouch
import EMPGrenadeExplode
import EMPGrenadeTouch
import GasGrenadeExplode
import GasGrenadeTouch
import NapalmGrenadeExplode
import NapalmGrenadeTouch
import MirvGrenadeExplode
import MirvGrenadeTouch
import NailGrenadeExplode
import NailGrenadeTouch
import ConcussionGrenadeExplode
import ConcussionGrenadeTouch
import NormalGrenadeExplode
import NormalGrenadeTouch
import FlareGrenadeTouch
import FlareGrenadeExplode
import TeamFortress_AmmoboxTouch
import TeamFortress_ExplodePerson
import TeamFortress_RegenerateCells
import TeamFortress_Regenerate
import SelectSpawnPoint
import execute_changelevel
import ForceRespawn
import ReturnItem
import tfgoalitem_checkgoalreturn
import tfgoalitem_drop
import RemoveResults
import DoTriggerWork
import DoItemGroupWork
import SetupRespawn
import APMeetsCriteria
import Apply_Results
import IsAffectedBy
import RestoreGoal
import InactivateGoal
import Findteamspawn
import TF_StartGoal
import TF_PlaceGoal
import TF_StartItem
import TF_PlaceItem
import TeamFortress_TeamIncreaseScore
import DoRespawn
import info_tfgoal_use
import tfgoalitem_remove
import tfgoal_timer_tick
import item_tfgoal_touch
import tfgoal_touch
import RemoveGoal
import TeamFortress_DisplayDetectionItems
import DoResults
import tfgoalitem_RemoveFromPlayer
import tfgoalitem_GiveToPlayer
import SetupTeamEqualiser
import ParseTFDetect
import CheckExistence
import AttemptToActivate
import Activated
import Findgoal
import Finditem
import DisplayItemStatus
import teamsprint
import TeamFortress_TeamShowScores
import TeamFortress_TeamSet
import SetTeamName
import ClassIsRestricted
import TeamFortress_TeamIsCivilian
import TeamFortress_GetNoPlayers
import TeamFortress_TeamGetTopColor
import TeamFortress_TeamGetColor
import TeamFortress_DetpackExplode
import TeamFortress_CheckTeamCheats
import TeamFortress_TeamGetSecond
import TeamFortress_TeamGetScore
import TeamFortress_TeamGetWinner
import GetTeamName
import TeamEqualiseDamage
import Admin_CeaseFire
import Admin_DoKick
import Admin_CycleKick
import Admin_CountPlayers
import PreMatch_Think
import CeaseFire_think
import BirthdayTimer
import CTF_FlagCheck
import CheckBelowBuilding
import TF_zoom
import TeamFortress_Build
import DestroyBuilding
import Engineer_RemoveBuildings
import ScannerSwitch
import BioInfection_MonsterDecay
import BioInfection_Decay
import Engineer_UseMortar
import Engineer_UseSentryGun
import Engineer_UseDispenser
import TeamFortress_SetDetpack
import TeamFortress_Scan_Angel
import TeamFortress_Scan
import RemoveOldFlare
import RemoveFlare
import UseSpecialSkill
import DropKey
import SniperSight_Create
import TeamFortress_DetpackStop
import PipebombTouch
import OldConcussionGrenadeTimer
import ConcussionGrenadeTimer
import DropGoalItems
import DumpClanScores
import TF_MovePlayer
import TeamFortress_HelpMap
import TeamFortress_MOTD
import TeamFortress_CTF_FlagInfo
import TeamFortress_TeamShowMemberClasses_New
import TeamFortress_EngineerBuild
import TeamFortress_SpyGoUndercover
import TeamFortress_StatusQuery
import TeamFortress_AutoZoomToggle
import TeamFortress_ReloadCurrentWeapon
import TeamFortress_DetonatePipebombs
import TeamFortress_Discard
import TeamFortress_ThrowGrenade
import TeamFortress_PrimeGrenade
import TeamFortress_FlameThrower
import TeamFortress_IncendiaryCannon
import TeamFortress_AssaultWeapon
import TeamFortress_SniperWeapon
import TeamFortress_ShowTF
import TeamFortress_ShowIDs
import TeamFortress_ID
import TeamFortress_SaveMe
import TeamFortress_Inventory
import TeamFortress_DisplayLegalClasses
import TeamFortress_TeamGetLives
import TeamFortress_TeamGetMaxPlayers
import TeamFortress_TeamGetNoPlayers
import TeamFortress_TeamShowMemberClasses
import TeamFortress_AmmoboxRemove
import TeamFortress_GetSkinByTeamClass
import TeamFortress_GetSkin
import TeamFortress_TeamGetColorString
import TeamFortress_Alias
import KickCheater
import TeamFortress_TeamPutPlayerInTeam
import TeamFortress_ExecMapScript
import TeamFortress_ExecClassScript
import TeamFortress_SetColor
import TeamFortress_SetSkin
import TeamFortress_SetSpeed
import TeamFortress_SetHealth
import TeamFortress_SetEquipment
import TeamFortress_PrintClassName
import TeamFortress_DescribeArmor
import IsLegalClass
import TeamFortress_CheckClassStats
import TeamFortress_ChangeClass
import TeamFortress_SetupRespawn
import TeamFortress_RemoveTimers
import TF_AddFrags
import TeamFortress_GetClassName
import set_suicide_frame
import PlayerDie
import GibPlayer
import KillPlayer
import PlayerDead
import DeathSound
import DeathBubblesSpawn
import player_die_ax1
import player_diee1
import player_died1
import player_diec1
import player_dieb1
import player_diea1
import player_pain
import player_axpain6
import player_axpain5
import player_axpain4
import player_axpain3
import player_axpain2
import player_axpain1
import player_pain6
import player_pain5
import player_pain4
import player_pain3
import player_pain2
import player_pain1
import PainSound
import player_rocket6
import player_rocket5
import player_rocket4
import player_rocket3
import player_rocket2
import player_rocket1
import player_light2
import player_light1
import player_assaultcannondown1
import player_assaultcannon2
import player_assaultcannon1
import player_assaultcannonup2
import player_assaultcannonup1
import player_nail2
import player_nail1
import player_bioweapond4
import player_bioweapond3
import player_bioweapond2
import player_bioweapond1
import player_bioweaponc4
import player_bioweaponc3
import player_bioweaponc2
import player_bioweaponc1
import player_bioweaponb4
import player_bioweaponb3
import player_bioweaponb2
import player_bioweaponb1
import player_bioweapon4
import player_bioweapon3
import player_bioweapon2
import player_bioweapon1
import player_medikitd4
import player_medikitd3
import player_medikitd2
import player_medikitd1
import player_medikitc4
import player_medikitc3
import player_medikitc2
import player_medikitc1
import player_medikitb4
import player_medikitb3
import player_medikitb2
import player_medikitb1
import player_medikit4
import player_medikit3
import player_medikit2
import player_medikit1
import player_chain5
import player_chain4
import player_chain3
import player_chain2a
import player_chain2
import player_chain1a
import player_chain1
import player_axed4
import player_axed3
import player_axed2
import player_axed1
import player_axec4
import player_axec3
import player_axec2
import player_axec1
import player_axeb4
import player_axeb3
import player_axeb2
import player_axeb1
import player_axe4
import player_axe3
import player_axe2
import player_axe1
import player_autorifle3
import player_autorifle2
import player_autorifle1
import player_shot6
import player_shot5
import player_shot4
import player_shot3
import player_shot2
import player_shot1
import player_touch
import player_run
import player_stand1
import Headless_Think
import ThrowGib
import spy_upaxe9
import spy_upaxe8
import spy_upaxe7
import spy_upaxe6
import spy_upaxe5
import spy_upaxe4
import spy_upaxe3
import spy_upaxe2
import spy_upaxe1
import spy_upe9
import spy_upe8
import spy_upe7
import spy_upe6
import spy_upe5
import spy_upe4
import spy_upe3
import spy_upe2
import spy_upe1
import spy_upd9
import spy_upd8
import spy_upd7
import spy_upd6
import spy_upd5
import spy_upd4
import spy_upd3
import spy_upd2
import spy_upd1
import spy_upc15
import spy_upc14
import spy_upc13
import spy_upc12
import spy_upc11
import spy_upc10
import spy_upc9
import spy_upc8
import spy_upc7
import spy_upc6
import spy_upc5
import spy_upc4
import spy_upc3
import spy_upc2
import spy_upc1
import spy_upb9
import spy_upb8
import spy_upb7
import spy_upb6
import spy_upb5
import spy_upb4
import spy_upb3
import spy_upb2
import spy_upb1
import spy_die_ax9
import spy_die_ax8
import spy_die_ax7
import spy_die_ax6
import spy_die_ax5
import spy_die_ax4
import spy_die_ax3
import spy_die_ax2
import spy_die_ax1
import spy_diee9
import spy_diee8
import spy_diee7
import spy_diee6
import spy_diee5
import spy_diee4
import spy_diee3
import spy_diee2
import spy_diee1
import spy_died9
import spy_died8
import spy_died7
import spy_died6
import spy_died5
import spy_died4
import spy_died3
import spy_died2
import spy_died1
import spy_diec15
import spy_diec14
import spy_diec13
import spy_diec12
import spy_diec11
import spy_diec10
import spy_diec9
import spy_diec8
import spy_diec7
import spy_diec6
import spy_diec5
import spy_diec4
import spy_diec3
import spy_diec2
import spy_diec1
import spy_dieb9
import spy_dieb8
import spy_dieb7
import spy_dieb6
import spy_dieb5
import spy_dieb4
import spy_dieb3
import spy_dieb2
import spy_dieb1
import spy_diea11
import spy_diea10
import spy_diea9
import spy_diea8
import spy_diea7
import spy_diea6
import spy_diea5
import spy_diea4
import spy_diea3
import spy_diea2
import spy_diea1
import TeamFortress_SpyFeignDeath
import TeamFortress_SpyChangeColor
import TeamFortress_SpyChangeSkin
import Spy_RemoveDisguise
import ResetGasSkins
import SetGasSkins
import TranquiliserTimer
import HallucinationTimer
import trap_SetBotCMD
import trap_SetBotUserInfo
import trap_RemoveBot
import trap_AddBot
import trap_Map_Extension
import trap_FS_GetFileList
import trap_FS_TellFile
import trap_FS_SeekFile
import trap_FS_WriteFile
import trap_FS_ReadFile
import trap_FS_CloseFile
import trap_FS_OpenFile
import trap_TraceCapsule
import trap_CmdArgv
import trap_CmdArgc
import trap_disableupdates
import trap_FlushSignon
import trap_WriteEntity
import trap_WriteString
import trap_WriteCoord
import trap_WriteAngle
import trap_WriteLong
import trap_WriteShort
import trap_WriteChar
import trap_WriteByte
import trap_infokey
import trap_logfrag
import trap_multicast
import trap_changelevel
import trap_setspawnparam
import trap_makestatic
import trap_find
import trap_nextent
import trap_pointcontents
import trap_checkbottom
import trap_lightstyle
import trap_walkmove
import trap_droptofloor
import trap_cvar_set_float
import trap_cvar_set
import trap_cvar_string
import trap_cvar
import trap_redirectcmd
import trap_readcmd
import trap_executecmd
import trap_localcmd
import trap_stuffcmd
import trap_traceline
import trap_checkclient
import trap_sound
import trap_ambientsound
import trap_setmodel
import trap_setsize
import trap_setorigin
import trap_precache_model
import trap_precache_sound
import trap_remove
import trap_spawn
import trap_Error
import trap_CenterPrint
import trap_SPrint
import trap_BPrint
import trap_conprint
import trap_DPrintf
import trap_GetEntityToken
import trap_GetApiVersion
import GR_TYPE_NAPALM_NO
import GR_TYPE_MIRV_NO
import MAX_WORLD_AMMOBOXES
import MAX_WORLD_PIPEBOMBS
import FLAME_MAXWORLDNUM
import team_menu_string
import rj
import CTF_Map
import teams_allied
import teammaxplayers
import teamlives
import teamfrags
import teamscores
import civilianteams
import illegalclasses
import number_of_teams
import skill
import sv_gravity
import MD5Transform
import MD5Final
import MD5Update
import MD5Init
import RotatePointAroundVector
import anglemod
import BoxOnPlaneSide
import AngleVectors
import GreatestCommonDivisor
import Mul16_30
import Invert24To16
import FloorDivMod
import R_ConcatTransforms
import R_ConcatRotations
import Q_log2
import VectorScale
import VectorInverse
import VectorNormalize
import CrossProduct
import VectorLength
import VectorCompareF
import VectorCompare
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import VectorMA
import nanmask
import vec3_origin
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import FloatSwap
import LongSwap
import ShortSwap
import alloca_reset
import alloca
import realloc
import free
import malloc
import calloc
import memcmp
import asin
import abs
import acos
import fabs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import _snprintf
import _vsnprintf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $223
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $212
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $205
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $204
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $203
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 97
byte 1 120
byte 1 104
byte 1 105
byte 1 116
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $202
byte 1 115
byte 1 104
byte 1 97
byte 1 109
byte 1 98
byte 1 108
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 109
byte 1 97
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $194
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 0
align 1
LABELV $193
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $192
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $191
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $26
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 114
byte 1 111
byte 1 112
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $22
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $12
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 100
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
