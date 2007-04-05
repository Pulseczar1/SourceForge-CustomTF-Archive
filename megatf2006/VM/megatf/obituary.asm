export Mega_ClientObituary
code
proc Mega_ClientObituary 76 20
file "..\src\megatf\obituary.c"
line 28
;1:/*
;2: *  QWProgs-MegaTF_C
;3: *  Copyright (C) 2006  XavioR
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
;21: *  $Id: obituary.c,v 1.00 2006/10/06 XavioR Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:// MegaTF client obituary
;26:// I tried to wrap this as best I could, but it's still ugly.
;27:void Mega_ClientObituary( gedict_t* targ, gedict_t* attacker ) 
;28:{
line 30
;29:	float rnum, deathmsg;
;30:	char   *deathstring = "";
ADDRLP4 0
ADDRGP4 $12
ASGNP4
line 31
;31:	char   *deathstring2 = "";
ADDRLP4 12
ADDRGP4 $12
ASGNP4
line 33
;32:
;33:	deathmsg = ( float ) tf_data.deathmsg;
ADDRLP4 4
ADDRGP4 tf_data+88
INDIRI4
CVIF4 4
ASGNF4
line 77
;34:#ifdef fte_rankings
;35:	if (FTE_Server == 1)
;36:		Rank_AddDeaths(targ, 1);
;37:#endif
;38:// 'fer code caller!
;39:	/*
;40:	if (deathmsg > 0 && deathmsg < 199)
;41:	{
;42:		if (attacker)
;43:		{
;44:			attacker->num_kills = attacker->num_kills + 1;
;45:                  if ((targ->off_hook > g_globalvars.time))
;46:                  {
;47:                  attacker->num_kills = attacker->num_kills - 1;
;48:                  targ->off_hook = 0;
;49:                  }
;50:			if (attacker->fertracker != 1)
;51:			{
;52:				attacker->fertracker = 1;
;53:				fertimer (attacker);
;54:			}
;55:			if (attacker == targ)
;56:			{
;57:				attacker->num_kills = attacker->num_kills - 1;
;58:			}*/
;59:#ifdef fte_rankings
;60:			if (FTE_Server == 1 && attacker != targ)
;61:				Rank_AddFrags(attacker, 1);
;62:#endif
;63:			/*
;64:			if (targ->off_hook != 1)
;65:			{
;66://So disps, Drones, and heads dont count as fers
;67:				if (streq(targ->s.v.classname, "building_dispenser")) {
;68:				attacker->num_kills = attacker->num_kills - 1; }
;69:				if (targ->s.v.think (func_t) == DroneJet) {
;70:				attacker->num_kills = attacker->num_kills - 1; }
;71:				if (targ->s.v.touch (func_t) == KickHead) {
;72:				attacker->num_kills = attacker->num_kills - 1; }
;73:			}
;74:		}
;75:	}*/
;76:// end 'fer caller
;77:	rnum = g_random();
ADDRLP4 16
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 16
INDIRF4
ASGNF4
line 78
;78:	if (streq(targ->s.v.classname, "player"))
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 20
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $14
line 79
;79:	{
line 80
;80:		if (streq(attacker->s.v.classname, "teledeath"))
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $19
ARGP4
ADDRLP4 24
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $17
line 81
;81:		{
line 82
;82:			G_bprint(1, targ->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 83
;83:			G_bprint(1, " got in the way of ");
CNSTI4 1
ARGI4
ADDRGP4 $20
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 84
;84:			G_bprint(1, PROG_TO_EDICT(attacker->s.v.owner)->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+284
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 85
;85:			G_bprint(1, "\n");
CNSTI4 1
ARGI4
ADDRGP4 $23
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 86
;86:			if (PROG_TO_EDICT(attacker->s.v.owner)->team_no != targ->team_no || PROG_TO_EDICT(attacker->s.v.owner)->team_no < 1)
ADDRLP4 28
ADDRFP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
NEI4 $28
ADDRLP4 28
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
CNSTI4 1
GEI4 $24
LABELV $28
line 87
;87:			{
line 88
;88:				PROG_TO_EDICT(attacker->s.v.owner)->real_frags = PROG_TO_EDICT(attacker->s.v.owner)->real_frags + 1;
ADDRLP4 32
ADDRFP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 g_edicts+1024
ADDP4
ADDRLP4 32
INDIRI4
ADDRGP4 g_edicts+1024
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 89
;89:			}
LABELV $24
line 90
;90:			if (!(tf_data.toggleflags & 128))
ADDRGP4 tf_data
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $11
line 91
;91:			{
line 92
;92:				PROG_TO_EDICT(attacker->s.v.owner)->s.v.frags = PROG_TO_EDICT(attacker->s.v.owner)->real_frags;
ADDRLP4 32
ADDRFP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 g_edicts+112+188
ADDP4
ADDRLP4 32
INDIRI4
ADDRGP4 g_edicts+1024
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 93
;93:			}
line 94
;94:			return;
ADDRGP4 $11
JUMPV
LABELV $17
line 96
;95:		}
;96:		if (streq(attacker->s.v.classname, "teledeath2"))
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $38
ARGP4
ADDRLP4 28
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $36
line 97
;97:		{
line 98
;98:			G_bprint(1, "Satan's power deflects ");
CNSTI4 1
ARGI4
ADDRGP4 $39
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 99
;99:			G_bprint(1, targ->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 100
;100:			G_bprint(1, "'s telefrag\n");
CNSTI4 1
ARGI4
ADDRGP4 $40
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 101
;101:			targ->real_frags = targ->real_frags - 1;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 102
;102:			if (!(tf_data.toggleflags & 128))
ADDRGP4 tf_data
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $41
line 103
;103:			{
line 104
;104:				targ->s.v.frags = targ->real_frags;
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 105
;105:			}
LABELV $41
line 106
;106:			logfrag(targ, targ);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
line 107
;107:			return;
ADDRGP4 $11
JUMPV
LABELV $36
line 109
;108:		}
;109:		if (streq(attacker->s.v.classname, "info_tfgoal"))
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $45
ARGP4
ADDRLP4 32
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $43
line 110
;110:		{
line 111
;111:			if (attacker->deathtype != "")
ADDRFP4 4
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 $12
CVPU4 4
EQU4 $46
line 112
;112:			{
line 113
;113:				G_bprint(1, targ->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 114
;114:				G_bprint(1, attacker->deathtype);
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 115
;115:			}
LABELV $46
line 116
;116:			logfrag(targ, targ);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
line 117
;117:			return;
ADDRGP4 $11
JUMPV
LABELV $43
line 119
;118:		}
;119:		if (streq(attacker->s.v.classname, "player") || attacker->s.v.classname  == "bot")
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 36
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $51
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 $50
CVPU4 4
NEU4 $48
LABELV $51
line 120
;120:		{
line 121
;121:			if (targ == attacker)
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $52
line 122
;122:			{
line 123
;123:				attacker->real_frags = attacker->real_frags - 1;
ADDRLP4 40
ADDRFP4 4
INDIRP4
CNSTI4 1024
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 124
;124:				if (!(tf_data.toggleflags & 128))
ADDRGP4 tf_data
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $54
line 125
;125:				{
line 126
;126:					attacker->s.v.frags = attacker->real_frags;
ADDRLP4 44
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 127
;127:				}
LABELV $54
line 128
;128:				G_bprint(1, targ->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 129
;129:				if (deathmsg == 8)
ADDRLP4 4
INDIRF4
CNSTF4 1090519040
NEF4 $56
line 130
;130:				{
line 131
;131:					deathstring = " grenades himself\n";
ADDRLP4 0
ADDRGP4 $58
ASGNP4
line 132
;132:				}
ADDRGP4 $57
JUMPV
LABELV $56
line 134
;133:				else
;134:				{
line 135
;135:					if (deathmsg == 43)
ADDRLP4 4
INDIRF4
CNSTF4 1110179840
NEF4 $59
line 136
;136:					{
line 137
;137:						deathstring = " has himself bombed\n";
ADDRLP4 0
ADDRGP4 $61
ASGNP4
line 138
;138:					}
ADDRGP4 $60
JUMPV
LABELV $59
line 140
;139:					else
;140:					{
line 141
;141:						if (deathmsg == 45)
ADDRLP4 4
INDIRF4
CNSTF4 1110704128
NEF4 $62
line 142
;142:						{
line 143
;143:							deathstring = " hugs his proximity grenade\n";
ADDRLP4 0
ADDRGP4 $64
ASGNP4
line 144
;144:						}
ADDRGP4 $63
JUMPV
LABELV $62
line 146
;145:						else
;146:						{
line 147
;147:							if (deathmsg == 9)
ADDRLP4 4
INDIRF4
CNSTF4 1091567616
NEF4 $65
line 148
;148:							{
line 149
;149:								deathstring = " nails himself\n";
ADDRLP4 0
ADDRGP4 $67
ASGNP4
line 150
;150:							}
ADDRGP4 $66
JUMPV
LABELV $65
line 152
;151:							else
;152:							{
line 153
;153:								if (deathmsg == 10)
ADDRLP4 4
INDIRF4
CNSTF4 1092616192
NEF4 $68
line 154
;154:								{
line 155
;155:									deathstring = " is blown to bits\n";
ADDRLP4 0
ADDRGP4 $70
ASGNP4
line 156
;156:								}
ADDRGP4 $69
JUMPV
LABELV $68
line 158
;157:								else
;158:								{
line 159
;159:									if (deathmsg == 11)
ADDRLP4 4
INDIRF4
CNSTF4 1093664768
NEF4 $71
line 160
;160:									{
line 161
;161:										deathstring = " pipebombs himself...\nWhat a dumb-ass!\n";
ADDRLP4 0
ADDRGP4 $73
ASGNP4
line 162
;162:									}
ADDRGP4 $72
JUMPV
LABELV $71
line 164
;163:									else
;164:									{
line 165
;165:										if (deathmsg == 24)
ADDRLP4 4
INDIRF4
CNSTF4 1103101952
NEF4 $74
line 166
;166:										{
line 167
;167:											deathstring = " gags on his own gas... pew!\n";
ADDRLP4 0
ADDRGP4 $76
ASGNP4
line 168
;168:										}
ADDRGP4 $75
JUMPV
LABELV $74
line 170
;169:										else
;170:										{
line 171
;171:											if (deathmsg == 30)
ADDRLP4 4
INDIRF4
CNSTF4 1106247680
NEF4 $77
line 172
;172:											{
line 173
;173:												deathstring = " nukes his own ammo\n";
ADDRLP4 0
ADDRGP4 $79
ASGNP4
line 174
;174:											}
ADDRGP4 $78
JUMPV
LABELV $77
line 176
;175:											else
;176:											{
line 177
;177:												if (deathmsg == 35)
ADDRLP4 4
INDIRF4
CNSTF4 1108082688
NEF4 $80
line 178
;178:												{
line 179
;179:													deathstring = " flash grenade himself to death\n";
ADDRLP4 0
ADDRGP4 $82
ASGNP4
line 180
;180:												}
ADDRGP4 $81
JUMPV
LABELV $80
line 182
;181:												else
;182:												{
line 183
;183:													if (deathmsg == 31)
ADDRLP4 4
INDIRF4
CNSTF4 1106771968
NEF4 $83
line 184
;184:													{
line 185
;185:														deathstring = " detonates an ammo box too close to him\n";
ADDRLP4 0
ADDRGP4 $85
ASGNP4
line 186
;186:													}
ADDRGP4 $84
JUMPV
LABELV $83
line 188
;187:													else
;188:													{
line 189
;189:														if (deathmsg == 12)
ADDRLP4 4
INDIRF4
CNSTF4 1094713344
NEF4 $86
line 190
;190:														{
line 191
;191:															deathstring = " detpacks himself\n That was smart!\n";
ADDRLP4 0
ADDRGP4 $88
ASGNP4
line 192
;192:														}
ADDRGP4 $87
JUMPV
LABELV $86
line 194
;193:														else
;194:														{
line 195
;195:															if (deathmsg == 13)
ADDRLP4 4
INDIRF4
CNSTF4 1095761920
NEF4 $89
line 196
;196:															{
line 197
;197:																deathstring = " died impossibly!\n";
ADDRLP4 0
ADDRGP4 $91
ASGNP4
line 198
;198:															}
ADDRGP4 $90
JUMPV
LABELV $89
line 200
;199:															else
;200:															{
line 201
;201:																if (deathmsg == 6)
ADDRLP4 4
INDIRF4
CNSTF4 1086324736
NEF4 $92
line 202
;202:																{
line 203
;203:																	if (rnum <= 0.5)
ADDRLP4 8
INDIRF4
CNSTF4 1056964608
GTF4 $94
line 204
;204:																	{
line 205
;205:																		deathstring = " checks if his weapon is loaded\n";
ADDRLP4 0
ADDRGP4 $96
ASGNP4
line 206
;206:																	}
ADDRGP4 $93
JUMPV
LABELV $94
line 208
;207:																	else
;208:																	{
line 209
;209:																		deathstring = " hates himself\n";
ADDRLP4 0
ADDRGP4 $97
ASGNP4
line 210
;210:																	}
line 211
;211:																}
ADDRGP4 $93
JUMPV
LABELV $92
line 213
;212:																else
;213:																{
line 214
;214:																	if (deathmsg == 41)
ADDRLP4 4
INDIRF4
CNSTF4 1109655552
NEF4 $98
line 215
;215:																	{
line 216
;216:																		deathstring = "'s Laser Drone malfunctioned\n";
ADDRLP4 0
ADDRGP4 $100
ASGNP4
line 217
;217:																	}
ADDRGP4 $99
JUMPV
LABELV $98
line 219
;218:																	else
;219:																	{
line 220
;220:																		if (deathmsg == 33)
ADDRLP4 4
INDIRF4
CNSTF4 1107558400
NEF4 $101
line 221
;221:																		{
line 222
;222:																			deathstring = " chars himself with an incendiary rocket\n";
ADDRLP4 0
ADDRGP4 $103
ASGNP4
line 223
;223:																		}
ADDRGP4 $102
JUMPV
LABELV $101
line 225
;224:																		else
;225:																		{
line 226
;226:																			if (deathmsg == 5)
ADDRLP4 4
INDIRF4
CNSTF4 1084227584
NEF4 $104
line 227
;227:																			{
line 228
;228:																				deathstring = " tries to put the pin back in\n";
ADDRLP4 0
ADDRGP4 $106
ASGNP4
line 229
;229:																			}
ADDRGP4 $105
JUMPV
LABELV $104
line 231
;230:																			else
;231:																			{
line 232
;232:																				if (deathmsg == 15)
ADDRLP4 4
INDIRF4
CNSTF4 1097859072
NEF4 $107
line 233
;233:																				{
line 234
;234:																					if (attacker->playerclass == 1)
ADDRFP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
NEI4 $109
line 235
;235:																					{
line 236
;236:																						deathstring = "'s JetPack malfunctions\n";
ADDRLP4 0
ADDRGP4 $111
ASGNP4
line 237
;237:																					}
ADDRGP4 $108
JUMPV
LABELV $109
line 239
;238:																					else
;239:																					{
line 240
;240:																						deathstring = " bakes himself\n";
ADDRLP4 0
ADDRGP4 $112
ASGNP4
line 241
;241:																					}
line 242
;242:																				}
ADDRGP4 $108
JUMPV
LABELV $107
line 244
;243:																				else
;244:																				{
line 245
;245:																					if (deathmsg == 7 && targ->s.v.waterlevel > 0)
ADDRLP4 4
INDIRF4
CNSTF4 1088421888
NEF4 $113
ADDRFP4 0
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 0
LEF4 $113
line 246
;246:																					{
line 247
;247:																						G_bprint(1, " shocks himself to death.\n");
CNSTI4 1
ARGI4
ADDRGP4 $115
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 248
;248:																						return;
ADDRGP4 $11
JUMPV
LABELV $113
line 251
;249:																					}
;250:																					else
;251:																					{
line 252
;252:																						if (deathmsg == 40)																					
ADDRLP4 4
INDIRF4
CNSTF4 1109393408
NEF4 $116
line 253
;253:																						{
line 254
;254:																							deathstring = " couldn't outrun his airspam\n";																							
ADDRLP4 0
ADDRGP4 $118
ASGNP4
line 255
;255:																						}
ADDRGP4 $117
JUMPV
LABELV $116
line 257
;256:																						else
;257:																						{
line 258
;258:																							if (deathmsg == 201)
ADDRLP4 4
INDIRF4
CNSTF4 1128857600
NEF4 $119
line 259
;259:																							{
line 260
;260:																								deathstring = " used his dispenser for all the wrong reasons\n";																								
ADDRLP4 0
ADDRGP4 $121
ASGNP4
line 261
;261:																							}
LABELV $119
line 262
;262:																						}
LABELV $117
line 263
;263:																					}
line 264
;264:																				}
LABELV $108
line 265
;265:																			}
LABELV $105
line 266
;266:																		}
LABELV $102
line 267
;267:																	}
LABELV $99
line 268
;268:																}
LABELV $93
line 269
;269:															}
LABELV $90
line 270
;270:														}
LABELV $87
line 271
;271:													}
LABELV $84
line 272
;272:												}
LABELV $81
line 273
;273:											}
LABELV $78
line 274
;274:										}
LABELV $75
line 275
;275:									}
LABELV $72
line 276
;276:								}
LABELV $69
line 277
;277:							}
LABELV $66
line 278
;278:						}
LABELV $63
line 279
;279:					}
LABELV $60
line 280
;280:				}
LABELV $57
line 281
;281:				G_bprint(1, deathstring);
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 282
;282:				return;
ADDRGP4 $11
JUMPV
LABELV $52
line 285
;283:			}
;284:			else
;285:			{
line 286
;286:				if (teamplay && attacker->team_no == targ->team_no && attacker->team_no > 0)
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRGP4 teamplay
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $122
ADDRLP4 44
CNSTI4 960
ASGNI4
ADDRLP4 48
ADDRFP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRI4
NEI4 $122
ADDRLP4 48
INDIRI4
ADDRLP4 40
INDIRI4
LEI4 $122
line 287
;287:				{
line 288
;288:					if (attacker->team_no > 0 && attacker->team_no == targ->team_no)
ADDRLP4 52
CNSTI4 960
ASGNI4
ADDRLP4 56
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
LEI4 $124
ADDRLP4 56
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
NEI4 $124
line 289
;289:					{
line 290
;290:						attacker->real_frags = attacker->real_frags - 1;
ADDRLP4 60
ADDRFP4 4
INDIRP4
CNSTI4 1024
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 291
;291:					}
ADDRGP4 $125
JUMPV
LABELV $124
line 293
;292:					else
;293:					{
line 294
;294:						attacker->real_frags = attacker->real_frags + 1;
ADDRLP4 60
ADDRFP4 4
INDIRP4
CNSTI4 1024
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 295
;295:					}
LABELV $125
line 296
;296:					if (!(tf_data.toggleflags & 128))
ADDRGP4 tf_data
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $126
line 297
;297:					{
line 298
;298:						attacker->s.v.frags = attacker->real_frags;
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 299
;299:					}
LABELV $126
line 300
;300:					if (rnum < 0.25)
ADDRLP4 8
INDIRF4
CNSTF4 1048576000
GEF4 $128
line 301
;301:					{
line 302
;302:						deathstring = " mows down a teammate\n";
ADDRLP4 0
ADDRGP4 $130
ASGNP4
line 303
;303:					}
ADDRGP4 $129
JUMPV
LABELV $128
line 305
;304:					else
;305:					{
line 306
;306:						if (rnum < 0.5)
ADDRLP4 8
INDIRF4
CNSTF4 1056964608
GEF4 $131
line 307
;307:						{
line 308
;308:							deathstring = " checks his glasses\n";
ADDRLP4 0
ADDRGP4 $133
ASGNP4
line 309
;309:						}
ADDRGP4 $132
JUMPV
LABELV $131
line 311
;310:						else
;311:						{
line 312
;312:							if (rnum < 0.75)
ADDRLP4 8
INDIRF4
CNSTF4 1061158912
GEF4 $134
line 313
;313:							{
line 314
;314:								deathstring = " gets a frag for the other team\n";
ADDRLP4 0
ADDRGP4 $136
ASGNP4
line 315
;315:							}
ADDRGP4 $135
JUMPV
LABELV $134
line 317
;316:							else
;317:							{
line 318
;318:								deathstring = " loses another friend\n";
ADDRLP4 0
ADDRGP4 $137
ASGNP4
line 319
;319:							}
LABELV $135
line 320
;320:						}
LABELV $132
line 321
;321:					}
LABELV $129
line 322
;322:					if (deathmsg == 23)
ADDRLP4 4
INDIRF4
CNSTF4 1102577664
NEF4 $138
line 323
;323:					{
line 324
;324:						G_bprint(1, targ->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 325
;325:						G_bprint(1, " didn't survive the operation.\n");
CNSTI4 1
ARGI4
ADDRGP4 $140
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 326
;326:						return;
ADDRGP4 $11
JUMPV
LABELV $138
line 328
;327:					}
;328:					G_bprint(1, attacker->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 329
;329:					G_bprint(1, deathstring);
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 330
;330:					return;
ADDRGP4 $11
JUMPV
LABELV $122
line 333
;331:				}
;332:				else
;333:				{
line 334
;334:					attacker->real_frags = attacker->real_frags + 1;
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 1024
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 335
;335:					logfrag(attacker, targ);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
line 336
;336:					if (!(tf_data.toggleflags & 128))
ADDRGP4 tf_data
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $141
line 337
;337:					{
line 338
;338:						attacker->s.v.frags = attacker->real_frags;
ADDRLP4 56
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 339
;339:					}
LABELV $141
line 340
;340:					if (deathmsg == 43)
ADDRLP4 4
INDIRF4
CNSTF4 1110179840
NEF4 $143
line 341
;341:					{
line 342
;342:						deathstring = " was bombed by ";
ADDRLP4 0
ADDRGP4 $145
ASGNP4
line 343
;343:						deathstring2 = "'s AirStrike call\n";
ADDRLP4 12
ADDRGP4 $146
ASGNP4
line 344
;344:					}
LABELV $143
line 345
;345:					if (deathmsg == 45)
ADDRLP4 4
INDIRF4
CNSTF4 1110704128
NEF4 $147
line 346
;346:					{
line 347
;347:						deathstring = " gets too friendly with ";
ADDRLP4 0
ADDRGP4 $149
ASGNP4
line 348
;348:						deathstring2 = "'s Proxi grenade\n";
ADDRLP4 12
ADDRGP4 $150
ASGNP4
line 349
;349:					}
LABELV $147
line 350
;350:					if (deathmsg == 46)
ADDRLP4 4
INDIRF4
CNSTF4 1110966272
NEF4 $151
line 351
;351:					{
line 352
;352:						deathstring = " gets shredded by ";
ADDRLP4 0
ADDRGP4 $153
ASGNP4
line 353
;353:						deathstring2 = "'s 20mm cannon\n";
ADDRLP4 12
ADDRGP4 $154
ASGNP4
line 354
;354:					}
LABELV $151
line 355
;355:					if (deathmsg == 8)
ADDRLP4 4
INDIRF4
CNSTF4 1090519040
NEF4 $155
line 356
;356:					{
line 357
;357:						deathstring = " tries to hatch ";
ADDRLP4 0
ADDRGP4 $157
ASGNP4
line 358
;358:						deathstring2 = "'s grenade\n";
ADDRLP4 12
ADDRGP4 $158
ASGNP4
line 359
;359:					}
ADDRGP4 $156
JUMPV
LABELV $155
line 361
;360:					else
;361:					{
line 362
;362:						if (deathmsg == 9)
ADDRLP4 4
INDIRF4
CNSTF4 1091567616
NEF4 $159
line 363
;363:						{
line 364
;364:							deathstring = " gets perforated by ";
ADDRLP4 0
ADDRGP4 $161
ASGNP4
line 365
;365:							deathstring2 = "'s nail grenade\n";
ADDRLP4 12
ADDRGP4 $162
ASGNP4
line 366
;366:						}
ADDRGP4 $160
JUMPV
LABELV $159
line 368
;367:						else
;368:						{
line 369
;369:							if (deathmsg == 10)
ADDRLP4 4
INDIRF4
CNSTF4 1092616192
NEF4 $163
line 370
;370:							{
line 371
;371:								deathstring = " gets juiced by ";
ADDRLP4 0
ADDRGP4 $165
ASGNP4
line 372
;372:								deathstring2 = "'s Mirv grenade\n";
ADDRLP4 12
ADDRGP4 $166
ASGNP4
line 373
;373:							}
ADDRGP4 $164
JUMPV
LABELV $163
line 375
;374:							else
;375:							{
line 376
;376:								if (deathmsg == 40)
ADDRLP4 4
INDIRF4
CNSTF4 1109393408
NEF4 $167
line 377
;377:								{
line 378
;378:									deathstring = " is shreaded by ";
ADDRLP4 0
ADDRGP4 $169
ASGNP4
line 379
;379:									deathstring2 = "'s AirMirv\n";
ADDRLP4 12
ADDRGP4 $170
ASGNP4
line 380
;380:								}
ADDRGP4 $168
JUMPV
LABELV $167
line 382
;381:								else
;382:								{
line 383
;383:									if (deathmsg == 11)
ADDRLP4 4
INDIRF4
CNSTF4 1093664768
NEF4 $171
line 384
;384:									{
line 385
;385:										deathstring = " is shreaded by ";
ADDRLP4 0
ADDRGP4 $169
ASGNP4
line 386
;386:										deathstring2 = "'s pipebomb trap\n";
ADDRLP4 12
ADDRGP4 $173
ASGNP4
line 387
;387:									}
ADDRGP4 $172
JUMPV
LABELV $171
line 389
;388:									else
;389:									{
line 390
;390:										if (deathmsg == 24)
ADDRLP4 4
INDIRF4
CNSTF4 1103101952
NEF4 $174
line 391
;391:										{
line 392
;392:											deathstring = " sniffs to much of ";
ADDRLP4 0
ADDRGP4 $176
ASGNP4
line 393
;393:											deathstring2 = "'s glue\n";
ADDRLP4 12
ADDRGP4 $177
ASGNP4
line 394
;394:										}
ADDRGP4 $175
JUMPV
LABELV $174
line 396
;395:										else
;396:										{
line 397
;397:											if (deathmsg == 30)
ADDRLP4 4
INDIRF4
CNSTF4 1106247680
NEF4 $178
line 398
;398:											{
line 399
;399:												deathstring = "'s gets vaporized by ";
ADDRLP4 0
ADDRGP4 $180
ASGNP4
line 400
;400:												deathstring2 = "'s EMP grenade.\n";
ADDRLP4 12
ADDRGP4 $181
ASGNP4
line 401
;401:											}
ADDRGP4 $179
JUMPV
LABELV $178
line 403
;402:											else
;403:											{
line 404
;404:												if (deathmsg == 35)
ADDRLP4 4
INDIRF4
CNSTF4 1108082688
NEF4 $182
line 405
;405:												{
line 406
;406:													deathstring = "'s brain is fried by ";
ADDRLP4 0
ADDRGP4 $184
ASGNP4
line 407
;407:													deathstring2 = "'s flash grenade\n";
ADDRLP4 12
ADDRGP4 $185
ASGNP4
line 408
;408:												}
ADDRGP4 $183
JUMPV
LABELV $182
line 410
;409:												else
;410:												{
line 411
;411:													if (deathmsg == 31)
ADDRLP4 4
INDIRF4
CNSTF4 1106771968
NEF4 $186
line 412
;412:													{
line 413
;413:														deathstring = " stands near some ammo as ";
ADDRLP4 0
ADDRGP4 $188
ASGNP4
line 414
;414:														deathstring2 = "'s EMP nukes it\n";
ADDRLP4 12
ADDRGP4 $189
ASGNP4
line 415
;415:													}
ADDRGP4 $187
JUMPV
LABELV $186
line 417
;416:													else
;417:													{
line 418
;418:														if (deathmsg == 12)
ADDRLP4 4
INDIRF4
CNSTF4 1094713344
NEF4 $190
line 419
;419:														{
line 420
;420:															deathstring = " is nuked by ";
ADDRLP4 0
ADDRGP4 $192
ASGNP4
line 421
;421:															deathstring2 = "'s detpack\n";
ADDRLP4 12
ADDRGP4 $193
ASGNP4
line 422
;422:														}
ADDRGP4 $191
JUMPV
LABELV $190
line 424
;423:														else
;424:														{
line 425
;425:															if (deathmsg == 16)
ADDRLP4 4
INDIRF4
CNSTF4 1098907648
NEF4 $194
line 426
;426:															{
line 427
;427:																deathstring = " cut the red wire of ";
ADDRLP4 0
ADDRGP4 $196
ASGNP4
line 428
;428:																deathstring2 = "'s detpack\n";
ADDRLP4 12
ADDRGP4 $193
ASGNP4
line 429
;429:															}
ADDRGP4 $195
JUMPV
LABELV $194
line 431
;430:															else
;431:															{
line 432
;432:																if (deathmsg == 13)
ADDRLP4 4
INDIRF4
CNSTF4 1095761920
NEF4 $197
line 433
;433:																{
line 434
;434:																	deathstring = " dies from ";
ADDRLP4 0
ADDRGP4 $199
ASGNP4
line 435
;435:																	deathstring2 = "'s social disease\n";
ADDRLP4 12
ADDRGP4 $200
ASGNP4
line 436
;436:																	sound(targ, 0, "player/mpain6.wav", 1, 1);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $201
ARGP4
ADDRLP4 56
CNSTF4 1065353216
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 437
;437:																}
ADDRGP4 $198
JUMPV
LABELV $197
line 439
;438:																else
;439:																{
line 440
;440:																	if (deathmsg == 14)
ADDRLP4 4
INDIRF4
CNSTF4 1096810496
NEF4 $202
line 441
;441:																	{
line 442
;442:																		deathstring = " escapes infection from ";
ADDRLP4 0
ADDRGP4 $204
ASGNP4
line 443
;443:																		deathstring2 = " by dying first\n";
ADDRLP4 12
ADDRGP4 $205
ASGNP4
line 444
;444:																	}
ADDRGP4 $203
JUMPV
LABELV $202
line 446
;445:																	else
;446:																	{
line 447
;447:																		if (deathmsg == 5)
ADDRLP4 4
INDIRF4
CNSTF4 1084227584
NEF4 $206
line 448
;448:																		{
line 449
;449:																			deathstring = " swallows ";
ADDRLP4 0
ADDRGP4 $208
ASGNP4
line 450
;450:																			deathstring2 = "'s grenade\n";
ADDRLP4 12
ADDRGP4 $158
ASGNP4
line 451
;451:																			if (targ->s.v.health < -40)
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 3256877056
GEF4 $207
line 452
;452:																			{
line 453
;453:																				deathstring = " was split in half by ";
ADDRLP4 0
ADDRGP4 $211
ASGNP4
line 454
;454:																				deathstring2 = "'s grenade\n";
ADDRLP4 12
ADDRGP4 $158
ASGNP4
line 455
;455:																			}
line 456
;456:																		}
ADDRGP4 $207
JUMPV
LABELV $206
line 458
;457:																		else
;458:																		{
line 459
;459:																			if (deathmsg == 6)
ADDRLP4 4
INDIRF4
CNSTF4 1086324736
NEF4 $212
line 460
;460:																			{
line 461
;461:																				deathstring = " is reamed by ";
ADDRLP4 0
ADDRGP4 $214
ASGNP4
line 462
;462:																				deathstring2 = "'s rocket\n";
ADDRLP4 12
ADDRGP4 $215
ASGNP4
line 463
;463:																				if (targ->s.v.health < -40)
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 3256877056
GEF4 $213
line 464
;464:																				{
line 465
;465:																					deathstring = "'s bunghole was ripped by ";
ADDRLP4 0
ADDRGP4 $218
ASGNP4
line 466
;466:																					deathstring2 = "'s rocket\n";
ADDRLP4 12
ADDRGP4 $215
ASGNP4
line 467
;467:																				}
line 468
;468:																			}
ADDRGP4 $213
JUMPV
LABELV $212
line 470
;469:																			else
;470:																			{
line 471
;471:																				if (deathmsg == 41)
ADDRLP4 4
INDIRF4
CNSTF4 1109655552
NEF4 $219
line 472
;472:																				{
line 473
;473:																					deathstring = " was killed by ";
ADDRLP4 0
ADDRGP4 $221
ASGNP4
line 474
;474:																					deathstring2 = "'s Laser Drone\n";
ADDRLP4 12
ADDRGP4 $222
ASGNP4
line 475
;475:																					if (targ->s.v.health < -40)
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 3256877056
GEF4 $220
line 476
;476:																					{
line 477
;477:																						deathstring = " was vaporized by ";
ADDRLP4 0
ADDRGP4 $225
ASGNP4
line 478
;478:																						deathstring2 = "'s Laser Drone\n";
ADDRLP4 12
ADDRGP4 $222
ASGNP4
line 479
;479:																					}
line 480
;480:																				}
ADDRGP4 $220
JUMPV
LABELV $219
line 482
;481:																				else
;482:																				{
line 483
;483:																					if (deathmsg == 42)
ADDRLP4 4
INDIRF4
CNSTF4 1109917696
NEF4 $226
line 484
;484:																					{
line 485
;485:																						deathstring = " was torn up by an enemy Rottweiler";
ADDRLP4 0
ADDRGP4 $228
ASGNP4
line 486
;486:																						deathstring2 = "\n";
ADDRLP4 12
ADDRGP4 $23
ASGNP4
line 487
;487:																					}
ADDRGP4 $227
JUMPV
LABELV $226
line 489
;488:																					else
;489:																					{
line 490
;490:																						if (deathmsg == 44)
ADDRLP4 4
INDIRF4
CNSTF4 1110441984
NEF4 $229
line 491
;491:																						{
line 492
;492:																							deathstring = " was stopped by an enemy autoturret";
ADDRLP4 0
ADDRGP4 $231
ASGNP4
line 493
;493:																							deathstring2 = "\n";
ADDRLP4 12
ADDRGP4 $23
ASGNP4
line 494
;494:																						}
ADDRGP4 $230
JUMPV
LABELV $229
line 496
;495:																						else
;496:																						{
line 497
;497:																							if (deathmsg == 15)
ADDRLP4 4
INDIRF4
CNSTF4 1097859072
NEF4 $232
line 498
;498:																							{
line 499
;499:																								if (rnum < 0.2)
ADDRLP4 8
INDIRF4
CNSTF4 1045220557
GEF4 $234
line 500
;500:																								{
line 501
;501:																									deathstring = " burns to death by ";
ADDRLP4 0
ADDRGP4 $236
ASGNP4
line 502
;502:																									deathstring2 = "'s flame\n";
ADDRLP4 12
ADDRGP4 $237
ASGNP4
line 503
;503:																								}
ADDRGP4 $233
JUMPV
LABELV $234
line 505
;504:																								else
;505:																								{
line 506
;506:																									if (rnum < 0.4)
ADDRLP4 8
INDIRF4
CNSTF4 1053609165
GEF4 $238
line 507
;507:																									{
line 508
;508:																										deathstring = " is fried by ";
ADDRLP4 0
ADDRGP4 $240
ASGNP4
line 509
;509:																										deathstring2 = "'s fire\n";
ADDRLP4 12
ADDRGP4 $241
ASGNP4
line 510
;510:																									}
ADDRGP4 $233
JUMPV
LABELV $238
line 512
;511:																									else
;512:																									{
line 513
;513:																										if (rnum < 0.6)
ADDRLP4 8
INDIRF4
CNSTF4 1058642330
GEF4 $242
line 514
;514:																										{
line 515
;515:																											deathstring = " is boiled alive by ";
ADDRLP4 0
ADDRGP4 $244
ASGNP4
line 516
;516:																											deathstring2 = "'s heat\n";
ADDRLP4 12
ADDRGP4 $245
ASGNP4
line 517
;517:																										}
ADDRGP4 $233
JUMPV
LABELV $242
line 519
;518:																										else
;519:																										{
line 520
;520:																											if (rnum < 0.8)
ADDRLP4 8
INDIRF4
CNSTF4 1061997773
GEF4 $246
line 521
;521:																											{
line 522
;522:																												deathstring = " is cremated by ";
ADDRLP4 0
ADDRGP4 $248
ASGNP4
line 523
;523:																												deathstring2 = "'s incinerator\n";
ADDRLP4 12
ADDRGP4 $249
ASGNP4
line 524
;524:																											}
ADDRGP4 $233
JUMPV
LABELV $246
line 526
;525:																											else
;526:																											{
line 527
;527:																												deathstring = " is grilled by ";
ADDRLP4 0
ADDRGP4 $250
ASGNP4
line 528
;528:																												deathstring2 = "'s BBQ\n";
ADDRLP4 12
ADDRGP4 $251
ASGNP4
line 529
;529:																											}
line 530
;530:																										}
line 531
;531:																									}
line 532
;532:																								}
line 533
;533:																							}
ADDRGP4 $233
JUMPV
LABELV $232
line 535
;534:																							else
;535:																							{
line 536
;536:																								if (deathmsg == 17)
ADDRLP4 4
INDIRF4
CNSTF4 1099431936
NEF4 $252
line 537
;537:																								{
line 538
;538:																									if (attacker->playerclass == PC_SPY)
ADDRFP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $254
line 539
;539:																									{
line 540
;540:																										deathstring = " was stabbed by ";
ADDRLP4 0
ADDRGP4 $256
ASGNP4
line 541
;541:																									}
ADDRGP4 $255
JUMPV
LABELV $254
line 543
;542:																									else
;543:																									{
line 544
;544:																										deathstring = " was slit open by ";
ADDRLP4 0
ADDRGP4 $257
ASGNP4
line 545
;545:																									}
LABELV $255
line 546
;546:																									deathstring2 = "\n";
ADDRLP4 12
ADDRGP4 $23
ASGNP4
line 547
;547:																								}
ADDRGP4 $253
JUMPV
LABELV $252
line 549
;548:																								else
;549:																								{
line 550
;550:																									if (deathmsg == 32)
ADDRLP4 4
INDIRF4
CNSTF4 1107296256
NEF4 $258
line 551
;551:																									{
line 552
;552:																										deathstring = " was spanner-whacked by ";
ADDRLP4 0
ADDRGP4 $260
ASGNP4
line 553
;553:																										deathstring2 = "\n";
ADDRLP4 12
ADDRGP4 $23
ASGNP4
line 554
;554:																									}
ADDRGP4 $259
JUMPV
LABELV $258
line 556
;555:																									else
;556:																									{
line 557
;557:																										if (deathmsg == 1)
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
NEF4 $261
line 558
;558:																										{
line 559
;559:																											deathstring = " was swiss-cheesed by ";
ADDRLP4 0
ADDRGP4 $263
ASGNP4
line 560
;560:																											deathstring2 = "'s bird gun\n";
ADDRLP4 12
ADDRGP4 $264
ASGNP4
line 562
;561://																											//shotgun_exp_gain ();
;562:																										}
ADDRGP4 $262
JUMPV
LABELV $261
line 564
;563:																										else
;564:																										{
line 565
;565:																											if (deathmsg == 2)
ADDRLP4 4
INDIRF4
CNSTF4 1073741824
NEF4 $265
line 566
;566:																											{
line 567
;567:																												deathstring = "'s head is popped by ";
ADDRLP4 0
ADDRGP4 $267
ASGNP4
line 568
;568:																												deathstring2 = "'s shotgun\n";
ADDRLP4 12
ADDRGP4 $268
ASGNP4
line 569
;569:																											}
ADDRGP4 $266
JUMPV
LABELV $265
line 571
;570:																											else
;571:																											{
line 572
;572:																												if (deathmsg == 3)
ADDRLP4 4
INDIRF4
CNSTF4 1077936128
NEF4 $269
line 573
;573:																												{
line 574
;574:																													deathstring = " was capped by ";
ADDRLP4 0
ADDRGP4 $271
ASGNP4
line 575
;575:																													deathstring2 = "\n";
ADDRLP4 12
ADDRGP4 $23
ASGNP4
line 576
;576:																												}
ADDRGP4 $270
JUMPV
LABELV $269
line 578
;577:																												else
;578:																												{
line 579
;579:																													if (deathmsg == 4)
ADDRLP4 4
INDIRF4
CNSTF4 1082130432
NEF4 $272
line 580
;580:																													{
line 581
;581:																														deathstring = " was perforated by ";
ADDRLP4 0
ADDRGP4 $274
ASGNP4
line 582
;582:																														deathstring2 = "'s nailgun\n";
ADDRLP4 12
ADDRGP4 $275
ASGNP4
line 583
;583:																													}
ADDRGP4 $273
JUMPV
LABELV $272
line 585
;584:																													else
;585:																													{
line 586
;586:																														if (deathmsg == 7)
ADDRLP4 4
INDIRF4
CNSTF4 1088421888
NEF4 $276
line 587
;587:																														{
line 588
;588:																															deathstring = " swims with ";
ADDRLP4 0
ADDRGP4 $278
ASGNP4
line 589
;589:																															deathstring2 = "'s toaster\n";
ADDRLP4 12
ADDRGP4 $279
ASGNP4
line 590
;590:																														}
ADDRGP4 $277
JUMPV
LABELV $276
line 592
;591:																														else
;592:																														{
line 593
;593:																															if (deathmsg == 21)
ADDRLP4 4
INDIRF4
CNSTF4 1101529088
NEF4 $280
line 594
;594:																															{
line 595
;595:																																deathstring = " grappled with ";
ADDRLP4 0
ADDRGP4 $282
ASGNP4
line 596
;596:																																deathstring2 = "\n";
ADDRLP4 12
ADDRGP4 $23
ASGNP4
line 597
;597:																															}
ADDRGP4 $281
JUMPV
LABELV $280
line 599
;598:																															else
;599:																															{
line 600
;600:																																if (deathmsg == 18)
ADDRLP4 4
INDIRF4
CNSTF4 1099956224
NEF4 $283
line 601
;601:																																{
line 602
;602:																																	if (rnum <= 0.3)
ADDRLP4 8
INDIRF4
CNSTF4 1050253722
GTF4 $285
line 603
;603:																																	{
line 604
;604:																																		deathstring = " gets a sucking chest wound from ";
ADDRLP4 0
ADDRGP4 $287
ASGNP4
line 605
;605:																																		deathstring2 = "\n";
ADDRLP4 12
ADDRGP4 $23
ASGNP4
line 606
;606:																																	}
ADDRGP4 $284
JUMPV
LABELV $285
line 608
;607:																																	else
;608:																																	{
line 609
;609:																																		if (rnum <= 0.6)
ADDRLP4 8
INDIRF4
CNSTF4 1058642330
GTF4 $288
line 610
;610:																																		{
line 611
;611:																																			deathstring = "'s liver is blown out by ";
ADDRLP4 0
ADDRGP4 $290
ASGNP4
line 612
;612:																																			deathstring2 = "\n";
ADDRLP4 12
ADDRGP4 $23
ASGNP4
line 613
;613:																																		}
ADDRGP4 $284
JUMPV
LABELV $288
line 615
;614:																																		else
;615:																																		{
line 616
;616:																																			deathstring = "'s chest explodes from ";
ADDRLP4 0
ADDRGP4 $291
ASGNP4
line 617
;617:																																			deathstring2 = "'s sniper round\n";
ADDRLP4 12
ADDRGP4 $292
ASGNP4
line 618
;618:																																		}
line 619
;619:																																	}
line 620
;620:																																}
ADDRGP4 $284
JUMPV
LABELV $283
line 622
;621:																																else
;622:																																{
line 623
;623:																																	if (deathmsg == 29)
ADDRLP4 4
INDIRF4
CNSTF4 1105723392
NEF4 $293
line 624
;624:																																	{
line 625
;625:																																		if (rnum <= 0.5)
ADDRLP4 8
INDIRF4
CNSTF4 1056964608
GTF4 $295
line 626
;626:																																		{
line 627
;627:																																			deathstring = " is beheaded by ";
ADDRLP4 0
ADDRGP4 $297
ASGNP4
line 628
;628:																																			deathstring2 = "'s round\n";
ADDRLP4 12
ADDRGP4 $298
ASGNP4
line 629
;629:																																		}
ADDRGP4 $294
JUMPV
LABELV $295
line 631
;630:																																		else
;631:																																		{
line 632
;632:																																			deathstring = "'s labotomized by ";
ADDRLP4 0
ADDRGP4 $299
ASGNP4
line 633
;633:																																			deathstring2 = "'s sniper round\n";
ADDRLP4 12
ADDRGP4 $292
ASGNP4
line 634
;634:																																		}
line 635
;635:																																	}
ADDRGP4 $294
JUMPV
LABELV $293
line 637
;636:																																	else
;637:																																	{
line 638
;638:																																		if (deathmsg == 28)
ADDRLP4 4
INDIRF4
CNSTF4 1105199104
NEF4 $300
line 639
;639:																																		{
line 640
;640:																																			if (rnum <= 0.5)
ADDRLP4 8
INDIRF4
CNSTF4 1056964608
GTF4 $302
line 641
;641:																																			{
line 642
;642:																																				deathstring = " is neutered by ";
ADDRLP4 0
ADDRGP4 $304
ASGNP4
line 643
;643:																																				deathstring2 = "\n";
ADDRLP4 12
ADDRGP4 $23
ASGNP4
line 644
;644:																																			}
ADDRGP4 $301
JUMPV
LABELV $302
line 646
;645:																																			else
;646:																																			{
line 647
;647:																																				deathstring = "'s legs explode open from ";
ADDRLP4 0
ADDRGP4 $305
ASGNP4
line 648
;648:																																				deathstring2 = "'s shot\n";
ADDRLP4 12
ADDRGP4 $306
ASGNP4
line 649
;649:																																			}
line 650
;650:																																		}
ADDRGP4 $301
JUMPV
LABELV $300
line 652
;651:																																		else
;652:																																		{
line 653
;653:																																			if (deathmsg == 19)
ADDRLP4 4
INDIRF4
CNSTF4 1100480512
NEF4 $307
line 654
;654:																																			{
line 655
;655:																																				deathstring = " enjoys ";
ADDRLP4 0
ADDRGP4 $309
ASGNP4
line 656
;656:																																				deathstring2 = "'s machinegun.\n";
ADDRLP4 12
ADDRGP4 $310
ASGNP4
line 657
;657:																																			}
ADDRGP4 $308
JUMPV
LABELV $307
line 659
;658:																																			else
;659:																																			{
line 660
;660:																																				if (deathmsg == 20)
ADDRLP4 4
INDIRF4
CNSTF4 1101004800
NEF4 $311
line 661
;661:																																				{
line 662
;662:																																					deathstring = " torso is removed by ";
ADDRLP4 0
ADDRGP4 $313
ASGNP4
line 663
;663:																																					deathstring2 = "\n";
ADDRLP4 12
ADDRGP4 $23
ASGNP4
line 664
;664:																																				}
ADDRGP4 $312
JUMPV
LABELV $311
line 666
;665:																																				else
;666:																																				{
line 667
;667:																																					if (deathmsg == 22)
ADDRLP4 4
INDIRF4
CNSTF4 1102053376
NEF4 $314
line 668
;668:																																					{
line 669
;669:																																						deathstring = " is ass-knifed by ";
ADDRLP4 0
ADDRGP4 $316
ASGNP4
line 670
;670:																																						deathstring2 = "\n";
ADDRLP4 12
ADDRGP4 $23
ASGNP4
line 671
;671:																																						sound(targ, 0, "player/mpain6.wav", 1, 1);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $201
ARGP4
ADDRLP4 56
CNSTF4 1065353216
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 672
;672:																																					}
ADDRGP4 $315
JUMPV
LABELV $314
line 674
;673:																																					else
;674:																																					{
line 675
;675:																																						if (deathmsg == 25)
ADDRLP4 4
INDIRF4
CNSTF4 1103626240
NEF4 $317
line 676
;676:																																						{
line 677
;677:																																							deathstring = " is over-dosed by ";
ADDRLP4 0
ADDRGP4 $319
ASGNP4
line 678
;678:																																							deathstring2 = "'s ludes\n";
ADDRLP4 12
ADDRGP4 $320
ASGNP4
line 679
;679:																																						}
ADDRGP4 $318
JUMPV
LABELV $317
line 681
;680:																																						else
;681:																																						{
line 682
;682:																																							if (deathmsg == 26)
ADDRLP4 4
INDIRF4
CNSTF4 1104150528
NEF4 $321
line 683
;683:																																							{
line 684
;684:																																								deathstring = " spews juice thru holes from ";
ADDRLP4 0
ADDRGP4 $323
ASGNP4
line 685
;685:																																								deathstring2 = "'s railgun\n";
ADDRLP4 12
ADDRGP4 $324
ASGNP4
line 686
;686:																																							}
ADDRGP4 $322
JUMPV
LABELV $321
line 688
;687:																																							else
;688:																																							{
line 689
;689:																																								if (deathmsg == 33)
ADDRLP4 4
INDIRF4
CNSTF4 1107558400
NEF4 $325
line 690
;690:																																								{
line 691
;691:																																									deathstring = " gets cooked by ";
ADDRLP4 0
ADDRGP4 $327
ASGNP4
line 692
;692:																																									deathstring2 = "'s incendiary rocket\n";
ADDRLP4 12
ADDRGP4 $328
ASGNP4
line 693
;693:																																								} 
ADDRGP4 $326
JUMPV
LABELV $325
line 696
;694:																																								// pablo. spike trap death msg.
;695:																																								else
;696:																																								{
line 697
;697:																																									if (deathmsg == 200)
ADDRLP4 4
INDIRF4
CNSTF4 1128792064
NEF4 $329
line 698
;698:																																									{
line 699
;699:																																										deathstring = "'s leg was amputated by ";
ADDRLP4 0
ADDRGP4 $331
ASGNP4
line 700
;700:																																										deathstring2 = "'s spike\n";
ADDRLP4 12
ADDRGP4 $332
ASGNP4
line 701
;701:																																									}
ADDRGP4 $330
JUMPV
LABELV $329
line 704
;702:																																									// pablo. dispenser death msg.
;703:																																									else
;704:																																									{
line 705
;705:																																										if (deathmsg == 201)
ADDRLP4 4
INDIRF4
CNSTF4 1128857600
NEF4 $333
line 706
;706:																																										{
line 707
;707:																																											deathstring = " thought ";
ADDRLP4 0
ADDRGP4 $335
ASGNP4
line 708
;708:																																											deathstring2 = "'s dispenser was a mechanical bull\n";
ADDRLP4 12
ADDRGP4 $336
ASGNP4
line 709
;709:																																										}
LABELV $333
line 710
;710:																																									}
LABELV $330
line 711
;711:																																								}
LABELV $326
line 712
;712:																																							}																																						
LABELV $322
line 713
;713:																																						}
LABELV $318
line 714
;714:																																					}
LABELV $315
line 715
;715:																																				}
LABELV $312
line 716
;716:																																			}
LABELV $308
line 717
;717:																																		}
LABELV $301
line 718
;718:																																	}
LABELV $294
line 719
;719:																																}
LABELV $284
line 720
;720:																															}
LABELV $281
line 721
;721:																														}
LABELV $277
line 722
;722:																													}
LABELV $273
line 723
;723:																												}
LABELV $270
line 724
;724:																											}
LABELV $266
line 725
;725:																										}
LABELV $262
line 726
;726:																									}
LABELV $259
line 727
;727:																								}
LABELV $253
line 728
;728:																							}
LABELV $233
line 729
;729:																						}
LABELV $230
line 730
;730:																					}
LABELV $227
line 731
;731:																				}
LABELV $220
line 732
;732:																			}
LABELV $213
line 733
;733:																		}
LABELV $207
line 734
;734:																	}
LABELV $203
line 735
;735:																}
LABELV $198
line 736
;736:															}
LABELV $195
line 737
;737:														}
LABELV $191
line 738
;738:													}
LABELV $187
line 739
;739:												}
LABELV $183
line 740
;740:											}
LABELV $179
line 741
;741:										}
LABELV $175
line 742
;742:									}
LABELV $172
line 743
;743:								}
LABELV $168
line 744
;744:							}
LABELV $164
line 745
;745:						}
LABELV $160
line 746
;746:					}
LABELV $156
line 747
;747:					G_bprint(1, targ->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 748
;748:					G_bprint(1, deathstring);
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 749
;749:					G_bprint(1, attacker->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 750
;750:					G_bprint(1, deathstring2);
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 751
;751:				}
line 752
;752:			}
line 753
;753:			return;
ADDRGP4 $11
JUMPV
LABELV $48
line 756
;754:		}
;755:		else
;756:		{
line 757
;757:			if (streq(attacker->s.v.classname, "building_sentrygun"))
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $339
ARGP4
ADDRLP4 40
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $337
line 758
;758:			{
line 759
;759:				if (targ == attacker->real_owner)
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
NEU4 $340
line 760
;760:				{
line 761
;761:					if (deathmsg == 34)
ADDRLP4 4
INDIRF4
CNSTF4 1107820544
NEF4 $342
line 762
;762:					{
line 763
;763:						deathstring = " gets wasted by his sentry gun\nDumb-ass!\n";
ADDRLP4 0
ADDRGP4 $344
ASGNP4
line 764
;764:					}
ADDRGP4 $343
JUMPV
LABELV $342
line 766
;765:					else
;766:					{
line 767
;767:						if (deathmsg == 27)
ADDRLP4 4
INDIRF4
CNSTF4 1104674816
NEF4 $345
line 768
;768:						{
line 769
;769:							deathstring = " crossed his sentry gun's line of fire\n";
ADDRLP4 0
ADDRGP4 $347
ASGNP4
line 770
;770:						}
LABELV $345
line 771
;771:					}
LABELV $343
line 772
;772:					G_bprint(1, targ->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 773
;773:					G_bprint(1, deathstring);
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 774
;774:				}
ADDRGP4 $15
JUMPV
LABELV $340
line 776
;775:				else
;776:				{
line 777
;777:					attacker->real_owner->real_frags = attacker->real_owner->real_frags + 1;
ADDRLP4 44
ADDRFP4 4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 1024
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 778
;778:					logfrag(attacker->real_owner, targ);
ADDRFP4 4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
line 779
;779:					if (!(tf_data.toggleflags & 128))
ADDRGP4 tf_data
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $348
line 780
;780:					{
line 781
;781:						attacker->real_owner->s.v.frags = attacker->real_owner->real_frags;
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 782
;782:					}
LABELV $348
line 783
;783:					if (deathmsg == 34)
ADDRLP4 4
INDIRF4
CNSTF4 1107820544
NEF4 $350
line 784
;784:					{
line 785
;785:						deathstring = " is creamed by ";
ADDRLP4 0
ADDRGP4 $352
ASGNP4
line 786
;786:						deathstring2 = "'s sentry gun\n";
ADDRLP4 12
ADDRGP4 $353
ASGNP4
line 787
;787:					}
ADDRGP4 $351
JUMPV
LABELV $350
line 789
;788:					else
;789:					{
line 790
;790:						if (deathmsg == 27)
ADDRLP4 4
INDIRF4
CNSTF4 1104674816
NEF4 $354
line 791
;791:						{
line 792
;792:							deathstring = "'s spine is extracted by ";
ADDRLP4 0
ADDRGP4 $356
ASGNP4
line 793
;793:							deathstring2 = "'s sentry gun\n";
ADDRLP4 12
ADDRGP4 $353
ASGNP4
line 794
;794:						}
LABELV $354
line 795
;795:					}
LABELV $351
line 796
;796:					G_bprint(1, targ->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 797
;797:					G_bprint(1, deathstring);
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 798
;798:					G_bprint(1, attacker->real_owner->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 4
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
line 799
;799:					G_bprint(1, deathstring2);
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 800
;800:				}
line 801
;801:			}
ADDRGP4 $15
JUMPV
LABELV $337
line 803
;802:			else
;803:			{
line 804
;804:				logfrag(targ, targ);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
line 805
;805:				targ->real_frags = targ->real_frags - 1;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 1024
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 806
;806:				if (!(tf_data.toggleflags & 128))
ADDRGP4 tf_data
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $357
line 807
;807:				{
line 808
;808:					targ->s.v.frags = targ->real_frags;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 809
;809:				}
LABELV $357
line 810
;810:				rnum = targ->s.v.watertype;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ASGNF4
line 811
;811:				G_bprint(2, targ->s.v.netname);
CNSTI4 2
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 812
;812:				if (rnum == -3)
ADDRLP4 8
INDIRF4
CNSTF4 3225419776
NEF4 $359
line 813
;813:				{
line 814
;814:					if (g_random() < 0.5)
ADDRLP4 52
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 1056964608
GEF4 $361
line 815
;815:					{
line 816
;816:						deathstring = " can't swim worth a crap!\n";
ADDRLP4 0
ADDRGP4 $363
ASGNP4
line 817
;817:					}
ADDRGP4 $360
JUMPV
LABELV $361
line 819
;818:					else
;819:					{
line 820
;820:						deathstring = " can't breathe water\n";
ADDRLP4 0
ADDRGP4 $364
ASGNP4
line 821
;821:					}
line 822
;822:				}
ADDRGP4 $360
JUMPV
LABELV $359
line 824
;823:				else
;824:				{
line 825
;825:					if (rnum == -4)
ADDRLP4 8
INDIRF4
CNSTF4 3229614080
NEF4 $365
line 826
;826:					{
line 827
;827:						if (g_random() < 0.5)
ADDRLP4 52
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 1056964608
GEF4 $367
line 828
;828:						{
line 829
;829:							deathstring = " gulped a load of slime\n";
ADDRLP4 0
ADDRGP4 $369
ASGNP4
line 830
;830:						}
ADDRGP4 $366
JUMPV
LABELV $367
line 832
;831:						else
;832:						{
line 833
;833:							deathstring = " can't exist on slime alone\n";
ADDRLP4 0
ADDRGP4 $370
ASGNP4
line 834
;834:						}
line 835
;835:					}
ADDRGP4 $366
JUMPV
LABELV $365
line 837
;836:					else
;837:					{
line 838
;838:						if (rnum == -5)
ADDRLP4 8
INDIRF4
CNSTF4 3231711232
NEF4 $371
line 839
;839:						{
line 840
;840:							if (targ->s.v.health < -15)
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 3245342720
GEF4 $373
line 841
;841:							{
line 842
;842:								deathstring = " burst into flames\n";
ADDRLP4 0
ADDRGP4 $375
ASGNP4
line 843
;843:							}
ADDRGP4 $372
JUMPV
LABELV $373
line 845
;844:							else
;845:							{
line 846
;846:								if (g_random() < 0.5)
ADDRLP4 52
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 1056964608
GEF4 $376
line 847
;847:								{
line 848
;848:									deathstring = " turned into hot slag\n";
ADDRLP4 0
ADDRGP4 $378
ASGNP4
line 849
;849:								}
ADDRGP4 $372
JUMPV
LABELV $376
line 851
;850:								else
;851:								{
line 852
;852:									deathstring = " visits the Hell fires\n";
ADDRLP4 0
ADDRGP4 $379
ASGNP4
line 853
;853:								}
line 854
;854:							}
line 855
;855:						}
ADDRGP4 $372
JUMPV
LABELV $371
line 857
;856:						else
;857:						{
line 858
;858:							if (streq(attacker->s.v.classname, "monster_dog"))
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $382
ARGP4
ADDRLP4 52
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $380
line 859
;859:							{
line 860
;860:								deathstring = " was mauled by a Rottweiler\n";
ADDRLP4 0
ADDRGP4 $383
ASGNP4
line 861
;861:							}
ADDRGP4 $381
JUMPV
LABELV $380
line 863
;862:							else
;863:							{
line 864
;864:								if (streq(attacker->s.v.classname, "explo_box"))
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $386
ARGP4
ADDRLP4 56
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $384
line 865
;865:								{
line 866
;866:									deathstring = " blew up\n";
ADDRLP4 0
ADDRGP4 $387
ASGNP4
line 867
;867:								}
ADDRGP4 $385
JUMPV
LABELV $384
line 869
;868:								else
;869:								{
line 870
;870:									if (attacker->s.v.solid == SOLID_BSP && attacker != world)
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
CNSTF4 1082130432
NEF4 $388
ADDRLP4 60
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $388
line 871
;871:									{
line 872
;872:										deathstring = " was crushed\n";
ADDRLP4 0
ADDRGP4 $390
ASGNP4
line 873
;873:									}
ADDRGP4 $389
JUMPV
LABELV $388
line 875
;874:									else
;875:									{
line 876
;876:										if (targ->deathtype == "falling")
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 $393
CVPU4 4
NEU4 $391
line 877
;877:										{
line 878
;878:											targ->deathtype = "";
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ADDRGP4 $12
ASGNP4
line 879
;879:											deathstring = " fell to his death\n";
ADDRLP4 0
ADDRGP4 $394
ASGNP4
line 880
;880:										}
ADDRGP4 $392
JUMPV
LABELV $391
line 882
;881:										else
;882:										{
line 883
;883:											if (streq(attacker->s.v.classname, "trap_shooter") || attacker->s.v.classname  == "trap_spikeshooter")
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $397
ARGP4
ADDRLP4 64
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $399
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 $398
CVPU4 4
NEU4 $395
LABELV $399
line 884
;884:											{
line 885
;885:												deathstring = " was shot\n";
ADDRLP4 0
ADDRGP4 $400
ASGNP4
line 886
;886:											}
ADDRGP4 $396
JUMPV
LABELV $395
line 888
;887:											else
;888:											{
line 889
;889:												if (streq(attacker->s.v.classname, "fireball"))
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $403
ARGP4
ADDRLP4 68
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $401
line 890
;890:												{
line 891
;891:													deathstring = " ate a lavaball\n";
ADDRLP4 0
ADDRGP4 $404
ASGNP4
line 892
;892:												}
ADDRGP4 $402
JUMPV
LABELV $401
line 894
;893:												else
;894:												{
line 895
;895:													if (streq(attacker->s.v.classname, "trigger_changelevel"))
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $407
ARGP4
ADDRLP4 72
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $405
line 896
;896:													{
line 897
;897:														deathstring = " tried to leave\n";
ADDRLP4 0
ADDRGP4 $408
ASGNP4
line 898
;898:													}
ADDRGP4 $406
JUMPV
LABELV $405
line 900
;899:													else
;900:													{
line 901
;901:														deathstring = " died\n";
ADDRLP4 0
ADDRGP4 $409
ASGNP4
line 902
;902:													}
LABELV $406
line 903
;903:												}
LABELV $402
line 904
;904:											}
LABELV $396
line 905
;905:										}
LABELV $392
line 906
;906:									}
LABELV $389
line 907
;907:								}
LABELV $385
line 908
;908:							}
LABELV $381
line 909
;909:						}
LABELV $372
line 910
;910:					}
LABELV $366
line 911
;911:				}
LABELV $360
line 912
;912:				G_bprint(1, deathstring);
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 913
;913:			}
line 914
;914:		}
line 915
;915:	}
ADDRGP4 $15
JUMPV
LABELV $14
line 917
;916:	else
;917:	{
line 918
;918:		if (streq(targ->s.v.classname, "building_sentrygun"))
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $339
ARGP4
ADDRLP4 24
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $410
line 919
;919:		{
line 920
;920:			if (streq(attacker->s.v.classname, "teledeath"))
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $19
ARGP4
ADDRLP4 28
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $412
line 921
;921:			{
line 922
;922:				G_bprint(1, targ->real_owner->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 0
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
line 923
;923:				G_bprint(1, "'s sentrygun was telefragged by ");
CNSTI4 1
ARGI4
ADDRGP4 $414
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 924
;924:				G_bprint(1, PROG_TO_EDICT(attacker->s.v.owner)->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+284
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 925
;925:				G_bprint(1, "\n");
CNSTI4 1
ARGI4
ADDRGP4 $23
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 926
;926:				return;
ADDRGP4 $11
JUMPV
LABELV $412
line 928
;927:			}
;928:			if (streq(attacker->s.v.classname, "player"))
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 32
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $417
line 929
;929:			{
line 930
;930:				if (attacker == targ->real_owner)
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
NEU4 $419
line 931
;931:				{
line 932
;932:					G_bprint(1, targ->real_owner->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 0
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
line 933
;933:					G_bprint(1, " selfdistructs his sentrygun\n");
CNSTI4 1
ARGI4
ADDRGP4 $421
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 934
;934:					return;
ADDRGP4 $11
JUMPV
LABELV $419
line 936
;935:				}
;936:				G_bprint(1, targ->real_owner->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 0
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
line 937
;937:				G_bprint(1, "'s sentrygun was no match for ");
CNSTI4 1
ARGI4
ADDRGP4 $422
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 938
;938:				G_bprint(1, attacker->s.v.netname);
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 939
;939:				G_bprint(1, "\n");
CNSTI4 1
ARGI4
ADDRGP4 $23
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 940
;940:				logfrag(attacker, targ->real_owner);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
line 941
;941:				attacker->real_frags = attacker->real_frags + 1;
ADDRLP4 36
ADDRFP4 4
INDIRP4
CNSTI4 1024
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 943
;942:				// pablo. no frags when teamscores is on.
;943:				if (!(tf_data.toggleflags & 128))
ADDRGP4 tf_data
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $423
line 944
;944:				{
line 945
;945:					attacker->s.v.frags = attacker->real_frags;
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 946
;946:				}
LABELV $423
line 948
;947:				//
;948:				if (attacker->team_no > 0 && attacker->team_no != targ->real_owner->team_no)
ADDRLP4 40
CNSTI4 960
ASGNI4
ADDRLP4 44
ADDRFP4 4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
LEI4 $11
ADDRLP4 44
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
EQI4 $11
line 949
;949:				{
line 950
;950:					attacker->real_frags = attacker->real_frags + 1;
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 1024
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 951
;951:					logfrag(attacker, targ->real_owner);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
line 952
;952:					if (!(tf_data.toggleflags & 128))
ADDRGP4 tf_data
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $11
line 953
;953:					{
line 954
;954:						attacker->s.v.frags = attacker->real_frags;
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 955
;955:					}
line 956
;956:				}
line 957
;957:				return;
LABELV $417
line 959
;958:			}
;959:		}
LABELV $410
line 960
;960:	}
LABELV $15
line 961
;961:}様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様
LABELV $11
endproc Mega_ClientObituary 76 20
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
LABELV $422
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 0
align 1
LABELV $421
byte 1 32
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 100
byte 1 105
byte 1 115
byte 1 116
byte 1 114
byte 1 117
byte 1 99
byte 1 116
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $414
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $409
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $408
byte 1 32
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 118
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $407
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $404
byte 1 32
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $403
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $400
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $398
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 95
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $397
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $394
byte 1 32
byte 1 102
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 10
byte 1 0
align 1
LABELV $393
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $390
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 99
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $387
byte 1 32
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 117
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $386
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 95
byte 1 98
byte 1 111
byte 1 120
byte 1 0
align 1
LABELV $383
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 117
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 97
byte 1 32
byte 1 82
byte 1 111
byte 1 116
byte 1 116
byte 1 119
byte 1 101
byte 1 105
byte 1 108
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $382
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $379
byte 1 32
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 72
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $378
byte 1 32
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 104
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $375
byte 1 32
byte 1 98
byte 1 117
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $370
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 101
byte 1 120
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 115
byte 1 108
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 111
byte 1 110
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $369
byte 1 32
byte 1 103
byte 1 117
byte 1 108
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 115
byte 1 108
byte 1 105
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $364
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 98
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $363
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 109
byte 1 32
byte 1 119
byte 1 111
byte 1 114
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 99
byte 1 114
byte 1 97
byte 1 112
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $356
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 101
byte 1 120
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $353
byte 1 39
byte 1 115
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
byte 1 10
byte 1 0
align 1
LABELV $352
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $347
byte 1 32
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 115
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
byte 1 39
byte 1 115
byte 1 32
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $344
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 104
byte 1 105
byte 1 115
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
byte 1 10
byte 1 68
byte 1 117
byte 1 109
byte 1 98
byte 1 45
byte 1 97
byte 1 115
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $339
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
LABELV $336
byte 1 39
byte 1 115
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
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 109
byte 1 101
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 105
byte 1 99
byte 1 97
byte 1 108
byte 1 32
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $335
byte 1 32
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 0
align 1
LABELV $332
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $331
byte 1 39
byte 1 115
byte 1 32
byte 1 108
byte 1 101
byte 1 103
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 109
byte 1 112
byte 1 117
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $328
byte 1 39
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 99
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 97
byte 1 114
byte 1 121
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $327
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 111
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $324
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $323
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 119
byte 1 115
byte 1 32
byte 1 106
byte 1 117
byte 1 105
byte 1 99
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 114
byte 1 117
byte 1 32
byte 1 104
byte 1 111
byte 1 108
byte 1 101
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 0
align 1
LABELV $320
byte 1 39
byte 1 115
byte 1 32
byte 1 108
byte 1 117
byte 1 100
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $319
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 45
byte 1 100
byte 1 111
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $316
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 115
byte 1 115
byte 1 45
byte 1 107
byte 1 110
byte 1 105
byte 1 102
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $313
byte 1 32
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $310
byte 1 39
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $309
byte 1 32
byte 1 101
byte 1 110
byte 1 106
byte 1 111
byte 1 121
byte 1 115
byte 1 32
byte 1 0
align 1
LABELV $306
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $305
byte 1 39
byte 1 115
byte 1 32
byte 1 108
byte 1 101
byte 1 103
byte 1 115
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 0
align 1
LABELV $304
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $299
byte 1 39
byte 1 115
byte 1 32
byte 1 108
byte 1 97
byte 1 98
byte 1 111
byte 1 116
byte 1 111
byte 1 109
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $298
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $297
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $292
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $291
byte 1 39
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 116
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 0
align 1
LABELV $290
byte 1 39
byte 1 115
byte 1 32
byte 1 108
byte 1 105
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $287
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 117
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 116
byte 1 32
byte 1 119
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 0
align 1
LABELV $282
byte 1 32
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 0
align 1
LABELV $279
byte 1 39
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $278
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 109
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 0
align 1
LABELV $275
byte 1 39
byte 1 115
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $274
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 102
byte 1 111
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $271
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $268
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $267
byte 1 39
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 112
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $264
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 105
byte 1 114
byte 1 100
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $263
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 115
byte 1 115
byte 1 45
byte 1 99
byte 1 104
byte 1 101
byte 1 101
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $260
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 45
byte 1 119
byte 1 104
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $257
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 108
byte 1 105
byte 1 116
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $256
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 98
byte 1 98
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $251
byte 1 39
byte 1 115
byte 1 32
byte 1 66
byte 1 66
byte 1 81
byte 1 10
byte 1 0
align 1
LABELV $250
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $249
byte 1 39
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 99
byte 1 105
byte 1 110
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $248
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 114
byte 1 101
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $245
byte 1 39
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $244
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 98
byte 1 111
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $241
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $240
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $237
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $236
byte 1 32
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $231
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 116
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $228
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 114
byte 1 110
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 82
byte 1 111
byte 1 116
byte 1 116
byte 1 119
byte 1 101
byte 1 105
byte 1 108
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $225
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 118
byte 1 97
byte 1 112
byte 1 111
byte 1 114
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $222
byte 1 39
byte 1 115
byte 1 32
byte 1 76
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 68
byte 1 114
byte 1 111
byte 1 110
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $221
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $218
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 117
byte 1 110
byte 1 103
byte 1 104
byte 1 111
byte 1 108
byte 1 101
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $215
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $214
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $211
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 108
byte 1 105
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 104
byte 1 97
byte 1 108
byte 1 102
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $208
byte 1 32
byte 1 115
byte 1 119
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 115
byte 1 32
byte 1 0
align 1
LABELV $205
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 100
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $204
byte 1 32
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 112
byte 1 101
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 0
align 1
LABELV $201
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
LABELV $200
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 111
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $199
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 0
align 1
LABELV $196
byte 1 32
byte 1 99
byte 1 117
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 0
align 1
LABELV $193
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
byte 1 10
byte 1 0
align 1
LABELV $192
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 117
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $189
byte 1 39
byte 1 115
byte 1 32
byte 1 69
byte 1 77
byte 1 80
byte 1 32
byte 1 110
byte 1 117
byte 1 107
byte 1 101
byte 1 115
byte 1 32
byte 1 105
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $188
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 115
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 0
align 1
LABELV $185
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $184
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $181
byte 1 39
byte 1 115
byte 1 32
byte 1 69
byte 1 77
byte 1 80
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $180
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 118
byte 1 97
byte 1 112
byte 1 111
byte 1 114
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $177
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 108
byte 1 117
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $176
byte 1 32
byte 1 115
byte 1 110
byte 1 105
byte 1 102
byte 1 102
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 109
byte 1 117
byte 1 99
byte 1 104
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 0
align 1
LABELV $173
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 32
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $170
byte 1 39
byte 1 115
byte 1 32
byte 1 65
byte 1 105
byte 1 114
byte 1 77
byte 1 105
byte 1 114
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $169
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $166
byte 1 39
byte 1 115
byte 1 32
byte 1 77
byte 1 105
byte 1 114
byte 1 118
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $165
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 106
byte 1 117
byte 1 105
byte 1 99
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $162
byte 1 39
byte 1 115
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $161
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 102
byte 1 111
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $158
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $157
byte 1 32
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 104
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 0
align 1
LABELV $154
byte 1 39
byte 1 115
byte 1 32
byte 1 50
byte 1 48
byte 1 109
byte 1 109
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $153
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 101
byte 1 100
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $150
byte 1 39
byte 1 115
byte 1 32
byte 1 80
byte 1 114
byte 1 111
byte 1 120
byte 1 105
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $149
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 0
align 1
LABELV $146
byte 1 39
byte 1 115
byte 1 32
byte 1 65
byte 1 105
byte 1 114
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $145
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $140
byte 1 32
byte 1 100
byte 1 105
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 115
byte 1 117
byte 1 114
byte 1 118
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $137
byte 1 32
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $136
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 10
byte 1 0
align 1
LABELV $133
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 103
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $130
byte 1 32
byte 1 109
byte 1 111
byte 1 119
byte 1 115
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $121
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 115
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
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 114
byte 1 111
byte 1 110
byte 1 103
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $118
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 114
byte 1 117
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 105
byte 1 114
byte 1 115
byte 1 112
byte 1 97
byte 1 109
byte 1 10
byte 1 0
align 1
LABELV $115
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 99
byte 1 107
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $112
byte 1 32
byte 1 98
byte 1 97
byte 1 107
byte 1 101
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $111
byte 1 39
byte 1 115
byte 1 32
byte 1 74
byte 1 101
byte 1 116
byte 1 80
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 109
byte 1 97
byte 1 108
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $106
byte 1 32
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 117
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 105
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $103
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 99
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 97
byte 1 114
byte 1 121
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $100
byte 1 39
byte 1 115
byte 1 32
byte 1 76
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 68
byte 1 114
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 108
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $97
byte 1 32
byte 1 104
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $96
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 115
byte 1 32
byte 1 105
byte 1 102
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $91
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 109
byte 1 112
byte 1 111
byte 1 115
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 121
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $88
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
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 10
byte 1 32
byte 1 84
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 109
byte 1 97
byte 1 114
byte 1 116
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $85
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 111
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 98
byte 1 111
byte 1 120
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 10
byte 1 0
align 1
LABELV $82
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 10
byte 1 0
align 1
LABELV $79
byte 1 32
byte 1 110
byte 1 117
byte 1 107
byte 1 101
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $76
byte 1 32
byte 1 103
byte 1 97
byte 1 103
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 97
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 112
byte 1 101
byte 1 119
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $73
byte 1 32
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 87
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 100
byte 1 117
byte 1 109
byte 1 98
byte 1 45
byte 1 97
byte 1 115
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $70
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $67
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $64
byte 1 32
byte 1 104
byte 1 117
byte 1 103
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $61
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $58
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
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $50
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $45
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
LABELV $40
byte 1 39
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $39
byte 1 83
byte 1 97
byte 1 116
byte 1 97
byte 1 110
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 32
byte 1 0
align 1
LABELV $38
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 50
byte 1 0
align 1
LABELV $23
byte 1 10
byte 1 0
align 1
LABELV $20
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 0
align 1
LABELV $19
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $16
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $12
byte 1 0
