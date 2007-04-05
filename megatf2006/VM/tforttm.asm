export TeamFortress_TeamPutPlayerInTeam
code
proc TeamFortress_TeamPutPlayerInTeam 28 4
file "..\src\tforttm.c"
line 34
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
;21: *  $Id: tforttm.c,v 1.22 2006/03/04 13:09:25 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:int     teamscores[5];
;26:int     teamfrags[5];
;27:int     teamlives[5];
;28:int     teammaxplayers[5];
;29:static float   teamadvantage[5];
;30:int     illegalclasses[5];
;31:int     civilianteams;
;32:
;33:int TeamFortress_TeamPutPlayerInTeam(  )
;34:{
line 37
;35:	int     i, j, lowest, likely_team;
;36:
;37:	likely_team = (int)( g_random(  ) * number_of_teams ) + 1;
ADDRLP4 16
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRGP4 number_of_teams
INDIRI4
CVIF4 4
MULF4
CVFI4 4
CNSTI4 1
ADDI4
ASGNI4
line 39
;38:
;39:	if ( !likely_team )
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $12
line 40
;40:		likely_team = number_of_teams;
ADDRLP4 12
ADDRGP4 number_of_teams
INDIRI4
ASGNI4
LABELV $12
line 42
;41:
;42:	lowest = 33;
ADDRLP4 8
CNSTI4 33
ASGNI4
line 44
;43:
;44:	for ( i = 1; i < number_of_teams + 1; i++ )
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $17
JUMPV
LABELV $14
line 45
;45:	{
line 46
;46:		j = TeamFortress_TeamGetNoPlayers( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 47
;47:		if ( j < lowest )
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
GEI4 $18
line 48
;48:		{
line 49
;49:			if ( TeamFortress_TeamGetMaxPlayers( i ) > j )
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 TeamFortress_TeamGetMaxPlayers
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $20
line 50
;50:			{
line 51
;51:				lowest = j;
ADDRLP4 8
ADDRLP4 4
INDIRI4
ASGNI4
line 52
;52:				likely_team = i;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 53
;53:			}
LABELV $20
line 54
;54:		}
LABELV $18
line 55
;55:	}
LABELV $15
line 44
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $17
ADDRLP4 0
INDIRI4
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 1
ADDI4
LTI4 $14
line 56
;56:	return TeamFortress_TeamSet( likely_team );
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 TeamFortress_TeamSet
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
LABELV $11
endproc TeamFortress_TeamPutPlayerInTeam 28 4
lit
align 4
LABELV team_colors
byte 4 0
byte 4 14
byte 4 5
byte 4 13
byte 4 12
data
export team_top_colors
align 4
LABELV team_top_colors
byte 4 0
byte 4 13
byte 4 4
byte 4 12
byte 4 11
export TeamFortress_TeamGetColor
code
proc TeamFortress_TeamGetColor 0 0
line 63
;57:}
;58:
;59:static const int     team_colors[5] = { 0, 14, 5, 13, 12 };
;60:int           team_top_colors[5] = { 0, 13, 4, 12, 11 };
;61:
;62:int TeamFortress_TeamGetColor( int tno )
;63:{
line 64
;64:	if ( tno < 5 )
ADDRFP4 0
INDIRI4
CNSTI4 5
GEI4 $23
line 65
;65:		return team_colors[tno];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_colors
ADDP4
INDIRI4
RETI4
ADDRGP4 $22
JUMPV
LABELV $23
line 67
;66:	else
;67:		return 0;
CNSTI4 0
RETI4
LABELV $22
endproc TeamFortress_TeamGetColor 0 0
export TeamFortress_TeamGetTopColor
proc TeamFortress_TeamGetTopColor 0 0
line 71
;68:}
;69:
;70:int TeamFortress_TeamGetTopColor( int tno )
;71:{
line 72
;72:	if ( tno < 5 )
ADDRFP4 0
INDIRI4
CNSTI4 5
GEI4 $26
line 73
;73:		return team_top_colors[tno];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_top_colors
ADDP4
INDIRI4
RETI4
ADDRGP4 $25
JUMPV
LABELV $26
line 75
;74:	else
;75:		return 0;
CNSTI4 0
RETI4
LABELV $25
endproc TeamFortress_TeamGetTopColor 0 0
data
align 1
LABELV team_names
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
skip 5
byte 1 114
byte 1 101
byte 1 100
byte 1 0
skip 6
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 0
skip 5
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 0
skip 5
export LoadTeamNames
code
proc LoadTeamNames 0 20
line 81
;76:}
;77:
;78:static char    team_names[4][10] = { "blue", "red", "yell", "gren" };
;79:
;80:void LoadTeamNames(  )
;81:{
line 82
;82:	GetSVInfokeyString( "team1", "t1", team_names[0], 10, "blue" );
ADDRGP4 $29
ARGP4
ADDRGP4 $30
ARGP4
ADDRGP4 team_names
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $31
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 83
;83:	GetSVInfokeyString( "team2", "t2", team_names[1], 10, "red" );
ADDRGP4 $32
ARGP4
ADDRGP4 $33
ARGP4
ADDRGP4 team_names+10
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $35
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 84
;84:	GetSVInfokeyString( "team3", "t3", team_names[2], 10, "yell" );
ADDRGP4 $36
ARGP4
ADDRGP4 $37
ARGP4
ADDRGP4 team_names+20
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $39
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 85
;85:	GetSVInfokeyString( "team4", "t4", team_names[3], 10, "gren" );
ADDRGP4 $40
ARGP4
ADDRGP4 $41
ARGP4
ADDRGP4 team_names+30
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $43
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 86
;86:}
LABELV $28
endproc LoadTeamNames 0 20
export GetTeamName
proc GetTeamName 4 0
line 89
;87:
;88:const char  *GetTeamName( int tno )
;89:{
line 90
;90:	LoadTeamNames();
ADDRGP4 LoadTeamNames
CALLV
pop
line 91
;91:	if ( tno > 0 && tno <= 4 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $45
ADDRLP4 0
INDIRI4
CNSTI4 4
GTI4 $45
line 92
;92:		return team_names[tno - 1];
CNSTI4 10
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 team_names-10
ADDP4
RETP4
ADDRGP4 $44
JUMPV
LABELV $45
line 94
;93:	else
;94:		return "\"\"";
ADDRGP4 $48
RETP4
LABELV $44
endproc GetTeamName 4 0
export SetTeamName
proc SetTeamName 12 12
line 98
;95:}
;96:
;97:void SetTeamName( gedict_t * p )
;98:{
line 99
;99:        if ( p->isBot )
ADDRFP4 0
INDIRP4
CNSTI4 1652
ADDP4
INDIRI4
CNSTI4 0
EQI4 $50
line 100
;100:        {
line 101
;101:                if( p->team_no >0 && p->team_no <=4)
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $52
ADDRLP4 0
INDIRI4
CNSTI4 4
GTI4 $52
line 102
;102:                        trap_SetBotUserInfo(NUM_FOR_EDICT( p ),"team",team_names[p->team_no-1 ]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $54
ARGP4
CNSTI4 10
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
MULI4
ADDRGP4 team_names-10
ADDP4
ARGP4
ADDRGP4 trap_SetBotUserInfo
CALLI4
pop
ADDRGP4 $51
JUMPV
LABELV $52
line 104
;103:                else
;104:                        trap_SetBotUserInfo(NUM_FOR_EDICT( p ),"team","");
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 $54
ARGP4
ADDRGP4 $56
ARGP4
ADDRGP4 trap_SetBotUserInfo
CALLI4
pop
line 105
;105:        }else
ADDRGP4 $51
JUMPV
LABELV $50
line 106
;106:	       stuffcmd( p, "team %s\n", GetTeamName( p->team_no ) );
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 GetTeamName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $57
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $51
line 107
;107:}
LABELV $49
endproc SetTeamName 12 12
export TeamFortress_TeamSet
proc TeamFortress_TeamSet 52 16
line 111
;108:
;109:
;110:int TeamFortress_TeamSet( int tno )
;111:{
line 114
;112:	int     tc;
;113:
;114:	if ( teamplay < 1 )
ADDRGP4 teamplay
INDIRI4
CNSTI4 1
GEI4 $59
line 115
;115:	{
line 116
;116:		G_sprint( self, 2, "Teamplay is not On, so FortressTeams are inactive.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $61
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 117
;117:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $58
JUMPV
LABELV $59
line 119
;118:	}
;119:	if ( tno > number_of_teams && number_of_teams )
ADDRLP4 4
ADDRGP4 number_of_teams
INDIRI4
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $62
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $62
line 120
;120:	{
line 121
;121:		G_sprint( self, 2, "There can be only %d teams on this map.\nTry again\n", number_of_teams );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $64
ARGP4
ADDRGP4 number_of_teams
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 122
;122:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $58
JUMPV
LABELV $62
line 124
;123:	}
;124:	if ( self->team_no > 0 )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 0
LEI4 $65
line 125
;125:	{
line 126
;126:		G_sprint( self, 2, "You're already in Team No %d.\n", self->team_no );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $67
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 127
;127:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $58
JUMPV
LABELV $65
line 129
;128:	}
;129:	tc = TeamFortress_TeamGetNoPlayers( tno );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 130
;130:	if ( tc >= TeamFortress_TeamGetMaxPlayers( tno ) )
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 TeamFortress_TeamGetMaxPlayers
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $68
line 131
;131:	{
line 132
;132:		G_sprint( self, 2, "That team is full. Pick another.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $70
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 133
;133:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $58
JUMPV
LABELV $68
line 135
;134:	}
;135:	if ( !TeamFortress_TeamGetColor( tno ) )
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $71
line 136
;136:	{
line 138
;137:		//TeamFortress_TeamSetColor( tno );
;138:		if ( !TeamFortress_TeamGetColor( tno ) )
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $73
line 139
;139:		{
line 140
;140:			G_sprint( self, 2, "You can't start a new team with your color, since another " );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $75
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 141
;141:			G_sprint( self, 2, "already using that color. Change your pants color, then try again.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $76
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 142
;142:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $58
JUMPV
LABELV $73
line 144
;143:		}
;144:		G_bprint( 2, "%s has started Team No %d.\n", self->s.v.netname, tno );
CNSTI4 2
ARGI4
ADDRGP4 $77
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 146
;145:
;146:		self->immune_to_check = g_globalvars.time + 10;
ADDRGP4 self
INDIRP4
CNSTI4 1080
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 147
;147:		if ( ( tf_data.toggleflags & TFLAG_TEAMFRAGS ) || ( tf_data.toggleflags & TFLAG_FULLTEAMSCORE ) )
ADDRLP4 24
ADDRGP4 tf_data
INDIRI4
ASGNI4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 128
BANDI4
ADDRLP4 28
INDIRI4
NEI4 $81
ADDRLP4 24
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 28
INDIRI4
EQI4 $79
LABELV $81
line 148
;148:			self->s.v.frags = TeamFortress_TeamGetScore( tno );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 32
INDIRI4
CVIF4 4
ASGNF4
LABELV $79
line 149
;149:		TeamFortress_SetColor( self, TeamFortress_TeamGetTopColor( tno ), 
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 TeamFortress_SetColor
CALLV
pop
line 153
;150:		                      TeamFortress_TeamGetColor( tno ) - 1 );
;151:
;152:
;153:		self->team_no = tno;
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 154
;154:		self->lives = TeamFortress_TeamGetLives( tno );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 TeamFortress_TeamGetLives
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 964
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 155
;155:		SetTeamName( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 SetTeamName
CALLV
pop
line 156
;156:		if ( !self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $82
line 157
;157:		{
line 158
;158:			if ( TeamFortress_TeamIsCivilian( self->team_no ) )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 TeamFortress_TeamIsCivilian
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $84
line 159
;159:			{
line 160
;160:				self->s.v.impulse = 1;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 1065353216
ASGNF4
line 161
;161:				TeamFortress_ChangeClass(  );
ADDRGP4 TeamFortress_ChangeClass
CALLV
pop
line 162
;162:			}
LABELV $84
line 163
;163:		}
LABELV $82
line 164
;164:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $58
JUMPV
LABELV $71
line 166
;165:	}
;166:	G_bprint( 2, "%s has joined Team No %d.\n", self->s.v.netname, tno );
CNSTI4 2
ARGI4
ADDRGP4 $86
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 167
;167:	TeamFortress_SetColor( self, TeamFortress_TeamGetTopColor( tno ), TeamFortress_TeamGetColor( tno ) - 1 );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 TeamFortress_SetColor
CALLV
pop
line 169
;168:
;169:	self->team_no = tno;
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 170
;170:	self->immune_to_check = g_globalvars.time + 10;
ADDRGP4 self
INDIRP4
CNSTI4 1080
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 171
;171:	self->lives = TeamFortress_TeamGetLives( tno );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 TeamFortress_TeamGetLives
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 964
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 172
;172:	if ( ( tf_data.toggleflags & TFLAG_TEAMFRAGS ) || ( tf_data.toggleflags & TFLAG_FULLTEAMSCORE ) )
ADDRLP4 32
ADDRGP4 tf_data
INDIRI4
ASGNI4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 128
BANDI4
ADDRLP4 36
INDIRI4
NEI4 $90
ADDRLP4 32
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 36
INDIRI4
EQI4 $88
LABELV $90
line 173
;173:		self->s.v.frags = TeamFortress_TeamGetScore( tno );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 40
INDIRI4
CVIF4 4
ASGNF4
LABELV $88
line 175
;174:
;175:	TeamFortress_TeamShowMemberClasses( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_TeamShowMemberClasses
CALLV
pop
line 176
;176:	SetTeamName( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 SetTeamName
CALLV
pop
line 177
;177:	if ( !self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $91
line 178
;178:	{
line 179
;179:		if ( TeamFortress_TeamIsCivilian( self->team_no ) )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 TeamFortress_TeamIsCivilian
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $93
line 180
;180:		{
line 181
;181:			self->s.v.impulse = 1;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 1065353216
ASGNF4
line 182
;182:			TeamFortress_ChangeClass(  );
ADDRGP4 TeamFortress_ChangeClass
CALLV
pop
line 183
;183:		}
LABELV $93
line 184
;184:	}
LABELV $91
line 185
;185:	return 1;
CNSTI4 1
RETI4
LABELV $58
endproc TeamFortress_TeamSet 52 16
export TeamFortress_CheckTeamCheats
proc TeamFortress_CheckTeamCheats 60 24
line 189
;186:}
;187:
;188:void TeamFortress_CheckTeamCheats(  )
;189:{
line 194
;190:	char    st[20];
;191:	const char *sk;
;192:	int     tc;
;193:
;194:	if ( self->immune_to_check > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 1080
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $96
line 195
;195:		return;
ADDRGP4 $95
JUMPV
LABELV $96
line 196
;196:	if ( self->s.v.deadflag )
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 0
EQF4 $99
line 197
;197:		return;
ADDRGP4 $95
JUMPV
LABELV $99
line 198
;198:	if ( !( self->s.v.netname[0] ) )
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $101
line 199
;199:		KickCheater( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickCheater
CALLV
pop
ADDRGP4 $102
JUMPV
LABELV $101
line 201
;200:	else
;201:	{
line 202
;202:		if ( self->playerclass && !self->team_no && teamplay > 0 )
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $103
ADDRLP4 28
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $103
ADDRGP4 teamplay
INDIRI4
ADDRLP4 32
INDIRI4
LEI4 $103
line 203
;203:			KickCheater( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickCheater
CALLV
pop
LABELV $103
line 204
;204:	}
LABELV $102
line 205
;205:	if ( self->team_no > 0 && teamplay > 0 )
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $105
ADDRGP4 teamplay
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $105
line 206
;206:	{
line 208
;207:
;208:		tc = GetInfokeyInt( self, "bottomcolor", NULL, 0 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $107
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 GetInfokeyInt
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 32
INDIRI4
ASGNI4
line 210
;209:
;210:		if ( self->playerclass == PC_SPY && self->undercover_team )
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $108
ADDRLP4 36
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
CNSTI4 0
EQI4 $108
line 211
;211:		{
line 212
;212:			if ( TeamFortress_TeamGetColor( self->undercover_team ) - 1 != tc )
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 20
INDIRI4
EQI4 $109
line 213
;213:			{
line 214
;214:			        TeamFortress_SetColor( self,
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 TeamFortress_SetColor
CALLV
pop
line 218
;215:					  TeamFortress_TeamGetTopColor( self->undercover_team ),
;216:					  TeamFortress_TeamGetColor( self->undercover_team ) - 1 );
;217:
;218:				G_bprint( 1, "%s has been kicked for changing color.\n", self->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $112
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 219
;219:				G_sprint( self, 2,
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $113
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 221
;220:					  "You have been kicked for changing your pants color. Don't do it.\n" );
;221:				KickCheater( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickCheater
CALLV
pop
line 222
;222:				return;
ADDRGP4 $95
JUMPV
line 224
;223:			}
;224:		} else
LABELV $108
line 225
;225:		{
line 226
;226:			if ( tc != TeamFortress_TeamGetColor( self->team_no ) - 1 )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 40
INDIRI4
CNSTI4 1
SUBI4
EQI4 $114
line 227
;227:			{
line 228
;228:				TeamFortress_SetColor( self,
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 TeamFortress_SetColor
CALLV
pop
line 231
;229:					  TeamFortress_TeamGetTopColor( self->team_no ),
;230:					  TeamFortress_TeamGetColor( self->team_no ) - 1 );
;231:				G_bprint( 1, "%s has been kicked for changing color.\n", self->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $112
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 232
;232:				G_sprint( self, 2,
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $113
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 234
;233:					  "You have been kicked for changing your pants color. Don't do it.\n" );
;234:				KickCheater( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickCheater
CALLV
pop
line 235
;235:				return;
ADDRGP4 $95
JUMPV
LABELV $114
line 237
;236:			}
;237:		}
LABELV $109
line 238
;238:		if ( tf_data.topcolor_check )
ADDRGP4 tf_data+104
INDIRI4
CNSTI4 0
EQI4 $116
line 239
;239:		{
line 240
;240:			tc = GetInfokeyInt( self, "topcolor", NULL, 0 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $119
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 40
ADDRGP4 GetInfokeyInt
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
ASGNI4
line 241
;241:			if ( self->playerclass == PC_SPY && self->undercover_team )
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $120
ADDRLP4 44
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
CNSTI4 0
EQI4 $120
line 242
;242:			{
line 243
;243:				if ( TeamFortress_TeamGetTopColor( self->undercover_team ) != tc )
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $121
line 244
;244:				{
line 245
;245:				        TeamFortress_SetColor( self, 
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 TeamFortress_SetColor
CALLV
pop
line 249
;246:						  TeamFortress_TeamGetTopColor( self->undercover_team ),
;247:						  TeamFortress_TeamGetColor( self->undercover_team ) - 1 );
;248:
;249:					G_bprint( 1, "%s has been kicked for changing color.\n", self->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $112
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 250
;250:					G_sprint( self, 2,
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
line 252
;251:						  "You have been kicked for changing your top color. Don't do it.\n" );
;252:					KickCheater( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickCheater
CALLV
pop
line 253
;253:					return;
ADDRGP4 $95
JUMPV
line 255
;254:				}
;255:			} else
LABELV $120
line 256
;256:			{
line 257
;257:				if ( tc != TeamFortress_TeamGetTopColor( self->team_no ) )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $125
line 258
;258:				{
line 259
;259:					TeamFortress_SetColor( self, 
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 TeamFortress_SetColor
CALLV
pop
line 263
;260:						  TeamFortress_TeamGetTopColor( self->undercover_team ),
;261:						  TeamFortress_TeamGetColor( self->undercover_team ) - 1 );
;262:
;263:					G_bprint( 1, "%s has been kicked for changing color.\n", self->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $112
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 264
;264:					G_sprint( self, 2,
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
line 266
;265:						  "You have been kicked for changing your top color. Don't do it.\n" );
;266:					KickCheater( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickCheater
CALLV
pop
line 267
;267:					return;
ADDRGP4 $95
JUMPV
LABELV $125
line 269
;268:				}
;269:			}
LABELV $121
line 270
;270:		}
LABELV $116
line 271
;271:		if ( self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $127
line 272
;272:		{
line 273
;273:			GetInfokeyString( self, "skin", NULL, st, sizeof( st ), "" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $129
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 $56
ARGP4
ADDRGP4 GetInfokeyString
CALLI4
pop
line 274
;274:			tc = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 275
;275:			sk = TeamFortress_GetSkin( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 TeamFortress_GetSkin
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 40
INDIRP4
ASGNP4
line 276
;276:			if ( strneq( st, sk ) )
ADDRLP4 0
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $130
line 277
;277:			{
line 278
;278:				TeamFortress_SetSkin( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSkin
CALLV
pop
line 279
;279:				G_bprint( 1, "%s has been kicked for changing skin.\n", self->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $132
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 280
;280:				G_sprint( self, 2, "You have been kicked for changing your skin. Don't do it.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $133
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 281
;281:				KickCheater( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickCheater
CALLV
pop
line 282
;282:			}
LABELV $130
line 283
;283:			if ( tc == 8 )
ADDRLP4 20
INDIRI4
CNSTI4 8
NEI4 $134
line 284
;284:				self->playerclass = 8;
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
CNSTI4 8
ASGNI4
LABELV $134
line 285
;285:		}
LABELV $127
line 286
;286:		sk = GetTeamName( self->team_no );
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 GetTeamName
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 40
INDIRP4
ASGNP4
line 287
;287:		GetInfokeyString( self, "team", NULL, st, sizeof( st ), "" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $54
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 $56
ARGP4
ADDRGP4 GetInfokeyString
CALLI4
pop
line 288
;288:		if ( strneq( st, sk ) )
ADDRLP4 0
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $136
line 289
;289:		{
line 290
;290:			SetTeamName( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 SetTeamName
CALLV
pop
line 291
;291:			G_bprint( 1, " has been kicked for changing team.\n", self->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $138
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 292
;292:			G_sprint( self, 2, "You have been kicked for changing your team. Don't do it.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $139
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 293
;293:			KickCheater( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickCheater
CALLV
pop
line 294
;294:			return;
LABELV $136
line 296
;295:		}
;296:	}
LABELV $105
line 298
;297:
;298:}
LABELV $95
endproc TeamFortress_CheckTeamCheats 60 24
export TeamFortress_TeamGetScore
proc TeamFortress_TeamGetScore 4 0
line 302
;299:
;300:
;301:int TeamFortress_TeamGetScore( int tno )
;302:{
line 303
;303:	if ( tno <= 0 || tno > 4 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $143
ADDRLP4 0
INDIRI4
CNSTI4 4
LEI4 $141
LABELV $143
line 304
;304:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $140
JUMPV
LABELV $141
line 306
;305:
;306:	return teamscores[tno];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 teamscores
ADDP4
INDIRI4
RETI4
LABELV $140
endproc TeamFortress_TeamGetScore 4 0
export TeamFortress_TeamIncreaseScore
proc TeamFortress_TeamIncreaseScore 28 12
line 311
;307:}
;308:
;309:void UpdateServerinfoScores();
;310:void TeamFortress_TeamIncreaseScore( int tno, int scoretoadd )
;311:{
line 314
;312:	gedict_t *e;
;313:
;314:	if ( !tno || !scoretoadd || tno > 4 )
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $148
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $148
ADDRLP4 4
INDIRI4
CNSTI4 4
LEI4 $145
LABELV $148
line 315
;315:		return;
ADDRGP4 $144
JUMPV
LABELV $145
line 316
;316:	teamscores[tno] += scoretoadd;
ADDRLP4 12
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 teamscores
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 318
;317:
;318:	if ( ( tf_data.toggleflags & TFLAG_TEAMFRAGS ) || ( tf_data.toggleflags & TFLAG_FULLTEAMSCORE ) )
ADDRLP4 16
ADDRGP4 tf_data
INDIRI4
ASGNI4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 128
BANDI4
ADDRLP4 20
INDIRI4
NEI4 $151
ADDRLP4 16
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 20
INDIRI4
EQI4 $149
LABELV $151
line 319
;319:	{
line 321
;320:		
;321:		for ( e = world; ( e = trap_find( e, FOFS( s.v.classname ), "player" ) ) ; )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $155
JUMPV
LABELV $152
line 322
;322:		{
line 323
;323:			if ( e->team_no == tno )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $157
line 324
;324:				e->s.v.frags = TeamFortress_TeamGetScore( tno );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 24
INDIRI4
CVIF4 4
ASGNF4
LABELV $157
line 325
;325:		}
LABELV $153
line 321
LABELV $155
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $156
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
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
NEU4 $152
line 326
;326:	}
LABELV $149
line 327
;327:	UpdateServerinfoScores();
ADDRGP4 UpdateServerinfoScores
CALLV
pop
line 328
;328:}
LABELV $144
endproc TeamFortress_TeamIncreaseScore 28 12
export TeamFortress_TeamGetScoreFrags
proc TeamFortress_TeamGetScoreFrags 12 0
line 332
;329:
;330:
;331:int TeamFortress_TeamGetScoreFrags( int tno )
;332:{
line 333
;333:	if ( tno <= 0 || tno > 4 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $162
ADDRLP4 0
INDIRI4
CNSTI4 4
LEI4 $160
LABELV $162
line 334
;334:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $159
JUMPV
LABELV $160
line 336
;335:
;336:	if ( ( tf_data.toggleflags & TFLAG_TEAMFRAGS ) || ( tf_data.toggleflags & TFLAG_FULLTEAMSCORE ) )
ADDRLP4 4
ADDRGP4 tf_data
INDIRI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 128
BANDI4
ADDRLP4 8
INDIRI4
NEI4 $165
ADDRLP4 4
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $163
LABELV $165
line 337
;337:		return teamscores[tno];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 teamscores
ADDP4
INDIRI4
RETI4
ADDRGP4 $159
JUMPV
LABELV $163
line 339
;338:	else
;339:		return teamfrags[tno];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 teamfrags
ADDP4
INDIRI4
RETI4
LABELV $159
endproc TeamFortress_TeamGetScoreFrags 12 0
export TeamFortress_TeamGetLives
proc TeamFortress_TeamGetLives 4 0
line 345
;340:
;341://	return 0;
;342:}
;343:
;344:int TeamFortress_TeamGetLives( int tno )
;345:{
line 346
;346:	if ( tno <= 0 || tno > 4 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $169
ADDRLP4 0
INDIRI4
CNSTI4 4
LEI4 $167
LABELV $169
line 347
;347:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $166
JUMPV
LABELV $167
line 349
;348:
;349:	return teamlives[tno];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 teamlives
ADDP4
INDIRI4
RETI4
LABELV $166
endproc TeamFortress_TeamGetLives 4 0
export TeamFortress_TeamGetNoPlayers
proc TeamFortress_TeamGetNoPlayers 12 12
line 353
;350:}
;351:
;352:int TeamFortress_TeamGetNoPlayers( int tno )
;353:{
line 354
;354:	int     size_team = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 357
;355:	gedict_t *search;
;356:
;357:	for ( search = world; ( search = trap_find( search, FOFS( s.v.classname ), "player" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $174
JUMPV
LABELV $171
line 358
;358:	{
line 359
;359:		if ( search->team_no == tno )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $175
line 360
;360:			size_team++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $175
line 361
;361:	}
LABELV $172
line 357
LABELV $174
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $156
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
NEU4 $171
line 362
;362:	return size_team;
ADDRLP4 4
INDIRI4
RETI4
LABELV $170
endproc TeamFortress_TeamGetNoPlayers 12 12
export TeamFortress_GetNoPlayers
proc TeamFortress_GetNoPlayers 12 12
line 366
;363:}
;364:
;365:int TeamFortress_GetNoPlayers(  )
;366:{
line 367
;367:	int     nump = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 370
;368:	gedict_t *search;
;369:
;370:	for ( search = world;( search = trap_find( search, FOFS( s.v.classname ), "player" ) ) ; )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $181
JUMPV
LABELV $178
line 371
;371:		nump++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $179
line 370
LABELV $181
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $156
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
NEU4 $178
line 372
;372:	return nump;
ADDRLP4 4
INDIRI4
RETI4
LABELV $177
endproc TeamFortress_GetNoPlayers 12 12
export TeamFortress_TeamGetMaxPlayers
proc TeamFortress_TeamGetMaxPlayers 4 0
line 377
;373:}
;374:
;375:
;376:int TeamFortress_TeamGetMaxPlayers( int tno )
;377:{
line 378
;378:	if ( tno <= 0 || tno > 4 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $185
ADDRLP4 0
INDIRI4
CNSTI4 4
LEI4 $183
LABELV $185
line 379
;379:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $182
JUMPV
LABELV $183
line 380
;380:	return teammaxplayers[tno];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 teammaxplayers
ADDP4
INDIRI4
RETI4
LABELV $182
endproc TeamFortress_TeamGetMaxPlayers 4 0
export TeamFortress_TeamGetWinner
proc TeamFortress_TeamGetWinner 20 4
line 385
;381:}
;382:
;383:
;384:int TeamFortress_TeamGetWinner(  )
;385:{
line 386
;386:	int     i, j, highest = 0, highestteam = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
line 388
;387:
;388:	for ( i = 1; i < number_of_teams + 1; i++ )
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $190
JUMPV
LABELV $187
line 389
;389:	{
line 390
;390:		j = TeamFortress_TeamGetScoreFrags( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 TeamFortress_TeamGetScoreFrags
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 391
;391:		if ( j > highest || highestteam == 0 )
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
GTI4 $193
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $191
LABELV $193
line 392
;392:		{
line 393
;393:			highest = j;
ADDRLP4 12
ADDRLP4 4
INDIRI4
ASGNI4
line 394
;394:			highestteam = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 395
;395:		}
LABELV $191
line 396
;396:	}
LABELV $188
line 388
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $190
ADDRLP4 0
INDIRI4
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 1
ADDI4
LTI4 $187
line 397
;397:	return highestteam;
ADDRLP4 8
INDIRI4
RETI4
LABELV $186
endproc TeamFortress_TeamGetWinner 20 4
export TeamFortress_TeamGetSecond
proc TeamFortress_TeamGetSecond 40 4
line 401
;398:}
;399:
;400:int TeamFortress_TeamGetSecond(  )
;401:{
line 402
;402:	int     i, j, highest, highestteam, secondteam = 0, second = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 12
CNSTI4 0
ASGNI4
line 404
;403:
;404:	highestteam = TeamFortress_TeamGetWinner(  );
ADDRLP4 24
ADDRGP4 TeamFortress_TeamGetWinner
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 24
INDIRI4
ASGNI4
line 406
;405:
;406:	highest = TeamFortress_TeamGetScoreFrags( highestteam );
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 TeamFortress_TeamGetScoreFrags
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 28
INDIRI4
ASGNI4
line 408
;407:
;408:	for ( i = 1; i < number_of_teams + 1; i++ )
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $198
JUMPV
LABELV $195
line 409
;409:	{
line 410
;410:		j = TeamFortress_TeamGetScoreFrags( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 TeamFortress_TeamGetScoreFrags
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 32
INDIRI4
ASGNI4
line 411
;411:		if ( j <= highest && ( j > second || secondteam == 0 ) && i != highestteam )
ADDRLP4 4
INDIRI4
ADDRLP4 20
INDIRI4
GTI4 $199
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
GTI4 $201
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $199
LABELV $201
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $199
line 412
;412:		{
line 413
;413:			second = j;
ADDRLP4 12
ADDRLP4 4
INDIRI4
ASGNI4
line 414
;414:			secondteam = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 415
;415:		}
LABELV $199
line 416
;416:	}
LABELV $196
line 408
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $198
ADDRLP4 0
INDIRI4
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 1
ADDI4
LTI4 $195
line 417
;417:	return secondteam;
ADDRLP4 8
INDIRI4
RETI4
LABELV $194
endproc TeamFortress_TeamGetSecond 40 4
export TeamFortress_TeamShowScores
proc TeamFortress_TeamShowScores 52 20
line 423
;418:}
;419:
;420:
;421:
;422:void TeamFortress_TeamShowScores( int all )
;423:{
line 433
;424:	const char *st;
;425:	int i;
;426:	int j;
;427:	int fl2;
;428:	int fl3;
;429:	int fix1;
;430:	int fix2;
;431:	int totalf;
;432:
;433:	i = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 434
;434:	fl2 = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 435
;435:	fl3 = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 436
;436:	if ((all == 2))
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $228
line 437
;437:	{
ADDRGP4 $206
JUMPV
LABELV $205
line 439
;438:		while ((i <= number_of_teams))
;439:		{
line 440
;440:			if ((TeamFortress_TeamGetColor (i) > 0))
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LEI4 $208
line 441
;441:			{
line 442
;442:				j = TeamFortress_TeamGetScore (i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 36
INDIRI4
ASGNI4
line 443
;443:				st = TeamFortress_TeamGetColorString (i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 TeamFortress_TeamGetColorString
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
ASGNP4
line 444
;444:				G_bprint (2, st);
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 445
;445:				G_bprint (2, ": ");
CNSTI4 2
ARGI4
ADDRGP4 $210
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 447
;446:				//st = ftos (j);
;447:				G_bprint (2, "%d",j);
CNSTI4 2
ARGI4
ADDRGP4 $211
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 448
;448:				G_bprint (2, " ");
CNSTI4 2
ARGI4
ADDRGP4 $212
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 449
;449:				if ((j >= TeamFortress_TeamGetScore (fl2)))
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 44
INDIRI4
LTI4 $213
line 450
;450:				{
line 451
;451:					fl3 = fl2;
ADDRLP4 16
ADDRLP4 12
INDIRI4
ASGNI4
line 452
;452:					fl2 = i;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 453
;453:				}
ADDRGP4 $214
JUMPV
LABELV $213
line 455
;454:				else
;455:				{
line 456
;456:					if ((j >= TeamFortress_TeamGetScore (fl3)))
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $215
line 457
;457:					{
line 458
;458:						fl3 = i;
ADDRLP4 16
ADDRLP4 0
INDIRI4
ASGNI4
line 459
;459:					}
LABELV $215
line 460
;460:				}
LABELV $214
line 461
;461:			}
LABELV $208
line 462
;462:			i = i + 1;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 463
;463:		}
LABELV $206
line 438
ADDRLP4 0
INDIRI4
ADDRGP4 number_of_teams
INDIRI4
LEI4 $205
line 464
;464:		G_bprint (2, "\n");
CNSTI4 2
ARGI4
ADDRGP4 $217
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 465
;465:		sound (world, 4, "misc/update.wav", 1, 0);
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $218
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 478
;466:/*		if ((quadscore > 0))
;467:		{
;468:			if ((team1score > team2score))
;469:			{
;470:				bprint (2, "ê");
;471:				bprint (2, TeamFortress_TeamGetColorString (1));
;472:				bprint (2, "ë Ë·Û†˜ÔÓ†ÙËÂ†Ì·Ù„Ë°\n");
;473:				execute_changelevel ();
;474:				return;
;475:			}
;476:		}*/
;477:// Changed code slightly..
;478:		if ((TeamFortress_TeamGetScore (fl2) != TeamFortress_TeamGetScore (fl3)))
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $219
line 479
;479:		{
line 481
;480:			//char totals;
;481:			fix1 = ((TeamFortress_TeamGetScore (fl2)));
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 40
INDIRI4
ASGNI4
line 482
;482:			fix2 = ((TeamFortress_TeamGetScore (fl3)));
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 44
INDIRI4
ASGNI4
line 483
;483:			totalf = (fix1 - fix2);
ADDRLP4 20
ADDRLP4 24
INDIRI4
ADDRLP4 28
INDIRI4
SUBI4
ASGNI4
line 485
;484:			//totals = ftos (totalf);
;485:			if (totalf != 0) {
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $221
line 486
;486:			G_bprint (2, "ê");
CNSTI4 2
ARGI4
ADDRGP4 $223
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 487
;487:			G_bprint (2, TeamFortress_TeamGetColorString (fl2));
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 TeamFortress_TeamGetColorString
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 488
;488:			G_bprint (2, "ë ÈÛ†ÏÂ·‰ÈÓÁ†‚˘ ê");
CNSTI4 2
ARGI4
ADDRGP4 $224
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 489
;489:			G_bprint (2, "%d",totalf);
CNSTI4 2
ARGI4
ADDRGP4 $211
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 491
;490://			bprint (2, ftos ((TeamFortress_TeamGetScore (fl2) - TeamFortress_TeamGetScore (fl3))));
;491:			G_bprint (2, "ë\n"); }
CNSTI4 2
ARGI4
ADDRGP4 $225
ARGP4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $202
JUMPV
LABELV $221
line 493
;492:			else
;493:			{
line 494
;494:				G_bprint (2, "‘ËÂ†Á·ÌÂ†ÈÛ êtiedë\n");
CNSTI4 2
ARGI4
ADDRGP4 $226
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 495
;495:			}	
line 496
;496:		}
ADDRGP4 $202
JUMPV
LABELV $219
line 498
;497:		else
;498:		{
line 499
;499:			G_bprint (2, "‘ËÂ†Á·ÌÂ†ÈÛ êtiedë\n");
CNSTI4 2
ARGI4
ADDRGP4 $226
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 500
;500:		}
line 501
;501:		return;
ADDRGP4 $202
JUMPV
LABELV $227
line 504
;502:	}
;503:	while ((i <= number_of_teams))
;504:	{
line 505
;505:		if ((TeamFortress_TeamGetColor (i) > 0))
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LEI4 $230
line 506
;506:		{
line 507
;507:			if (all)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $232
line 508
;508:			{
line 509
;509:				G_bprint (2, "Team ");
CNSTI4 2
ARGI4
ADDRGP4 $234
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 510
;510:			}
ADDRGP4 $233
JUMPV
LABELV $232
line 512
;511:			else
;512:			{
line 513
;513:			 G_sprint (self, 2, "Team ");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $234
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 514
;514:			}
LABELV $233
line 516
;515:			//st = ftos (i);
;516:			if (all)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $235
line 517
;517:			{
line 518
;518:				G_bprint (2, "%d", i);
CNSTI4 2
ARGI4
ADDRGP4 $211
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 519
;519:			}
ADDRGP4 $236
JUMPV
LABELV $235
line 521
;520:			else
;521:			{
line 522
;522:			 G_sprint (self, 2, "%d", i);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $211
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 523
;523:			}
LABELV $236
line 524
;524:			if (all)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $237
line 525
;525:			{
line 526
;526:				G_bprint (2, " (");
CNSTI4 2
ARGI4
ADDRGP4 $239
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 527
;527:			}
ADDRGP4 $238
JUMPV
LABELV $237
line 529
;528:			else
;529:			{
line 530
;530:			 G_sprint (self, 2, " (");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $239
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 531
;531:			}
LABELV $238
line 532
;532:			st = TeamFortress_TeamGetColorString (i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 TeamFortress_TeamGetColorString
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
ASGNP4
line 533
;533:			if (all)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $240
line 534
;534:			{
line 535
;535:				G_bprint (2, "%c",st);
CNSTI4 2
ARGI4
ADDRGP4 $242
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 536
;536:			}
ADDRGP4 $241
JUMPV
LABELV $240
line 538
;537:			else
;538:			{
line 539
;539:			 G_sprint (self, 2, "%c", st);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $242
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 540
;540:			}
LABELV $241
line 541
;541:			if (all)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $243
line 542
;542:			{
line 543
;543:				G_bprint (2, ") : ");
CNSTI4 2
ARGI4
ADDRGP4 $245
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 544
;544:			}
ADDRGP4 $244
JUMPV
LABELV $243
line 546
;545:			else
;546:			{
line 547
;547:			 G_sprint (self, 2, ") : ");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $245
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 548
;548:			}
LABELV $244
line 549
;549:			j = TeamFortress_TeamGetScore (i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 40
INDIRI4
ASGNI4
line 551
;550:			//st = ftos (j);
;551:			if (all)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $246
line 552
;552:			{
line 553
;553:				G_bprint (2, "%d", j);
CNSTI4 2
ARGI4
ADDRGP4 $211
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 554
;554:			}
ADDRGP4 $247
JUMPV
LABELV $246
line 556
;555:			else
;556:			{
line 557
;557:			 G_sprint (self, 2, "%d", j);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $211
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 558
;558:			}
LABELV $247
line 559
;559:			if (all)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $248
line 560
;560:			{
line 561
;561:				G_bprint (2, "\n");
CNSTI4 2
ARGI4
ADDRGP4 $217
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 562
;562:			}
ADDRGP4 $249
JUMPV
LABELV $248
line 564
;563:			else
;564:			{
line 565
;565:			 G_sprint (self, 2, "\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $217
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 566
;566:			}
LABELV $249
line 567
;567:		}
LABELV $230
line 568
;568:		i = i + 1;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 569
;569:	}
LABELV $228
line 503
ADDRLP4 0
INDIRI4
ADDRGP4 number_of_teams
INDIRI4
LEI4 $227
line 600
;570:
;571:	/*			// orig score code
;572:	int     i;
;573:
;574:	if ( all == 2 )
;575:	{
;576:		for ( i = 1; i <= number_of_teams; i++ )
;577:		{
;578:			if ( TeamFortress_TeamGetColor( i ) > 0 )
;579:			{
;580:				G_bprint( 2, "%s: %d ", TeamFortress_TeamGetColorString( i ),
;581:					  TeamFortress_TeamGetScore( i ) );
;582:
;583:			}
;584:		}
;585:		G_bprint( 2, "\n" );
;586:		return;
;587:	}
;588:	for ( i = 1; i <= number_of_teams; i++ )
;589:	{
;590:		if ( TeamFortress_TeamGetColor( i ) > 0 )
;591:		{
;592:			if ( all )
;593:				G_bprint( 2, "Team %d (%s) : %d\n", i,
;594:					  TeamFortress_TeamGetColorString( i ), TeamFortress_TeamGetScore( i ) );
;595:			else
;596:				G_sprint( self, 2, "Team %d (%s) : %d\n", i,
;597:					  TeamFortress_TeamGetColorString( i ), TeamFortress_TeamGetScore( i ) );
;598:		}
;599:	}*/
;600:}
LABELV $202
endproc TeamFortress_TeamShowScores 52 20
data
export colornames
align 4
LABELV colornames
address $250
address $251
address $252
address $253
address $254
address $255
address $256
address $257
address $258
address $259
address $260
address $261
address $262
address $263
address $250
export TeamFortress_TeamGetColorString
code
proc TeamFortress_TeamGetColorString 8 4
line 621
;601:
;602://////////////////////
;603:const char   *colornames[15] = { "DarkBlue",
;604:	"White",
;605:	"Brown",
;606:	"Blue",
;607:	"Green",
;608:	"Red",
;609:	"Tan",
;610:	"Pink",
;611:	"Orange",
;612:	"Purple",
;613:	"DarkPurple",
;614:	"Grey",
;615:	"DarkGreen",
;616:	"Yellow",
;617:	"DarkBlue"
;618:};
;619:
;620:const char   *TeamFortress_TeamGetColorString( int tno )
;621:{
line 624
;622:	int     col;
;623:
;624:	col = TeamFortress_TeamGetColor( tno );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 625
;625:	if ( col > 14 )
ADDRLP4 0
INDIRI4
CNSTI4 14
LEI4 $265
line 626
;626:		col = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $265
line 627
;627:	return colornames[col];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 colornames
ADDP4
INDIRP4
RETP4
LABELV $264
endproc TeamFortress_TeamGetColorString 8 4
export TeamFortress_TeamShowMemberClasses
proc TeamFortress_TeamShowMemberClasses 24 16
line 631
;628:}
;629:
;630:void TeamFortress_TeamShowMemberClasses( gedict_t * Player )
;631:{
line 633
;632:	gedict_t *e;
;633:	int     found = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 635
;634:
;635:	found = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 637
;636:
;637:	for ( e = world; ( e = trap_find( e, FOFS( s.v.classname ), "player" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $271
JUMPV
LABELV $268
line 638
;638:	{
line 639
;639:		if ( ( e->team_no == Player->team_no || !e->team_no ) && e != Player )
ADDRLP4 8
CNSTI4 960
ASGNI4
ADDRLP4 12
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
EQI4 $274
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $272
LABELV $274
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $272
line 640
;640:		{
line 641
;641:			if ( e->s.v.model && e->s.v.model[0] )
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $275
ADDRLP4 16
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $275
line 642
;642:			{
line 643
;643:				if ( !found )
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $277
line 644
;644:				{
line 645
;645:					found = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 646
;646:					G_sprint( Player, 2, "The other members of your team are:\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $279
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 647
;647:				}
LABELV $277
line 648
;648:				G_sprint( Player, 2, "%s : ", e->s.v.netname );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $280
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 649
;649:				TeamFortress_PrintClassName( Player, e->playerclass, e->tfstate & 8 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ARGI4
ADDRGP4 TeamFortress_PrintClassName
CALLV
pop
line 650
;650:			}
LABELV $275
line 651
;651:		}
LABELV $272
line 652
;652:	}
LABELV $269
line 637
LABELV $271
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $156
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
NEU4 $268
line 653
;653:	if ( !found )
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $281
line 654
;654:		G_sprint( Player, 2, "There are no other players on your team.\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $283
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $281
line 655
;655:}
LABELV $267
endproc TeamFortress_TeamShowMemberClasses 24 16
export TeamFortress_TeamShowMemberClasses_New
proc TeamFortress_TeamShowMemberClasses_New 48 24
line 658
;656:
;657:void TeamFortress_TeamShowMemberClasses_New( gedict_t * Player )
;658:{
line 661
;659:	int		stf;
;660:	gedict_t*	e,*te;
;661:	int	found = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 662
;662:	stf = self->settings_bits;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 1524
ADDP4
INDIRI4
ASGNI4
line 663
;663:	for(e= world; (e = trap_find( e, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $288
JUMPV
LABELV $285
line 664
;664:	{
line 665
;665:		if ( ( e->team_no == Player->team_no /*|| !e->team_no*/ ) && e != Player )
ADDRLP4 20
CNSTI4 960
ASGNI4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
NEI4 $289
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 24
INDIRP4
CVPU4 4
EQU4 $289
line 666
;666:		{
line 667
;667:			if ( e->s.v.model && e->s.v.model[0] )
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $291
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $291
line 668
;668:			{
line 669
;669:				if ( !found )
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $293
line 670
;670:				{
line 671
;671:					found = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 672
;672:					G_sprint( Player, 2, "The other members of your team are:\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $279
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 673
;673:				}
LABELV $293
line 674
;674:				G_sprint( Player, 2, "%s : %s", e->s.v.netname, TeamFortress_GetClassName(e->playerclass) );
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 TeamFortress_GetClassName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $295
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 676
;675:
;676:				if ( e->tfstate & TFSTATE_RANDOMPC)
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $296
line 677
;677:					G_sprint(Player, 2, " (Random)");
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $298
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $296
line 678
;678:				if( !e->playerclass)
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $299
line 679
;679:				{
line 680
;680:					G_sprint(Player, 2, "\n");
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $217
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 681
;681:					continue;
ADDRGP4 $286
JUMPV
LABELV $299
line 683
;682:				}
;683:				if((stf & TF_STATUS_STATS_MASK) ==0)
ADDRLP4 8
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $301
line 684
;684:				{
line 686
;685:
;686:					if(e->s.v.armortype == (float) 0.8)
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRF4
CNSTF4 1061997773
NEF4 $303
line 687
;687:						G_sprint(Player, 2, " R");
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $305
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $304
JUMPV
LABELV $303
line 688
;688:					else if(e->s.v.armortype == (float) 0.6)
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRF4
CNSTF4 1058642330
NEF4 $306
line 689
;689:						G_sprint(Player, 2, " Y");
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $308
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $307
JUMPV
LABELV $306
line 690
;690:					else if(e->s.v.armortype == (float) 0.3)
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRF4
CNSTF4 1050253722
NEF4 $309
line 691
;691:						G_sprint(Player, 2, " G");
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $311
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $310
JUMPV
LABELV $309
line 693
;692:					else 
;693:						G_sprint(Player, 2, "  ");
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $312
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $310
LABELV $307
LABELV $304
line 695
;694:
;695:					G_sprint(Player, 2, "%.0f/%.0f",e->s.v.armorvalue,e->s.v.health);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $313
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 697
;696:
;697:					if((e->playerclass == PC_SPY) && ((stf & TF_STATUS_SPY_MASK) ==0))
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $314
ADDRLP4 8
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $314
line 698
;698:					{
line 699
;699:					        if( e->undercover_team ) 
ADDRLP4 0
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
CNSTI4 0
EQI4 $316
line 700
;700:					                G_sprint(Player, 2, " %s", GetTeamName(e->undercover_team));
ADDRLP4 0
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 GetTeamName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $318
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $316
line 701
;701:					        if( e->undercover_skin ) 
ADDRLP4 0
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
CNSTI4 0
EQI4 $319
line 702
;702:					                G_sprint(Player, 2, " %s", TeamFortress_GetClassName(e->undercover_skin));
ADDRLP4 0
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 TeamFortress_GetClassName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $318
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $319
line 703
;703:					}
LABELV $314
line 705
;704:
;705:					if((e->playerclass == PC_DEMOMAN) && ((stf & TF_STATUS_DETPACK_MASK) !=0))
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
NEI4 $321
ADDRLP4 8
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $321
line 706
;706:					{
line 707
;707:						for(te= world; (te = trap_find( te, FOFS( s.v.classname ), "detpack" )); )
ADDRLP4 4
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $326
JUMPV
LABELV $323
line 708
;708:						{
line 709
;709:							if (te->s.v.owner == EDICT_TO_PROG(e))
ADDRLP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $328
line 710
;710:							{
line 711
;711:								G_sprint(Player, 2, " DTP:%.0f", te->s.v.nextthink - g_globalvars.time);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $330
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 288
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
SUBF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 712
;712:								break;
ADDRGP4 $325
JUMPV
LABELV $328
line 714
;713:							}
;714:						}
LABELV $324
line 707
LABELV $326
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $327
ARGP4
ADDRLP4 40
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $323
LABELV $325
line 715
;715:					}
LABELV $321
line 716
;716:					if((e->playerclass == PC_ENGINEER) && ((stf & TF_STATUS_SENTRY_MASK) !=0))
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
NEI4 $332
ADDRLP4 8
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $332
line 717
;717:					{
line 719
;718:
;719:						if( e->has_sentry)
ADDRLP4 0
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
CNSTI4 0
EQI4 $334
line 720
;720:						{
line 721
;721:							for(te= world; (te = trap_find( te, FOFS( s.v.classname ), "building_sentrygun" )); )
ADDRLP4 4
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $339
JUMPV
LABELV $336
line 722
;722:							{
line 723
;723:								if (te->real_owner == e)
ADDRLP4 4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
NEU4 $341
line 724
;724:								{
line 725
;725:									G_sprint(Player, 2, " SENTRY:%.0f", te->s.v.weapon );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $343
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 726
;726:									break;
ADDRGP4 $335
JUMPV
LABELV $341
line 728
;727:								}
;728:							}
LABELV $337
line 721
LABELV $339
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $340
ARGP4
ADDRLP4 40
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $336
line 729
;729:						}else
ADDRGP4 $335
JUMPV
LABELV $334
line 730
;730:						{
line 731
;731:							G_sprint(Player, 2, " NOSENTRY");
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $344
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 732
;732:						}
LABELV $335
line 733
;733:					}
LABELV $332
line 734
;734:					if((stf & TF_STATUS_COORD_MASK) !=0)
ADDRLP4 8
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $345
line 735
;735:						G_sprint(Player, 2, " '%3.0f %3.0f %3.0f'",PASSVEC3(e->s.v.origin));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $347
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
ADDRGP4 G_sprint
CALLV
pop
LABELV $345
line 736
;736:					G_sprint(Player, 2, "\n");
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $217
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 737
;737:				}
LABELV $301
line 738
;738:			}
LABELV $291
line 739
;739:		}
LABELV $289
line 741
;740:	
;741:	}
LABELV $286
line 663
LABELV $288
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $156
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $285
line 742
;742:	if ( !found )
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $348
line 743
;743:		G_sprint( Player, 2, "There are no other players on your team.\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $283
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $348
line 744
;744:}
LABELV $284
endproc TeamFortress_TeamShowMemberClasses_New 48 24
export CalculateTeamEqualiser
proc CalculateTeamEqualiser 44 4
line 747
;745:
;746:void CalculateTeamEqualiser(  )
;747:{
line 752
;748:	float   t1, t2, t3, t4;
;749:	float   t_ave;
;750:	float   calc;
;751:
;752:	teamadvantage[0] = teamadvantage[1] = teamadvantage[2] = teamadvantage[3] = teamadvantage[4] = 1;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
ADDRGP4 teamadvantage+16
ADDRLP4 24
INDIRF4
ASGNF4
ADDRGP4 teamadvantage+12
ADDRLP4 24
INDIRF4
ASGNF4
ADDRGP4 teamadvantage+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRGP4 teamadvantage+4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRGP4 teamadvantage
ADDRLP4 24
INDIRF4
ASGNF4
line 754
;753:
;754:	if ( number_of_teams < 2 )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 2
GEI4 $355
line 755
;755:	{
line 756
;756:		self->s.v.nextthink = g_globalvars.time + 60;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 757
;757:		return;
ADDRGP4 $350
JUMPV
LABELV $355
line 760
;758:	}
;759:
;760:	if ( teamplay & 32 )
ADDRGP4 teamplay
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $358
line 761
;761:	{
line 762
;762:		t1 = TeamFortress_TeamGetNoPlayers( 1 );
CNSTI4 1
ARGI4
ADDRLP4 28
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 28
INDIRI4
CVIF4 4
ASGNF4
line 763
;763:		t2 = TeamFortress_TeamGetNoPlayers( 2 );
CNSTI4 2
ARGI4
ADDRLP4 32
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 32
INDIRI4
CVIF4 4
ASGNF4
line 764
;764:		t3 = TeamFortress_TeamGetNoPlayers( 3 );
CNSTI4 3
ARGI4
ADDRLP4 36
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 36
INDIRI4
CVIF4 4
ASGNF4
line 765
;765:		t4 = TeamFortress_TeamGetNoPlayers( 4 );
CNSTI4 4
ARGI4
ADDRLP4 40
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 40
INDIRI4
CVIF4 4
ASGNF4
line 766
;766:		if ( t1 + t2 + t3 + t4 < 1 )
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
ADDF4
CNSTF4 1065353216
GEF4 $360
line 767
;767:		{
line 768
;768:			self->s.v.nextthink = g_globalvars.time + 30;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 769
;769:			return;
ADDRGP4 $350
JUMPV
LABELV $360
line 771
;770:		}
;771:		t_ave = ( t1 + t2 + t3 + t4 ) / number_of_teams;
ADDRLP4 20
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
ADDF4
ADDRGP4 number_of_teams
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 772
;772:		if ( t1 > 0 )
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $363
line 773
;773:		{
line 774
;774:			calc = t_ave / t1 - 1;
ADDRLP4 0
ADDRLP4 20
INDIRF4
ADDRLP4 4
INDIRF4
DIVF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 775
;775:			if ( calc )
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $365
line 776
;776:				calc = calc / 3 + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
DIVF4
CNSTF4 1065353216
ADDF4
ASGNF4
ADDRGP4 $366
JUMPV
LABELV $365
line 778
;777:			else
;778:				calc = calc + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $366
line 779
;779:			teamadvantage[1] = calc;
ADDRGP4 teamadvantage+4
ADDRLP4 0
INDIRF4
ASGNF4
line 780
;780:		}
LABELV $363
line 781
;781:		if ( t2 > 0 && number_of_teams >= 2 )
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $368
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 2
LTI4 $368
line 782
;782:		{
line 783
;783:			calc = t_ave / t2 - 1;
ADDRLP4 0
ADDRLP4 20
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 784
;784:			if ( calc )
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $370
line 785
;785:				calc = calc / 3 + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
DIVF4
CNSTF4 1065353216
ADDF4
ASGNF4
ADDRGP4 $371
JUMPV
LABELV $370
line 787
;786:			else
;787:				calc = calc + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $371
line 788
;788:			teamadvantage[2] = calc;
ADDRGP4 teamadvantage+8
ADDRLP4 0
INDIRF4
ASGNF4
line 789
;789:		}
LABELV $368
line 790
;790:		if ( t3 > 0 && number_of_teams >= 3 )
ADDRLP4 12
INDIRF4
CNSTF4 0
LEF4 $373
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 3
LTI4 $373
line 791
;791:		{
line 792
;792:			calc = t_ave / t3 - 1;
ADDRLP4 0
ADDRLP4 20
INDIRF4
ADDRLP4 12
INDIRF4
DIVF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 793
;793:			if ( calc )
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $375
line 794
;794:				calc = calc / 3 + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
DIVF4
CNSTF4 1065353216
ADDF4
ASGNF4
ADDRGP4 $376
JUMPV
LABELV $375
line 796
;795:			else
;796:				calc = calc + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $376
line 797
;797:			teamadvantage[3] = calc;
ADDRGP4 teamadvantage+12
ADDRLP4 0
INDIRF4
ASGNF4
line 798
;798:		}
LABELV $373
line 799
;799:		if ( t4 > 0 && number_of_teams >= 4 )
ADDRLP4 16
INDIRF4
CNSTF4 0
LEF4 $378
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 4
LTI4 $378
line 800
;800:		{
line 801
;801:			calc = t_ave / t4 - 1;
ADDRLP4 0
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRF4
DIVF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 802
;802:			if ( calc )
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $380
line 803
;803:				calc = calc / 3 + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
DIVF4
CNSTF4 1065353216
ADDF4
ASGNF4
ADDRGP4 $381
JUMPV
LABELV $380
line 805
;804:			else
;805:				calc = calc + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $381
line 806
;806:			teamadvantage[4] = calc;
ADDRGP4 teamadvantage+16
ADDRLP4 0
INDIRF4
ASGNF4
line 807
;807:		}
LABELV $378
line 808
;808:	}
LABELV $358
line 809
;809:	if ( teamplay & 64 )
ADDRGP4 teamplay
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $383
line 810
;810:	{
line 811
;811:		t1 = teamscores[0] + 60;
ADDRLP4 4
ADDRGP4 teamscores
INDIRI4
CNSTI4 60
ADDI4
CVIF4 4
ASGNF4
line 812
;812:		if ( number_of_teams >= 2 )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 2
LTI4 $385
line 813
;813:			t2 = teamscores[2] + 60;
ADDRLP4 8
ADDRGP4 teamscores+8
INDIRI4
CNSTI4 60
ADDI4
CVIF4 4
ASGNF4
ADDRGP4 $386
JUMPV
LABELV $385
line 815
;814:		else
;815:			t2 = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
LABELV $386
line 816
;816:		if ( number_of_teams >= 3 )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 3
LTI4 $388
line 817
;817:			t3 = teamscores[3] + 60;
ADDRLP4 12
ADDRGP4 teamscores+12
INDIRI4
CNSTI4 60
ADDI4
CVIF4 4
ASGNF4
ADDRGP4 $389
JUMPV
LABELV $388
line 819
;818:		else
;819:			t3 = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
LABELV $389
line 820
;820:		if ( number_of_teams >= 4 )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 4
LTI4 $391
line 821
;821:			t4 = teamscores[4] + 60;
ADDRLP4 16
ADDRGP4 teamscores+16
INDIRI4
CNSTI4 60
ADDI4
CVIF4 4
ASGNF4
ADDRGP4 $392
JUMPV
LABELV $391
line 823
;822:		else
;823:			t4 = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
LABELV $392
line 824
;824:		t_ave = ( t2 + t3 + t4 ) / ( number_of_teams - 1 );
ADDRLP4 20
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
ADDF4
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 825
;825:		calc = t_ave / t1 - 1;
ADDRLP4 0
ADDRLP4 20
INDIRF4
ADDRLP4 4
INDIRF4
DIVF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 826
;826:		if ( calc )
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $394
line 827
;827:			calc = calc / 3 + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
DIVF4
CNSTF4 1065353216
ADDF4
ASGNF4
ADDRGP4 $395
JUMPV
LABELV $394
line 829
;828:		else
;829:			calc = calc + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $395
line 830
;830:		teamadvantage[0] *= calc;
ADDRLP4 28
ADDRGP4 teamadvantage
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 831
;831:		if ( number_of_teams >= 2 )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 2
LTI4 $396
line 832
;832:		{
line 833
;833:			t_ave = ( t1 + t3 + t4 ) / ( number_of_teams - 1 );
ADDRLP4 20
ADDRLP4 4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
ADDF4
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 834
;834:			calc = t_ave / t2 - 1;
ADDRLP4 0
ADDRLP4 20
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 835
;835:			if ( calc )
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $398
line 836
;836:				calc = calc / 3 + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
DIVF4
CNSTF4 1065353216
ADDF4
ASGNF4
ADDRGP4 $399
JUMPV
LABELV $398
line 838
;837:			else
;838:				calc = calc + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $399
line 839
;839:			teamadvantage[2] *= calc;
ADDRLP4 32
ADDRGP4 teamadvantage+8
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 840
;840:		}
LABELV $396
line 841
;841:		if ( number_of_teams >= 3 )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 3
LTI4 $401
line 842
;842:		{
line 843
;843:			t_ave = ( t2 + t1 + t4 ) / ( number_of_teams - 1 );
ADDRLP4 20
ADDRLP4 8
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
ADDF4
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 844
;844:			calc = t_ave / t3 - 1;
ADDRLP4 0
ADDRLP4 20
INDIRF4
ADDRLP4 12
INDIRF4
DIVF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 845
;845:			if ( calc )
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $403
line 846
;846:				calc = calc / 3 + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
DIVF4
CNSTF4 1065353216
ADDF4
ASGNF4
ADDRGP4 $404
JUMPV
LABELV $403
line 848
;847:			else
;848:				calc = calc + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $404
line 849
;849:			teamadvantage[3] *= calc;
ADDRLP4 32
ADDRGP4 teamadvantage+12
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 850
;850:		}
LABELV $401
line 851
;851:		if ( number_of_teams >= 4 )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 4
LTI4 $406
line 852
;852:		{
line 853
;853:			t_ave = ( t2 + t3 + t1 ) / ( number_of_teams - 1 );
ADDRLP4 20
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRF4
ADDF4
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 854
;854:			calc = t_ave / t4 - 1;
ADDRLP4 0
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRF4
DIVF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 855
;855:			if ( calc )
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $408
line 856
;856:				calc = calc / 3 + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
DIVF4
CNSTF4 1065353216
ADDF4
ASGNF4
ADDRGP4 $409
JUMPV
LABELV $408
line 858
;857:			else
;858:				calc = calc + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $409
line 859
;859:			teamadvantage[4] *= calc;
ADDRLP4 32
ADDRGP4 teamadvantage+16
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 860
;860:		}
LABELV $406
line 861
;861:	}
LABELV $383
line 862
;862:	self->s.v.nextthink = g_globalvars.time + 10;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 863
;863:}
LABELV $350
endproc CalculateTeamEqualiser 44 4
export SetupTeamEqualiser
proc SetupTeamEqualiser 12 0
line 866
;864:
;865:void SetupTeamEqualiser(  )
;866:{
line 869
;867:	gedict_t *TE;
;868:
;869:	teamadvantage[0] = teamadvantage[1] = teamadvantage[2] = teamadvantage[3] = teamadvantage[4] = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRGP4 teamadvantage+16
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 teamadvantage+12
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 teamadvantage+8
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 teamadvantage+4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 teamadvantage
ADDRLP4 4
INDIRF4
ASGNF4
line 870
;870:	if ( !( teamplay & ( 32 | 64 ) ) )
ADDRGP4 teamplay
INDIRI4
CNSTI4 96
BANDI4
CNSTI4 0
NEI4 $417
line 871
;871:		return;
ADDRGP4 $412
JUMPV
LABELV $417
line 872
;872:	TE = spawn(  );
ADDRLP4 8
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 873
;873:	TE->s.v.classname = "Team Equaliser";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $419
ASGNP4
line 874
;874:	TE->s.v.think = ( func_t ) CalculateTeamEqualiser;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 CalculateTeamEqualiser
CVPU4 4
CVUI4 4
ASGNI4
line 875
;875:	TE->s.v.nextthink = g_globalvars.time + 30;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 876
;876:}
LABELV $412
endproc SetupTeamEqualiser 12 0
export TeamEqualiseDamage
proc TeamEqualiseDamage 40 8
line 879
;877:
;878:float TeamEqualiseDamage( gedict_t * targ, gedict_t * attacker, float damage )
;879:{
line 880
;880:	float   adv = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 883
;881:	float   newdam;
;882:
;883:	if ( strneq( targ->s.v.classname, "player" ) || strneq( attacker->s.v.classname, "player" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $156
ARGP4
ADDRLP4 8
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $424
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $156
ARGP4
ADDRLP4 12
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $422
LABELV $424
line 884
;884:		return damage;
ADDRFP4 8
INDIRF4
RETF4
ADDRGP4 $421
JUMPV
LABELV $422
line 885
;885:	if ( !targ->team_no || !attacker->team_no || attacker->team_no == targ->team_no )
ADDRLP4 16
CNSTI4 960
ASGNI4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $428
ADDRLP4 28
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $428
ADDRLP4 28
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $425
LABELV $428
line 886
;886:		return damage;
ADDRFP4 8
INDIRF4
RETF4
ADDRGP4 $421
JUMPV
LABELV $425
line 888
;887:
;888:	if ( attacker->team_no > 0 && attacker->team_no < 4 )
ADDRLP4 32
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LEI4 $429
ADDRLP4 32
INDIRI4
CNSTI4 4
GEI4 $429
line 889
;889:		adv = teamadvantage[attacker->team_no];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 teamadvantage
ADDP4
INDIRF4
ASGNF4
LABELV $429
line 891
;890:
;891:	if ( !adv )
ADDRLP4 0
INDIRF4
CNSTF4 0
NEF4 $431
line 892
;892:	{
line 893
;893:		G_conprintf( "There is a team with an advantage of 0\n" );
ADDRGP4 $433
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 894
;894:		adv = 0.1;
ADDRLP4 0
CNSTF4 1036831949
ASGNF4
line 895
;895:	}
LABELV $431
line 896
;896:	newdam = damage * adv;
ADDRLP4 4
ADDRFP4 8
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 897
;897:	if ( targ->team_no > 0 && targ->team_no < 4 )
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
LEI4 $434
ADDRLP4 36
INDIRI4
CNSTI4 4
GEI4 $434
line 898
;898:		adv = teamadvantage[targ->team_no];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 teamadvantage
ADDP4
INDIRF4
ASGNF4
LABELV $434
line 900
;899:
;900:	if ( !adv )
ADDRLP4 0
INDIRF4
CNSTF4 0
NEF4 $436
line 901
;901:	{
line 902
;902:		G_conprintf( "There is a team with an advantage of 0\n" );
ADDRGP4 $433
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 903
;903:		adv = 0.1;
ADDRLP4 0
CNSTF4 1036831949
ASGNF4
line 904
;904:	}
LABELV $436
line 905
;905:	newdam = newdam * 1 / adv;
ADDRLP4 4
CNSTF4 1065353216
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 0
INDIRF4
DIVF4
ASGNF4
line 906
;906:	return newdam;
ADDRLP4 4
INDIRF4
RETF4
LABELV $421
endproc TeamEqualiseDamage 40 8
export TeamFortress_StatusQuery
proc TeamFortress_StatusQuery 16 28
line 910
;907:}
;908:
;909:void TeamFortress_StatusQuery(  )
;910:{
line 912
;911:
;912:	G_sprint( self, 2, "players per team: %d %d %d %d\n",
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
CNSTI4 2
ARGI4
ADDRLP4 4
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
CNSTI4 3
ARGI4
ADDRLP4 8
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
CNSTI4 4
ARGI4
ADDRLP4 12
ADDRGP4 TeamFortress_TeamGetNoPlayers
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $439
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 917
;913:		  TeamFortress_TeamGetNoPlayers( 1 ),
;914:		  TeamFortress_TeamGetNoPlayers( 2 ),
;915:		  TeamFortress_TeamGetNoPlayers( 3 ), TeamFortress_TeamGetNoPlayers( 4 ) );
;916:
;917:	G_sprint( self, 2, "    equalisation: %.0f %.0f %.0f %.0f\n",
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $440
ARGP4
ADDRGP4 teamadvantage+4
INDIRF4
ARGF4
ADDRGP4 teamadvantage+8
INDIRF4
ARGF4
ADDRGP4 teamadvantage+12
INDIRF4
ARGF4
ADDRGP4 teamadvantage+16
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 920
;918:		  teamadvantage[1], teamadvantage[2], teamadvantage[3], teamadvantage[4] );
;919:
;920:	G_sprint( self, 2, "Teamplay is %d\n", teamplay );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $445
ARGP4
ADDRGP4 teamplay
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 921
;921:}
LABELV $438
endproc TeamFortress_StatusQuery 16 28
export TeamFortress_TeamGetIllegalClasses
proc TeamFortress_TeamGetIllegalClasses 4 0
line 925
;922:
;923:
;924:int TeamFortress_TeamGetIllegalClasses( int tno )
;925:{
line 926
;926:	if ( tno <= 0 || tno > 4 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $449
ADDRLP4 0
INDIRI4
CNSTI4 4
LEI4 $447
LABELV $449
line 927
;927:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $446
JUMPV
LABELV $447
line 928
;928:	return illegalclasses[tno];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 illegalclasses
ADDP4
INDIRI4
RETI4
LABELV $446
endproc TeamFortress_TeamGetIllegalClasses 4 0
export TeamFortress_TeamIsCivilian
proc TeamFortress_TeamIsCivilian 12 0
line 934
;929:}
;930:
;931:
;932:
;933:qboolean TeamFortress_TeamIsCivilian( int tno )
;934:{
line 935
;935:	if ( tno <= 0 || tno > 4 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $453
ADDRLP4 0
INDIRI4
CNSTI4 4
LEI4 $451
LABELV $453
line 936
;936:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $450
JUMPV
LABELV $451
line 938
;937:
;938:	return ( civilianteams & ( 1 << ( tno - 1 ) ) ) != 0;
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 civilianteams
INDIRI4
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $455
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $456
JUMPV
LABELV $455
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $456
ADDRLP4 4
INDIRI4
RETI4
LABELV $450
endproc TeamFortress_TeamIsCivilian 12 0
data
align 4
LABELV li_classrestricted
address $457
address $458
address $459
address $460
address $461
address $462
address $463
address $464
address $465
address $466
address $467
address $468
address $469
address $470
address $471
address $472
address $473
address $474
address $475
address $476
export ClassIsRestricted
code
proc ClassIsRestricted 32 12
line 955
;939:}
;940:
;941://////////////
;942:const static char   *li_classrestricted[10][2] = {
;943:	{"cr_sc", "cr_scout"},
;944:	{"cr_sn", "cr_sniper"},
;945:	{"cr_so", "cr_soldier"},
;946:	{"cr_de", "cr_demoman"},
;947:	{"cr_me", "cr_medic"},
;948:	{"cr_hw", "cr_hwguy"},
;949:	{"cr_py", "cr_pyro"},
;950:	{"cr_sp", "cr_spy"},
;951:	{"cr_en", "cr_engineer"},
;952:	{"cr_ra", "cr_random"}
;953:};
;954:int ClassIsRestricted( int tno, int pc )
;955:{
line 956
;956:	int     max, num = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 959
;957:	gedict_t *te;
;958:
;959:	if ( pc <= 0 || pc > 10 )
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LEI4 $480
ADDRLP4 12
INDIRI4
CNSTI4 10
LEI4 $478
LABELV $480
line 960
;960:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $477
JUMPV
LABELV $478
line 961
;961:	if ( !tno )
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $481
line 962
;962:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $477
JUMPV
LABELV $481
line 964
;963:
;964:	max = GetSVInfokeyInt( li_classrestricted[pc-1][0], li_classrestricted[pc-1][1], 0 );
ADDRLP4 16
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 li_classrestricted-8
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ADDRGP4 li_classrestricted-8+4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 966
;965:
;966:	if ( max > 0 )
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $486
line 967
;967:	{
line 968
;968:	        for ( te = world; ( te = trap_find( te, FOFS( s.v.classname ), "player" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $491
JUMPV
LABELV $488
line 969
;969:		{
line 970
;970:			if ( te->team_no == tno )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $492
line 971
;971:			{
line 972
;972:				if ( pc == 10 )
ADDRFP4 4
INDIRI4
CNSTI4 10
NEI4 $494
line 973
;973:				{
line 974
;974:					if ( te->tfstate & TFSTATE_RANDOMPC )
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $495
line 975
;975:						num++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 976
;976:				} else
ADDRGP4 $495
JUMPV
LABELV $494
line 977
;977:				{
line 978
;978:					if ( te->playerclass == pc || te->nextpc == pc )
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $500
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $498
LABELV $500
line 979
;979:					{
line 980
;980:						if ( !( te->tfstate & TFSTATE_RANDOMPC ) )
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $501
line 981
;981:							num++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $501
line 982
;982:					}
LABELV $498
line 983
;983:				}
LABELV $495
line 984
;984:			}
LABELV $492
line 985
;985:		}
LABELV $489
line 968
LABELV $491
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $156
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
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
NEU4 $488
line 986
;986:		if ( num >= max )
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $503
line 987
;987:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $477
JUMPV
LABELV $503
line 988
;988:	}
LABELV $486
line 989
;989:	if ( max == -1 )
ADDRLP4 4
INDIRI4
CNSTI4 -1
NEI4 $505
line 990
;990:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $477
JUMPV
LABELV $505
line 991
;991:	return 0;
CNSTI4 0
RETI4
LABELV $477
endproc ClassIsRestricted 32 12
export teamsprint
proc teamsprint 8 12
line 995
;992:}
;993:
;994:void teamsprint( int tno, gedict_t * ignore, char *st )
;995:{
line 998
;996:	gedict_t *te;
;997:
;998:	if ( !tno )
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $508
line 999
;999:		return;
ADDRGP4 $507
JUMPV
LABELV $508
line 1001
;1000:
;1001:	for ( te = world;( te = trap_find( te, FOFS( s.v.classname ), "player" ) ) ; )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $513
JUMPV
LABELV $510
line 1002
;1002:	{
line 1003
;1003:		if ( te->team_no == tno && te != ignore )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $514
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
EQU4 $514
line 1004
;1004:			G_sprint( te, 2, st );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $514
line 1005
;1005:	}
LABELV $511
line 1001
LABELV $513
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $156
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
NEU4 $510
line 1006
;1006:}
LABELV $507
endproc teamsprint 8 12
data
export teams_allied
align 4
LABELV teams_allied
byte 4 0
lit
align 4
LABELV team_allied_bitindex
byte 4 0
byte 4 1
byte 4 2
byte 4 4
byte 4 1
byte 4 0
byte 4 8
byte 4 16
byte 4 2
byte 4 8
byte 4 0
byte 4 32
byte 4 4
byte 4 16
byte 4 32
byte 4 0
export TeamFortress_isTeamsAllied
code
proc TeamFortress_isTeamsAllied 20 0
line 1025
;1007:
;1008:int teams_allied = 0;
;1009:const static int team_allied_bitindex[4][4] = 
;1010:{
;1011:	{  0,  1,  2,  4},
;1012:	{  1,  0,  8, 16},
;1013:	{  2,  8,  0, 32},
;1014:	{  4, 16, 32,  0}
;1015:};
;1016:/*
;1017:    1  - team 1 & 2
;1018:    2  - team 1 & 3
;1019:    4  - team 1 & 4
;1020:    8  - team 2 & 3
;1021:   16  - team 2 & 4
;1022:   32  - team 3 & 4
;1023:*/
;1024:qboolean TeamFortress_isTeamsAllied( int teamno1, int teamno2 )
;1025:{
line 1026
;1026:        if( teamno1 == teamno2 )
ADDRFP4 0
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $517
line 1027
;1027:        	return true;
CNSTI4 1
RETI4
ADDRGP4 $516
JUMPV
LABELV $517
line 1029
;1028:	
;1029:	if(!teamno1 || !teamno2 || teamno1 > 4 || teamno2 > 4 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $523
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $523
ADDRLP4 12
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
GTI4 $523
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $519
LABELV $523
line 1030
;1030:		   return false;
CNSTI4 0
RETI4
ADDRGP4 $516
JUMPV
LABELV $519
line 1031
;1031:	return teams_allied & team_allied_bitindex[teamno1-1][teamno2-1];
ADDRLP4 16
CNSTI4 4
ASGNI4
ADDRGP4 teams_allied
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRI4
SUBI4
ADDRFP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRGP4 team_allied_bitindex-16
ADDP4
ADDP4
INDIRI4
BANDI4
RETI4
LABELV $516
endproc TeamFortress_isTeamsAllied 20 0
import UpdateServerinfoScores
bss
align 4
LABELV teamadvantage
skip 20
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
import TeamFortress_CanGetWeapon
import TeamFortress_GetMaxAmmo
import DoGroupWork
import DoGoalWork
import TeamFortress_AutoID
import decrement_team_ammoboxes
import increment_team_ammoboxes
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
import ParseTFDetect
import CheckExistence
import AttemptToActivate
import Activated
import Findgoal
import Finditem
import DisplayItemStatus
import TeamFortress_DetpackExplode
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
import TeamFortress_EngineerBuild
import TeamFortress_SpyGoUndercover
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
import TeamFortress_AmmoboxRemove
import TeamFortress_GetSkinByTeamClass
import TeamFortress_GetSkin
import TeamFortress_Alias
import KickCheater
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
export teammaxplayers
align 4
LABELV teammaxplayers
skip 20
export teamlives
align 4
LABELV teamlives
skip 20
export teamfrags
align 4
LABELV teamfrags
skip 20
export teamscores
align 4
LABELV teamscores
skip 20
export civilianteams
align 4
LABELV civilianteams
skip 4
export illegalclasses
align 4
LABELV illegalclasses
skip 20
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
LABELV $476
byte 1 99
byte 1 114
byte 1 95
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $475
byte 1 99
byte 1 114
byte 1 95
byte 1 114
byte 1 97
byte 1 0
align 1
LABELV $474
byte 1 99
byte 1 114
byte 1 95
byte 1 101
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 101
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $473
byte 1 99
byte 1 114
byte 1 95
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $472
byte 1 99
byte 1 114
byte 1 95
byte 1 115
byte 1 112
byte 1 121
byte 1 0
align 1
LABELV $471
byte 1 99
byte 1 114
byte 1 95
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $470
byte 1 99
byte 1 114
byte 1 95
byte 1 112
byte 1 121
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $469
byte 1 99
byte 1 114
byte 1 95
byte 1 112
byte 1 121
byte 1 0
align 1
LABELV $468
byte 1 99
byte 1 114
byte 1 95
byte 1 104
byte 1 119
byte 1 103
byte 1 117
byte 1 121
byte 1 0
align 1
LABELV $467
byte 1 99
byte 1 114
byte 1 95
byte 1 104
byte 1 119
byte 1 0
align 1
LABELV $466
byte 1 99
byte 1 114
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $465
byte 1 99
byte 1 114
byte 1 95
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $464
byte 1 99
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 109
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $463
byte 1 99
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $462
byte 1 99
byte 1 114
byte 1 95
byte 1 115
byte 1 111
byte 1 108
byte 1 100
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $461
byte 1 99
byte 1 114
byte 1 95
byte 1 115
byte 1 111
byte 1 0
align 1
LABELV $460
byte 1 99
byte 1 114
byte 1 95
byte 1 115
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $459
byte 1 99
byte 1 114
byte 1 95
byte 1 115
byte 1 110
byte 1 0
align 1
LABELV $458
byte 1 99
byte 1 114
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $457
byte 1 99
byte 1 114
byte 1 95
byte 1 115
byte 1 99
byte 1 0
align 1
LABELV $445
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $440
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 101
byte 1 113
byte 1 117
byte 1 97
byte 1 108
byte 1 105
byte 1 115
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $439
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $433
byte 1 84
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 100
byte 1 118
byte 1 97
byte 1 110
byte 1 116
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $419
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 69
byte 1 113
byte 1 117
byte 1 97
byte 1 108
byte 1 105
byte 1 115
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $347
byte 1 32
byte 1 39
byte 1 37
byte 1 51
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 51
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 51
byte 1 46
byte 1 48
byte 1 102
byte 1 39
byte 1 0
align 1
LABELV $344
byte 1 32
byte 1 78
byte 1 79
byte 1 83
byte 1 69
byte 1 78
byte 1 84
byte 1 82
byte 1 89
byte 1 0
align 1
LABELV $343
byte 1 32
byte 1 83
byte 1 69
byte 1 78
byte 1 84
byte 1 82
byte 1 89
byte 1 58
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 0
align 1
LABELV $340
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
LABELV $330
byte 1 32
byte 1 68
byte 1 84
byte 1 80
byte 1 58
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 0
align 1
LABELV $327
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $318
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $313
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 47
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 0
align 1
LABELV $312
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $311
byte 1 32
byte 1 71
byte 1 0
align 1
LABELV $308
byte 1 32
byte 1 89
byte 1 0
align 1
LABELV $305
byte 1 32
byte 1 82
byte 1 0
align 1
LABELV $298
byte 1 32
byte 1 40
byte 1 82
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 41
byte 1 0
align 1
LABELV $295
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $283
byte 1 84
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 110
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
byte 1 111
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $280
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $279
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $263
byte 1 89
byte 1 101
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $262
byte 1 68
byte 1 97
byte 1 114
byte 1 107
byte 1 71
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $261
byte 1 71
byte 1 114
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $260
byte 1 68
byte 1 97
byte 1 114
byte 1 107
byte 1 80
byte 1 117
byte 1 114
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $259
byte 1 80
byte 1 117
byte 1 114
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $258
byte 1 79
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $257
byte 1 80
byte 1 105
byte 1 110
byte 1 107
byte 1 0
align 1
LABELV $256
byte 1 84
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $255
byte 1 82
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $254
byte 1 71
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $253
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $252
byte 1 66
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $251
byte 1 87
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $250
byte 1 68
byte 1 97
byte 1 114
byte 1 107
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $245
byte 1 41
byte 1 32
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $242
byte 1 37
byte 1 99
byte 1 0
align 1
LABELV $239
byte 1 32
byte 1 40
byte 1 0
align 1
LABELV $234
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 0
align 1
LABELV $226
byte 1 212
byte 1 232
byte 1 229
byte 1 160
byte 1 231
byte 1 225
byte 1 237
byte 1 229
byte 1 160
byte 1 233
byte 1 243
byte 1 32
byte 1 144
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 145
byte 1 10
byte 1 0
align 1
LABELV $225
byte 1 145
byte 1 10
byte 1 0
align 1
LABELV $224
byte 1 145
byte 1 32
byte 1 233
byte 1 243
byte 1 160
byte 1 236
byte 1 229
byte 1 225
byte 1 228
byte 1 233
byte 1 238
byte 1 231
byte 1 160
byte 1 226
byte 1 249
byte 1 32
byte 1 144
byte 1 0
align 1
LABELV $223
byte 1 144
byte 1 0
align 1
LABELV $218
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 117
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $217
byte 1 10
byte 1 0
align 1
LABELV $212
byte 1 32
byte 1 0
align 1
LABELV $211
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $210
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $156
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $139
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
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
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 32
byte 1 68
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $138
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
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
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $133
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
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
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 46
byte 1 32
byte 1 68
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $132
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
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
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $129
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $124
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
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
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 116
byte 1 111
byte 1 112
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 46
byte 1 32
byte 1 68
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $119
byte 1 116
byte 1 111
byte 1 112
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $113
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
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
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 112
byte 1 97
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 46
byte 1 32
byte 1 68
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $112
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
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
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $107
byte 1 98
byte 1 111
byte 1 116
byte 1 116
byte 1 111
byte 1 109
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $86
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 78
byte 1 111
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $77
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 78
byte 1 111
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $76
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 46
byte 1 32
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 112
byte 1 97
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 44
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 97
byte 1 103
byte 1 97
byte 1 105
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $75
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
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 110
byte 1 101
byte 1 119
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 44
byte 1 32
byte 1 115
byte 1 105
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 97
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 0
align 1
LABELV $70
byte 1 84
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 32
byte 1 80
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 97
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $67
byte 1 89
byte 1 111
byte 1 117
byte 1 39
byte 1 114
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 78
byte 1 111
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $64
byte 1 84
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 111
byte 1 110
byte 1 108
byte 1 121
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 46
byte 1 10
byte 1 84
byte 1 114
byte 1 121
byte 1 32
byte 1 97
byte 1 103
byte 1 97
byte 1 105
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $61
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 79
byte 1 110
byte 1 44
byte 1 32
byte 1 115
byte 1 111
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 116
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $57
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $56
byte 1 0
align 1
LABELV $54
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $48
byte 1 34
byte 1 34
byte 1 0
align 1
LABELV $43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $41
byte 1 116
byte 1 52
byte 1 0
align 1
LABELV $40
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 52
byte 1 0
align 1
LABELV $39
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $37
byte 1 116
byte 1 51
byte 1 0
align 1
LABELV $36
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 51
byte 1 0
align 1
LABELV $35
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $33
byte 1 116
byte 1 50
byte 1 0
align 1
LABELV $32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 50
byte 1 0
align 1
LABELV $31
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $30
byte 1 116
byte 1 49
byte 1 0
align 1
LABELV $29
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 49
byte 1 0
