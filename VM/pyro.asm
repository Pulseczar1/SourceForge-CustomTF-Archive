data
align 4
LABELV num_world_flames
byte 4 0
export FlameSpawn
code
proc FlameSpawn 28 28
file "..\src\pyro.c"
line 40
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
;21: *  $Id: pyro.c,v 1.14 2005/11/29 14:22:43 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:#define FLAME_PLYRMAXTIME 45
;25:void    NapalmGrenadeTouch(  );
;26:void    NapalmGrenadeLaunch( vec3_t org, gedict_t * shooter );
;27:void    Napalm_touch(  );
;28:int     RemoveFlameFromQueue( int id_flame );
;29:static int     num_world_flames = 0;
;30:
;31://** different types of flames (decreasing priority)
;32:
;33:// 1 : burning flames making light and damage (1 per players or monsters)
;34:// 2 : exploding flames (grenade)
;35:// 3 : burning flames (players, monsters)
;36:// 4 : world flames (on ground)
;37:
;38:// create a flame of a given type, maintaining the count for each type
;39:gedict_t *FlameSpawn( int type, gedict_t * p_owner )
;40:{
line 41
;41:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $12
line 42
;42:		return world;
ADDRGP4 world
INDIRP4
RETP4
ADDRGP4 $11
JUMPV
LABELV $12
line 47
;43:
;44:/*	if ( type != 1 && !tf_data.lan_mode )
;45:		return world;*/
;46:
;47:	num_world_flames = num_world_flames + 1;
ADDRLP4 0
ADDRGP4 num_world_flames
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $17
JUMPV
LABELV $16
line 49
;48:	while ( num_world_flames > FLAME_MAXWORLDNUM )
;49:	{
line 50
;50:		if ( !RemoveFlameFromQueue( type ) )
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 RemoveFlameFromQueue
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $19
line 51
;51:			return world;
ADDRGP4 world
INDIRP4
RETP4
ADDRGP4 $11
JUMPV
LABELV $19
line 52
;52:	}
LABELV $17
line 48
ADDRGP4 num_world_flames
INDIRI4
ADDRGP4 FLAME_MAXWORLDNUM
INDIRI4
GTI4 $16
line 53
;53:	newmis = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 4
INDIRP4
ASGNP4
line 55
;54:	// to keep track of the number of each type of flames
;55:	switch ( type )
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $21
ADDRLP4 8
INDIRI4
CNSTI4 4
GTI4 $21
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $32-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $32
address $23
address $26
address $28
address $30
code
line 56
;56:	{
LABELV $23
line 58
;57:	case 1:
;58:		newmis->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 59
;59:		newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 60
;60:		newmis->s.v.effects = 8;
ADDRGP4 newmis
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1090519040
ASGNF4
line 61
;61:		newmis->flame_id = "1";
ADDRGP4 newmis
INDIRP4
CNSTI4 1400
ADDP4
ADDRGP4 $24
ASGNP4
line 62
;62:		setmodel( newmis, "progs/flame2.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $25
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 63
;63:		setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 64
;64:		break;
ADDRGP4 $22
JUMPV
LABELV $26
line 66
;65:	case 2:
;66:		newmis->s.v.movetype = MOVETYPE_BOUNCE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 67
;67:		newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 68
;68:		newmis->flame_id = "2";
ADDRGP4 newmis
INDIRP4
CNSTI4 1400
ADDP4
ADDRGP4 $27
ASGNP4
line 69
;69:		setmodel( newmis, "progs/flame2.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $25
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 70
;70:		newmis->s.v.frame = 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1065353216
ASGNF4
line 71
;71:		setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 72
;72:		break;
ADDRGP4 $22
JUMPV
LABELV $28
line 74
;73:	case 3:
;74:		newmis->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 75
;75:		newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 76
;76:		newmis->flame_id = "3";
ADDRGP4 newmis
INDIRP4
CNSTI4 1400
ADDP4
ADDRGP4 $29
ASGNP4
line 77
;77:		setmodel( newmis, "progs/flame2.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $25
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 78
;78:		setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 20
CNSTF4 0
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
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 79
;79:		break;
ADDRGP4 $22
JUMPV
LABELV $30
line 81
;80:	case 4:
;81:		newmis->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 82
;82:		newmis->flame_id = "4";
ADDRGP4 newmis
INDIRP4
CNSTI4 1400
ADDP4
ADDRGP4 $31
ASGNP4
line 83
;83:		newmis->s.v.frame = 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1065353216
ASGNF4
line 84
;84:		newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 85
;85:		setmodel( newmis, "progs/flame2.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $25
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 86
;86:		setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 24
CNSTF4 0
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
line 87
;87:		break;
LABELV $21
LABELV $22
line 89
;88:	}
;89:	newmis->s.v.owner = EDICT_TO_PROG( p_owner );
ADDRGP4 newmis
INDIRP4
CNSTI4 480
ADDP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 90
;90:	return newmis;
ADDRGP4 newmis
INDIRP4
RETP4
LABELV $11
endproc FlameSpawn 28 28
export FlameDestroy
proc FlameDestroy 4 4
line 95
;91:}
;92:
;93:// destroy a given flame, maintaining counters and links in the queue
;94:void FlameDestroy( gedict_t * this )
;95:{
line 96
;96:	num_world_flames = num_world_flames - 1;
ADDRLP4 0
ADDRGP4 num_world_flames
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 97
;97:	dremove( this );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 98
;98:}
LABELV $34
endproc FlameDestroy 4 4
export RemoveFlameFromQueue
proc RemoveFlameFromQueue 24 12
line 101
;99:
;100:int RemoveFlameFromQueue( int id_flame )
;101:{
line 102
;102:	gedict_t *tmp = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 104
;103:
;104:	if ( num_world_flames < FLAME_MAXWORLDNUM )
ADDRGP4 num_world_flames
INDIRI4
ADDRGP4 FLAME_MAXWORLDNUM
INDIRI4
GEI4 $36
line 105
;105:	{
line 106
;106:		G_conprintf( "ERROR in RemoveFlameFromQueue\n" );
ADDRGP4 $38
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 107
;107:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $35
JUMPV
LABELV $36
line 111
;108:	}
;109:
;110:
;111:	switch ( id_flame )
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
LTI4 $39
ADDRLP4 4
INDIRI4
CNSTI4 4
GTI4 $39
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $45-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $45
address $41
address $42
address $43
address $44
code
line 112
;112:	{
LABELV $41
line 114
;113:	case 1:
;114:		tmp = trap_find( world, FOFS( flame_id ), "1" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 1400
ARGI4
ADDRGP4 $24
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 115
;115:		break;
ADDRGP4 $40
JUMPV
LABELV $42
line 117
;116:	case 2:
;117:		tmp = trap_find( world, FOFS( flame_id ), "2" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 1400
ARGI4
ADDRGP4 $27
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 118
;118:		break;
ADDRGP4 $40
JUMPV
LABELV $43
line 120
;119:	case 3:
;120:		tmp = trap_find( world, FOFS( flame_id ), "3" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 1400
ARGI4
ADDRGP4 $29
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 121
;121:		break;
ADDRGP4 $40
JUMPV
LABELV $44
line 123
;122:	case 4:
;123:		tmp = trap_find( world, FOFS( flame_id ), "4" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 1400
ARGI4
ADDRGP4 $31
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 124
;124:		break;
LABELV $39
LABELV $40
line 126
;125:	}
;126:	if ( !tmp )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $47
line 127
;127:	{
line 128
;128:		G_conprintf( "\n\nRemoveFlameFromQueue():BOOM!\n" );
ADDRGP4 $49
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 129
;129:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $35
JUMPV
LABELV $47
line 131
;130:	}
;131:	num_world_flames = num_world_flames - 1;
ADDRLP4 8
ADDRGP4 num_world_flames
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 132
;132:	ent_remove( tmp );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 133
;133:	return 1;
CNSTI4 1
RETI4
LABELV $35
endproc RemoveFlameFromQueue 24 12
export Remove
proc Remove 0 4
line 137
;134:}
;135:
;136:void Remove(  )
;137:{
line 138
;138:	FlameDestroy( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 FlameDestroy
CALLV
pop
line 139
;139:}
LABELV $50
endproc Remove 0 4
export NapalmGrenadeFollow
proc NapalmGrenadeFollow 24 32
line 143
;140:
;141:// function used by the flames spawned when the grenade explode : killed in water or when stopped
;142:void NapalmGrenadeFollow(  )
;143:{
line 144
;144:	traceline( PASSVEC3( self->s.v.origin ), PASSVEC3( self->s.v.origin ), 1, self );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 145
;145:	if ( g_globalvars.trace_inwater == 1 )
ADDRGP4 g_globalvars+312
INDIRF4
CNSTF4 1065353216
NEF4 $52
line 146
;146:	{
line 147
;147:		sound( self, 2, "misc/vapeur2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $55
ARGP4
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 148
;148:		FlameDestroy( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 FlameDestroy
CALLV
pop
line 149
;149:	}
LABELV $52
line 150
;150:	if ( VectorCompareF( self->s.v.velocity, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $56
line 151
;151:		FlameDestroy( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 FlameDestroy
CALLV
pop
LABELV $56
line 152
;152:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 153
;153:}
LABELV $51
endproc NapalmGrenadeFollow 24 32
export NapalmGrenadeTouch
proc NapalmGrenadeTouch 12 20
line 156
;154:
;155:void NapalmGrenadeTouch(  )
;156:{
line 157
;157:	sound( self, 1, "weapons/bounce.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $60
ARGP4
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 158
;158:	if ( VectorCompareF( self->s.v.velocity, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $61
line 159
;159:		SetVector( self->s.v.avelocity, 0, 0, 0 );
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
LABELV $61
line 160
;160:}
LABELV $59
endproc NapalmGrenadeTouch 12 20
export NapalmGrenadeNetThink
proc NapalmGrenadeNetThink 16 24
line 163
;161:
;162:void NapalmGrenadeNetThink(  )
;163:{
line 166
;164:	gedict_t *head;
;165:
;166:	self->s.v.nextthink = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 167
;167:	for ( head = world; (head = findradius( head, self->s.v.origin, 180 )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $68
JUMPV
LABELV $65
line 168
;168:	{
line 169
;169:		if ( head->s.v.takedamage )
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $69
line 170
;170:		{
line 171
;171:			tf_data.deathmsg = DMSG_FLAME;
ADDRGP4 tf_data+88
CNSTI4 15
ASGNI4
line 172
;172:			TF_T_Damage( head, self, PROG_TO_EDICT( self->s.v.owner ), 20, 2, 16 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
CNSTI4 2
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 173
;173:			other = head;
ADDRGP4 other
ADDRLP4 0
INDIRP4
ASGNP4
line 174
;174:			Napalm_touch(  );
ADDRGP4 Napalm_touch
CALLV
pop
line 175
;175:			if ( streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $74
ARGP4
ADDRLP4 8
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $72
line 176
;176:				stuffcmd( other, "bf\nbf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $75
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $72
line 177
;177:		}
LABELV $69
line 178
;178:	}
LABELV $66
line 167
LABELV $68
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTF4 1127481344
ARGF4
ADDRLP4 4
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $65
line 179
;179:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 180
;180:	trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 181
;181:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 182
;182:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 183
;183:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 184
;184:	trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 185
;185:	self->heat = self->heat + 1;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 186
;186:	if ( self->heat > 7 )
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 1088421888
LEF4 $76
line 187
;187:	{
line 188
;188:		dremove( PROG_TO_EDICT( self->s.v.enemy ) );
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 189
;189:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 190
;190:	}
LABELV $76
line 191
;191:}
LABELV $63
endproc NapalmGrenadeNetThink 16 24
export NapalmGrenadeExplode
proc NapalmGrenadeExplode 68 32
line 194
;192:
;193:void NapalmGrenadeExplode(  )
;194:{
line 199
;195://      float   i;
;196:	gedict_t *head;
;197:	float   i;
;198:	vec3_t  tmp;
;199:	if( !tf_data.lan_mode )
ADDRGP4 tf_data+176
INDIRI4
CNSTI4 0
NEI4 $79
line 200
;200:	{
line 201
;201:        	sound( self, 0, "weapons/flmgrexp.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $82
ARGP4
ADDRLP4 20
CNSTF4 1065353216
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 202
;202:        	traceline( PASSVEC3( self->s.v.origin ), PASSVEC3( self->s.v.origin ), 1, self );
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 36
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 203
;203:        	if ( g_globalvars.trace_inwater == 1 )
ADDRGP4 g_globalvars+312
INDIRF4
CNSTF4 1065353216
NEF4 $83
line 204
;204:        	{
line 205
;205:        		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 206
;206:        		return;
ADDRGP4 $78
JUMPV
LABELV $83
line 209
;207:        	}
;208:        	// do an incendiary-cannon explosion instead
;209:        	self->s.v.effects = ( int ) self->s.v.effects | 8;
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 8
BORI4
CVIF4 4
ASGNF4
line 213
;210:        
;211:        	// don't do radius damage to the other, because all the damage
;212:        	// was done in the impact
;213:        	for ( head = world; (head = findradius( head, self->s.v.origin, 180 )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $89
JUMPV
LABELV $86
line 214
;214:        	{
line 215
;215:        		if ( head->s.v.takedamage )
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $90
line 216
;216:        		{
line 217
;217:        			tf_data.deathmsg = DMSG_FLAME;
ADDRGP4 tf_data+88
CNSTI4 15
ASGNI4
line 218
;218:        			TF_T_Damage( head, self, PROG_TO_EDICT( self->s.v.owner ), 40, 2, 16 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1109393408
ARGF4
CNSTI4 2
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 220
;219:        			// set 'em on fire
;220:        			other = head;// i can't believe this works!
ADDRGP4 other
ADDRLP4 0
INDIRP4
ASGNP4
line 221
;221:        			Napalm_touch(  );
ADDRGP4 Napalm_touch
CALLV
pop
line 222
;222:        			if ( streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $74
ARGP4
ADDRLP4 48
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $93
line 223
;223:        				stuffcmd( other, "bf\nbf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $75
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $93
line 224
;224:        		}
LABELV $90
line 225
;225:        	}
LABELV $87
line 213
LABELV $89
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTF4 1127481344
ARGF4
ADDRLP4 44
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 44
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $86
line 226
;226:        	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 227
;227:        	trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 228
;228:        	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 229
;229:        	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 230
;230:        	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 231
;231:        	trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 48
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 48
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 232
;232:        	head = spawn(  );
ADDRLP4 52
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 52
INDIRP4
ASGNP4
line 233
;233:        	head->s.v.think = ( func_t ) NapalmGrenadeNetThink;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 NapalmGrenadeNetThink
CVPU4 4
CVUI4 4
ASGNI4
line 234
;234:        	head->s.v.nextthink = g_globalvars.time + 1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 235
;235:        	head->heat = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 0
ASGNF4
line 236
;236:        	VectorCopy( self->s.v.origin, head->s.v.origin );
ADDRLP4 56
CNSTI4 156
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 60
CNSTI4 160
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 64
CNSTI4 164
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 237
;237:        	head->s.v.owner = self->s.v.owner;
ADDRLP4 56
CNSTI4 480
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 238
;238:        	head->team_no = PROG_TO_EDICT( self->s.v.owner )->team_no;
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
ASGNI4
line 239
;239:        	head->s.v.enemy = EDICT_TO_PROG( self );
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 241
;240:        ///Napalm fix
;241:        	self->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 242
;242:        	SetVector( self->s.v.velocity, 0, 0, 0 );
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
line 243
;243:	}else
ADDRGP4 $80
JUMPV
LABELV $79
line 244
;244:	{
line 245
;245:        	sound( self, 0, "weapons/flmgrexp.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $82
ARGP4
ADDRLP4 20
CNSTF4 1065353216
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 246
;246:        	traceline( PASSVEC3( self->s.v.origin ), PASSVEC3( self->s.v.origin ), 1, self );
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 36
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 247
;247:        	if ( g_globalvars.trace_inwater == 1 )
ADDRGP4 g_globalvars+312
INDIRF4
CNSTF4 1065353216
NEF4 $97
line 248
;248:        	{
line 249
;249:        		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 250
;250:        		return;
ADDRGP4 $78
JUMPV
LABELV $97
line 252
;251:        	}
;252:        	tf_data.deathmsg = DMSG_FLAME;
ADDRGP4 tf_data+88
CNSTI4 15
ASGNI4
line 253
;253:        	T_RadiusDamage( self, PROG_TO_EDICT( self->s.v.owner ), 20, world );
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 254
;254:        	i = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 255
;255:        	VectorCopy( self->s.v.origin, tmp );
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 256
;256:        	tmp[2] += 5;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
ADDRGP4 $105
JUMPV
LABELV $104
line 258
;257:        	while ( i < 15 )
;258:        	{
line 259
;259:        		NapalmGrenadeLaunch( tmp, PROG_TO_EDICT( self->s.v.owner ) );
ADDRLP4 8
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRGP4 NapalmGrenadeLaunch
CALLV
pop
line 260
;260:        		i = i + 1;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 261
;261:        	}
LABELV $105
line 257
ADDRLP4 4
INDIRF4
CNSTF4 1097859072
LTF4 $104
line 262
;262:        	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 263
;263:        	BecomeExplosion(  );
ADDRGP4 BecomeExplosion
CALLV
pop
line 264
;264:	}
LABELV $80
line 265
;265:}
LABELV $78
endproc NapalmGrenadeExplode 68 32
export NapalmGrenadeLaunch
proc NapalmGrenadeLaunch 44 28
line 270
;266:
;267://=========================================================================
;268:// Launch a flame foe the grenade explosion
;269:void NapalmGrenadeLaunch( vec3_t org, gedict_t * shooter )
;270:{
line 276
;271:	float   xdir;
;272:	float   ydir;
;273:	float   zdir;
;274:	float   spin;
;275:
;276:	xdir = 150 * g_random(  ) - 75;
ADDRLP4 16
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
CNSTF4 1125515264
ADDRLP4 16
INDIRF4
MULF4
CNSTF4 1117126656
SUBF4
ASGNF4
line 277
;277:	ydir = 150 * g_random(  ) - 75;
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 8
CNSTF4 1125515264
ADDRLP4 20
INDIRF4
MULF4
CNSTF4 1117126656
SUBF4
ASGNF4
line 278
;278:	zdir = 40 * g_random(  );
ADDRLP4 24
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 12
CNSTF4 1109393408
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 279
;279:	newmis = FlameSpawn( 2, shooter );
CNSTI4 2
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 FlameSpawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 28
INDIRP4
ASGNP4
line 280
;280:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 282
;281:
;282:	if ( newmis == world )
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $109
line 283
;283:		return;
ADDRGP4 $107
JUMPV
LABELV $109
line 284
;284:	self->s.v.touch = ( func_t ) SUB_Null;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 285
;285:	newmis->s.v.classname = "fire";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $111
ASGNP4
line 286
;286:	newmis->s.v.touch = ( func_t ) Napalm_touch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 Napalm_touch
CVPU4 4
CVUI4 4
ASGNI4
line 287
;287:	newmis->s.v.think = ( func_t ) NapalmGrenadeFollow;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 NapalmGrenadeFollow
CVPU4 4
CVUI4 4
ASGNI4
line 288
;288:	newmis->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 289
;289:	newmis->s.v.enemy = shooter->s.v.owner;
ADDRGP4 newmis
INDIRP4
CNSTI4 400
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
line 290
;290:	newmis->s.v.velocity[0] = xdir * 2;
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1073741824
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 291
;291:	newmis->s.v.velocity[1] = ydir * 2;
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1073741824
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 292
;292:	newmis->s.v.velocity[2] = zdir * 15;
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1097859072
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 293
;293:	spin = ( int ) ( g_random(  ) * 10 / 2 );
ADDRLP4 32
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1092616192
ADDRLP4 32
INDIRF4
MULF4
CNSTF4 1073741824
DIVF4
CVFI4 4
CVIF4 4
ASGNF4
line 294
;294:	if ( spin <= 0 )
ADDRLP4 0
INDIRF4
CNSTF4 0
GTF4 $113
line 295
;295:		SetVector( newmis->s.v.avelocity, 250, 300, 400 );
ADDRGP4 newmis
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1132068864
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1133903872
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1137180672
ASGNF4
LABELV $113
line 296
;296:	if ( spin == 1 )
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $115
line 297
;297:		SetVector( newmis->s.v.avelocity, 400, 250, 300 );
ADDRGP4 newmis
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1137180672
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1132068864
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1133903872
ASGNF4
LABELV $115
line 298
;298:	if ( spin == 2 )
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $117
line 299
;299:		SetVector( newmis->s.v.avelocity, 300, 400, 250 );
ADDRGP4 newmis
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1133903872
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1137180672
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1132068864
ASGNF4
LABELV $117
line 300
;300:	if ( spin == 3 )
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
NEF4 $119
line 301
;301:		SetVector( newmis->s.v.avelocity, 300, 300, 300 );
ADDRGP4 newmis
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1133903872
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1133903872
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1133903872
ASGNF4
LABELV $119
line 302
;302:	if ( spin >= 4 )
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
LTF4 $121
line 303
;303:		SetVector( newmis->s.v.avelocity, 400, 250, 400 );
ADDRGP4 newmis
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1137180672
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1132068864
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1137180672
ASGNF4
LABELV $121
line 304
;304:	setorigin( newmis, PASSVEC3( org ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 305
;305:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 40
CNSTF4 0
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 306
;306:}
LABELV $107
endproc NapalmGrenadeLaunch 44 28
export FlameFollow
proc FlameFollow 80 24
line 312
;307:
;308:
;309:void    OnPlayerFlame_touch(  );
;310:
;311:void FlameFollow(  )
;312:{
line 317
;313:	vec3_t  dir;
;314:	vec3_t  vtemp;
;315:	vec3_t  boundsize;
;316:	float   damage;
;317:	gedict_t *enemy = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 319
;318:
;319:	VectorCopy( enemy->s.v.absmin, vtemp );
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
ASGNF4
line 320
;320:	VectorCopy( enemy->s.v.size, boundsize );
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
ASGNF4
line 321
;321:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 322
;322:	self->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 323
;323:	if ( !enemy->numflames )
ADDRLP4 0
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CNSTI4 0
NEI4 $128
line 324
;324:	{
line 325
;325:		FlameDestroy( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 FlameDestroy
CALLV
pop
line 326
;326:		return;
ADDRGP4 $123
JUMPV
LABELV $128
line 328
;327:	}
;328:	if ( enemy->s.v.health < 1 )
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $130
line 329
;329:	{
line 330
;330:		tf_data.deathmsg = DMSG_FLAME;
ADDRGP4 tf_data+88
CNSTI4 15
ASGNI4
line 331
;331:		T_RadiusDamage( self, self, 10, self );
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
CNSTF4 1092616192
ARGF4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 332
;332:		enemy->numflames = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1396
ADDP4
CNSTI4 0
ASGNI4
line 333
;333:		FlameDestroy( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 FlameDestroy
CALLV
pop
line 334
;334:		return;
ADDRGP4 $123
JUMPV
LABELV $130
line 336
;335:	}
;336:	if ( ( enemy->armorclass & AT_SAVEFIRE ) && enemy->s.v.armorvalue > 0 )
ADDRLP4 0
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $133
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
CNSTF4 0
LEF4 $133
line 337
;337:		self->s.v.health = 0;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 0
ASGNF4
LABELV $133
line 339
;338:
;339:	if ( enemy->tfstate & 131072 )
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $135
line 340
;340:	{
line 341
;341:		self->s.v.health = FLAME_PLYRMAXTIME;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1110704128
ASGNF4
line 342
;342:		enemy->tfstate = enemy->tfstate - ( enemy->tfstate & 131072 );
ADDRLP4 48
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRP4
ADDRLP4 52
INDIRI4
ADDRLP4 52
INDIRI4
CNSTI4 131072
BANDI4
SUBI4
ASGNI4
line 343
;343:	}
LABELV $135
line 344
;344:	if ( self->s.v.health < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $137
line 345
;345:	{
line 347
;346:	        // only remove the flame if it is not the master flame, or if it is the last flame
;347:		if ( self->s.v.effects != EF_DIMLIGHT || enemy->numflames <= 1 )
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1090519040
NEF4 $141
ADDRLP4 0
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CNSTI4 1
GTI4 $139
LABELV $141
line 348
;348:		{
line 349
;349:			enemy->numflames = enemy->numflames - 1;
ADDRLP4 48
ADDRLP4 0
INDIRP4
CNSTI4 1396
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 350
;350:			enemy->numflames = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1396
ADDP4
CNSTI4 0
ASGNI4
line 351
;351:			FlameDestroy( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 FlameDestroy
CALLV
pop
line 352
;352:			return;
ADDRGP4 $123
JUMPV
LABELV $139
line 354
;353:		}
;354:	}
LABELV $137
line 355
;355:	self->s.v.health = self->s.v.health - 1;
ADDRLP4 48
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 356
;356:	if ( vlen( enemy->s.v.velocity ) < 50 )
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 52
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 1112014848
GEF4 $142
line 357
;357:	{
line 358
;358:		dir[0] = g_random(  ) * boundsize[0] / 2 + boundsize[0] / 4;
ADDRLP4 56
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 60
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 28
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
CNSTF4 1073741824
DIVF4
ADDRLP4 60
INDIRF4
CNSTF4 1082130432
DIVF4
ADDF4
ASGNF4
line 359
;359:		dir[1] = g_random(  ) * boundsize[1] / 2 + boundsize[1] / 4;
ADDRLP4 64
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 64
INDIRF4
ADDRLP4 16+4
INDIRF4
MULF4
CNSTF4 1073741824
DIVF4
ADDRLP4 16+4
INDIRF4
CNSTF4 1082130432
DIVF4
ADDF4
ASGNF4
line 360
;360:		dir[2] = g_random(  ) * boundsize[2] / 3 + boundsize[2] / 2;
ADDRLP4 68
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 28+8
ADDRLP4 68
INDIRF4
ADDRLP4 16+8
INDIRF4
MULF4
CNSTF4 1077936128
DIVF4
ADDRLP4 16+8
INDIRF4
CNSTF4 1073741824
DIVF4
ADDF4
ASGNF4
line 361
;361:		VectorAdd( vtemp, dir, vtemp );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDF4
ASGNF4
line 362
;362:		setorigin( self, PASSVEC3( vtemp ) );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 363
;363:		if ( strneq( self->s.v.model, "progs/flame2.mdl" ) )
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 $25
ARGP4
ADDRLP4 72
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $143
line 364
;364:		{
line 365
;365:			self->s.v.model = "progs/flame2.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $25
ASGNP4
line 366
;366:			setmodel( self, self->s.v.model );
ADDRLP4 76
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 367
;367:		}
line 368
;368:	} else
ADDRGP4 $143
JUMPV
LABELV $142
line 369
;369:	{
line 370
;370:		if ( streq( self->s.v.model, "progs/flame2.mdl" ) )
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 $25
ARGP4
ADDRLP4 56
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $160
line 371
;371:		{
line 372
;372:			self->s.v.model = "";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $162
ASGNP4
line 373
;373:			setmodel( self, self->s.v.model );
ADDRLP4 60
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 374
;374:		}
LABELV $160
line 375
;375:	}
LABELV $143
line 376
;376:	if ( enemy->s.v.waterlevel > 1 )
ADDRLP4 0
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $163
line 377
;377:	{
line 378
;378:		sound( self, 2, "misc/vapeur2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $55
ARGP4
ADDRLP4 56
CNSTF4 1065353216
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 379
;379:		enemy->numflames = enemy->numflames - 1;
ADDRLP4 60
ADDRLP4 0
INDIRP4
CNSTI4 1396
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 380
;380:		FlameDestroy( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 FlameDestroy
CALLV
pop
line 381
;381:		return;
ADDRGP4 $123
JUMPV
LABELV $163
line 383
;382:	}
;383:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 384
;384:	if ( self->s.v.effects == EF_DIMLIGHT && self->heat >= 3 )
ADDRLP4 56
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1090519040
NEF4 $166
ADDRLP4 56
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 1077936128
LTF4 $166
line 385
;385:	{
line 386
;386:		damage = enemy->numflames * 0.3 * 3;
ADDRLP4 40
CNSTF4 1077936128
CNSTF4 1050253722
ADDRLP4 0
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CVIF4 4
MULF4
MULF4
ASGNF4
line 387
;387:		if ( damage < 1 )
ADDRLP4 40
INDIRF4
CNSTF4 1065353216
GEF4 $168
line 388
;388:			damage = 1;
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
LABELV $168
line 389
;389:		self->heat = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 1065353216
ASGNF4
line 390
;390:		tf_data.deathmsg = DMSG_FLAME;
ADDRGP4 tf_data+88
CNSTI4 15
ASGNI4
line 391
;391:		TF_T_Damage( enemy, self, PROG_TO_EDICT( self->s.v.owner ), damage, 2, 16 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRLP4 40
INDIRF4
ARGF4
CNSTI4 2
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 392
;392:	} else
ADDRGP4 $167
JUMPV
LABELV $166
line 393
;393:	{
line 394
;394:		if ( self->s.v.effects == EF_DIMLIGHT )
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1090519040
NEF4 $171
line 395
;395:			self->heat = self->heat + 1;
ADDRLP4 60
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $171
line 396
;396:	}
LABELV $167
line 397
;397:}
LABELV $123
endproc FlameFollow 80 24
export OnPlayerFlame_touch
proc OnPlayerFlame_touch 32 20
line 401
;398:
;399:// OnPlayerflame : no damage if enemy not dead, spawn flames if touched
;400:void OnPlayerFlame_touch(  )
;401:{
line 406
;402:	gedict_t *flame;
;403:
;404://      vec3_t  vtemp;
;405:
;406:	if ( other != world && other->s.v.health > 0 && other != PROG_TO_EDICT( self->s.v.enemy ) )
ADDRLP4 4
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 8
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $174
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $174
ADDRLP4 8
INDIRU4
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
EQU4 $174
line 407
;407:	{
line 408
;408:		if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $176
line 409
;409:			return;
ADDRGP4 $173
JUMPV
LABELV $176
line 410
;410:		if ( other->numflames >= 4 )
ADDRGP4 other
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CNSTI4 4
LTI4 $180
line 411
;411:		{
line 412
;412:			other->tfstate = other->tfstate | 131072;
ADDRLP4 12
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 413
;413:			return;
ADDRGP4 $173
JUMPV
LABELV $180
line 415
;414:		}
;415:		if ( streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $74
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $182
line 416
;416:		{
line 417
;417:			if ( ( teamplay & 16 ) && other->team_no > 0
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 teamplay
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 16
INDIRI4
EQI4 $184
ADDRLP4 20
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 16
INDIRI4
LEI4 $184
ADDRLP4 20
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
NEI4 $184
line 419
;418:			     && other->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no )
;419:				return;
ADDRGP4 $173
JUMPV
LABELV $184
line 420
;420:			CenterPrint( other, "You are on fire!\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $187
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 421
;421:			stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $188
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 422
;422:		}
LABELV $182
line 423
;423:		if ( other->numflames < 1 )
ADDRGP4 other
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CNSTI4 1
GEI4 $189
line 424
;424:		{
line 425
;425:			flame = FlameSpawn( 1, other );
CNSTI4 1
ARGI4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 FlameSpawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 426
;426:			sound( flame, 2, "ambience/fire1.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $191
ARGP4
ADDRLP4 20
CNSTF4 1065353216
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 427
;427:		} else
ADDRGP4 $190
JUMPV
LABELV $189
line 428
;428:		{
line 429
;429:			flame = FlameSpawn( 3, other );
CNSTI4 3
ARGI4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 FlameSpawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 430
;430:			if ( flame == world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $192
line 431
;431:				return;
ADDRGP4 $173
JUMPV
LABELV $192
line 432
;432:		}
LABELV $190
line 433
;433:		flame->s.v.classname = "fire";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $111
ASGNP4
line 434
;434:		flame->s.v.health = FLAME_PLYRMAXTIME;
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1110704128
ASGNF4
line 435
;435:		other->numflames = other->numflames + 1;
ADDRLP4 16
ADDRGP4 other
INDIRP4
CNSTI4 1396
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 436
;436:		VectorCopy( other->s.v.velocity, flame->s.v.velocity );
ADDRLP4 20
CNSTI4 180
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
CNSTI4 184
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
CNSTI4 188
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 437
;437:		flame->s.v.enemy = EDICT_TO_PROG( other );
ADDRLP4 0
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
line 438
;438:		flame->s.v.touch = ( func_t ) OnPlayerFlame_touch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 OnPlayerFlame_touch
CVPU4 4
CVUI4 4
ASGNI4
line 439
;439:		flame->s.v.owner = self->s.v.owner;
ADDRLP4 20
CNSTI4 480
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 440
;440:		setorigin( flame, PASSVEC3( self->s.v.origin ) );
ADDRLP4 0
INDIRP4
ARGP4
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
ADDRGP4 setorigin
CALLV
pop
line 441
;441:		flame->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 442
;442:		flame->s.v.think = ( func_t ) FlameFollow;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 FlameFollow
CVPU4 4
CVUI4 4
ASGNI4
line 443
;443:	}
LABELV $174
line 444
;444:}
LABELV $173
endproc OnPlayerFlame_touch 32 20
export QW_Flame_ResetTouch
proc QW_Flame_ResetTouch 4 0
line 450
;445:
;446:
;447:void    WorldFlame_touch(  );
;448:
;449:void QW_Flame_ResetTouch(  )
;450:{
line 451
;451:	self->s.v.touch = ( func_t ) WorldFlame_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 WorldFlame_touch
CVPU4 4
CVUI4 4
ASGNI4
line 452
;452:	self->s.v.think = ( func_t ) Remove;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 Remove
CVPU4 4
CVUI4 4
ASGNI4
line 453
;453:	self->s.v.nextthink = self->heat;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
ASGNF4
line 454
;454:}
LABELV $195
endproc QW_Flame_ResetTouch 4 0
export WorldFlame_touch
proc WorldFlame_touch 44 24
line 457
;455:// worldflame : lot of damage, spawn flames if touched
;456:void WorldFlame_touch(  )
;457:{
line 463
;458:	gedict_t *flame;
;459:
;460://      vec3_t  dir;
;461:	vec3_t  vtemp;
;462:
;463:	tf_data.deathmsg = DMSG_FLAME;
ADDRGP4 tf_data+88
CNSTI4 15
ASGNI4
line 464
;464:	TF_T_Damage( other, self, PROG_TO_EDICT( self->s.v.enemy ), 10, 2, 16 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1092616192
ARGF4
CNSTI4 2
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 465
;465:	self->s.v.touch = ( func_t ) SUB_Null;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 466
;466:	if ( self->heat > g_globalvars.time + 1 )
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
LEF4 $198
line 467
;467:	{
line 468
;468:		self->s.v.think = ( func_t ) QW_Flame_ResetTouch;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 QW_Flame_ResetTouch
CVPU4 4
CVUI4 4
ASGNI4
line 469
;469:		self->s.v.nextthink = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 470
;470:	}
LABELV $198
line 471
;471:	if ( other != world && other->s.v.solid != 1 && other->s.v.health > 0 )
ADDRLP4 20
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $202
ADDRLP4 20
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
CNSTF4 1065353216
EQF4 $202
ADDRLP4 20
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $202
line 472
;472:	{
line 473
;473:		if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $204
line 474
;474:			return;
ADDRGP4 $196
JUMPV
LABELV $204
line 475
;475:		if ( other->numflames >= 4 )
ADDRGP4 other
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CNSTI4 4
LTI4 $208
line 476
;476:		{
line 477
;477:			other->tfstate = other->tfstate | 131072;
ADDRLP4 24
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 478
;478:			return;
ADDRGP4 $196
JUMPV
LABELV $208
line 480
;479:		}
;480:		if ( streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $74
ARGP4
ADDRLP4 24
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $210
line 481
;481:		{
line 482
;482:			if ( ( teamplay & 16 ) && other->team_no > 0
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRGP4 teamplay
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 28
INDIRI4
EQI4 $212
ADDRLP4 32
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $212
ADDRLP4 32
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
NEI4 $212
line 484
;483:			     && other->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no )
;484:				return;
ADDRGP4 $196
JUMPV
LABELV $212
line 485
;485:			CenterPrint( other, "You are on fire!\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $187
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 486
;486:			stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $188
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 487
;487:		}
LABELV $210
line 488
;488:		if ( other->numflames < 1 )
ADDRGP4 other
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CNSTI4 1
GEI4 $215
line 489
;489:		{
line 490
;490:			flame = FlameSpawn( 1, other );
CNSTI4 1
ARGI4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 FlameSpawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 491
;491:			sound( flame, 2, "ambience/fire1.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $191
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
line 492
;492:		} else
ADDRGP4 $216
JUMPV
LABELV $215
line 493
;493:		{
line 494
;494:			flame = FlameSpawn( 3, other );
CNSTI4 3
ARGI4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 FlameSpawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 495
;495:			if ( flame == world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $217
line 496
;496:				return;
ADDRGP4 $196
JUMPV
LABELV $217
line 497
;497:		}
LABELV $216
line 498
;498:		flame->s.v.classname = "fire";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $111
ASGNP4
line 499
;499:		flame->s.v.health = 0;
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 0
ASGNF4
line 500
;500:		other->numflames = other->numflames + 1;
ADDRLP4 28
ADDRGP4 other
INDIRP4
CNSTI4 1396
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 501
;501:		VectorCopy( other->s.v.velocity, flame->s.v.velocity );
ADDRLP4 32
CNSTI4 180
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 36
CNSTI4 184
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 40
CNSTI4 188
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 502
;502:		flame->s.v.enemy = EDICT_TO_PROG( other );
ADDRLP4 0
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
line 503
;503:		flame->s.v.touch = ( func_t ) OnPlayerFlame_touch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 OnPlayerFlame_touch
CVPU4 4
CVUI4 4
ASGNI4
line 504
;504:		flame->s.v.owner = self->s.v.owner;
ADDRLP4 32
CNSTI4 480
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 505
;505:		VectorCopy( self->s.v.origin, vtemp );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 506
;506:		vtemp[2] += 10;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 507
;507:		setorigin( flame, PASSVEC3( vtemp ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 508
;508:		flame->s.v.nextthink = g_globalvars.time + 0.15;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1041865114
ADDF4
ASGNF4
line 509
;509:		flame->s.v.think = ( func_t ) FlameFollow;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 FlameFollow
CVPU4 4
CVUI4 4
ASGNI4
line 510
;510:	}
LABELV $202
line 511
;511:}
LABELV $196
endproc WorldFlame_touch 44 24
export Flamer_stream_touch
proc Flamer_stream_touch 64 24
line 515
;512:
;513:// first touch : direct touch with the flamer stream or flame from grenade
;514:void Flamer_stream_touch(  )
;515:{
line 522
;516:	gedict_t *flame;
;517:
;518://      vec3_t  dir;
;519:	vec3_t  vtemp;
;520:	int pos;
;521:    
;522:	VectorCopy( self->s.v.origin , vtemp);
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 523
;523:	vtemp[2]++;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 524
;524:	pos = trap_pointcontents( PASSVEC3( vtemp));
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 526
;525:
;526:	if( pos == CONTENT_WATER || pos == CONTENT_SLIME )
ADDRLP4 16
INDIRI4
CNSTI4 -3
EQI4 $233
ADDRLP4 16
INDIRI4
CNSTI4 -4
NEI4 $231
LABELV $233
line 527
;527:	{
line 528
;528:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 529
;529:		return;
ADDRGP4 $225
JUMPV
LABELV $231
line 532
;530:	}
;531:
;532:	if ( streq( other->s.v.classname, "fire" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $111
ARGP4
ADDRLP4 28
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $234
line 533
;533:		return;
ADDRGP4 $225
JUMPV
LABELV $234
line 534
;534:	if ( other != world )
ADDRGP4 other
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $236
line 535
;535:	{
line 536
;536:		if ( other->s.v.takedamage == DAMAGE_AIM && other->s.v.health > 0 )
ADDRLP4 32
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $237
ADDRLP4 32
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $237
line 537
;537:		{
line 538
;538:			tf_data.deathmsg = DMSG_FLAME;
ADDRGP4 tf_data+88
CNSTI4 15
ASGNI4
line 539
;539:			TF_T_Damage( other, self, PROG_TO_EDICT( self->s.v.owner ), 10, TF_TD_NOTTEAM, TF_TD_FIRE );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1092616192
ARGF4
CNSTI4 2
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 540
;540:			if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $241
line 541
;541:				return;
ADDRGP4 $225
JUMPV
LABELV $241
line 542
;542:			if ( other->numflames >= 4 )
ADDRGP4 other
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CNSTI4 4
LTI4 $245
line 543
;543:			{
line 544
;544:				other->tfstate = other->tfstate | 131072;
ADDRLP4 40
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 545
;545:				return;
ADDRGP4 $225
JUMPV
LABELV $245
line 547
;546:			}
;547:			if ( ( other->armorclass & AT_SAVEFIRE ) && other->s.v.armorvalue > 0 )
ADDRLP4 40
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $247
ADDRLP4 40
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
CNSTF4 0
LEF4 $247
line 548
;548:				return;
ADDRGP4 $225
JUMPV
LABELV $247
line 549
;549:			if ( streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $74
ARGP4
ADDRLP4 44
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $249
line 550
;550:			{
line 551
;551:				if ( ( teamplay & TEAMPLAY_NOEXPLOSIVE ) && other->team_no > 0
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRGP4 teamplay
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 48
INDIRI4
EQI4 $251
ADDRLP4 52
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 48
INDIRI4
LEI4 $251
ADDRLP4 52
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
NEI4 $251
line 553
;552:				     && other->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no )
;553:					return;
ADDRGP4 $225
JUMPV
LABELV $251
line 554
;554:				CenterPrint( other, "You are on fire!\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $187
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 555
;555:				stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $188
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 556
;556:			}
LABELV $249
line 557
;557:			if ( other->numflames < 1 )
ADDRGP4 other
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CNSTI4 1
GEI4 $254
line 558
;558:			{
line 559
;559:				flame = FlameSpawn( 1, other );
CNSTI4 1
ARGI4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 FlameSpawn
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 48
INDIRP4
ASGNP4
line 560
;560:				sound( flame, 2, "ambience/fire1.wav", 1, 1 );
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $191
ARGP4
ADDRLP4 52
CNSTF4 1065353216
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 561
;561:			} else
ADDRGP4 $255
JUMPV
LABELV $254
line 562
;562:			{
line 563
;563:				flame = FlameSpawn( 3, other );
CNSTI4 3
ARGI4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 FlameSpawn
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 48
INDIRP4
ASGNP4
line 564
;564:				if ( flame == world )
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $256
line 565
;565:					return;
ADDRGP4 $225
JUMPV
LABELV $256
line 566
;566:			}
LABELV $255
line 567
;567:			flame->s.v.classname = "fire";
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $111
ASGNP4
line 568
;568:			flame->s.v.health = FLAME_PLYRMAXTIME;
ADDRLP4 12
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1110704128
ASGNF4
line 569
;569:			other->numflames = other->numflames + 1;
ADDRLP4 48
ADDRGP4 other
INDIRP4
CNSTI4 1396
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 570
;570:			VectorCopy( other->s.v.velocity, flame->s.v.velocity );
ADDRLP4 52
CNSTI4 180
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56
CNSTI4 184
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 60
CNSTI4 188
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 571
;571:			flame->s.v.enemy = EDICT_TO_PROG( other );
ADDRLP4 12
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
line 572
;572:			flame->s.v.touch = ( func_t ) OnPlayerFlame_touch;
ADDRLP4 12
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 OnPlayerFlame_touch
CVPU4 4
CVUI4 4
ASGNI4
line 573
;573:			flame->s.v.owner = self->s.v.owner;
ADDRLP4 52
CNSTI4 480
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 574
;574:			VectorCopy( self->s.v.origin, vtemp );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 575
;575:			setorigin( flame, PASSVEC3( vtemp ) );
ADDRLP4 12
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
line 576
;576:			flame->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 12
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 577
;577:			flame->s.v.think = ( func_t ) FlameFollow;
ADDRLP4 12
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 FlameFollow
CVPU4 4
CVUI4 4
ASGNI4
line 578
;578:		}
line 579
;579:	} else
ADDRGP4 $237
JUMPV
LABELV $236
line 580
;580:	{
line 582
;581:		//if ( g_random(  ) < 0.3 || trap_pointcontents( PASSVEC3( self->s.v.origin ) + 1 ) != -1 )
;582:		if ( g_random(  ) < 0.4 )
ADDRLP4 32
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1053609165
GEF4 $263
line 583
;583:		{
line 584
;584:			ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 586
;585://                        SetVector( self->s.v.velocity, 0, 0, 0 );
;586:			return;
ADDRGP4 $225
JUMPV
LABELV $263
line 588
;587:		}
;588:		flame = FlameSpawn( 4, other );
CNSTI4 4
ARGI4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 FlameSpawn
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 36
INDIRP4
ASGNP4
line 589
;589:		if ( flame != world )
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $265
line 590
;590:		{
line 591
;591:			flame->s.v.touch = ( func_t ) WorldFlame_touch;
ADDRLP4 12
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 WorldFlame_touch
CVPU4 4
CVUI4 4
ASGNI4
line 592
;592:			flame->s.v.classname = "fire";
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $111
ASGNP4
line 593
;593:			VectorCopy( self->s.v.origin, vtemp );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 594
;594:			vtemp[2] += 10;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 595
;595:			setorigin( flame, PASSVEC3( vtemp ) );
ADDRLP4 12
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
line 596
;596:			flame->s.v.nextthink = g_globalvars.time + 8;
ADDRLP4 12
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 597
;597:			flame->heat = flame->s.v.nextthink;
ADDRLP4 12
INDIRP4
CNSTI4 1076
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 288
ADDP4
INDIRF4
ASGNF4
line 598
;598:			flame->s.v.think = ( func_t ) Remove;
ADDRLP4 12
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 Remove
CVPU4 4
CVUI4 4
ASGNI4
line 599
;599:			flame->s.v.enemy = self->s.v.owner;
ADDRLP4 12
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
line 600
;600:		}
LABELV $265
line 602
;601:		//if(!tf_data.pyrotype)
;602:			ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 603
;603:	}
LABELV $237
line 604
;604:}
LABELV $225
endproc Flamer_stream_touch 64 24
export Napalm_touch
proc Napalm_touch 52 24
line 607
;605:
;606:void Napalm_touch(  )
;607:{
line 613
;608:	gedict_t *flame;
;609:
;610://      vec3_t  dir;
;611:	vec3_t  vtemp;
;612:
;613:	if ( streq( other->s.v.classname, "fire" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $111
ARGP4
ADDRLP4 16
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $274
line 614
;614:		return;
ADDRGP4 $273
JUMPV
LABELV $274
line 615
;615:	if ( other != world )
ADDRGP4 other
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $276
line 616
;616:	{
line 617
;617:		if ( other->s.v.takedamage == 2 && other->s.v.health > 0 )
ADDRLP4 20
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $277
ADDRLP4 20
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $277
line 618
;618:		{
line 619
;619:			tf_data.deathmsg = DMSG_FLAME;
ADDRGP4 tf_data+88
CNSTI4 15
ASGNI4
line 620
;620:			TF_T_Damage( other, self, PROG_TO_EDICT( self->s.v.owner ), 6, 2, 16 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1086324736
ARGF4
CNSTI4 2
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 621
;621:			if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $281
line 622
;622:				return;
ADDRGP4 $273
JUMPV
LABELV $281
line 623
;623:			if ( other->numflames >= 4 )
ADDRGP4 other
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CNSTI4 4
LTI4 $285
line 624
;624:			{
line 625
;625:				other->tfstate = other->tfstate | 131072;
ADDRLP4 28
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 626
;626:				return;
ADDRGP4 $273
JUMPV
LABELV $285
line 628
;627:			}
;628:			if ( ( other->armorclass & AT_SAVEFIRE ) && other->s.v.armorvalue > 0 )
ADDRLP4 28
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $287
ADDRLP4 28
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
CNSTF4 0
LEF4 $287
line 629
;629:				return;
ADDRGP4 $273
JUMPV
LABELV $287
line 630
;630:			if ( streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $74
ARGP4
ADDRLP4 32
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $289
line 631
;631:			{
line 632
;632:				if ( ( teamplay & TEAMPLAY_NOEXPLOSIVE ) && other->team_no > 0
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 teamplay
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 36
INDIRI4
EQI4 $291
ADDRLP4 40
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
ADDRLP4 36
INDIRI4
LEI4 $291
ADDRLP4 40
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
NEI4 $291
line 634
;633:				     && other->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no )
;634:					return;
ADDRGP4 $273
JUMPV
LABELV $291
line 635
;635:				CenterPrint( other, "You are on fire!\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $187
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 636
;636:				stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $188
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 637
;637:			}
LABELV $289
line 638
;638:			if ( other->numflames < 1 )
ADDRGP4 other
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CNSTI4 1
GEI4 $294
line 639
;639:			{
line 640
;640:				flame = FlameSpawn( 1, other );
CNSTI4 1
ARGI4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 FlameSpawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 641
;641:				sound( flame, 2, "ambience/fire1.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $191
ARGP4
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 642
;642:			} else
ADDRGP4 $295
JUMPV
LABELV $294
line 643
;643:			{
line 644
;644:				flame = FlameSpawn( 3, other );
CNSTI4 3
ARGI4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 FlameSpawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 645
;645:				if ( flame == world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $296
line 646
;646:					return;
ADDRGP4 $273
JUMPV
LABELV $296
line 647
;647:			}
LABELV $295
line 648
;648:			flame->s.v.classname = "fire";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $111
ASGNP4
line 649
;649:			flame->s.v.health = FLAME_PLYRMAXTIME;
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1110704128
ASGNF4
line 650
;650:			other->numflames = other->numflames + 1;
ADDRLP4 36
ADDRGP4 other
INDIRP4
CNSTI4 1396
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 651
;651:			VectorCopy( other->s.v.velocity, flame->s.v.velocity );
ADDRLP4 40
CNSTI4 180
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 44
CNSTI4 184
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 48
CNSTI4 188
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 652
;652:			flame->s.v.enemy = EDICT_TO_PROG( other );
ADDRLP4 0
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
line 653
;653:			flame->s.v.touch = ( func_t ) OnPlayerFlame_touch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 OnPlayerFlame_touch
CVPU4 4
CVUI4 4
ASGNI4
line 654
;654:			flame->s.v.owner = self->s.v.owner;
ADDRLP4 40
CNSTI4 480
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 655
;655:			VectorCopy( self->s.v.origin, vtemp );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 656
;656:			setorigin( flame, PASSVEC3( vtemp ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 657
;657:			flame->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 658
;658:			flame->s.v.think = ( func_t ) FlameFollow;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 FlameFollow
CVPU4 4
CVUI4 4
ASGNI4
line 659
;659:		}
line 660
;660:	} else
ADDRGP4 $277
JUMPV
LABELV $276
line 661
;661:	{
line 662
;662:		if ( trap_pointcontents( PASSVEC3( self->s.v.origin ) + 1 ) != -1 )
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 -1
EQI4 $303
line 663
;663:		{
line 664
;664:			FlameDestroy( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 FlameDestroy
CALLV
pop
line 665
;665:			return;
ADDRGP4 $273
JUMPV
LABELV $303
line 667
;666:		}
;667:		flame = FlameSpawn( 4, other );
CNSTI4 4
ARGI4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 FlameSpawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 668
;668:		if ( flame != world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $305
line 669
;669:		{
line 670
;670:			flame->s.v.touch = ( func_t ) WorldFlame_touch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 WorldFlame_touch
CVPU4 4
CVUI4 4
ASGNI4
line 671
;671:			flame->s.v.classname = "fire";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $111
ASGNP4
line 672
;672:			VectorCopy( self->s.v.origin, vtemp );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 673
;673:			vtemp[2] += 10;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 674
;674:			setorigin( flame, PASSVEC3( vtemp ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 675
;675:			flame->s.v.nextthink = g_globalvars.time + 20;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 676
;676:			flame->heat = flame->s.v.nextthink;
ADDRLP4 0
INDIRP4
CNSTI4 1076
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRF4
ASGNF4
line 677
;677:			flame->s.v.think = ( func_t ) Remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 Remove
CVPU4 4
CVUI4 4
ASGNI4
line 678
;678:			flame->s.v.enemy = self->s.v.owner;
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
line 679
;679:		}
LABELV $305
line 680
;680:		FlameDestroy( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 FlameDestroy
CALLV
pop
line 681
;681:	}
LABELV $277
line 682
;682:}
LABELV $273
endproc Napalm_touch 52 24
export NewBubbles
proc NewBubbles 16 16
line 686
;683:
;684:// Slightly varied version of DEATHBUBBLES
;685:void NewBubbles( float num_bubbles, vec3_t bub_origin )
;686:{
line 689
;687:	gedict_t *bubble_spawner;
;688:
;689:	bubble_spawner = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 690
;690:	setorigin( bubble_spawner, PASSVEC3( bub_origin ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 691
;691:	bubble_spawner->s.v.movetype = MOVETYPE_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 692
;692:	bubble_spawner->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 693
;693:	bubble_spawner->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 695
;694:
;695:	if ( streq( self->s.v.classname, "player" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $74
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $315
line 696
;696:		bubble_spawner->s.v.owner = EDICT_TO_PROG( self );
ADDRLP4 0
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
ADDRGP4 $316
JUMPV
LABELV $315
line 698
;697:	else
;698:		bubble_spawner->s.v.owner = self->s.v.enemy;
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ASGNI4
LABELV $316
line 700
;699:
;700:	bubble_spawner->s.v.think = ( func_t ) DeathBubblesSpawn;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 DeathBubblesSpawn
CVPU4 4
CVUI4 4
ASGNI4
line 701
;701:	bubble_spawner->bubble_count = num_bubbles;
ADDRLP4 0
INDIRP4
CNSTI4 800
ADDP4
ADDRFP4 0
INDIRF4
ASGNF4
line 703
;702:
;703:	return;
LABELV $313
endproc NewBubbles 16 16
export W_FireFlame
proc W_FireFlame 52 28
line 714
;704:}
;705:
;706:void    s_explode1(  );
;707:void    s_explode2(  );
;708:void    s_explode3(  );
;709:void    s_explode4(  );
;710:void    s_explode5(  );
;711:void    s_explode6(  );
;712:
;713:void W_FireFlame(  )
;714:{
line 719
;715:	gedict_t *flame;
;716:	float   rn;
;717:	vec3_t  vtemp;
;718:
;719:	if ( self->s.v.waterlevel > 2 )
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1073741824
LEF4 $318
line 720
;720:	{
line 721
;721:		makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 722
;722:		VectorScale( g_globalvars.v_forward, 64, vtemp );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1115684864
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 723
;723:		VectorAdd( self->s.v.origin, vtemp, vtemp );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDF4
ASGNF4
line 724
;724:		NewBubbles( 2, vtemp );
CNSTF4 1073741824
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 NewBubbles
CALLV
pop
line 725
;725:		rn = g_random(  );
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 20
INDIRF4
ASGNF4
line 726
;726:		if ( rn < 0.5 )
ADDRLP4 16
INDIRF4
CNSTF4 1056964608
GEF4 $325
line 727
;727:			sound( self, 1, "misc/water1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $327
ARGP4
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
ADDRGP4 $317
JUMPV
LABELV $325
line 729
;728:		else
;729:			sound( self, 1, "misc/water2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $328
ARGP4
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 730
;730:		return;
ADDRGP4 $317
JUMPV
LABELV $318
line 732
;731:	}
;732:	if ( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $329
line 733
;733:		self->s.v.currentammo = --( self->s.v.ammo_cells );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 20
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
LABELV $329
line 735
;734:
;735:	sound( self, 0, "weapons/flmfire2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $332
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
line 737
;736:
;737:	flame = spawn(  );
ADDRLP4 36
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 738
;738:	flame->s.v.owner = EDICT_TO_PROG( self );
ADDRLP4 0
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
line 739
;739:	flame->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 740
;740:	flame->s.v.solid = SOLID_BBOX;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 741
;741:	flame->s.v.classname = "flamerflame";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $333
ASGNP4
line 743
;742:
;743:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 744
;744:	aim( flame->s.v.velocity );
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 aim
CALLV
pop
line 746
;745:
;746:	if ( self->playerclass != PC_HVYWEAP )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 6
EQI4 $334
line 747
;747:		VectorScale( flame->s.v.velocity, 600, flame->s.v.velocity );
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTF4 1142292480
ARGF4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
ADDRGP4 $335
JUMPV
LABELV $334
line 749
;748:	else
;749:		VectorScale( flame->s.v.velocity, 100, flame->s.v.velocity );
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
CNSTF4 1120403456
ARGF4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
LABELV $335
line 751
;750:
;751:	flame->s.v.touch = ( func_t ) Flamer_stream_touch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 Flamer_stream_touch
CVPU4 4
CVUI4 4
ASGNI4
line 753
;752://	flame->s.v.think = ( func_t ) s_explode1;
;753:	flame->s.v.think = ( func_t ) s2_explode1;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s2_explode1
CVPU4 4
CVUI4 4
ASGNI4
line 754
;754:	flame->s.v.effects = 8;
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1090519040
ASGNF4
line 755
;755:	if ( self->s.v.classname == "airstrike" )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 $338
CVPU4 4
NEU4 $336
line 756
;756:	{
line 757
;757:		flame->s.v.velocity[0] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 0
ASGNF4
line 758
;758:		flame->s.v.velocity[1] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 0
ASGNF4
line 759
;759:		flame->s.v.velocity[2] = 200;
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1128792064
ASGNF4
line 760
;760:	}
LABELV $336
line 761
;761:	flame->s.v.nextthink = g_globalvars.time + 0.15;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1041865114
ADDF4
ASGNF4
line 763
;762:
;763:	setmodel( flame, "progs/s_explod.spr" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $340
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 764
;764:	setsize( flame, 0, 0, 0, 0, 0, 0 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 48
CNSTF4 0
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 766
;765:
;766:	VectorScale( g_globalvars.v_forward, 16, vtemp );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1098907648
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 767
;767:	VectorAdd( self->s.v.origin, vtemp, vtemp );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDF4
ASGNF4
line 768
;768:	if ( self->s.v.classname == "airstrike" ) {
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 $338
CVPU4 4
NEU4 $346
line 769
;769:		flame->s.v.velocity[0] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 0
ASGNF4
line 770
;770:		flame->s.v.velocity[1] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 0
ASGNF4
line 771
;771:		flame->s.v.velocity[2] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 0
ASGNF4
line 772
;772:	}
LABELV $346
line 773
;773:	vtemp[2] += 16;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 774
;774:	setorigin( flame, PASSVEC3( vtemp ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 775
;775:}
LABELV $317
endproc W_FireFlame 52 28
export T_IncendiaryTouch
proc T_IncendiaryTouch 72 32
line 781
;776:
;777:/*======================
;778:Touch function for incendiary cannon rockets
;779:======================*/
;780:void T_IncendiaryTouch(  )
;781:{
line 788
;782:	float   damg;
;783:
;784://      float   points;
;785:	gedict_t *head, *owner;
;786:	vec3_t  vtemp;
;787:
;788:	owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 789
;789:	if ( other == owner ) // don't explode on owner
ADDRGP4 other
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRP4
CVPU4 4
NEU4 $352
line 790
;790:		return;
ADDRGP4 $351
JUMPV
LABELV $352
line 792
;791:
;792:	if ( trap_pointcontents( PASSVEC3( self->s.v.origin ) ) == -6 )
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
NEI4 $354
line 793
;793:	{
line 794
;794:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 795
;795:		return;
ADDRGP4 $351
JUMPV
LABELV $354
line 798
;796:	}
;797:
;798:	self->s.v.effects = ( int ) self->s.v.effects | 4;
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 4
BORI4
CVIF4 4
ASGNF4
line 799
;799:	damg = 30 + g_random(  ) * 20;
ADDRLP4 36
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 20
CNSTF4 1101004800
ADDRLP4 36
INDIRF4
MULF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 801
;800:
;801:	if ( other->s.v.health )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $356
line 802
;802:	{
line 803
;803:		tf_data.deathmsg = DMSG_FLAME;
ADDRGP4 tf_data+88
CNSTI4 15
ASGNI4
line 804
;804:		TF_T_Damage( other, self, owner, damg, 2, 16 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
INDIRF4
ARGF4
CNSTI4 2
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 805
;805:	}
LABELV $356
line 809
;806:
;807:	// don't do radius damage to the other, because all the damage
;808:	// was done in the impact
;809:	for ( head = world; (head = findradius( head, self->s.v.origin, 180 )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $362
JUMPV
LABELV $359
line 810
;810:	{
line 811
;811:		if ( head->s.v.takedamage )
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $363
line 812
;812:		{
line 813
;813:			traceline( PASSVEC3( self->s.v.origin ), PASSVEC3( head->s.v.origin ), 1, self );
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
CNSTI4 156
ASGNI4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 48
CNSTI4 160
ASGNI4
ADDRLP4 40
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
CNSTI4 164
ASGNI4
ADDRLP4 40
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 814
;814:			VectorSubtract( self->s.v.origin, head->s.v.origin, vtemp );
ADDRLP4 60
CNSTI4 156
ASGNI4
ADDRLP4 4
ADDRGP4 self
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64
CNSTI4 160
ASGNI4
ADDRLP4 4+4
ADDRGP4 self
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
ADDRLP4 68
CNSTI4 164
ASGNI4
ADDRLP4 4+8
ADDRGP4 self
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 815
;815:			if ( g_globalvars.trace_fraction == 1
ADDRLP4 60
CNSTF4 1065353216
ASGNF4
ADDRGP4 g_globalvars+272
INDIRF4
ADDRLP4 60
INDIRF4
EQF4 $371
ADDRGP4 g_globalvars+272
INDIRF4
ADDRLP4 60
INDIRF4
EQF4 $367
ADDRLP4 4
ARGP4
ADDRLP4 64
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 64
INDIRF4
CNSTF4 1115684864
GTF4 $367
LABELV $371
line 817
;816:			     || ( g_globalvars.trace_fraction != 1 && vlen( vtemp ) <= 64 ) )
;817:			{
line 818
;818:				tf_data.deathmsg = DMSG_FLAME;
ADDRGP4 tf_data+88
CNSTI4 15
ASGNI4
line 819
;819:				TF_T_Damage( head, self, owner, 10, 2, 16 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 1092616192
ARGF4
CNSTI4 2
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 820
;820:				other = head;
ADDRGP4 other
ADDRLP4 0
INDIRP4
ASGNP4
line 821
;821:				if( !g_globalvars.trace_inwater)
ADDRGP4 g_globalvars+312
INDIRF4
CNSTF4 0
NEF4 $373
line 822
;822:					Napalm_touch(  );
ADDRGP4 Napalm_touch
CALLV
pop
LABELV $373
line 824
;823:
;824:				if ( streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $74
ARGP4
ADDRLP4 68
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $376
line 825
;825:					stuffcmd( other, "bf\nbf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $75
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $376
line 826
;826:			}
LABELV $367
line 827
;827:		}
LABELV $363
line 828
;828:	}
LABELV $360
line 809
LABELV $362
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTF4 1127481344
ARGF4
ADDRLP4 40
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $359
line 829
;829:	normalize( self->s.v.velocity, vtemp );
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 normalize
CALLV
pop
line 830
;830:	VectorScale( vtemp, 8, vtemp );
ADDRLP4 4
ARGP4
CNSTF4 1090519040
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 831
;831:	VectorSubtract( self->s.v.origin, vtemp, self->s.v.origin );
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 156
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
ADDRLP4 48
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 52
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 832
;832:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 833
;833:	trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 834
;834:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 835
;835:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 836
;836:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 837
;837:	trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 838
;838:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 839
;839:}
LABELV $351
endproc T_IncendiaryTouch 72 32
export W_FireIncendiaryCannon
proc W_FireIncendiaryCannon 44 28
line 847
;840:
;841:/*
;842:================
;843:W_FireIncendiaryCannon
;844:================
;845:*/
;846:void W_FireIncendiaryCannon(  )
;847:{
line 850
;848:	vec3_t  vtemp;
;849:
;850:	if ( self->s.v.ammo_rockets < 3 )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1077936128
GEF4 $381
line 851
;851:		return;
ADDRGP4 $380
JUMPV
LABELV $381
line 852
;852:	if ( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $383
line 853
;853:		self->s.v.currentammo = self->s.v.ammo_rockets = self->s.v.ammo_rockets - 3;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1077936128
SUBF4
ASGNF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
LABELV $383
line 855
;854:
;855:	sound( self, 1, "doors/airdoor2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $386
ARGP4
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 856
;856:	KickPlayer( -3, self );
CNSTI4 -3
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 857
;857:	newmis = spawn(  );
ADDRLP4 28
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 28
INDIRP4
ASGNP4
line 859
;858:
;859:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 860
;860:	newmis->s.v.owner = EDICT_TO_PROG( self );
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
line 861
;861:	newmis->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 862
;862:	newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 864
;863:
;864:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 865
;865:	aim( newmis->s.v.velocity );
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 aim
CALLV
pop
line 866
;866:	VectorScale( newmis->s.v.velocity, 750, newmis->s.v.velocity );		// maybe this val will change
ADDRLP4 32
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
CNSTF4 1144750080
ARGF4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 868
;867:
;868:	vectoangles( newmis->s.v.velocity, newmis->s.v.angles );
ADDRLP4 36
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 870
;869:
;870:	newmis->s.v.classname = "rocket";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $388
ASGNP4
line 871
;871:	newmis->s.v.touch = ( func_t ) T_IncendiaryTouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 T_IncendiaryTouch
CVPU4 4
CVUI4 4
ASGNI4
line 872
;872:	newmis->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 873
;873:	newmis->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 874
;874:	newmis->s.v.weapon = DMSG_INCENDIARY;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1107558400
ASGNF4
line 876
;875:
;876:	setmodel( newmis, "progs/incenrkt.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $390
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 877
;877:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 40
CNSTF4 0
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 879
;878:
;879:	VectorScale( g_globalvars.v_forward, 8, vtemp );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1090519040
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 880
;880:	VectorAdd( vtemp, self->s.v.origin, vtemp );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDF4
ASGNF4
line 881
;881:	vtemp[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 882
;882:	setorigin( newmis, PASSVEC3( vtemp ) );
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
line 883
;883:}
LABELV $380
endproc W_FireIncendiaryCannon 44 28
export TeamFortress_IncendiaryCannon
proc TeamFortress_IncendiaryCannon 0 12
line 888
;884:
;885://=========================================================================
;886:// Incendiary cannon selection function
;887:void TeamFortress_IncendiaryCannon(  )
;888:{
line 889
;889:	if ( !( self->weapons_carried & WEAP_INCENDIARY ) )
ADDRGP4 self
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
NEI4 $400
line 890
;890:		return;
ADDRGP4 $399
JUMPV
LABELV $400
line 891
;891:	if ( self->s.v.ammo_rockets < 3 )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1077936128
GEF4 $402
line 892
;892:	{
line 893
;893:		G_sprint( self, 2, "not enough ammo.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $404
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 894
;894:		return;
ADDRGP4 $399
JUMPV
LABELV $402
line 896
;895:	}
;896:	self->current_weapon = WEAP_INCENDIARY;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 16384
ASGNI4
line 897
;897:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 898
;898:}
LABELV $399
endproc TeamFortress_IncendiaryCannon 0 12
export TeamFortress_FlameThrower
proc TeamFortress_FlameThrower 0 12
line 902
;899:
;900:// Flamethrower selection function
;901:void TeamFortress_FlameThrower(  )
;902:{
line 903
;903:	if ( !( self->weapons_carried & WEAP_FLAMETHROWER ) )
ADDRGP4 self
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $406
line 904
;904:		return;
ADDRGP4 $405
JUMPV
LABELV $406
line 905
;905:	if ( self->s.v.ammo_cells < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $408
line 906
;906:	{
line 907
;907:		G_sprint( self, 2, "not enough ammo.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $404
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 908
;908:		return;
ADDRGP4 $405
JUMPV
LABELV $408
line 910
;909:	}
;910:	self->current_weapon = WEAP_FLAMETHROWER;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 4096
ASGNI4
line 911
;911:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 912
;912:}
LABELV $405
endproc TeamFortress_FlameThrower 0 12
import s_explode6
import s_explode5
import s_explode4
import s_explode3
import s_explode2
import s_explode1
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
LABELV $404
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $390
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 99
byte 1 101
byte 1 110
byte 1 114
byte 1 107
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $388
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $386
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 97
byte 1 105
byte 1 114
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
align 1
LABELV $340
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $338
byte 1 97
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $333
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $332
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 109
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $328
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $327
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $191
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $188
byte 1 98
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $187
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $162
byte 1 0
align 1
LABELV $111
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $82
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 109
byte 1 103
byte 1 114
byte 1 101
byte 1 120
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $75
byte 1 98
byte 1 102
byte 1 10
byte 1 98
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $74
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $60
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
LABELV $55
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 118
byte 1 97
byte 1 112
byte 1 101
byte 1 117
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $49
byte 1 10
byte 1 10
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 70
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 70
byte 1 114
byte 1 111
byte 1 109
byte 1 81
byte 1 117
byte 1 101
byte 1 117
byte 1 101
byte 1 40
byte 1 41
byte 1 58
byte 1 66
byte 1 79
byte 1 79
byte 1 77
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $38
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 70
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 70
byte 1 114
byte 1 111
byte 1 109
byte 1 81
byte 1 117
byte 1 101
byte 1 117
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $31
byte 1 52
byte 1 0
align 1
LABELV $29
byte 1 51
byte 1 0
align 1
LABELV $27
byte 1 50
byte 1 0
align 1
LABELV $25
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $24
byte 1 49
byte 1 0
