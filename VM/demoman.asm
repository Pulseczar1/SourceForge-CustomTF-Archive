export TeamFortress_DetonatePipebombs
code
proc TeamFortress_DetonatePipebombs 8 12
file "..\src\demoman.c"
line 39
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
;21: *  $Id: demoman.c,v 1.17 2005/11/29 14:22:43 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:void    NormalGrenadeTouch(  );
;26:void    NormalGrenadeExplode(  );
;27:void    MirvGrenadeTouch(  );
;28:void    MirvGrenadeExplode(  );
;29:void    MirvGrenadeLaunch( vec3_t org, gedict_t * shooter );
;30:void    TeamFortress_DetpackSet(  );
;31:void    TeamFortress_DetpackExplode(  );
;32:void    TeamFortress_DetpackTouch(  );
;33:void    TeamFortress_DetpackDisarm(  );
;34:void    TeamFortress_DetpackCountDown(  );
;35:
;36://=========================================================================
;37:// Detonate all thrown pipebombs
;38:void TeamFortress_DetonatePipebombs(  )
;39:{
line 42
;40:	gedict_t *e;
;41:	// Find all this players pipebombs
;42:	for ( e = world; (e = trap_find( e, FOFS( s.v.classname ), "pipebomb" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $15
JUMPV
LABELV $12
line 43
;43:	{
line 44
;44:		if ( e->s.v.owner == EDICT_TO_PROG( self ) )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $17
line 45
;45:			e->s.v.nextthink = g_globalvars.time;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
LABELV $17
line 46
;46:	}
LABELV $13
line 42
LABELV $15
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $16
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
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
NEU4 $12
line 47
;47:}
LABELV $11
endproc TeamFortress_DetonatePipebombs 8 12
export PipebombTouch
proc PipebombTouch 12 20
line 52
;48:
;49://=========================================================================
;50:// Pipebomb touch function
;51:void PipebombTouch(  )
;52:{
line 53
;53:	sound( self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM );  // bounce sound
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $21
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
line 54
;54:	if ( VectorCompareF( self->s.v.velocity, 0, 0, 0 ) )
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
EQI4 $22
line 55
;55:		SetVector( self->s.v.avelocity, 0, 0, 0 );
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
LABELV $22
line 56
;56:}
LABELV $20
endproc PipebombTouch 12 20
export MirvGrenadeTouch
proc MirvGrenadeTouch 12 20
line 62
;57:
;58://=========================================================================
;59:// Touch Function for Mirv Grenade
;60:// Mirv Grenade heavily influenced by the Firewall Grenade by Steve Bond (wedge@nuc.net)
;61:void MirvGrenadeTouch(  )
;62:{
line 64
;63:        // If the Mirv Grenade hits a player, it just bounces off
;64:	sound( self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $21
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
line 65
;65:	if ( VectorCompareF( self->s.v.velocity, 0, 0, 0 ) )
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
EQI4 $25
line 66
;66:		SetVector( self->s.v.avelocity, 0, 0, 0 );
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
LABELV $25
line 67
;67:}
LABELV $24
endproc MirvGrenadeTouch 12 20
export MirvGrenadeExplode
proc MirvGrenadeExplode 16 16
line 72
;68:
;69://=========================================================================
;70:// Mirv Grenade explode function, for when the PRIMETIME runs out
;71:void MirvGrenadeExplode(  )
;72:{
line 75
;73:	float   i;
;74:
;75:	tf_data.deathmsg = DMSG_GREN_MIRV;
ADDRGP4 tf_data+88
CNSTI4 10
ASGNI4
line 76
;76:	T_RadiusDamage( self, PROG_TO_EDICT( self->s.v.owner ), 100, world );
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
CNSTF4 1120403456
ARGF4
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 77
;77:	trap_WriteByte( MSG_BROADCAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 78
;78:	trap_WriteByte( MSG_BROADCAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 79
;79:	trap_WriteCoord( MSG_BROADCAST, self->s.v.origin[0] );
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
line 80
;80:	trap_WriteCoord( MSG_BROADCAST, self->s.v.origin[1] );
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
line 81
;81:	trap_WriteCoord( MSG_BROADCAST, self->s.v.origin[2] );
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
line 82
;82:	trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
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
line 83
;83:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 85
;84:	// Launch mirvs
;85:	for ( i = 0; i < GR_TYPE_MIRV_NO; i++)
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRGP4 $32
JUMPV
LABELV $29
line 86
;86:	{
line 87
;87:		MirvGrenadeLaunch( self->s.v.origin, PROG_TO_EDICT( self->s.v.owner ) );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRGP4 MirvGrenadeLaunch
CALLV
pop
line 88
;88:	}
LABELV $30
line 85
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $32
ADDRLP4 0
INDIRF4
ADDRGP4 GR_TYPE_MIRV_NO
INDIRI4
CVIF4 4
LTF4 $29
line 89
;89:	BecomeExplosion(  );
ADDRGP4 BecomeExplosion
CALLV
pop
line 90
;90:}
LABELV $27
endproc MirvGrenadeExplode 16 16
export MirvGrenadeLaunch
proc MirvGrenadeLaunch 44 28
line 98
;91:
;92://=========================================================================
;93:// Launch a Mirv
;94:void GrenadeTouch(  );
;95:void GrenadeExplode(  );
;96:
;97:void MirvGrenadeLaunch( vec3_t org, gedict_t * shooter )
;98:{
line 103
;99:	float   xdir;
;100:	float   ydir;
;101:	float   zdir;
;102:
;103:	xdir = 150 * g_random(  ) - 75;
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1125515264
ADDRLP4 12
INDIRF4
MULF4
CNSTF4 1117126656
SUBF4
ASGNF4
line 104
;104:	ydir = 150 * g_random(  ) - 75;
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
line 105
;105:	zdir = 40 * g_random(  );
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 8
CNSTF4 1109393408
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
line 106
;106:	newmis = spawn(  );
ADDRLP4 24
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 24
INDIRP4
ASGNP4
line 107
;107:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 108
;108:	newmis->s.v.owner = EDICT_TO_PROG( shooter );
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
line 109
;109:	newmis->s.v.movetype = MOVETYPE_BOUNCE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 110
;110:	newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 111
;111:	newmis->s.v.classname = "grenade";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $35
ASGNP4
line 112
;112:	newmis->s.v.weapon = 10;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1092616192
ASGNF4
line 113
;113:	if( tf_data.lan_mode )
ADDRGP4 tf_data+176
INDIRI4
CNSTI4 0
EQI4 $36
line 114
;114:	{
line 115
;115:		newmis->s.v.touch = ( func_t ) GrenadeTouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 GrenadeTouch
CVPU4 4
CVUI4 4
ASGNI4
line 116
;116:		newmis->s.v.think = ( func_t ) GrenadeExplode;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 GrenadeExplode
CVPU4 4
CVUI4 4
ASGNI4
line 117
;117:	}else
ADDRGP4 $37
JUMPV
LABELV $36
line 118
;118:	{
line 119
;119:		newmis->s.v.touch = ( func_t ) NormalGrenadeTouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 NormalGrenadeTouch
CVPU4 4
CVUI4 4
ASGNI4
line 120
;120:		newmis->s.v.think = ( func_t ) NormalGrenadeExplode;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 NormalGrenadeExplode
CVPU4 4
CVUI4 4
ASGNI4
line 121
;121:	}
LABELV $37
line 123
;122:
;123:	newmis->s.v.nextthink = g_globalvars.time + 2 + g_random(  );
ADDRLP4 28
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ADDRLP4 28
INDIRF4
ADDF4
ASGNF4
line 124
;124:	newmis->s.v.velocity[0] = xdir * 2;
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1073741824
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 125
;125:	newmis->s.v.velocity[1] = ydir * 2;
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1073741824
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 126
;126:	newmis->s.v.velocity[2] = zdir * 15 + 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1097859072
ADDRLP4 8
INDIRF4
MULF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 127
;127:	SetVector( newmis->s.v.avelocity, 250, 300, 400 );
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
line 128
;128:	if ( tf_data.birthday == 1 && g_random(  ) < 0.3 )
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $40
ADDRLP4 32
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1050253722
GEF4 $40
line 129
;129:		setmodel( newmis, "progs/grenade3.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $43
ARGP4
ADDRGP4 setmodel
CALLV
pop
ADDRGP4 $41
JUMPV
LABELV $40
line 131
;130:	else
;131:		setmodel( newmis, "progs/grenade2.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $44
ARGP4
ADDRGP4 setmodel
CALLV
pop
LABELV $41
line 133
;132:
;133:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 134
;134:	setorigin( newmis, PASSVEC3( org ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 135
;135:}
LABELV $33
endproc MirvGrenadeLaunch 44 28
export Detpack_SetClip
proc Detpack_SetClip 12 12
line 142
;136:
;137://=========================================================================
;138:// Handles the Setting of Detpacks
;139:
;140:// Training Ground Stuff
;141:void Detpack_SetClip(  )
;142:{
line 145
;143:	gedict_t *te;
;144:
;145:	for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "detpack" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $49
JUMPV
LABELV $46
line 146
;146:	{
line 147
;147:	        switch(tg_data.detpack_clip)
ADDRLP4 4
ADDRGP4 tg_data+20
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $56
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $54
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $55
ADDRGP4 $51
JUMPV
line 148
;148:	        {
LABELV $54
line 150
;149:	        	case TG_DETPACK_CLIP_ALL:
;150:	        		te->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 151
;151:	        		break;
ADDRGP4 $52
JUMPV
LABELV $55
line 153
;152:	        	case TG_DETPACK_SOLID_ALL:
;153:				te->s.v.solid = SOLID_BBOX;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 154
;154:				te->s.v.owner = EDICT_TO_PROG( world );
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 world
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 155
;155:	        		break;
ADDRGP4 $52
JUMPV
LABELV $56
LABELV $51
line 159
;156:
;157:	        	case TG_DETPACK_CLIP_OWNER:
;158:	        	default:	
;159:				te->s.v.solid = SOLID_BBOX;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 160
;160:				te->s.v.owner = EDICT_TO_PROG( te->real_owner );
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 161
;161:				break;
LABELV $52
line 163
;162:	        }
;163:	}
LABELV $47
line 145
LABELV $49
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $50
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
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
NEU4 $46
line 164
;164:}
LABELV $45
endproc Detpack_SetClip 12 12
export TeamFortress_Cmd_Detpack
proc TeamFortress_Cmd_Detpack 1040 12
line 167
;165:
;166:void TeamFortress_Cmd_Detpack()
;167:{
line 171
;168:        int time;
;169:        char    value[1024];
;170:
;171:        if( trap_CmdArgc() != 2)
ADDRLP4 1028
ADDRGP4 trap_CmdArgc
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
EQI4 $58
line 172
;172:        	return;
ADDRGP4 $57
JUMPV
LABELV $58
line 174
;173:
;174:        trap_CmdArgv( 1, value, sizeof( value ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 175
;175:        if( !strcmp(value,"stop"))
ADDRLP4 0
ARGP4
ADDRGP4 $62
ARGP4
ADDRLP4 1032
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $60
line 176
;176:        {
line 177
;177:        	TeamFortress_DetpackStop();
ADDRGP4 TeamFortress_DetpackStop
CALLV
pop
line 178
;178:        	return;
ADDRGP4 $57
JUMPV
LABELV $60
line 181
;179:        }
;180:
;181:        time = atoi(value);
ADDRLP4 0
ARGP4
ADDRLP4 1036
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
ADDRLP4 1036
INDIRI4
ASGNI4
line 182
;182:        if (  time > 255 )
ADDRLP4 1024
INDIRI4
CNSTI4 255
LEI4 $63
line 183
;183:        	time = 255;
ADDRLP4 1024
CNSTI4 255
ASGNI4
LABELV $63
line 184
;184:        TeamFortress_SetDetpack( time );
ADDRLP4 1024
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 TeamFortress_SetDetpack
CALLV
pop
line 185
;185:}
LABELV $57
endproc TeamFortress_Cmd_Detpack 1040 12
export TeamFortress_SetDetpack
proc TeamFortress_SetDetpack 44 20
line 188
;186:
;187:void TeamFortress_SetDetpack( float timer )
;188:{
line 193
;189:	gedict_t *te;
;190:	gedict_t *at_spot;
;191:
;192:	// prevent detpack impulse from triggering anything else
;193:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 194
;194:	self->last_impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 196
;195:
;196:	if ( !( self->weapons_carried & WEAP_DETPACK ) && !tg_data.tg_enabled )
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
ADDRLP4 8
INDIRI4
NEI4 $66
ADDRGP4 tg_data
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $66
line 197
;197:		return;
ADDRGP4 $65
JUMPV
LABELV $66
line 198
;198:	if ( (tf_data.disable_grens & DG_TYPE_DETPACK) && !tg_data.tg_enabled )
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 tf_data+100
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 12
INDIRI4
EQI4 $68
ADDRGP4 tg_data
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $68
line 199
;199:		return;
ADDRGP4 $65
JUMPV
LABELV $68
line 200
;200:	if ( self->ammo_detpack <= 0 && !tg_data.tg_enabled )
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1052
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
GTI4 $71
ADDRGP4 tg_data
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $71
line 201
;201:		return;
ADDRGP4 $65
JUMPV
LABELV $71
line 203
;202:
;203:	for ( at_spot = world; (at_spot = findradius( at_spot, self->s.v.origin, 65 )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $76
JUMPV
LABELV $73
line 204
;204:	{
line 205
;205:		if ( streq( at_spot->s.v.classname, "player" ) && self != at_spot )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $79
ARGP4
ADDRLP4 20
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $77
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $77
line 206
;206:		{
line 207
;207:			G_sprint( self, 2, "You can't set a detpack on someone!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $80
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 208
;208:			return;
ADDRGP4 $65
JUMPV
LABELV $77
line 210
;209:		}
;210:		if ( streq( at_spot->mdl, "progs/turrbase.mdl" ) || streq( at_spot->mdl, "progs/turrgun.mdl" ) )
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 $83
ARGP4
ADDRLP4 24
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $85
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 $84
ARGP4
ADDRLP4 28
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $81
LABELV $85
line 211
;211:		{
line 212
;212:			G_sprint( self, 2, "You can't set a detpack on a sentry gun!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $86
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 213
;213:			return;
ADDRGP4 $65
JUMPV
LABELV $81
line 216
;214:		}
;215:		//if ( streq( at_spot->mdl, "progs/disp.mdl" ) )
;216:		if ( streq( at_spot->mdl, "progs/dispencr.mdl" ) )
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 $89
ARGP4
ADDRLP4 32
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $87
line 217
;217:		{
line 218
;218:			G_sprint( self, 2, "You can't set a detpack on a dispenser!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $90
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 219
;219:			return;
ADDRGP4 $65
JUMPV
LABELV $87
line 221
;220:		}
;221:		if ( tf_data.birthday == 1 && streq( at_spot->mdl, "progs/detpack2.mdl" ) )
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $91
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 $94
ARGP4
ADDRLP4 36
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $91
line 222
;222:		{
line 223
;223:			G_sprint( self, 2, "Detpacks can't be stacked!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $95
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 224
;224:			return;
ADDRGP4 $65
JUMPV
LABELV $91
line 226
;225:		}
;226:		if ( streq( at_spot->s.v.classname, "detpack" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $50
ARGP4
ADDRLP4 40
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $96
line 227
;227:		{
line 228
;228:			G_sprint( self, 2, "Detpacks can't be stacked!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $95
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 229
;229:			return;
ADDRGP4 $65
JUMPV
LABELV $96
line 231
;230:		}
;231:	}
LABELV $74
line 203
LABELV $76
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTF4 1115815936
ARGF4
ADDRLP4 20
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $73
line 232
;232:	if ( tf_data.detpack_block )
ADDRGP4 tf_data+168
INDIRI4
CNSTI4 0
EQI4 $98
line 233
;233:	{
line 234
;234:		for ( at_spot = world; (at_spot = findradius( at_spot, self->s.v.origin, 100 )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $104
JUMPV
LABELV $101
line 235
;235:		{
line 236
;236:			if ( tf_data.birthday == 1 && streq( at_spot->mdl, "progs/detpack2.mdl" ) )
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $105
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 $94
ARGP4
ADDRLP4 24
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $105
line 237
;237:			{
line 238
;238:				G_sprint( self, 2, "Detpacks can't be stacked!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $95
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 239
;239:				return;
ADDRGP4 $65
JUMPV
LABELV $105
line 241
;240:			}
;241:			if ( streq( at_spot->s.v.classname, "detpack" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $50
ARGP4
ADDRLP4 28
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $108
line 242
;242:			{
line 243
;243:				G_sprint( self, 2, "Detpacks can't be stacked!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $95
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 244
;244:				return;
ADDRGP4 $65
JUMPV
LABELV $108
line 246
;245:			}
;246:		}
LABELV $102
line 234
LABELV $104
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTF4 1120403456
ARGF4
ADDRLP4 24
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $101
line 247
;247:	}
LABELV $98
line 249
;248:	// Cant set detpack if you're in the air
;249:	if ( !( ( int ) self->s.v.flags & FL_ONGROUND ) )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $110
line 250
;250:	{
line 251
;251:		G_sprint( self, PRINT_HIGH, "You can't set detpacks in the air!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $112
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 252
;252:		return;
ADDRGP4 $65
JUMPV
LABELV $110
line 254
;253:	}
;254:        if( !tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
NEI4 $113
line 255
;255:        {
line 256
;256:        	for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "detpack" )); )
ADDRLP4 4
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $118
JUMPV
LABELV $115
line 257
;257:        	{
line 258
;258:        		if ( te->s.v.owner == EDICT_TO_PROG( self ) )
ADDRLP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $119
line 259
;259:        		{
line 260
;260:        			G_sprint( self, PRINT_HIGH, "You can only have 1 detpack active at a time.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $121
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 261
;261:        			return;
ADDRGP4 $65
JUMPV
LABELV $119
line 263
;262:        		}
;263:        	}
LABELV $116
line 256
LABELV $118
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $50
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $115
line 264
;264:        }
LABELV $113
line 265
;265:	if ( timer < 5 )
ADDRFP4 0
INDIRF4
CNSTF4 1084227584
GEF4 $122
line 266
;266:	{
line 267
;267:		G_sprint( self, 2, "You can't set detpacks for less that 5 seconds.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $124
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 268
;268:		return;
ADDRGP4 $65
JUMPV
LABELV $122
line 270
;269:	}
;270:	self->is_detpacking = 1;
ADDRGP4 self
INDIRP4
CNSTI4 876
ADDP4
CNSTI4 1
ASGNI4
line 271
;271:	self->ammo_detpack = self->ammo_detpack - 1;
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 1052
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 272
;272:	self->tfstate = self->tfstate | TFSTATE_CANT_MOVE;
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 274
;273:	// Save the current weapon and remove it
;274:	self->s.v.weapon = self->current_weapon;
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 304
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 275
;275:	self->current_weapon = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 0
ASGNI4
line 276
;276:	self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $125
ASGNP4
line 277
;277:	self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 279
;278:
;279:	TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 280
;280:	self->pausetime = g_globalvars.time + WEAP_DETPACK_SETTIME;
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 281
;281:	G_sprint( self, 2, "Setting detpack for %.0f seconds...\n", timer );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $127
ARGP4
ADDRFP4 0
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 282
;282:	sound( self, 2, "items/flare1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $128
ARGP4
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 283
;283:	newmis = spawn(  );
ADDRLP4 40
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 40
INDIRP4
ASGNP4
line 284
;284:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 286
;285:
;286:	newmis->s.v.owner = EDICT_TO_PROG( self );
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
line 287
;287:	newmis->real_owner = self;
ADDRGP4 newmis
INDIRP4
CNSTI4 976
ADDP4
ADDRGP4 self
INDIRP4
ASGNP4
line 289
;288:
;289:	newmis->s.v.classname = "timer";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $130
ASGNP4
line 290
;290:	newmis->s.v.netname = "detpack_timer";
ADDRGP4 newmis
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $131
ASGNP4
line 291
;291:	newmis->s.v.nextthink = g_globalvars.time + WEAP_DETPACK_SETTIME;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 292
;292:	newmis->s.v.think = ( func_t ) TeamFortress_DetpackSet;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TeamFortress_DetpackSet
CVPU4 4
CVUI4 4
ASGNI4
line 293
;293:	newmis->s.v.health = timer;
ADDRGP4 newmis
INDIRP4
CNSTI4 296
ADDP4
ADDRFP4 0
INDIRF4
ASGNF4
line 294
;294:}
LABELV $65
endproc TeamFortress_SetDetpack 44 20
export TeamFortress_DetpackStop
proc TeamFortress_DetpackStop 24 12
line 299
;295:
;296://=========================================================================
;297:// Stops the setting of the detpack
;298:void TeamFortress_DetpackStop(  )
;299:{
line 302
;300:	gedict_t *detpack_timer;
;301:
;302:	for ( detpack_timer = world; (detpack_timer = trap_find( detpack_timer, FOFS( s.v.netname ), "detpack_timer" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $137
JUMPV
LABELV $134
line 303
;303:	{
line 304
;304:		if ( detpack_timer->s.v.owner == EDICT_TO_PROG( self ) )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $138
line 305
;305:			break;
ADDRGP4 $136
JUMPV
LABELV $138
line 306
;306:	}
LABELV $135
line 302
LABELV $137
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 396
ARGI4
ADDRGP4 $131
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
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
NEU4 $134
LABELV $136
line 307
;307:	if ( !detpack_timer )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $140
line 308
;308:		return;
ADDRGP4 $133
JUMPV
LABELV $140
line 309
;309:	G_sprint( self, 2, "Detpack retrieved.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 310
;310:	self->ammo_detpack = self->ammo_detpack + 1;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 1052
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 311
;311:	dremove( detpack_timer );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 312
;312:	self->tfstate = self->tfstate - ( self->tfstate & TFSTATE_CANT_MOVE );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 65536
BANDI4
SUBI4
ASGNI4
line 313
;313:	self->is_detpacking = 0;
ADDRGP4 self
INDIRP4
CNSTI4 876
ADDP4
CNSTI4 0
ASGNI4
line 314
;314:	self->current_weapon = self->s.v.weapon;
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 1032
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 315
;315:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 316
;316:	TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 317
;317:	self->pausetime = g_globalvars.time;
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 318
;318:}
LABELV $133
endproc TeamFortress_DetpackStop 24 12
export TeamFortress_DetpackSet
proc TeamFortress_DetpackSet 72 28
line 323
;319:
;320://=========================================================================
;321:// The detpack is set, let the player go and start timer
;322:void TeamFortress_DetpackSet(  )
;323:{
line 327
;324:	gedict_t *countd;
;325:	gedict_t *oldself, *owner;
;326:
;327:	owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 328
;328:	self->is_detpacking = 0;
ADDRGP4 self
INDIRP4
CNSTI4 876
ADDP4
CNSTI4 0
ASGNI4
line 329
;329:	owner->tfstate = owner->tfstate - ( owner->tfstate & TFSTATE_CANT_MOVE );
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 65536
BANDI4
SUBI4
ASGNI4
line 330
;330:	TeamFortress_SetSpeed( owner );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 331
;331:	sound( owner, 2, "doors/medtry.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $145
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
line 332
;332:	oldself = self;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
line 333
;333:	self = owner;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 334
;334:	self->is_detpacking = 0;
ADDRGP4 self
INDIRP4
CNSTI4 876
ADDP4
CNSTI4 0
ASGNI4
line 335
;335:	self->current_weapon = self->s.v.weapon;
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 1032
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 336
;336:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 337
;337:	self = oldself;
ADDRGP4 self
ADDRLP4 8
INDIRP4
ASGNP4
line 338
;338:	newmis = spawn(  );
ADDRLP4 28
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 28
INDIRP4
ASGNP4
line 339
;339:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 340
;340:	newmis->s.v.owner = self->s.v.owner;
ADDRLP4 32
CNSTI4 480
ASGNI4
ADDRGP4 newmis
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
line 341
;341:	VectorCopy( owner->s.v.origin, newmis->s.v.origin );
ADDRLP4 36
CNSTI4 156
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 40
CNSTI4 160
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 44
CNSTI4 164
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 342
;342:	newmis->s.v.origin[2] -= 23;
ADDRLP4 36
ADDRGP4 newmis
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1102577664
SUBF4
ASGNF4
line 344
;343:
;344:	newmis->real_owner = self->real_owner;
ADDRLP4 40
CNSTI4 976
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 346
;345:
;346:	newmis->s.v.movetype = MOVETYPE_BOUNCE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 347
;347:	newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 348
;348:	newmis->s.v.classname = "detpack";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $50
ASGNP4
line 349
;349:	newmis->s.v.flags = 256;
ADDRGP4 newmis
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 1132462080
ASGNF4
line 350
;350:	SetVector( newmis->s.v.angles, 90, 0, 0 );
ADDRGP4 newmis
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1119092736
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 0
ASGNF4
line 351
;351:	newmis->s.v.angles[1] = owner->s.v.angles[1];
ADDRLP4 44
CNSTI4 196
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 352
;352:	SetVector( newmis->s.v.velocity, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 0
ASGNF4
line 353
;353:	SetVector( newmis->s.v.avelocity, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 0
ASGNF4
line 355
;354:
;355:	newmis->weaponmode = 0;        // Detpack weaponmode = 1 when disarming
ADDRGP4 newmis
INDIRP4
CNSTI4 940
ADDP4
CNSTI4 0
ASGNI4
line 356
;356:	newmis->s.v.touch = ( func_t ) TeamFortress_DetpackTouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 TeamFortress_DetpackTouch
CVPU4 4
CVUI4 4
ASGNI4
line 358
;357:
;358:	if ( tf_data.birthday == 1 )
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $147
line 359
;359:		setmodel( newmis, "progs/detpack2.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $94
ARGP4
ADDRGP4 setmodel
CALLV
pop
ADDRGP4 $148
JUMPV
LABELV $147
line 361
;360:	else
;361:		setmodel( newmis, "progs/detpack.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $150
ARGP4
ADDRGP4 setmodel
CALLV
pop
LABELV $148
line 362
;362:	setsize( newmis, -16, -16, 0, 16, 16, 8 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 48
CNSTF4 3246391296
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 52
CNSTF4 1098907648
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
CNSTF4 1090519040
ARGF4
ADDRGP4 setsize
CALLV
pop
line 363
;363:	setorigin( newmis, PASSVEC3( owner->s.v.origin ) );
ADDRGP4 newmis
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
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 366
;364:	
;365:	// Create the CountDown entity
;366:	countd = spawn(  );
ADDRLP4 60
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 60
INDIRP4
ASGNP4
line 367
;367:	newmis->linked_list = countd;
ADDRGP4 newmis
INDIRP4
CNSTI4 896
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 368
;368:	countd->s.v.think = ( func_t ) TeamFortress_DetpackCountDown;
ADDRLP4 4
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TeamFortress_DetpackCountDown
CVPU4 4
CVUI4 4
ASGNI4
line 369
;369:	countd->s.v.health = self->s.v.health - 1;
ADDRLP4 64
CNSTI4 296
ASGNI4
ADDRLP4 4
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
CNSTF4 1065353216
SUBF4
ASGNF4
line 370
;370:	countd->s.v.owner = self->s.v.owner;
ADDRLP4 68
CNSTI4 480
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 371
;371:	countd->s.v.classname = "countdown_timer";// Don't call it timer, because we
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $151
ASGNP4
line 373
;372:                                                  // don't want it removed if player dies
;373:	countd->s.v.enemy = EDICT_TO_PROG( newmis );
ADDRLP4 4
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 374
;374:	newmis->oldenemy = countd;
ADDRGP4 newmis
INDIRP4
CNSTI4 980
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 375
;375:	if ( self->s.v.health <= 255 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1132396544
GTF4 $152
line 376
;376:		countd->s.v.nextthink = g_globalvars.time + 1;
ADDRLP4 4
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
ADDRGP4 $153
JUMPV
LABELV $152
line 378
;377:	else
;378:	{
line 379
;379:		countd->s.v.nextthink = g_globalvars.time + self->s.v.health - 10;
ADDRLP4 4
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ADDF4
CNSTF4 1092616192
SUBF4
ASGNF4
line 380
;380:		countd->s.v.health = 9;
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1091567616
ASGNF4
line 381
;381:	}
LABELV $153
line 382
;382:	newmis->s.v.nextthink = g_globalvars.time + self->s.v.health;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ADDF4
ASGNF4
line 383
;383:	newmis->s.v.think = ( func_t ) TeamFortress_DetpackExplode;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TeamFortress_DetpackExplode
CVPU4 4
CVUI4 4
ASGNI4
line 384
;384:	G_sprint( owner, 2, "Detpack set!\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $157
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 385
;385:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 386
;386:}
LABELV $144
endproc TeamFortress_DetpackSet 72 28
export TeamFortress_DetpackExplode
proc TeamFortress_DetpackExplode 92 32
line 391
;387:
;388://=========================================================================
;389:// The detpack goes BOOM!
;390:void TeamFortress_DetpackExplode(  )
;391:{
line 398
;392:	float   pos;
;393:	float   points;
;394:	gedict_t *head;
;395:	gedict_t *te, *owner;
;396:	vec3_t  org, vtemp;
;397:
;398:	owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 36
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 399
;399:	G_bprint( 1, "FIRE IN THE HOLE!\n" );
CNSTI4 1
ARGI4
ADDRGP4 $159
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 401
;400:
;401:	sound( self, 1, "weapons/detpack.wav", 1, 0 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $160
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 402
;402:	if ( tf_data.birthday == 1 )
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $161
line 403
;403:		G_bprint( 1, "%s spreads good cheer!\n", self->real_owner->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $164
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
LABELV $161
line 406
;404:
;405:	// Check the pointcontents to prevent detpack outside the world
;406:	pos = trap_pointcontents( PASSVEC3( self->s.v.origin ) );
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
ADDRLP4 48
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 48
INDIRI4
CVIF4 4
ASGNF4
line 408
;407:
;408:	if ( pos != CONTENT_SOLID && pos != CONTENT_SKY && self->real_owner->has_disconnected != 1 )
ADDRLP4 32
INDIRF4
CNSTF4 3221225472
EQF4 $165
ADDRLP4 32
INDIRF4
CNSTF4 3233808384
EQF4 $165
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
EQI4 $165
line 409
;409:	{
line 410
;410:		tf_data.deathmsg = DMSG_DETPACK;
ADDRGP4 tf_data+88
CNSTI4 12
ASGNI4
line 411
;411:		for ( head = world; (head = findradius( head, self->s.v.origin, WEAP_DETPACK_SIZE )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $171
JUMPV
LABELV $168
line 412
;412:		{
line 413
;413:			if ( streq( head->s.v.classname, "info_tfgoal" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $174
ARGP4
ADDRLP4 56
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $172
line 414
;414:			{
line 415
;415:				if ( ( head->goal_activation & TFGA_TOUCH_DETPACK ) && !head->search_time )
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $173
ADDRLP4 0
INDIRP4
CNSTI4 1108
ADDP4
INDIRF4
CNSTF4 0
NEF4 $173
line 416
;416:				{
line 417
;417:					traceline( PASSVEC3( self->s.v.origin ), PASSVEC3( head->s.v.origin ), 1,
ADDRLP4 64
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 68
CNSTI4 156
ASGNI4
ADDRLP4 64
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
CNSTI4 160
ASGNI4
ADDRLP4 64
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 76
CNSTI4 164
ASGNI4
ADDRLP4 64
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 419
;418:						   self );
;419:					if ( g_globalvars.trace_fraction == 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $173
line 420
;420:					{
line 421
;421:						if ( Activated( head, self->real_owner ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 Activated
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $180
line 422
;422:							DoResults( head, self->real_owner, 1 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 DoResults
CALLV
pop
ADDRGP4 $173
JUMPV
LABELV $180
line 424
;423:						else
;424:						{
line 425
;425:							if ( head->else_goal )
ADDRLP4 0
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $173
line 426
;426:							{
line 427
;427:								te = Findgoal( head->else_goal );
ADDRLP4 0
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 88
INDIRP4
ASGNP4
line 428
;428:								if ( te )
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $173
line 429
;429:									AttemptToActivate( te, self->real_owner, head );
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 AttemptToActivate
CALLV
pop
line 430
;430:							}
line 431
;431:						}
line 432
;432:					}
line 433
;433:				}
line 434
;434:			} else
ADDRGP4 $173
JUMPV
LABELV $172
line 435
;435:			{
line 436
;436:				VectorSubtract( head->s.v.origin, self->s.v.origin, vtemp );
ADDRLP4 60
CNSTI4 156
ASGNI4
ADDRLP4 16
ADDRLP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
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
ADDRLP4 16+4
ADDRLP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
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
ADDRLP4 16+8
ADDRLP4 0
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 437
;437:				if ( head->s.v.takedamage && vlen( vtemp ) <= 700 )
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $188
ADDRLP4 16
ARGP4
ADDRLP4 60
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 1143930880
GTF4 $188
line 438
;438:				{
line 439
;439:					VectorAdd( head->s.v.mins, head->s.v.maxs, org );
ADDRLP4 4
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
ASGNF4
ADDRLP4 4+4
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
ASGNF4
ADDRLP4 4+8
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
ASGNF4
line 440
;440:					VectorScale( org, 0.5, org );
ADDRLP4 4
ARGP4
CNSTF4 1056964608
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 441
;441:					VectorAdd( head->s.v.origin, org, org );
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDF4
ASGNF4
line 442
;442:					VectorSubtract( head->s.v.origin, org, vtemp );
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 443
;443:					points = 0.5 * vlen( vtemp );
ADDRLP4 16
ARGP4
ADDRLP4 64
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 28
CNSTF4 1056964608
ADDRLP4 64
INDIRF4
MULF4
ASGNF4
line 444
;444:					if ( points < 0 )
ADDRLP4 28
INDIRF4
CNSTF4 0
GEF4 $200
line 445
;445:						points = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
LABELV $200
line 446
;446:					points = 700 - points;
ADDRLP4 28
CNSTF4 1143930880
ADDRLP4 28
INDIRF4
SUBF4
ASGNF4
line 447
;447:					if ( points )
ADDRLP4 28
INDIRF4
CNSTF4 0
EQF4 $202
line 448
;448:					{
line 449
;449:						if ( CanDamage( head, self ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 CanDamage
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $204
line 450
;450:							TF_T_Damage( head, self, self->real_owner, points * 2, 2, 4 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTF4 1073741824
ADDRLP4 28
INDIRF4
MULF4
ARGF4
CNSTI4 2
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
LABELV $204
line 451
;451:					}
LABELV $202
line 452
;452:				}
LABELV $188
line 453
;453:			}
LABELV $173
line 454
;454:		}
LABELV $169
line 411
LABELV $171
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTF4 1153138688
ARGF4
ADDRLP4 56
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $168
line 455
;455:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 456
;456:		trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 457
;457:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 458
;458:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 459
;459:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 460
;460:		trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
ADDRLP4 60
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
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
line 461
;461:	} else
ADDRGP4 $166
JUMPV
LABELV $165
line 462
;462:		G_sprint( self->real_owner, 2, "Your detpack fizzled out.\n" );
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $206
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $166
line 464
;463:	// This code handles a disarming scout with protection
;464:	if ( self->weaponmode == 1 )// Detpack was being disarmed
ADDRGP4 self
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 1
NEI4 $207
line 465
;465:	{
line 466
;466:		TeamFortress_SetSpeed( PROG_TO_EDICT( self->s.v.enemy ) );
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 467
;467:		dremove( self->oldenemy );            // CountDown
ADDRGP4 self
INDIRP4
CNSTI4 980
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 468
;468:		dremove( self->observer_list );       // Disarm timer
ADDRGP4 self
INDIRP4
CNSTI4 900
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 469
;469:	}
LABELV $207
line 470
;470:	BecomeExplosion(  );
ADDRGP4 BecomeExplosion
CALLV
pop
line 471
;471:}
LABELV $158
endproc TeamFortress_DetpackExplode 92 32
export TeamFortress_DetpackTouch
proc TeamFortress_DetpackTouch 8 20
line 476
;472:
;473://=========================================================================
;474:// The detpack touch function. Scouts can disarm it.
;475:void TeamFortress_DetpackTouch(  )
;476:{
line 478
;477:	// no real detpack touch function in newer MegaTF builds
;478:	if ( !streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $79
ARGP4
ADDRLP4 0
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $210
line 479
;479:		sound (self, 3, "zombie/z_hit.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $212
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
LABELV $210
line 527
;480:/*	gedict_t *disarm, *owner;
;481:	vec3_t  source;
;482:	vec3_t  dest;
;483:
;484:	if ( tg_data.detpack_drop )
;485:		CheckBelowBuilding( self );
;486:
;487:	if ( tg_data.disable_disarm )
;488:		return;
;489:
;490:	if ( strneq( other->s.v.classname, "player" ) )
;491:		return;
;492:	if ( other->playerclass != PC_SCOUT )
;493:		return;
;494:	if ( other->s.v.deadflag )
;495:		return;
;496:	if ( self->weaponmode == 1 )
;497:		return;
;498:	owner = PROG_TO_EDICT( self->s.v.owner );
;499:
;500:	if ( (owner->team_no && TeamFortress_isTeamsAllied (other->team_no , owner->team_no)) && !tg_data.tg_enabled )
;501:		return;
;502:
;503:	makevectors( other->s.v.v_angle );
;504:	VectorCopy( other->s.v.origin, source );
;505:	source[2] += 16;
;506:
;507:	VectorScale( g_globalvars.v_forward, 64, dest );
;508:	VectorAdd( source, dest, dest );
;509:	traceline( PASSVEC3( source ), PASSVEC3( dest ), 0, other );
;510:	if ( g_globalvars.trace_fraction == 1 || g_globalvars.trace_ent != EDICT_TO_PROG( self ) )
;511:		return;
;512:	other->tfstate = other->tfstate | TFSTATE_CANT_MOVE;
;513:	G_sprint( other, 2, "Disarming detpack...\n" );
;514:	TeamFortress_SetSpeed( other );
;515:	
;516:	// Spawn disarming entity
;517:	disarm = spawn(  );
;518:	disarm->s.v.owner = EDICT_TO_PROG( other );// the scout
;519:	disarm->s.v.enemy = EDICT_TO_PROG( self ); // the detpack
;520:	disarm->s.v.classname = "timer";
;521:	disarm->s.v.nextthink = g_globalvars.time + WEAP_DETPACK_DISARMTIME;
;522:	disarm->s.v.think = ( func_t ) TeamFortress_DetpackDisarm;
;523:	self->weaponmode = 1;                          // indicates disarming
;524:	self->s.v.enemy = EDICT_TO_PROG( other );      // points to scout
;525:	self->observer_list = disarm;
;526:	*/
;527:}
LABELV $209
endproc TeamFortress_DetpackTouch 8 20
export TeamFortress_DetpackDisarm
proc TeamFortress_DetpackDisarm 16 16
line 534
;528:
;529://=========================================================================
;530:// The detpack disarm function. Scout has finished disarming it
;531:// .enemy is the detpack
;532:// .owner is the scout
;533:void TeamFortress_DetpackDisarm(  )
;534:{
line 535
;535:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 536
;536:	gedict_t *enemy = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 538
;537:
;538:	if ( owner->s.v.deadflag )
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 0
EQF4 $214
line 539
;539:	{
line 540
;540:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 541
;541:		return;
ADDRGP4 $213
JUMPV
LABELV $214
line 543
;542:	}
;543:	if ( tf_data.birthday == 1 )
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $216
line 544
;544:	{
line 545
;545:		G_bprint( 1, "%s stole %s's birthday present!\n", owner->s.v.netname, enemy->real_owner->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $219
ARGP4
ADDRLP4 8
CNSTI4 396
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 546
;546:	} else
ADDRGP4 $217
JUMPV
LABELV $216
line 547
;547:	{
line 548
;548:		G_bprint( 1, "%s's detpack was defused by %s\n", enemy->real_owner->s.v.netname, owner->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 8
CNSTI4 396
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 549
;549:	}
LABELV $217
line 550
;550:	owner->tfstate = owner->tfstate - ( owner->tfstate & TFSTATE_CANT_MOVE );
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 65536
BANDI4
SUBI4
ASGNI4
line 551
;551:	TF_AddFrags( owner, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 553
;552:	// Reset speeds of scout
;553:	TeamFortress_SetSpeed( owner );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 555
;554:
;555:	dremove( enemy->oldenemy ); // remove count down                
ADDRLP4 4
INDIRP4
CNSTI4 980
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 556
;556:	dremove( enemy );           // remove detpack                   
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 557
;557:	dremove( self );            // remove this timer
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 558
;558:}
LABELV $213
endproc TeamFortress_DetpackDisarm 16 16
export TeamFortress_DetpackCountDown
proc TeamFortress_DetpackCountDown 20 20
line 564
;559:
;560://=========================================================================
;561:// The Detpack CountDown function. Displays the seconds left before the
;562:// detpack detonates to the owner of the detpack, if <10
;563:void TeamFortress_DetpackCountDown(  )
;564:{
line 565
;565:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 566
;566:	gedict_t *enemy = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 568
;567:
;568:	if ( tg_data.detpack_drop )
ADDRGP4 tg_data+24
INDIRI4
CNSTI4 0
EQI4 $222
line 569
;569:		CheckBelowBuilding( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 CheckBelowBuilding
CALLV
pop
LABELV $222
line 571
;570:
;571:	self->s.v.nextthink = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 572
;572:	self->s.v.health = self->s.v.health - 1;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 573
;573:	if ( self->s.v.health < 10 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1092616192
GEF4 $226
line 574
;574:	{
line 575
;575:		G_sprint( owner, 2, "%.0f...\n", self->s.v.health+1 );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $228
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 576
;576:		if ( self->s.v.health < 5 && !self->has_disconnected )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1084227584
GEF4 $229
ADDRLP4 12
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
NEI4 $229
line 577
;577:		{
line 578
;578:			sound( enemy, 2, "doors/baseuse.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $231
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
line 579
;579:			self->has_disconnected = 1;
ADDRGP4 self
INDIRP4
CNSTI4 888
ADDP4
CNSTI4 1
ASGNI4
line 580
;580:		}
LABELV $229
line 582
;581:		// Flash the red light
;582:		if ( self->s.v.health < 5 && !enemy->s.v.skin )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1084227584
GEF4 $232
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 0
NEF4 $232
line 583
;583:			enemy->s.v.skin = 1;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRGP4 $233
JUMPV
LABELV $232
line 585
;584:		else
;585:			enemy->s.v.skin = 0;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 0
ASGNF4
LABELV $233
line 586
;586:		if ( !self->s.v.health )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
NEF4 $234
line 587
;587:			dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
LABELV $234
line 588
;588:	}
LABELV $226
line 589
;589:}
LABELV $221
endproc TeamFortress_DetpackCountDown 20 20
import GrenadeExplode
import GrenadeTouch
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
import TeamFortress_Scan_Angel
import TeamFortress_Scan
import RemoveOldFlare
import RemoveFlare
import UseSpecialSkill
import DropKey
import SniperSight_Create
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
LABELV $231
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
LABELV $228
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $220
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $219
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 111
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 105
byte 1 114
byte 1 116
byte 1 104
byte 1 100
byte 1 97
byte 1 121
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $212
byte 1 122
byte 1 111
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 47
byte 1 122
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $206
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 105
byte 1 122
byte 1 122
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $174
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 116
byte 1 102
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $164
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $160
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
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
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $159
byte 1 70
byte 1 73
byte 1 82
byte 1 69
byte 1 32
byte 1 73
byte 1 78
byte 1 32
byte 1 84
byte 1 72
byte 1 69
byte 1 32
byte 1 72
byte 1 79
byte 1 76
byte 1 69
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $157
byte 1 68
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $151
byte 1 99
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $150
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
LABELV $145
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
LABELV $142
byte 1 68
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 118
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $131
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $130
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $128
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $127
byte 1 83
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $125
byte 1 0
align 1
LABELV $124
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 108
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 53
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $121
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 32
byte 1 111
byte 1 110
byte 1 108
byte 1 121
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 49
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $112
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 97
byte 1 105
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $95
byte 1 68
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $94
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
LABELV $90
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $89
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
byte 1 101
byte 1 110
byte 1 99
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $86
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $84
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
LABELV $83
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
LABELV $80
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 115
byte 1 111
byte 1 109
byte 1 101
byte 1 111
byte 1 110
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $79
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $62
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $50
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $44
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
LABELV $43
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
LABELV $35
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $21
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
LABELV $16
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 0
