export TeamFortress_MOTD
code
proc TeamFortress_MOTD 276 16
file "..\src\tforthlp.c"
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
;21: *  $Id: tforthlp.c,v 1.9 2005/05/05 14:51:43 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:void TeamFortress_MOTD(  )
;26:{
line 30
;27:	int     rnum;
;28:	char	mu[256];	//music
;29:
;30:	if ( self->motd == 4 )
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
CNSTI4 4
NEI4 $12
line 31
;31:		stuffcmd( self, "is_aliased\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $14
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $12
line 32
;32:	if ( self->motd <= 20 )
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
CNSTI4 20
GTI4 $15
line 33
;33:	{
line 34
;34:		self->motd += 1;
ADDRLP4 260
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
ASGNP4
ADDRLP4 260
INDIRP4
ADDRLP4 260
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 35
;35:		return;
ADDRGP4 $11
JUMPV
LABELV $15
line 37
;36:	}
;37:	if ( self->motd == 21 )
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
CNSTI4 21
NEI4 $17
line 38
;38:	{
line 39
;39:		if ( !0 )
line 40
;40:			self->tfstate |= TFSTATE_ZOOMOFF;
ADDRLP4 260
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 260
INDIRP4
ADDRLP4 260
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
LABELV $19
line 42
;41:
;42:		if ( teamplay && !self->team_no )
ADDRLP4 264
CNSTI4 0
ASGNI4
ADDRGP4 teamplay
INDIRI4
ADDRLP4 264
INDIRI4
EQI4 $21
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 264
INDIRI4
NEI4 $21
line 43
;43:		{
line 44
;44:		        TeamFortress_SetColor( self, 0,0);
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 268
CNSTI4 0
ASGNI4
ADDRLP4 268
INDIRI4
ARGI4
ADDRLP4 268
INDIRI4
ARGI4
ADDRGP4 TeamFortress_SetColor
CALLV
pop
line 45
;45:		}
LABELV $21
line 46
;46:		rnum = ( int ) g_random();
ADDRLP4 268
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 256
ADDRLP4 268
INDIRF4
CVFI4 4
ASGNI4
line 48
;47:		// play the megatf join music
;48:		infokey( self, "tf_music", mu, sizeof( mu ) );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $23
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 infokey
CALLV
pop
line 49
;49:		if ( tf_data.tf_music == 1 && strcmp( mu, "off" ) )
ADDRGP4 tf_data+196
INDIRI4
CNSTI4 1
NEI4 $24
ADDRLP4 0
ARGP4
ADDRGP4 $27
ARGP4
ADDRLP4 272
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $24
line 50
;50:		{
line 51
;51:			if (rnum < 0.33)
ADDRLP4 256
INDIRI4
CVIF4 4
CNSTF4 1051260355
GEF4 $28
line 52
;52:			{
line 53
;53:				stuffcmd( self, "play music/megamnu1.wav\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $30
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 54
;54:			}
ADDRGP4 $29
JUMPV
LABELV $28
line 56
;55:			else
;56:			{
line 57
;57:				if (rnum < 0.66)
ADDRLP4 256
INDIRI4
CVIF4 4
CNSTF4 1059648963
GEF4 $31
line 58
;58:				{
line 59
;59:					stuffcmd( self, "play music/megamnu2.wav\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $33
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 60
;60:				}
ADDRGP4 $32
JUMPV
LABELV $31
line 62
;61:				else
;62:				{
line 63
;63:					stuffcmd( self, "play music/megamnu3.wav\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $34
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 64
;64:				}
LABELV $32
line 65
;65:			}
LABELV $29
line 66
;66:		}
LABELV $24
line 67
;67:		if ( !self->got_aliases )
ADDRGP4 self
INDIRP4
CNSTI4 856
ADDP4
INDIRI4
CNSTI4 0
NEI4 $35
line 68
;68:			G_sprint( self, 2, "\n\n\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $37
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $35
line 69
;69:		G_sprint( self, 2, "Type help for more info.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $38
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 70
;70:		G_sprint( self, 2, MEGATF_VERSION );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $39
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 73
;71:		//G_sprint( self, 2, "Ñõáëå×ïòìä ÔåáíÆïòôòåóó ”’’•\n" );
;72:
;73:		if( tf_data.enable_bot )
ADDRGP4 tf_data+180
INDIRI4
CNSTI4 0
EQI4 $40
line 74
;74:		{
line 75
;75:		      G_sprint( self, 2, "Bots Enabled\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $43
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 76
;76:		}
LABELV $40
line 79
;77:
;78://		G_sprint(self, 2, "Official ÍÔÆÌ version\n");
;79:		G_sprint( self, 2, "C code by sd‘ angel for ÍÔÆÌ\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $44
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 80
;80:		G_sprint( self, 2, "MTF-C code by ØavioÒ\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $45
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 81
;81:		G_sprint( self, 2, "Bug reports to avirox38@hotmail.com\n" );
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
line 82
;82:		G_sprint( self, 2, "http://ÁíîåóéáÇáíåó®ãïí\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $47
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 84
;83:
;84:		self->menu_displaytime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 956
ADDP4
CNSTI4 0
ASGNI4
line 85
;85:		self->current_menu = MENU_INTRO;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 5
ASGNI4
line 86
;86:		self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 87
;87:		self->motd = 22;
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
CNSTI4 22
ASGNI4
line 88
;88:		if ( self->got_aliases == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 856
ADDP4
INDIRI4
CNSTI4 1
NEI4 $48
line 89
;89:			return;
ADDRGP4 $11
JUMPV
LABELV $48
line 90
;90:		G_sprint( self, 2, "binding aliases...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $50
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 91
;91:		TeamFortress_Alias( "inv", 135, 0 );
ADDRGP4 $51
ARGP4
CNSTI4 135
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 92
;92:		TeamFortress_Alias( "showtf", 136, 0 );
ADDRGP4 $52
ARGP4
CNSTI4 136
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 93
;93:		TeamFortress_Alias( "autozoom", 174, 0 );
ADDRGP4 $53
ARGP4
CNSTI4 174
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 94
;94:		TeamFortress_Alias( "changeclass", 99, 0 );
ADDRGP4 $54
ARGP4
CNSTI4 99
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 95
;95:		TeamFortress_Alias( "scout", TF_CHANGEPC + PC_SCOUT, 0 );
ADDRGP4 $55
ARGP4
CNSTI4 101
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 96
;96:		TeamFortress_Alias( "sniper", TF_CHANGEPC + PC_SNIPER, 0 );
ADDRGP4 $56
ARGP4
CNSTI4 102
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 97
;97:		TeamFortress_Alias( "soldier", TF_CHANGEPC + PC_SOLDIER, 0 );
ADDRGP4 $57
ARGP4
CNSTI4 103
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 98
;98:		TeamFortress_Alias( "demoman", TF_CHANGEPC + PC_DEMOMAN, 0 );
ADDRGP4 $58
ARGP4
CNSTI4 104
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 99
;99:		TeamFortress_Alias( "medic", TF_CHANGEPC + PC_MEDIC, 0 );
ADDRGP4 $59
ARGP4
CNSTI4 105
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 100
;100:		TeamFortress_Alias( "hwguy", TF_CHANGEPC + PC_HVYWEAP, 0 );
ADDRGP4 $60
ARGP4
CNSTI4 106
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 101
;101:		TeamFortress_Alias( "pyro", TF_CHANGEPC + PC_PYRO, 0 );
ADDRGP4 $61
ARGP4
CNSTI4 107
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 102
;102:		TeamFortress_Alias( "spy", TF_CHANGEPC + PC_SPY, 0 );
ADDRGP4 $62
ARGP4
CNSTI4 108
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 103
;103:		TeamFortress_Alias( "engineer", TF_CHANGEPC + PC_ENGINEER, 0 );
ADDRGP4 $63
ARGP4
CNSTI4 109
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 104
;104:		TeamFortress_Alias( "randompc", TF_CHANGEPC + PC_RANDOM, 0 );
ADDRGP4 $64
ARGP4
CNSTI4 110
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 106
;105:		//mtf
;106:		TeamFortress_Alias( "ir", 50, 0 );		// night vision
ADDRGP4 $65
ARGP4
CNSTI4 50
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 107
;107:		TeamFortress_Alias( "dot", 61, 0 );
ADDRGP4 $66
ARGP4
CNSTI4 61
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 108
;108:		TeamFortress_Alias( "airscout", 154, 0 );
ADDRGP4 $67
ARGP4
CNSTI4 154
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 109
;109:		TeamFortress_Alias( "jetjump", 155, 0 );
ADDRGP4 $68
ARGP4
CNSTI4 155
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 110
;110:		TeamFortress_Alias( "bic", 157, 0 );
ADDRGP4 $69
ARGP4
CNSTI4 157
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 111
;111:		TeamFortress_Alias( "bhole", 58, 0 );
ADDRGP4 $70
ARGP4
CNSTI4 58
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 112
;112:		TeamFortress_Alias( "hey", 156, 0 );
ADDRGP4 $71
ARGP4
CNSTI4 156
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 113
;113:		TeamFortress_Alias( "pants", 250, 0 );
ADDRGP4 $72
ARGP4
CNSTI4 250
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 114
;114:		TeamFortress_Alias( "lay", 158, 0 );
ADDRGP4 $73
ARGP4
CNSTI4 158
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 115
;115:		TeamFortress_Alias( "drop1", 190, 0 );
ADDRGP4 $74
ARGP4
CNSTI4 190
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 116
;116:		TeamFortress_Alias( "holo", 200, 0 );
ADDRGP4 $75
ARGP4
CNSTI4 200
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 117
;117:		TeamFortress_Alias( "taunt", 53, 0 );
ADDRGP4 $76
ARGP4
CNSTI4 53
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 118
;118:		TeamFortress_Alias( "yell", 56, 0 );
ADDRGP4 $77
ARGP4
CNSTI4 56
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 119
;119:		TeamFortress_Alias( "mega", 57, 0 );
ADDRGP4 $78
ARGP4
CNSTI4 57
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 120
;120:		TeamFortress_Alias( "drop2", 201, 0 );
ADDRGP4 $79
ARGP4
CNSTI4 201
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 121
;121:		TeamFortress_Alias( "pants", 250, 0 );
ADDRGP4 $72
ARGP4
CNSTI4 250
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 122
;122:		TeamFortress_Alias( "drop3", 55, 0 );
ADDRGP4 $80
ARGP4
CNSTI4 55
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 123
;123:		TeamFortress_Alias( "is_aliased", 13, 0 );
ADDRGP4 $81
ARGP4
CNSTI4 13
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 124
;124:		return;
ADDRGP4 $11
JUMPV
LABELV $17
line 126
;125:	}
;126:	if ( self->motd <= 95 )
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
CNSTI4 95
GTI4 $82
line 127
;127:		self->motd += 1;
ADDRLP4 260
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
ASGNP4
ADDRLP4 260
INDIRP4
ADDRLP4 260
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $82
line 128
;128:	if ( self->motd == 25 )
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
CNSTI4 25
NEI4 $84
line 129
;129:	{
line 130
;130:		TeamFortress_Alias( "detpipe", 170, 0 );
ADDRGP4 $86
ARGP4
CNSTI4 170
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 131
;131:		TeamFortress_Alias( "reload", 173, 0 );
ADDRGP4 $87
ARGP4
CNSTI4 173
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 132
;132:		TeamFortress_Alias( "scan10", 162, 0 );
ADDRGP4 $88
ARGP4
CNSTI4 162
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 133
;133:		TeamFortress_Alias( "scan30", 163, 0 );
ADDRGP4 $89
ARGP4
CNSTI4 163
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 134
;134:		TeamFortress_Alias( "scan50", 164, 0 );
ADDRGP4 $90
ARGP4
CNSTI4 164
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 135
;135:		TeamFortress_Alias( "scan100", 164, 0 );
ADDRGP4 $91
ARGP4
CNSTI4 164
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 136
;136:		TeamFortress_Alias( "scanf", 161, 0 );
ADDRGP4 $92
ARGP4
CNSTI4 161
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 137
;137:		TeamFortress_Alias( "scane", 160, 0 );
ADDRGP4 $93
ARGP4
CNSTI4 160
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 138
;138:		TeamFortress_Alias( "autoscan", AUTOSCAN_IMPULSE, 0 );
ADDRGP4 $94
ARGP4
CNSTI4 210
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 139
;139:		TeamFortress_Alias("scanf_off", TF_SCAN, TF_POST_SCANF_OFF);
ADDRGP4 $95
ARGP4
CNSTI4 159
ARGI4
CNSTI4 162
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 140
;140:		TeamFortress_Alias("scanf_on" , TF_SCAN, TF_POST_SCANF_ON );
ADDRGP4 $96
ARGP4
CNSTI4 159
ARGI4
CNSTI4 163
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 141
;141:		TeamFortress_Alias("scane_off", TF_SCAN, TF_POST_SCANE_OFF);
ADDRGP4 $97
ARGP4
CNSTI4 159
ARGI4
CNSTI4 164
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 142
;142:		TeamFortress_Alias("scane_on" , TF_SCAN, TF_POST_SCANE_ON );
ADDRGP4 $98
ARGP4
CNSTI4 159
ARGI4
CNSTI4 165
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 143
;143:		TeamFortress_Alias("autoscan_on" ,  TF_SCAN, TF_POST_AUTOSCAN_ON  );
ADDRGP4 $99
ARGP4
CNSTI4 159
ARGI4
CNSTI4 167
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 144
;144:		TeamFortress_Alias("autoscan_off" , TF_SCAN, TF_POST_AUTOSCAN_OFF );
ADDRGP4 $100
ARGP4
CNSTI4 159
ARGI4
CNSTI4 166
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 145
;145:		return;
ADDRGP4 $11
JUMPV
LABELV $84
line 147
;146:	}
;147:	if ( self->motd == 35 )
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
CNSTI4 35
NEI4 $101
line 148
;148:	{
line 149
;149:		TeamFortress_Alias( "primeone", 150, 0 );
ADDRGP4 $103
ARGP4
CNSTI4 150
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 150
;150:		TeamFortress_Alias( "primetwo", 151, 0 );
ADDRGP4 $104
ARGP4
CNSTI4 151
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 151
;151:		TeamFortress_Alias( "throwgren", 152, 0 );
ADDRGP4 $105
ARGP4
CNSTI4 152
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 152
;152:		TeamFortress_Alias( "+gren1", 150, 0 );
ADDRGP4 $106
ARGP4
CNSTI4 150
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 153
;153:		TeamFortress_Alias( "+gren2", 151, 0 );
ADDRGP4 $107
ARGP4
CNSTI4 151
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 154
;154:		TeamFortress_Alias( "-gren1", 152, 0 );
ADDRGP4 $108
ARGP4
CNSTI4 152
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 155
;155:		TeamFortress_Alias( "-gren2", 152, 0 );
ADDRGP4 $109
ARGP4
CNSTI4 152
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 156
;156:		TeamFortress_Alias( "showscores", 145, 0 );
ADDRGP4 $110
ARGP4
CNSTI4 145
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 157
;157:		TeamFortress_Alias( "showclasses", 144, 0 );
ADDRGP4 $111
ARGP4
CNSTI4 144
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 158
;158:		TeamFortress_Alias( "query", 119, 0 );
ADDRGP4 $112
ARGP4
CNSTI4 119
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 159
;159:		return;
ADDRGP4 $11
JUMPV
LABELV $101
line 161
;160:	}
;161:	if ( self->motd == 45 )
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
CNSTI4 45
NEI4 $113
line 162
;162:	{
line 163
;163:		TeamFortress_Alias( "dropkey", 175, 0 );
ADDRGP4 $115
ARGP4
CNSTI4 175
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 164
;164:		TeamFortress_Alias( "dropammo", 172, 0 );
ADDRGP4 $116
ARGP4
CNSTI4 172
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 165
;165:		TeamFortress_Alias( "dropitems", 194, 0 );
ADDRGP4 $117
ARGP4
CNSTI4 194
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 166
;166:		TeamFortress_Alias( "showloc", 118, 0 );
ADDRGP4 $118
ARGP4
CNSTI4 118
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 167
;167:		TeamFortress_Alias( "special", 171, 0 );
ADDRGP4 $119
ARGP4
CNSTI4 171
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 168
;168:		TeamFortress_Alias( "saveme", 181, 0 );
ADDRGP4 $120
ARGP4
CNSTI4 181
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 169
;169:		TeamFortress_Alias( "discard", 184, 0 );
ADDRGP4 $121
ARGP4
CNSTI4 184
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 170
;170:		TeamFortress_Alias( "id", 185, 0 );
ADDRGP4 $122
ARGP4
CNSTI4 185
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 171
;171:		return;
ADDRGP4 $11
JUMPV
LABELV $113
line 173
;172:	}
;173:	if ( self->motd == 55 )
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
CNSTI4 55
NEI4 $123
line 174
;174:	{
line 175
;175:		TeamFortress_Alias( "flaginfo", 23, 0 );
ADDRGP4 $125
ARGP4
CNSTI4 23
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 176
;176:		TeamFortress_Alias( "maphelp", 131, 0 );
ADDRGP4 $126
ARGP4
CNSTI4 131
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 177
;177:		TeamFortress_Alias( "showids", 186, 0 );
ADDRGP4 $127
ARGP4
CNSTI4 186
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 178
;178:		stuffcmd( self, "bind 9 \"impulse 9\"\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $128
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 179
;179:		stuffcmd( self, "bind 0 \"impulse 10\"\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $129
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 180
;180:		return;
ADDRGP4 $11
JUMPV
LABELV $123
line 182
;181:	}
;182:	if ( self->motd == 65 )
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
CNSTI4 65
NEI4 $130
line 183
;183:	{
line 184
;184:		TeamFortress_Alias( "sbar_on", 182, 0 );
ADDRGP4 $132
ARGP4
CNSTI4 182
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 185
;185:		TeamFortress_Alias( "sbar_off", 183, 0 );
ADDRGP4 $133
ARGP4
CNSTI4 183
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 186
;186:		TeamFortress_Alias( "sbar_200", 71, 0 );
ADDRGP4 $134
ARGP4
CNSTI4 71
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 187
;187:		TeamFortress_Alias( "sbar_240", 71 + 1, 0 );
ADDRGP4 $135
ARGP4
CNSTI4 72
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 188
;188:		TeamFortress_Alias( "sbar_300", 71 + 2, 0 );
ADDRGP4 $136
ARGP4
CNSTI4 73
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 189
;189:		TeamFortress_Alias( "sbar_350", 71 + 3, 0 );
ADDRGP4 $137
ARGP4
CNSTI4 74
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 190
;190:		TeamFortress_Alias( "sbar_384", 71 + 4, 0 );
ADDRGP4 $138
ARGP4
CNSTI4 75
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 191
;191:		TeamFortress_Alias( "sbar_400", 71 + 5, 0 );
ADDRGP4 $139
ARGP4
CNSTI4 76
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 192
;192:		TeamFortress_Alias( "sbar_480", 71 + 6, 0 );
ADDRGP4 $140
ARGP4
CNSTI4 77
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 193
;193:		TeamFortress_Alias( "sbar_600", 71 + 7, 0 );
ADDRGP4 $141
ARGP4
CNSTI4 78
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 194
;194:		TeamFortress_Alias( "sbar_768", 71 + 8, 0 );
ADDRGP4 $142
ARGP4
CNSTI4 79
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 195
;195:		return;
ADDRGP4 $11
JUMPV
LABELV $130
line 197
;196:	}
;197:	if ( self->motd == 75 )
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
CNSTI4 75
NEI4 $143
line 198
;198:	{
line 199
;199:		TeamFortress_Alias( "+det5", 165, 0 );
ADDRGP4 $145
ARGP4
CNSTI4 165
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 200
;200:		TeamFortress_Alias( "-det5", 169, 0 );
ADDRGP4 $146
ARGP4
CNSTI4 169
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 201
;201:		TeamFortress_Alias( "+det20", 166, 0 );
ADDRGP4 $147
ARGP4
CNSTI4 166
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 202
;202:		TeamFortress_Alias( "-det20", 169, 0 );
ADDRGP4 $148
ARGP4
CNSTI4 169
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 203
;203:		TeamFortress_Alias( "+det50", 167, 0 );
ADDRGP4 $149
ARGP4
CNSTI4 167
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 204
;204:		TeamFortress_Alias( "-det50", 169, 0 );
ADDRGP4 $150
ARGP4
CNSTI4 169
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 205
;205:		return;
ADDRGP4 $11
JUMPV
LABELV $143
line 207
;206:	}
;207:	if ( self->motd == 85 )
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
CNSTI4 85
NEI4 $151
line 208
;208:	{
line 209
;209:              if(tg_data.tg_enabled)
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $11
line 210
;210:              {
line 211
;211:		TeamFortress_Alias( "mod_menu", TG_MAINMENU_IMPULSE, 0 );
ADDRGP4 $155
ARGP4
CNSTI4 220
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 212
;212:		TeamFortress_Alias( "sg_rebuild", TG_SG_REBUILD_IMPULSE, 0 );
ADDRGP4 $156
ARGP4
CNSTI4 221
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 213
;213:		TeamFortress_Alias( "sg_reload", TG_SG_RELOAD_IMPULSE, 0 );
ADDRGP4 $157
ARGP4
CNSTI4 222
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 214
;214:		TeamFortress_Alias( "sg_upgrade", TG_SG_UPGRADE_IMPULSE, 0 );
ADDRGP4 $158
ARGP4
CNSTI4 223
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 215
;215:		TeamFortress_Alias( "disp_load", TG_DISP_LOAD_IMPULSE, 0 );
ADDRGP4 $159
ARGP4
CNSTI4 224
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 216
;216:		TeamFortress_Alias( "disp_unload", TG_DISP_UNLOAD_IMPULSE, 0 );
ADDRGP4 $160
ARGP4
CNSTI4 225
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 217
;217:		TeamFortress_Alias( "eff_conc", TG_CONC_IMPULSE, 0);
ADDRGP4 $161
ARGP4
CNSTI4 205
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 218
;218:		TeamFortress_Alias( "eff_flash", TG_FLASH_IMPULSE, 0);
ADDRGP4 $162
ARGP4
CNSTI4 206
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 219
;219:		TeamFortress_Alias( "eff_remove", TG_EFF_REMOVE_IMPULSE, 0);
ADDRGP4 $163
ARGP4
CNSTI4 207
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 220
;220:              }
line 221
;221:		return;
ADDRGP4 $11
JUMPV
LABELV $151
line 223
;222:	}
;223:	if ( self->motd == 95 )
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
CNSTI4 95
NEI4 $164
line 224
;224:	{
line 225
;225:		TeamFortress_Alias( "disguise", 177, 0 );
ADDRGP4 $166
ARGP4
CNSTI4 177
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 226
;226:		TeamFortress_Alias( "feign", 178, 0 );
ADDRGP4 $167
ARGP4
CNSTI4 178
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 227
;227:		TeamFortress_Alias( "sfeign", TF_SPY_SFEIGN_IMPULSE, 0 );
ADDRGP4 $168
ARGP4
CNSTI4 199
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 228
;228:		TeamFortress_Alias( "build", 179, 0 );
ADDRGP4 $169
ARGP4
CNSTI4 179
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 229
;229:		TeamFortress_Alias( "detsentry", 188, 0 );
ADDRGP4 $170
ARGP4
CNSTI4 188
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 230
;230:		TeamFortress_Alias( "detdispenser", 187, 0 );
ADDRGP4 $171
ARGP4
CNSTI4 187
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Alias
CALLV
pop
line 231
;231:	}
LABELV $164
line 232
;232:}
LABELV $11
endproc TeamFortress_MOTD 276 16
export TeamFortress_HelpMap
proc TeamFortress_HelpMap 8 12
line 235
;233:
;234:void TeamFortress_HelpMap(  )
;235:{
line 238
;236:	gedict_t *te;
;237:
;238:	te = trap_find( world, FOFS( s.v.classname ), "info_tfdetect" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $173
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 239
;239:	if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $174
line 240
;240:	{
line 241
;241:		if ( te->non_team_broadcast )
ADDRLP4 0
INDIRP4
CNSTI4 1340
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $176
line 242
;242:		{
line 243
;243:			G_sprint( self, 2, te->non_team_broadcast );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 1340
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 244
;244:			return;
ADDRGP4 $172
JUMPV
LABELV $176
line 246
;245:		}
;246:	}
LABELV $174
line 247
;247:	G_sprint( self, 2, "There is no help for this map.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $178
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 248
;248:}
LABELV $172
endproc TeamFortress_HelpMap 8 12
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
LABELV $178
byte 1 84
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 102
byte 1 111
byte 1 114
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
byte 1 0
align 1
LABELV $173
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 116
byte 1 102
byte 1 100
byte 1 101
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $171
byte 1 100
byte 1 101
byte 1 116
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
LABELV $170
byte 1 100
byte 1 101
byte 1 116
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $169
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 0
align 1
LABELV $168
byte 1 115
byte 1 102
byte 1 101
byte 1 105
byte 1 103
byte 1 110
byte 1 0
align 1
LABELV $167
byte 1 102
byte 1 101
byte 1 105
byte 1 103
byte 1 110
byte 1 0
align 1
LABELV $166
byte 1 100
byte 1 105
byte 1 115
byte 1 103
byte 1 117
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $163
byte 1 101
byte 1 102
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $162
byte 1 101
byte 1 102
byte 1 102
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $161
byte 1 101
byte 1 102
byte 1 102
byte 1 95
byte 1 99
byte 1 111
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $160
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $159
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 95
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $158
byte 1 115
byte 1 103
byte 1 95
byte 1 117
byte 1 112
byte 1 103
byte 1 114
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $157
byte 1 115
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $156
byte 1 115
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 0
align 1
LABELV $155
byte 1 109
byte 1 111
byte 1 100
byte 1 95
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $150
byte 1 45
byte 1 100
byte 1 101
byte 1 116
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $149
byte 1 43
byte 1 100
byte 1 101
byte 1 116
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $148
byte 1 45
byte 1 100
byte 1 101
byte 1 116
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $147
byte 1 43
byte 1 100
byte 1 101
byte 1 116
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $146
byte 1 45
byte 1 100
byte 1 101
byte 1 116
byte 1 53
byte 1 0
align 1
LABELV $145
byte 1 43
byte 1 100
byte 1 101
byte 1 116
byte 1 53
byte 1 0
align 1
LABELV $142
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 55
byte 1 54
byte 1 56
byte 1 0
align 1
LABELV $141
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 54
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $140
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 52
byte 1 56
byte 1 48
byte 1 0
align 1
LABELV $139
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 52
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $138
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 51
byte 1 56
byte 1 52
byte 1 0
align 1
LABELV $137
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 51
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $136
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 51
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $135
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 50
byte 1 52
byte 1 48
byte 1 0
align 1
LABELV $134
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 50
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $133
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $132
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $129
byte 1 98
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 48
byte 1 32
byte 1 34
byte 1 105
byte 1 109
byte 1 112
byte 1 117
byte 1 108
byte 1 115
byte 1 101
byte 1 32
byte 1 49
byte 1 48
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $128
byte 1 98
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 57
byte 1 32
byte 1 34
byte 1 105
byte 1 109
byte 1 112
byte 1 117
byte 1 108
byte 1 115
byte 1 101
byte 1 32
byte 1 57
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $127
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 105
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $126
byte 1 109
byte 1 97
byte 1 112
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 0
align 1
LABELV $125
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 0
align 1
LABELV $122
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $121
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $120
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $119
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $118
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 108
byte 1 111
byte 1 99
byte 1 0
align 1
LABELV $117
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $116
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $115
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $112
byte 1 113
byte 1 117
byte 1 101
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $111
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $110
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $109
byte 1 45
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 50
byte 1 0
align 1
LABELV $108
byte 1 45
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 49
byte 1 0
align 1
LABELV $107
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 50
byte 1 0
align 1
LABELV $106
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 49
byte 1 0
align 1
LABELV $105
byte 1 116
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $104
byte 1 112
byte 1 114
byte 1 105
byte 1 109
byte 1 101
byte 1 116
byte 1 119
byte 1 111
byte 1 0
align 1
LABELV $103
byte 1 112
byte 1 114
byte 1 105
byte 1 109
byte 1 101
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $100
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 95
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $99
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 95
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $98
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 101
byte 1 95
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $97
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 101
byte 1 95
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $96
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 102
byte 1 95
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $95
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 102
byte 1 95
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $94
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $93
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $92
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 102
byte 1 0
align 1
LABELV $91
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $90
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $89
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $88
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $87
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $86
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $81
byte 1 105
byte 1 115
byte 1 95
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $80
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 51
byte 1 0
align 1
LABELV $79
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 50
byte 1 0
align 1
LABELV $78
byte 1 109
byte 1 101
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $77
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $76
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $75
byte 1 104
byte 1 111
byte 1 108
byte 1 111
byte 1 0
align 1
LABELV $74
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 0
align 1
LABELV $73
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $72
byte 1 112
byte 1 97
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $71
byte 1 104
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $70
byte 1 98
byte 1 104
byte 1 111
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $69
byte 1 98
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $68
byte 1 106
byte 1 101
byte 1 116
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $67
byte 1 97
byte 1 105
byte 1 114
byte 1 115
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $66
byte 1 100
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $65
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $64
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 112
byte 1 99
byte 1 0
align 1
LABELV $63
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
LABELV $62
byte 1 115
byte 1 112
byte 1 121
byte 1 0
align 1
LABELV $61
byte 1 112
byte 1 121
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $60
byte 1 104
byte 1 119
byte 1 103
byte 1 117
byte 1 121
byte 1 0
align 1
LABELV $59
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $58
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 109
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $57
byte 1 115
byte 1 111
byte 1 108
byte 1 100
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $56
byte 1 115
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $55
byte 1 115
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $54
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $53
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $52
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $51
byte 1 105
byte 1 110
byte 1 118
byte 1 0
align 1
LABELV $50
byte 1 98
byte 1 105
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 101
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $47
byte 1 104
byte 1 116
byte 1 116
byte 1 112
byte 1 58
byte 1 47
byte 1 47
byte 1 193
byte 1 237
byte 1 238
byte 1 229
byte 1 243
byte 1 233
byte 1 225
byte 1 199
byte 1 225
byte 1 237
byte 1 229
byte 1 243
byte 1 174
byte 1 227
byte 1 239
byte 1 237
byte 1 10
byte 1 0
align 1
LABELV $46
byte 1 66
byte 1 117
byte 1 103
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 118
byte 1 105
byte 1 114
byte 1 111
byte 1 120
byte 1 51
byte 1 56
byte 1 64
byte 1 104
byte 1 111
byte 1 116
byte 1 109
byte 1 97
byte 1 105
byte 1 108
byte 1 46
byte 1 99
byte 1 111
byte 1 109
byte 1 10
byte 1 0
align 1
LABELV $45
byte 1 77
byte 1 84
byte 1 70
byte 1 45
byte 1 67
byte 1 32
byte 1 99
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 216
byte 1 97
byte 1 118
byte 1 105
byte 1 111
byte 1 210
byte 1 10
byte 1 0
align 1
LABELV $44
byte 1 67
byte 1 32
byte 1 99
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 144
byte 1 115
byte 1 100
byte 1 145
byte 1 32
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 108
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 205
byte 1 212
byte 1 198
byte 1 204
byte 1 10
byte 1 0
align 1
LABELV $43
byte 1 66
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 69
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $39
byte 1 77
byte 1 101
byte 1 103
byte 1 97
byte 1 84
byte 1 70
byte 1 50
byte 1 48
byte 1 48
byte 1 54
byte 1 32
byte 1 49
byte 1 49
byte 1 46
byte 1 48
byte 1 50
byte 1 46
byte 1 48
byte 1 54
byte 1 97
byte 1 10
byte 1 0
align 1
LABELV $38
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $37
byte 1 10
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $34
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 47
byte 1 109
byte 1 101
byte 1 103
byte 1 97
byte 1 109
byte 1 110
byte 1 117
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $33
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 47
byte 1 109
byte 1 101
byte 1 103
byte 1 97
byte 1 109
byte 1 110
byte 1 117
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $30
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 47
byte 1 109
byte 1 101
byte 1 103
byte 1 97
byte 1 109
byte 1 110
byte 1 117
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $27
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $23
byte 1 116
byte 1 102
byte 1 95
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $14
byte 1 105
byte 1 115
byte 1 95
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 101
byte 1 100
byte 1 10
byte 1 0
