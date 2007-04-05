export ThrowGrenade
code
proc ThrowGrenade 12 12
file "..\src\bot\ai.c"
line 28
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
;21: *  $Id: ai.c,v 1.12 2005/06/15 11:48:13 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:
;26:#define BOT_COUNT 1
;27:qboolean ThrowGrenade(  )
;28:{
line 32
;29:	gedict_t *eTemp;
;30:	gedict_t *eGren;
;31:
;32:	if ( !( self->tfstate & TFSTATE_GRENPRIMED ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $12
line 33
;33:	{
line 34
;34:		return false;
CNSTI4 0
RETI4
ADDRGP4 $11
JUMPV
LABELV $12
line 37
;35:	}
;36:
;37:	eGren = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 38
;38:	for ( eTemp = world; ( eTemp = trap_find( eTemp, FOFS( s.v.classname ), "primer" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $17
JUMPV
LABELV $14
line 39
;39:	{
line 40
;40:		if ( PROG_TO_EDICT( eTemp->s.v.owner ) == self )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
ADDRGP4 self
INDIRP4
CVPU4 4
NEU4 $19
line 41
;41:			eGren = eTemp;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $19
line 42
;42:	}
LABELV $15
line 38
LABELV $17
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $18
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $14
line 43
;43:	if ( eGren )
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $21
line 44
;44:	{
line 45
;45:		if ( eGren->heat < g_globalvars.time + 0.6 )
ADDRLP4 4
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1058642330
ADDF4
GEF4 $23
line 46
;46:			self->s.v.impulse = TF_GRENADE_T;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 1125646336
ASGNF4
LABELV $23
line 47
;47:		return true;
CNSTI4 1
RETI4
ADDRGP4 $11
JUMPV
LABELV $21
line 49
;48:	}
;49:	return false;
CNSTI4 0
RETI4
LABELV $11
endproc ThrowGrenade 12 12
export Bot_AI
proc Bot_AI 20 4
line 55
;50:
;51:}
;52:
;53:void SelectWP();
;54:void Bot_AI(  )
;55:{
line 56
;56:	if ( self->s.v.health <= 0 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $27
line 57
;57:	{
line 58
;58:		if ( self->fBotMessageTime == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 1692
ADDP4
INDIRF4
CNSTF4 0
NEF4 $29
line 59
;59:		{
line 60
;60:			self->fBotMessageTime =
ADDRLP4 0
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1692
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1069547520
ADDRGP4 tf_data+184
INDIRI4
CVIF4 4
MULF4
ADDF4
CNSTF4 1050253722
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 63
;61:			    g_globalvars.time + tf_data.botResupplyBetweenKills * 1.5 +
;62:			    g_random(  ) * BOT_COUNT * 0.3;
;63:			return;
ADDRGP4 $26
JUMPV
LABELV $29
line 65
;64:		}
;65:		if ( self->fBotMessageTime < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 1692
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $33
line 66
;66:		{
line 67
;67:			ClearAllWaypoints(  );
ADDRGP4 ClearAllWaypoints
CALLV
pop
line 68
;68:			ClearAllTargets(  );
ADDRGP4 ClearAllTargets
CALLV
pop
line 69
;69:			self->obs_time = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1736
ADDP4
CNSTF4 0
ASGNF4
line 70
;70:			self->action = BOT_IDLE;
ADDRGP4 self
INDIRP4
CNSTI4 1664
ADDP4
CNSTI4 1
ASGNI4
line 71
;71:			self->s.v.button0 = floor( g_random(  ) * 2 );
ADDRLP4 0
ADDRGP4 g_random
CALLF4
ASGNF4
CNSTF4 1073741824
ADDRLP4 0
INDIRF4
MULF4
ARGF4
ADDRLP4 4
ADDRGP4 floor
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 72
;72:			self->s.v.button1 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 368
ADDP4
CNSTF4 0
ASGNF4
line 73
;73:			self->s.v.button2 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
CNSTF4 0
ASGNF4
line 74
;74:			self->keys = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
CNSTI4 0
ASGNI4
line 75
;75:			self->fBotMessageTime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1692
ADDP4
CNSTF4 0
ASGNF4
line 76
;76:			return;
ADDRGP4 $26
JUMPV
LABELV $33
line 78
;77:		}
;78:	}
LABELV $27
line 79
;79:	if ( !self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $36
line 80
;80:	{
line 81
;81:		if ( self->current_menu > MENU_DEFAULT )
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
CNSTI4 1
LEI4 $26
line 82
;82:			self->s.v.impulse = BotImpulseMenu(  );
ADDRLP4 0
ADDRGP4 BotImpulseMenu
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
ADDRLP4 0
INDIRI4
CVIF4 4
ASGNF4
line 83
;83:		return;
ADDRGP4 $26
JUMPV
LABELV $36
LABELV $40
line 86
;84:	}
;85:      retry:
;86:	switch ( self->action )
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1664
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
CNSTI4 8
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $45
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
GTI4 $49
LABELV $48
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $44
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $47
ADDRGP4 $41
JUMPV
LABELV $49
ADDRLP4 0
INDIRI4
CNSTI4 16
EQI4 $46
ADDRGP4 $41
JUMPV
line 87
;87:	{
LABELV $44
line 93
;88:	case BOT_IDLE:
;89://              if ( CheckForResupply(  ) == true && tf_data.botResupplyBetweenKills )
;90://              {
;91://                      self->action = BOT_RESUPPLYING;
;92://              } else
;93:		self->action = BOT_DEFEND;
ADDRGP4 self
INDIRP4
CNSTI4 1664
ADDP4
CNSTI4 8
ASGNI4
line 94
;94:		goto retry;
ADDRGP4 $40
JUMPV
LABELV $45
line 96
;95:	case BOT_DEFEND:
;96:                SelectWP();
ADDRGP4 SelectWP
CALLV
pop
line 97
;97:		break;
ADDRGP4 $42
JUMPV
LABELV $46
line 126
;98:/*		if ( !ThrowGrenade(  ) )
;99:			ReloadWeapons(  );
;100:		if ( self->team_no == 1 )
;101:		{
;102:			if ( self->s.v.origin[1] < -610 )
;103:			{
;104:				SetVector( self->waypoint1, 256, -550, -936 );
;105:				break;
;106:			}
;107:		} else
;108:		{
;109:			if ( self->s.v.origin[1] > 260 )
;110:			{
;111:				SetVector( self->waypoint1, 256, 200, -936 );
;112:				break;
;113:			}
;114:		}
;115:
;116:		//if ( self->FlashTime == 0 )
;117:		FindTargets(  );
;118:
;119:		if ( self->target1 )
;120:		{
;121:			self->action = BOT_FIGHTING;
;122:			goto retry;
;123:		}
;124:		break;*/
;125:	case BOT_RESUPPLYING:
;126:		self->action = BOT_IDLE;
ADDRGP4 self
INDIRP4
CNSTI4 1664
ADDP4
CNSTI4 1
ASGNI4
line 127
;127:		goto retry;
ADDRGP4 $40
JUMPV
line 163
;128:/*		if ( !ThrowGrenade(  ) )
;129:			ReloadWeapons(  );
;130:		if ( !CheckForResupply(  ) )
;131:		{
;132:			self->action = BOT_IDLE;
;133:			goto retry;
;134:		}
;135:
;136:		if ( self->team_no == 1 )
;137:		{
;138:			vtemp2[0] = self->s.v.origin[0] - 256;
;139:			vtemp2[1] = self->s.v.origin[1] + 840;
;140:			vtemp2[2] = self->s.v.origin[2] + 936;
;141:
;142:			if ( vlen( vtemp2 ) < 200 )
;143:				SetVector( self->waypoint1, 256, -840, -936 );
;144:			else
;145:			{
;146:				SetVector( self->waypoint1, 256, -550, -936 );
;147:				SetVector( self->waypoint2, 256, -840, -936 );
;148:			}
;149:		} else
;150:		{
;151:			vtemp2[0] = self->s.v.origin[0] - 256;
;152:			vtemp2[1] = self->s.v.origin[1] - 430;
;153:			vtemp2[2] = self->s.v.origin[2] + 936;
;154:
;155:			if ( vlen( vtemp2 ) < 200 )
;156:				SetVector( self->waypoint1, 256, 430, -936 );
;157:			else
;158:			{
;159:				SetVector( self->waypoint1, 256, 200, -936 );
;160:				SetVector( self->waypoint2, 256, 430, -936 );
;161:			}
;162:		}*/
;163:		break;
LABELV $47
line 166
;164:
;165:	case BOT_FIGHTING:
;166:	        self->action = BOT_IDLE;
ADDRGP4 self
INDIRP4
CNSTI4 1664
ADDP4
CNSTI4 1
ASGNI4
line 167
;167:	        goto retry;
ADDRGP4 $40
JUMPV
line 182
;168:/*		//UpdateTargets //remove lost targets
;169://              FindTargets(  );
;170://              if ( !self->target1 )
;171:		{
;172:			self->action = BOT_IDLE;
;173:			goto retry;
;174:		}
;175://              if ( self->attack_finished > g_globalvars.time )
;176://              {
;177:		//DodgeEnemy
;178://              } else
;179:		{
;180://                      AttackTargets(  );
;181:		}*/
;182:		break;
LABELV $41
LABELV $42
line 187
;183:	}
;184:
;185://      DodgeEnemyGrenades(  );
;186:
;187:	if ( self->current_menu > MENU_DEFAULT )
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
CNSTI4 1
LEI4 $50
line 188
;188:		self->s.v.impulse = BotImpulseMenu(  );
ADDRLP4 16
ADDRGP4 BotImpulseMenu
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
LABELV $50
line 190
;189:
;190:	DoMovement(  );
ADDRGP4 DoMovement
CALLV
pop
line 191
;191:}
LABELV $26
endproc Bot_AI 20 4
data
export end_pos
align 4
LABELV end_pos
byte 4 0
byte 4 0
byte 4 1103101952
export SelectWP
code
proc SelectWP 64 12
line 195
;192:
;193:vec3_t end_pos = { 0,0,24 };
;194:void SelectWP()
;195:{
line 199
;196:        waypoint_t* wpsrc,*wpdst;
;197:        vec3_t v;
;198:
;199:        if( self->s.v.health <= 0 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $53
line 200
;200:                return;
ADDRGP4 $52
JUMPV
LABELV $53
line 202
;201:
;202:	if ( self->wp || self->wp_path )
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
CNSTU4 0
ASGNU4
ADDRLP4 20
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 24
INDIRU4
NEU4 $57
ADDRLP4 20
INDIRP4
CNSTI4 1760
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 24
INDIRU4
EQU4 $55
LABELV $57
line 203
;203:	{
line 204
;204:	        return;
ADDRGP4 $52
JUMPV
LABELV $55
line 207
;205:	}
;206:
;207:	VectorSubtract( self->s.v.origin, end_pos, v );
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRGP4 end_pos
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRGP4 end_pos+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRGP4 end_pos+8
INDIRF4
SUBF4
ASGNF4
line 209
;208:
;209:	if( vlen(v) < 50 )
ADDRLP4 8
ARGP4
ADDRLP4 28
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 28
INDIRF4
CNSTF4 1112014848
GEF4 $62
line 210
;210:	        return;
ADDRGP4 $52
JUMPV
LABELV $62
line 212
;211:
;212:        wpsrc = WaypointFindNearestVisible( self->s.v.origin, 0 );
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 WaypointFindNearestVisible
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 213
;213:        if( !wpsrc )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $64
line 214
;214:                wpsrc = WaypointFindNearest( self->s.v.origin );
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 WaypointFindNearest
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
LABELV $64
line 216
;215:        
;216:        wpdst = WaypointFindNearestVisible( end_pos, 0 );
ADDRGP4 end_pos
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 40
ADDRGP4 WaypointFindNearestVisible
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
ASGNP4
line 217
;217:        if( !wpdst )
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $66
line 218
;218:                wpdst = WaypointFindNearest( end_pos );
ADDRGP4 end_pos
ARGP4
ADDRLP4 44
ADDRGP4 WaypointFindNearest
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 44
INDIRP4
ASGNP4
LABELV $66
line 220
;219:
;220:        if( !wpsrc || !wpdst )
ADDRLP4 48
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 48
INDIRU4
EQU4 $70
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 48
INDIRU4
NEU4 $68
LABELV $70
line 221
;221:                return;
ADDRGP4 $52
JUMPV
LABELV $68
line 223
;222:
;223:        if( wpsrc == wpdst )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
NEU4 $71
line 224
;224:                return;
ADDRGP4 $52
JUMPV
LABELV $71
line 225
;225:	if( !self->end_wp )
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $73
line 226
;226:	        self->end_wp = malloc(sizeof(waypoint_t));
CNSTI4 116
ARGI4
ADDRLP4 52
ADDRGP4 malloc
CALLP4
ASGNP4
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
ADDRLP4 52
INDIRP4
ASGNP4
LABELV $73
line 228
;227:
;228:	memset( self->end_wp, 0, sizeof(waypoint_t));
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 116
ARGI4
ADDRGP4 memset
CALLP4
pop
line 229
;229:	self->end_wp->flags = WP_FL_TEMP;
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 1
ASGNI4
line 230
;230:	self->end_wp->radius = 30;
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1106247680
ASGNF4
line 231
;231:	VectorCopy( end_pos, self->end_wp->origin );
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
ADDRGP4 end_pos
INDIRF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 end_pos+4
INDIRF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 end_pos+8
INDIRF4
ASGNF4
line 233
;232:
;233:        self->wp_path = NULL;
ADDRGP4 self
INDIRP4
CNSTI4 1760
ADDP4
CNSTP4 0
ASGNP4
line 235
;234:
;235:        if( wpsrc != wpdst )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
EQU4 $77
line 236
;236:        {
line 237
;237:	       if( !(self->wp_path = WaypointFindPath( wpsrc, wpdst ) ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 WaypointFindPath
CALLP4
ASGNP4
ADDRGP4 self
INDIRP4
CNSTI4 1760
ADDP4
ADDRLP4 56
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $79
line 238
;238:	       {
line 239
;239:	               G_dprintf("path not found\n");
ADDRGP4 $81
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 240
;240:	               return;
ADDRGP4 $52
JUMPV
LABELV $79
line 242
;241:	       }
;242:               self->wp = self->wp_path->link->src_wp;
ADDRLP4 60
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 1748
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 1760
ADDP4
INDIRP4
INDIRP4
INDIRP4
ASGNP4
line 243
;243:        }else
ADDRGP4 $78
JUMPV
LABELV $77
line 244
;244:        {
line 245
;245:                self->wp = self->end_wp;
ADDRLP4 56
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 1748
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
ASGNP4
line 246
;246:                self->end_wp = NULL;
ADDRGP4 self
INDIRP4
CNSTI4 1752
ADDP4
CNSTP4 0
ASGNP4
line 247
;247:        }
LABELV $78
line 250
;248:
;249:	        
;250:	self->wp_link = &default_link;
ADDRGP4 self
INDIRP4
CNSTI4 1756
ADDP4
ADDRGP4 default_link
ASGNP4
line 251
;251:}
LABELV $52
endproc SelectWP 64 12
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
LABELV $81
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $18
byte 1 112
byte 1 114
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
