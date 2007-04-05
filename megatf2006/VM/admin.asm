export Admin_CountPlayers
code
proc Admin_CountPlayers 8 16
file "..\src\admin.c"
line 26
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
;21: *  $Id: admin.c,v 1.5 2004/12/23 03:16:14 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:void    autokick_think(  );
;25:void Admin_CountPlayers(  )
;26:{
line 28
;27:
;28:	G_sprint( self, 2, "Players In Game : %d\n", TeamFortress_GetNoPlayers(  ) );
ADDRLP4 0
ADDRGP4 TeamFortress_GetNoPlayers
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $12
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 29
;29:	if ( number_of_teams > 0 )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 0
LEI4 $13
line 30
;30:	{
line 31
;31:		G_sprint( self, 2, "Players In Team1: %d\n", TeamFortress_TeamGetNoPlayers( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $15
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 32
;32:	}
LABELV $13
line 33
;33:	if ( number_of_teams > 1 )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 1
LEI4 $16
line 34
;34:	{
line 35
;35:		G_sprint( self, 2, "Players In Team2: %d\n", TeamFortress_TeamGetNoPlayers( 2 ) );
CNSTI4 2
ARGI4
ADDRLP4 4
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $18
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 36
;36:	}
LABELV $16
line 37
;37:	if ( number_of_teams > 2 )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 2
LEI4 $19
line 38
;38:	{
line 39
;39:		G_sprint( self, 2, "Players In Team3: %d\n", TeamFortress_TeamGetNoPlayers( 3 ) );
CNSTI4 3
ARGI4
ADDRLP4 4
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $21
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 40
;40:	}
LABELV $19
line 41
;41:	if ( number_of_teams > 3 )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 3
LEI4 $22
line 42
;42:	{
line 43
;43:		G_sprint( self, 2, "Players In Team4: %d\n", TeamFortress_TeamGetNoPlayers( 4 ) );
CNSTI4 4
ARGI4
ADDRLP4 4
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $24
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 44
;44:	}
LABELV $22
line 45
;45:}
LABELV $11
endproc Admin_CountPlayers 8 16
export Admin_CycleKick
proc Admin_CycleKick 16 16
line 48
;46:
;47:void Admin_CycleKick(  )
;48:{
line 50
;49:
;50:	if ( TeamFortress_GetNoPlayers(  ) <= 1 )
ADDRLP4 0
ADDRGP4 TeamFortress_GetNoPlayers
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
GTI4 $26
line 51
;51:	{
line 52
;52:		G_sprint( self, 2, "No other players in the game.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $28
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 53
;53:		self->admin_use = world;
ADDRGP4 self
INDIRP4
CNSTI4 1580
ADDP4
ADDRGP4 world
INDIRP4
ASGNP4
line 54
;54:		self->admin_mode = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1568
ADDP4
CNSTI4 0
ASGNI4
line 55
;55:		return;
ADDRGP4 $25
JUMPV
LABELV $26
line 57
;56:	}
;57:	if ( !self->admin_use )
ADDRGP4 self
INDIRP4
CNSTI4 1580
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $34
line 58
;58:		self->admin_use = world;
ADDRGP4 self
INDIRP4
CNSTI4 1580
ADDP4
ADDRGP4 world
INDIRP4
ASGNP4
line 59
;59:	for ( ; ( self->admin_use = trap_find( self->admin_use, FOFS( s.v.classname ), "player" ) ); )
ADDRGP4 $34
JUMPV
LABELV $31
line 60
;60:	{
line 61
;61:		if ( !self->admin_use->s.v.netname || self->admin_use == self )
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 1580
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $38
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
NEU4 $33
LABELV $38
line 62
;62:			continue;
line 63
;63:		break;
LABELV $32
line 59
LABELV $34
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 1580
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $35
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $31
LABELV $33
line 65
;64:	}
;65:	if ( self->admin_use )
ADDRGP4 self
INDIRP4
CNSTI4 1580
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $39
line 66
;66:	{
line 67
;67:		self->admin_mode = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1568
ADDP4
CNSTI4 1
ASGNI4
line 68
;68:		G_sprint( self, 2, "Kick %s?\n", self->admin_use->s.v.netname );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $41
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 1580
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 69
;69:	} else
ADDRGP4 $40
JUMPV
LABELV $39
line 70
;70:	{
line 71
;71:		self->admin_mode = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1568
ADDP4
CNSTI4 0
ASGNI4
line 72
;72:		G_sprint( self, 2, "End of player list\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $42
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 73
;73:	}
LABELV $40
line 74
;74:}
LABELV $25
endproc Admin_CycleKick 16 16
export Admin_DoKick
proc Admin_DoKick 8 16
line 77
;75:
;76:void Admin_DoKick(  )
;77:{
line 78
;78:	G_bprint( 2, "%s was kicked by %s\n", self->admin_use->s.v.netname, self->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $44
ARGP4
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 396
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1580
ADDP4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 79
;79:	KickCheater( self->admin_use );
ADDRGP4 self
INDIRP4
CNSTI4 1580
ADDP4
INDIRP4
ARGP4
ADDRGP4 KickCheater
CALLV
pop
line 80
;80:	self->admin_mode = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1568
ADDP4
CNSTI4 0
ASGNI4
line 81
;81:	self->admin_use = world;
ADDRGP4 self
INDIRP4
CNSTI4 1580
ADDP4
ADDRGP4 world
INDIRP4
ASGNP4
line 82
;82:}
LABELV $43
endproc Admin_DoKick 8 16
export CeaseFire_think
proc CeaseFire_think 12 12
line 85
;83:
;84:void CeaseFire_think(  )
;85:{
line 88
;86:	gedict_t *te;
;87:
;88:	if ( g_globalvars.time > tf_data.cb_ceasefire_time && self->s.v.weapon == 1 && tf_data.cease_fire == 1 )
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 tf_data+28
INDIRF4
LEF4 $46
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $46
ADDRGP4 tf_data+72
INDIRI4
CNSTI4 1
NEI4 $46
line 89
;89:	{
line 90
;90:		tf_data.cease_fire = 0;
ADDRGP4 tf_data+72
CNSTI4 0
ASGNI4
line 91
;91:		G_bprint( 2, "RESUME FIRE\n" );
CNSTI4 2
ARGI4
ADDRGP4 $52
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 92
;92:		for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $56
JUMPV
LABELV $53
line 93
;93:		{
line 94
;94:			G_centerprint( te, "RESUME FIRE\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $52
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 95
;95:			te->tfstate = te->tfstate - ( te->tfstate & TFSTATE_CANT_MOVE );
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 65536
BANDI4
SUBI4
ASGNI4
line 96
;96:			TeamFortress_SetSpeed( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 97
;97:		}
LABELV $54
line 92
LABELV $56
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $35
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
NEU4 $53
line 98
;98:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 99
;99:		return;
ADDRGP4 $45
JUMPV
LABELV $46
line 101
;100:	}
;101:	if ( !tf_data.cease_fire )
ADDRGP4 tf_data+72
INDIRI4
CNSTI4 0
NEI4 $57
line 102
;102:	{
line 103
;103:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 104
;104:		return;
ADDRGP4 $45
JUMPV
LABELV $57
line 106
;105:	}
;106:	for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $63
JUMPV
LABELV $60
line 107
;107:	{
line 108
;108:		G_centerprint( te, "CEASE FIRE\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $64
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 109
;109:	}
LABELV $61
line 106
LABELV $63
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $35
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
NEU4 $60
line 110
;110:	self->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 111
;111:}
LABELV $45
endproc CeaseFire_think 12 12
export Admin_CeaseFire
proc Admin_CeaseFire 16 12
line 114
;112:
;113:void Admin_CeaseFire(  )
;114:{
line 117
;115:	gedict_t *te;
;116:
;117:	if ( !tf_data.cease_fire )
ADDRGP4 tf_data+72
INDIRI4
CNSTI4 0
NEI4 $67
line 118
;118:	{
line 119
;119:		tf_data.cease_fire = 1;
ADDRGP4 tf_data+72
CNSTI4 1
ASGNI4
line 120
;120:		G_bprint( 2, "CEASE FIRE\n" );
CNSTI4 2
ARGI4
ADDRGP4 $64
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 121
;121:		for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $74
JUMPV
LABELV $71
line 122
;122:		{
line 123
;123:			G_centerprint( te, "CEASE FIRE\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $64
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 124
;124:			te->tfstate = te->tfstate | TFSTATE_CANT_MOVE;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 125
;125:			TeamFortress_SetSpeed( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 126
;126:		}
LABELV $72
line 121
LABELV $74
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $35
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
NEU4 $71
line 127
;127:		te = spawn(  );
ADDRLP4 8
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 128
;128:		te->s.v.classname = "ceasefire";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $75
ASGNP4
line 129
;129:		te->s.v.think = ( func_t ) CeaseFire_think;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 CeaseFire_think
CVPU4 4
CVUI4 4
ASGNI4
line 130
;130:		te->s.v.nextthink = g_globalvars.time + 5;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 131
;131:	} else
ADDRGP4 $68
JUMPV
LABELV $67
line 132
;132:	{
line 133
;133:		te = trap_find( world, FOFS( s.v.classname ), "ceasefire" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $75
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 134
;134:		if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $77
line 135
;135:			dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
LABELV $77
line 136
;136:		tf_data.cease_fire = 0;
ADDRGP4 tf_data+72
CNSTI4 0
ASGNI4
line 137
;137:		G_bprint( 2, "RESUME FIRE\n" );
CNSTI4 2
ARGI4
ADDRGP4 $52
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 138
;138:		for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $83
JUMPV
LABELV $80
line 139
;139:		{
line 141
;140:
;141:			G_centerprint( te, "RESUME FIRE\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $52
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 142
;142:			te->tfstate = te->tfstate - ( te->tfstate & TFSTATE_CANT_MOVE );
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
line 143
;143:			TeamFortress_SetSpeed( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 144
;144:		}
LABELV $81
line 138
LABELV $83
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $35
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
NEU4 $80
line 145
;145:	}
LABELV $68
line 146
;146:}
LABELV $66
endproc Admin_CeaseFire 16 12
export CheckAutoKick
proc CheckAutoKick 16 12
line 149
;147:
;148:void CheckAutoKick( gedict_t * p )
;149:{
line 153
;150:	float   rnum;
;151:	gedict_t *te;
;152:
;153:	if ( p->teamkills >= tf_data.autokick_kills && tf_data.autokick_kills )
ADDRFP4 0
INDIRP4
CNSTI4 1540
ADDP4
INDIRI4
ADDRGP4 tf_data+84
INDIRI4
LTI4 $85
ADDRGP4 tf_data+84
INDIRI4
CNSTI4 0
EQI4 $85
line 154
;154:	{
line 155
;155:		G_bprint( 2, "%s was kicked for killing teammates.\n", p->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $89
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 156
;156:		G_sprint( p, 2, "You were kicked for killing teammates.\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $90
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 157
;157:		KickCheater( p );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 KickCheater
CALLV
pop
line 158
;158:	} else
ADDRGP4 $86
JUMPV
LABELV $85
line 159
;159:	{
line 160
;160:		if ( tf_data.autokick_kills )
ADDRGP4 tf_data+84
INDIRI4
CNSTI4 0
EQI4 $91
line 161
;161:		{
line 162
;162:			if ( p->teamkills == tf_data.autokick_kills - 1 )
ADDRFP4 0
INDIRP4
CNSTI4 1540
ADDP4
INDIRI4
ADDRGP4 tf_data+84
INDIRI4
CNSTI4 1
SUBI4
NEI4 $94
line 163
;163:				G_sprint( p, 2, "Kill one more teammate, and you're outta here.\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $97
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $94
line 164
;164:			rnum = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 165
;165:			for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "ak_timer" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $101
JUMPV
LABELV $98
line 166
;166:			{
line 167
;167:				if ( te->s.v.owner == EDICT_TO_PROG( p ) )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $103
line 168
;168:				{
line 169
;169:					rnum = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 170
;170:					break;
ADDRGP4 $100
JUMPV
LABELV $103
line 172
;171:				}
;172:			}
LABELV $99
line 165
LABELV $101
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $102
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
NEU4 $98
LABELV $100
line 173
;173:			if ( !rnum )
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $105
line 174
;174:			{
line 175
;175:				te = spawn(  );
ADDRLP4 12
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 176
;176:				te->s.v.classname = "ak_timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $102
ASGNP4
line 177
;177:				te->s.v.owner = EDICT_TO_PROG( p );
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 178
;178:				te->s.v.think = ( func_t ) autokick_think;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 autokick_think
CVPU4 4
CVUI4 4
ASGNI4
line 179
;179:				te->s.v.nextthink = g_globalvars.time + tf_data.autokick_time;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 tf_data+80
INDIRF4
ADDF4
ASGNF4
line 180
;180:			}
LABELV $105
line 181
;181:		}
LABELV $91
line 182
;182:	}
LABELV $86
line 183
;183:}
LABELV $84
endproc CheckAutoKick 16 12
import autokick_think
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
import PreMatch_Think
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
LABELV $102
byte 1 97
byte 1 107
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $97
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 44
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 39
byte 1 114
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 116
byte 1 97
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $90
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 119
byte 1 101
byte 1 114
byte 1 101
byte 1 32
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $89
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $75
byte 1 99
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $64
byte 1 67
byte 1 69
byte 1 65
byte 1 83
byte 1 69
byte 1 32
byte 1 70
byte 1 73
byte 1 82
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $52
byte 1 82
byte 1 69
byte 1 83
byte 1 85
byte 1 77
byte 1 69
byte 1 32
byte 1 70
byte 1 73
byte 1 82
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $44
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 99
byte 1 107
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
LABELV $42
byte 1 69
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $41
byte 1 75
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 37
byte 1 115
byte 1 63
byte 1 10
byte 1 0
align 1
LABELV $35
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $28
byte 1 78
byte 1 111
byte 1 32
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $24
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 73
byte 1 110
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 52
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $21
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 73
byte 1 110
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 51
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $18
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 73
byte 1 110
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 50
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $15
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 73
byte 1 110
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 49
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $12
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 73
byte 1 110
byte 1 32
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
