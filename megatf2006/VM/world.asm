code
proc InitBodyQue 16 0
file "..\src\world.c"
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
;21: *  $Id: world.c,v 1.12 2006/01/18 14:05:26 AngelD Exp $
;22: */
;23:
;24:// Note from XavioR:
;25://  Quite a few of these models are no longer used in mtf. I've weeded
;26:// out the ones I could find and left others. Modders decide. 
;27:
;28:#include "g_local.h"
;29:#define MAX_BODYQUE 4
;30:static gedict_t *bodyque[MAX_BODYQUE];
;31:static int     bodyque_head;
;32:/*
;33:==============================================================================
;34:
;35:BODY QUE
;36:
;37:==============================================================================
;38:*/
;39:
;40:static void InitBodyQue(  )
;41:{
line 44
;42:	int     i;
;43:
;44:	bodyque[0] = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 bodyque
ADDRLP4 4
INDIRP4
ASGNP4
line 45
;45:	bodyque[0]->s.v.classname = "bodyque";
ADDRGP4 bodyque
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $12
ASGNP4
line 46
;46:	for ( i = 1; i < MAX_BODYQUE; i++ )
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $13
line 47
;47:	{
line 48
;48:		bodyque[i] = spawn(  );
ADDRLP4 8
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 49
;49:		bodyque[i]->s.v.classname = "bodyque";
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $12
ASGNP4
line 50
;50:		bodyque[i - 1]->s.v.owner = EDICT_TO_PROG( bodyque[i] );
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 bodyque-4
ADDP4
INDIRP4
CNSTI4 480
ADDP4
ADDRLP4 12
INDIRI4
ADDRGP4 bodyque
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 51
;51:	}
LABELV $14
line 46
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $13
line 52
;52:	bodyque[MAX_BODYQUE - 1]->s.v.owner = EDICT_TO_PROG( bodyque[0] );
ADDRGP4 bodyque+12
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 bodyque
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 53
;53:	bodyque_head = 0;
ADDRGP4 bodyque_head
CNSTI4 0
ASGNI4
line 54
;54:}
LABELV $11
endproc InitBodyQue 16 0
export CopyToBodyQue
proc CopyToBodyQue 36 28
line 59
;55:
;56:// make a body que entry for the given ent so the ent can be
;57:// respawned elsewhere
;58:void CopyToBodyQue( gedict_t * ent )
;59:{
line 60
;60:	VectorCopy( ent->s.v.angles, bodyque[bodyque_head]->s.v.angles );
ADDRLP4 0
CNSTI4 192
ASGNI4
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
CNSTI4 196
ASGNI4
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
CNSTI4 200
ASGNI4
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 61
;61:	VectorCopy( ent->s.v.velocity, bodyque[bodyque_head]->s.v.velocity );
ADDRLP4 0
CNSTI4 180
ASGNI4
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
CNSTI4 184
ASGNI4
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
CNSTI4 188
ASGNI4
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 62
;62:	bodyque[bodyque_head]->s.v.model = ent->s.v.model;
ADDRLP4 0
CNSTI4 220
ASGNI4
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 63
;63:	bodyque[bodyque_head]->s.v.modelindex = ent->s.v.modelindex;
ADDRLP4 4
CNSTI4 112
ASGNI4
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 64
;64:	bodyque[bodyque_head]->s.v.frame = ent->s.v.frame;
ADDRLP4 8
CNSTI4 224
ASGNI4
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 65
;65:	bodyque[bodyque_head]->s.v.colormap = ent->s.v.colormap;
ADDRLP4 12
CNSTI4 408
ASGNI4
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 66
;66:	bodyque[bodyque_head]->s.v.movetype = ent->s.v.movetype;
ADDRLP4 16
CNSTI4 148
ASGNI4
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 67
;67:	bodyque[bodyque_head]->s.v.flags = 0;
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 0
ASGNF4
line 69
;68:
;69:	setorigin( bodyque[bodyque_head], PASSVEC3( ent->s.v.origin ) );
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRFP4 0
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
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 70
;70:	setsize( bodyque[bodyque_head], PASSVEC3( ent->s.v.mins ), PASSVEC3( ent->s.v.maxs ) );
ADDRGP4 bodyque_head
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 bodyque
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 72
;71:
;72:	if ( ++bodyque_head >= MAX_BODYQUE )
ADDRLP4 28
ADDRGP4 bodyque_head
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 4
LTI4 $20
line 73
;73:		bodyque_head = 0;
ADDRGP4 bodyque_head
CNSTI4 0
ASGNI4
LABELV $20
line 74
;74:}
LABELV $19
endproc CopyToBodyQue 36 28
data
export number_of_teams
align 4
LABELV number_of_teams
byte 4 0
export SP_worldspawn
code
proc SP_worldspawn 160 16
line 93
;75:
;76://=======================
;77:/*QUAKED worldspawn (0 0 0) ?
;78:Only used for the world entity.
;79:Set message to the level name.
;80:Set sounds to the cd track to play.
;81:
;82:World Types:
;83:0: medieval
;84:1: metal
;85:2: base
;86:*/
;87://=======================
;88:
;89:extern gedict_t *lastspawn;
;90:int     number_of_teams = 0;
;91:
;92:void SP_worldspawn(  )
;93:{
line 98
;94:	char   *s;
;95:	char    gamedir[64], cycledir[64];
;96:	char    exec_maps[10];
;97:
;98:	G_SpawnString( "classname", "", &s );
ADDRGP4 $23
ARGP4
ADDRGP4 $24
ARGP4
ADDRLP4 76
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 99
;99:	if ( Q_stricmp( s, "worldspawn" ) )
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 $27
ARGP4
ADDRLP4 144
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $25
line 100
;100:	{
line 101
;101:		G_Error( "SP_worldspawn: The first entity isn't 'worldspawn'" );
ADDRGP4 $28
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 102
;102:	}
LABELV $25
line 103
;103:	world->s.v.classname = "worldspawn";
ADDRGP4 world
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $27
ASGNP4
line 104
;104:	lastspawn = world;
ADDRGP4 lastspawn
ADDRGP4 world
INDIRP4
ASGNP4
line 105
;105:	number_of_teams = 0;
ADDRGP4 number_of_teams
CNSTI4 0
ASGNI4
line 106
;106:	InitBodyQue(  );
ADDRGP4 InitBodyQue
CALLV
pop
line 108
;107:
;108:	if ( !Q_stricmp( self->s.v.model, "maps/e1m8.bsp" ) )
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 $31
ARGP4
ADDRLP4 148
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $29
line 109
;109:		trap_cvar_set( "sv_gravity", "100" );
ADDRGP4 $32
ARGP4
ADDRGP4 $33
ARGP4
ADDRGP4 trap_cvar_set
CALLV
pop
ADDRGP4 $30
JUMPV
LABELV $29
line 111
;110:	else
;111:		trap_cvar_set( "sv_gravity", "800" );
ADDRGP4 $32
ARGP4
ADDRGP4 $34
ARGP4
ADDRGP4 trap_cvar_set
CALLV
pop
LABELV $30
line 113
;112:
;113:	infokey( world, "*sv_gamedir", gamedir, sizeof( gamedir ) );
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 $35
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 infokey
CALLV
pop
line 114
;114:	if ( gamedir[0] != 0 && strcmp( gamedir, "fortress" ) )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $36
ADDRLP4 0
ARGP4
ADDRGP4 $38
ARGP4
ADDRLP4 152
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $36
line 115
;115:	{
line 116
;116:		G_Error( "QW TF must be run with a sv_gamedir of \"fortress\".\n" );
ADDRGP4 $39
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 117
;117:	} else
ADDRGP4 $37
JUMPV
LABELV $36
line 118
;118:	{
line 119
;119:		if ( gamedir[0] == 0 )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $40
line 120
;120:		{
line 121
;121:			infokey( world, "*gamedir", gamedir, sizeof( gamedir ) );
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 $42
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 infokey
CALLV
pop
line 122
;122:			if ( strcmp( gamedir, "fortress" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $38
ARGP4
ADDRLP4 156
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $43
line 123
;123:				G_Error( "QW TF must be run with a sv_gamedir or gamedir of \"fortress\". %s\n", gamedir );
ADDRGP4 $45
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $43
line 124
;124:		}
LABELV $40
line 125
;125:	}
LABELV $37
line 127
;126:
;127:	infokey( world, "exec_map_cfgs", exec_maps, sizeof( exec_maps ) );
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 $46
ARGP4
ADDRLP4 64
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 infokey
CALLV
pop
line 129
;128:
;129:	if ( !strcmp( exec_maps, "on" ) )
ADDRLP4 64
ARGP4
ADDRGP4 $49
ARGP4
ADDRLP4 156
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $47
line 130
;130:	{
line 131
;131:		infokey( world, "cycledir", cycledir, sizeof( cycledir ) );
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 $50
ARGP4
ADDRLP4 80
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 infokey
CALLV
pop
line 132
;132:		if ( cycledir[0] )
ADDRLP4 80
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $51
line 133
;133:		{
line 134
;134:			localcmd( "exec %s/mapdefault.cfg\n", cycledir );
ADDRGP4 $53
ARGP4
ADDRLP4 80
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 135
;135:			localcmd( "exec %s/%s.cfg\n", cycledir, g_globalvars.mapname );
ADDRGP4 $54
ARGP4
ADDRLP4 80
ARGP4
ADDRGP4 g_globalvars+140
INDIRP4
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 136
;136:		} else
ADDRGP4 $52
JUMPV
LABELV $51
line 137
;137:		{
line 138
;138:			localcmd( "exec qwmcycle/mapdefault.cfg\n" );
ADDRGP4 $56
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 139
;139:			localcmd( "exec qwmcycle/%s.cfg\n", g_globalvars.mapname );
ADDRGP4 $57
ARGP4
ADDRGP4 g_globalvars+140
INDIRP4
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 140
;140:		}
LABELV $52
line 141
;141:	}
LABELV $47
line 145
;142:// the area based ambient sounds MUST be the first precache_sounds
;143:
;144:// player precaches     
;145:	W_Precache(  );		// get weapon precaches
ADDRGP4 W_Precache
CALLV
pop
line 148
;146:
;147:// sounds used from C physics code
;148:	trap_precache_sound( "demon/dland2.wav" );	// landing thud
ADDRGP4 $59
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 149
;149:	trap_precache_sound( "misc/h2ohit1.wav" );	// landing splash
ADDRGP4 $60
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 152
;150:
;151:// setup precaches allways needed
;152:	trap_precache_sound( "items/itembk2.wav" );	// item respawn sound
ADDRGP4 $61
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 153
;153:	trap_precache_sound( "player/plyrjmp8.wav" );	// player jump
ADDRGP4 $62
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 154
;154:	trap_precache_sound( "player/land.wav" );	// player landing
ADDRGP4 $63
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 155
;155:	trap_precache_sound( "player/land2.wav" );	// player hurt landing
ADDRGP4 $64
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 156
;156:	trap_precache_sound( "player/drown1.wav" );	// drowning pain
ADDRGP4 $65
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 157
;157:	trap_precache_sound( "player/drown2.wav" );	// drowning pain
ADDRGP4 $66
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 158
;158:	trap_precache_sound( "player/gasp1.wav" );	// gasping for air
ADDRGP4 $67
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 159
;159:	trap_precache_sound( "player/gasp2.wav" );	// taking breath
ADDRGP4 $68
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 160
;160:	trap_precache_sound( "player/h2odeath.wav" );	// drowning death
ADDRGP4 $69
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 162
;161:
;162:	trap_precache_sound( "misc/talk.wav" );	// talk
ADDRGP4 $70
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 163
;163:	trap_precache_sound( "player/teledth1.wav" );	// telefrag
ADDRGP4 $71
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 164
;164:	trap_precache_sound( "misc/r_tele1.wav" );	// teleport sounds
ADDRGP4 $72
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 165
;165:	trap_precache_sound( "misc/r_tele2.wav" );
ADDRGP4 $73
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 166
;166:	trap_precache_sound( "misc/r_tele3.wav" );
ADDRGP4 $74
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 167
;167:	trap_precache_sound( "misc/r_tele4.wav" );
ADDRGP4 $75
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 168
;168:	trap_precache_sound( "misc/r_tele5.wav" );
ADDRGP4 $76
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 169
;169:	trap_precache_sound( "weapons/lock4.wav" );	// ammo pick up
ADDRGP4 $77
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 170
;170:	trap_precache_sound( "weapons/pkup.wav" );	// weapon up
ADDRGP4 $78
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 171
;171:	trap_precache_sound( "items/armor1.wav" );	// armor up
ADDRGP4 $79
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 172
;172:	trap_precache_sound( "weapons/lhit.wav" );	//lightning
ADDRGP4 $80
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 173
;173:	trap_precache_sound( "weapons/lstart.wav" );	//lightning start
ADDRGP4 $81
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 174
;174:	trap_precache_sound( "items/damage3.wav" );
ADDRGP4 $82
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 176
;175:
;176:	trap_precache_sound( "misc/power.wav" );	//lightning for boss
ADDRGP4 $83
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 179
;177:
;178:// player gib sounds
;179:	trap_precache_sound( "player/gib.wav" );	// player gib sound
ADDRGP4 $84
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 180
;180:	trap_precache_sound( "player/gib2.wav" );	// mtf gib sounds
ADDRGP4 $85
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 181
;181:	trap_precache_sound( "player/gib3.wav" );
ADDRGP4 $86
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 182
;182:	trap_precache_sound( "player/udeath.wav" );	// player gib sound
ADDRGP4 $87
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 183
;183:	trap_precache_sound( "player/tornoff2.wav" );	// gib sound
ADDRGP4 $88
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 187
;184:
;185:// player pain sounds
;186:
;187:	trap_precache_sound( "player/pain1.wav" );
ADDRGP4 $89
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 188
;188:	trap_precache_sound( "player/pain2.wav" );
ADDRGP4 $90
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 189
;189:	trap_precache_sound( "player/pain3.wav" );
ADDRGP4 $91
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 190
;190:	trap_precache_sound( "player/pain4.wav" );
ADDRGP4 $92
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 191
;191:	trap_precache_sound( "player/pain5.wav" );
ADDRGP4 $93
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 192
;192:	trap_precache_sound( "player/pain6.wav" );
ADDRGP4 $94
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 193
;193:	trap_precache_sound( "player/mpain6.wav" );	// mtf pain
ADDRGP4 $95
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 196
;194:
;195:// player death sounds
;196:	trap_precache_sound( "player/death1.wav" );
ADDRGP4 $96
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 197
;197:	trap_precache_sound( "player/death2.wav" );
ADDRGP4 $97
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 198
;198:	trap_precache_sound( "player/death3.wav" );
ADDRGP4 $98
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 199
;199:	trap_precache_sound( "player/death4.wav" );
ADDRGP4 $99
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 200
;200:	trap_precache_sound( "player/mdeath5.wav" );	// heart stopped
ADDRGP4 $100
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 201
;201:	trap_precache_sound( "player/malive5.wav" );	// oops - i'm alive!
ADDRGP4 $101
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 202
;202:	trap_precache_sound( "player/death5.wav" );
ADDRGP4 $102
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 204
;203:
;204:	trap_precache_sound( "boss1/sight1.wav" );
ADDRGP4 $103
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 207
;205:
;206:// ax sounds    
;207:	trap_precache_sound( "weapons/ax1.wav" );	// ax swoosh
ADDRGP4 $104
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 208
;208:	trap_precache_sound( "player/axhit1.wav" );	// ax hit meat
ADDRGP4 $105
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 209
;209:	trap_precache_sound( "player/axhit2.wav" );	// ax hit world
ADDRGP4 $106
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 211
;210:
;211:	trap_precache_sound( "player/h2ojump.wav" );	// player jumping into water
ADDRGP4 $107
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 212
;212:	trap_precache_sound( "player/slimbrn2.wav" );	// player enter slime
ADDRGP4 $108
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 213
;213:	trap_precache_sound( "player/inh2o.wav" );	// player enter water
ADDRGP4 $109
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 214
;214:	trap_precache_sound( "player/inlava.wav" );	// player enter lava
ADDRGP4 $110
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 215
;215:	trap_precache_sound( "misc/outwater.wav" );	// leaving water sound
ADDRGP4 $111
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 217
;216:
;217:	trap_precache_sound( "player/lburn1.wav" );	// lava burn
ADDRGP4 $112
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 218
;218:	trap_precache_sound( "player/lburn2.wav" );	// lava burn
ADDRGP4 $113
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 220
;219:
;220:	trap_precache_sound( "misc/water1.wav" );	// swimming
ADDRGP4 $114
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 221
;221:	trap_precache_sound( "misc/water2.wav" );	// swimming
ADDRGP4 $115
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 224
;222:
;223:// Invulnerability sounds
;224:	trap_precache_sound( "items/protect.wav" );
ADDRGP4 $116
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 225
;225:	trap_precache_sound( "items/protect2.wav" );
ADDRGP4 $117
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 226
;226:	trap_precache_sound( "items/protect3.wav" );
ADDRGP4 $118
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 229
;227:
;228:
;229:	trap_precache_model( "progs/player.mdl" );
ADDRGP4 $119
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 230
;230:	trap_precache_model( "progs/eyes.mdl" );
ADDRGP4 $120
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 231
;231:	trap_precache_model( "progs/h_player.mdl" );
ADDRGP4 $121
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 232
;232:	trap_precache_model( "progs/headless.mdl" );
ADDRGP4 $122
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 233
;233:	trap_precache_model( "progs/gib1.mdl" );
ADDRGP4 $123
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 234
;234:	trap_precache_model( "progs/gib2.mdl" );
ADDRGP4 $124
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 235
;235:	trap_precache_model( "progs/gib3.mdl" );
ADDRGP4 $125
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 237
;236:
;237:	trap_precache_model( "progs/s_bubble.spr" );	// drowning bubbles
ADDRGP4 $126
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 238
;238:	trap_precache_model( "progs/s_explod.spr" );	// sprite explosion
ADDRGP4 $127
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 240
;239:
;240:	trap_precache_model( "progs/v_axe.mdl" );
ADDRGP4 $128
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 241
;241:	trap_precache_model( "progs/v_shot.mdl" );
ADDRGP4 $129
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 242
;242:	trap_precache_model( "progs/v_nail.mdl" );
ADDRGP4 $130
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 243
;243:	trap_precache_model( "progs/v_rock.mdl" );
ADDRGP4 $131
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 244
;244:	trap_precache_model( "progs/v_shot2.mdl" );
ADDRGP4 $132
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 245
;245:	trap_precache_model( "progs/v_nail2.mdl" );
ADDRGP4 $133
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 246
;246:	trap_precache_model( "progs/v_rock2.mdl" );
ADDRGP4 $134
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 248
;247:
;248:	trap_precache_model( "progs/bolt.mdl" );	// for lightning gun
ADDRGP4 $135
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 249
;249:	trap_precache_model( "progs/bolt2.mdl" );	// for lightning gun
ADDRGP4 $136
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 250
;250:	trap_precache_model( "progs/bolt3.mdl" );	// for boss shock
ADDRGP4 $137
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 251
;251:	trap_precache_model( "progs/lavaball.mdl" );	// for testing
ADDRGP4 $138
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 253
;252:
;253:	trap_precache_model( "progs/missile.mdl" );
ADDRGP4 $139
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 254
;254:	trap_precache_model( "progs/grenade.mdl" );
ADDRGP4 $140
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 255
;255:	trap_precache_model( "progs/spike.mdl" );
ADDRGP4 $141
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 256
;256:	trap_precache_model( "progs/s_spike.mdl" );
ADDRGP4 $142
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 258
;257:
;258:	trap_precache_model( "progs/backpack.mdl" );
ADDRGP4 $143
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 260
;259:
;260:	trap_precache_model( "progs/zom_gib.mdl" );
ADDRGP4 $144
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 262
;261:
;262:	trap_precache_model( "progs/v_light.mdl" );
ADDRGP4 $145
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 265
;263:
;264://///////////////////////TF///////////////////
;265:	trap_precache_model( "progs/laser.mdl" );
ADDRGP4 $146
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 266
;266:	trap_precache_sound( "enforcer/enfire.wav" );
ADDRGP4 $147
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 267
;267:	trap_precache_sound( "enforcer/enfstop.wav" );
ADDRGP4 $148
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 268
;268:	trap_precache_sound( "hknight/attack1.wav" );
ADDRGP4 $149
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 269
;269:	trap_precache_model( "progs/sight.spr" );
ADDRGP4 $150
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 270
;270:	trap_precache_model( "progs/caltrop.mdl" );
ADDRGP4 $151
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 271
;271:	trap_precache_model( "progs/cross1.mdl" );
ADDRGP4 $152
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 272
;272:	trap_precache_model( "progs/tf_flag.mdl" );
ADDRGP4 $153
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 273
;273:	trap_precache_model( "progs/tf_stan.mdl" );
ADDRGP4 $154
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 274
;274:	trap_precache_model( "progs/v_medi.mdl" );
ADDRGP4 $155
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 275
;275:	trap_precache_model( "progs/v_bio.mdl" );
ADDRGP4 $156
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 276
;276:	trap_precache_model( "progs/v_pipe.mdl" );
ADDRGP4 $157
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 277
;277:	trap_precache_model( "progs/hgren2.mdl" );
ADDRGP4 $158
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 278
;278:	trap_precache_model( "progs/biggren.mdl" );
ADDRGP4 $159
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 279
;279:	trap_precache_model( "progs/flare.mdl" );
ADDRGP4 $160
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 280
;280:	trap_precache_model( "progs/v_srifle.mdl" );
ADDRGP4 $161
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 281
;281:	trap_precache_model( "progs/v_asscan.mdl" );
ADDRGP4 $162
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 282
;282:	trap_precache_model( "progs/detpack.mdl" );
ADDRGP4 $163
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 283
;283:	trap_precache_model( "progs/ammobox.mdl" );
ADDRGP4 $164
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 284
;284:	trap_precache_model( "progs/v_knife.mdl" );
ADDRGP4 $165
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 285
;285:	trap_precache_model( "progs/v_knife2.mdl" );
ADDRGP4 $166
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 286
;286:	trap_precache_model( "progs/v_span.mdl" );
ADDRGP4 $167
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 287
;287:	trap_precache_model( "progs/e_spike1.mdl" );
ADDRGP4 $168
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 288
;288:	trap_precache_model( "progs/e_spike2.mdl" );
ADDRGP4 $169
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 289
;289:	trap_precache_model( "progs/v_rail.mdl" );
ADDRGP4 $170
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 290
;290:	trap_precache_model( "progs/turrgun.mdl" );
ADDRGP4 $171
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 291
;291:	trap_precache_model( "progs/turrbase.mdl" );
ADDRGP4 $172
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 292
;292:	trap_precache_model( "progs/tgib1.mdl" );
ADDRGP4 $173
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 293
;293:	trap_precache_model( "progs/tgib2.mdl" );
ADDRGP4 $174
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 294
;294:	trap_precache_model( "progs/tgib3.mdl" );
ADDRGP4 $175
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 295
;295:	trap_precache_model( "progs/disp.mdl" );		// not used in mtf - should it still be precache'd?
ADDRGP4 $176
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 296
;296:	trap_precache_model( "progs/dgib1.mdl" );
ADDRGP4 $177
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 297
;297:	trap_precache_model( "progs/dgib2.mdl" );
ADDRGP4 $178
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 298
;298:	trap_precache_model( "progs/dgib3.mdl" );
ADDRGP4 $179
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 299
;299:	trap_precache_model( "progs/grenade2.mdl" );
ADDRGP4 $180
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 300
;300:	trap_precache_model( "progs/v_grap.mdl" );
ADDRGP4 $181
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 301
;301:	trap_precache_model( "progs/hook.mdl" );
ADDRGP4 $182
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 302
;302:	trap_precache_model( "progs/caltrop.mdl" );
ADDRGP4 $151
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 303
;303:	trap_precache_sound( "doors/baseuse.wav" );
ADDRGP4 $183
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 304
;304:	trap_precache_sound( "doors/medtry.wav" );
ADDRGP4 $184
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 305
;305:	trap_precache_sound( "speech/saveme1.wav" );
ADDRGP4 $185
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 306
;306:	trap_precache_sound( "speech/saveme2.wav" );
ADDRGP4 $186
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 307
;307:	trap_precache_model( "progs/detpack2.mdl" );
ADDRGP4 $187
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 308
;308:	trap_precache_model( "progs/grenade3.mdl" );
ADDRGP4 $188
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 309
;309:	trap_precache_sound( "misc/b1.wav" );
ADDRGP4 $189
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 310
;310:	trap_precache_sound( "misc/b2.wav" );
ADDRGP4 $190
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 311
;311:	trap_precache_sound( "misc/b3.wav" );
ADDRGP4 $191
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 312
;312:	trap_precache_sound( "misc/b4.wav" );
ADDRGP4 $192
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 313
;313:	trap_precache_model( "progs/w_s_key.mdl" );
ADDRGP4 $193
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 314
;314:	trap_precache_model( "progs/m_s_key.mdl" );
ADDRGP4 $194
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 315
;315:	trap_precache_model( "progs/b_s_key.mdl" );
ADDRGP4 $195
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 316
;316:	trap_precache_model( "progs/w_g_key.mdl" );
ADDRGP4 $196
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 317
;317:	trap_precache_model( "progs/m_g_key.mdl" );
ADDRGP4 $197
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 318
;318:	trap_precache_model( "progs/b_g_key.mdl" );
ADDRGP4 $198
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 320
;319:	//megatf
;320:	trap_precache_model ("progs/dot1.spr");
ADDRGP4 $199
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 321
;321:	trap_precache_model ("progs/dot2.spr");
ADDRGP4 $200
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 322
;322:	trap_precache_model ("progs/dot3.spr");
ADDRGP4 $201
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 323
;323:	trap_precache_model ("progs/dot4.spr");
ADDRGP4 $202
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 325
;324:
;325:	trap_precache_model( "progs/s_light.spr" );
ADDRGP4 $203
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 331
;326://
;327:// Setup light animation tables. 'a' is total darkness, 'z' is maxbright.
;328://
;329:
;330:	// 0 normal
;331:	trap_lightstyle( 0, "m" );
CNSTI4 0
ARGI4
ADDRGP4 $204
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 334
;332:
;333:	// 1 FLICKER (first variety)
;334:	trap_lightstyle( 1, "mmnmmommommnonmmonqnmmo" );
CNSTI4 1
ARGI4
ADDRGP4 $205
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 337
;335:
;336:	// 2 SLOW STRONG PULSE
;337:	trap_lightstyle( 2, "abcdefghijklmnopqrstuvwxyzyxwvutsrqponmlkjihgfedcba" );
CNSTI4 2
ARGI4
ADDRGP4 $206
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 340
;338:
;339:	// 3 CANDLE (first variety)
;340:	trap_lightstyle( 3, "mmmmmaaaaammmmmaaaaaabcdefgabcdefg" );
CNSTI4 3
ARGI4
ADDRGP4 $207
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 343
;341:
;342:	// 4 FAST STROBE
;343:	trap_lightstyle( 4, "mamamamamama" );
CNSTI4 4
ARGI4
ADDRGP4 $208
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 346
;344:
;345:	// 5 GENTLE PULSE 1
;346:	trap_lightstyle( 5, "jklmnopqrstuvwxyzyxwvutsrqponmlkj" );
CNSTI4 5
ARGI4
ADDRGP4 $209
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 349
;347:
;348:	// 6 FLICKER (second variety)
;349:	trap_lightstyle( 6, "nmonqnmomnmomomno" );
CNSTI4 6
ARGI4
ADDRGP4 $210
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 352
;350:
;351:	// 7 CANDLE (second variety)
;352:	trap_lightstyle( 7, "mmmaaaabcdefgmmmmaaaammmaamm" );
CNSTI4 7
ARGI4
ADDRGP4 $211
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 355
;353:
;354:	// 8 CANDLE (third variety)
;355:	trap_lightstyle( 8, "mmmaaammmaaammmabcdefaaaammmmabcdefmmmaaaa" );
CNSTI4 8
ARGI4
ADDRGP4 $212
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 358
;356:
;357:	// 9 SLOW STROBE (fourth variety)
;358:	trap_lightstyle( 9, "aaaaaaaazzzzzzzz" );
CNSTI4 9
ARGI4
ADDRGP4 $213
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 361
;359:
;360:	// 10 FLUORESCENT FLICKER
;361:	trap_lightstyle( 10, "mmamammmmammamamaaamammma" );
CNSTI4 10
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 364
;362:
;363:	// 11 SLOW PULSE NOT FADE TO BLACK
;364:	trap_lightstyle( 11, "abcdefghijklmnopqrrqponmlkjihgfedcba" );
CNSTI4 11
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 369
;365:
;366:	// styles 32-62 are assigned by the light program for switchable lights
;367:
;368:	// 63 testing
;369:	trap_lightstyle( 63, "a" );
CNSTI4 63
ARGI4
ADDRGP4 $216
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 371
;370:
;371:}
LABELV $22
endproc SP_worldspawn 160 16
data
align 4
LABELV old_time
byte 4 0
export StartFrame
code
proc StartFrame 20 4
line 378
;372:
;373:int     timelimit, fraglimit, teamplay, deathmatch, framecount, coop;
;374:static  float old_time = 0;
;375:
;376:void MatchTimer( qboolean );
;377:void StartFrame( int time )
;378:{
line 379
;379:	timelimit = trap_cvar( "timelimit" ) * 60;
ADDRGP4 $218
ARGP4
ADDRLP4 0
ADDRGP4 trap_cvar
CALLF4
ASGNF4
ADDRGP4 timelimit
CNSTF4 1114636288
ADDRLP4 0
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 380
;380:	fraglimit = trap_cvar( "fraglimit" );
ADDRGP4 $219
ARGP4
ADDRLP4 4
ADDRGP4 trap_cvar
CALLF4
ASGNF4
ADDRGP4 fraglimit
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 381
;381:	teamplay  = trap_cvar( "teamplay" );
ADDRGP4 $220
ARGP4
ADDRLP4 8
ADDRGP4 trap_cvar
CALLF4
ASGNF4
ADDRGP4 teamplay
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 382
;382:	deathmatch = trap_cvar( "deathmatch" );
ADDRGP4 $221
ARGP4
ADDRLP4 12
ADDRGP4 trap_cvar
CALLF4
ASGNF4
ADDRGP4 deathmatch
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 384
;383:
;384:	framecount = framecount + 1;
ADDRLP4 16
ADDRGP4 framecount
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 385
;385:	bot_frametime = g_globalvars.time - old_time;
ADDRGP4 bot_frametime
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 old_time
INDIRF4
SUBF4
ASGNF4
line 386
;386:	old_time = g_globalvars.time;
ADDRGP4 old_time
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 387
;387:	BotFrame();
ADDRGP4 BotFrame
CALLV
pop
line 388
;388:	MatchTimer( false );
CNSTI4 0
ARGI4
ADDRGP4 MatchTimer
CALLV
pop
line 389
;389:}
LABELV $217
endproc StartFrame 20 4
import MatchTimer
import lastspawn
bss
align 4
LABELV bodyque_head
skip 4
align 4
LABELV bodyque
skip 16
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
export coop
align 4
LABELV coop
skip 4
export framecount
align 4
LABELV framecount
skip 4
export deathmatch
align 4
LABELV deathmatch
skip 4
export teamplay
align 4
LABELV teamplay
skip 4
export fraglimit
align 4
LABELV fraglimit
skip 4
export timelimit
align 4
LABELV timelimit
skip 4
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
LABELV $221
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $220
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $219
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $218
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $216
byte 1 97
byte 1 0
align 1
LABELV $215
byte 1 97
byte 1 98
byte 1 99
byte 1 100
byte 1 101
byte 1 102
byte 1 103
byte 1 104
byte 1 105
byte 1 106
byte 1 107
byte 1 108
byte 1 109
byte 1 110
byte 1 111
byte 1 112
byte 1 113
byte 1 114
byte 1 114
byte 1 113
byte 1 112
byte 1 111
byte 1 110
byte 1 109
byte 1 108
byte 1 107
byte 1 106
byte 1 105
byte 1 104
byte 1 103
byte 1 102
byte 1 101
byte 1 100
byte 1 99
byte 1 98
byte 1 97
byte 1 0
align 1
LABELV $214
byte 1 109
byte 1 109
byte 1 97
byte 1 109
byte 1 97
byte 1 109
byte 1 109
byte 1 109
byte 1 109
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 109
byte 1 97
byte 1 109
byte 1 97
byte 1 97
byte 1 97
byte 1 109
byte 1 97
byte 1 109
byte 1 109
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $213
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 122
byte 1 122
byte 1 122
byte 1 122
byte 1 122
byte 1 122
byte 1 122
byte 1 122
byte 1 0
align 1
LABELV $212
byte 1 109
byte 1 109
byte 1 109
byte 1 97
byte 1 97
byte 1 97
byte 1 109
byte 1 109
byte 1 109
byte 1 97
byte 1 97
byte 1 97
byte 1 109
byte 1 109
byte 1 109
byte 1 97
byte 1 98
byte 1 99
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 109
byte 1 109
byte 1 109
byte 1 109
byte 1 97
byte 1 98
byte 1 99
byte 1 100
byte 1 101
byte 1 102
byte 1 109
byte 1 109
byte 1 109
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 0
align 1
LABELV $211
byte 1 109
byte 1 109
byte 1 109
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 98
byte 1 99
byte 1 100
byte 1 101
byte 1 102
byte 1 103
byte 1 109
byte 1 109
byte 1 109
byte 1 109
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 109
byte 1 109
byte 1 109
byte 1 97
byte 1 97
byte 1 109
byte 1 109
byte 1 0
align 1
LABELV $210
byte 1 110
byte 1 109
byte 1 111
byte 1 110
byte 1 113
byte 1 110
byte 1 109
byte 1 111
byte 1 109
byte 1 110
byte 1 109
byte 1 111
byte 1 109
byte 1 111
byte 1 109
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $209
byte 1 106
byte 1 107
byte 1 108
byte 1 109
byte 1 110
byte 1 111
byte 1 112
byte 1 113
byte 1 114
byte 1 115
byte 1 116
byte 1 117
byte 1 118
byte 1 119
byte 1 120
byte 1 121
byte 1 122
byte 1 121
byte 1 120
byte 1 119
byte 1 118
byte 1 117
byte 1 116
byte 1 115
byte 1 114
byte 1 113
byte 1 112
byte 1 111
byte 1 110
byte 1 109
byte 1 108
byte 1 107
byte 1 106
byte 1 0
align 1
LABELV $208
byte 1 109
byte 1 97
byte 1 109
byte 1 97
byte 1 109
byte 1 97
byte 1 109
byte 1 97
byte 1 109
byte 1 97
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $207
byte 1 109
byte 1 109
byte 1 109
byte 1 109
byte 1 109
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 109
byte 1 109
byte 1 109
byte 1 109
byte 1 109
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 97
byte 1 98
byte 1 99
byte 1 100
byte 1 101
byte 1 102
byte 1 103
byte 1 97
byte 1 98
byte 1 99
byte 1 100
byte 1 101
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $206
byte 1 97
byte 1 98
byte 1 99
byte 1 100
byte 1 101
byte 1 102
byte 1 103
byte 1 104
byte 1 105
byte 1 106
byte 1 107
byte 1 108
byte 1 109
byte 1 110
byte 1 111
byte 1 112
byte 1 113
byte 1 114
byte 1 115
byte 1 116
byte 1 117
byte 1 118
byte 1 119
byte 1 120
byte 1 121
byte 1 122
byte 1 121
byte 1 120
byte 1 119
byte 1 118
byte 1 117
byte 1 116
byte 1 115
byte 1 114
byte 1 113
byte 1 112
byte 1 111
byte 1 110
byte 1 109
byte 1 108
byte 1 107
byte 1 106
byte 1 105
byte 1 104
byte 1 103
byte 1 102
byte 1 101
byte 1 100
byte 1 99
byte 1 98
byte 1 97
byte 1 0
align 1
LABELV $205
byte 1 109
byte 1 109
byte 1 110
byte 1 109
byte 1 109
byte 1 111
byte 1 109
byte 1 109
byte 1 111
byte 1 109
byte 1 109
byte 1 110
byte 1 111
byte 1 110
byte 1 109
byte 1 109
byte 1 111
byte 1 110
byte 1 113
byte 1 110
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $204
byte 1 109
byte 1 0
align 1
LABELV $203
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $202
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 111
byte 1 116
byte 1 52
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $201
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 111
byte 1 116
byte 1 51
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $200
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 111
byte 1 116
byte 1 50
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $199
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 111
byte 1 116
byte 1 49
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $198
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 103
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $197
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 109
byte 1 95
byte 1 103
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $196
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 119
byte 1 95
byte 1 103
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $195
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 115
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $194
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 109
byte 1 95
byte 1 115
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $193
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 119
byte 1 95
byte 1 115
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $192
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 98
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $191
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 98
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $190
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 98
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $189
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 98
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $188
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 51
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $187
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $186
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 109
byte 1 101
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $185
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 109
byte 1 101
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $184
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 116
byte 1 114
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $183
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 117
byte 1 115
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $182
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
LABELV $181
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $180
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $179
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 103
byte 1 105
byte 1 98
byte 1 51
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $178
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 103
byte 1 105
byte 1 98
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $177
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 103
byte 1 105
byte 1 98
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $176
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $175
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 116
byte 1 103
byte 1 105
byte 1 98
byte 1 51
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $174
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 116
byte 1 103
byte 1 105
byte 1 98
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $173
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 116
byte 1 103
byte 1 105
byte 1 98
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $172
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 116
byte 1 117
byte 1 114
byte 1 114
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $171
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 116
byte 1 117
byte 1 114
byte 1 114
byte 1 103
byte 1 117
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $170
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $169
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 101
byte 1 95
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $168
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 101
byte 1 95
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $167
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 115
byte 1 112
byte 1 97
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $166
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 107
byte 1 110
byte 1 105
byte 1 102
byte 1 101
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $165
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 107
byte 1 110
byte 1 105
byte 1 102
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $164
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 98
byte 1 111
byte 1 120
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $163
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $162
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 97
byte 1 115
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $161
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 115
byte 1 114
byte 1 105
byte 1 102
byte 1 108
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $160
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $159
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $158
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $157
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $156
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 98
byte 1 105
byte 1 111
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $155
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $154
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 116
byte 1 102
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $153
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 116
byte 1 102
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $152
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $151
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 99
byte 1 97
byte 1 108
byte 1 116
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $150
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $149
byte 1 104
byte 1 107
byte 1 110
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 47
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $148
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 47
byte 1 101
byte 1 110
byte 1 102
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $147
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 47
byte 1 101
byte 1 110
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $146
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 108
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $145
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $144
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 122
byte 1 111
byte 1 109
byte 1 95
byte 1 103
byte 1 105
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $143
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $142
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $141
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $140
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $139
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 108
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $138
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $137
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 108
byte 1 116
byte 1 51
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $136
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 108
byte 1 116
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $135
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 108
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $134
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $133
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $132
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $131
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $130
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $129
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $128
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 97
byte 1 120
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $127
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
LABELV $126
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 98
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $125
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 51
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $124
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $123
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $122
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 108
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $121
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 104
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $120
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 101
byte 1 121
byte 1 101
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $119
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $118
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
LABELV $117
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
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $116
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
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $115
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
LABELV $114
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
LABELV $113
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 108
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $112
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 108
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $111
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 111
byte 1 117
byte 1 116
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $110
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 105
byte 1 110
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 105
byte 1 110
byte 1 104
byte 1 50
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $108
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 108
byte 1 105
byte 1 109
byte 1 98
byte 1 114
byte 1 110
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $107
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 104
byte 1 50
byte 1 111
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $106
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
LABELV $105
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
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $104
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 97
byte 1 120
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $103
byte 1 98
byte 1 111
byte 1 115
byte 1 115
byte 1 49
byte 1 47
byte 1 115
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $102
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 53
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $101
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 109
byte 1 97
byte 1 108
byte 1 105
byte 1 118
byte 1 101
byte 1 53
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $100
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 109
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 53
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $99
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $98
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $97
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $96
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 109
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 54
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $94
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 54
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $93
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 53
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $92
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $91
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $90
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $89
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $88
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 116
byte 1 111
byte 1 114
byte 1 110
byte 1 111
byte 1 102
byte 1 102
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $87
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 117
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $86
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $85
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $84
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $83
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $82
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $81
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 108
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $80
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 108
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $79
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $78
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 107
byte 1 117
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $77
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $76
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 53
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $75
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $74
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $73
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $72
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $71
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 100
byte 1 116
byte 1 104
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $70
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 97
byte 1 108
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $69
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 104
byte 1 50
byte 1 111
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $68
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 97
byte 1 115
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $67
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 97
byte 1 115
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $66
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $65
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $64
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $63
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $62
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 108
byte 1 121
byte 1 114
byte 1 106
byte 1 109
byte 1 112
byte 1 56
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $61
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 98
byte 1 107
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $60
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 104
byte 1 50
byte 1 111
byte 1 104
byte 1 105
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $59
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 110
byte 1 47
byte 1 100
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $57
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 113
byte 1 119
byte 1 109
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $56
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 113
byte 1 119
byte 1 109
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $54
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $53
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 37
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $50
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $49
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $46
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 95
byte 1 99
byte 1 102
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $45
byte 1 81
byte 1 87
byte 1 32
byte 1 84
byte 1 70
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 118
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 34
byte 1 102
byte 1 111
byte 1 114
byte 1 116
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 34
byte 1 46
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $42
byte 1 42
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $39
byte 1 81
byte 1 87
byte 1 32
byte 1 84
byte 1 70
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 118
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 34
byte 1 102
byte 1 111
byte 1 114
byte 1 116
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 34
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $38
byte 1 102
byte 1 111
byte 1 114
byte 1 116
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $35
byte 1 42
byte 1 115
byte 1 118
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $34
byte 1 56
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $33
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $32
byte 1 115
byte 1 118
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $31
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 101
byte 1 49
byte 1 109
byte 1 56
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $28
byte 1 83
byte 1 80
byte 1 95
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 58
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 39
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 39
byte 1 0
align 1
LABELV $27
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $24
byte 1 0
align 1
LABELV $23
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $12
byte 1 98
byte 1 111
byte 1 100
byte 1 121
byte 1 113
byte 1 117
byte 1 101
byte 1 0
