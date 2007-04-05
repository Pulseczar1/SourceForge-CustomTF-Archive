data
align 4
LABELV maxspeed
byte 4 0
export default_link
align 4
LABELV default_link
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
skip 28
export max_yaw_per_sek
align 4
LABELV max_yaw_per_sek
byte 4 1132068864
export AtLocation
code
proc AtLocation 20 4
file "..\src\bot\move.c"
line 50
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
;21: *  $Id: move.c,v 1.12 2005/06/10 00:43:39 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:void SelectWP();
;26:#define DEFAULT_MAX_YAW_PER_SEK 250
;27://#define SPEED_REPORT
;28://#define MAX_YAW_PER_SEK 1800
;29://#define MAX_STRAFE_ANGLE 30 //MAX abs(dir-vel)
;30://#define STRAFE_ANGLE_DELTA 5.0
;31://#define MAX_STRAFE_ANGLE_AT_START 60
;32://#define SPEED_COEFFICIENT 1.4
;33:#define CHANGE_WP_DISTANCE 50
;34:
;35:#ifdef  SPEED_REPORT
;36:static float last_report = 0;
;37:#endif
;38:static float maxspeed = 0;
;39:
;40:const wp_link_t default_link = { NULL, NULL, 0, 0, 0};
;41:float max_yaw_per_sek = DEFAULT_MAX_YAW_PER_SEK;
;42:float bot_frametime;
;43:static float max_yaw_pf;
;44:static vec3_t dir2move, curr_vel, cur_angle;
;45:static float vel_yaw, dir_yaw, view_yaw; 
;46:static float velocity,sv_accelerate;
;47:
;48:
;49:qboolean AtLocation( vec3_t vDestination )
;50:{
line 53
;51:	vec3_t  spot1;
;52:
;53:	VectorSubtract( vDestination, self->s.v.origin, spot1 );
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
SUBF4
ASGNF4
line 55
;54:
;55:	return vlen( spot1 ) < 45;
ADDRLP4 0
ARGP4
ADDRLP4 16
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 16
INDIRF4
CNSTF4 1110704128
GEF4 $15
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $16
JUMPV
LABELV $15
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $16
ADDRLP4 12
INDIRI4
RETI4
LABELV $11
endproc AtLocation 20 4
export ClearAllWaypoints
proc ClearAllWaypoints 8 4
line 59
;56:}
;57:
;58:void ClearAllWaypoints()
;59:{
line 61
;60:
;61:        FreePath( self->wp_path );
ADDRGP4 self
INDIRP4
CNSTI4 1760
ADDP4
INDIRP4
ARGP4
ADDRGP4 FreePath
CALLV
pop
line 63
;62:
;63:        if( self->end_wp && (self->end_wp->flags & WP_FL_TEMP ) )
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $18
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $18
line 64
;64:                free( self->end_wp );
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
ARGP4
ADDRGP4 free
CALLV
pop
LABELV $18
line 66
;65:
;66:        if( self->wp && (self->wp->flags & WP_FL_TEMP ) )
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $20
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $20
line 67
;67:                free( (void*)self->wp );
ADDRGP4 self
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
ARGP4
ADDRGP4 free
CALLV
pop
LABELV $20
line 69
;68:                
;69:        self->end_wp = NULL;
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
CNSTP4 0
ASGNP4
line 70
;70:        self->wp = NULL;
ADDRGP4 self
INDIRP4
CNSTI4 1748
ADDP4
CNSTP4 0
ASGNP4
line 71
;71:        self->wp_link = NULL;
ADDRGP4 self
INDIRP4
CNSTI4 1756
ADDP4
CNSTP4 0
ASGNP4
line 72
;72:        self->wp_path = NULL;
ADDRGP4 self
INDIRP4
CNSTI4 1760
ADDP4
CNSTP4 0
ASGNP4
line 73
;73:	self->checkMovementTime = g_globalvars.time + 0.7;
ADDRGP4 self
INDIRP4
CNSTI4 1732
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1060320051
ADDF4
ASGNF4
line 74
;74:}
LABELV $17
endproc ClearAllWaypoints 8 4
export subangle
proc subangle 16 4
line 97
;75:
;76:/*float angcomp( float y1, float y2 )
;77:{
;78:	float   answer;
;79:
;80:	while ( y1 > 180 )
;81:		y1 = y1 - 360;
;82:	while ( y1 < -180 )
;83:		y1 = y1 + 360;
;84:	while ( y2 > 180 )
;85:		y2 = y2 - 360;
;86:	while ( y2 < -180 )
;87:		y2 = y2 + 360;
;88:	answer = y1 - y2;
;89:	if ( fabs( answer ) >= 180 )
;90:		answer = 360 - fabs( answer );
;91:	return answer;
;92:}*/
;93:
;94:
;95:
;96:float   subangle( float y1, float y2 )
;97:{
line 100
;98:        float o;
;99:        
;100:        o = anglemod(y1) - anglemod(y2);
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 106
;101:
;102:/*	if( o > 180)
;103:	        o -=360;
;104:	if( o < -180)
;105:	        o +=360;*/
;106:	o = anglemod( o );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 107
;107:	if( o > 180 )
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $24
line 108
;108:	        o -= 360;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $24
line 109
;109:	return o;
ADDRLP4 0
INDIRF4
RETF4
LABELV $23
endproc subangle 16 4
export InitCalcMovement
proc InitCalcMovement 32 8
line 114
;110:
;111:}
;112:
;113:void InitCalcMovement()
;114:{
line 117
;115:        vec3_t vtmp;
;116:
;117:        max_yaw_pf = max_yaw_per_sek * bot_frametime;
ADDRGP4 max_yaw_pf
ADDRGP4 max_yaw_per_sek
INDIRF4
ADDRGP4 bot_frametime
INDIRF4
MULF4
ASGNF4
line 119
;118:
;119:	VectorCopy( self->s.v.velocity, curr_vel );
ADDRGP4 curr_vel
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ASGNF4
ADDRGP4 curr_vel+4
ADDRGP4 self
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ASGNF4
ADDRGP4 curr_vel+8
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ASGNF4
line 120
;120:	vectoangles( curr_vel, vtmp );
ADDRGP4 curr_vel
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 121
;121:	vel_yaw = vtmp[1];
ADDRGP4 vel_yaw
ADDRLP4 0+4
INDIRF4
ASGNF4
line 122
;122:	curr_vel[2] = 0;
ADDRGP4 curr_vel+8
CNSTF4 0
ASGNF4
line 123
;123:	velocity = vlen( self->s.v.velocity );
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRGP4 velocity
ADDRLP4 12
INDIRF4
ASGNF4
line 124
;124:	velocity = vlen( curr_vel );
ADDRGP4 curr_vel
ARGP4
ADDRLP4 16
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRGP4 velocity
ADDRLP4 16
INDIRF4
ASGNF4
line 126
;125:
;126:	VectorSubtract( self->wp->origin, self->s.v.origin, dir2move );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 dir2move
ADDRLP4 20
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 dir2move+4
ADDRLP4 24
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 dir2move+8
ADDRLP4 28
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
SUBF4
ASGNF4
line 128
;127:
;128:	dir2move[2] = 0;
ADDRGP4 dir2move+8
CNSTF4 0
ASGNF4
line 129
;129:	vectoangles( dir2move, vtmp );
ADDRGP4 dir2move
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 131
;130:
;131:	dir_yaw = vtmp[1];
ADDRGP4 dir_yaw
ADDRLP4 0+4
INDIRF4
ASGNF4
line 133
;132:
;133:	VectorCopy( self->s.v.v_angle, cur_angle);
ADDRGP4 cur_angle
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
INDIRF4
ASGNF4
ADDRGP4 cur_angle+4
ADDRGP4 self
INDIRP4
CNSTI4 388
ADDP4
INDIRF4
ASGNF4
ADDRGP4 cur_angle+8
ADDRGP4 self
INDIRP4
CNSTI4 392
ADDP4
INDIRF4
ASGNF4
line 135
;134:
;135:	cur_angle[2] = 0;
ADDRGP4 cur_angle+8
CNSTF4 0
ASGNF4
line 137
;136:
;137:	view_yaw = cur_angle[1];
ADDRGP4 view_yaw
ADDRGP4 cur_angle+4
INDIRF4
ASGNF4
line 139
;138:
;139:	sv_accelerate = trap_cvar("sv_accelerate");
ADDRGP4 $39
ARGP4
ADDRLP4 20
ADDRGP4 trap_cvar
CALLF4
ASGNF4
ADDRGP4 sv_accelerate
ADDRLP4 20
INDIRF4
ASGNF4
line 140
;140:}
LABELV $26
endproc InitCalcMovement 32 8
data
export counter
align 4
LABELV counter
byte 4 0
export ChangeBotYaw
code
proc ChangeBotYaw 20 8
line 144
;141:int counter = 0;
;142:
;143:void ChangeBotYaw( float wish_yaw, float max_delta_yaw )
;144:{
line 145
;145:        float ftmp= subangle( wish_yaw, view_yaw);
ADDRFP4 0
INDIRF4
ARGF4
ADDRGP4 view_yaw
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 subangle
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 146
;146:        if( fabs(ftmp) < max_yaw_pf )
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 8
INDIRF4
ADDRGP4 max_yaw_pf
INDIRF4
GEF4 $41
line 147
;147:                self->s.v.v_angle[1] = wish_yaw;
ADDRGP4 self
INDIRP4
CNSTI4 388
ADDP4
ADDRFP4 0
INDIRF4
ASGNF4
ADDRGP4 $42
JUMPV
LABELV $41
line 149
;148:        else
;149:        {
line 150
;150:                if( ftmp < 0 )
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $43
line 151
;151:                        self->s.v.v_angle[1] -= max_delta_yaw;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 388
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $44
JUMPV
LABELV $43
line 153
;152:                else
;153:                        self->s.v.v_angle[1] += max_delta_yaw;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 388
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
ADDF4
ASGNF4
LABELV $44
line 154
;154:        }
LABELV $42
line 155
;155:}
LABELV $40
endproc ChangeBotYaw 20 8
export WPChange
proc WPChange 40 56
line 158
;156:
;157:int WPChange()
;158:{
line 160
;159:        int dist;
;160:	if( self->s.v.fixangle )
ADDRGP4 self
INDIRP4
CNSTI4 380
ADDP4
INDIRF4
CNSTF4 0
EQF4 $46
line 161
;161:	{
line 162
;162:	        self->botNoMoveTime = g_globalvars.time + BOT_TIMEWAIT_AFTER_TELEPORT;
ADDRGP4 self
INDIRP4
CNSTI4 1740
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 163
;163:	        ClearAllWaypoints(  );
ADDRGP4 ClearAllWaypoints
CALLV
pop
line 164
;164:	        SelectWP();
ADDRGP4 SelectWP
CALLV
pop
line 165
;165:	        if(!self->wp)
ADDRGP4 self
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $49
line 166
;166:       	              return 0;
CNSTI4 0
RETI4
ADDRGP4 $45
JUMPV
LABELV $49
line 167
;167:	}
LABELV $46
line 170
;168:
;169:        //TraceCapsule( PASSVEC3( self->s.v.origin ), PASSVEC3( self->wp->origin ), 1, self,PASSVEC3( self->s.v.mins)+TRACECAP_ADD, PASSVEC3( self->s.v.maxs)-TRACECAP_ADD );
;170:        traceline( PASSVEC3( self->s.v.origin ), PASSVEC3( self->wp->origin ), 1, self);
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
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 1748
ADDP4
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
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 172
;171:
;172:        if( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $51
line 173
;173:        {
line 174
;174:                ClearAllWaypoints(  );
ADDRGP4 ClearAllWaypoints
CALLV
pop
line 175
;175:                SelectWP();
ADDRGP4 SelectWP
CALLV
pop
line 176
;176:	        if(!self->wp)
ADDRGP4 self
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $54
line 177
;177:       	              return 0;
CNSTI4 0
RETI4
ADDRGP4 $45
JUMPV
LABELV $54
line 178
;178:        }
LABELV $51
line 180
;179:
;180:        InitCalcMovement();
ADDRGP4 InitCalcMovement
CALLV
pop
line 202
;181:/*        if( self->wp_path ) // попробовать срезать путь( для случаев когда ближайший вп сзади )
;182:        {
;183:                int flags = self->wp_path->link->flags;
;184:                if( !flags || ( flags & WPLINK_FL_WALK) )
;185:                if( abs( subangle(dir_yaw, self->wp_path->link->dirangles[1] ) ) >= 160 )
;186:                {
;187:                      TraceCapsule( PASSVEC3( self->s.v.origin ), PASSVEC3( self->wp_path->link->dest_wp->origin ), 1, self,
;188:                               PASSVEC3( self->s.v.mins)+TRACECAP_ADD, PASSVEC3( self->s.v.maxs)-TRACECAP_ADD );
;189:                      if( g_globalvars.trace_fraction == 1 )  
;190:                      {
;191:                               wp_path_t *path = self->wp_path;
;192:           	               self->wp = path->link->dest_wp;
;193:            	               self->wp_link = path->link;
;194:                    	       self->wp_path = path->next;
;195:                    	       free(path);
;196:                    	       InitCalcMovement();
;197:                               self->time_for_wpchange = g_globalvars.time + bot_frametime * 10;
;198:	                       return 2;
;199:                      }
;200:                }
;201:        }*/
;202:        dist = vlen( dir2move );
ADDRGP4 dir2move
ARGP4
ADDRLP4 12
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 204
;203:                
;204:	if ( velocity && (( dist / velocity) < 0.1) )
ADDRLP4 16
ADDRGP4 velocity
INDIRF4
ASGNF4
ADDRLP4 16
INDIRF4
CNSTF4 0
EQF4 $56
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
DIVF4
CNSTF4 1036831949
GEF4 $56
line 205
;205:	{
line 206
;206:	        wp_path_t *path = self->wp_path;
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 1760
ADDP4
INDIRP4
ASGNP4
line 207
;207:	        if( !path )
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $58
line 208
;208:	        {
line 209
;209:	                if( self->end_wp )
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $60
line 210
;210:	                {
line 211
;211:	                       if( dist >  self->wp->radius ) 
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
LEF4 $62
line 212
;212:	                       {
line 213
;213: 	                         TraceCapsule( PASSVEC3( self->s.v.origin ), PASSVEC3( self->end_wp->origin ), 1, self,
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
ADDRLP4 24
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
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
ADDRLP4 32
CNSTF4 1097859072
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
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
ADDRLP4 32
INDIRF4
SUBF4
ARGF4
ADDRGP4 TraceCapsule
CALLV
pop
line 215
;214:	                               PASSVEC3( self->s.v.mins)+TRACECAP_ADD, PASSVEC3( self->s.v.maxs)-TRACECAP_ADD );
;215:                                 if( g_globalvars.trace_fraction != 1 )  
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $64
line 216
;216:                                      return 1;
CNSTI4 1
RETI4
ADDRGP4 $45
JUMPV
LABELV $64
line 217
;217:	                       }
LABELV $62
line 218
;218:                               self->wp_link = &default_link;
ADDRGP4 self
INDIRP4
CNSTI4 1756
ADDP4
ADDRGP4 default_link
ASGNP4
line 219
;219:                               self->wp = self->end_wp;
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 1748
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
ASGNP4
line 220
;220:                               self->end_wp = NULL;
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
CNSTP4 0
ASGNP4
line 221
;221:	                }else
ADDRGP4 $59
JUMPV
LABELV $60
line 222
;222:	                {
line 223
;223:         	                if( dist < self->wp->radius )
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
GEF4 $59
line 224
;224:         	                {
line 225
;225:         	                   ClearAllWaypoints();
ADDRGP4 ClearAllWaypoints
CALLV
pop
line 226
;226:         			   self->keys = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
CNSTI4 0
ASGNI4
line 227
;227:         			   return 0;
CNSTI4 0
RETI4
ADDRGP4 $45
JUMPV
line 229
;228:         	                }
;229:	                }
line 230
;230:	        }else
LABELV $58
line 231
;231:	        {
line 232
;232:	                if( dist >  self->wp->radius )
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
LEF4 $69
line 233
;233:	                {
line 235
;234:	                       //traceline( PASSVEC3( self->s.v.origin ), PASSVEC3( path->link->dest_wp->origin ), 0, self );
;235: 	                       TraceCapsule( PASSVEC3( self->s.v.origin ), PASSVEC3( path->link->dest_wp->origin ), 1, self,
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
CNSTI4 4
ASGNI4
ADDRLP4 32
ADDRLP4 20
INDIRP4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
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
ADDRLP4 36
CNSTF4 1097859072
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
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
ADDRLP4 36
INDIRF4
SUBF4
ARGF4
ADDRGP4 TraceCapsule
CALLV
pop
line 237
;236:	                               PASSVEC3( self->s.v.mins)+TRACECAP_ADD, PASSVEC3( self->s.v.maxs)-TRACECAP_ADD );
;237:                                if( g_globalvars.trace_fraction != 1 )  return 1;
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $71
CNSTI4 1
RETI4
ADDRGP4 $45
JUMPV
LABELV $71
line 238
;238:	                }
LABELV $69
line 240
;239:
;240:       	                self->wp = path->link->dest_wp;
ADDRGP4 self
INDIRP4
CNSTI4 1748
ADDP4
ADDRLP4 20
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 241
;241:       	                self->wp_link = path->link;
ADDRGP4 self
INDIRP4
CNSTI4 1756
ADDP4
ADDRLP4 20
INDIRP4
INDIRP4
ASGNP4
line 242
;242:              	        self->wp_path = path->next;
ADDRGP4 self
INDIRP4
CNSTI4 1760
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 243
;243:              	        free(path);
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 free
CALLV
pop
line 244
;244:	        }
LABELV $59
line 245
;245:	        InitCalcMovement();
ADDRGP4 InitCalcMovement
CALLV
pop
line 246
;246:	        self->time_for_wpchange = g_globalvars.time + bot_frametime * 10;
ADDRGP4 self
INDIRP4
CNSTI4 1744
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDRGP4 bot_frametime
INDIRF4
MULF4
ADDF4
ASGNF4
line 247
;247:	        return 2;
CNSTI4 2
RETI4
ADDRGP4 $45
JUMPV
LABELV $56
line 249
;248:	}
;249:	return 1;
CNSTI4 1
RETI4
LABELV $45
endproc WPChange 40 56
export DoMovement
proc DoMovement 68 56
line 253
;250:}
;251:
;252:void DoMovement()
;253:{
line 258
;254:        float ftmp;
;255:        float max_strafe_angle;
;256:        vec3_t v;
;257:
;258:        self->keys = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
CNSTI4 0
ASGNI4
line 259
;259:        if( self->checkMovementTime > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 1732
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $76
line 260
;260:                return;
ADDRGP4 $75
JUMPV
LABELV $76
line 261
;261:	if ( !self->wp )
ADDRGP4 self
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $79
line 262
;262:	{
line 263
;263:		self->keys = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
CNSTI4 0
ASGNI4
line 264
;264:		return;
ADDRGP4 $75
JUMPV
LABELV $79
line 266
;265:	}
;266:	if( self->s.v.health <=0  || self->s.v.deadflag )
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 20
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
LEF4 $83
ADDRLP4 20
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
EQF4 $81
LABELV $83
line 267
;267:	{
line 268
;268:	        maxspeed = 0;
ADDRGP4 maxspeed
CNSTF4 0
ASGNF4
line 269
;269:		self->keys = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
CNSTI4 0
ASGNI4
line 270
;270:	        return;
ADDRGP4 $75
JUMPV
LABELV $81
line 273
;271:	}
;272:
;273:	if( g_globalvars.time < self->botNoMoveTime )
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 1740
ADDP4
INDIRF4
GEF4 $84
line 274
;274:	{
line 275
;275:	        return;
ADDRGP4 $75
JUMPV
LABELV $84
line 278
;276:	}
;277:
;278:	if(! WPChange())
ADDRLP4 28
ADDRGP4 WPChange
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $87
line 279
;279:	        return;
ADDRGP4 $75
JUMPV
LABELV $87
line 281
;280:
;281:	if ( ( int ) ( self->s.v.flags ) & ( FL_INWATER ) )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $89
line 282
;282:	{
line 283
;283:	        self->keys |= KEY_MOVEFORWARD;
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 284
;284:	        self->s.v.button2 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
CNSTF4 0
ASGNF4
line 285
;285:	        self->s.v.v_angle[1] = dir_yaw;
ADDRGP4 self
INDIRP4
CNSTI4 388
ADDP4
ADDRGP4 dir_yaw
INDIRF4
ASGNF4
line 286
;286:	        return;
ADDRGP4 $75
JUMPV
LABELV $89
line 288
;287:	}
;288:        if ( ( int ) ( self->s.v.flags ) & ( FL_ONGROUND |FL_PARTIALGROUND ) )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1536
BANDI4
CNSTI4 0
EQI4 $91
line 289
;289:	{
line 290
;290:	        if( velocity < self->maxfbspeed * 0.95 || (self->wp_link && (self->wp_link->flags & WPLINK_FL_WALK)) )
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 velocity
INDIRF4
CNSTF4 1064514355
ADDRLP4 32
INDIRP4
CNSTI4 932
ADDP4
INDIRI4
CVIF4 4
MULF4
LTF4 $95
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 1756
ADDP4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $93
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $93
LABELV $95
line 291
;291:	        {
line 293
;292:	                
;293:	                if( fabs(dir_yaw - vel_yaw) > 5 )
ADDRGP4 dir_yaw
INDIRF4
ADDRGP4 vel_yaw
INDIRF4
SUBF4
ARGF4
ADDRLP4 40
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1084227584
LEF4 $96
line 294
;294:	                {
line 295
;295:	                       self->s.v.v_angle[1] = dir_yaw;
ADDRGP4 self
INDIRP4
CNSTI4 388
ADDP4
ADDRGP4 dir_yaw
INDIRF4
ASGNF4
line 296
;296:	                }
LABELV $96
line 297
;297:         	        self->keys |= KEY_MOVEFORWARD;
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 298
;298:         	        self->s.v.button2 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
CNSTF4 0
ASGNF4
line 299
;299:	        }else
ADDRGP4 $75
JUMPV
LABELV $93
line 300
;300:	        {
line 301
;301:	                if( !self->old_button2 )
ADDRGP4 self
INDIRP4
CNSTI4 1644
ADDP4
INDIRI4
CNSTI4 0
NEI4 $98
line 302
;302:                	        self->s.v.button2 = 1;
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRGP4 $99
JUMPV
LABELV $98
line 304
;303:	                else
;304:                	        self->s.v.button2 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
CNSTF4 0
ASGNF4
LABELV $99
line 306
;305:	                        
;306:	                if( self->bot_strafe_state == BOT_STRAFE_LEFT)
ADDRGP4 self
INDIRP4
CNSTI4 1680
ADDP4
INDIRI4
CNSTI4 1
NEI4 $100
line 307
;307:	                {
line 308
;308:	                        self->keys |= KEY_MOVELEFT;
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 309
;309:	                }else
ADDRGP4 $75
JUMPV
LABELV $100
line 310
;310:	                {
line 311
;311:	                        self->keys |= KEY_MOVERIGHT;
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 312
;312:	                }
line 313
;313:	        }
line 314
;314:                return;
ADDRGP4 $75
JUMPV
LABELV $91
line 318
;315:	}
;316:
;317:	//Air Move
;318:	self->s.v.button2 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
CNSTF4 0
ASGNF4
line 321
;319:
;320:
;321:	ftmp = atan2( 30, velocity) * 180 / M_PI; // angle per frame
CNSTF4 1106247680
ARGF4
ADDRGP4 velocity
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 12
CNSTF4 1127481344
ADDRLP4 32
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
ASGNF4
line 323
;322:
;323:	if( ftmp > max_yaw_pf )
ADDRLP4 12
INDIRF4
ADDRGP4 max_yaw_pf
INDIRF4
LEF4 $102
line 324
;324:	        ftmp = max_yaw_pf;
ADDRLP4 12
ADDRGP4 max_yaw_pf
INDIRF4
ASGNF4
LABELV $102
line 326
;325:
;326:	max_strafe_angle = (ftmp / 5 ) / bot_frametime;
ADDRLP4 16
ADDRLP4 12
INDIRF4
CNSTF4 1084227584
DIVF4
ADDRGP4 bot_frametime
INDIRF4
DIVF4
ASGNF4
line 327
;327:	if(  max_strafe_angle > 60 )
ADDRLP4 16
INDIRF4
CNSTF4 1114636288
LEF4 $104
line 328
;328:	        max_strafe_angle = 60;
ADDRLP4 16
CNSTF4 1114636288
ASGNF4
LABELV $104
line 348
;329:
;330:#ifdef SPEED_REPORT
;331:	if( vlen(curr_vel) - maxspeed > 30 ) 
;332:	{
;333:	       G_bprint(3,"maxspeed = %3.0f %3.0f\n", 
;334:	       vlen(curr_vel), (vlen(curr_vel) - maxspeed)/ (g_globalvars.time -last_report ));
;335:	       maxspeed = vlen(curr_vel);
;336:	       last_report = g_globalvars.time;
;337:	}
;338:#endif
;339:
;340:/*	if( (int)velocity < 300 )
;341:	        max_strafe_angle = 80;
;342:	else
;343:	        if( (int)velocity < 400 )
;344:	                max_strafe_angle = 60;
;345:	        else
;346:      	                max_strafe_angle = 30;*/
;347:
;348:	VectorScale(self->s.v.velocity, bot_frametime * 3, v);
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
CNSTF4 1077936128
ADDRGP4 bot_frametime
INDIRF4
MULF4
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 349
;349:	VectorAdd(self->s.v.origin, v,v);
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
line 350
;350:        TraceCapsule( PASSVEC3( self->s.v.origin ), PASSVEC3( v ), 1, self,
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
CNSTF4 1097859072
ASGNF4
ADDRLP4 36
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
ADDF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
SUBF4
ARGF4
ADDRGP4 TraceCapsule
CALLV
pop
line 353
;351:                           PASSVEC3( self->s.v.mins)+TRACECAP_ADD, PASSVEC3( self->s.v.maxs)-TRACECAP_ADD );
;352:
;353:      	ftmp =  subangle( dir_yaw,vel_yaw );
ADDRGP4 dir_yaw
INDIRF4
ARGF4
ADDRGP4 vel_yaw
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 subangle
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 44
INDIRF4
ASGNF4
line 354
;354:	if( abs( ftmp) >  max_strafe_angle  || g_globalvars.trace_fraction != 1  || self->time_for_wpchange > g_globalvars.time )
ADDRLP4 12
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 48
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
GTF4 $117
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $117
ADDRGP4 self
INDIRP4
CNSTI4 1744
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $112
LABELV $117
line 355
;355:	{
line 356
;356:	        if( abs( ftmp ) < 1 )
ADDRLP4 12
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 52
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 1
GEI4 $118
line 357
;357:	                self->time_for_wpchange = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1744
ADDP4
CNSTF4 0
ASGNF4
LABELV $118
line 359
;358:	                
;359:	        if( ftmp < 0 )
ADDRLP4 12
INDIRF4
CNSTF4 0
GEF4 $120
line 360
;360:	        {
line 361
;361:	                self->bot_strafe_state = BOT_STRAFE_RIGHT;
ADDRGP4 self
INDIRP4
CNSTI4 1680
ADDP4
CNSTI4 2
ASGNI4
line 362
;362:	                self->keys |= KEY_MOVERIGHT;
ADDRLP4 56
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 364
;363:	                
;364:	        }else
ADDRGP4 $121
JUMPV
LABELV $120
line 365
;365:	        {
line 366
;366:	                self->keys |= KEY_MOVELEFT;
ADDRLP4 56
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 367
;367:	                self->bot_strafe_state = BOT_STRAFE_LEFT;
ADDRGP4 self
INDIRP4
CNSTI4 1680
ADDP4
CNSTI4 1
ASGNI4
line 368
;368:	        }
LABELV $121
line 369
;369:	        self->s.v.v_angle[1] = vel_yaw;
ADDRGP4 self
INDIRP4
CNSTI4 388
ADDP4
ADDRGP4 vel_yaw
INDIRF4
ASGNF4
line 370
;370:                return;
ADDRGP4 $75
JUMPV
LABELV $112
line 372
;371:	}
;372:        TraceCapsule( PASSVEC3( self->wp->origin ), PASSVEC3( v ), 1, self,
ADDRLP4 52
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 52
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 1097859072
ASGNF4
ADDRLP4 52
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ADDRLP4 60
INDIRF4
ADDF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ADDRLP4 60
INDIRF4
SUBF4
ARGF4
ADDRGP4 TraceCapsule
CALLV
pop
line 375
;373:                           PASSVEC3( self->s.v.mins)+TRACECAP_ADD, PASSVEC3( self->s.v.maxs)-TRACECAP_ADD );
;374:
;375:        if( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $124
line 376
;376:        {
line 377
;377:	        if( ftmp < 0 )
ADDRLP4 12
INDIRF4
CNSTF4 0
GEF4 $127
line 378
;378:	        {
line 379
;379:	                self->bot_strafe_state = BOT_STRAFE_RIGHT;
ADDRGP4 self
INDIRP4
CNSTI4 1680
ADDP4
CNSTI4 2
ASGNI4
line 380
;380:	        }else
ADDRGP4 $128
JUMPV
LABELV $127
line 381
;381:	        {
line 382
;382:	                self->bot_strafe_state = BOT_STRAFE_LEFT;
ADDRGP4 self
INDIRP4
CNSTI4 1680
ADDP4
CNSTI4 1
ASGNI4
line 383
;383:	        }
LABELV $128
line 384
;384:        }
LABELV $124
line 397
;385:/*        if ( velocity && (( vlen( dir2move ) / velocity) < 0.5) && self->wp_path ) 
;386:        {
;387:                ftmp = subangle( vel_yaw, self->wp_path->link->dirangles[1] );
;388:	        if( ftmp > 0 )
;389:	        {
;390:	                self->bot_strafe_state = BOT_STRAFE_RIGHT;
;391:	        }else
;392:	        {
;393:	                self->bot_strafe_state = BOT_STRAFE_LEFT;
;394:	        }
;395:        }*/
;396:
;397:        if(self->bot_strafe_state == BOT_STRAFE_RIGHT)
ADDRGP4 self
INDIRP4
CNSTI4 1680
ADDP4
INDIRI4
CNSTI4 2
NEI4 $129
line 398
;398:        {
line 399
;399:                self->keys |= KEY_MOVERIGHT;
ADDRLP4 64
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 401
;400:                
;401:        }else
ADDRGP4 $130
JUMPV
LABELV $129
line 402
;402:        {
line 403
;403:                self->keys |= KEY_MOVELEFT;
ADDRLP4 64
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 404
;404:        }
LABELV $130
line 405
;405:        ChangeBotYaw(vel_yaw,max_yaw_pf);
ADDRGP4 vel_yaw
INDIRF4
ARGF4
ADDRGP4 max_yaw_pf
INDIRF4
ARGF4
ADDRGP4 ChangeBotYaw
CALLV
pop
line 406
;406:}
LABELV $75
endproc DoMovement 68 56
bss
align 4
LABELV sv_accelerate
skip 4
align 4
LABELV velocity
skip 4
align 4
LABELV view_yaw
skip 4
align 4
LABELV dir_yaw
skip 4
align 4
LABELV vel_yaw
skip 4
align 4
LABELV cur_angle
skip 12
align 4
LABELV curr_vel
skip 12
align 4
LABELV dir2move
skip 12
align 4
LABELV max_yaw_pf
skip 4
import SelectWP
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
export bot_frametime
align 4
LABELV bot_frametime
skip 4
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
import MoveToLocation
import GotoLocation
import GetKeysByLoc
import GetKeysByDir
import StrafeRight
import StrafeLeft
import PickAName
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
LABELV $39
byte 1 115
byte 1 118
byte 1 95
byte 1 97
byte 1 99
byte 1 99
byte 1 101
byte 1 108
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 0
