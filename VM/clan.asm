export PreMatch_Think
code
proc PreMatch_Think 48 24
file "..\src\clan.c"
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
;21: *  $Id: clan.c,v 1.11 2006/01/18 14:05:26 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:extern int last_id;
;26:void MatchTimer( qboolean force );
;27:void PreMatch_Think(  )
;28:{
line 34
;29:	int     time_left;
;30:	gedict_t *te;
;31:	gedict_t *oldself;
;32:	gedict_t *gren;
;33:
;34:	time_left = ceil( tf_data.cb_prematch_time - g_globalvars.time );
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
SUBF4
ARGF4
ADDRLP4 16
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 35
;35:	if ( time_left > 60 )
ADDRLP4 12
INDIRI4
CNSTI4 60
LEI4 $14
line 36
;36:	{
line 37
;37:		G_bprint( 2, "%d minutes left till Match begins.\n", time_left / 60 );
CNSTI4 2
ARGI4
ADDRGP4 $16
ARGP4
ADDRLP4 12
INDIRI4
CNSTI4 60
DIVI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 38
;38:		if ( time_left < 120 )
ADDRLP4 12
INDIRI4
CNSTI4 120
GEI4 $17
line 39
;39:			self->s.v.nextthink = g_globalvars.time + time_left - 60;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
ADDF4
CNSTF4 1114636288
SUBF4
ASGNF4
ADDRGP4 $11
JUMPV
LABELV $17
line 41
;40:		else
;41:			self->s.v.nextthink = g_globalvars.time + 60.0;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 42
;42:		return;
ADDRGP4 $11
JUMPV
LABELV $14
line 44
;43:	}
;44:	if ( time_left >= 59 )
ADDRLP4 12
INDIRI4
CNSTI4 59
LTI4 $21
line 45
;45:	{
line 46
;46:		G_bprint( 2, "1 minute left till Match begins.\n" );
CNSTI4 2
ARGI4
ADDRGP4 $23
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 47
;47:		self->s.v.nextthink = g_globalvars.time + 30.0;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 48
;48:		return;
ADDRGP4 $11
JUMPV
LABELV $21
line 50
;49:	}
;50:	if ( time_left >= 29 )
ADDRLP4 12
INDIRI4
CNSTI4 29
LTI4 $25
line 51
;51:	{
line 52
;52:		G_bprint( 2, "30 seconds left till Match begins.\n" );
CNSTI4 2
ARGI4
ADDRGP4 $27
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 53
;53:		self->s.v.nextthink = g_globalvars.time + 20.0;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 54
;54:		return;
ADDRGP4 $11
JUMPV
LABELV $25
line 56
;55:	}
;56:	if ( time_left > 1 )
ADDRLP4 12
INDIRI4
CNSTI4 1
LEI4 $29
line 57
;57:	{
line 58
;58:		G_bprint( 2, "%d seconds.\n", time_left );
CNSTI4 2
ARGI4
ADDRGP4 $31
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 59
;59:		self->s.v.nextthink = g_globalvars.time + 1.0;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 60
;60:		return;
ADDRGP4 $11
JUMPV
LABELV $29
line 63
;61:	}
;62:	//if ( time_left > 0 )
;63:	if( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $33
line 64
;64:	{
line 65
;65:		G_bprint( 2, "1 second.\n" );
CNSTI4 2
ARGI4
ADDRGP4 $37
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 66
;66:		self->s.v.nextthink = g_globalvars.time + 1.0;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 67
;67:		return;
ADDRGP4 $11
JUMPV
LABELV $33
line 74
;68:	}
;69:/*	if( tf_data.cb_prematch_time > g_globalvars.time )
;70:	{
;71:	        self->s.v.nextthink = g_globalvars.time + 0.5;
;72:	        return;
;73:	}*/
;74:	G_bprint( 2, "MATCH BEGINS NOW\n" );
CNSTI4 2
ARGI4
ADDRGP4 $39
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 75
;75:	MatchTimer( true );
CNSTI4 1
ARGI4
ADDRGP4 MatchTimer
CALLV
pop
line 76
;76:	if ( tf_data.game_locked )
ADDRGP4 tf_data+32
INDIRI4
CNSTI4 0
EQI4 $40
line 77
;77:		G_bprint( 2, "GAME IS NOW LOCKED\n" );
CNSTI4 2
ARGI4
ADDRGP4 $43
ARGP4
ADDRGP4 G_bprint
CALLV
pop
LABELV $40
line 78
;78:	teamscores[0] = teamscores[1] = teamscores[2] = teamscores[3] = teamscores[4] = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 teamscores+16
ADDRLP4 20
INDIRI4
ASGNI4
ADDRGP4 teamscores+12
ADDRLP4 20
INDIRI4
ASGNI4
ADDRGP4 teamscores+8
ADDRLP4 20
INDIRI4
ASGNI4
ADDRGP4 teamscores+4
ADDRLP4 20
INDIRI4
ASGNI4
ADDRGP4 teamscores
ADDRLP4 20
INDIRI4
ASGNI4
line 79
;79:	teamfrags[0] = teamfrags[1] = teamfrags[2] = teamfrags[3] = teamfrags[4] = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 teamfrags+16
ADDRLP4 24
INDIRI4
ASGNI4
ADDRGP4 teamfrags+12
ADDRLP4 24
INDIRI4
ASGNI4
ADDRGP4 teamfrags+8
ADDRLP4 24
INDIRI4
ASGNI4
ADDRGP4 teamfrags+4
ADDRLP4 24
INDIRI4
ASGNI4
ADDRGP4 teamfrags
ADDRLP4 24
INDIRI4
ASGNI4
line 81
;80://paranoid ?????????
;81:	if( tf_data.cease_fire )	
ADDRGP4 tf_data+72
INDIRI4
CNSTI4 0
EQI4 $52
line 82
;82:	{
line 83
;83:		G_bprint(2,"!!!BUG BUG BUG!!! tf_data.cease_fire != 0\n");
CNSTI4 2
ARGI4
ADDRGP4 $55
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 84
;84:		tf_data.cease_fire = 0;
ADDRGP4 tf_data+72
CNSTI4 0
ASGNI4
line 85
;85:	}
LABELV $52
line 86
;86:	for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 4
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $60
JUMPV
LABELV $57
line 87
;87:	{
line 88
;88:		oldself = self;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
line 89
;89:		self = te;
ADDRGP4 self
ADDRLP4 4
INDIRP4
ASGNP4
line 90
;90:		if ( !self->tf_id )
ADDRGP4 self
INDIRP4
CNSTI4 1536
ADDP4
INDIRI4
CNSTI4 0
NEI4 $62
line 91
;91:		{
line 92
;92:			last_id = last_id + 20 + g_random(  ) * 10;
ADDRLP4 28
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 32
ADDRGP4 last_id
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 20
ADDI4
CVIF4 4
CNSTF4 1092616192
ADDRLP4 28
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 93
;93:			self->tf_id = g_random(  ) * 10 + last_id;
ADDRLP4 36
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1536
ADDP4
CNSTF4 1092616192
ADDRLP4 36
INDIRF4
MULF4
ADDRGP4 last_id
INDIRI4
CVIF4 4
ADDF4
CVFI4 4
ASGNI4
line 94
;94:			stuffcmd( self, "setinfo tf_id %d\n", self->tf_id );
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 $64
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 1536
ADDP4
INDIRI4
ARGI4
ADDRGP4 stuffcmd
CALLV
pop
line 95
;95:			G_sprint( self, 2, "Your Battle ID is %d\n", self->tf_id );
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $65
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 1536
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 96
;96:		}
LABELV $62
line 97
;97:		if ( self->hook_out )
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
INDIRI4
CNSTI4 0
EQI4 $66
line 98
;98:		{
line 99
;99:			Reset_Grapple( self->hook );
ADDRGP4 self
INDIRP4
CNSTI4 1440
ADDP4
INDIRP4
ARGP4
ADDRGP4 Reset_Grapple
CALLV
pop
line 100
;100:			Attack_Finished( 0.75 );
CNSTF4 1061158912
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 101
;101:			self->hook_out = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
CNSTI4 1
ASGNI4
line 102
;102:		}
LABELV $66
line 103
;103:		TeamFortress_RemoveTimers(  );
ADDRGP4 TeamFortress_RemoveTimers
CALLV
pop
line 104
;104:		self->s.v.frags = 0;
ADDRGP4 self
INDIRP4
CNSTI4 300
ADDP4
CNSTF4 0
ASGNF4
line 105
;105:		self->real_frags = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1024
ADDP4
CNSTI4 0
ASGNI4
line 106
;106:		for ( gren = world; (gren = trap_find( gren, FOFS( s.v.classname ), "grenade" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $71
JUMPV
LABELV $68
line 107
;107:		{
line 108
;108:			if ( gren->s.v.owner == EDICT_TO_PROG( self ) )
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
NEI4 $73
line 109
;109:				gren->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
LABELV $73
line 110
;110:		}
LABELV $69
line 106
LABELV $71
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $72
ARGP4
ADDRLP4 28
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $68
line 112
;111:		
;112:		TF_T_Damage( self, world, world, self->s.v.health + 1, TF_TD_IGNOREARMOUR, 0 );
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 world
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 114
;113:
;114:		self = oldself;
ADDRGP4 self
ADDRLP4 8
INDIRP4
ASGNP4
line 115
;115:	}
LABELV $58
line 86
LABELV $60
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $61
ARGP4
ADDRLP4 28
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 28
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $57
line 116
;116:}
LABELV $11
endproc PreMatch_Think 48 24
export TeamFortress_ShowIDs
proc TeamFortress_ShowIDs 16 20
line 119
;117:
;118:void TeamFortress_ShowIDs(  )
;119:{
line 123
;120:	gedict_t *te;
;121:	float   got_one;
;122:
;123:	if ( !self->team_no )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 0
NEI4 $77
line 124
;124:	{
line 125
;125:		G_sprint( self, 2, "You aren't in a team.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $79
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 126
;126:		return;
ADDRGP4 $76
JUMPV
LABELV $77
line 128
;127:	}
;128:	got_one = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 129
;129:	G_sprint( self, 2, "Existing Team Member IDs:\n" );
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
line 130
;130:	for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $84
JUMPV
LABELV $81
line 131
;131:	{
line 132
;132:		if ( te->team_no == self->team_no )
ADDRLP4 8
CNSTI4 960
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
NEI4 $85
line 133
;133:		{
line 134
;134:			got_one = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 135
;135:			G_sprint( self, 2, "%s : %d\n", te->s.v.netname, te->tf_id );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $87
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1536
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 136
;136:		}
LABELV $85
line 137
;137:	}
LABELV $82
line 130
LABELV $84
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $61
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
NEU4 $81
line 138
;138:	if ( !got_one )
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $88
line 139
;139:		G_sprint( self, 2, "NONE\n" );
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
LABELV $88
line 140
;140:	got_one = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 141
;141:	G_sprint( self, 2, "Disconnected Team Member IDs:\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $91
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 142
;142:	for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "ghost" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $95
JUMPV
LABELV $92
line 143
;143:	{
line 144
;144:		if ( te->team_no == self->team_no )
ADDRLP4 12
CNSTI4 960
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
NEI4 $97
line 145
;145:		{
line 146
;146:			got_one = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 147
;147:			G_sprint( self, 2, "%d\n", te->tf_id );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $99
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1536
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 148
;148:		}
LABELV $97
line 149
;149:	}
LABELV $93
line 142
LABELV $95
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $96
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $92
line 150
;150:	if ( !got_one )
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $100
line 151
;151:		G_sprint( self, 2, "NONE\n" );
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
LABELV $100
line 153
;152:
;153:}
LABELV $76
endproc TeamFortress_ShowIDs 16 20
export DumpClanScores
proc DumpClanScores 136 24
line 156
;154:
;155:void DumpClanScores(  )
;156:{
line 157
;157:	int     winners, no_teams = 0, printed = 0, ti = 0, teamfrags_q;
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
line 163
;158:	int     t_pl[5], t_unacc[5], i;
;159:	gedict_t *te;
;160:	const char   *st;
;161:    char st2[10];
;162:
;163:	for ( i = 1; i <= 4; i++ )
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $103
line 164
;164:	{
line 165
;165:		if ( (t_pl[i] = TeamFortress_TeamGetNoPlayers( i ) ))
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
ADDRLP4 88
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $107
line 166
;166:			no_teams++;
ADDRLP4 56
ADDRLP4 56
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $107
line 167
;167:		t_unacc[i] = 0;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
CNSTI4 0
ASGNI4
line 168
;168:	}
LABELV $104
line 163
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LEI4 $103
line 170
;169:
;170:	if ( no_teams < 2 )
ADDRLP4 56
INDIRI4
CNSTI4 2
GEI4 $109
line 171
;171:		return;
ADDRGP4 $102
JUMPV
LABELV $109
line 172
;172:	teamfrags_q = tf_data.toggleflags & ( TFLAG_TEAMFRAGS | TFLAG_FULLTEAMSCORE );
ADDRLP4 60
ADDRGP4 tf_data
INDIRI4
CNSTI4 2176
BANDI4
ASGNI4
line 173
;173:	for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $114
JUMPV
LABELV $111
line 174
;174:	{
line 175
;175:		if ( te->team_no <= 0 || te->team_no > 4 )
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
LEI4 $117
ADDRLP4 84
INDIRI4
CNSTI4 4
LEI4 $115
LABELV $117
line 176
;176:			continue;
ADDRGP4 $112
JUMPV
LABELV $115
line 177
;177:		t_unacc[te->team_no] += te->real_frags;
ADDRLP4 92
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
ADDI4
ASGNI4
line 178
;178:	}
LABELV $112
line 173
LABELV $114
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $61
ARGP4
ADDRLP4 84
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 84
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $111
line 179
;179:	for ( i = 1; i <= 4; i++ )
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $118
line 180
;180:		t_unacc[i] = teamfrags[i] - t_unacc[i];
ADDRLP4 88
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 92
ADDRLP4 88
INDIRI4
ADDRLP4 12
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 88
INDIRI4
ADDRGP4 teamfrags
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
INDIRI4
SUBI4
ASGNI4
LABELV $119
line 179
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LEI4 $118
line 182
;181:
;182:	winners = TeamFortress_TeamGetWinner(  );
ADDRLP4 96
ADDRGP4 TeamFortress_TeamGetWinner
CALLI4
ASGNI4
ADDRLP4 76
ADDRLP4 96
INDIRI4
ASGNI4
line 183
;183:	G_bprint( 2, "\n\n=------= MATCH RESULTS =------=\n" );
CNSTI4 2
ARGI4
ADDRGP4 $122
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 186
;184:
;185:
;186:	if ( no_teams == 2
ADDRLP4 56
INDIRI4
CNSTI4 2
NEI4 $123
ADDRGP4 teamscores+4
INDIRI4
ADDRGP4 teamscores+8
INDIRI4
NEI4 $130
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $129
LABELV $130
ADDRGP4 teamfrags+4
INDIRI4
ADDRGP4 teamfrags+8
INDIRI4
NEI4 $123
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $123
LABELV $129
line 189
;187:	     && ( ( teamscores[1] == teamscores[2] && teamfrags_q )
;188:		  || ( teamfrags[1] == teamfrags[2] && !teamfrags_q ) ) )
;189:		G_bprint( 2, " DRAW " );
CNSTI4 2
ARGI4
ADDRGP4 $131
ARGP4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $124
JUMPV
LABELV $123
line 191
;190:	else
;191:	{
line 192
;192:		if ( no_teams == 3
ADDRLP4 56
INDIRI4
CNSTI4 3
NEI4 $132
ADDRGP4 teamscores+4
INDIRI4
ADDRGP4 teamscores+8
INDIRI4
NEI4 $144
ADDRLP4 100
CNSTI4 1
ASGNI4
ADDRGP4 $145
JUMPV
LABELV $144
ADDRLP4 100
CNSTI4 0
ASGNI4
LABELV $145
ADDRLP4 100
INDIRI4
ADDRGP4 teamscores+12
INDIRI4
NEI4 $143
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $142
LABELV $143
ADDRGP4 teamfrags+4
INDIRI4
ADDRGP4 teamfrags+8
INDIRI4
NEI4 $146
ADDRLP4 104
CNSTI4 1
ASGNI4
ADDRGP4 $147
JUMPV
LABELV $146
ADDRLP4 104
CNSTI4 0
ASGNI4
LABELV $147
ADDRLP4 104
INDIRI4
ADDRGP4 teamfrags+12
INDIRI4
NEI4 $132
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $132
LABELV $142
line 195
;193:		     && ( ( teamscores[1] == teamscores[2] == teamscores[3] && teamfrags_q )
;194:			  || ( teamfrags[1] == teamfrags[2] == teamfrags[3] && !teamfrags_q ) ) )
;195:			G_bprint( 2, " DRAW " );
CNSTI4 2
ARGI4
ADDRGP4 $131
ARGP4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $133
JUMPV
LABELV $132
line 197
;196:		else
;197:		{
line 198
;198:			if ( no_teams == 3
ADDRLP4 56
INDIRI4
CNSTI4 3
NEI4 $148
ADDRGP4 teamscores+4
INDIRI4
ADDRGP4 teamscores+8
INDIRI4
NEI4 $166
ADDRLP4 112
CNSTI4 1
ASGNI4
ADDRGP4 $167
JUMPV
LABELV $166
ADDRLP4 112
CNSTI4 0
ASGNI4
LABELV $167
ADDRLP4 112
INDIRI4
ADDRGP4 teamscores+12
INDIRI4
NEI4 $164
ADDRLP4 108
CNSTI4 1
ASGNI4
ADDRGP4 $165
JUMPV
LABELV $164
ADDRLP4 108
CNSTI4 0
ASGNI4
LABELV $165
ADDRLP4 108
INDIRI4
ADDRGP4 teamscores+16
INDIRI4
NEI4 $163
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $162
LABELV $163
ADDRGP4 teamfrags+4
INDIRI4
ADDRGP4 teamfrags+8
INDIRI4
NEI4 $170
ADDRLP4 120
CNSTI4 1
ASGNI4
ADDRGP4 $171
JUMPV
LABELV $170
ADDRLP4 120
CNSTI4 0
ASGNI4
LABELV $171
ADDRLP4 120
INDIRI4
ADDRGP4 teamfrags+12
INDIRI4
NEI4 $168
ADDRLP4 116
CNSTI4 1
ASGNI4
ADDRGP4 $169
JUMPV
LABELV $168
ADDRLP4 116
CNSTI4 0
ASGNI4
LABELV $169
ADDRLP4 116
INDIRI4
ADDRGP4 teamfrags+16
INDIRI4
NEI4 $148
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $148
LABELV $162
line 202
;199:			     && ( ( teamscores[1] == teamscores[2] == teamscores[3] == teamscores[4] && teamfrags_q )
;200:				  || ( teamfrags[1] == teamfrags[2] == teamfrags[3] == teamfrags[4]
;201:				       && !teamfrags_q ) ) )
;202:				G_bprint( 2, " DRAW " );
CNSTI4 2
ARGI4
ADDRGP4 $131
ARGP4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $149
JUMPV
LABELV $148
line 204
;203:			else
;204:			{
line 205
;205:				G_bprint( 2, "%s defeated ", GetTeamName( winners ) );
ADDRLP4 76
INDIRI4
ARGI4
ADDRLP4 124
ADDRGP4 GetTeamName
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRGP4 $172
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 206
;206:				for ( i = 1; i < 4; i++ )
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $173
line 207
;207:				{
line 208
;208:					if ( winners != i && t_pl[i] )
ADDRLP4 76
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $177
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $177
line 209
;209:					{
line 210
;210:						st = GetTeamName( i );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 GetTeamName
CALLP4
ASGNP4
ADDRLP4 80
ADDRLP4 132
INDIRP4
ASGNP4
line 211
;211:						if ( !printed )
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $179
line 212
;212:							G_bprint( 2, "%s", st );
CNSTI4 2
ARGI4
ADDRGP4 $181
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $180
JUMPV
LABELV $179
line 213
;213:						else if ( printed == no_teams )
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $182
line 214
;214:							G_bprint( 2, " and %s", st );
CNSTI4 2
ARGI4
ADDRGP4 $184
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $183
JUMPV
LABELV $182
line 216
;215:						else
;216:							G_bprint( 2, ", %s", st );
CNSTI4 2
ARGI4
ADDRGP4 $185
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
LABELV $183
LABELV $180
line 217
;217:						printed++;
ADDRLP4 52
ADDRLP4 52
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 219
;218:
;219:					}
LABELV $177
line 220
;220:				}
LABELV $174
line 206
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $173
line 221
;221:			}
LABELV $149
line 222
;222:		}
LABELV $133
line 223
;223:	}
LABELV $124
line 224
;224:	G_bprint( 2, "\n\n" );
CNSTI4 2
ARGI4
ADDRGP4 $186
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 226
;225:
;226:	GetSVInfokeyString( "dtf", "dont_tweak_frags", st2, sizeof( st2 ), "off" );
ADDRGP4 $187
ARGP4
ADDRGP4 $188
ARGP4
ADDRLP4 64
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $189
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 227
;227:	if ( strcmp( st2, "on" ) )
ADDRLP4 64
ARGP4
ADDRGP4 $192
ARGP4
ADDRLP4 100
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $190
line 228
;228:	{
line 229
;229:		if ( teamfrags_q )
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $193
line 230
;230:		{
line 231
;231:			for ( i = 1; i <= 4; i++ )
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $195
line 232
;232:			{
line 233
;233:				if ( t_pl[i] <= 0 )
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
CNSTI4 0
GTI4 $199
line 234
;234:					continue;
ADDRGP4 $196
JUMPV
LABELV $199
line 235
;235:				printed = teamscores[i] / t_pl[i];
ADDRLP4 104
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 52
ADDRLP4 104
INDIRI4
ADDRGP4 teamscores
ADDP4
INDIRI4
ADDRLP4 104
INDIRI4
ADDRLP4 32
ADDP4
INDIRI4
DIVI4
ASGNI4
line 236
;236:				ti = teamscores[i] % t_pl[i];
ADDRLP4 108
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 8
ADDRLP4 108
INDIRI4
ADDRGP4 teamscores
ADDP4
INDIRI4
ADDRLP4 108
INDIRI4
ADDRLP4 32
ADDP4
INDIRI4
MODI4
ASGNI4
line 237
;237:				for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $204
JUMPV
LABELV $201
line 238
;238:				{
line 239
;239:					if ( te->team_no == i )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $205
line 240
;240:						te->s.v.frags = printed;
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 52
INDIRI4
CVIF4 4
ASGNF4
LABELV $205
line 241
;241:					if ( ti )
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $207
line 242
;242:					{
line 243
;243:						te->s.v.frags += 1;
ADDRLP4 112
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 244
;244:						ti--;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 245
;245:					}
LABELV $207
line 246
;246:				}
LABELV $202
line 237
LABELV $204
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $61
ARGP4
ADDRLP4 112
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 112
INDIRP4
ASGNP4
ADDRLP4 112
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $201
line 247
;247:			}
LABELV $196
line 231
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LEI4 $195
line 248
;248:		} else
ADDRGP4 $194
JUMPV
LABELV $193
line 249
;249:		{
line 250
;250:			for ( i = 1; i <= 4; i++ )
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $209
line 251
;251:			{
line 252
;252:				if ( !( t_pl[i] > 0 && t_unacc[i] > 0 ) )
ADDRLP4 104
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRLP4 104
INDIRI4
ADDRLP4 32
ADDP4
INDIRI4
ADDRLP4 108
INDIRI4
LEI4 $215
ADDRLP4 104
INDIRI4
ADDRLP4 12
ADDP4
INDIRI4
ADDRLP4 108
INDIRI4
GTI4 $213
LABELV $215
line 253
;253:					continue;
ADDRGP4 $210
JUMPV
LABELV $213
line 254
;254:				printed = t_unacc[i] / t_pl[i];
ADDRLP4 112
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 52
ADDRLP4 112
INDIRI4
ADDRLP4 12
ADDP4
INDIRI4
ADDRLP4 112
INDIRI4
ADDRLP4 32
ADDP4
INDIRI4
DIVI4
ASGNI4
line 255
;255:				ti = t_unacc[i] % t_pl[i];
ADDRLP4 116
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 8
ADDRLP4 116
INDIRI4
ADDRLP4 12
ADDP4
INDIRI4
ADDRLP4 116
INDIRI4
ADDRLP4 32
ADDP4
INDIRI4
MODI4
ASGNI4
line 256
;256:				for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $219
JUMPV
LABELV $216
line 257
;257:				{
line 258
;258:					if ( te->team_no == i )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $220
line 259
;259:					{
line 260
;260:						te->s.v.frags += printed;
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRF4
ADDRLP4 52
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 261
;261:						if ( ti )
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $222
line 262
;262:						{
line 263
;263:							te->s.v.frags += 1;
ADDRLP4 124
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 264
;264:							ti--;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 265
;265:						}
LABELV $222
line 266
;266:					}
LABELV $220
line 267
;267:				}
LABELV $217
line 256
LABELV $219
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $61
ARGP4
ADDRLP4 120
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 120
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $216
line 269
;268:
;269:			}
LABELV $210
line 250
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LEI4 $209
line 270
;270:		}
LABELV $194
line 271
;271:	}
LABELV $190
line 272
;272:	for ( i = 1; i <= 4; i++ )
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $224
line 273
;273:	{
line 274
;274:		if ( t_pl[i] <= 0 )
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
CNSTI4 0
GTI4 $228
line 275
;275:			continue;
ADDRGP4 $225
JUMPV
LABELV $228
line 276
;276:		G_bprint( 2, "\n=------= TEAM%d RESULTS =------=\n", i );
CNSTI4 2
ARGI4
ADDRGP4 $230
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 277
;277:		G_bprint( 2, "%d players.\n%d frags, %d unaccounted for.\n%d team score.\n\n",
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
ADDRLP4 108
CNSTI4 2
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRGP4 $231
ARGP4
ADDRLP4 104
INDIRI4
ARGI4
ADDRLP4 112
ADDRLP4 4
INDIRI4
ADDRLP4 108
INDIRI4
LSHI4
ASGNI4
ADDRLP4 112
INDIRI4
ADDRGP4 teamfrags
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
INDIRI4
ADDRLP4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
INDIRI4
ADDRGP4 teamscores
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 279
;278:			  TeamFortress_TeamGetNoPlayers( i ), teamfrags[i], t_unacc[i], teamscores[i] );
;279:	}
LABELV $225
line 272
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LEI4 $224
line 281
;280:
;281:	for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $235
JUMPV
LABELV $232
line 282
;282:	{
line 283
;283:		if ( te->take_sshot )
ADDRLP4 0
INDIRP4
CNSTI4 1532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $236
line 284
;284:		{
line 285
;285:			stuffcmd( te, "screenshot\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $238
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 286
;286:		}
LABELV $236
line 287
;287:	}
LABELV $233
line 281
LABELV $235
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $61
ARGP4
ADDRLP4 104
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 104
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $232
line 288
;288:	MatchTimer( true );
CNSTI4 1
ARGI4
ADDRGP4 MatchTimer
CALLV
pop
line 289
;289:}
LABELV $102
endproc DumpClanScores 136 24
data
align 4
LABELV $240
byte 4 0
export MatchTimer
code
proc MatchTimer 12 8
line 292
;290:
;291:void MatchTimer( qboolean force )
;292:{
line 296
;293:        static float lasttime = 0;
;294:        int     time_left;
;295:
;296:        if ( !( tf_data.toggleflags & TFLAG_FIRSTENTRY ) )
ADDRGP4 tf_data
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
NEI4 $241
line 297
;297:                return;
ADDRGP4 $239
JUMPV
LABELV $241
line 299
;298:
;299:        if( !force && lasttime && ( ( g_globalvars.time - lasttime ) < 60 ))
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $243
ADDRLP4 4
ADDRGP4 $240
INDIRF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $243
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
CNSTF4 1114636288
GEF4 $243
line 300
;300:        {
line 301
;301:                return;
ADDRGP4 $239
JUMPV
LABELV $243
line 303
;302:        }
;303:        lasttime = g_globalvars.time;
ADDRGP4 $240
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 304
;304:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $247
line 305
;305:	{//prematch
line 306
;306:	        localcmd("serverinfo status Countdown\n" );
ADDRGP4 $251
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 313
;307:/*	        time_left = ceil(tf_data.cb_prematch_time - g_globalvars.time+0.5);
;308:	        if( time_left > 60 )
;309:	                localcmd("serverinfo status \"PM %d min left\"\n", time_left / 60);
;310:	        else
;311:	                localcmd("serverinfo status \"PM %d sec left\"\n", time_left );
;312:*/	        
;313:		return;
ADDRGP4 $239
JUMPV
LABELV $247
line 315
;314:	}
;315:	if( !timelimit )
ADDRGP4 timelimit
INDIRI4
CNSTI4 0
NEI4 $252
line 316
;316:	{
line 317
;317:	        localcmd("serverinfo status \"no timelimit\"\n");
ADDRGP4 $254
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 318
;318:	        return;
ADDRGP4 $239
JUMPV
LABELV $252
line 320
;319:	}
;320:	if( g_globalvars.time < timelimit )
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 timelimit
INDIRI4
CVIF4 4
GEF4 $255
line 321
;321:	{
line 322
;322:	        time_left = ceil( timelimit - g_globalvars.time +0.5);
ADDRGP4 timelimit
INDIRI4
CVIF4 4
ADDRGP4 g_globalvars+124
INDIRF4
SUBF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRLP4 8
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 323
;323:	        if( time_left > 60 )
ADDRLP4 0
INDIRI4
CNSTI4 60
LEI4 $259
line 324
;324:	                localcmd("serverinfo status \"%d min left\"\n", time_left / 60);
ADDRGP4 $261
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ARGI4
ADDRGP4 localcmd
CALLV
pop
ADDRGP4 $239
JUMPV
LABELV $259
line 326
;325:	        else
;326:	                localcmd("serverinfo status \"%d sec left\"\n", time_left );
ADDRGP4 $262
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 localcmd
CALLV
pop
line 327
;327:	        return;
ADDRGP4 $239
JUMPV
LABELV $255
line 329
;328:	}
;329:	localcmd("serverinfo status Standby\n");
ADDRGP4 $263
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 330
;330:}
LABELV $239
endproc MatchTimer 12 8
export UpdateServerinfoScores
proc UpdateServerinfoScores 4 20
line 333
;331:
;332:void UpdateServerinfoScores()
;333:{
line 334
;334:        switch(number_of_teams)
ADDRLP4 0
ADDRGP4 number_of_teams
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $267
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $271
ADDRLP4 0
INDIRI4
CNSTI4 4
EQI4 $276
ADDRGP4 $264
JUMPV
line 335
;335:        {
LABELV $267
line 337
;336:                case 2:
;337:                        localcmd("serverinfo score \"%d:%d\"\n", teamscores[1],teamscores[2]);
ADDRGP4 $268
ARGP4
ADDRGP4 teamscores+4
INDIRI4
ARGI4
ADDRGP4 teamscores+8
INDIRI4
ARGI4
ADDRGP4 localcmd
CALLV
pop
line 338
;338:                        break;
ADDRGP4 $266
JUMPV
LABELV $271
line 340
;339:                case 3:
;340:                        localcmd("serverinfo score \"%d:%d:%d\"\n", teamscores[1],teamscores[2],teamscores[3]);
ADDRGP4 $272
ARGP4
ADDRGP4 teamscores+4
INDIRI4
ARGI4
ADDRGP4 teamscores+8
INDIRI4
ARGI4
ADDRGP4 teamscores+12
INDIRI4
ARGI4
ADDRGP4 localcmd
CALLV
pop
line 341
;341:                        break;
ADDRGP4 $266
JUMPV
LABELV $276
line 343
;342:                case 4:
;343:                        localcmd("serverinfo score \"%d:%d:%d:%d\"\n", teamscores[1],teamscores[2],teamscores[3],teamscores[4]);
ADDRGP4 $277
ARGP4
ADDRGP4 teamscores+4
INDIRI4
ARGI4
ADDRGP4 teamscores+8
INDIRI4
ARGI4
ADDRGP4 teamscores+12
INDIRI4
ARGI4
ADDRGP4 teamscores+16
INDIRI4
ARGI4
ADDRGP4 localcmd
CALLV
pop
line 344
;344:                        break;
line 346
;345:                default:
;346:                        return;
LABELV $266
line 349
;347:        }
;348:
;349:}
LABELV $264
endproc UpdateServerinfoScores 4 20
import last_id
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
LABELV $277
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 34
byte 1 37
byte 1 100
byte 1 58
byte 1 37
byte 1 100
byte 1 58
byte 1 37
byte 1 100
byte 1 58
byte 1 37
byte 1 100
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $272
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 34
byte 1 37
byte 1 100
byte 1 58
byte 1 37
byte 1 100
byte 1 58
byte 1 37
byte 1 100
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $268
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 34
byte 1 37
byte 1 100
byte 1 58
byte 1 37
byte 1 100
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $263
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 83
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 98
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $262
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 34
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $261
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 34
byte 1 37
byte 1 100
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $254
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 34
byte 1 110
byte 1 111
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $251
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $238
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $231
byte 1 37
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 10
byte 1 37
byte 1 100
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 117
byte 1 110
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 46
byte 1 10
byte 1 37
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 46
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $230
byte 1 10
byte 1 61
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 61
byte 1 32
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 37
byte 1 100
byte 1 32
byte 1 82
byte 1 69
byte 1 83
byte 1 85
byte 1 76
byte 1 84
byte 1 83
byte 1 32
byte 1 61
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 61
byte 1 10
byte 1 0
align 1
LABELV $192
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $189
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $188
byte 1 100
byte 1 111
byte 1 110
byte 1 116
byte 1 95
byte 1 116
byte 1 119
byte 1 101
byte 1 97
byte 1 107
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $187
byte 1 100
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $186
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $185
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $184
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $181
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $172
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 0
align 1
LABELV $131
byte 1 32
byte 1 68
byte 1 82
byte 1 65
byte 1 87
byte 1 32
byte 1 0
align 1
LABELV $122
byte 1 10
byte 1 10
byte 1 61
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 61
byte 1 32
byte 1 77
byte 1 65
byte 1 84
byte 1 67
byte 1 72
byte 1 32
byte 1 82
byte 1 69
byte 1 83
byte 1 85
byte 1 76
byte 1 84
byte 1 83
byte 1 32
byte 1 61
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 61
byte 1 10
byte 1 0
align 1
LABELV $99
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $96
byte 1 103
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $91
byte 1 68
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 77
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 73
byte 1 68
byte 1 115
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $90
byte 1 78
byte 1 79
byte 1 78
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $87
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $80
byte 1 69
byte 1 120
byte 1 105
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 77
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 73
byte 1 68
byte 1 115
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $79
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $72
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $65
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 66
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 73
byte 1 68
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $64
byte 1 115
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 116
byte 1 102
byte 1 95
byte 1 105
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $61
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $55
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
byte 1 116
byte 1 102
byte 1 95
byte 1 100
byte 1 97
byte 1 116
byte 1 97
byte 1 46
byte 1 99
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 33
byte 1 61
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $43
byte 1 71
byte 1 65
byte 1 77
byte 1 69
byte 1 32
byte 1 73
byte 1 83
byte 1 32
byte 1 78
byte 1 79
byte 1 87
byte 1 32
byte 1 76
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $39
byte 1 77
byte 1 65
byte 1 84
byte 1 67
byte 1 72
byte 1 32
byte 1 66
byte 1 69
byte 1 71
byte 1 73
byte 1 78
byte 1 83
byte 1 32
byte 1 78
byte 1 79
byte 1 87
byte 1 10
byte 1 0
align 1
LABELV $37
byte 1 49
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $31
byte 1 37
byte 1 100
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
LABELV $27
byte 1 51
byte 1 48
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 32
byte 1 116
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 77
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 98
byte 1 101
byte 1 103
byte 1 105
byte 1 110
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $23
byte 1 49
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 32
byte 1 116
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 77
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 98
byte 1 101
byte 1 103
byte 1 105
byte 1 110
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $16
byte 1 37
byte 1 100
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 32
byte 1 116
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 77
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 98
byte 1 101
byte 1 103
byte 1 105
byte 1 110
byte 1 115
byte 1 46
byte 1 10
byte 1 0
