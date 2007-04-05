export monster_death_use
code
proc monster_death_use 8 0
file "..\src\combat.c"
line 36
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
;21: *  $Id: combat.c,v 1.9 2006/01/31 13:39:00 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:void    ClientObituary( gedict_t * e1, gedict_t * e2 );
;25:
;26://============================================================================
;27:
;28:/*================
;29:monster_death_use (from monsters.qc)
;30:
;31:When a monster dies, it fires all of its targets with the current
;32:enemy as activator.
;33:================
;34:*/
;35:void monster_death_use(  )
;36:{
line 38
;37:
;38:	if ( ( int ) self->s.v.flags & FL_FLY )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $12
line 39
;39:		self->s.v.flags -= FL_FLY;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
LABELV $12
line 40
;40:	if ( ( int ) self->s.v.flags & FL_SWIM )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $14
line 41
;41:		self->s.v.flags -= FL_SWIM;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
LABELV $14
line 42
;42:	if ( !self->s.v.target )
ADDRGP4 self
INDIRP4
CNSTI4 460
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $16
line 43
;43:		return;
ADDRGP4 $11
JUMPV
LABELV $16
line 44
;44:	activator = PROG_TO_EDICT( self->s.v.enemy );
ADDRGP4 activator
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 45
;45:	SUB_UseTargets(  );
ADDRGP4 SUB_UseTargets
CALLV
pop
line 46
;46:}
LABELV $11
endproc monster_death_use 8 0
export CanDamage
proc CanDamage 116 32
line 58
;47:
;48:/*
;49:============
;50:CanDamage
;51:
;52:Returns true if the inflictor can directly damage the target.  Used for
;53:explosions and melee attacks.
;54:============
;55:*/
;56:
;57:qboolean CanDamage( gedict_t * targ, gedict_t * inflictor )
;58:{
line 60
;59:// bmodels need special checking because their origin is 0,0,0
;60:	if ( targ->s.v.movetype == MOVETYPE_PUSH )
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRF4
CNSTF4 1088421888
NEF4 $19
line 61
;61:	{
line 63
;62:
;63:		traceline( PASSVEC3( inflictor->s.v.origin ),
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
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
ARGF4
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ADDF4
MULF4
ARGF4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
ADDF4
MULF4
ARGF4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 136
ADDP4
INDIRF4
ADDF4
MULF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 68
;64:			   0.5 * ( targ->s.v.absmin[0] + targ->s.v.absmax[0] ),
;65:			   0.5 * ( targ->s.v.absmin[1] + targ->s.v.absmax[1] ),
;66:			   0.5 * ( targ->s.v.absmin[2] + targ->s.v.absmax[2] ), true, self );
;67:
;68:		if ( g_globalvars.trace_fraction == 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $21
line 69
;69:			return true;
CNSTI4 1
RETI4
ADDRGP4 $18
JUMPV
LABELV $21
line 71
;70:
;71:		if ( PROG_TO_EDICT( g_globalvars.trace_ent ) == targ )
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $24
line 72
;72:			return true;
CNSTI4 1
RETI4
ADDRGP4 $18
JUMPV
LABELV $24
line 74
;73:
;74:		return false;
CNSTI4 0
RETI4
ADDRGP4 $18
JUMPV
LABELV $19
line 76
;75:	}
;76:	traceline( PASSVEC3( inflictor->s.v.origin ), PASSVEC3( targ->s.v.origin ), true, self );
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 156
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
CNSTI4 160
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
CNSTI4 164
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 77
;77:	if ( g_globalvars.trace_fraction == 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $27
line 78
;78:		return true;
CNSTI4 1
RETI4
ADDRGP4 $18
JUMPV
LABELV $27
line 80
;79:
;80:	traceline( PASSVEC3( inflictor->s.v.origin ),
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 156
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
CNSTI4 160
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
CNSTI4 164
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
CNSTF4 1097859072
ASGNF4
ADDRLP4 36
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
ADDF4
ARGF4
ADDRLP4 36
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
ADDF4
ARGF4
ADDRLP4 36
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
CNSTF4 0
ADDF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 82
;81:		   targ->s.v.origin[0] + 15, targ->s.v.origin[1] + 15, targ->s.v.origin[2] + 0, true, self );
;82:	if ( g_globalvars.trace_fraction == 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $30
line 83
;83:		return true;
CNSTI4 1
RETI4
ADDRGP4 $18
JUMPV
LABELV $30
line 85
;84:
;85:	traceline( PASSVEC3( inflictor->s.v.origin ),
ADDRLP4 44
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 48
CNSTI4 156
ASGNI4
ADDRLP4 44
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
CNSTI4 160
ASGNI4
ADDRLP4 44
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
CNSTI4 164
ASGNI4
ADDRLP4 44
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
CNSTF4 1097859072
ASGNF4
ADDRLP4 60
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 64
INDIRF4
SUBF4
ARGF4
ADDRLP4 60
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRLP4 64
INDIRF4
SUBF4
ARGF4
ADDRLP4 60
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
CNSTF4 0
ADDF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 87
;86:		   targ->s.v.origin[0] - 15, targ->s.v.origin[1] - 15, targ->s.v.origin[2] + 0, true, self );
;87:	if ( g_globalvars.trace_fraction == 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $33
line 88
;88:		return true;
CNSTI4 1
RETI4
ADDRGP4 $18
JUMPV
LABELV $33
line 90
;89:
;90:	traceline( PASSVEC3( inflictor->s.v.origin ),
ADDRLP4 68
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 72
CNSTI4 156
ASGNI4
ADDRLP4 68
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 76
CNSTI4 160
ASGNI4
ADDRLP4 68
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 80
CNSTI4 164
ASGNI4
ADDRLP4 68
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
CNSTF4 1097859072
ASGNF4
ADDRLP4 84
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRLP4 88
INDIRF4
SUBF4
ARGF4
ADDRLP4 84
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRLP4 88
INDIRF4
ADDF4
ARGF4
ADDRLP4 84
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
CNSTF4 0
ADDF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 92
;91:		   targ->s.v.origin[0] - 15, targ->s.v.origin[1] + 15, targ->s.v.origin[2] + 0, true, self );
;92:	if ( g_globalvars.trace_fraction == 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $36
line 93
;93:		return true;
CNSTI4 1
RETI4
ADDRGP4 $18
JUMPV
LABELV $36
line 95
;94:
;95:	traceline( PASSVEC3( inflictor->s.v.origin ),
ADDRLP4 92
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 96
CNSTI4 156
ASGNI4
ADDRLP4 92
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 100
CNSTI4 160
ASGNI4
ADDRLP4 92
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 104
CNSTI4 164
ASGNI4
ADDRLP4 92
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 112
CNSTF4 1097859072
ASGNF4
ADDRLP4 108
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRF4
ADDRLP4 112
INDIRF4
ADDF4
ARGF4
ADDRLP4 108
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRF4
ADDRLP4 112
INDIRF4
SUBF4
ARGF4
ADDRLP4 108
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRF4
CNSTF4 0
ADDF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 97
;96:		   targ->s.v.origin[0] + 15, targ->s.v.origin[1] - 15, targ->s.v.origin[2] + 0, true, self );
;97:	if ( g_globalvars.trace_fraction == 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $39
line 98
;98:		return true;
CNSTI4 1
RETI4
ADDRGP4 $18
JUMPV
LABELV $39
line 101
;99:
;100:
;101:	return false;
CNSTI4 0
RETI4
LABELV $18
endproc CanDamage 116 32
export Killed
proc Killed 12 8
line 110
;102:}
;103:
;104:/*
;105:============
;106:Killed
;107:============
;108:*/
;109:void Killed( gedict_t * targ, gedict_t * attacker )
;110:{
line 113
;111:	gedict_t *oself;
;112:
;113:	oself = self;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
line 114
;114:	self = targ;
ADDRGP4 self
ADDRFP4 0
INDIRP4
ASGNP4
line 117
;115:
;116:	// don't let sbar look bad if a player
;117:	if ( self->s.v.health < -99 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 3267756032
GEF4 $43
line 118
;118:		self->s.v.health = -99;	
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 3267756032
ASGNF4
LABELV $43
line 121
;119:
;120:	// doors, triggers, etc
;121:	if ( self->s.v.movetype == MOVETYPE_PUSH || self->s.v.movetype == MOVETYPE_NONE )
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 1088421888
EQF4 $47
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $45
LABELV $47
line 122
;122:	{			
line 123
;123:		self->th_die(  );
ADDRGP4 self
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CALLV
pop
line 124
;124:		self = oself;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 125
;125:		return;
ADDRGP4 $42
JUMPV
LABELV $45
line 127
;126:	}
;127:	self->s.v.enemy = EDICT_TO_PROG( attacker );
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 130
;128:
;129:        // bump the monster counter
;130:	if ( ( ( int ) ( self->s.v.flags ) ) & FL_MONSTER )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $48
line 131
;131:	{
line 132
;132:		g_globalvars.killed_monsters++;
ADDRLP4 8
ADDRGP4 g_globalvars+160
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 133
;133:		trap_WriteByte( MSG_ALL, SVC_KILLEDMONSTER );
CNSTI4 2
ARGI4
CNSTI4 27
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 134
;134:	}
LABELV $48
line 136
;135:
;136:	ClientObituary( self, attacker );
ADDRGP4 self
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ClientObituary
CALLV
pop
line 138
;137:
;138:	self->s.v.takedamage = DAMAGE_NO;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 139
;139:	self->s.v.touch = ( func_t ) SUB_Null;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 140
;140:	self->s.v.effects = 0;
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 0
ASGNF4
line 142
;141:
;142:	monster_death_use(  );
ADDRGP4 monster_death_use
CALLV
pop
line 143
;143:	self->th_die(  );
ADDRGP4 self
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CALLV
pop
line 145
;144:
;145:	self = oself;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 146
;146:}
LABELV $42
endproc Killed 12 8
export T_Damage
proc T_Damage 112 20
line 158
;147:
;148:/*
;149:============
;150:T_Damage
;151:
;152:The damage is coming from inflictor, but get mad at attacker
;153:This should be the only function that ever reduces health.
;154:============
;155:*/
;156:gedict_t *damage_attacker, *damage_inflictor;
;157:void T_Damage( gedict_t * targ, gedict_t * inflictor, gedict_t * attacker, float damage )
;158:{
line 166
;159:	vec3_t  dir;
;160:	gedict_t *oldself, *te;
;161:	float   save;
;162:	float   take;
;163:
;164://      char    attackerteam[10], targteam[10];
;165:
;166:	if ( !targ->s.v.takedamage )
ADDRFP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
NEF4 $52
line 167
;167:		return;
ADDRGP4 $51
JUMPV
LABELV $52
line 169
;168:
;169:	if ( streq( attacker->s.v.classname, "player" ) )
ADDRFP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 28
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $54
line 170
;170:		damage = damage * 0.9;
ADDRFP4 12
CNSTF4 1063675494
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
LABELV $54
line 171
;171:	if ( streq( attacker->s.v.classname, "player" ) )
ADDRFP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 32
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $57
line 172
;172:	{
line 173
;173:		if ( attacker->super_damage_finished > g_globalvars.time )
ADDRFP4 8
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $59
line 174
;174:			damage = damage * 4;
ADDRFP4 12
CNSTF4 1082130432
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
LABELV $59
line 175
;175:		if ( strneq( targ->s.v.classname, "player" ) && strneq( targ->s.v.classname, "bot" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 36
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $62
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $64
ARGP4
ADDRLP4 40
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $62
line 176
;176:		{
line 177
;177:			if ( !Activated( targ, attacker ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 Activated
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $65
line 178
;178:			{
line 179
;179:				if ( targ->else_goal )
ADDRFP4 0
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $51
line 180
;180:				{
line 181
;181:					te = Findgoal( targ->else_goal );
ADDRFP4 0
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 48
INDIRP4
ASGNP4
line 182
;182:					if ( te )
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $51
line 183
;183:						AttemptToActivate( te, attacker, targ );
ADDRLP4 24
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AttemptToActivate
CALLV
pop
line 184
;184:				}
line 185
;185:				return;
ADDRGP4 $51
JUMPV
LABELV $65
line 187
;186:			}
;187:		}
LABELV $62
line 188
;188:	}
LABELV $57
line 190
;189:// used by buttons and triggers to set activator for target firing
;190:	damage_attacker = attacker;
ADDRGP4 damage_attacker
ADDRFP4 8
INDIRP4
ASGNP4
line 192
;191:
;192:	if ( teamplay & ( TEAMPLAY_LESSSCOREHELP | TEAMPLAY_LESSPLAYERSHELP ) )
ADDRGP4 teamplay
INDIRI4
CNSTI4 96
BANDI4
CNSTI4 0
EQI4 $71
line 193
;193:		damage = TeamEqualiseDamage( targ, attacker, damage );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 TeamEqualiseDamage
CALLF4
ASGNF4
ADDRFP4 12
ADDRLP4 36
INDIRF4
ASGNF4
LABELV $71
line 196
;194:// save damage based on the target's armor level
;195:
;196:	save = ceil( targ->s.v.armortype * damage );
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ARGF4
ADDRLP4 40
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 40
INDIRF4
ASGNF4
line 197
;197:	if ( save >= targ->s.v.armorvalue )
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
LTF4 $73
line 198
;198:	{
line 199
;199:		save = targ->s.v.armorvalue;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ASGNF4
line 200
;200:		targ->s.v.armortype = 0;	// lost all armor
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTF4 0
ASGNF4
line 201
;201:		targ->s.v.items -= ( ( int ) targ->s.v.items & ( IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3 ) );
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 44
INDIRP4
ADDRLP4 48
INDIRF4
ADDRLP4 48
INDIRF4
CVFI4 4
CNSTI4 57344
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 202
;202:	}
LABELV $73
line 204
;203:
;204:	targ->s.v.armorvalue = targ->s.v.armorvalue - save;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 205
;205:	take = ceil( damage - save );
ADDRFP4 12
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRLP4 48
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 48
INDIRF4
ASGNF4
line 210
;206:
;207:// add to the damage total for clients, which will be sent as a single
;208:// message at the end of the frame
;209:// FIXME: remove after combining shotgun blasts?
;210:	if ( ( int ) targ->s.v.flags & FL_CLIENT )
ADDRFP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $75
line 211
;211:	{
line 212
;212:		targ->s.v.dmg_take += take;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 468
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 213
;213:		targ->s.v.dmg_save += save;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 472
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 214
;214:		targ->s.v.dmg_inflictor = EDICT_TO_PROG( inflictor );
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 215
;215:	}
LABELV $75
line 216
;216:	damage_inflictor = inflictor;
ADDRGP4 damage_inflictor
ADDRFP4 4
INDIRP4
ASGNP4
line 218
;217:// figure momentum add
;218:	if ( ( inflictor != world ) && ( targ->s.v.movetype == MOVETYPE_WALK ) )
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $77
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $77
line 219
;219:	{
line 221
;220:
;221:		dir[0] = targ->s.v.origin[0] - ( inflictor->s.v.absmin[0] + inflictor->s.v.absmax[0] ) * 0.5;
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 52
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ADDF4
MULF4
SUBF4
ASGNF4
line 222
;222:		dir[1] = targ->s.v.origin[1] - ( inflictor->s.v.absmin[1] + inflictor->s.v.absmax[1] ) * 0.5;
ADDRLP4 56
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8+4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 56
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
ADDF4
MULF4
SUBF4
ASGNF4
line 223
;223:		dir[2] = targ->s.v.origin[2] - ( inflictor->s.v.absmin[2] + inflictor->s.v.absmax[2] ) * 0.5;
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8+8
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 60
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 136
ADDP4
INDIRF4
ADDF4
MULF4
SUBF4
ASGNF4
line 224
;224:		VectorNormalize( dir );
ADDRLP4 8
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 225
;225:		if ( ( damage <
ADDRFP4 12
INDIRF4
CNSTF4 1114636288
GEF4 $84
ADDRLP4 64
CNSTI4 1
ASGNI4
ADDRGP4 $85
JUMPV
LABELV $84
ADDRLP4 64
CNSTI4 0
ASGNI4
LABELV $85
ADDRFP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 68
ADDRGP4 streq
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 72
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 76
CNSTI4 396
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
ADDRLP4 68
INDIRI4
BANDI4
ADDRLP4 72
INDIRI4
BANDI4
ADDRLP4 80
INDIRI4
BANDI4
CNSTI4 0
EQI4 $81
line 230
;226:		       60 ) & ( streq( attacker->s.v.classname,
;227:				       "player" ) ) & ( streq( targ->s.v.classname,
;228:							       "player" ) ) &
;229:		     strneq( attacker->s.v.netname, targ->s.v.netname ) )
;230:		{
line 231
;231:			targ->s.v.velocity[0] += dir[0] * damage * 11;
ADDRLP4 84
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
CNSTF4 1093664768
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 232
;232:			targ->s.v.velocity[1] += dir[1] * damage * 11;
ADDRLP4 88
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRF4
CNSTF4 1093664768
ADDRLP4 8+4
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 233
;233:			targ->s.v.velocity[2] += dir[2] * damage * 11;
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
CNSTF4 1093664768
ADDRLP4 8+8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 235
;234:
;235:		} else
ADDRGP4 $82
JUMPV
LABELV $81
line 236
;236:		{
line 237
;237:			targ->s.v.velocity[0] += dir[0] * damage * 8;
ADDRLP4 84
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 238
;238:			targ->s.v.velocity[1] += dir[1] * damage * 8;
ADDRLP4 88
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDRLP4 8+4
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 239
;239:			targ->s.v.velocity[2] += dir[2] * damage * 8;
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDRLP4 8+8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 240
;240:		}
LABELV $82
line 241
;241:		if ( ( rj > 1 )
ADDRGP4 rj
INDIRF4
CNSTF4 1065353216
LEF4 $90
ADDRFP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 84
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $90
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 88
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $90
ADDRLP4 92
CNSTI4 396
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $90
line 245
;242:		     && ( ( streq( attacker->s.v.classname, "player" ) )
;243:			  && streq( targ->s.v.classname, "player" ) )
;244:		     && streq( attacker->s.v.netname, targ->s.v.netname ) )
;245:		{
line 246
;246:			targ->s.v.velocity[0] += dir[0] * damage * rj;
ADDRLP4 100
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ADDRGP4 rj
INDIRF4
MULF4
ADDF4
ASGNF4
line 247
;247:			targ->s.v.velocity[1] += dir[1] * damage * rj;
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
ADDRLP4 8+4
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ADDRGP4 rj
INDIRF4
MULF4
ADDF4
ASGNF4
line 248
;248:			targ->s.v.velocity[2] += dir[2] * damage * rj;
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
ADDRLP4 8+8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ADDRGP4 rj
INDIRF4
MULF4
ADDF4
ASGNF4
line 250
;249:
;250:		}
LABELV $90
line 251
;251:	}
LABELV $77
line 252
;252:	if ( streq( targ->s.v.classname, "player" ) && tg_data.godmode )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 52
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $94
ADDRGP4 tg_data+4
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $94
line 253
;253:		return;
ADDRGP4 $51
JUMPV
LABELV $94
line 256
;254:
;255:// check for godmode or invincibility
;256:	if ( ( int ) targ->s.v.flags & FL_GODMODE )
ADDRFP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $97
line 257
;257:		return;
ADDRGP4 $51
JUMPV
LABELV $97
line 259
;258:
;259:	if ( targ->invincible_finished >= g_globalvars.time )
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LTF4 $99
line 260
;260:	{
line 261
;261:		if ( self->invincible_sound < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 752
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $51
line 262
;262:		{
line 263
;263:			sound( targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $105
ARGP4
ADDRLP4 60
CNSTF4 1065353216
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 264
;264:			self->invincible_sound = g_globalvars.time + 2;
ADDRGP4 self
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 265
;265:		}
line 266
;266:		return;
ADDRGP4 $51
JUMPV
LABELV $99
line 269
;267:	}
;268:
;269:	if ( streq( attacker->s.v.classname, "player" )
ADDRFP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 60
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $107
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 64
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $110
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $109
ARGP4
ADDRLP4 68
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $107
LABELV $110
line 271
;270:	     && ( streq( targ->s.v.classname, "player" ) || streq( targ->s.v.classname, "building_sentrygun" ) ) )
;271:	{
line 272
;272:		if ( targ->team_no > 0 && targ->team_no == attacker->team_no && targ != attacker )
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
CNSTI4 960
ASGNI4
ADDRLP4 80
ADDRLP4 72
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
LEI4 $111
ADDRLP4 84
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 80
INDIRI4
ADDRLP4 84
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRI4
NEI4 $111
ADDRLP4 72
INDIRP4
CVPU4 4
ADDRLP4 84
INDIRP4
CVPU4 4
EQU4 $111
line 273
;273:		{
line 274
;274:			if ( teamplay & TEAMPLAY_NOEXPLOSIVE )
ADDRGP4 teamplay
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $113
line 275
;275:				return;
ADDRGP4 $51
JUMPV
LABELV $113
line 277
;276:			else
;277:			{
line 278
;278:				if ( teamplay & TEAMPLAY_HALFEXPLOSIVE )
ADDRGP4 teamplay
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $115
line 279
;279:					take = take / 2;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
LABELV $115
line 280
;280:			}
line 281
;281:		}
LABELV $111
line 282
;282:	}
LABELV $107
line 283
;283:	if ( take < 1 && take )
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $117
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $117
line 284
;284:		take = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
LABELV $117
line 285
;285:	targ->s.v.health = targ->s.v.health - take;
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 286
;286:	if ( targ->s.v.armorvalue < 1 )
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $119
line 287
;287:	{
line 288
;288:		targ->armorclass = 0;
ADDRFP4 0
INDIRP4
CNSTI4 828
ADDP4
CNSTI4 0
ASGNI4
line 289
;289:		targ->s.v.armorvalue = 0;
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
CNSTF4 0
ASGNF4
line 290
;290:	}
LABELV $119
line 291
;291:	if ( targ->s.v.health <= 0 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $121
line 292
;292:	{
line 293
;293:		Killed( targ, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Killed
CALLV
pop
line 294
;294:		return;
ADDRGP4 $51
JUMPV
LABELV $121
line 296
;295:	}
;296:	oldself = self;
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
line 297
;297:	self = targ;
ADDRGP4 self
ADDRFP4 0
INDIRP4
ASGNP4
line 298
;298:	if ( self->th_pain )
ADDRGP4 self
INDIRP4
CNSTI4 816
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $123
line 299
;299:	{
line 300
;300:		self->th_pain( attacker, take );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 self
INDIRP4
CNSTI4 816
ADDP4
INDIRP4
CALLV
pop
line 301
;301:		if ( skill >= 3 )
ADDRGP4 skill
INDIRI4
CNSTI4 3
LTI4 $125
line 302
;302:			self->pain_finished = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 728
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
LABELV $125
line 303
;303:	}
LABELV $123
line 304
;304:	self = oldself;
ADDRGP4 self
ADDRLP4 20
INDIRP4
ASGNP4
line 305
;305:}
LABELV $51
endproc T_Damage 112 20
export TF_T_Damage
proc TF_T_Damage 160 24
line 334
;306:
;307:/*==============================
;308: TF_T_Damage
;309: same thing as T_Damage (see above), just with some more details
;310:
;311: T_Flags:
;312:	#TF_TD_IGNOREARMOUR: bypasses the armour of the target
;313:	#TF_TD_NOTTEAM: doesn't damage a team member
;314:	#TF_TD_NOTSELF: doesn't damage self
;315:
;316: The following is used to determine whether this attack is affected 
;317: the type of armor the defender is wearing.
;318: T_AttackType:		
;319:	#TF_TD_OTHER			:	type ignored
;320:	#TF_TD_SHOT			: 	bullet damage
;321:	#TF_TD_NAIL			:	nailgun damage
;322:	#TF_TD_EXPLOSION		:	explosion damage
;323:	#TF_TD_ELECTRICITY	:	electricity damage
;324:	#TF_TD_FIRE			:	fire damage
;325:
;326:	#TF_TD_NOSOUND		:	Special Value. Health is adjusted without
;327:						    any sound, painframe, etc
;328:							Health is _set_ to damage, not altered.
;329:
;330:==============================*/
;331:
;332:void TF_T_Damage( gedict_t * targ, gedict_t * inflictor, gedict_t * attacker,
;333:		  float damage, int T_flags, int T_AttackType )
;334:{
line 344
;335:	vec3_t  dir;
;336:	gedict_t *oldself;
;337:	gedict_t *te;
;338:	float   save;
;339:	float   take;
;340:	int     olddmsg;
;341:	float   no_damage;
;342:	float   moment;
;343:
;344:	if ( !targ->s.v.takedamage )
ADDRFP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
NEF4 $129
line 345
;345:		return;
ADDRGP4 $128
JUMPV
LABELV $129
line 346
;346:	if ( T_AttackType & TF_TD_NOSOUND )
ADDRFP4 20
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $131
line 347
;347:	{
line 348
;348:	        if(streq(targ->s.v.classname,"player"))
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 40
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $133
line 349
;349:	        	G_sprint(targ,2,"!!!BUG BUG BUG!!! killed by TF_TD_NOSOUND\n");
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $135
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $133
line 351
;350:
;351:		targ->s.v.health = damage;
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
ADDRFP4 12
INDIRF4
ASGNF4
line 352
;352:		return;
ADDRGP4 $128
JUMPV
LABELV $131
line 354
;353:	}
;354:	if ( tf_data.cease_fire )
ADDRGP4 tf_data+72
INDIRI4
CNSTI4 0
EQI4 $136
line 355
;355:		return;
ADDRGP4 $128
JUMPV
LABELV $136
line 356
;356:	no_damage = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 357
;357:	if ( streq( attacker->s.v.classname, "player" ) )
ADDRFP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 40
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $139
line 358
;358:	{
line 359
;359:		damage = damage * 0.9;
ADDRFP4 12
CNSTF4 1063675494
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 361
;360:		// check for quad damage powerup on the attacker
;361:		if ( attacker->super_damage_finished > g_globalvars.time )
ADDRFP4 8
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $141
line 362
;362:			damage = damage * 4;
ADDRFP4 12
CNSTF4 1082130432
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
LABELV $141
line 364
;363:
;364:		if ( strneq( targ->s.v.classname, "player" )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 44
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $144
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $64
ARGP4
ADDRLP4 48
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $144
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $109
ARGP4
ADDRLP4 52
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $144
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $146
ARGP4
ADDRLP4 56
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $144
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $147
ARGP4
ADDRLP4 60
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $144
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $148
ARGP4
ADDRLP4 64
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $144
line 370
;365:		     && strneq( targ->s.v.classname, "bot" )
;366:		     && strneq( targ->s.v.classname, "building_sentrygun" )
;367:		     && strneq( targ->s.v.classname, "building_dispenser" )
;368:		     && strneq( targ->s.v.classname, "building_teleporter_entrance" )
;369:		     && strneq( targ->s.v.classname, "building_teleporter_exit" ) )
;370:		{
line 371
;371:			if ( !Activated( targ, attacker ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 Activated
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $149
line 372
;372:			{
line 374
;373:			        // If an else goal should be activated, activate it
;374:				if ( targ->else_goal )
ADDRFP4 0
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $128
line 375
;375:				{
line 376
;376:					te = Findgoal( targ->else_goal );
ADDRFP4 0
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 72
INDIRP4
ASGNP4
line 377
;377:					if ( te )
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $128
line 378
;378:						AttemptToActivate( te, attacker, targ );
ADDRLP4 36
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AttemptToActivate
CALLV
pop
line 379
;379:				}
line 380
;380:				return;
ADDRGP4 $128
JUMPV
LABELV $149
line 382
;381:			}
;382:		}
LABELV $144
line 383
;383:	}
LABELV $139
line 385
;384:	// used by buttons and triggers to set activator for target firing
;385:	damage_attacker = attacker;
ADDRGP4 damage_attacker
ADDRFP4 8
INDIRP4
ASGNP4
line 388
;386:
;387:	// megatf damage system (use localinfo/serverinfo teamdamage "on" to bypass)
;388:	if ( teamplay != 1 && teamplay != 2 )
ADDRLP4 44
ADDRGP4 teamplay
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
EQI4 $155
ADDRLP4 44
INDIRI4
CNSTI4 2
EQI4 $155
line 389
;389:		if ( targ->team_no == attacker->team_no && targ != attacker )
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
CNSTI4 960
ASGNI4
ADDRLP4 56
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ADDRLP4 56
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
NEI4 $157
ADDRLP4 48
INDIRP4
CVPU4 4
ADDRLP4 56
INDIRP4
CVPU4 4
EQU4 $157
line 390
;390:			damage = 0;
ADDRFP4 12
CNSTF4 0
ASGNF4
LABELV $157
LABELV $155
line 392
;391:
;392:	if ( teamplay & ( TEAMPLAY_LESSSCOREHELP | TEAMPLAY_LESSPLAYERSHELP ) )
ADDRGP4 teamplay
INDIRI4
CNSTI4 96
BANDI4
CNSTI4 0
EQI4 $159
line 393
;393:		damage = TeamEqualiseDamage( targ, attacker, damage );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 TeamEqualiseDamage
CALLF4
ASGNF4
ADDRFP4 12
ADDRLP4 60
INDIRF4
ASGNF4
LABELV $159
line 396
;394:
;395:	// Do armorclass stuff
;396:	if ( targ->armorclass && T_AttackType )
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $161
ADDRFP4 20
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $161
line 397
;397:	{
line 398
;398:		if ( ( targ->armorclass & AT_SAVESHOT ) && ( T_AttackType & TF_TD_SHOT ) )
ADDRLP4 68
CNSTI4 1
ASGNI4
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
BANDI4
ADDRLP4 72
INDIRI4
EQI4 $163
ADDRFP4 20
INDIRI4
ADDRLP4 68
INDIRI4
BANDI4
ADDRLP4 72
INDIRI4
EQI4 $163
line 399
;399:			damage = floor( damage * 0.5 );
CNSTF4 1056964608
ADDRFP4 12
INDIRF4
MULF4
ARGF4
ADDRLP4 76
ADDRGP4 floor
CALLF4
ASGNF4
ADDRFP4 12
ADDRLP4 76
INDIRF4
ASGNF4
LABELV $163
line 400
;400:		if ( ( targ->armorclass & AT_SAVENAIL ) && ( T_AttackType & TF_TD_NAIL ) )
ADDRLP4 80
CNSTI4 2
ASGNI4
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
ADDRLP4 80
INDIRI4
BANDI4
ADDRLP4 84
INDIRI4
EQI4 $165
ADDRFP4 20
INDIRI4
ADDRLP4 80
INDIRI4
BANDI4
ADDRLP4 84
INDIRI4
EQI4 $165
line 401
;401:			damage = floor( damage * 0.5 );
CNSTF4 1056964608
ADDRFP4 12
INDIRF4
MULF4
ARGF4
ADDRLP4 88
ADDRGP4 floor
CALLF4
ASGNF4
ADDRFP4 12
ADDRLP4 88
INDIRF4
ASGNF4
LABELV $165
line 402
;402:		if ( ( targ->armorclass & AT_SAVEEXPLOSION ) && ( T_AttackType & TF_TD_EXPLOSION ) )
ADDRLP4 92
CNSTI4 4
ASGNI4
ADDRLP4 96
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
ADDRLP4 92
INDIRI4
BANDI4
ADDRLP4 96
INDIRI4
EQI4 $167
ADDRFP4 20
INDIRI4
ADDRLP4 92
INDIRI4
BANDI4
ADDRLP4 96
INDIRI4
EQI4 $167
line 403
;403:			damage = floor( damage * 0.5 );
CNSTF4 1056964608
ADDRFP4 12
INDIRF4
MULF4
ARGF4
ADDRLP4 100
ADDRGP4 floor
CALLF4
ASGNF4
ADDRFP4 12
ADDRLP4 100
INDIRF4
ASGNF4
LABELV $167
line 404
;404:		if ( ( targ->armorclass & AT_SAVEELECTRICITY ) && ( T_AttackType & TF_TD_ELECTRICITY ) )
ADDRLP4 104
CNSTI4 8
ASGNI4
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
ADDRLP4 104
INDIRI4
BANDI4
ADDRLP4 108
INDIRI4
EQI4 $169
ADDRFP4 20
INDIRI4
ADDRLP4 104
INDIRI4
BANDI4
ADDRLP4 108
INDIRI4
EQI4 $169
line 405
;405:			damage = floor( damage * 0.5 );
CNSTF4 1056964608
ADDRFP4 12
INDIRF4
MULF4
ARGF4
ADDRLP4 112
ADDRGP4 floor
CALLF4
ASGNF4
ADDRFP4 12
ADDRLP4 112
INDIRF4
ASGNF4
LABELV $169
line 406
;406:		if ( ( targ->armorclass & AT_SAVEFIRE ) && ( T_AttackType & TF_TD_FIRE ) )
ADDRLP4 116
CNSTI4 16
ASGNI4
ADDRLP4 120
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
ADDRLP4 116
INDIRI4
BANDI4
ADDRLP4 120
INDIRI4
EQI4 $171
ADDRFP4 20
INDIRI4
ADDRLP4 116
INDIRI4
BANDI4
ADDRLP4 120
INDIRI4
EQI4 $171
line 407
;407:			damage = floor( damage * 0.5 );
CNSTF4 1056964608
ADDRFP4 12
INDIRF4
MULF4
ARGF4
ADDRLP4 124
ADDRGP4 floor
CALLF4
ASGNF4
ADDRFP4 12
ADDRLP4 124
INDIRF4
ASGNF4
LABELV $171
line 408
;408:	}
LABELV $161
line 410
;409:	// save damage based on the target's armor level
;410:	if ( T_flags & TF_TD_IGNOREARMOUR )
ADDRFP4 16
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $173
line 411
;411:	{
line 412
;412:		take = damage;
ADDRLP4 0
ADDRFP4 12
INDIRF4
ASGNF4
line 413
;413:		save = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 414
;414:	} else
ADDRGP4 $174
JUMPV
LABELV $173
line 415
;415:	{
line 416
;416:		save = ceil( targ->s.v.armortype * damage );
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ARGF4
ADDRLP4 68
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 68
INDIRF4
ASGNF4
line 417
;417:		if ( streq( attacker->s.v.classname, "player" ) && targ->team_no > 0
ADDRFP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 72
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRI4
ADDRLP4 76
INDIRI4
EQI4 $175
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTI4 960
ASGNI4
ADDRLP4 88
ADDRLP4 80
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRLP4 76
INDIRI4
LEI4 $175
ADDRLP4 92
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 88
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRI4
NEI4 $175
ADDRLP4 80
INDIRP4
CVPU4 4
ADDRLP4 92
INDIRP4
CVPU4 4
EQU4 $175
ADDRFP4 16
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 76
INDIRI4
EQI4 $175
line 419
;418:		     && targ->team_no == attacker->team_no && targ != attacker && ( T_flags & TF_TD_NOTTEAM ) )
;419:		{
line 420
;420:			if ( T_AttackType & TF_TD_EXPLOSION )
ADDRFP4 20
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $177
line 421
;421:			{
line 422
;422:				if ( teamplay & 1024 )
ADDRGP4 teamplay
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $179
line 423
;423:					save = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRGP4 $178
JUMPV
LABELV $179
line 425
;424:				else
;425:				{
line 426
;426:					if ( teamplay & 512 )
ADDRGP4 teamplay
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $178
line 427
;427:						save = save / 2;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 428
;428:				}
line 429
;429:			} else
ADDRGP4 $178
JUMPV
LABELV $177
line 430
;430:			{
line 431
;431:				if ( teamplay & 256 )
ADDRGP4 teamplay
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $183
line 432
;432:					save = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRGP4 $184
JUMPV
LABELV $183
line 434
;433:				else
;434:				{
line 435
;435:					if ( teamplay & 128 )
ADDRGP4 teamplay
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $185
line 436
;436:						save = save / 2;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
LABELV $185
line 437
;437:				}
LABELV $184
line 438
;438:			}
LABELV $178
line 439
;439:		}
LABELV $175
line 442
;440:// save damage based on the target's armor level
;441:
;442:		save = ceil( targ->s.v.armortype * damage );
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ARGF4
ADDRLP4 96
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 96
INDIRF4
ASGNF4
line 443
;443:		if ( save >= targ->s.v.armorvalue )
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
LTF4 $187
line 444
;444:		{
line 445
;445:			save = targ->s.v.armorvalue;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ASGNF4
line 446
;446:			targ->s.v.armortype = 0;	// lost all armor
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTF4 0
ASGNF4
line 447
;447:			targ->armorclass = 0;	       // lost special armor
ADDRFP4 0
INDIRP4
CNSTI4 828
ADDP4
CNSTI4 0
ASGNI4
line 448
;448:			targ->s.v.items -= ( ( int ) targ->s.v.items & ( IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3 ) );
ADDRLP4 100
ADDRFP4 0
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 104
ADDRLP4 100
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 100
INDIRP4
ADDRLP4 104
INDIRF4
ADDRLP4 104
INDIRF4
CVFI4 4
CNSTI4 57344
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 449
;449:		}
LABELV $187
line 451
;450:
;451:		targ->s.v.armorvalue = targ->s.v.armorvalue - save;
ADDRLP4 100
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 452
;452:		take = ceil( damage - save );
ADDRFP4 12
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRLP4 104
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 104
INDIRF4
ASGNF4
line 453
;453:	}
LABELV $174
line 457
;454:	// add to the damage total for clients, which will be sent as a single
;455:	// message at the end of the frame
;456:	// FIXME: remove after combining shotgun blasts?
;457:	if ( ( int ) targ->s.v.flags & FL_CLIENT )
ADDRFP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $189
line 458
;458:	{
line 459
;459:		targ->s.v.dmg_take += take;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 468
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 460
;460:		targ->s.v.dmg_save += save;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 472
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 461
;461:		targ->s.v.dmg_inflictor = EDICT_TO_PROG( inflictor );
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 462
;462:	}
LABELV $189
line 463
;463:	damage_inflictor = inflictor;
ADDRGP4 damage_inflictor
ADDRFP4 4
INDIRP4
ASGNP4
line 466
;464:
;465:	// figure momentum add
;466:	if ( inflictor != world && targ->s.v.movetype == MOVETYPE_WALK && !( targ->tfstate & TFSTATE_CANT_MOVE ) )
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $191
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 148
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $191
ADDRLP4 68
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
NEI4 $191
line 467
;467:	{
line 468
;468:		if ( targ->playerclass != PC_HVYWEAP )
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 6
EQI4 $193
line 469
;469:		{
line 471
;470:	        // Nail Gren doesn't knock ppl
;471:		if ( tf_data.deathmsg != DMSG_GREN_NAIL )
ADDRGP4 tf_data+88
INDIRI4
CNSTI4 9
EQI4 $195
line 472
;472:		{
line 474
;473:                        //   targ.immune_to_check = g_globalvars.time + damage / 20;
;474:			dir[0] = targ->s.v.origin[0] - ( inflictor->s.v.absmin[0] + inflictor->s.v.absmax[0] ) * 0.5;
ADDRLP4 72
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 72
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ADDF4
MULF4
SUBF4
ASGNF4
line 475
;475:			dir[1] = targ->s.v.origin[1] - ( inflictor->s.v.absmin[1] + inflictor->s.v.absmax[1] ) * 0.5;
ADDRLP4 76
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16+4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 76
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
ADDF4
MULF4
SUBF4
ASGNF4
line 476
;476:			dir[2] = targ->s.v.origin[2] - ( inflictor->s.v.absmin[2] + inflictor->s.v.absmax[2] ) * 0.5;
ADDRLP4 80
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16+8
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 80
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 136
ADDP4
INDIRF4
ADDF4
MULF4
SUBF4
ASGNF4
line 477
;477:			VectorNormalize( dir );
ADDRLP4 16
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 479
;478:			
;479:			if ( targ->playerclass == PC_HVYWEAP )
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 6
NEI4 $200
line 480
;480:			{
line 482
;481:#ifdef NEWHWGUY
;482:				if ( targ != attacker )
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $202
line 483
;483:				{
line 486
;484:#endif
;485:					
;486:					moment = damage / 3;
ADDRLP4 28
ADDRFP4 12
INDIRF4
CNSTF4 1077936128
DIVF4
ASGNF4
line 487
;487:					if ( damage <= 50 )
ADDRFP4 12
INDIRF4
CNSTF4 1112014848
GTF4 $201
line 488
;488:						moment = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
line 490
;489:#ifdef NEWHWGUY
;490:				} else
ADDRGP4 $201
JUMPV
LABELV $202
line 491
;491:				{
line 492
;492:					moment = damage / 2;
ADDRLP4 28
ADDRFP4 12
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 493
;493:				}
line 495
;494:#endif
;495:			} else
ADDRGP4 $201
JUMPV
LABELV $200
line 496
;496:				moment = damage;
ADDRLP4 28
ADDRFP4 12
INDIRF4
ASGNF4
LABELV $201
line 500
;497:			
;498:			// Set kickback for smaller weapons
;499:			// Read: only if it's not yourself doing the damage
;500:			if ( moment < 60 && streq( attacker->s.v.classname, "player" )
ADDRLP4 28
INDIRF4
CNSTF4 1114636288
GEF4 $206
ADDRFP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 84
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $206
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 88
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $206
ADDRLP4 92
CNSTI4 396
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $206
line 503
;501:			     && streq( targ->s.v.classname, "player" )
;502:			     && strneq( attacker->s.v.netname, targ->s.v.netname ) )
;503:			{
line 504
;504:				targ->s.v.velocity[0] += dir[0] * moment * 11;
ADDRLP4 100
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
CNSTF4 1093664768
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 505
;505:				targ->s.v.velocity[1] += dir[1] * moment * 11;
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
CNSTF4 1093664768
ADDRLP4 16+4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 506
;506:				targ->s.v.velocity[2] += dir[2] * moment * 11;
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
CNSTF4 1093664768
ADDRLP4 16+8
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 508
;507:
;508:			} else
ADDRGP4 $207
JUMPV
LABELV $206
line 511
;509:			// Otherwise, these rules apply to rockets and grenades                        
;510:			// for blast velocity
;511:			{
line 512
;512:				targ->s.v.velocity[0] += dir[0] * moment * 8;
ADDRLP4 100
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 513
;513:				targ->s.v.velocity[1] += dir[1] * moment * 8;
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDRLP4 16+4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 514
;514:				targ->s.v.velocity[2] += dir[2] * moment * 8;
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDRLP4 16+8
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 515
;515:			}
LABELV $207
line 517
;516:			// Rocket Jump modifiers
;517:			if ( ( rj > 1 )
ADDRGP4 rj
INDIRF4
CNSTF4 1065353216
LEF4 $212
ADDRFP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 100
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $212
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 104
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
EQI4 $212
ADDRLP4 108
CNSTI4 396
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $212
line 521
;518:			     && ( ( streq( attacker->s.v.classname, "player" ) )
;519:				  && streq( targ->s.v.classname, "player" ) )
;520:			     && streq( attacker->s.v.netname, targ->s.v.netname ) )
;521:			{
line 522
;522:				targ->s.v.velocity[0] += dir[0] * moment * rj;
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDRGP4 rj
INDIRF4
MULF4
ADDF4
ASGNF4
line 523
;523:				targ->s.v.velocity[1] += dir[1] * moment * rj;
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRF4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDRGP4 rj
INDIRF4
MULF4
ADDF4
ASGNF4
line 524
;524:				targ->s.v.velocity[2] += dir[2] * moment * rj;
ADDRLP4 124
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRF4
ADDRLP4 16+8
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDRGP4 rj
INDIRF4
MULF4
ADDF4
ASGNF4
line 526
;525:
;526:			}
LABELV $212
line 527
;527:		}
LABELV $195
line 528
;528:		}
LABELV $193
line 529
;529:	}
LABELV $191
line 531
;530:// check for godmode or invincibility
;531:	if ( streq( targ->s.v.classname, "player" ) && tg_data.godmode )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 72
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRI4
ADDRLP4 76
INDIRI4
EQI4 $216
ADDRGP4 tg_data+4
INDIRI4
ADDRLP4 76
INDIRI4
EQI4 $216
line 532
;532:		return;
ADDRGP4 $128
JUMPV
LABELV $216
line 534
;533:
;534:	if ( ( int ) targ->s.v.flags & FL_GODMODE )
ADDRFP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $219
line 535
;535:		return;
ADDRGP4 $128
JUMPV
LABELV $219
line 537
;536:
;537:	if ( targ->invincible_finished >= g_globalvars.time )
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LTF4 $221
line 538
;538:	{
line 539
;539:		if ( self->invincible_sound < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 752
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $128
line 540
;540:		{
line 541
;541:			sound( targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $105
ARGP4
ADDRLP4 80
CNSTF4 1065353216
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 542
;542:			self->invincible_sound = g_globalvars.time + 2;
ADDRGP4 self
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 543
;543:		}
line 544
;544:		return;
ADDRGP4 $128
JUMPV
LABELV $221
line 547
;545:	}
;546:	// team play damage avoidance
;547:	if ( streq( attacker->s.v.classname, "player" )
ADDRFP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 80
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $228
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 84
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $233
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $109
ARGP4
ADDRLP4 88
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $233
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $146
ARGP4
ADDRLP4 92
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $233
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $147
ARGP4
ADDRLP4 96
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $233
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $148
ARGP4
ADDRLP4 100
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $228
LABELV $233
line 553
;548:	     && ( streq( targ->s.v.classname, "player" )
;549:		  || streq( targ->s.v.classname, "building_sentrygun" )
;550:		  || streq( targ->s.v.classname, "building_dispenser" )
;551:		  || streq( targ->s.v.classname, "building_teleporter_entrance" )
;552:		  || streq( targ->s.v.classname, "building_teleporter_exit" ) ) )
;553:	{
line 554
;554:		if ( targ->team_no > 0 && targ->team_no == attacker->team_no
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
CNSTI4 960
ASGNI4
ADDRLP4 112
ADDRLP4 104
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 116
CNSTI4 0
ASGNI4
ADDRLP4 112
INDIRI4
ADDRLP4 116
INDIRI4
LEI4 $234
ADDRLP4 120
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 112
INDIRI4
ADDRLP4 120
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRI4
NEI4 $234
ADDRLP4 104
INDIRP4
CVPU4 4
ADDRLP4 120
INDIRP4
CVPU4 4
EQU4 $234
ADDRFP4 16
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 116
INDIRI4
EQI4 $234
line 556
;555:		     && targ != attacker && ( T_flags & TF_TD_NOTTEAM ) )
;556:		{
line 557
;557:			if ( T_AttackType & TF_TD_EXPLOSION )
ADDRFP4 20
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $236
line 558
;558:			{
line 559
;559:				if ( teamplay & TEAMPLAY_NOEXPLOSIVE )
ADDRGP4 teamplay
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $238
line 560
;560:					no_damage = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
ADDRGP4 $237
JUMPV
LABELV $238
line 562
;561:				else
;562:				{
line 563
;563:					if ( teamplay & TEAMPLAY_HALFEXPLOSIVE )
ADDRGP4 teamplay
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $237
line 564
;564:						take /= 2;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 565
;565:				}
line 566
;566:			} else
ADDRGP4 $237
JUMPV
LABELV $236
line 567
;567:			{
line 568
;568:				if ( teamplay & TEAMPLAY_NODIRECT )
ADDRGP4 teamplay
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $242
line 569
;569:					no_damage = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
ADDRGP4 $243
JUMPV
LABELV $242
line 571
;570:				else
;571:				{
line 572
;572:					if ( teamplay & TEAMPLAY_HALFDIRECT )
ADDRGP4 teamplay
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $244
line 573
;573:						take = take / 2;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
LABELV $244
line 574
;574:				}
LABELV $243
line 575
;575:			}
LABELV $237
line 576
;576:		}
LABELV $234
line 577
;577:	}
LABELV $228
line 578
;578:	if ( T_flags & TF_TD_NOTSELF )
ADDRFP4 16
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $246
line 579
;579:	{
line 580
;580:		if ( targ == attacker )
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $248
line 581
;581:			return;
ADDRGP4 $128
JUMPV
LABELV $248
line 582
;582:	}
LABELV $246
line 584
;583:	// do the damage, min 1
;584:	if ( take < 1 )
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $250
line 585
;585:		take = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
LABELV $250
line 586
;586:	take = rint( take );	//take = floor( take );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 104
ADDRGP4 rint
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 104
INDIRI4
CVIF4 4
ASGNF4
line 588
;587:
;588:	if ( !no_damage )
ADDRLP4 8
INDIRF4
CNSTF4 0
NEF4 $252
line 589
;589:	{
line 590
;590:		targ->s.v.health = targ->s.v.health - take;
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 591
;591:	}
LABELV $252
line 593
;592:
;593:	if ( streq( attacker->s.v.classname, "player" )
ADDRFP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 108
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
EQI4 $254
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 112
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
NEI4 $259
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $109
ARGP4
ADDRLP4 116
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
NEI4 $259
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $146
ARGP4
ADDRLP4 120
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $259
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $147
ARGP4
ADDRLP4 124
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
NEI4 $259
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $148
ARGP4
ADDRLP4 128
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
EQI4 $254
LABELV $259
line 599
;594:	     && ( streq( targ->s.v.classname, "player" )
;595:		  || streq( targ->s.v.classname, "building_sentrygun" )
;596:		  || streq( targ->s.v.classname, "building_dispenser" )
;597:		  || streq( targ->s.v.classname, "building_teleporter_entrance" )
;598:		  || streq( targ->s.v.classname, "building_teleporter_exit" ) ) )
;599:	{
line 600
;600:		if ( targ->team_no > 0 && targ->team_no == attacker->team_no
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 136
CNSTI4 960
ASGNI4
ADDRLP4 140
ADDRLP4 132
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRLP4 140
INDIRI4
ADDRLP4 144
INDIRI4
LEI4 $260
ADDRLP4 148
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 140
INDIRI4
ADDRLP4 148
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRI4
NEI4 $260
ADDRLP4 132
INDIRP4
CVPU4 4
ADDRLP4 148
INDIRP4
CVPU4 4
EQU4 $260
ADDRFP4 16
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 144
INDIRI4
EQI4 $260
line 602
;601:		     && targ != attacker && ( T_flags & TF_TD_NOTTEAM ) )
;602:		{
line 603
;603:			olddmsg = tf_data.deathmsg;
ADDRLP4 32
ADDRGP4 tf_data+88
INDIRI4
ASGNI4
line 604
;604:			if ( T_AttackType & TF_TD_EXPLOSION )
ADDRFP4 20
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $263
line 605
;605:			{
line 606
;606:				tf_data.deathmsg = DMSG_TEAMKILL;
ADDRGP4 tf_data+88
CNSTI4 37
ASGNI4
line 607
;607:				if ( teamplay & 16384 )
ADDRGP4 teamplay
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $266
line 608
;608:					TF_T_Damage( attacker, world, world, take, 1, 0 );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 world
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
ADDRGP4 $264
JUMPV
LABELV $266
line 610
;609:				else
;610:				{
line 611
;611:					if ( teamplay & 8192 )
ADDRGP4 teamplay
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $264
line 612
;612:						TF_T_Damage( attacker, world, world, take / 2, 1, 0 );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 world
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
ARGP4
ADDRLP4 156
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
DIVF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 613
;613:				}
line 614
;614:			} else
ADDRGP4 $264
JUMPV
LABELV $263
line 615
;615:			{
line 616
;616:				tf_data.deathmsg = DMSG_TEAMKILL;
ADDRGP4 tf_data+88
CNSTI4 37
ASGNI4
line 617
;617:				if ( teamplay & 4096 )
ADDRGP4 teamplay
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $271
line 618
;618:					TF_T_Damage( attacker, world, world, take, 1, 0 );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 world
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
ADDRGP4 $272
JUMPV
LABELV $271
line 620
;619:				else
;620:				{
line 621
;621:					if ( teamplay & 2048 )
ADDRGP4 teamplay
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $273
line 622
;622:						TF_T_Damage( attacker, world, world, take / 2, 1, 0 );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 world
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
ARGP4
ADDRLP4 156
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
DIVF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
LABELV $273
line 623
;623:				}
LABELV $272
line 624
;624:			}
LABELV $264
line 625
;625:			tf_data.deathmsg = olddmsg;
ADDRGP4 tf_data+88
ADDRLP4 32
INDIRI4
ASGNI4
line 626
;626:		}
LABELV $260
line 627
;627:	}
LABELV $254
line 628
;628:	if ( no_damage == 1 )
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
NEF4 $276
line 629
;629:		return;
ADDRGP4 $128
JUMPV
LABELV $276
line 630
;630:	if ( targ->s.v.armorvalue < 1 )
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $278
line 631
;631:	{
line 632
;632:		targ->armorclass = 0; // lost special armor
ADDRFP4 0
INDIRP4
CNSTI4 828
ADDP4
CNSTI4 0
ASGNI4
line 633
;633:		targ->s.v.armorvalue = 0;
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
CNSTF4 0
ASGNF4
line 634
;634:	}
LABELV $278
line 635
;635:	if ( targ->s.v.health <= 0 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $280
line 636
;636:	{
line 637
;637:		if ( streq( inflictor->s.v.classname, "detpack" )
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $284
ARGP4
ADDRLP4 132
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $282
ADDRLP4 136
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 1
NEI4 $282
ADDRLP4 136
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $282
line 639
;638:		     && inflictor->weaponmode == 1 && inflictor->s.v.enemy == EDICT_TO_PROG( targ ) )
;639:			tf_data.deathmsg = DMSG_DETPACK_DIS;
ADDRGP4 tf_data+88
CNSTI4 16
ASGNI4
LABELV $282
line 640
;640:		Killed( targ, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Killed
CALLV
pop
line 641
;641:		return;
ADDRGP4 $128
JUMPV
LABELV $280
line 644
;642:	}
;643:	// react to the damage
;644:	oldself = self;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
line 645
;645:	self = targ;
ADDRGP4 self
ADDRFP4 0
INDIRP4
ASGNP4
line 646
;646:	if ( self->th_pain )
ADDRGP4 self
INDIRP4
CNSTI4 816
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $286
line 647
;647:	{
line 648
;648:		self->th_pain( attacker, take );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 self
INDIRP4
CNSTI4 816
ADDP4
INDIRP4
CALLV
pop
line 650
;649:		// nightmare mode monsters don't go into pain frames often
;650:		if ( skill >= 3 )
ADDRGP4 skill
INDIRI4
CNSTI4 3
LTI4 $288
line 651
;651:			self->pain_finished = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 728
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
LABELV $288
line 652
;652:	}
LABELV $286
line 653
;653:	self = oldself;
ADDRGP4 self
ADDRLP4 12
INDIRP4
ASGNP4
line 654
;654:}
LABELV $128
endproc TF_T_Damage 160 24
export T_RadiusDamage
proc T_RadiusDamage 60 24
line 662
;655:
;656:/*
;657:============
;658:T_RadiusDamage
;659:============
;660:*/
;661:void T_RadiusDamage( gedict_t * inflictor, gedict_t * attacker, float damage, gedict_t * ignore )
;662:{
line 669
;663:	float   points;
;664:	gedict_t *head;
;665:
;666://      gedict_t *te;
;667:	vec3_t  org;
;668:
;669:	head = findradius( world, inflictor->s.v.origin, damage + 40 );
ADDRGP4 world
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRFP4 8
INDIRF4
CNSTF4 1109393408
ADDF4
ARGF4
ADDRLP4 20
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
ADDRGP4 $293
JUMPV
LABELV $292
line 671
;670:	while ( head )
;671:	{
line 672
;672:		if ( head != ignore )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 12
INDIRP4
CVPU4 4
EQU4 $295
line 673
;673:		{
line 674
;674:			if ( head->s.v.takedamage )
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $297
line 675
;675:			{
line 676
;676:				org[0] =
ADDRLP4 24
CNSTI4 156
ASGNI4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
SUBF4
ASGNF4
line 679
;677:				    inflictor->s.v.origin[0] - ( head->s.v.origin[0] +
;678:								 ( head->s.v.mins[0] + head->s.v.maxs[0] ) * 0.5 );
;679:				org[1] =
ADDRLP4 32
CNSTI4 160
ASGNI4
ADDRLP4 8+4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
SUBF4
ASGNF4
line 682
;680:				    inflictor->s.v.origin[1] - ( head->s.v.origin[1] +
;681:								 ( head->s.v.mins[1] + head->s.v.maxs[1] ) * 0.5 );
;682:				org[2] =
ADDRLP4 40
CNSTI4 164
ASGNI4
ADDRLP4 8+8
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
SUBF4
ASGNF4
line 685
;683:				    inflictor->s.v.origin[2] - ( head->s.v.origin[2] +
;684:								 ( head->s.v.mins[2] + head->s.v.maxs[2] ) * 0.5 );
;685:				points = 0.5 * vlen( org );
ADDRLP4 8
ARGP4
ADDRLP4 48
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 4
CNSTF4 1056964608
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 686
;686:				if ( points < 0 )
ADDRLP4 4
INDIRF4
CNSTF4 0
GEF4 $301
line 687
;687:					points = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
LABELV $301
line 688
;688:				points = damage - points;
ADDRLP4 4
ADDRFP4 8
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 689
;689:				if ( head == attacker )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $303
line 690
;690:					points = points * 0.75;
ADDRLP4 4
CNSTF4 1061158912
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
LABELV $303
line 691
;691:				if ( points > 0 )
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $305
line 692
;692:				{
line 693
;693:					if ( CanDamage( head, inflictor ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 CanDamage
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $307
line 694
;694:					{// shambler takes half damage from all explosions
line 695
;695:						if ( streq( head->s.v.classname, "monster_shambler" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $311
ARGP4
ADDRLP4 56
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $309
line 696
;696:							T_Damage( head, inflictor, attacker, points * 0.5 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1056964608
ADDRLP4 4
INDIRF4
MULF4
ARGF4
ADDRGP4 T_Damage
CALLV
pop
ADDRGP4 $310
JUMPV
LABELV $309
line 698
;697:						else
;698:							TF_T_Damage( head, inflictor, attacker, points, 2, 4 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
CNSTI4 2
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
LABELV $310
line 699
;699:					}
LABELV $307
line 700
;700:				}
LABELV $305
line 701
;701:			}
LABELV $297
line 702
;702:		}
LABELV $295
line 703
;703:		head = findradius( head, inflictor->s.v.origin, damage + 40 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRFP4 8
INDIRF4
CNSTF4 1109393408
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 704
;704:	}
LABELV $293
line 670
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $292
line 705
;705:}
LABELV $291
endproc T_RadiusDamage 60 24
export T_BeamDamage
proc T_BeamDamage 36 16
line 713
;706:
;707:/*
;708:============
;709:T_BeamDamage
;710:============
;711:*/
;712:void T_BeamDamage( gedict_t * attacker, float damage )
;713:{
line 718
;714:	vec3_t  tmpv;
;715:	float   points;
;716:	gedict_t *head;
;717:
;718:	head = findradius( world, attacker->s.v.origin, damage + 40 );
ADDRGP4 world
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRFP4 4
INDIRF4
CNSTF4 1109393408
ADDF4
ARGF4
ADDRLP4 20
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
ADDRGP4 $314
JUMPV
LABELV $313
line 720
;719:	while ( head )
;720:	{
line 721
;721:		if ( head->s.v.takedamage )
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $316
line 722
;722:		{
line 723
;723:			VectorSubtract( attacker->s.v.origin, head->s.v.origin, tmpv ) points = 0.5 * vlen( tmpv );
ADDRLP4 24
CNSTI4 156
ASGNI4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
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
ADDRLP4 8+4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
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
ADDRLP4 8+8
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8
ARGP4
ADDRLP4 24
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 4
CNSTF4 1056964608
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 724
;724:			if ( points < 0 )
ADDRLP4 4
INDIRF4
CNSTF4 0
GEF4 $320
line 725
;725:				points = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
LABELV $320
line 726
;726:			points = damage - points;
ADDRLP4 4
ADDRFP4 4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 727
;727:			if ( head == attacker )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $322
line 728
;728:				points = points * 0.5;
ADDRLP4 4
CNSTF4 1056964608
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
LABELV $322
line 729
;729:			if ( points > 0 )
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $324
line 730
;730:			{
line 731
;731:				if ( CanDamage( head, attacker ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 CanDamage
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $326
line 732
;732:					T_Damage( head, attacker, attacker, points );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 T_Damage
CALLV
pop
LABELV $326
line 733
;733:			}
LABELV $324
line 734
;734:		}
LABELV $316
line 735
;735:		head = findradius( head, attacker->s.v.origin, damage + 40 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRFP4 4
INDIRF4
CNSTF4 1109393408
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 736
;736:	}
LABELV $314
line 719
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $313
line 737
;737:}
LABELV $312
endproc T_BeamDamage 36 16
import ClientObituary
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
import Throw_Grapple
import Service_Grapple
import Reset_Grapple
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
bss
export damage_inflictor
align 4
LABELV damage_inflictor
skip 4
export damage_attacker
align 4
LABELV damage_attacker
skip 4
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
LABELV $311
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 109
byte 1 98
byte 1 108
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $284
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $148
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $147
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $146
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $135
byte 1 33
byte 1 33
byte 1 33
byte 1 66
byte 1 85
byte 1 71
byte 1 32
byte 1 66
byte 1 85
byte 1 71
byte 1 32
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 33
byte 1 33
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 84
byte 1 70
byte 1 95
byte 1 84
byte 1 68
byte 1 95
byte 1 78
byte 1 79
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $109
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $105
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $64
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $56
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
