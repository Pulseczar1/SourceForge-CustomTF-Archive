lit
align 4
LABELV default_class_discard
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 1
byte 4 1
byte 4 0
byte 4 0
byte 4 1
byte 4 1
byte 4 0
byte 4 1
byte 4 0
byte 4 1
byte 4 0
byte 4 1
byte 4 0
byte 4 1
byte 4 0
byte 4 0
byte 4 1
byte 4 1
byte 4 0
byte 4 1
byte 4 1
byte 4 0
byte 4 0
byte 4 1
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 1
byte 4 1
byte 4 0
byte 4 0
byte 4 1
byte 4 0
export TeamFortress_Cmd_Discard
code
proc TeamFortress_Cmd_Discard 1128 28
file "..\src\actions.c"
line 44
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
;21: *  $Id: actions.c,v 1.25 2006/01/14 16:50:10 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:void	W_Reload_shotgun(  );
;26:void	W_Reload_super_shotgun(  );
;27:void 	W_Reload_grenade_launcher(  );
;28:void 	W_Reload_rocket_launcher(  );
;29:
;30:static const int     default_class_discard[10][4] = {
;31:	{0, 0, 0, 0},
;32:	{0, 0, 1, 1},
;33:	{0, 0, 1, 1},
;34:	{0, 1, 0, 1},
;35:	{0, 1, 0, 1},
;36:	{0, 0, 1, 1},
;37:	{0, 1, 1, 0},
;38:	{0, 1, 0, 0},
;39:	{0, 0, 1, 1},
;40:	{0, 0, 1, 0}
;41:};
;42:
;43:void TeamFortress_Cmd_Discard( void )
;44:{
line 50
;45:	int     ammo_tmp;
;46:	vec3_t  vtemp;
;47:	int argc,i;
;48:	char    value[1024];
;49:
;50:	argc  = trap_CmdArgc();
ADDRLP4 1048
ADDRGP4 trap_CmdArgc
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1048
INDIRI4
ASGNI4
line 51
;51:	newmis = spawn(  );
ADDRLP4 1052
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 1052
INDIRP4
ASGNP4
line 53
;52:
;53:	if ( default_class_discard[self->playerclass][0] )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 default_class_discard
ADDP4
INDIRI4
CNSTI4 0
EQI4 $12
line 54
;54:		newmis->s.v.ammo_shells = self->s.v.ammo_shells;
ADDRLP4 1056
CNSTI4 320
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 1056
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 1056
INDIRI4
ADDP4
INDIRF4
ASGNF4
LABELV $12
line 55
;55:	if ( default_class_discard[self->playerclass][1] )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 default_class_discard+4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $14
line 56
;56:		newmis->s.v.ammo_nails = self->s.v.ammo_nails;
ADDRLP4 1060
CNSTI4 324
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 1060
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 1060
INDIRI4
ADDP4
INDIRF4
ASGNF4
LABELV $14
line 57
;57:	if ( default_class_discard[self->playerclass][2] )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 default_class_discard+8
ADDP4
INDIRI4
CNSTI4 0
EQI4 $17
line 58
;58:		newmis->s.v.ammo_rockets = self->s.v.ammo_rockets;
ADDRLP4 1064
CNSTI4 328
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 1064
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 1064
INDIRI4
ADDP4
INDIRF4
ASGNF4
LABELV $17
line 59
;59:	if ( default_class_discard[self->playerclass][3] )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 default_class_discard+12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $20
line 60
;60:		newmis->s.v.ammo_cells = self->s.v.ammo_cells;
ADDRLP4 1068
CNSTI4 332
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 1068
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 1068
INDIRI4
ADDP4
INDIRF4
ASGNF4
LABELV $20
line 62
;61:
;62:	for (  i = 1 ; i < argc ; i++ )
ADDRLP4 1024
CNSTI4 1
ASGNI4
ADDRGP4 $26
JUMPV
LABELV $23
line 63
;63:	{
line 64
;64:		trap_CmdArgv( i, value, sizeof( value ) );
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 65
;65:		switch( value[0] )
ADDRLP4 1072
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1080
CNSTI4 99
ASGNI4
ADDRLP4 1072
INDIRI4
ADDRLP4 1080
INDIRI4
EQI4 $51
ADDRLP4 1072
INDIRI4
ADDRLP4 1080
INDIRI4
LTI4 $27
LABELV $58
ADDRLP4 1072
INDIRI4
CNSTI4 110
EQI4 $37
ADDRLP4 1072
INDIRI4
CNSTI4 114
EQI4 $44
ADDRLP4 1072
INDIRI4
CNSTI4 115
EQI4 $30
ADDRGP4 $27
JUMPV
line 66
;66:		{
LABELV $30
line 68
;67:			case 's':
;68:				trap_CmdArgv( ++i, value, sizeof( value ) );
ADDRLP4 1088
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1024
ADDRLP4 1088
INDIRI4
ASGNI4
ADDRLP4 1088
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 69
;69:				ammo_tmp = atoi(value);
ADDRLP4 0
ARGP4
ADDRLP4 1092
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1092
INDIRI4
ASGNI4
line 70
;70:				if( ammo_tmp > 0 )
ADDRLP4 1028
INDIRI4
CNSTI4 0
LEI4 $31
line 71
;71:				{
line 72
;72:					if( ammo_tmp > self->s.v.ammo_shells )
ADDRLP4 1028
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
LEF4 $32
line 73
;73:						ammo_tmp = self->s.v.ammo_shells;
ADDRLP4 1028
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 74
;74:				}else
ADDRGP4 $32
JUMPV
LABELV $31
line 75
;75:				{
line 76
;76:					if( -ammo_tmp > self->s.v.ammo_shells )
ADDRLP4 1028
INDIRI4
NEGI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
LEF4 $35
line 77
;77:						ammo_tmp = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
ADDRGP4 $36
JUMPV
LABELV $35
line 79
;78:					else
;79:						ammo_tmp += self->s.v.ammo_shells;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
LABELV $36
line 80
;80:				}
LABELV $32
line 81
;81:				newmis->s.v.ammo_shells = ammo_tmp;
ADDRGP4 newmis
INDIRP4
CNSTI4 320
ADDP4
ADDRLP4 1028
INDIRI4
CVIF4 4
ASGNF4
line 82
;82:				break;
ADDRGP4 $28
JUMPV
LABELV $37
line 84
;83:			case 'n':
;84:				trap_CmdArgv( ++i, value, sizeof( value ) );
ADDRLP4 1096
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1024
ADDRLP4 1096
INDIRI4
ASGNI4
ADDRLP4 1096
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 85
;85:				ammo_tmp = atoi(value);
ADDRLP4 0
ARGP4
ADDRLP4 1100
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1100
INDIRI4
ASGNI4
line 86
;86:				if( ammo_tmp > 0 )
ADDRLP4 1028
INDIRI4
CNSTI4 0
LEI4 $38
line 87
;87:				{
line 88
;88:					if( ammo_tmp > self->s.v.ammo_nails )
ADDRLP4 1028
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
LEF4 $39
line 89
;89:						ammo_tmp = self->s.v.ammo_nails;
ADDRLP4 1028
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 90
;90:				}else
ADDRGP4 $39
JUMPV
LABELV $38
line 91
;91:				{
line 92
;92:					if( -ammo_tmp > self->s.v.ammo_nails )
ADDRLP4 1028
INDIRI4
NEGI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
LEF4 $42
line 93
;93:						ammo_tmp = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
ADDRGP4 $43
JUMPV
LABELV $42
line 95
;94:					else
;95:						ammo_tmp += self->s.v.ammo_nails;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
LABELV $43
line 96
;96:				}
LABELV $39
line 97
;97:				newmis->s.v.ammo_nails = ammo_tmp;
ADDRGP4 newmis
INDIRP4
CNSTI4 324
ADDP4
ADDRLP4 1028
INDIRI4
CVIF4 4
ASGNF4
line 98
;98:				break;
ADDRGP4 $28
JUMPV
LABELV $44
line 101
;99:				
;100:			case 'r':
;101:				trap_CmdArgv( ++i, value, sizeof( value ) );
ADDRLP4 1104
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1024
ADDRLP4 1104
INDIRI4
ASGNI4
ADDRLP4 1104
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 102
;102:				ammo_tmp = atoi(value);
ADDRLP4 0
ARGP4
ADDRLP4 1108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1108
INDIRI4
ASGNI4
line 103
;103:				if( ammo_tmp > 0 )
ADDRLP4 1028
INDIRI4
CNSTI4 0
LEI4 $45
line 104
;104:				{
line 105
;105:					if( ammo_tmp > self->s.v.ammo_rockets )
ADDRLP4 1028
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
LEF4 $46
line 106
;106:						ammo_tmp = self->s.v.ammo_rockets;
ADDRLP4 1028
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 107
;107:				}else
ADDRGP4 $46
JUMPV
LABELV $45
line 108
;108:				{
line 109
;109:					if( -ammo_tmp > self->s.v.ammo_rockets )
ADDRLP4 1028
INDIRI4
NEGI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
LEF4 $49
line 110
;110:						ammo_tmp = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
ADDRGP4 $50
JUMPV
LABELV $49
line 112
;111:					else
;112:						ammo_tmp += self->s.v.ammo_rockets;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
LABELV $50
line 113
;113:				}
LABELV $46
line 114
;114:				newmis->s.v.ammo_rockets = ammo_tmp;
ADDRGP4 newmis
INDIRP4
CNSTI4 328
ADDP4
ADDRLP4 1028
INDIRI4
CVIF4 4
ASGNF4
line 115
;115:				break;
ADDRGP4 $28
JUMPV
LABELV $51
line 117
;116:			case 'c':
;117:				trap_CmdArgv( ++i, value, sizeof( value ) );
ADDRLP4 1112
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1024
ADDRLP4 1112
INDIRI4
ASGNI4
ADDRLP4 1112
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 118
;118:				ammo_tmp = atoi(value);
ADDRLP4 0
ARGP4
ADDRLP4 1116
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1116
INDIRI4
ASGNI4
line 119
;119:				if( ammo_tmp > 0 )
ADDRLP4 1028
INDIRI4
CNSTI4 0
LEI4 $52
line 120
;120:				{
line 121
;121:					if( ammo_tmp > self->s.v.ammo_cells )
ADDRLP4 1028
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
LEF4 $53
line 122
;122:						ammo_tmp = self->s.v.ammo_cells;
ADDRLP4 1028
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 123
;123:				}else
ADDRGP4 $53
JUMPV
LABELV $52
line 124
;124:				{
line 125
;125:					if( -ammo_tmp > self->s.v.ammo_cells )
ADDRLP4 1028
INDIRI4
NEGI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
LEF4 $56
line 126
;126:						ammo_tmp = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
ADDRGP4 $57
JUMPV
LABELV $56
line 128
;127:					else
;128:						ammo_tmp += self->s.v.ammo_cells;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
LABELV $57
line 129
;129:				}
LABELV $53
line 130
;130:				newmis->s.v.ammo_cells = ammo_tmp;
ADDRGP4 newmis
INDIRP4
CNSTI4 332
ADDP4
ADDRLP4 1028
INDIRI4
CVIF4 4
ASGNF4
line 131
;131:				break;
LABELV $27
LABELV $28
line 134
;132:		}
;133:		
;134:	}
LABELV $24
line 62
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $26
ADDRLP4 1024
INDIRI4
ADDRLP4 1032
INDIRI4
LTI4 $23
line 136
;135:
;136:	if ( !( newmis->s.v.ammo_shells + newmis->s.v.ammo_nails + newmis->s.v.ammo_rockets + newmis->s.v.ammo_cells ) )
ADDRLP4 1072
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRLP4 1072
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ADDF4
ADDRLP4 1072
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ADDF4
ADDRLP4 1072
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDF4
CNSTF4 0
NEF4 $59
line 137
;137:	{
line 138
;138:		dremove( newmis );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 139
;139:		return;
ADDRGP4 $11
JUMPV
LABELV $59
line 141
;140:	}
;141:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 143
;142:
;143:	if ( newmis->s.v.ammo_shells )
ADDRGP4 newmis
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 0
EQF4 $62
line 144
;144:		self->s.v.ammo_shells = self->s.v.ammo_shells - newmis->s.v.ammo_shells;
ADDRLP4 1076
CNSTI4 320
ASGNI4
ADDRLP4 1080
ADDRGP4 self
INDIRP4
ADDRLP4 1076
INDIRI4
ADDP4
ASGNP4
ADDRLP4 1080
INDIRP4
ADDRLP4 1080
INDIRP4
INDIRF4
ADDRGP4 newmis
INDIRP4
ADDRLP4 1076
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $62
line 145
;145:	if ( newmis->s.v.ammo_nails )
ADDRGP4 newmis
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 0
EQF4 $64
line 146
;146:		self->s.v.ammo_nails = self->s.v.ammo_nails - newmis->s.v.ammo_nails;
ADDRLP4 1084
CNSTI4 324
ASGNI4
ADDRLP4 1088
ADDRGP4 self
INDIRP4
ADDRLP4 1084
INDIRI4
ADDP4
ASGNP4
ADDRLP4 1088
INDIRP4
ADDRLP4 1088
INDIRP4
INDIRF4
ADDRGP4 newmis
INDIRP4
ADDRLP4 1084
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $64
line 147
;147:	if ( newmis->s.v.ammo_rockets )
ADDRGP4 newmis
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 0
EQF4 $66
line 148
;148:		self->s.v.ammo_rockets = self->s.v.ammo_rockets - newmis->s.v.ammo_rockets;
ADDRLP4 1092
CNSTI4 328
ASGNI4
ADDRLP4 1096
ADDRGP4 self
INDIRP4
ADDRLP4 1092
INDIRI4
ADDP4
ASGNP4
ADDRLP4 1096
INDIRP4
ADDRLP4 1096
INDIRP4
INDIRF4
ADDRGP4 newmis
INDIRP4
ADDRLP4 1092
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $66
line 149
;149:	if ( newmis->s.v.ammo_cells )
ADDRGP4 newmis
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 0
EQF4 $68
line 150
;150:		self->s.v.ammo_cells = self->s.v.ammo_cells - newmis->s.v.ammo_cells;
ADDRLP4 1100
CNSTI4 332
ASGNI4
ADDRLP4 1104
ADDRGP4 self
INDIRP4
ADDRLP4 1100
INDIRI4
ADDP4
ASGNP4
ADDRLP4 1104
INDIRP4
ADDRLP4 1104
INDIRP4
INDIRF4
ADDRGP4 newmis
INDIRP4
ADDRLP4 1100
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $68
line 151
;151:	W_SetCurrentAmmo();
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 152
;152:	sound( self, CHAN_ITEM, "weapons/lock4.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $70
ARGP4
ADDRLP4 1108
CNSTF4 1065353216
ASGNF4
ADDRLP4 1108
INDIRF4
ARGF4
ADDRLP4 1108
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 153
;153:	increment_team_ammoboxes( self->team_no );
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRGP4 increment_team_ammoboxes
CALLV
pop
line 155
;154:
;155:	newmis->s.v.enemy = EDICT_TO_PROG( self );
ADDRGP4 newmis
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
line 156
;156:	newmis->s.v.health = g_globalvars.time;
ADDRGP4 newmis
INDIRP4
CNSTI4 296
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 157
;157:	newmis->s.v.weapon = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 0
ASGNF4
line 158
;158:	newmis->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 159
;159:	newmis->s.v.solid = SOLID_TRIGGER;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 160
;160:	newmis->s.v.classname = "ammobox";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $72
ASGNP4
line 161
;161:	newmis->team_no = self->team_no;
ADDRLP4 1112
CNSTI4 960
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 1112
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 1112
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 162
;162:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 163
;163:	if ( self->s.v.v_angle[0] )
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
INDIRF4
CNSTF4 0
EQF4 $73
line 164
;164:	{
line 165
;165:		VectorScale( g_globalvars.v_forward, 400, newmis->s.v.velocity );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1137180672
ARGF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 166
;166:		VectorScale( g_globalvars.v_up, 200, vtemp );
ADDRGP4 g_globalvars+240
ARGP4
CNSTF4 1128792064
ARGF4
ADDRLP4 1036
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 167
;167:		VectorAdd( vtemp, newmis->s.v.velocity, newmis->s.v.velocity );
ADDRLP4 1116
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 1116
INDIRP4
ADDRLP4 1036
INDIRF4
ADDRLP4 1116
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 1120
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
ASGNP4
ADDRLP4 1120
INDIRP4
ADDRLP4 1036+4
INDIRF4
ADDRLP4 1120
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 1124
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 1124
INDIRP4
ADDRLP4 1036+8
INDIRF4
ADDRLP4 1124
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 168
;168:	} else
ADDRGP4 $74
JUMPV
LABELV $73
line 169
;169:	{
line 170
;170:		aim( newmis->s.v.velocity );
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 aim
CALLV
pop
line 171
;171:		VectorScale( newmis->s.v.velocity, 400, newmis->s.v.velocity );
ADDRLP4 1116
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 1116
INDIRP4
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 1116
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 172
;172:		newmis->s.v.velocity[2] = 200;
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1128792064
ASGNF4
line 173
;173:	}
LABELV $74
line 174
;174:	SetVector( newmis->s.v.avelocity, 0, 300, 0 );
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
CNSTF4 1133903872
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 0
ASGNF4
line 175
;175:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 1116
CNSTF4 0
ASGNF4
ADDRLP4 1116
INDIRF4
ARGF4
ADDRLP4 1116
INDIRF4
ARGF4
ADDRLP4 1116
INDIRF4
ARGF4
ADDRLP4 1116
INDIRF4
ARGF4
ADDRLP4 1116
INDIRF4
ARGF4
ADDRLP4 1116
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 176
;176:	setorigin( newmis, PASSVEC3( self->s.v.origin ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 1120
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 1120
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 1120
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 1120
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 177
;177:	newmis->s.v.nextthink = g_globalvars.time + 30;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 178
;178:	newmis->s.v.think = ( func_t ) TeamFortress_AmmoboxRemove;//	SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TeamFortress_AmmoboxRemove
CVPU4 4
CVUI4 4
ASGNI4
line 179
;179:	newmis->s.v.touch = ( func_t ) TeamFortress_AmmoboxTouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 TeamFortress_AmmoboxTouch
CVPU4 4
CVUI4 4
ASGNI4
line 180
;180:	setmodel( newmis, "progs/backpack.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $80
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 181
;181:}
LABELV $11
endproc TeamFortress_Cmd_Discard 1128 28
export TeamFortress_Discard
proc TeamFortress_Discard 92 28
line 184
;182:
;183:void TeamFortress_Discard(  )
;184:{
line 188
;185:	int     ammo_tmp;
;186:	vec3_t  vtemp;
;187:
;188:	newmis = spawn(  );
ADDRLP4 16
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 16
INDIRP4
ASGNP4
line 190
;189:
;190:	if ( default_class_discard[self->playerclass][0] )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 default_class_discard
ADDP4
INDIRI4
CNSTI4 0
EQI4 $82
line 191
;191:		newmis->s.v.ammo_shells = self->s.v.ammo_shells;
ADDRLP4 20
CNSTI4 320
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ASGNF4
LABELV $82
line 192
;192:	if ( default_class_discard[self->playerclass][1] )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 default_class_discard+4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $84
line 193
;193:		newmis->s.v.ammo_nails = self->s.v.ammo_nails;
ADDRLP4 24
CNSTI4 324
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ASGNF4
LABELV $84
line 194
;194:	if ( default_class_discard[self->playerclass][2] )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 default_class_discard+8
ADDP4
INDIRI4
CNSTI4 0
EQI4 $87
line 195
;195:		newmis->s.v.ammo_rockets = self->s.v.ammo_rockets;
ADDRLP4 28
CNSTI4 328
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ASGNF4
LABELV $87
line 196
;196:	if ( default_class_discard[self->playerclass][3] )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 default_class_discard+12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $90
line 197
;197:		newmis->s.v.ammo_cells = self->s.v.ammo_cells;
ADDRLP4 32
CNSTI4 332
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
INDIRF4
ASGNF4
LABELV $90
line 199
;198:
;199:	ammo_tmp = self->discard_shells;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1508
ADDP4
INDIRI4
ASGNI4
line 200
;200:	if ( ammo_tmp >= 0 )
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $93
line 201
;201:	{
line 202
;202:		if ( ammo_tmp <= self->s.v.ammo_shells )
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
GTF4 $95
line 203
;203:			newmis->s.v.ammo_shells = self->s.v.ammo_shells -  ammo_tmp;
ADDRLP4 36
CNSTI4 320
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
SUBF4
ASGNF4
ADDRGP4 $96
JUMPV
LABELV $95
line 205
;204:		else
;205:			newmis->s.v.ammo_shells = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 320
ADDP4
CNSTF4 0
ASGNF4
LABELV $96
line 206
;206:	}
LABELV $93
line 207
;207:	ammo_tmp = self->discard_nails;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1512
ADDP4
INDIRI4
ASGNI4
line 208
;208:	if ( ammo_tmp >= 0 )
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $97
line 209
;209:	{
line 210
;210:		if ( ammo_tmp <= self->s.v.ammo_nails )
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
GTF4 $99
line 211
;211:			newmis->s.v.ammo_nails = self->s.v.ammo_nails - ammo_tmp;
ADDRLP4 36
CNSTI4 324
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
SUBF4
ASGNF4
ADDRGP4 $100
JUMPV
LABELV $99
line 213
;212:		else
;213:			newmis->s.v.ammo_nails = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 324
ADDP4
CNSTF4 0
ASGNF4
LABELV $100
line 214
;214:	}
LABELV $97
line 215
;215:	ammo_tmp = self->discard_rockets;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1516
ADDP4
INDIRI4
ASGNI4
line 216
;216:	if ( ammo_tmp >= 0 )
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $101
line 217
;217:	{
line 218
;218:		if ( ammo_tmp <= self->s.v.ammo_rockets )
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
GTF4 $103
line 219
;219:			newmis->s.v.ammo_rockets = self->s.v.ammo_rockets - ammo_tmp;
ADDRLP4 36
CNSTI4 328
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
SUBF4
ASGNF4
ADDRGP4 $104
JUMPV
LABELV $103
line 221
;220:		else
;221:			newmis->s.v.ammo_rockets = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 328
ADDP4
CNSTF4 0
ASGNF4
LABELV $104
line 222
;222:	}
LABELV $101
line 223
;223:	ammo_tmp = self->discard_cells;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1520
ADDP4
INDIRI4
ASGNI4
line 224
;224:	if ( ammo_tmp >= 0 )
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $105
line 225
;225:	{
line 226
;226:		if ( ammo_tmp <= self->s.v.ammo_cells )
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
GTF4 $107
line 227
;227:			newmis->s.v.ammo_cells = self->s.v.ammo_cells - ammo_tmp;
ADDRLP4 36
CNSTI4 332
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
SUBF4
ASGNF4
ADDRGP4 $108
JUMPV
LABELV $107
line 229
;228:		else
;229:			newmis->s.v.ammo_cells = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 332
ADDP4
CNSTF4 0
ASGNF4
LABELV $108
line 230
;230:	}
LABELV $105
line 233
;231:
;232:
;233:	if ( !( newmis->s.v.ammo_shells + newmis->s.v.ammo_nails + newmis->s.v.ammo_rockets + newmis->s.v.ammo_cells ) )
ADDRLP4 36
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ADDF4
ADDRLP4 36
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ADDF4
ADDRLP4 36
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDF4
CNSTF4 0
NEF4 $109
line 234
;234:	{
line 235
;235:		dremove( newmis );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 236
;236:		return;
ADDRGP4 $81
JUMPV
LABELV $109
line 238
;237:	}
;238:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 240
;239:
;240:	if ( newmis->s.v.ammo_shells )
ADDRGP4 newmis
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 0
EQF4 $112
line 241
;241:		self->s.v.ammo_shells = self->s.v.ammo_shells - newmis->s.v.ammo_shells;
ADDRLP4 40
CNSTI4 320
ASGNI4
ADDRLP4 44
ADDRGP4 self
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRGP4 newmis
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $112
line 242
;242:	if ( newmis->s.v.ammo_nails )
ADDRGP4 newmis
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 0
EQF4 $114
line 243
;243:		self->s.v.ammo_nails = self->s.v.ammo_nails - newmis->s.v.ammo_nails;
ADDRLP4 48
CNSTI4 324
ASGNI4
ADDRLP4 52
ADDRGP4 self
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRGP4 newmis
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $114
line 244
;244:	if ( newmis->s.v.ammo_rockets )
ADDRGP4 newmis
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 0
EQF4 $116
line 245
;245:		self->s.v.ammo_rockets = self->s.v.ammo_rockets - newmis->s.v.ammo_rockets;
ADDRLP4 56
CNSTI4 328
ASGNI4
ADDRLP4 60
ADDRGP4 self
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRGP4 newmis
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $116
line 246
;246:	if ( newmis->s.v.ammo_cells )
ADDRGP4 newmis
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 0
EQF4 $118
line 247
;247:		self->s.v.ammo_cells = self->s.v.ammo_cells - newmis->s.v.ammo_cells;
ADDRLP4 64
CNSTI4 332
ASGNI4
ADDRLP4 68
ADDRGP4 self
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRGP4 newmis
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $118
line 248
;248:	W_SetCurrentAmmo();
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 249
;249:	sound( self, CHAN_ITEM, "weapons/lock4.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $70
ARGP4
ADDRLP4 72
CNSTF4 1065353216
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 250
;250:	increment_team_ammoboxes( self->team_no );
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRGP4 increment_team_ammoboxes
CALLV
pop
line 252
;251:
;252:	newmis->s.v.enemy = EDICT_TO_PROG( self );
ADDRGP4 newmis
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
line 253
;253:	newmis->s.v.health = g_globalvars.time;
ADDRGP4 newmis
INDIRP4
CNSTI4 296
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 254
;254:	newmis->s.v.weapon = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 0
ASGNF4
line 255
;255:	newmis->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 256
;256:	newmis->s.v.solid = SOLID_TRIGGER;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 257
;257:	newmis->s.v.classname = "ammobox";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $72
ASGNP4
line 258
;258:	newmis->team_no = self->team_no;
ADDRLP4 76
CNSTI4 960
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 259
;259:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 260
;260:	if ( self->s.v.v_angle[0] )
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
INDIRF4
CNSTF4 0
EQF4 $121
line 261
;261:	{
line 262
;262:		VectorScale( g_globalvars.v_forward, 400, newmis->s.v.velocity );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1137180672
ARGF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 263
;263:		VectorScale( g_globalvars.v_up, 200, vtemp );
ADDRGP4 g_globalvars+240
ARGP4
CNSTF4 1128792064
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 264
;264:		VectorAdd( vtemp, newmis->s.v.velocity, newmis->s.v.velocity );
ADDRLP4 80
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 4
INDIRF4
ADDRLP4 80
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 4+4
INDIRF4
ADDRLP4 84
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 4+8
INDIRF4
ADDRLP4 88
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 265
;265:	} else
ADDRGP4 $122
JUMPV
LABELV $121
line 266
;266:	{
line 267
;267:		aim( newmis->s.v.velocity );
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 aim
CALLV
pop
line 268
;268:		VectorScale( newmis->s.v.velocity, 400, newmis->s.v.velocity );
ADDRLP4 80
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 269
;269:		newmis->s.v.velocity[2] = 200;
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1128792064
ASGNF4
line 270
;270:	}
LABELV $122
line 271
;271:	SetVector( newmis->s.v.avelocity, 0, 300, 0 );
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
CNSTF4 1133903872
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 0
ASGNF4
line 272
;272:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 80
CNSTF4 0
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 273
;273:	setorigin( newmis, PASSVEC3( self->s.v.origin ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 84
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 84
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 274
;274:	newmis->s.v.nextthink = g_globalvars.time + 30;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 275
;275:	newmis->s.v.think = ( func_t ) TeamFortress_AmmoboxRemove;//	SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TeamFortress_AmmoboxRemove
CVPU4 4
CVUI4 4
ASGNI4
line 276
;276:	newmis->s.v.touch = ( func_t ) TeamFortress_AmmoboxTouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 TeamFortress_AmmoboxTouch
CVPU4 4
CVUI4 4
ASGNI4
line 277
;277:	setmodel( newmis, "progs/backpack.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $80
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 278
;278:}
LABELV $81
endproc TeamFortress_Discard 92 28
export TeamFortress_SaveMe
proc TeamFortress_SaveMe 48 20
line 281
;279:
;280:void TeamFortress_SaveMe(  )
;281:{
line 285
;282:	gedict_t *te;
;283:	gedict_t *tl;
;284:
;285:	if ( self->last_saveme_sound < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 1084
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $129
line 286
;286:	{
line 287
;287:		if ( g_random(  ) < 0.8 )
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 8
INDIRF4
CNSTF4 1061997773
GEF4 $132
line 288
;288:			sound( self, CHAN_WEAPON, "speech/saveme1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $134
ARGP4
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
ADDRGP4 $133
JUMPV
LABELV $132
line 290
;289:		else
;290:			sound( self, CHAN_WEAPON, "speech/saveme2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $135
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
LABELV $133
line 291
;291:		self->last_saveme_sound = g_globalvars.time + 4;
ADDRGP4 self
INDIRP4
CNSTI4 1084
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1082130432
ADDF4
ASGNF4
line 292
;292:	}
LABELV $129
line 293
;293:	for ( te = world; ( te = trap_find( te, FOFS( s.v.classname ) , "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $140
JUMPV
LABELV $137
line 294
;294:	{
line 295
;295:		if ( self == te || te->playerclass == PC_MEDIC || te->playerclass == PC_ENGINEER
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $146
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 5
EQI4 $146
ADDRLP4 12
INDIRI4
CNSTI4 9
EQI4 $146
ADDRLP4 12
INDIRI4
CNSTI4 8
NEI4 $142
LABELV $146
line 297
;296:		     || te->playerclass == PC_SPY )
;297:		{
line 298
;298:			if ( ( self->team_no && TeamFortress_isTeamsAllied(te->team_no , self->team_no) ) || te->playerclass == PC_SPY )
ADDRLP4 16
CNSTI4 960
ASGNI4
ADDRLP4 20
ADDRGP4 self
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $150
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $149
LABELV $150
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $147
LABELV $149
line 299
;299:			{
line 300
;300:				if ( visible( te ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 visible
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $151
line 301
;301:				{
line 302
;302:					g_globalvars.msg_entity = EDICT_TO_PROG( te );
ADDRGP4 g_globalvars+316
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 303
;303:					tl = spawn(  );
ADDRLP4 32
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
ASGNP4
line 304
;304:					VectorCopy( self->s.v.origin, tl->s.v.origin );
ADDRLP4 36
CNSTI4 156
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 40
CNSTI4 160
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 44
CNSTI4 164
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 305
;305:					tl->s.v.origin[2] += 32;
ADDRLP4 36
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 306
;306:					trap_WriteByte( MSG_ONE, SVC_TEMPENTITY );
CNSTI4 1
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 307
;307:					trap_WriteByte( MSG_ONE, TE_LIGHTNING3 );
CNSTI4 1
ARGI4
CNSTI4 9
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 308
;308:					WriteEntity( MSG_ONE, tl );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 WriteEntity
CALLV
pop
line 309
;309:					trap_WriteCoord( MSG_ONE, tl->s.v.origin[0] );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 310
;310:					trap_WriteCoord( MSG_ONE, tl->s.v.origin[1] );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 311
;311:					trap_WriteCoord( MSG_ONE, tl->s.v.origin[2] + 24 );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1103101952
ADDF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 312
;312:					trap_WriteCoord( MSG_ONE, self->s.v.origin[0] );
CNSTI4 1
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
line 313
;313:					trap_WriteCoord( MSG_ONE, self->s.v.origin[1] );
CNSTI4 1
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
line 314
;314:					trap_WriteCoord( MSG_ONE, self->s.v.origin[2] );
CNSTI4 1
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
line 315
;315:					dremove( tl );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 316
;316:				}
LABELV $151
line 317
;317:			}
LABELV $147
line 318
;318:		}
LABELV $142
line 319
;319:	}
LABELV $138
line 293
LABELV $140
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $141
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
NEU4 $137
line 320
;320:}
LABELV $128
endproc TeamFortress_SaveMe 48 20
export TeamFortress_ReloadCurrentWeapon
proc TeamFortress_ReloadCurrentWeapon 36 12
line 324
;321:
;322:
;323:void TeamFortress_ReloadCurrentWeapon(  )
;324:{
line 328
;325:	float   rt;
;326:	gedict_t *tWeapon;
;327:
;328:	if ( self->s.v.weaponmodel == "progs/proxgren.mdl" ) {
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 $157
CVPU4 4
NEU4 $155
line 329
;329:		if ( self->oldweaponmodel != "" ) {
ADDRGP4 self
INDIRP4
CNSTI4 1008
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 $160
CVPU4 4
EQU4 $158
line 330
;330:			self->tfstate = (self->tfstate - ( self->tfstate & TFSTATE_RELOADING ) );
ADDRLP4 8
ADDRGP4 self
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
CNSTI4 2
BANDI4
SUBI4
ASGNI4
line 331
;331:		}
LABELV $158
line 332
;332:		self->s.v.weaponmodel = self->oldweaponmodel;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 308
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 1008
ADDP4
INDIRP4
ASGNP4
line 333
;333:		self->s.v.currentammo = self->oldcurrentammo;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 1012
ADDP4
INDIRF4
ASGNF4
line 334
;334:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 335
;335:	}
LABELV $155
line 336
;336:	if ( self->tfstate & TFSTATE_RELOADING )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $162
line 337
;337:		return;
ADDRGP4 $154
JUMPV
LABELV $162
line 338
;338:	if ( self->current_weapon == WEAP_SHOTGUN )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 128
NEI4 $164
line 339
;339:	{
line 340
;340:		if ( !self->s.v.ammo_shells )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 0
NEF4 $166
line 341
;341:		{
line 342
;342:			G_sprint( self, 2, "out of shells.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $168
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 343
;343:			return;
ADDRGP4 $154
JUMPV
LABELV $166
line 345
;344:		}
;345:		if ( !self->reload_shotgun )
ADDRGP4 self
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
CNSTI4 0
NEI4 $169
line 346
;346:		{
line 347
;347:			G_sprint( self, 2, "clip full.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $171
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 348
;348:			return;
ADDRGP4 $154
JUMPV
LABELV $169
line 350
;349:		}
;350:		if ( 8 - self->reload_shotgun == self->s.v.ammo_shells )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
CNSTI4 8
ADDRLP4 8
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
NEF4 $172
line 351
;351:		{
line 352
;352:			G_sprint( self, 2, "all shells are in the clip.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $174
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 353
;353:			return;
ADDRGP4 $154
JUMPV
LABELV $172
line 355
;354:		}
;355:		if ( self->reload_shotgun < self->s.v.ammo_shells )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
GEF4 $175
line 356
;356:		{
line 357
;357:			Attack_Finished( 0.4 );
CNSTF4 1053609165
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 358
;358:			rt = ( 8 - (float)self->reload_shotgun ) / 8;
ADDRLP4 16
CNSTF4 1090519040
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
CVIF4 4
SUBF4
ADDRLP4 16
INDIRF4
DIVF4
ASGNF4
line 359
;359:			rt = 2 - 2 * rt;
ADDRLP4 20
CNSTF4 1073741824
ASGNF4
ADDRLP4 4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
SUBF4
ASGNF4
line 360
;360:			self->reload_shotgun = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1060
ADDP4
CNSTI4 0
ASGNI4
line 361
;361:			if ( self->s.v.ammo_shells < 8 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1090519040
GEF4 $177
line 362
;362:				self->reload_shotgun = 8 - self->s.v.ammo_shells;
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 1060
ADDP4
CNSTF4 1090519040
ADDRLP4 24
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
SUBF4
CVFI4 4
ASGNI4
LABELV $177
line 363
;363:			G_sprint( self, 2, "reloading...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $179
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 364
;364:			self->tfstate = self->tfstate | TFSTATE_RELOADING;
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
CNSTI4 2
BORI4
ASGNI4
line 365
;365:			tWeapon = spawn(  );
ADDRLP4 32
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 366
;366:			tWeapon->s.v.owner = EDICT_TO_PROG(self);
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
line 367
;367:			tWeapon->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $180
ASGNP4
line 368
;368:			tWeapon->s.v.nextthink = g_globalvars.time + rt;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 369
;369:			tWeapon->s.v.think = ( func_t ) W_Reload_shotgun;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 W_Reload_shotgun
CVPU4 4
CVUI4 4
ASGNI4
line 370
;370:			self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $160
ASGNP4
line 371
;371:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 372
;372:		} else
ADDRGP4 $176
JUMPV
LABELV $175
line 373
;373:			G_sprint( self, 2, "not enough ammo to reload\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $182
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $176
line 374
;374:	}
LABELV $164
line 375
;375:	if ( self->current_weapon == WEAP_SUPER_SHOTGUN )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 256
NEI4 $183
line 376
;376:	{
line 377
;377:		if ( !self->s.v.ammo_shells )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 0
NEF4 $185
line 378
;378:		{
line 379
;379:			G_sprint( self, 2, "out of shells.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $168
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 380
;380:			return;
ADDRGP4 $154
JUMPV
LABELV $185
line 382
;381:		}
;382:		if ( !self->reload_super_shotgun )
ADDRGP4 self
INDIRP4
CNSTI4 1064
ADDP4
INDIRI4
CNSTI4 0
NEI4 $187
line 383
;383:		{
line 384
;384:			G_sprint( self, 2, "clip full.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $171
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 385
;385:			return;
ADDRGP4 $154
JUMPV
LABELV $187
line 387
;386:		}
;387:		if ( 16 - self->reload_super_shotgun == self->s.v.ammo_shells )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
CNSTI4 16
ADDRLP4 8
INDIRP4
CNSTI4 1064
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
NEF4 $189
line 388
;388:		{
line 389
;389:			G_sprint( self, 2, "all shells are in the clip.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $174
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 390
;390:			return;
ADDRGP4 $154
JUMPV
LABELV $189
line 392
;391:		}
;392:		if ( self->reload_super_shotgun < self->s.v.ammo_shells )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1064
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
GEF4 $191
line 393
;393:		{
line 394
;394:			Attack_Finished( 0.7 );
CNSTF4 1060320051
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 395
;395:			rt = ( 16 - (float)self->reload_super_shotgun ) / 16;
ADDRLP4 16
CNSTF4 1098907648
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 1064
ADDP4
INDIRI4
CVIF4 4
SUBF4
ADDRLP4 16
INDIRF4
DIVF4
ASGNF4
line 396
;396:			rt = 3 - 3 * rt;
ADDRLP4 20
CNSTF4 1077936128
ASGNF4
ADDRLP4 4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
SUBF4
ASGNF4
line 397
;397:			self->reload_super_shotgun = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1064
ADDP4
CNSTI4 0
ASGNI4
line 398
;398:			if ( self->s.v.ammo_shells < 16 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1098907648
GEF4 $193
line 399
;399:				self->reload_super_shotgun = 16 - self->s.v.ammo_shells;
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 1064
ADDP4
CNSTF4 1098907648
ADDRLP4 24
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
SUBF4
CVFI4 4
ASGNI4
LABELV $193
line 400
;400:			G_sprint( self, 2, "reloading...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $179
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 401
;401:			self->tfstate = self->tfstate | TFSTATE_RELOADING;
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
CNSTI4 2
BORI4
ASGNI4
line 402
;402:			tWeapon = spawn(  );
ADDRLP4 32
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 403
;403:			tWeapon->s.v.owner = EDICT_TO_PROG(self);
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
line 404
;404:			tWeapon->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $180
ASGNP4
line 405
;405:			tWeapon->s.v.nextthink = g_globalvars.time + rt;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 406
;406:			tWeapon->s.v.think = ( func_t ) W_Reload_super_shotgun;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 W_Reload_super_shotgun
CVPU4 4
CVUI4 4
ASGNI4
line 407
;407:			self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $160
ASGNP4
line 408
;408:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 409
;409:		} else
ADDRGP4 $192
JUMPV
LABELV $191
line 410
;410:			G_sprint( self, 2, "not enough ammo to reload\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $182
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $192
line 411
;411:	}
LABELV $183
line 412
;412:	if ( self->current_weapon == WEAP_GRENADE_LAUNCHER )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2048
NEI4 $196
line 413
;413:	{
line 414
;414:		if ( !self->s.v.ammo_rockets )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 0
NEF4 $198
line 415
;415:		{
line 416
;416:			G_sprint( self, 2, "out of grenades.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $200
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 417
;417:			return;
ADDRGP4 $154
JUMPV
LABELV $198
line 419
;418:		}
;419:		if ( !self->reload_grenade_launcher )
ADDRGP4 self
INDIRP4
CNSTI4 1068
ADDP4
INDIRI4
CNSTI4 0
NEI4 $201
line 420
;420:		{
line 421
;421:			G_sprint( self, 2, "clip full.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $171
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 422
;422:			return;
ADDRGP4 $154
JUMPV
LABELV $201
line 424
;423:		}
;424:		if ( 6 - self->reload_grenade_launcher == self->s.v.ammo_rockets )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
CNSTI4 6
ADDRLP4 8
INDIRP4
CNSTI4 1068
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
NEF4 $203
line 425
;425:		{
line 426
;426:			G_sprint( self, 2, "all grenades are in the clip.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $205
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 427
;427:			return;
ADDRGP4 $154
JUMPV
LABELV $203
line 429
;428:		}
;429:		if ( self->reload_grenade_launcher < self->s.v.ammo_rockets )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1068
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
GEF4 $206
line 430
;430:		{
line 431
;431:			Attack_Finished( 0.6 );
CNSTF4 1058642330
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 432
;432:			rt = ( 6 - (float)self->reload_grenade_launcher ) / 6;
ADDRLP4 16
CNSTF4 1086324736
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 1068
ADDP4
INDIRI4
CVIF4 4
SUBF4
ADDRLP4 16
INDIRF4
DIVF4
ASGNF4
line 433
;433:			rt = 4 - 4 * rt;
ADDRLP4 20
CNSTF4 1082130432
ASGNF4
ADDRLP4 4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
SUBF4
ASGNF4
line 434
;434:			self->reload_grenade_launcher = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1068
ADDP4
CNSTI4 0
ASGNI4
line 435
;435:			if ( self->s.v.ammo_rockets < 6 )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1086324736
GEF4 $208
line 436
;436:				self->reload_grenade_launcher = 6 - self->s.v.ammo_rockets;
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 1068
ADDP4
CNSTF4 1086324736
ADDRLP4 24
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
SUBF4
CVFI4 4
ASGNI4
LABELV $208
line 437
;437:			G_sprint( self, 2, "reloading...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $179
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 438
;438:			self->tfstate = self->tfstate | TFSTATE_RELOADING;
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
CNSTI4 2
BORI4
ASGNI4
line 439
;439:			tWeapon = spawn(  );
ADDRLP4 32
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 440
;440:			tWeapon->s.v.owner = EDICT_TO_PROG(self);
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
line 441
;441:			tWeapon->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $180
ASGNP4
line 442
;442:			tWeapon->s.v.nextthink = g_globalvars.time + rt;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 443
;443:			tWeapon->s.v.think = ( func_t ) W_Reload_grenade_launcher;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 W_Reload_grenade_launcher
CVPU4 4
CVUI4 4
ASGNI4
line 444
;444:			self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $160
ASGNP4
line 445
;445:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 446
;446:		} else
ADDRGP4 $207
JUMPV
LABELV $206
line 447
;447:			G_sprint( self, 2, "not enough ammo to reload\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $182
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $207
line 448
;448:	}
LABELV $196
line 449
;449:	if ( self->current_weapon == WEAP_ROCKET_LAUNCHER )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 8192
NEI4 $211
line 450
;450:	{
line 451
;451:		if ( !self->s.v.ammo_rockets )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 0
NEF4 $213
line 452
;452:		{
line 453
;453:			G_sprint( self, 2, "out of rockets.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $215
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 454
;454:			return;
ADDRGP4 $154
JUMPV
LABELV $213
line 456
;455:		}
;456:		if ( !self->reload_rocket_launcher )
ADDRGP4 self
INDIRP4
CNSTI4 1072
ADDP4
INDIRI4
CNSTI4 0
NEI4 $216
line 457
;457:		{
line 458
;458:			G_sprint( self, 2, "clip full.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $171
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 459
;459:			return;
ADDRGP4 $154
JUMPV
LABELV $216
line 461
;460:		}
;461:		if ( 4 - self->reload_rocket_launcher == self->s.v.ammo_rockets )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
CNSTI4 4
ADDRLP4 8
INDIRP4
CNSTI4 1072
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
NEF4 $218
line 462
;462:		{
line 463
;463:			G_sprint( self, 2, "all rockets are in the clip.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $220
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 464
;464:			return;
ADDRGP4 $154
JUMPV
LABELV $218
line 466
;465:		}
;466:		if ( self->reload_rocket_launcher < self->s.v.ammo_rockets )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1072
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
GEF4 $221
line 467
;467:		{
line 468
;468:			Attack_Finished( 0.8 );
CNSTF4 1061997773
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 469
;469:			rt = ( 4 - (float)self->reload_rocket_launcher ) / 4;
ADDRLP4 16
CNSTF4 1082130432
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 1072
ADDP4
INDIRI4
CVIF4 4
SUBF4
ADDRLP4 16
INDIRF4
DIVF4
ASGNF4
line 470
;470:			rt = 5 - 5 * rt;
ADDRLP4 20
CNSTF4 1084227584
ASGNF4
ADDRLP4 4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
SUBF4
ASGNF4
line 471
;471:			self->reload_rocket_launcher = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1072
ADDP4
CNSTI4 0
ASGNI4
line 472
;472:			if ( self->s.v.ammo_rockets < 4 )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1082130432
GEF4 $223
line 473
;473:				self->reload_rocket_launcher = 4 - self->s.v.ammo_rockets;
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 1072
ADDP4
CNSTF4 1082130432
ADDRLP4 24
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
SUBF4
CVFI4 4
ASGNI4
LABELV $223
line 474
;474:			G_sprint( self, 2, "reloading...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $179
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 475
;475:			self->tfstate = self->tfstate | TFSTATE_RELOADING;
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
CNSTI4 2
BORI4
ASGNI4
line 476
;476:			tWeapon = spawn(  );
ADDRLP4 32
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 477
;477:			tWeapon->s.v.owner = EDICT_TO_PROG(self);
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
line 478
;478:			tWeapon->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $180
ASGNP4
line 479
;479:			tWeapon->s.v.nextthink = g_globalvars.time + rt;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 480
;480:			tWeapon->s.v.think = ( func_t ) W_Reload_rocket_launcher;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 W_Reload_rocket_launcher
CVPU4 4
CVUI4 4
ASGNI4
line 481
;481:			self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $160
ASGNP4
line 482
;482:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 483
;483:		}
LABELV $221
line 484
;484:	}
LABELV $211
line 485
;485:}
LABELV $154
endproc TeamFortress_ReloadCurrentWeapon 36 12
export TeamFortress_ID_Player
proc TeamFortress_ID_Player 56 20
line 488
;486:
;487:void TeamFortress_ID_Player( gedict_t * trace_ent )
;488:{
line 491
;489:	const char   *cls;
;490:
;491:	if ( self->team_no && TeamFortress_isTeamsAllied(self->team_no , trace_ent->team_no) )
ADDRLP4 4
CNSTI4 960
ASGNI4
ADDRLP4 8
ADDRGP4 self
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $227
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $227
line 492
;492:	{
line 493
;493:		cls = TeamFortress_GetClassName( trace_ent->playerclass );
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 TeamFortress_GetClassName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 494
;494:		switch ( self->playerclass )
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
CNSTI4 5
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $232
ADDRLP4 20
INDIRI4
ADDRLP4 28
INDIRI4
LTI4 $229
LABELV $237
ADDRLP4 20
INDIRI4
CNSTI4 9
EQI4 $234
ADDRGP4 $229
JUMPV
line 495
;495:		{
LABELV $232
line 497
;496:		case PC_MEDIC:
;497:			G_centerprint( self, "\n\n\n\n%s\nFriendly %s\n%.0f health\n", trace_ent->s.v.netname, cls,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_centerprint
CALLV
pop
line 499
;498:				       trace_ent->s.v.health );
;499:			break;
ADDRGP4 $226
JUMPV
LABELV $234
line 501
;500:		case PC_ENGINEER:
;501:			G_centerprint( self, "\n\n\n\n%s\nFriendly %s\n%.0f armor\n", trace_ent->s.v.netname, cls,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $235
ARGP4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_centerprint
CALLV
pop
line 503
;502:				       trace_ent->s.v.armorvalue );
;503:			break;
ADDRGP4 $226
JUMPV
LABELV $229
line 505
;504:		default:
;505:			G_centerprint( self, "\n\n\n\n%s\nFriendly %s\n", trace_ent->s.v.netname, cls );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $236
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 506
;506:			break;
line 508
;507:		}
;508:		return;
ADDRGP4 $226
JUMPV
LABELV $227
line 511
;509:	}
;510://enemy
;511:	if ( trace_ent->playerclass != PC_SPY )
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
EQI4 $238
line 512
;512:	{
line 513
;513:		cls = TeamFortress_GetClassName( trace_ent->playerclass );
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 TeamFortress_GetClassName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 514
;514:		G_centerprint( self, "\n\n\n\n%s\nEnemy %s\n\n", trace_ent->s.v.netname, cls );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $240
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 515
;515:		return;
ADDRGP4 $226
JUMPV
LABELV $238
line 518
;516:	}
;517://enemy spy
;518:	cls = TeamFortress_GetClassName( trace_ent->undercover_skin );
ADDRFP4 0
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 TeamFortress_GetClassName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 519
;519:	if ( self->team_no && TeamFortress_isTeamsAllied( self->team_no , trace_ent->undercover_team) )
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $241
ADDRLP4 20
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $241
line 520
;520:	{
line 521
;521:		switch ( self->playerclass )
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
CNSTI4 5
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $246
ADDRLP4 28
INDIRI4
ADDRLP4 36
INDIRI4
LTI4 $243
LABELV $257
ADDRLP4 28
INDIRI4
CNSTI4 9
EQI4 $250
ADDRGP4 $243
JUMPV
line 522
;522:		{
LABELV $246
line 524
;523:		case PC_MEDIC:
;524:			if ( trace_ent->undercover_skin )
ADDRFP4 0
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
CNSTI4 0
EQI4 $247
line 525
;525:				G_centerprint( self, "\n\n\n\n%s\nFriendly %s\n%.0f health\n",
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 1412
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_centerprint
CALLV
pop
ADDRGP4 $226
JUMPV
LABELV $247
line 528
;526:					       trace_ent->undercover_name, cls, trace_ent->s.v.health );
;527:			else
;528:				G_centerprint( self, "\n\n\n\n%s\nFriendly Spy\n%.0f health\n",
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $249
ARGP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 1412
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_centerprint
CALLV
pop
line 530
;529:					       trace_ent->undercover_name, trace_ent->s.v.health );
;530:			break;
ADDRGP4 $226
JUMPV
LABELV $250
line 532
;531:		case PC_ENGINEER:
;532:			if ( trace_ent->undercover_skin )
ADDRFP4 0
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
CNSTI4 0
EQI4 $251
line 533
;533:				G_centerprint( self, "\n\n\n\n%s\nFriendly %s\n%.0f armor\n",
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $235
ARGP4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 1412
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_centerprint
CALLV
pop
ADDRGP4 $226
JUMPV
LABELV $251
line 536
;534:					       trace_ent->undercover_name, cls, trace_ent->s.v.armorvalue );
;535:			else
;536:				G_centerprint( self, "\n\n\n\n%s\nFriendly Spy\n%.0f armor\n",
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $253
ARGP4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 1412
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_centerprint
CALLV
pop
line 538
;537:					       trace_ent->undercover_name, trace_ent->s.v.armorvalue );
;538:			break;
ADDRGP4 $226
JUMPV
LABELV $243
line 540
;539:		default:
;540:			if ( trace_ent->undercover_skin )
ADDRFP4 0
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
CNSTI4 0
EQI4 $254
line 541
;541:				G_centerprint( self, "\n\n\n\n%s\nFriendly %s\n", trace_ent->undercover_name, cls );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $236
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1412
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
ADDRGP4 $226
JUMPV
LABELV $254
line 543
;542:			else
;543:				G_centerprint( self, "\n\n\n\n%s\nFriendly Spy\n", trace_ent->undercover_name );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $256
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1412
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 544
;544:			break;
line 546
;545:		}
;546:		return;
ADDRGP4 $226
JUMPV
LABELV $241
line 548
;547:	}
;548:	if ( trace_ent->undercover_name )
ADDRFP4 0
INDIRP4
CNSTI4 1412
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $258
line 549
;549:	{
line 550
;550:		if ( trace_ent->undercover_skin )
ADDRFP4 0
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
CNSTI4 0
EQI4 $260
line 551
;551:			G_centerprint( self, "\n\n\n\n%s\nEnemy %s\n", trace_ent->undercover_name, cls );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $262
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1412
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
ADDRGP4 $259
JUMPV
LABELV $260
line 553
;552:		else
;553:			G_centerprint( self, "\n\n\n\n%s\nEnemy Spy\n", trace_ent->undercover_name );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $263
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1412
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 554
;554:	} else
ADDRGP4 $259
JUMPV
LABELV $258
line 555
;555:	{
line 556
;556:		if ( trace_ent->undercover_skin )
ADDRFP4 0
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
CNSTI4 0
EQI4 $264
line 557
;557:			G_centerprint( self, "\n\n\n\n%s\nEnemy %s\n", trace_ent->s.v.netname, cls );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $262
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
ADDRGP4 $265
JUMPV
LABELV $264
line 559
;558:		else
;559:			G_centerprint( self, "\n\n\n\n%s\nEnemy Spy\n", trace_ent->s.v.netname );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $263
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
LABELV $265
line 560
;560:	}
LABELV $259
line 561
;561:}
LABELV $226
endproc TeamFortress_ID_Player 56 20
export TeamFortress_ID_Sentry
proc TeamFortress_ID_Sentry 20 28
line 563
;562:void TeamFortress_ID_Sentry( gedict_t * te )
;563:{
line 565
;564:
;565:	if ( self == te->real_owner )
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
NEU4 $267
line 566
;566:	{
line 567
;567:		if ( self->playerclass == PC_ENGINEER || tg_data.tg_enabled )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
EQI4 $271
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $269
LABELV $271
line 568
;568:		{
line 569
;569:			if ( te->s.v.weapon != 3 )
ADDRFP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
EQF4 $272
line 570
;570:				G_centerprint( self, "\n\n\nYour SentryGun Level %.0f\nHealth: %.0f\nShells: %.0f\n",
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $274
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_centerprint
CALLV
pop
ADDRGP4 $268
JUMPV
LABELV $272
line 573
;571:					       te->s.v.weapon, te->s.v.health, te->s.v.ammo_shells );
;572:			else
;573:				G_centerprint( self,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $275
ARGP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_centerprint
CALLV
pop
line 577
;574:					       "\n\n\nYour SentryGun Level %.0f\nHealth: %.0f\nShells: %.0f Rockets: %.0f\n",
;575:					       te->s.v.weapon, te->s.v.health, te->s.v.ammo_shells,
;576:					       te->s.v.ammo_rockets );
;577:		} else
ADDRGP4 $268
JUMPV
LABELV $269
line 578
;578:			G_centerprint( self, "\n\n\n\nYour SentryGun\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $276
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 579
;579:	} else
ADDRGP4 $268
JUMPV
LABELV $267
line 580
;580:	{
line 581
;581:		if ( !teamplay )
ADDRGP4 teamplay
INDIRI4
CNSTI4 0
NEI4 $277
line 582
;582:			G_centerprint( self, "\n\n\n\nSentrygun made by\n%s\n", te->real_owner->s.v.netname );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $279
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
ADDRGP4 $278
JUMPV
LABELV $277
line 584
;583:		else
;584:		{
line 585
;585:			if ( self->team_no && TeamFortress_isTeamsAllied(self->team_no , te->team_no) )
ADDRLP4 0
CNSTI4 960
ASGNI4
ADDRLP4 4
ADDRGP4 self
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $280
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $280
line 586
;586:			{
line 587
;587:				if ( self->playerclass == PC_ENGINEER )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
NEI4 $282
line 588
;588:				{
line 589
;589:					if ( te->s.v.weapon != 3 )
ADDRFP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
EQF4 $284
line 590
;590:						G_centerprint( self,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $286
ARGP4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_centerprint
CALLV
pop
ADDRGP4 $281
JUMPV
LABELV $284
line 595
;591:							       "\n\n\nFriendly Sentrygun Level %.0f made by\n%s\nHealth: %.0f\nShells: %.0f\n",
;592:							       te->s.v.weapon, te->real_owner->s.v.netname,
;593:							       te->s.v.health, te->s.v.ammo_shells );
;594:					else
;595:					{
line 596
;596:						G_centerprint( self,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $287
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_centerprint
CALLV
pop
line 601
;597:							       "\n\n\nFriendly Sentrygun Level %.0f made by\n%s\nHealth: %.0f\nShells: %.0f Rockets: %.0f\n",
;598:							       te->s.v.weapon, te->real_owner->s.v.netname,
;599:							       te->s.v.health, te->s.v.ammo_shells,
;600:							       te->s.v.ammo_rockets );
;601:					}
line 602
;602:				} else
ADDRGP4 $281
JUMPV
LABELV $282
line 603
;603:					G_centerprint( self, "\n\n\n\nFriendly Sentrygun made by\n%s\n",
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $288
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 605
;604:						       te->real_owner->s.v.netname );
;605:			} else
ADDRGP4 $281
JUMPV
LABELV $280
line 606
;606:				G_centerprint( self, "\n\n\n\nEnemy Sentrygun made by\n%s\n",
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $289
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
LABELV $281
line 608
;607:					       te->real_owner->s.v.netname );
;608:		}
LABELV $278
line 609
;609:	}
LABELV $268
line 611
;610:
;611:}
LABELV $266
endproc TeamFortress_ID_Sentry 20 28
export TeamFortress_ID
proc TeamFortress_ID 76 36
line 613
;612:void TeamFortress_ID(  )
;613:{
line 616
;614:	vec3_t  src, end;
;615:	gedict_t *te, *trace_ent;
;616:	if ( tf_data.new_flash && ( self->FlashTime >= ( 24 - NEW_FLASH_START_TIME ) ) )
ADDRGP4 tf_data+48
INDIRI4
CNSTI4 0
EQI4 $291
ADDRGP4 self
INDIRP4
CNSTI4 1472
ADDP4
INDIRF4
CNSTF4 1102263091
LTF4 $291
line 617
;617:		return;
ADDRGP4 $290
JUMPV
LABELV $291
line 619
;618:
;619:	if((self->tfstate & TFSTATE_HALLUCINATING) && (tf_data.new_gas & GAS_MASK_DISABLE_ID) )
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
ADDRLP4 32
INDIRI4
EQI4 $294
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 128
BANDI4
ADDRLP4 32
INDIRI4
EQI4 $294
line 620
;620:		return;
ADDRGP4 $290
JUMPV
LABELV $294
line 622
;621:
;622:	if( self->current_menu > MENU_DEFAULT)
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
CNSTI4 1
LEI4 $297
line 623
;623:		return;
ADDRGP4 $290
JUMPV
LABELV $297
line 625
;624:
;625:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 626
;626:	VectorScale( g_globalvars.v_forward, 10, src );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1092616192
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 627
;627:	VectorAdd( src, self->s.v.origin, src );
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
line 628
;628:	src[2] = self->s.v.absmin[2] + self->s.v.size[2] * 0.7;
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 36
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1060320051
ADDRLP4 36
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 629
;629:	VectorScale( g_globalvars.v_forward, 2048, end );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1157627904
ARGF4
ADDRLP4 16
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 630
;630:	VectorAdd( end, src, end );
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 631
;631:	traceline( PASSVEC3( src ), PASSVEC3( end ), 0, self );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16+4
INDIRF4
ARGF4
ADDRLP4 16+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 632
;632:	trace_ent = PROG_TO_EDICT( g_globalvars.trace_ent );
ADDRLP4 12
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 634
;633:
;634:	if ( trace_ent == world )
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $317
line 635
;635:		return;
ADDRGP4 $290
JUMPV
LABELV $317
line 637
;636:
;637:	if ( VectorCompare( trace_ent->s.v.origin, world->s.v.origin ) )
ADDRLP4 40
CNSTI4 156
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ARGP4
ADDRGP4 world
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $319
line 638
;638:		return;
ADDRGP4 $290
JUMPV
LABELV $319
line 640
;639:
;640:    	if( GetSVInfokeyInt( "watervis", NULL, 0) == 0)
ADDRGP4 $323
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 48
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $321
line 641
;641:	{
line 642
;642:	 traceline( PASSVEC3( src ), PASSVEC3( g_globalvars.trace_endpos ), 1, self );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRGP4 g_globalvars+276
INDIRF4
ARGF4
ADDRGP4 g_globalvars+276+4
INDIRF4
ARGF4
ADDRGP4 g_globalvars+276+8
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
line 644
;643:	 //inwater inopen startsolid set only if NOMONSTERS = 1
;644:	 if ( g_globalvars.trace_inopen && g_globalvars.trace_inwater )
ADDRLP4 52
CNSTF4 0
ASGNF4
ADDRGP4 g_globalvars+308
INDIRF4
ADDRLP4 52
INDIRF4
EQF4 $331
ADDRGP4 g_globalvars+312
INDIRF4
ADDRLP4 52
INDIRF4
EQF4 $331
line 645
;645:	 	return;
ADDRGP4 $290
JUMPV
LABELV $331
line 646
;646:	}
LABELV $321
line 647
;647:	if ( streq( trace_ent->s.v.classname, "player" ) && trace_ent->s.v.health > 0 )
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $141
ARGP4
ADDRLP4 52
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $335
ADDRLP4 12
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $335
line 648
;648:	{
line 649
;649:		if ( trace_ent->is_feigning && self->team_no && !TeamFortress_isTeamsAllied(self->team_no, trace_ent->team_no) )
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $337
ADDRLP4 64
CNSTI4 960
ASGNI4
ADDRLP4 68
ADDRGP4 self
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $337
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $337
line 650
;650:			return;
ADDRGP4 $290
JUMPV
LABELV $337
line 651
;651:		self->StatusRefreshTime = g_globalvars.time + 1.5;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1069547520
ADDF4
ASGNF4
line 652
;652:		TeamFortress_ID_Player( trace_ent );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 TeamFortress_ID_Player
CALLV
pop
line 654
;653:
;654:	} else
ADDRGP4 $336
JUMPV
LABELV $335
line 655
;655:	{
line 656
;656:		if ( streq( trace_ent->s.v.classname, "building_dispenser" ) )
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $342
ARGP4
ADDRLP4 56
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $340
line 657
;657:		{
line 658
;658:			self->StatusRefreshTime = g_globalvars.time + 1.5;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1069547520
ADDF4
ASGNF4
line 660
;659:
;660:			if ( self == trace_ent->real_owner )
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
NEU4 $344
line 661
;661:			{
line 662
;662:				G_centerprint( self,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $346
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_centerprint
CALLV
pop
line 667
;663:					       "\n\n\n\nYour Dispenser\nHealth: %.0f Armor %.0f\nShells %.0f Nails %.0f\nRockets %.0f Cells %.0f\n",
;664:					       trace_ent->s.v.health, trace_ent->s.v.armorvalue,
;665:					       trace_ent->s.v.ammo_shells, trace_ent->s.v.ammo_nails,
;666:					       trace_ent->s.v.ammo_rockets, trace_ent->s.v.ammo_cells );
;667:				return;
ADDRGP4 $290
JUMPV
LABELV $344
line 669
;668:			} else
;669:			{
line 670
;670:				if ( self->team_no && TeamFortress_isTeamsAllied( self->team_no , trace_ent->team_no)
ADDRLP4 60
CNSTI4 960
ASGNI4
ADDRLP4 64
ADDRGP4 self
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $347
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $347
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
NEI4 $347
line 672
;671:				     && self->playerclass == PC_ENGINEER )
;672:				{
line 673
;673:					G_centerprint( self,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $349
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_centerprint
CALLV
pop
line 679
;674:						       "\n\n\n\nDispenser made by %s\nHealth: %.0f Armor %.0f\nShells %.0f Nails %.0f\nRockets %.0f Cells %.0f\n",
;675:						       trace_ent->real_owner->s.v.netname, trace_ent->s.v.health,
;676:						       trace_ent->s.v.armorvalue, trace_ent->s.v.ammo_shells,
;677:						       trace_ent->s.v.ammo_nails, trace_ent->s.v.ammo_rockets,
;678:						       trace_ent->s.v.ammo_cells );
;679:				} else
ADDRGP4 $341
JUMPV
LABELV $347
line 680
;680:					G_centerprint( self, "\n\n\n\nDispenser made by %s\n",
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $350
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 683
;681:						       trace_ent->real_owner->s.v.netname );
;682:
;683:			}
line 684
;684:		} else
ADDRGP4 $341
JUMPV
LABELV $340
line 685
;685:		{
line 686
;686:			if ( streq( trace_ent->s.v.classname, "building_sentrygun_base" ) )
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $353
ARGP4
ADDRLP4 60
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $351
line 687
;687:			{
line 688
;688:				for ( te = world; ( te = trap_find( te, FOFS( s.v.classname ) , "building_sentrygun" )); )
ADDRLP4 28
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $357
JUMPV
LABELV $354
line 689
;689:				{
line 690
;690:					if ( te->trigger_field == trace_ent )
ADDRLP4 28
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRP4
CVPU4 4
NEU4 $359
line 691
;691:					{
line 692
;692:						trace_ent = te;
ADDRLP4 12
ADDRLP4 28
INDIRP4
ASGNP4
line 693
;693:						break;
ADDRGP4 $356
JUMPV
LABELV $359
line 695
;694:					}
;695:				}
LABELV $355
line 688
LABELV $357
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $358
ARGP4
ADDRLP4 64
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 64
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $354
LABELV $356
line 696
;696:			}
LABELV $351
line 697
;697:			if ( streq( trace_ent->s.v.classname, "building_sentrygun" ) )
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $358
ARGP4
ADDRLP4 64
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $361
line 698
;698:			{
line 699
;699:				self->StatusRefreshTime = g_globalvars.time + 1.5;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1069547520
ADDF4
ASGNF4
line 700
;700:				TeamFortress_ID_Sentry( trace_ent );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 TeamFortress_ID_Sentry
CALLV
pop
line 701
;701:			}
LABELV $361
line 702
;702:		}
LABELV $341
line 703
;703:	}
LABELV $336
line 704
;704:}
LABELV $290
endproc TeamFortress_ID 76 36
import W_Reload_rocket_launcher
import W_Reload_grenade_launcher
import W_Reload_super_shotgun
import W_Reload_shotgun
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
import TeamFortress_DetonatePipebombs
import TeamFortress_ThrowGrenade
import TeamFortress_PrimeGrenade
import TeamFortress_FlameThrower
import TeamFortress_IncendiaryCannon
import TeamFortress_AssaultWeapon
import TeamFortress_SniperWeapon
import TeamFortress_ShowTF
import TeamFortress_ShowIDs
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
LABELV $358
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
LABELV $353
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
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $350
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 68
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $349
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 68
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 83
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 78
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 67
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $346
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 68
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 10
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 83
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 78
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 67
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $342
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
LABELV $323
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 118
byte 1 105
byte 1 115
byte 1 0
align 1
LABELV $289
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 69
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $288
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $287
byte 1 10
byte 1 10
byte 1 10
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 109
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 83
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $286
byte 1 10
byte 1 10
byte 1 10
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 109
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 83
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $279
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $276
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 71
byte 1 117
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $275
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 83
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $274
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 83
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $263
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 69
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 83
byte 1 112
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $262
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 69
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $256
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 83
byte 1 112
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $253
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 83
byte 1 112
byte 1 121
byte 1 10
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $249
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 83
byte 1 112
byte 1 121
byte 1 10
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 10
byte 1 0
align 1
LABELV $240
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 69
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $236
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $235
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $233
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 10
byte 1 0
align 1
LABELV $220
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $215
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $205
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $200
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $182
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
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $180
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $179
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $174
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $171
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $168
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $160
byte 1 0
align 1
LABELV $157
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
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
LABELV $141
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $135
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
LABELV $134
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
LABELV $80
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
LABELV $72
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 98
byte 1 111
byte 1 120
byte 1 0
align 1
LABELV $70
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
