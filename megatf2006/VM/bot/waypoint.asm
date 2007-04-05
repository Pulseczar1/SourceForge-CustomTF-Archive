data
align 4
LABELV wp_list_start
byte 4 0
align 4
LABELV numwaypoints
byte 4 0
align 4
LABELV wpdrawed
byte 4 0
export ClearWaypoints
code
proc ClearWaypoints 12 4
file "..\src\bot\waypoint.c"
line 35
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
;21: *  $Id: waypoint.c,v 1.9 2006/03/09 20:54:16 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:typedef struct wp_list_s {
;26:	struct wp_list_s *next, *prev;
;27:	waypoint_t *wp;
;28:} wp_list_t;
;29:
;30:static wp_list_t *wp_list_start = NULL;
;31:static int numwaypoints = 0;
;32:static int wpdrawed = 0;
;33:void DrawWPS();
;34:void ClearWaypoints(  )
;35:{
line 38
;36:        int i;
;37:        wp_list_t *wp_l;
;38:        if( wpdrawed )
ADDRGP4 wpdrawed
INDIRI4
CNSTI4 0
EQI4 $15
line 39
;39:                DrawWPS();
ADDRGP4 DrawWPS
CALLV
pop
ADDRGP4 $15
JUMPV
LABELV $14
line 42
;40:                
;41:        while( wp_list_start )
;42:        {
line 43
;43:                wp_l = wp_list_start;
ADDRLP4 4
ADDRGP4 wp_list_start
INDIRP4
ASGNP4
line 44
;44:                wp_list_start = wp_l->next;
ADDRGP4 wp_list_start
ADDRLP4 4
INDIRP4
INDIRP4
ASGNP4
line 45
;45:		for ( i = 0 ; i < MAX_WP_LINKS ; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $17
line 46
;46:		{
line 47
;47:		        if( wp_l->wp->links[i] )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $21
line 48
;48:        		        free(wp_l->wp->links[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 free
CALLV
pop
LABELV $21
line 49
;49:		}
LABELV $18
line 45
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 20
LTI4 $17
line 50
;50:                free(wp_l->wp);
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 free
CALLV
pop
line 51
;51:                free(wp_l);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 free
CALLV
pop
line 52
;52:                numwaypoints--;
ADDRLP4 8
ADDRGP4 numwaypoints
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 53
;53:        }
LABELV $15
line 41
ADDRGP4 wp_list_start
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $14
line 56
;54:
;55:
;56:}
LABELV $11
endproc ClearWaypoints 12 4
export AddWaypoint
proc AddWaypoint 24 12
line 59
;57:
;58:waypoint_t *AddWaypoint( waypoint_t * newwp )
;59:{
line 61
;60:
;61:	waypoint_t *wp = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 64
;62:	wp_list_t *wp_l;
;63:
;64:	if ( newwp->flags & WP_FL_TEMP )	//dont allow temp wp in wp list
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $24
line 65
;65:		newwp->flags -= WP_FL_TEMP;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $24
line 67
;66:
;67:	if ( newwp->radius == 0 )
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 0
NEF4 $26
line 68
;68:		newwp->radius = 60;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1114636288
ASGNF4
LABELV $26
line 70
;69:
;70:	for ( wp_l = wp_list_start; wp_l; wp_l = wp_l->next )
ADDRLP4 0
ADDRGP4 wp_list_start
INDIRP4
ASGNP4
ADDRGP4 $31
JUMPV
LABELV $28
line 71
;71:	{
line 72
;72:	        if( wp_l->wp->index == newwp->index )
ADDRLP4 12
CNSTI4 16
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
NEI4 $32
line 73
;73:	        {
line 74
;74:	                wp = wp_l->wp;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
line 75
;75:	                break;
ADDRGP4 $30
JUMPV
LABELV $32
line 78
;76:	        }
;77:	        
;78:	}
LABELV $29
line 70
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
LABELV $31
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $28
LABELV $30
line 79
;79:	if( !wp)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $34
line 80
;80:	{
line 81
;81:          	wp = malloc( sizeof( waypoint_t ) );
CNSTI4 116
ARGI4
ADDRLP4 12
ADDRGP4 malloc
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 82
;82:         	memcpy( wp, newwp, sizeof( waypoint_t ) );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 116
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 84
;83:
;84:         	wp_l = malloc( sizeof( wp_list_t ) );
CNSTI4 12
ARGI4
ADDRLP4 16
ADDRGP4 malloc
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 86
;85:
;86:         	wp_l->next = wp_list_start;
ADDRLP4 0
INDIRP4
ADDRGP4 wp_list_start
INDIRP4
ASGNP4
line 87
;87:         	wp_l->prev = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTP4 0
ASGNP4
line 88
;88:         	wp_l->wp = wp;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 89
;89:         	if ( wp_list_start )
ADDRGP4 wp_list_start
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $36
line 90
;90:         		wp_list_start->prev = wp_l;
ADDRGP4 wp_list_start
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $36
line 91
;91:         	wp_list_start = wp_l;
ADDRGP4 wp_list_start
ADDRLP4 0
INDIRP4
ASGNP4
line 92
;92:         	memset( wp->links, 0, sizeof( wp->links ) );
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 80
ARGI4
ADDRGP4 memset
CALLP4
pop
line 93
;93:         	numwaypoints++;
ADDRLP4 20
ADDRGP4 numwaypoints
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 94
;94:	}else
ADDRGP4 $35
JUMPV
LABELV $34
line 95
;95:	{
line 96
;96:	        G_dprintf("WP index %3d replaced\n", newwp->index);
ADDRGP4 $38
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_dprintf
CALLV
pop
line 97
;97:	        VectorCopy( newwp->origin, wp->origin );
ADDRLP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 12
CNSTI4 4
ASGNI4
ADDRLP4 4
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
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRLP4 4
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
line 98
;98:	        wp->flags  = newwp->flags;
ADDRLP4 12
CNSTI4 20
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 99
;99:	        wp->radius = newwp->radius;
ADDRLP4 16
CNSTI4 12
ASGNI4
ADDRLP4 4
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
line 100
;100:	        wp->teams  = newwp->teams;
ADDRLP4 20
CNSTI4 24
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 101
;101:	}
LABELV $35
line 102
;102:	return wp;
ADDRLP4 4
INDIRP4
RETP4
LABELV $23
endproc AddWaypoint 24 12
export WaypointFindNearest
proc WaypointFindNearest 36 4
line 106
;103:}
;104:
;105:waypoint_t *WaypointFindNearest( vec3_t point )
;106:{
line 107
;107:	float   minlen = 10e8;
ADDRLP4 20
CNSTF4 1315859240
ASGNF4
line 111
;108:	float   len;
;109:	vec3_t  vtmp;
;110:	wp_list_t *wp_l;
;111:	waypoint_t *wp = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 113
;112:
;113:	for ( wp_l = wp_list_start; wp_l; wp_l = wp_l->next )
ADDRLP4 0
ADDRGP4 wp_list_start
INDIRP4
ASGNP4
ADDRGP4 $43
JUMPV
LABELV $40
line 114
;114:	{
line 115
;115:		VectorSubtract( point, wp_l->wp->origin, vtmp );
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28
CNSTI4 4
ASGNI4
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32
CNSTI4 8
ASGNI4
ADDRLP4 4+8
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
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 116
;116:		len = vlen( vtmp );
ADDRLP4 4
ARGP4
ADDRLP4 28
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 28
INDIRF4
ASGNF4
line 117
;117:		if ( minlen > len )
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $46
line 118
;118:		{
line 119
;119:			minlen = len;
ADDRLP4 20
ADDRLP4 16
INDIRF4
ASGNF4
line 120
;120:			wp = wp_l->wp;
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
line 121
;121:		}
LABELV $46
line 122
;122:	}
LABELV $41
line 113
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
LABELV $43
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $40
line 123
;123:	return wp;
ADDRLP4 24
INDIRP4
RETP4
LABELV $39
endproc WaypointFindNearest 36 4
export WaypointFindNearestVisible
proc WaypointFindNearestVisible 52 32
line 127
;124:}
;125:
;126:waypoint_t *WaypointFindNearestVisible( vec3_t point, int nomonsters )
;127:{
line 129
;128:
;129:	float   minlen = 10e8;
ADDRLP4 20
CNSTF4 1315859240
ASGNF4
line 133
;130:	float   len;
;131:	vec3_t  vtmp;
;132:	wp_list_t *wp_l;
;133:	waypoint_t *wp = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 135
;134:
;135:	for ( wp_l = wp_list_start; wp_l; wp_l = wp_l->next )
ADDRLP4 0
ADDRGP4 wp_list_start
INDIRP4
ASGNP4
ADDRGP4 $52
JUMPV
LABELV $49
line 136
;136:	{
line 137
;137:		traceline( PASSVEC3( point ), PASSVEC3( wp_l->wp->origin ), nomonsters,  self );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 32
CNSTI4 4
ASGNI4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
CNSTI4 8
ASGNI4
ADDRLP4 28
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 139
;138://                TraceCapsule( PASSVEC3( self->s.v.origin ), PASSVEC3( wp_l->wp->origin ), 1, self, PASSVEC3( self->s.v.mins)+TRACECAP_ADD, PASSVEC3( self->s.v.maxs)-TRACECAP_ADD );
;139:		if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $53
line 140
;140:			continue;
ADDRGP4 $50
JUMPV
LABELV $53
line 142
;141:
;142:		VectorSubtract( point, wp_l->wp->origin, vtmp );
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44
CNSTI4 4
ASGNI4
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 8
ASGNI4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 143
;143:		len = vlen( vtmp );
ADDRLP4 4
ARGP4
ADDRLP4 44
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 44
INDIRF4
ASGNF4
line 144
;144:		if ( minlen > len )
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $58
line 145
;145:		{
line 146
;146:			minlen = len;
ADDRLP4 20
ADDRLP4 16
INDIRF4
ASGNF4
line 147
;147:			wp = wp_l->wp;
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
line 148
;148:		}
LABELV $58
line 149
;149:	}
LABELV $50
line 135
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
LABELV $52
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $49
line 150
;150:	return wp;
ADDRLP4 24
INDIRP4
RETP4
LABELV $48
endproc WaypointFindNearestVisible 52 32
export WaypointFindVisible
proc WaypointFindVisible 28 32
line 153
;151:}
;152:int WaypointFindVisible( vec3_t point, int nomonsters, waypoint_t ** wps, int maxcount )
;153:{
line 154
;154:	int     num = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 157
;155:	wp_list_t *wp_l;
;156:
;157:	if ( !wps )
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $61
line 158
;158:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $60
JUMPV
LABELV $61
line 160
;159:
;160:	for ( wp_l = wp_list_start; wp_l && num < maxcount; wp_l = wp_l->next )
ADDRLP4 0
ADDRGP4 wp_list_start
INDIRP4
ASGNP4
ADDRGP4 $66
JUMPV
LABELV $63
line 161
;161:	{
line 162
;162:		traceline( PASSVEC3( point ), PASSVEC3( wp_l->wp->origin ), nomonsters, self );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
CNSTI4 4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 164
;163://              TraceCapsule( PASSVEC3( self->s.v.origin ), PASSVEC3( wp_l->wp->origin ), 1, self, PASSVEC3( self->s.v.mins)+TRACECAP_ADD, PASSVEC3( self->s.v.maxs)-TRACECAP_ADD );
;164:		if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $67
line 165
;165:			continue;
ADDRGP4 $64
JUMPV
LABELV $67
line 166
;166:		*wps++ = wp_l->wp;
ADDRLP4 24
ADDRFP4 8
INDIRP4
ASGNP4
ADDRFP4 8
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
line 167
;167:		num++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 168
;168:	}
LABELV $64
line 160
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
LABELV $66
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $70
ADDRLP4 4
INDIRI4
ADDRFP4 12
INDIRI4
LTI4 $63
LABELV $70
line 169
;169:	return num;
ADDRLP4 4
INDIRI4
RETI4
LABELV $60
endproc WaypointFindVisible 28 32
export WaypointFindByType
proc WaypointFindByType 28 0
line 173
;170:}
;171:
;172:int WaypointFindByType( int flags, int teams, waypoint_t ** wps, int maxcount )
;173:{
line 174
;174:	int     num = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 177
;175:	wp_list_t *wp_l;
;176:
;177:	if ( !wps )
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $72
line 178
;178:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $71
JUMPV
LABELV $72
line 180
;179:
;180:	for ( wp_l = wp_list_start; wp_l && num < maxcount; wp_l = wp_l->next )
ADDRLP4 0
ADDRGP4 wp_list_start
INDIRP4
ASGNP4
ADDRGP4 $77
JUMPV
LABELV $74
line 181
;181:	{
line 182
;182:		if ( !( flags && ( wp_l->wp->flags & flags ) ) )
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $80
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
BANDI4
ADDRLP4 12
INDIRI4
NEI4 $78
LABELV $80
line 183
;183:			continue;
ADDRGP4 $75
JUMPV
LABELV $78
line 185
;184:
;185:		if ( !( teams && ( wp_l->wp->teams & teams ) ) )
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $83
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
BANDI4
ADDRLP4 20
INDIRI4
NEI4 $81
LABELV $83
line 186
;186:			continue;
ADDRGP4 $75
JUMPV
LABELV $81
line 188
;187:
;188:		*wps++ = wp_l->wp;
ADDRLP4 24
ADDRFP4 8
INDIRP4
ASGNP4
ADDRFP4 8
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
line 189
;189:		num++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 190
;190:	}
LABELV $75
line 180
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
LABELV $77
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $84
ADDRLP4 4
INDIRI4
ADDRFP4 12
INDIRI4
LTI4 $74
LABELV $84
line 191
;191:	return num;
ADDRLP4 4
INDIRI4
RETI4
LABELV $71
endproc WaypointFindByType 28 0
export WaypointFindInRadius
proc WaypointFindInRadius 28 4
line 195
;192:}
;193:
;194:int     WaypointFindInRadius( vec3_t vPos, float fRadius, waypoint_t** wps, int maxcount )
;195:{
line 196
;196:	int     num = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 200
;197:	vec3_t  vtmp;
;198:	wp_list_t *wp_l;
;199:
;200:	if ( !wps )
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $86
line 201
;201:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $85
JUMPV
LABELV $86
line 203
;202:
;203:	for ( wp_l = wp_list_start; wp_l && num < maxcount; wp_l = wp_l->next )
ADDRLP4 0
ADDRGP4 wp_list_start
INDIRP4
ASGNP4
ADDRGP4 $91
JUMPV
LABELV $88
line 204
;204:	{
line 205
;205:		VectorSubtract( vPos, wp_l->wp->origin, vtmp );
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 4+8
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
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 206
;206:		if( vlen( vtmp ) > fRadius )
ADDRLP4 4
ARGP4
ADDRLP4 20
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $94
line 207
;207:		        continue;
ADDRGP4 $89
JUMPV
LABELV $94
line 209
;208:
;209:		*wps++ = wp_l->wp;
ADDRLP4 24
ADDRFP4 8
INDIRP4
ASGNP4
ADDRFP4 8
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
line 210
;210:		num++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 211
;211:	}
LABELV $89
line 203
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
LABELV $91
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $96
ADDRLP4 16
INDIRI4
ADDRFP4 12
INDIRI4
LTI4 $88
LABELV $96
line 212
;212:	return num;
ADDRLP4 16
INDIRI4
RETI4
LABELV $85
endproc WaypointFindInRadius 28 4
export AddLink
proc AddLink 40 12
line 216
;213:}
;214:
;215:qboolean AddLink( int src_index, int dest_index, wp_link_t * newlink )
;216:{
line 218
;217:	wp_list_t *wp_l;
;218:	waypoint_t *wp_src = NULL, *wp_dst = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
ADDRLP4 16
CNSTP4 0
ASGNP4
line 220
;219:	wp_link_t *link;
;220:	int     index = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 222
;221:
;222:	for ( wp_l = wp_list_start; wp_l; wp_l = wp_l->next )
ADDRLP4 0
ADDRGP4 wp_list_start
INDIRP4
ASGNP4
ADDRGP4 $101
JUMPV
LABELV $98
line 223
;223:	{
line 224
;224:		if ( wp_l->wp->index == src_index )
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $102
line 225
;225:			wp_src = wp_l->wp;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
LABELV $102
line 227
;226:
;227:		if ( wp_l->wp->index == dest_index )
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $104
line 228
;228:			wp_dst = wp_l->wp;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
LABELV $104
line 229
;229:	}
LABELV $99
line 222
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
LABELV $101
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $98
line 230
;230:	if ( !wp_src || !wp_dst )
ADDRLP4 20
CNSTU4 0
ASGNU4
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRU4
EQU4 $108
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRU4
NEU4 $106
LABELV $108
line 231
;231:		return false;
CNSTI4 0
RETI4
ADDRGP4 $97
JUMPV
LABELV $106
line 233
;232:
;233:	for ( index = 0; index < MAX_WP_LINKS; index++ )
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $109
line 234
;234:	{
line 235
;235:		if ( !wp_src->links[index] )
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $113
line 236
;236:			break;
ADDRGP4 $111
JUMPV
LABELV $113
line 237
;237:	}
LABELV $110
line 233
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 20
LTI4 $109
LABELV $111
line 238
;238:	if ( index == MAX_WP_LINKS )
ADDRLP4 4
INDIRI4
CNSTI4 20
NEI4 $115
line 239
;239:	{
line 240
;240:		G_dprintf( "AddLink: MAX_WP_LINKS in wp %d\n", src_index );
ADDRGP4 $117
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_dprintf
CALLV
pop
line 241
;241:		return false;
CNSTI4 0
RETI4
ADDRGP4 $97
JUMPV
LABELV $115
line 243
;242:	}
;243:	link = malloc( sizeof( wp_link_t ) );
CNSTI4 48
ARGI4
ADDRLP4 24
ADDRGP4 malloc
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 24
INDIRP4
ASGNP4
line 244
;244:	memcpy( link, newlink, sizeof( wp_link_t ) );
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 48
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 245
;245:	link->src_wp = wp_src;
ADDRLP4 12
INDIRP4
ADDRLP4 8
INDIRP4
ASGNP4
line 246
;246:	link->dest_wp = wp_dst;
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 247
;247:	VectorSubtract( wp_src->origin, wp_dst->origin, link->dir );
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28
CNSTI4 4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 8
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32
CNSTI4 8
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 8
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 248
;248:	link->length = VectorNormalize( link->dir );
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
line 249
;249:	vectoangles( link->dir, link->dirangles );
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 251
;250:
;251:	wp_src->links[index] = link;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDP4
ADDRLP4 12
INDIRP4
ASGNP4
line 252
;252:	return true;
CNSTI4 1
RETI4
LABELV $97
endproc AddLink 40 12
export FreePath
proc FreePath 4 4
line 263
;253:}
;254:
;255:
;256:#define MAX_PATH_LEN  100
;257:typedef struct tmp_path_s{
;258:	waypoint_t *wp;
;259:	int     link_index;
;260:} tmp_path_t;
;261:
;262:void FreePath( wp_path_t * path )
;263:{
ADDRGP4 $120
JUMPV
LABELV $119
line 267
;264:	wp_path_t *tmp;
;265:
;266:	while ( path )
;267:	{
line 268
;268:		tmp = path->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 269
;269:		free( path );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 free
CALLV
pop
line 270
;270:		path = tmp;
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
line 271
;271:	}
LABELV $120
line 266
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $119
line 272
;272:}
LABELV $118
endproc FreePath 4 4
export PrintPath
proc PrintPath 4 20
line 274
;273:void PrintPath(wp_path_t * path)
;274:{
ADDRGP4 $124
JUMPV
LABELV $123
line 277
;275:
;276:        while( path )
;277:        {
line 278
;278:                G_dprintf("WP %3d = %3f %3f %3f\n", path->link->src_wp->index,PASSVEC3( path->link->src_wp->origin));
ADDRGP4 $126
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_dprintf
CALLV
pop
line 279
;279:                path = path->next;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 280
;280:        }
LABELV $124
line 276
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $123
line 281
;281:}
LABELV $122
endproc PrintPath 4 20
export WaypointFindPath
proc WaypointFindPath 48 4
line 371
;282:
;283:/*wp_path_t *WaypointFindPathOld( waypoint_t * wp_src, waypoint_t * wp_dst )
;284:{
;285:	int     pathlen = 0, i;
;286:	tmp_path_t tmppath[MAX_PATH_LEN];
;287:	wp_path_t *path = NULL, *tmpp;
;288:
;289:	if ( !wp_dst || !wp_src )
;290:	{
;291:		G_dprintf( "WaypointFindPath: NULL arguments\n" );
;292:		return NULL;
;293:	}
;294:	if ( wp_src == wp_dst )
;295:	{
;296:		G_dprintf( "WaypointFindPath: wp_src == wp_dst\n" );
;297:		return NULL;
;298:	}
;299:
;300:	tmppath[pathlen].wp = wp_src;
;301:	tmppath[pathlen].link_index = -1;
;302:
;303://clear marked 
;304:        {
;305:            wp_list_t *wp_l;
;306:            for ( wp_l = wp_list_start; wp_l ; wp_l = wp_l->next )
;307:                wp_l->wp->marked = 0;
;308:        }
;309://
;310:	while ( 1 )
;311:	{
;312:		waypoint_t *curr_wp = tmppath[pathlen].wp;
;313:		int     link_index = tmppath[pathlen].link_index;
;314:                curr_wp->marked = 1;
;315:		
;316:		if ( link_index < 0 )
;317:			for ( i = 0; i < MAX_WP_LINKS; i++ )
;318:			{
;319:				if ( !curr_wp->links[i] )
;320:					continue;
;321:				if ( curr_wp->links[i]->dest_wp == wp_dst )
;322:				{
;323:					tmppath[pathlen++].link_index = i;
;324:					goto found;
;325:				}
;326:			}
;327:		while ( ++link_index < MAX_WP_LINKS )
;328:		{
;329:			if ( !curr_wp->links[link_index] )
;330:			        continue;
;331:			if ( !curr_wp->links[link_index]->dest_wp->marked )
;332:				break;
;333:		}
;334:		if ( link_index >= MAX_WP_LINKS )
;335:		{
;336:			if ( !( pathlen-- ) )
;337:				return NULL;
;338:			continue;
;339:		}
;340:		tmppath[pathlen].link_index = link_index;
;341:		if ( ++pathlen >= MAX_PATH_LEN )
;342:		{
;343:			pathlen -= 2;
;344:			continue;
;345:		}
;346:
;347:		tmppath[pathlen].wp = curr_wp->links[link_index]->dest_wp;
;348:		tmppath[pathlen].link_index = -1;
;349:
;350:	}
;351:      found:
;352:
;353:	path = malloc( sizeof( wp_path_t ) );
;354:	path->link = tmppath[0].wp->links[tmppath[0].link_index];
;355:	path->next = NULL;
;356:	tmpp = path;
;357:        G_dprintf( "WaypointFindPath: pathlen = %d\nWP  0 %3d = %3f %3f %3f\n", pathlen, tmpp->link->src_wp->index, PASSVEC3( tmpp->link->src_wp->origin));
;358:	for ( i = 1; i < pathlen; i++ )
;359:	{
;360:		tmpp->next = malloc( sizeof( wp_path_t ) );
;361:		tmpp = tmpp->next;
;362:		tmpp->link = tmppath[i].wp->links[tmppath[i].link_index];
;363:		tmpp->next = NULL;
;364:                G_dprintf("WP %2d %3d = %3f %3f %3f\n", i,tmpp->link->src_wp->index,PASSVEC3( tmpp->link->src_wp->origin));
;365:	}
;366:        G_dprintf("WP %2d %3d = %3f %3f %3f\n", i,tmpp->link->dest_wp->index, PASSVEC3( tmpp->link->dest_wp->origin));
;367:	return path;
;368:}*/
;369:
;370:wp_path_t *WaypointFindPath( waypoint_t * wp_src, waypoint_t * wp_dst )
;371:{
line 372
;372:	int     pathlen = 0, i;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 373
;373:	wp_path_t *path = NULL, *tmpp;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 376
;374:	wp_list_t *wp_l,*wp_l_end;
;375:
;376:	if ( !wp_dst || !wp_src )
ADDRLP4 24
CNSTU4 0
ASGNU4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 24
INDIRU4
EQU4 $130
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 24
INDIRU4
NEU4 $128
LABELV $130
line 377
;377:	{
line 378
;378:		G_dprintf( "WaypointFindPath: NULL arguments\n" );
ADDRGP4 $131
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 379
;379:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $127
JUMPV
LABELV $128
line 381
;380:	}
;381:	if ( wp_src == wp_dst )
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $132
line 382
;382:	{
line 383
;383:		G_dprintf( "WaypointFindPath: wp_src == wp_dst\n" );
ADDRGP4 $134
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 384
;384:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $127
JUMPV
LABELV $132
line 389
;385:	}
;386:
;387:
;388://clear marked 
;389:        {
line 390
;390:            for ( wp_l = wp_list_start; wp_l ; wp_l = wp_l->next )
ADDRLP4 4
ADDRGP4 wp_list_start
INDIRP4
ASGNP4
ADDRGP4 $138
JUMPV
LABELV $135
line 391
;391:            {
line 392
;392:                wp_l->wp->marked = 0;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 108
ADDP4
CNSTI4 0
ASGNI4
line 393
;393:                wp_l->wp->parent = NULL;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CNSTI4 112
ADDP4
CNSTP4 0
ASGNP4
line 394
;394:            }
LABELV $136
line 390
ADDRLP4 4
ADDRLP4 4
INDIRP4
INDIRP4
ASGNP4
LABELV $138
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $135
line 395
;395:        }
line 397
;396://
;397:        wp_l = malloc( sizeof( wp_list_t ));
CNSTI4 12
ARGI4
ADDRLP4 28
ADDRGP4 malloc
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 28
INDIRP4
ASGNP4
line 398
;398:        wp_l_end = wp_l;
ADDRLP4 8
ADDRLP4 4
INDIRP4
ASGNP4
line 399
;399:        wp_l->next = NULL;
ADDRLP4 4
INDIRP4
CNSTP4 0
ASGNP4
line 400
;400:        wp_l->prev = NULL;
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTP4 0
ASGNP4
line 401
;401:        wp_l->wp = wp_src;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 402
;402:        wp_src->marked = 1;
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTI4 1
ASGNI4
ADDRGP4 $140
JUMPV
LABELV $139
line 405
;403:
;404:	while ( wp_l_end )
;405:	{
line 406
;406:		wp_list_t *wpl_tmp  = wp_l_end;
ADDRLP4 32
ADDRLP4 8
INDIRP4
ASGNP4
line 407
;407:		waypoint_t *wp = wp_l_end->wp;
ADDRLP4 36
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
line 408
;408:		wp_l_end = wpl_tmp->prev;
ADDRLP4 8
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 409
;409:		if( wp_l_end )
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $142
line 410
;410:		        wp_l_end->next = NULL;
ADDRLP4 8
INDIRP4
CNSTP4 0
ASGNP4
ADDRGP4 $143
JUMPV
LABELV $142
line 412
;411:		else
;412:		{
line 413
;413:		        wp_l = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 414
;414:		        wp_l_end = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 415
;415:		}
LABELV $143
line 417
;416:		
;417:		free( wpl_tmp );
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 free
CALLV
pop
line 419
;418:
;419:		if( wp == wp_dst )
ADDRLP4 36
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $144
line 420
;420:		{
ADDRGP4 $147
JUMPV
LABELV $146
line 422
;421:		        while(wp_l)
;422:		        {
line 423
;423:		                wpl_tmp = wp_l->next;
ADDRLP4 32
ADDRLP4 4
INDIRP4
INDIRP4
ASGNP4
line 424
;424:		                free(wp_l);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 free
CALLV
pop
line 425
;425:		                wp_l = wpl_tmp;
ADDRLP4 4
ADDRLP4 32
INDIRP4
ASGNP4
line 426
;426:		        }
LABELV $147
line 421
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $146
line 427
;427:		        break;
ADDRGP4 $141
JUMPV
LABELV $144
line 430
;428:		}
;429:
;430:		for ( i = 0 ; i < MAX_WP_LINKS ; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $149
line 431
;431:		{
line 432
;432:      			if ( !wp->links[i] )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 36
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $153
line 433
;433:      				continue;
ADDRGP4 $150
JUMPV
LABELV $153
line 434
;434:      			if( wp->links[i]->dest_wp->marked )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 36
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 0
EQI4 $155
line 435
;435:      			        continue;
ADDRGP4 $150
JUMPV
LABELV $155
line 437
;436:
;437:      			wp->links[i]->dest_wp->marked = 1;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 36
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CNSTI4 108
ADDP4
CNSTI4 1
ASGNI4
line 438
;438:      			wp->links[i]->dest_wp->parent = wp->links[i];
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 36
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 40
INDIRP4
ASGNP4
line 439
;439:      			wpl_tmp = malloc( sizeof( wp_list_t ));
CNSTI4 12
ARGI4
ADDRLP4 44
ADDRGP4 malloc
CALLP4
ASGNP4
ADDRLP4 32
ADDRLP4 44
INDIRP4
ASGNP4
line 440
;440:      			wpl_tmp->wp = wp->links[i]->dest_wp;
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 36
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 441
;441:      			wpl_tmp->next = wp_l;
ADDRLP4 32
INDIRP4
ADDRLP4 4
INDIRP4
ASGNP4
line 442
;442:      			wpl_tmp->prev = NULL;
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
CNSTP4 0
ASGNP4
line 443
;443:      			if( wp_l )
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $157
line 444
;444:      			     wp_l->prev = wpl_tmp;
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 32
INDIRP4
ASGNP4
ADDRGP4 $158
JUMPV
LABELV $157
line 446
;445:      			else
;446:      			     wp_l_end = wpl_tmp;
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
LABELV $158
line 447
;447:      			wp_l = wpl_tmp;
ADDRLP4 4
ADDRLP4 32
INDIRP4
ASGNP4
line 448
;448:		}
LABELV $150
line 430
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 20
LTI4 $149
line 450
;449:
;450:	}
LABELV $140
line 404
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $139
LABELV $141
line 451
;451:	if( !wp_dst->parent )
ADDRFP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $159
line 452
;452:	        return NULL;
CNSTP4 0
RETP4
ADDRGP4 $127
JUMPV
LABELV $159
line 455
;453:
;454:	
;455:	path = malloc( sizeof( wp_path_t ) );
CNSTI4 8
ARGI4
ADDRLP4 32
ADDRGP4 malloc
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 32
INDIRP4
ASGNP4
line 456
;456:	path->link = wp_dst->parent;
ADDRLP4 12
INDIRP4
ADDRFP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
ASGNP4
line 457
;457:	path->next = NULL;
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
CNSTP4 0
ASGNP4
ADDRGP4 $162
JUMPV
LABELV $161
line 459
;458:	while( path->link->src_wp != wp_src )
;459:	{
line 460
;460:	        tmpp = path;
ADDRLP4 16
ADDRLP4 12
INDIRP4
ASGNP4
line 461
;461:	        path = malloc( sizeof( wp_path_t ) );
CNSTI4 8
ARGI4
ADDRLP4 36
ADDRGP4 malloc
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 36
INDIRP4
ASGNP4
line 462
;462:	        path->next = tmpp;
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 463
;463:	        path->link = tmpp->link->src_wp->parent;
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRP4
INDIRP4
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
ASGNP4
line 464
;464:	}
LABELV $162
line 458
ADDRLP4 12
INDIRP4
INDIRP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $161
line 466
;465:	
;466:	PrintPath(path);
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 PrintPath
CALLV
pop
line 467
;467:	return path;
ADDRLP4 12
INDIRP4
RETP4
LABELV $127
endproc WaypointFindPath 48 4
export DrawWPS
proc DrawWPS 20 16
line 472
;468:}
;469:
;470:
;471:void DrawWPS()
;472:{
line 476
;473:        gedict_t* te;
;474:        wp_list_t *wp_l;
;475:
;476:        if( wpdrawed )
ADDRGP4 wpdrawed
INDIRI4
CNSTI4 0
EQI4 $165
line 477
;477:        {
line 478
;478:                for ( te = world; ( te = trap_find( te, FOFS( s.v.classname ) , "wp" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $170
JUMPV
LABELV $167
line 479
;479:                        dremove(te);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
LABELV $168
line 478
LABELV $170
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $171
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
NEU4 $167
line 480
;480:                wpdrawed = 0;
ADDRGP4 wpdrawed
CNSTI4 0
ASGNI4
line 481
;481:                return;
ADDRGP4 $164
JUMPV
LABELV $165
line 483
;482:        }
;483:        wpdrawed = 1;
ADDRGP4 wpdrawed
CNSTI4 1
ASGNI4
line 484
;484: 	for ( wp_l = wp_list_start; wp_l; wp_l = wp_l->next )
ADDRLP4 4
ADDRGP4 wp_list_start
INDIRP4
ASGNP4
ADDRGP4 $175
JUMPV
LABELV $172
line 485
;485: 	{
line 486
;486: 	        te = spawn(  );
ADDRLP4 8
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 487
;487: 	        te->s.v.takedamage = DAMAGE_NO;
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 488
;488:          	te->s.v.movetype = MOVETYPE_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 489
;489:          	te->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 490
;490:          	te->s.v.classname = "wp";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $171
ASGNP4
line 491
;491:          	te->wp = wp_l->wp;
ADDRLP4 0
INDIRP4
CNSTI4 1748
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
line 492
;492:          	setmodel( te, "progs/s_light.spr" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $176
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 493
;493:          	setorigin( te, PASSVEC3( wp_l->wp->origin));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRLP4 16
ADDRLP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
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
ADDRGP4 setorigin
CALLV
pop
line 494
;494: 	}
LABELV $173
line 484
ADDRLP4 4
ADDRLP4 4
INDIRP4
INDIRP4
ASGNP4
LABELV $175
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $172
line 497
;495:
;496:        
;497:}
LABELV $164
endproc DrawWPS 20 16
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
LABELV $176
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
LABELV $171
byte 1 119
byte 1 112
byte 1 0
align 1
LABELV $134
byte 1 87
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 70
byte 1 105
byte 1 110
byte 1 100
byte 1 80
byte 1 97
byte 1 116
byte 1 104
byte 1 58
byte 1 32
byte 1 119
byte 1 112
byte 1 95
byte 1 115
byte 1 114
byte 1 99
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 119
byte 1 112
byte 1 95
byte 1 100
byte 1 115
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $131
byte 1 87
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 70
byte 1 105
byte 1 110
byte 1 100
byte 1 80
byte 1 97
byte 1 116
byte 1 104
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 97
byte 1 114
byte 1 103
byte 1 117
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $126
byte 1 87
byte 1 80
byte 1 32
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 51
byte 1 102
byte 1 32
byte 1 37
byte 1 51
byte 1 102
byte 1 32
byte 1 37
byte 1 51
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $117
byte 1 65
byte 1 100
byte 1 100
byte 1 76
byte 1 105
byte 1 110
byte 1 107
byte 1 58
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 87
byte 1 80
byte 1 95
byte 1 76
byte 1 73
byte 1 78
byte 1 75
byte 1 83
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 119
byte 1 112
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $38
byte 1 87
byte 1 80
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 32
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 100
byte 1 10
byte 1 0
