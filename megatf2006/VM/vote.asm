data
export votes
align 4
LABELV votes
address $11
address Vote_ChangeMap_Init
address Vote_ChangeMap_Yes
address Vote_ChangeMap_No
byte 4 60
byte 4 3
address $12
address Vote_Elect_Init
address Vote_Elect_Yes
address Vote_Elect_No
byte 4 60
byte 4 3
byte 4 0
skip 20
align 4
LABELV k_vote
byte 4 0
export current_vote
align 4
LABELV current_vote
byte 4 -1
export CountPlayers
code
proc CountPlayers 12 12
file "..\src\vote.c"
line 53
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
;21: *  $Id: vote.c,v 1.7 2006/03/02 12:08:56 AngelD Exp $
;22: */
;23:
;24:// vote.q: mapchange voting functions
;25:#include "g_local.h"
;26:
;27:void Vote_ChangeMap_Init();
;28:void Vote_ChangeMap_Yes();
;29:void Vote_ChangeMap_No();
;30:
;31:void Vote_Elect_Init();
;32:void Vote_Elect_Yes();
;33:void Vote_Elect_No();
;34:static float elect_percentage;
;35:static int elect_level;
;36:static gedict_t* elect_player;
;37:
;38:
;39:const vote_t votes[]=
;40:{
;41:	{"changemap", Vote_ChangeMap_Init, Vote_ChangeMap_Yes, Vote_ChangeMap_No, 60, 3},
;42:	{"elect", Vote_Elect_Init, Vote_Elect_Yes, Vote_Elect_No, 60, 3},
;43:	{NULL}
;44:};
;45:static int		k_vote = 0;
;46:int 		current_vote = -1;
;47:
;48:
;49:void NextLevel();
;50:
;51:
;52:int CountPlayers()
;53:{
line 54
;54:	gedict_t	*p=world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 55
;55:	int 		num = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $15
JUMPV
LABELV $14
line 58
;56:
;57:	while((p = trap_find(p, FOFS(s.v.classname), "player"))) 
;58:		if(p->s.v.netname[0]) 
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $18
line 59
;59:			num++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $18
LABELV $15
line 57
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $17
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
line 61
;60:
;61:	return num;
ADDRLP4 4
INDIRI4
RETI4
LABELV $13
endproc CountPlayers 12 12
export VoteThink
proc VoteThink 8 12
line 65
;62:}
;63:
;64:void VoteThink()
;65:{
line 66
;66:	gedict_t* p=world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 68
;67:
;68:	G_bprint(2, "The voting has timed out.\n");
CNSTI4 2
ARGI4
ADDRGP4 $21
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 69
;69:	self->s.v.nextthink = -1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
CNSTF4 3212836864
ASGNF4
line 70
;70:	k_vote = 0;
ADDRGP4 k_vote
CNSTI4 0
ASGNI4
line 71
;71:	current_vote = -1;
ADDRGP4 current_vote
CNSTI4 -1
ASGNI4
ADDRGP4 $23
JUMPV
LABELV $22
line 73
;72:        while((p = trap_find(p, FOFS(s.v.classname), "player"))) 
;73:        {
line 74
;74:		if(p->s.v.netname[0] ) p->k_voted = 0;
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $25
ADDRLP4 0
INDIRP4
CNSTI4 1628
ADDP4
CNSTI4 0
ASGNI4
LABELV $25
line 75
;75:	}
LABELV $23
line 72
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $17
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
NEU4 $22
line 76
;76:	dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 77
;77:}
LABELV $20
endproc VoteThink 8 12
export Vote_ChangeMap_Init
proc Vote_ChangeMap_Init 24 12
line 80
;78:
;79:void Vote_ChangeMap_Init()
;80:{
line 84
;81:	int f1;
;82:	gedict_t* voteguard;
;83:
;84:	f1 = CountPlayers();
ADDRLP4 8
ADDRGP4 CountPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 85
;85:	if(f1 == 1) {
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $28
line 86
;86:		G_bprint(2, "%s changes map\n",self->s.v.netname);
CNSTI4 2
ARGI4
ADDRGP4 $30
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
line 87
;87:		current_vote = -1;
ADDRGP4 current_vote
CNSTI4 -1
ASGNI4
line 88
;88:		NextLevel();
ADDRGP4 NextLevel
CALLV
pop
line 89
;89:		return;	// in case we get back here
ADDRGP4 $27
JUMPV
LABELV $28
line 93
;90:	}
;91:
;92:	
;93:	G_bprint(2, "%s votes for mapchange\n",self->s.v.netname);
CNSTI4 2
ARGI4
ADDRGP4 $31
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
line 95
;94:
;95:	if(f1/2 !=1)
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 1
EQI4 $32
line 96
;96:		G_bprint(2, "%d‘ total votes needed\nType ",f1/2);
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 $34
ARGP4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
DIVI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $33
JUMPV
LABELV $32
line 98
;97:	else
;98:		G_bprint(2, "%d‘ total vote needed\nType ",f1/2);
ADDRLP4 16
CNSTI4 2
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 $35
ARGP4
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
DIVI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
LABELV $33
line 100
;99:
;100:	G_bprint(3, "ãíä öïôå ùåó");
CNSTI4 3
ARGI4
ADDRGP4 $36
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 101
;101:	G_bprint(2, " in console to approve\n");
CNSTI4 2
ARGI4
ADDRGP4 $37
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 103
;102:
;103:	k_vote = 1;
ADDRGP4 k_vote
CNSTI4 1
ASGNI4
line 104
;104:	self->k_voted = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1628
ADDP4
CNSTI4 1
ASGNI4
line 105
;105:	voteguard = spawn(); // Check the 1 minute timeout for voting
ADDRLP4 20
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 106
;106:	voteguard->s.v.owner = EDICT_TO_PROG(world);
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
line 107
;107:	voteguard->s.v.classname  = "voteguard";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $38
ASGNP4
line 108
;108:	voteguard->s.v.think = (func_t) VoteThink;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 VoteThink
CVPU4 4
CVUI4 4
ASGNI4
line 109
;109:	voteguard->s.v.nextthink = g_globalvars.time + votes[current_vote].timeout;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTI4 24
ADDRGP4 current_vote
INDIRI4
MULI4
ADDRGP4 votes+16
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 110
;110:}
LABELV $27
endproc Vote_ChangeMap_Init 24 12
export Vote_ChangeMap_Yes
proc Vote_ChangeMap_Yes 28 12
line 113
;111:
;112:void Vote_ChangeMap_Yes()
;113:{
line 115
;114:	int 		f1, f2;
;115:	gedict_t* 	p = world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 117
;116:
;117:	if(!k_vote) return;
ADDRGP4 k_vote
INDIRI4
CNSTI4 0
NEI4 $42
ADDRGP4 $41
JUMPV
LABELV $42
line 119
;118:
;119:	if(self->k_voted) {
ADDRGP4 self
INDIRP4
CNSTI4 1628
ADDP4
INDIRI4
CNSTI4 0
EQI4 $44
line 120
;120:		G_sprint(self, 2, "--- your vote is still good ---\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $46
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 121
;121:		return;
ADDRGP4 $41
JUMPV
LABELV $44
line 125
;122:	}
;123:
;124:// register the vote
;125:	k_vote ++;
ADDRLP4 12
ADDRGP4 k_vote
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 126
;126:	G_bprint(2, "%s votes for mapchange\n",self->s.v.netname);
CNSTI4 2
ARGI4
ADDRGP4 $31
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
line 127
;127:	f1 = CountPlayers();
ADDRLP4 16
ADDRGP4 CountPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 128
;128:	f2 = f1 / 2 + 1;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 1
ADDI4
ASGNI4
line 129
;129:	if(k_vote >= f2) {
ADDRGP4 k_vote
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $47
line 130
;130:		G_bprint(3, "Map changed by majority vote\n");
CNSTI4 3
ARGI4
ADDRGP4 $49
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 131
;131:		k_vote = 0;
ADDRGP4 k_vote
CNSTI4 0
ASGNI4
line 132
;132:		current_vote = -1;
ADDRGP4 current_vote
CNSTI4 -1
ASGNI4
ADDRGP4 $51
JUMPV
LABELV $50
line 134
;133:        	while((p = trap_find(p, FOFS(s.v.classname), "player"))) 
;134:        	{
line 135
;135:			if(p->s.v.netname[0] ) p->k_voted = 0;
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $53
ADDRLP4 0
INDIRP4
CNSTI4 1628
ADDP4
CNSTI4 0
ASGNI4
LABELV $53
line 136
;136:		}
LABELV $51
line 133
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $17
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
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
NEU4 $50
line 138
;137:
;138:		p = trap_find(world, FOFS(s.v.classname), "voteguard");
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $38
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 139
;139:		if(p) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $55
line 140
;140:			p->s.v.classname  = "";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $57
ASGNP4
line 141
;141:		 dremove(p);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 142
;142:		}
LABELV $55
line 143
;143:		NextLevel();
ADDRGP4 NextLevel
CALLV
pop
line 144
;144:		return;
ADDRGP4 $41
JUMPV
LABELV $47
line 148
;145:	}
;146:
;147:// calculate how many more votes are needed
;148:	self->k_voted = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1628
ADDP4
CNSTI4 1
ASGNI4
line 149
;149:	f1 = f2 - k_vote;
ADDRLP4 4
ADDRLP4 8
INDIRI4
ADDRGP4 k_vote
INDIRI4
SUBI4
ASGNI4
line 150
;150:	if(f1>1)
ADDRLP4 4
INDIRI4
CNSTI4 1
LEI4 $58
line 151
;151:		G_bprint(2, "%d‘ more votes needed\n",f1);
CNSTI4 2
ARGI4
ADDRGP4 $60
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $59
JUMPV
LABELV $58
line 153
;152:	else
;153:		G_bprint(2, "%d‘ more vote needed\n",f1);	
CNSTI4 2
ARGI4
ADDRGP4 $61
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
LABELV $59
line 154
;154:}
LABELV $41
endproc Vote_ChangeMap_Yes 28 12
export Vote_ChangeMap_No
proc Vote_ChangeMap_No 24 12
line 157
;155:
;156:void Vote_ChangeMap_No()
;157:{
line 162
;158:	gedict_t* p;
;159:	int f1, f2;
;160:
;161:// withdraw one's vote
;162:	if(!k_vote || !self->k_voted) return;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 k_vote
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $65
ADDRGP4 self
INDIRP4
CNSTI4 1628
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $63
LABELV $65
ADDRGP4 $62
JUMPV
LABELV $63
line 164
;163:
;164:	G_bprint(2, "%s would rather play this map\n",self->s.v.netname);
CNSTI4 2
ARGI4
ADDRGP4 $66
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
line 165
;165:	self->k_voted = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1628
ADDP4
CNSTI4 0
ASGNI4
line 166
;166:	k_vote--;
ADDRLP4 16
ADDRGP4 k_vote
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 167
;167:	if(!k_vote) {
ADDRGP4 k_vote
INDIRI4
CNSTI4 0
NEI4 $67
line 168
;168:		G_bprint(3, "Voting is closed\n");
CNSTI4 3
ARGI4
ADDRGP4 $69
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 169
;169:		p = trap_find(world, FOFS(s.v.classname), "voteguard");
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $38
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 170
;170:		if(p) 
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $70
line 171
;171:		{
line 172
;172:			p->s.v.classname  = "";
ADDRLP4 8
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $57
ASGNP4
line 173
;173:		 	dremove(p);
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 174
;174:		}
LABELV $70
line 175
;175:		current_vote = -1;
ADDRGP4 current_vote
CNSTI4 -1
ASGNI4
line 176
;176:		return;
ADDRGP4 $62
JUMPV
LABELV $67
line 178
;177:	}
;178:	f1 = CountPlayers();
ADDRLP4 20
ADDRGP4 CountPlayers
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 179
;179:	f2 = (f1 / 2) + 1;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 1
ADDI4
ASGNI4
line 180
;180:	f1 = f2 - k_vote;
ADDRLP4 0
ADDRLP4 4
INDIRI4
ADDRGP4 k_vote
INDIRI4
SUBI4
ASGNI4
line 181
;181:	if(f1 > 1)
ADDRLP4 0
INDIRI4
CNSTI4 1
LEI4 $72
line 182
;182:		G_bprint(2, "%d‘ more votes needed\n",f1);
CNSTI4 2
ARGI4
ADDRGP4 $60
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $73
JUMPV
LABELV $72
line 184
;183:	else
;184:		G_bprint(2, "%d‘ more vote needed\n",f1);
CNSTI4 2
ARGI4
ADDRGP4 $61
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
LABELV $73
line 185
;185:}
LABELV $62
endproc Vote_ChangeMap_No 24 12
export Vote_Elect_Init
proc Vote_Elect_Init 32 16
line 188
;186:
;187:void Vote_Elect_Init()
;188:{
line 193
;189:	int f1;
;190:	int needed_votes;
;191:	gedict_t* voteguard;
;192:
;193:	elect_percentage = GetSVInfokeyInt(  "electpercentage", NULL, 50 );
ADDRGP4 $75
ARGP4
CNSTP4 0
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 12
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 elect_percentage
ADDRLP4 12
INDIRI4
CVIF4 4
ASGNF4
line 194
;194:	elect_level  = GetSVInfokeyInt(  "electlevel", NULL, 1 );
ADDRGP4 $76
ARGP4
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 elect_level
ADDRLP4 16
INDIRI4
ASGNI4
line 195
;195:	elect_player = self;
ADDRGP4 elect_player
ADDRGP4 self
INDIRP4
ASGNP4
line 196
;196:	if(!elect_percentage || !elect_level)
ADDRGP4 elect_percentage
INDIRF4
CNSTF4 0
EQF4 $79
ADDRGP4 elect_level
INDIRI4
CNSTI4 0
NEI4 $77
LABELV $79
line 197
;197:	{
line 198
;198:		G_sprint( self, 2, "Admin election disabled\n",self->s.v.netname);
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $80
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 199
;199:		return;
ADDRGP4 $74
JUMPV
LABELV $77
line 202
;200:	}
;201:
;202:	if ( self->is_admin >= elect_level ) 
ADDRGP4 self
INDIRP4
CNSTI4 1564
ADDP4
INDIRI4
ADDRGP4 elect_level
INDIRI4
LTI4 $81
line 203
;203:	{
line 204
;204:		G_sprint(self, 2, "You are already an admin\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $83
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 205
;205:		return;
ADDRGP4 $74
JUMPV
LABELV $81
line 208
;206:	}
;207:
;208:	if( elect_percentage < 5 || elect_percentage > 95)
ADDRLP4 20
ADDRGP4 elect_percentage
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 1084227584
LTF4 $86
ADDRLP4 20
INDIRF4
CNSTF4 1119748096
LEF4 $84
LABELV $86
line 209
;209:		elect_percentage = 50;
ADDRGP4 elect_percentage
CNSTF4 1112014848
ASGNF4
LABELV $84
line 211
;210:
;211:	f1 = CountPlayers();
ADDRLP4 24
ADDRGP4 CountPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
line 213
;212:	
;213:	if(  elect_percentage * f1 < 100 ) 
ADDRGP4 elect_percentage
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
CNSTF4 1120403456
GEF4 $87
line 214
;214:	{
line 215
;215:		G_bprint(2,  "%s çáéîó áäíéî óôáôõó!\n", elect_player->s.v.netname);
CNSTI4 2
ARGI4
ADDRGP4 $89
ARGP4
ADDRGP4 elect_player
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 216
;216:		G_sprint(elect_player, 2, "Type ãíä áäíéî for admin commands.\n");
ADDRGP4 elect_player
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $90
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 217
;217:		current_vote = -1;
ADDRGP4 current_vote
CNSTI4 -1
ASGNI4
line 218
;218:		elect_player->is_admin = elect_level;
ADDRGP4 elect_player
INDIRP4
CNSTI4 1564
ADDP4
ADDRGP4 elect_level
INDIRI4
ASGNI4
line 219
;219:		return;	
ADDRGP4 $74
JUMPV
LABELV $87
line 223
;220:	}
;221:
;222:	
;223:	G_bprint(2, "%s has requested admin rights!\n",self->s.v.netname);
CNSTI4 2
ARGI4
ADDRGP4 $91
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
line 225
;224:
;225:	k_vote = 1;
ADDRGP4 k_vote
CNSTI4 1
ASGNI4
line 226
;226:	self->k_voted = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1628
ADDP4
CNSTI4 1
ASGNI4
line 227
;227:	needed_votes = (int)(f1 * elect_percentage / 100)+1 - k_vote;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRGP4 elect_percentage
INDIRF4
MULF4
CNSTF4 1120403456
DIVF4
CVFI4 4
CNSTI4 1
ADDI4
ADDRGP4 k_vote
INDIRI4
SUBI4
ASGNI4
line 229
;228:
;229:	if( needed_votes > 1 )
ADDRLP4 8
INDIRI4
CNSTI4 1
LEI4 $92
line 230
;230:		G_bprint(2, "%d‘ total votes needed\nType ",needed_votes);
CNSTI4 2
ARGI4
ADDRGP4 $34
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $93
JUMPV
LABELV $92
line 232
;231:	else
;232:		G_bprint(2, "%d‘ total vote needed\nType ", needed_votes);
CNSTI4 2
ARGI4
ADDRGP4 $35
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
LABELV $93
line 234
;233:
;234:	G_bprint(3, "ãíä öïôå ùåó");
CNSTI4 3
ARGI4
ADDRGP4 $36
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 235
;235:	G_bprint(2, " in console to approve\n");
CNSTI4 2
ARGI4
ADDRGP4 $37
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 237
;236:
;237:	voteguard = spawn(); // Check the 1 minute timeout for voting
ADDRLP4 28
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 238
;238:	voteguard->s.v.owner = EDICT_TO_PROG(world);
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
line 239
;239:	voteguard->s.v.classname  = "voteguard";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $38
ASGNP4
line 240
;240:	voteguard->s.v.think = (func_t) VoteThink;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 VoteThink
CVPU4 4
CVUI4 4
ASGNI4
line 241
;241:	voteguard->s.v.nextthink = g_globalvars.time + votes[current_vote].timeout;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTI4 24
ADDRGP4 current_vote
INDIRI4
MULI4
ADDRGP4 votes+16
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 242
;242:}
LABELV $74
endproc Vote_Elect_Init 32 16
export Vote_Elect_Yes
proc Vote_Elect_Yes 28 12
line 245
;243:
;244:void Vote_Elect_Yes()
;245:{
line 247
;246:	int 		f1, needed_votes;
;247:	gedict_t* 	p = world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 249
;248:
;249:	if(!k_vote) return;
ADDRGP4 k_vote
INDIRI4
CNSTI4 0
NEI4 $97
ADDRGP4 $96
JUMPV
LABELV $97
line 251
;250:
;251:	if(self->k_voted) {
ADDRGP4 self
INDIRP4
CNSTI4 1628
ADDP4
INDIRI4
CNSTI4 0
EQI4 $99
line 252
;252:		G_sprint(self, 2, "--- your vote is still good ---\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $46
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 253
;253:		return;
ADDRGP4 $96
JUMPV
LABELV $99
line 257
;254:	}
;255:
;256:// register the vote
;257:	k_vote ++;
ADDRLP4 12
ADDRGP4 k_vote
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 258
;258:	G_bprint(2, "%s gives his vote\n",self->s.v.netname);
CNSTI4 2
ARGI4
ADDRGP4 $101
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
line 259
;259:	f1 = CountPlayers();
ADDRLP4 16
ADDRGP4 CountPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 260
;260:	needed_votes = (int)(f1 * elect_percentage / 100)+1 - k_vote;
ADDRLP4 4
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRGP4 elect_percentage
INDIRF4
MULF4
CNSTF4 1120403456
DIVF4
CVFI4 4
CNSTI4 1
ADDI4
ADDRGP4 k_vote
INDIRI4
SUBI4
ASGNI4
line 263
;261:
;262:	//if(  elect_percentage * f1 < 100 * k_vote ) 
;263:	if( needed_votes < 1)
ADDRLP4 4
INDIRI4
CNSTI4 1
GEI4 $102
line 264
;264:	{
line 265
;265:		k_vote = 0;
ADDRGP4 k_vote
CNSTI4 0
ASGNI4
line 266
;266:		current_vote = -1;
ADDRGP4 current_vote
CNSTI4 -1
ASGNI4
ADDRGP4 $105
JUMPV
LABELV $104
line 268
;267:        	while((p = trap_find(p, FOFS(s.v.classname), "player"))) 
;268:        	{
line 269
;269:			if( p->s.v.netname[0] ) p->k_voted = 0;
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $107
ADDRLP4 0
INDIRP4
CNSTI4 1628
ADDP4
CNSTI4 0
ASGNI4
LABELV $107
line 270
;270:		}
LABELV $105
line 267
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $17
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
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
NEU4 $104
line 272
;271:
;272:		p = trap_find(world, FOFS(s.v.classname), "voteguard");
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $38
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 273
;273:		if(p) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $109
line 274
;274:			p->s.v.classname  = "";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $57
ASGNP4
line 275
;275:		 dremove(p);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 276
;276:		}
LABELV $109
line 277
;277:		G_bprint(2,  "%s çáéîó áäíéî óôáôõó!\n", elect_player->s.v.netname);
CNSTI4 2
ARGI4
ADDRGP4 $89
ARGP4
ADDRGP4 elect_player
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 278
;278:		G_sprint(elect_player, 2, "Type ãíä áäíéî for admin commands.\n");
ADDRGP4 elect_player
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $90
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 279
;279:		elect_player->is_admin = elect_level;
ADDRGP4 elect_player
INDIRP4
CNSTI4 1564
ADDP4
ADDRGP4 elect_level
INDIRI4
ASGNI4
line 280
;280:		return;	
ADDRGP4 $96
JUMPV
LABELV $102
line 284
;281:	}
;282:
;283:// calculate how many more votes are needed
;284:	self->k_voted = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1628
ADDP4
CNSTI4 1
ASGNI4
line 286
;285:
;286:	if( needed_votes > 1)
ADDRLP4 4
INDIRI4
CNSTI4 1
LEI4 $111
line 287
;287:		G_bprint(2, "%d‘ total votes needed\nType ", needed_votes);
CNSTI4 2
ARGI4
ADDRGP4 $34
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $112
JUMPV
LABELV $111
line 289
;288:	else
;289:		G_bprint(2, "%d‘ total vote needed\nType ", needed_votes);
CNSTI4 2
ARGI4
ADDRGP4 $35
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
LABELV $112
line 292
;290:
;291:
;292:}
LABELV $96
endproc Vote_Elect_Yes 28 12
export Vote_Elect_No
proc Vote_Elect_No 24 12
line 295
;293:
;294:void Vote_Elect_No()
;295:{
line 300
;296:	gedict_t* p;
;297:	int f1, needed_votes;
;298:
;299:// withdraw one's vote
;300:	if(!k_vote || !self->k_voted) return;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 k_vote
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $116
ADDRGP4 self
INDIRP4
CNSTI4 1628
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $114
LABELV $116
ADDRGP4 $113
JUMPV
LABELV $114
line 302
;301:
;302:	G_bprint(2, "%s withdraws his vote\n",self->s.v.netname);
CNSTI4 2
ARGI4
ADDRGP4 $117
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
line 303
;303:	self->k_voted = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1628
ADDP4
CNSTI4 0
ASGNI4
line 304
;304:	k_vote--;
ADDRLP4 16
ADDRGP4 k_vote
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 305
;305:	if(!k_vote) {
ADDRGP4 k_vote
INDIRI4
CNSTI4 0
NEI4 $118
line 306
;306:		G_bprint(3, "Voting is closed\n");
CNSTI4 3
ARGI4
ADDRGP4 $69
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 307
;307:		p = trap_find(world, FOFS(s.v.classname), "voteguard");
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $38
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 308
;308:		if(p) 
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $120
line 309
;309:		{
line 310
;310:			p->s.v.classname  = "";
ADDRLP4 8
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $57
ASGNP4
line 311
;311:		 	dremove(p);
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 312
;312:		}
LABELV $120
line 313
;313:		current_vote = -1;
ADDRGP4 current_vote
CNSTI4 -1
ASGNI4
line 314
;314:		return;
ADDRGP4 $113
JUMPV
LABELV $118
line 317
;315:	}
;316:
;317:	f1 = CountPlayers();
ADDRLP4 20
ADDRGP4 CountPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 318
;318:	needed_votes = (int)(f1 * elect_percentage / 100)+1 - k_vote;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRGP4 elect_percentage
INDIRF4
MULF4
CNSTF4 1120403456
DIVF4
CVFI4 4
CNSTI4 1
ADDI4
ADDRGP4 k_vote
INDIRI4
SUBI4
ASGNI4
line 321
;319:
;320:	
;321:	if(needed_votes > 1)
ADDRLP4 0
INDIRI4
CNSTI4 1
LEI4 $122
line 322
;322:		G_bprint(2, "%d‘ more votes needed\n",needed_votes);
CNSTI4 2
ARGI4
ADDRGP4 $60
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $123
JUMPV
LABELV $122
line 324
;323:	else
;324:		G_bprint(2, "%d‘ more vote needed\n",needed_votes);
CNSTI4 2
ARGI4
ADDRGP4 $61
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
LABELV $123
line 325
;325:}
LABELV $113
endproc Vote_Elect_No 24 12
export Vote_Cmd
proc Vote_Cmd 76 16
line 328
;326:
;327:void Vote_Cmd()
;328:{
line 333
;329:        char    cmd_command[50];
;330:        int argc,i;
;331:        const vote_t*ucmd;
;332:
;333:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $125
line 334
;334:	{
line 335
;335:		return;
ADDRGP4 $124
JUMPV
LABELV $125
line 338
;336:	}
;337:
;338:	argc = trap_CmdArgc();
ADDRLP4 64
ADDRGP4 trap_CmdArgc
CALLI4
ASGNI4
ADDRLP4 60
ADDRLP4 64
INDIRI4
ASGNI4
line 340
;339:	
;340:	if( argc != 2 )
ADDRLP4 60
INDIRI4
CNSTI4 2
EQI4 $129
line 341
;341:	{
line 342
;342:	        G_sprint( self, 2, "Avaliable votes:\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $131
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 343
;343:		for ( ucmd = votes ; ucmd->command  ; ucmd++ )
ADDRLP4 0
ADDRGP4 votes
ASGNP4
ADDRGP4 $135
JUMPV
LABELV $132
line 344
;344:		{
line 345
;345:			G_sprint( self, 2, "%s\n",ucmd->command);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $136
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 346
;346:		}
LABELV $133
line 343
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
LABELV $135
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $132
line 347
;347:		return;
ADDRGP4 $124
JUMPV
LABELV $129
line 350
;348:	}
;349:
;350:	trap_CmdArgv( 1, cmd_command, sizeof( cmd_command ) );
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 351
;351:	if( current_vote != -1 )
ADDRGP4 current_vote
INDIRI4
CNSTI4 -1
EQI4 $137
line 352
;352:	{
line 353
;353:		if(!strcmp(cmd_command,"yes"))
ADDRLP4 8
ARGP4
ADDRGP4 $141
ARGP4
ADDRLP4 68
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $139
line 354
;354:		{
line 355
;355:		        votes[current_vote].VoteYes();
CNSTI4 24
ADDRGP4 current_vote
INDIRI4
MULI4
ADDRGP4 votes+8
ADDP4
INDIRP4
CALLV
pop
line 356
;356:			return;
ADDRGP4 $124
JUMPV
LABELV $139
line 359
;357:		}
;358:
;359:		if(!strcmp(cmd_command,"no"))
ADDRLP4 8
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 72
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $143
line 360
;360:		{
line 361
;361:		        votes[current_vote].VoteNo();
CNSTI4 24
ADDRGP4 current_vote
INDIRI4
MULI4
ADDRGP4 votes+12
ADDP4
INDIRP4
CALLV
pop
line 362
;362:			return;
ADDRGP4 $124
JUMPV
LABELV $143
line 364
;363:		}
;364:		G_sprint( self, 2, "Vote %s in progress\n",votes[current_vote].command);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $147
ARGP4
CNSTI4 24
ADDRGP4 current_vote
INDIRI4
MULI4
ADDRGP4 votes
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 365
;365:	        return;
ADDRGP4 $124
JUMPV
LABELV $137
line 367
;366:	}
;367:	if( g_globalvars.time < self->last_vote_time )
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 1632
ADDP4
INDIRF4
GEF4 $148
line 368
;368:	{
line 369
;369:		G_sprint( self, 2, "You cannot vote at this time.\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $151
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 370
;370:		return;
ADDRGP4 $124
JUMPV
LABELV $148
line 372
;371:	}
;372:	for ( ucmd = votes,i=0 ; ucmd->command  ; ucmd++,i++ )
ADDRLP4 0
ADDRGP4 votes
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $155
JUMPV
LABELV $152
line 373
;373:	{
line 374
;374:		if( !strcmp(cmd_command,ucmd->command) )
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $156
line 375
;375:		{
line 376
;376:		        current_vote = i;
ADDRGP4 current_vote
ADDRLP4 4
INDIRI4
ASGNI4
line 377
;377:		        self->last_vote_time = g_globalvars.time + votes[current_vote].pause * 60;
ADDRGP4 self
INDIRP4
CNSTI4 1632
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTI4 60
CNSTI4 24
ADDRGP4 current_vote
INDIRI4
MULI4
ADDRGP4 votes+20
ADDP4
INDIRI4
MULI4
CVIF4 4
ADDF4
ASGNF4
line 378
;378:			ucmd->VoteInit();
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 379
;379:			return;
ADDRGP4 $124
JUMPV
LABELV $156
line 381
;380:		}
;381:	}
LABELV $153
line 372
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $155
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $152
line 382
;382:	G_sprint( self, 2, "Unknown vote.\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $160
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 383
;383:}
LABELV $124
endproc Vote_Cmd 76 16
import NextLevel
bss
align 4
LABELV elect_player
skip 4
align 4
LABELV elect_level
skip 4
align 4
LABELV elect_percentage
skip 4
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
LABELV $160
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $151
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $147
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $145
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $141
byte 1 121
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $136
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $131
byte 1 65
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 115
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $117
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $101
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $91
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $90
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 227
byte 1 237
byte 1 228
byte 1 32
byte 1 225
byte 1 228
byte 1 237
byte 1 233
byte 1 238
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $89
byte 1 37
byte 1 115
byte 1 32
byte 1 231
byte 1 225
byte 1 233
byte 1 238
byte 1 243
byte 1 32
byte 1 225
byte 1 228
byte 1 237
byte 1 233
byte 1 238
byte 1 32
byte 1 243
byte 1 244
byte 1 225
byte 1 244
byte 1 245
byte 1 243
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $83
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 97
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
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $80
byte 1 65
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $76
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $75
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 112
byte 1 101
byte 1 114
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $69
byte 1 86
byte 1 111
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $66
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 114
byte 1 97
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $61
byte 1 144
byte 1 37
byte 1 100
byte 1 145
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $60
byte 1 144
byte 1 37
byte 1 100
byte 1 145
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $57
byte 1 0
align 1
LABELV $49
byte 1 77
byte 1 97
byte 1 112
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 109
byte 1 97
byte 1 106
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $46
byte 1 45
byte 1 45
byte 1 45
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $38
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 103
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $37
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 112
byte 1 112
byte 1 114
byte 1 111
byte 1 118
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $36
byte 1 227
byte 1 237
byte 1 228
byte 1 32
byte 1 246
byte 1 239
byte 1 244
byte 1 229
byte 1 32
byte 1 249
byte 1 229
byte 1 243
byte 1 0
align 1
LABELV $35
byte 1 144
byte 1 37
byte 1 100
byte 1 145
byte 1 32
byte 1 116
byte 1 111
byte 1 116
byte 1 97
byte 1 108
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 0
align 1
LABELV $34
byte 1 144
byte 1 37
byte 1 100
byte 1 145
byte 1 32
byte 1 116
byte 1 111
byte 1 116
byte 1 97
byte 1 108
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 0
align 1
LABELV $31
byte 1 37
byte 1 115
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $30
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $21
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 105
byte 1 109
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
LABELV $17
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $12
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $11
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 109
byte 1 97
byte 1 112
byte 1 0
