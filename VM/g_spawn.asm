export G_SpawnString
code
proc G_SpawnString 8 8
file "..\src\g_spawn.c"
line 37
;1:/*
;2: *  QWProgs-TF2003
;3: *  Copyright (C) 2004  [sd] angel
;4: *
;5: *  This code is based on Q3 VM code by Id Software, Inc.
;6: *
;7: *
;8: *  This program is free software; you can redistribute it and/or modify
;9: *  it under the terms of the GNU General Public License as published by
;10: *  the Free Software Foundation; either version 2 of the License, or
;11: *  (at your option) any later version.
;12: *
;13: *  This program is distributed in the hope that it will be useful,
;14: *  but WITHOUT ANY WARRANTY; without even the implied warranty of
;15: *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;16: *  GNU General Public License for more details.
;17: *
;18: *  You should have received a copy of the GNU General Public License
;19: *  along with this program; if not, write to the Free Software
;20: *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;21: *
;22: *
;23: *  $Id: g_spawn.c,v 1.9 2006/03/04 15:10:06 AngelD Exp $
;24: */
;25:
;26:#include "g_local.h"
;27:
;28:#define	MAX_SPAWN_VARS			64
;29:#define	MAX_SPAWN_VARS_CHARS	4096
;30:
;31:static int             numSpawnVars;
;32:static char           *spawnVars[MAX_SPAWN_VARS][2];	// key / value pairs
;33:static int             numSpawnVarChars;
;34:static char            spawnVarChars[MAX_SPAWN_VARS_CHARS];
;35:
;36:qboolean G_SpawnString( const char *key, const char *defaultString, char **out )
;37:{
line 45
;38:	int             i;
;39:
;40:/*	if ( !level.spawning ) {
;41:		*out = (char *)defaultString;
;42://		G_Error( "G_SpawnString() called while not spawning" );
;43:	}*/
;44:
;45:	for ( i = 0; i < numSpawnVars; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $15
JUMPV
LABELV $12
line 46
;46:	{
line 47
;47:		if ( !Q_stricmp( key, spawnVars[i][0] ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 spawnVars
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $16
line 48
;48:		{
line 49
;49:			*out = spawnVars[i][1];
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 spawnVars+4
ADDP4
INDIRP4
ASGNP4
line 50
;50:			return true;
CNSTI4 1
RETI4
ADDRGP4 $11
JUMPV
LABELV $16
line 52
;51:		}
;52:	}
LABELV $13
line 45
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $15
ADDRLP4 0
INDIRI4
ADDRGP4 numSpawnVars
INDIRI4
LTI4 $12
line 54
;53:
;54:	*out = ( char * ) defaultString;
ADDRFP4 8
INDIRP4
ADDRFP4 4
INDIRP4
ASGNP4
line 55
;55:	return false;
CNSTI4 0
RETI4
LABELV $11
endproc G_SpawnString 8 8
export G_SpawnFloat
proc G_SpawnFloat 16 12
line 59
;56:}
;57:
;58:qboolean G_SpawnFloat( const char *key, const char *defaultString, float *out )
;59:{
line 63
;60:	char           *s;
;61:	qboolean        present;
;62:
;63:	present = G_SpawnString( key, defaultString, &s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 64
;64:	*out = atof( s );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 65
;65:	return present;
ADDRLP4 4
INDIRI4
RETI4
LABELV $19
endproc G_SpawnFloat 16 12
export G_SpawnInt
proc G_SpawnInt 16 12
line 69
;66:}
;67:
;68:qboolean G_SpawnInt( const char *key, const char *defaultString, int *out )
;69:{
line 73
;70:	char           *s;
;71:	qboolean        present;
;72:
;73:	present = G_SpawnString( key, defaultString, &s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 74
;74:	*out = atoi( s );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 75
;75:	return present;
ADDRLP4 4
INDIRI4
RETI4
LABELV $20
endproc G_SpawnInt 16 12
export G_SpawnVector
proc G_SpawnVector 16 20
line 79
;76:}
;77:
;78:qboolean G_SpawnVector( const char *key, const char *defaultString, float *out )
;79:{
line 83
;80:	char           *s;
;81:	qboolean        present;
;82:
;83:	present = G_SpawnString( key, defaultString, &s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 84
;84:	sscanf( s, "%f %f %f", &out[0], &out[1], &out[2] );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $22
ARGP4
ADDRLP4 12
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 85
;85:	return present;
ADDRLP4 4
INDIRI4
RETI4
LABELV $21
endproc G_SpawnVector 16 20
lit
align 4
LABELV fields
address $23
byte 4 216
byte 4 2
address $24
byte 4 156
byte 4 3
address $25
byte 4 220
byte 4 2
address $26
byte 4 496
byte 4 2
address $27
byte 4 460
byte 4 2
address $28
byte 4 540
byte 4 2
address $29
byte 4 532
byte 4 2
address $30
byte 4 684
byte 4 1
address $31
byte 4 464
byte 4 2
address $32
byte 4 660
byte 4 1
address $33
byte 4 228
byte 4 1
address $34
byte 4 232
byte 4 1
address $35
byte 4 552
byte 4 1
address $36
byte 4 456
byte 4 1
address $37
byte 4 296
byte 4 1
address $38
byte 4 340
byte 4 1
address $39
byte 4 716
byte 4 1
address $40
byte 4 664
byte 4 1
address $41
byte 4 536
byte 4 0
address $42
byte 4 720
byte 4 1
address $43
byte 4 656
byte 4 1
address $44
byte 4 500
byte 4 1
address $45
byte 4 192
byte 4 3
address $46
byte 4 636
byte 4 3
address $47
byte 4 548
byte 4 0
address $48
byte 4 192
byte 4 4
address $49
byte 4 0
byte 4 5
address $50
byte 4 0
byte 4 5
address $51
byte 4 0
byte 4 5
address $52
byte 4 396
byte 4 2
address $53
byte 4 960
byte 4 0
address $54
byte 4 300
byte 4 1
address $55
byte 4 504
byte 4 2
address $56
byte 4 508
byte 4 2
address $57
byte 4 512
byte 4 2
address $58
byte 4 516
byte 4 2
address $59
byte 4 1128
byte 4 0
address $60
byte 4 1128
byte 4 0
address $61
byte 4 1132
byte 4 0
address $62
byte 4 1132
byte 4 0
address $63
byte 4 528
byte 4 2
address $29
byte 4 532
byte 4 2
address $28
byte 4 540
byte 4 2
address $64
byte 4 680
byte 4 2
address $65
byte 4 804
byte 4 2
address $66
byte 4 1284
byte 4 2
address $67
byte 4 1284
byte 4 2
address $68
byte 4 1288
byte 4 2
address $69
byte 4 1288
byte 4 2
address $70
byte 4 1292
byte 4 2
address $71
byte 4 1292
byte 4 2
address $72
byte 4 1296
byte 4 2
address $73
byte 4 1296
byte 4 2
address $74
byte 4 1300
byte 4 2
address $75
byte 4 1300
byte 4 2
address $76
byte 4 1304
byte 4 2
address $77
byte 4 1304
byte 4 2
address $78
byte 4 1332
byte 4 2
address $79
byte 4 1332
byte 4 2
address $80
byte 4 1336
byte 4 2
address $81
byte 4 1336
byte 4 2
address $82
byte 4 1340
byte 4 2
address $83
byte 4 1340
byte 4 2
address $84
byte 4 1344
byte 4 2
address $85
byte 4 1344
byte 4 2
address $86
byte 4 1348
byte 4 2
address $87
byte 4 1348
byte 4 2
address $88
byte 4 1352
byte 4 2
address $89
byte 4 1352
byte 4 2
address $90
byte 4 1356
byte 4 2
address $91
byte 4 1356
byte 4 2
address $92
byte 4 1360
byte 4 2
address $93
byte 4 1360
byte 4 2
address $94
byte 4 1364
byte 4 2
address $95
byte 4 1364
byte 4 2
address $96
byte 4 1368
byte 4 2
address $97
byte 4 1368
byte 4 2
address $98
byte 4 1372
byte 4 2
address $99
byte 4 1372
byte 4 2
address $100
byte 4 1376
byte 4 2
address $101
byte 4 1376
byte 4 2
address $102
byte 4 572
byte 4 0
address $103
byte 4 688
byte 4 0
address $104
byte 4 820
byte 4 0
address $105
byte 4 824
byte 4 0
address $106
byte 4 828
byte 4 0
address $107
byte 4 832
byte 4 0
address $108
byte 4 836
byte 4 0
address $109
byte 4 840
byte 4 0
address $110
byte 4 844
byte 4 0
address $111
byte 4 848
byte 4 0
address $112
byte 4 852
byte 4 0
address $113
byte 4 856
byte 4 0
address $114
byte 4 860
byte 4 0
address $115
byte 4 864
byte 4 0
address $116
byte 4 868
byte 4 0
address $117
byte 4 872
byte 4 0
address $118
byte 4 876
byte 4 0
address $119
byte 4 880
byte 4 0
address $120
byte 4 884
byte 4 0
address $121
byte 4 888
byte 4 0
address $122
byte 4 892
byte 4 0
address $123
byte 4 904
byte 4 0
address $124
byte 4 908
byte 4 0
address $125
byte 4 912
byte 4 0
address $126
byte 4 916
byte 4 0
address $127
byte 4 920
byte 4 0
address $128
byte 4 924
byte 4 1
address $129
byte 4 928
byte 4 0
address $130
byte 4 932
byte 4 0
address $131
byte 4 936
byte 4 0
address $132
byte 4 940
byte 4 0
address $133
byte 4 944
byte 4 0
address $134
byte 4 948
byte 4 0
address $135
byte 4 952
byte 4 0
address $136
byte 4 956
byte 4 0
address $53
byte 4 960
byte 4 0
address $137
byte 4 964
byte 4 0
address $138
byte 4 968
byte 4 0
address $139
byte 4 996
byte 4 0
address $140
byte 4 1000
byte 4 0
address $141
byte 4 1024
byte 4 0
address $142
byte 4 1028
byte 4 0
address $143
byte 4 1032
byte 4 0
address $144
byte 4 1036
byte 4 0
address $145
byte 4 1040
byte 4 0
address $146
byte 4 1044
byte 4 0
address $147
byte 4 1048
byte 4 0
address $148
byte 4 1052
byte 4 0
address $149
byte 4 1056
byte 4 0
address $150
byte 4 1060
byte 4 0
address $151
byte 4 1064
byte 4 0
address $152
byte 4 1068
byte 4 0
address $153
byte 4 1072
byte 4 0
address $154
byte 4 1088
byte 4 0
address $155
byte 4 1104
byte 4 0
address $156
byte 4 1112
byte 4 0
address $157
byte 4 1116
byte 4 0
address $158
byte 4 1120
byte 4 0
address $159
byte 4 1124
byte 4 0
address $59
byte 4 1128
byte 4 0
address $61
byte 4 1132
byte 4 0
address $160
byte 4 1136
byte 4 0
address $161
byte 4 1140
byte 4 0
address $162
byte 4 1144
byte 4 0
address $163
byte 4 1148
byte 4 0
address $164
byte 4 1152
byte 4 0
address $165
byte 4 1156
byte 4 0
address $166
byte 4 1160
byte 4 0
address $167
byte 4 1164
byte 4 0
address $168
byte 4 1168
byte 4 0
address $169
byte 4 1172
byte 4 0
address $170
byte 4 1176
byte 4 0
address $171
byte 4 1180
byte 4 0
address $172
byte 4 1180
byte 4 0
address $173
byte 4 1184
byte 4 0
address $174
byte 4 1184
byte 4 0
address $175
byte 4 1188
byte 4 0
address $176
byte 4 1192
byte 4 0
address $177
byte 4 1196
byte 4 0
address $178
byte 4 1196
byte 4 0
address $179
byte 4 1200
byte 4 0
address $180
byte 4 1200
byte 4 0
address $181
byte 4 1228
byte 4 0
address $182
byte 4 1228
byte 4 0
address $183
byte 4 1232
byte 4 0
address $184
byte 4 1232
byte 4 0
address $185
byte 4 1236
byte 4 0
address $186
byte 4 1236
byte 4 0
address $187
byte 4 1240
byte 4 0
address $188
byte 4 1244
byte 4 0
address $189
byte 4 1248
byte 4 0
address $190
byte 4 1252
byte 4 0
address $191
byte 4 1256
byte 4 0
address $192
byte 4 1260
byte 4 0
address $193
byte 4 1260
byte 4 0
address $194
byte 4 1264
byte 4 0
address $195
byte 4 1264
byte 4 0
address $196
byte 4 1268
byte 4 0
address $197
byte 4 1272
byte 4 0
address $198
byte 4 1276
byte 4 0
address $199
byte 4 1280
byte 4 0
address $200
byte 4 1308
byte 4 0
address $201
byte 4 1312
byte 4 0
address $202
byte 4 1316
byte 4 0
address $203
byte 4 1320
byte 4 0
address $204
byte 4 1324
byte 4 0
address $205
byte 4 1328
byte 4 0
address $206
byte 4 1380
byte 4 0
address $207
byte 4 1384
byte 4 0
address $208
byte 4 1388
byte 4 1
address $209
byte 4 1392
byte 4 0
address $210
byte 4 564
byte 4 1
address $211
byte 4 568
byte 4 1
address $212
byte 4 648
byte 4 1
address $213
byte 4 652
byte 4 1
address $214
byte 4 676
byte 4 1
address $215
byte 4 692
byte 4 1
address $216
byte 4 724
byte 4 1
address $217
byte 4 728
byte 4 1
address $218
byte 4 732
byte 4 1
address $219
byte 4 736
byte 4 1
address $220
byte 4 740
byte 4 1
address $221
byte 4 744
byte 4 1
address $222
byte 4 748
byte 4 1
address $223
byte 4 752
byte 4 1
address $224
byte 4 756
byte 4 1
address $225
byte 4 760
byte 4 1
address $226
byte 4 764
byte 4 1
address $227
byte 4 768
byte 4 1
address $228
byte 4 772
byte 4 1
address $229
byte 4 776
byte 4 1
address $230
byte 4 780
byte 4 1
address $231
byte 4 784
byte 4 1
address $232
byte 4 788
byte 4 1
address $233
byte 4 792
byte 4 1
address $234
byte 4 796
byte 4 1
address $235
byte 4 800
byte 4 1
address $236
byte 4 808
byte 4 1
address $237
byte 4 984
byte 4 1
address $238
byte 4 988
byte 4 1
address $239
byte 4 992
byte 4 1
address $240
byte 4 1076
byte 4 1
address $241
byte 4 1080
byte 4 1
address $242
byte 4 1084
byte 4 1
address $243
byte 4 1092
byte 4 1
address $244
byte 4 1096
byte 4 1
address $245
byte 4 1108
byte 4 1
address $246
byte 4 1416
byte 4 1
address $247
byte 4 576
byte 4 3
address $248
byte 4 588
byte 4 3
address $249
byte 4 600
byte 4 3
address $250
byte 4 612
byte 4 3
address $251
byte 4 624
byte 4 3
address $252
byte 4 700
byte 4 3
address $253
byte 4 1204
byte 4 3
address $254
byte 4 1216
byte 4 3
address $255
byte 4 1420
byte 4 3
address $256
byte 4 140
byte 4 1
address $257
byte 4 144
byte 4 1
address $258
byte 4 152
byte 4 1
address $259
byte 4 224
byte 4 1
address $260
byte 4 288
byte 4 1
address $54
byte 4 300
byte 4 1
address $261
byte 4 304
byte 4 1
address $262
byte 4 312
byte 4 1
address $263
byte 4 316
byte 4 1
address $264
byte 4 320
byte 4 1
address $265
byte 4 324
byte 4 1
address $266
byte 4 328
byte 4 1
address $267
byte 4 332
byte 4 1
address $268
byte 4 320
byte 4 1
address $269
byte 4 324
byte 4 1
address $270
byte 4 328
byte 4 1
address $271
byte 4 332
byte 4 1
address $272
byte 4 336
byte 4 1
address $273
byte 4 348
byte 4 1
address $274
byte 4 364
byte 4 1
address $275
byte 4 368
byte 4 1
address $276
byte 4 372
byte 4 1
address $277
byte 4 376
byte 4 1
address $278
byte 4 380
byte 4 1
address $279
byte 4 404
byte 4 1
address $280
byte 4 408
byte 4 1
address $281
byte 4 412
byte 4 1
address $282
byte 4 416
byte 4 1
address $283
byte 4 420
byte 4 1
address $284
byte 4 424
byte 4 1
address $285
byte 4 428
byte 4 1
address $286
byte 4 432
byte 4 1
address $287
byte 4 436
byte 4 1
address $288
byte 4 440
byte 4 1
address $289
byte 4 444
byte 4 1
address $290
byte 4 468
byte 4 1
address $291
byte 4 472
byte 4 1
address $292
byte 4 1436
byte 4 0
byte 4 0
skip 8
export SUB_Remove
code
proc SUB_Remove 0 4
line 385
;86:}
;87:
;88://
;89:// fields are needed for spawning from the entity string
;90://
;91:
;92:static const field_t         fields[] = {
;93:	{"classname",	FOFS( s.v.classname ),	F_LSTRING},
;94:	{"origin", 	FOFS( s.v.origin ),	F_VECTOR},
;95:	{"model", 	FOFS( s.v.model ),	F_LSTRING},
;96:	{"message", 	FOFS( s.v.message ),	F_LSTRING},
;97:	{"target", 	FOFS( s.v.target ),	F_LSTRING},
;98:	{"map", 	FOFS( map ),	 	F_LSTRING},
;99:	{"killtarget", 	FOFS( killtarget ),	F_LSTRING},
;100:	{"count", 	FOFS( count ),	 	F_FLOAT},
;101:	{"targetname", 	FOFS( s.v.targetname ),	F_LSTRING},
;102:	{"wait", 	FOFS( wait ),	 	F_FLOAT},
;103:	{"skin", 	FOFS( s.v.skin ),	F_FLOAT},
;104:	{"effects", 	FOFS( s.v.effects ),	F_FLOAT},
;105:	{"speed", 	FOFS( speed ),	 	F_FLOAT},
;106:	{"spawnflags", 	FOFS( s.v.spawnflags ),	F_FLOAT},
;107:	{"health", 	FOFS( s.v.health ),	F_FLOAT},
;108:	{"takedamage", 	FOFS( s.v.takedamage ),	F_FLOAT},
;109:	{"dmg", 	FOFS( dmg ),	 	F_FLOAT},
;110:	{"delay", 	FOFS( delay ),	 	F_FLOAT},
;111:	{"worldtype", 	FOFS( worldtype ),	F_INT},
;112:	{"lip", 	FOFS( lip ),		F_FLOAT},
;113:	{"height", 	FOFS( height ),		F_FLOAT},
;114:	{"sounds", 	FOFS( s.v.sounds ),	F_FLOAT},
;115:	{"angles", 	FOFS( s.v.angles ),	F_VECTOR},
;116:	{"mangle", 	FOFS( mangle ),		F_VECTOR},
;117:	{"style", 	FOFS( style ),		F_INT},
;118:	{"angle", 	FOFS( s.v.angles ),	F_ANGLEHACK},
;119:	{"light", 	0,			F_IGNORE},
;120:	{"wad", 	0, 			F_IGNORE},
;121:	{"_color", 	0, 			F_IGNORE},
;122://////Team Fortress
;123:	{"netname",		FOFS( s.v.netname ),		F_LSTRING},
;124:	{"team_no", 		FOFS( team_no ),		F_INT},
;125:	{"frags", 		FOFS( s.v.frags ),	 	F_FLOAT},
;126:	{"noise",		FOFS( s.v.noise ),		F_LSTRING},
;127:	{"noise1",		FOFS( s.v.noise1 ),		F_LSTRING},
;128:	{"noise2",		FOFS( s.v.noise2 ),		F_LSTRING},
;129:	{"noise3",		FOFS( s.v.noise3 ),		F_LSTRING},
;130:	{"goal_activation",	FOFS( goal_activation ),	F_INT},
;131:	{"g_a",			FOFS( goal_activation ),	F_INT},
;132:	{"goal_effects",	FOFS( goal_effects ),		F_INT},
;133:	{"g_e",			FOFS( goal_effects ),		F_INT},
;134://	{"items_allowed",	FOFS( items_allowed ),		F_INT},
;135:	
;136:        {"mdl",			FOFS( mdl ),			 F_LSTRING},
;137:        {"killtarget",		FOFS( killtarget ),		 F_LSTRING},
;138:        {"map",			FOFS( map ),	 F_LSTRING},
;139:        {"noise4",		FOFS( noise4 ),	 F_LSTRING},
;140:        {"deathtype",		FOFS( deathtype	 ),	 F_LSTRING},
;141:        {"team_str_home",	FOFS( team_str_home ),	 F_LSTRING},
;142:        {"t_s_h",		FOFS( team_str_home ),	 F_LSTRING},
;143:        {"team_str_moved",	FOFS( team_str_moved ),	 F_LSTRING},
;144:        {"t_s_m",		FOFS( team_str_moved ),	 F_LSTRING},
;145:        {"team_str_carried",	FOFS( team_str_carried ),	 F_LSTRING},
;146:        {"t_s_c",		FOFS( team_str_carried ),	 F_LSTRING},
;147:        {"non_team_str_home",	FOFS( non_team_str_home ),	 F_LSTRING},
;148:        {"n_s_h",		FOFS( non_team_str_home ),	 F_LSTRING},
;149:        {"non_team_str_moved",	FOFS( non_team_str_moved ),	 F_LSTRING},
;150:        {"n_s_m",		FOFS( non_team_str_moved ),	 F_LSTRING},
;151:        {"non_team_str_carried",FOFS( non_team_str_carried ),	 F_LSTRING},
;152:        {"n_s_c",		FOFS( non_team_str_carried ),	 F_LSTRING},
;153:        {"broadcast",		FOFS( broadcast ),	 F_LSTRING},
;154:        {"b_b",			FOFS( broadcast ),	 F_LSTRING},
;155:        {"team_broadcast",	FOFS( team_broadcast ),	 F_LSTRING},
;156:        {"b_t",			FOFS( team_broadcast ),	 F_LSTRING},
;157:        {"non_team_broadcast",	FOFS( non_team_broadcast ),	 F_LSTRING},
;158:        {"b_n",			FOFS( non_team_broadcast ),	 F_LSTRING},
;159:        {"owners_team_broadcast",FOFS( owners_team_broadcast ),	 F_LSTRING},
;160:        {"b_o",			FOFS( owners_team_broadcast ),	 F_LSTRING},
;161:        {"netname_broadcast",	FOFS( netname_broadcast ),	 F_LSTRING},
;162:        {"n_b",				FOFS( netname_broadcast ),	     	F_LSTRING},
;163:        {"netname_team_broadcast",	FOFS( netname_team_broadcast ),	     	F_LSTRING},
;164:        {"n_t",				FOFS( netname_team_broadcast ),	     	F_LSTRING},
;165:        {"netname_non_team_broadcast",	FOFS( netname_non_team_broadcast ),	F_LSTRING},
;166:        {"n_n",				FOFS( netname_non_team_broadcast ),	F_LSTRING},
;167:        {"netname_owners_team_broadcast",FOFS( netname_owners_team_broadcast ),	F_LSTRING},
;168:        {"n_o",				FOFS( netname_owners_team_broadcast ),	F_LSTRING},
;169:        {"team_drop",			FOFS( team_drop ),	                F_LSTRING},
;170:        {"d_t",				FOFS( team_drop ),	                F_LSTRING},
;171:        {"non_team_drop",		FOFS( non_team_drop ),	                F_LSTRING},
;172:        {"d_n",				FOFS( non_team_drop ),	                F_LSTRING},
;173:        {"netname_team_drop",		FOFS( netname_team_drop ),	        F_LSTRING},
;174:        {"d_n_t",			FOFS( netname_team_drop ),	        F_LSTRING},
;175:        {"netname_non_team_drop",	FOFS( netname_non_team_drop ),	        F_LSTRING},
;176:        {"d_n_n",			FOFS( netname_non_team_drop ),	        F_LSTRING},
;177:
;178:        {"aflag",			FOFS( aflag ),			 	F_INT},
;179:        {"last_impulse",		FOFS( last_impulse ),			F_INT},
;180:        {"playerclass",			FOFS( playerclass ),			F_INT},
;181:        {"nextpc",			FOFS( nextpc ),			 	F_INT},
;182:        {"armorclass",			FOFS( armorclass ),			F_INT},
;183:        {"tf_items",			FOFS( tf_items ),			F_INT},
;184:        {"tf_items_flags",		FOFS( tf_items_flags ),			F_INT},
;185:        {"no_grenades_1",		FOFS( no_grenades_1 ),			F_INT},
;186:        {"no_grenades_2",		FOFS( no_grenades_2 ),			F_INT},
;187:        {"tp_grenades_1",		FOFS( tp_grenades_1 ),			F_INT},
;188:        {"tp_grenades_2",		FOFS( tp_grenades_2 ),			F_INT},
;189:        {"got_aliases",			FOFS( got_aliases ),			F_INT},
;190:        {"cheat_check",			FOFS( cheat_check ),			F_INT},
;191:        {"is_removed",			FOFS( is_removed ),			F_INT},
;192:        {"is_undercover",		FOFS( is_undercover ),			F_INT},
;193:        {"is_building",			FOFS( is_building ),			F_INT},
;194:        {"is_detpacking",		FOFS( is_detpacking ),			F_INT},
;195:        {"is_feigning",			FOFS( is_feigning ),			F_INT},
;196:        {"is_unabletospy",		FOFS( is_unabletospy ),			F_INT},
;197:        {"has_disconnected",		FOFS( has_disconnected ),		F_INT},
;198:        {"tfstate",			FOFS( tfstate ),			F_INT},
;199:        {"maxammo_shells",		FOFS( maxammo_shells ),			F_INT},
;200:        {"maxammo_nails",		FOFS( maxammo_nails ),			F_INT},
;201:        {"maxammo_cells",		FOFS( maxammo_cells ),			F_INT},
;202:        {"maxammo_rockets",		FOFS( maxammo_rockets ),		F_INT},
;203:        {"items_allowed",		FOFS( items_allowed ),			F_INT},
;204:        {"armor_allowed",		FOFS( armor_allowed ),			F_FLOAT},
;205:        {"maxarmor",			FOFS( maxarmor ),			F_INT},
;206:        {"maxfbspeed",			FOFS( maxfbspeed ),			F_INT},
;207:        {"maxstrafespeed",		FOFS( maxstrafespeed ),			F_INT},
;208:        {"weaponmode",			FOFS( weaponmode ),			F_INT},
;209:        {"motd",			FOFS( motd ),			 	F_INT},
;210:        {"current_menu",		FOFS( current_menu ),			F_INT},
;211:        {"menu_count",			FOFS( menu_count ),			F_INT},
;212:        {"menu_displaytime",		FOFS( menu_displaytime ),		F_INT},
;213:        {"team_no",			FOFS( team_no ),			F_INT},
;214:        {"lives",			FOFS( lives ),			 	F_INT},
;215:        {"infection_team_no",		FOFS( infection_team_no ),		F_INT},
;216:        {"has_dispenser",		FOFS( has_dispenser ),			F_INT},
;217:        {"has_sentry",			FOFS( has_sentry ),			F_INT},
;218:        {"real_frags",			FOFS( real_frags ),			F_INT},
;219:        {"weapons_carried",		FOFS( weapons_carried ),		F_INT},
;220:        {"current_weapon",		FOFS( current_weapon ),			F_INT},
;221:        {"last_weapon",			FOFS( last_weapon ),			F_INT},
;222:        {"last_weaponmode",		FOFS( last_weaponmode ),		F_INT},
;223:        {"ammo_medikit",		FOFS( ammo_medikit ),			F_INT},
;224:        {"maxammo_medikit",		FOFS( maxammo_medikit ),		F_INT},
;225:        {"ammo_detpack",		FOFS( ammo_detpack ),			F_INT},
;226:        {"maxammo_detpack",		FOFS( maxammo_detpack ),		F_INT},
;227:        {"reload_shotgun",		FOFS( reload_shotgun ),			F_INT},
;228:        {"reload_super_shotgun",	FOFS( reload_super_shotgun ),		F_INT},
;229:        {"reload_grenade_launcher",	FOFS( reload_grenade_launcher ),	F_INT},
;230:        {"reload_rocket_launcher",	FOFS( reload_rocket_launcher ),		F_INT},
;231:        {"no_active_nail_grens",	FOFS( no_active_nail_grens ),		F_INT},
;232:        {"distance",			FOFS( distance ),			F_INT},
;233:        {"goal_no",			FOFS( goal_no ),			F_INT},
;234:        {"group_no",			FOFS( group_no ),			F_INT},
;235:        {"goal_state",			FOFS( goal_state ),			F_INT},
;236:        {"owned_by",			FOFS( owned_by ),			F_INT},
;237:        {"goal_activation",		FOFS( goal_activation ),		F_INT},
;238:        {"goal_effects",		FOFS( goal_effects ),			F_INT},
;239:        {"goal_result",			FOFS( goal_result ),			F_INT},
;240:        {"goal_group",			FOFS( goal_group ),			F_INT},
;241:        {"else_goal",			FOFS( else_goal ),			F_INT},
;242:        {"if_goal_is_active",		FOFS( if_goal_is_active ),		F_INT},
;243:        {"if_goal_is_inactive",		FOFS( if_goal_is_inactive ),		F_INT},
;244:        {"if_goal_is_removed",		FOFS( if_goal_is_removed ),		F_INT},
;245:        {"if_group_is_active",		FOFS( if_group_is_active ),		F_INT},
;246:        {"if_group_is_inactive",	FOFS( if_group_is_inactive ),		F_INT},
;247:        {"if_group_is_removed",		FOFS( if_group_is_removed ),		F_INT},
;248:        {"activate_goal_no",		FOFS( activate_goal_no ),		F_INT},
;249:        {"inactivate_goal_no",		FOFS( inactivate_goal_no ),		F_INT},
;250:        {"remove_goal_no",		FOFS( remove_goal_no ),			F_INT},
;251:        {"rv_g",			FOFS( remove_goal_no ),			F_INT},
;252:        {"restore_goal_no",		FOFS( restore_goal_no ),		F_INT},
;253:        {"rs_g",			FOFS( restore_goal_no ),		F_INT},
;254:        {"activate_group_no",		FOFS( activate_group_no ),		F_INT},
;255:        {"inactivate_group_no",		FOFS( inactivate_group_no ),		F_INT},
;256:        {"remove_group_no",		FOFS( remove_group_no ),		F_INT},
;257:        {"rv_gr",			FOFS( remove_group_no ),		F_INT},
;258:        {"restore_group_no",		FOFS( restore_group_no ),		F_INT},
;259:        {"rs_gr",			FOFS( restore_group_no ),		F_INT},
;260:        {"has_item_from_group",		FOFS( has_item_from_group ),		F_INT},
;261:        {"h_i_g",			FOFS( has_item_from_group ),		F_INT},
;262:        {"hasnt_item_from_group",	FOFS( hasnt_item_from_group ),		F_INT},
;263:        {"hn_i_g",			FOFS( hasnt_item_from_group ),		F_INT},
;264:        {"remove_item_group",		FOFS( remove_item_group ),		F_INT},
;265:        {"r_i_g",			FOFS( remove_item_group ),		F_INT},
;266:        {"return_item_no",		FOFS( return_item_no ),			F_INT},
;267:        {"if_item_has_moved",		FOFS( if_item_has_moved ),		F_INT},
;268:        {"if_item_hasnt_moved",		FOFS( if_item_hasnt_moved ),		F_INT},
;269:        {"remove_spawnpoint",		FOFS( remove_spawnpoint ),		F_INT},
;270:        {"restore_spawnpoint",		FOFS( restore_spawnpoint ),		F_INT},
;271:        {"remove_spawngroup",		FOFS( remove_spawngroup ),		F_INT},
;272:        {"rv_s_h",			FOFS( remove_spawngroup ),		F_INT},
;273:        {"restore_spawngroup",		FOFS( restore_spawngroup ),		F_INT},
;274:        {"rs_s_h",			FOFS( restore_spawngroup ),		F_INT},
;275:        {"display_item_status1",	FOFS( display_item_status1 ),		F_INT},
;276:        {"display_item_status2",	FOFS( display_item_status2 ),		F_INT},
;277:        {"display_item_status3",	FOFS( display_item_status3 ),		F_INT},
;278:        {"display_item_status4",	FOFS( display_item_status4 ),		F_INT},
;279:        {"ex_skill_min",		FOFS( ex_skill_min ),			F_INT},
;280:        {"ex_skill_max",		FOFS( ex_skill_max ),			F_INT},
;281:        {"increase_team1",		FOFS( increase_team1 ),			F_INT},
;282:        {"increase_team2",		FOFS( increase_team2 ),			F_INT},
;283:        {"increase_team3",		FOFS( increase_team3 ),			F_INT},
;284:        {"increase_team4",		FOFS( increase_team4 ),			F_INT},
;285:        {"all_active",			FOFS( all_active ),			F_INT},
;286:        {"item_list",			FOFS( item_list ),			F_INT},
;287:        {"delay_time",			FOFS( delay_time ),			F_FLOAT},
;288:        {"dont_do_triggerwork",		FOFS( dont_do_triggerwork ),		F_INT},
;289://float
;290:        {"healamount",			FOFS( healamount ),			F_FLOAT},
;291:        {"healtype",			FOFS( healtype ),			F_FLOAT},
;292:        {"t_length",			FOFS( t_length ),			F_FLOAT},
;293:        {"t_width",			FOFS( t_width ),			F_FLOAT},
;294:        {"pausetime",			FOFS( pausetime ),			F_FLOAT},
;295:        {"cnt",				FOFS( cnt ),				F_FLOAT},
;296:        {"attack_finished",		FOFS( attack_finished ),		F_FLOAT},
;297:        {"pain_finished",		FOFS( pain_finished ),			F_FLOAT},
;298:        {"invincible_finished",		FOFS( invincible_finished ),		F_FLOAT},
;299:        {"invisible_finished",		FOFS( invisible_finished ),		F_FLOAT},
;300:        {"super_damage_finished",	FOFS( super_damage_finished ),		F_FLOAT},
;301:        {"radsuit_finished",		FOFS( radsuit_finished ),		F_FLOAT},
;302:        {"invincible_time",		FOFS( invincible_time ),		F_FLOAT},
;303:        {"invincible_sound",		FOFS( invincible_sound ),		F_FLOAT},
;304:        {"invisible_time",		FOFS( invisible_time ),			F_FLOAT},
;305:        {"invisible_sound",		FOFS( invisible_sound ),		F_FLOAT},
;306:        {"super_time",			FOFS( super_time ),			F_FLOAT},
;307:        {"super_sound",			FOFS( super_sound ),			F_FLOAT},
;308:        {"rad_time",			FOFS( rad_time ),			F_FLOAT},
;309:        {"fly_sound",			FOFS( fly_sound ),			F_FLOAT},
;310:        {"axhitme",			FOFS( axhitme ),			F_FLOAT},
;311:        {"show_hostile",		FOFS( show_hostile ),			F_FLOAT},
;312:        {"jump_flag",			FOFS( jump_flag ),			F_FLOAT},
;313:        {"swim_flag",			FOFS( swim_flag ),			F_FLOAT},
;314:        {"air_finished",		FOFS( air_finished ),			F_FLOAT},
;315:        {"bubble_count",		FOFS( bubble_count ),			F_FLOAT},
;316:        {"dmgtime",			FOFS( dmgtime ),			F_FLOAT},
;317:        {"building_wait",		FOFS( building_wait ),			F_FLOAT},
;318:        {"respawn_time",		FOFS( respawn_time ),			F_FLOAT},
;319:        {"suicide_time",		FOFS( suicide_time ),			F_FLOAT},
;320:        {"heat",			FOFS( heat ),				F_FLOAT},
;321:        {"immune_to_check",		FOFS( immune_to_check ),		F_FLOAT},
;322:        {"last_saveme_sound",		FOFS( last_saveme_sound ),		F_FLOAT},
;323:        {"waitmin",			FOFS( waitmin ),			F_FLOAT},
;324:        {"waitmax",			FOFS( waitmax ),			F_FLOAT},
;325:        {"search_time",			FOFS( search_time ),			F_FLOAT},
;326:        {"camdist",			FOFS( camdist ),			F_FLOAT},
;327://vectors
;328:        {"dest",			FOFS( dest ),				F_VECTOR},
;329:        {"dest1",			FOFS( dest1 ),				F_VECTOR},
;330:        {"dest2",			FOFS( dest2 ),				F_VECTOR},
;331:        {"pos1",			FOFS( pos1 ),				F_VECTOR},
;332:        {"pos2",			FOFS( pos2 ),				F_VECTOR},
;333:        {"finaldest",			FOFS( finaldest ),			F_VECTOR},
;334:        {"goal_min",			FOFS( goal_min ),			F_VECTOR},
;335:        {"goal_max",			FOFS( goal_max ),			F_VECTOR},
;336:        {"camangle",			FOFS( camangle ),			F_VECTOR},
;337://float2
;338:        {"ltime",			FOFS( s.v.ltime ),			F_FLOAT},
;339:        {"lastruntime",			FOFS( s.v.lastruntime ),		F_FLOAT},
;340:        {"solid",			FOFS( s.v.solid ),			F_FLOAT},
;341:        {"frame",			FOFS( s.v.frame ),			F_FLOAT},
;342:        {"nextthink",			FOFS( s.v.nextthink ),			F_FLOAT},
;343:        {"frags",			FOFS( s.v.frags ),			F_FLOAT},
;344:        {"weapon",			FOFS( s.v.weapon ),			F_FLOAT},
;345:        {"weaponframe",			FOFS( s.v.weaponframe ),		F_FLOAT},
;346:        {"currentammo",			FOFS( s.v.currentammo ),		F_FLOAT},
;347:        {"ammo_shells",			FOFS( s.v.ammo_shells ),		F_FLOAT},
;348:        {"ammo_nails",			FOFS( s.v.ammo_nails ),			F_FLOAT},
;349:        {"ammo_rockets",		FOFS( s.v.ammo_rockets ),		F_FLOAT},
;350:        {"ammo_cells",			FOFS( s.v.ammo_cells ),			F_FLOAT},
;351:        {"a_s",				FOFS( s.v.ammo_shells ),		F_FLOAT},
;352:        {"a_n",				FOFS( s.v.ammo_nails ),			F_FLOAT},
;353:        {"a_r",				FOFS( s.v.ammo_rockets ),		F_FLOAT},
;354:        {"a_c",				FOFS( s.v.ammo_cells ),			F_FLOAT},
;355:
;356:        {"items",			FOFS( s.v.items ),			F_FLOAT},
;357:        {"deadflag",			FOFS( s.v.deadflag ),			F_FLOAT},
;358:        {"button0",			FOFS( s.v.button0 ),			F_FLOAT},
;359:        {"button1",			FOFS( s.v.button1 ),			F_FLOAT},
;360:        {"button2",			FOFS( s.v.button2 ),			F_FLOAT},
;361:        {"impulse",			FOFS( s.v.impulse ),			F_FLOAT},
;362:        {"fixangle",			FOFS( s.v.fixangle ),			F_FLOAT},
;363:        {"flags",			FOFS( s.v.flags ),			F_FLOAT},
;364:        {"colormap",			FOFS( s.v.colormap ),			F_FLOAT},
;365:        {"team",			FOFS( s.v.team ),			F_FLOAT},
;366:        {"max_health",			FOFS( s.v.max_health ),			F_FLOAT},
;367:        {"teleport_time",		FOFS( s.v.teleport_time ),		F_FLOAT},
;368:        {"armortype",			FOFS( s.v.armortype ),			F_FLOAT},
;369:        {"armorvalue",			FOFS( s.v.armorvalue ),			F_FLOAT},
;370:        {"waterlevel",			FOFS( s.v.waterlevel ),			F_FLOAT},
;371:        {"watertype",			FOFS( s.v.watertype ),			F_FLOAT},
;372:        {"ideal_yaw",			FOFS( s.v.ideal_yaw ),			F_FLOAT},
;373:        {"yaw_speed",			FOFS( s.v.yaw_speed ),			F_FLOAT},
;374:        {"dmg_take",			FOFS( s.v.dmg_take ),			F_FLOAT},
;375:        {"dmg_save",			FOFS( s.v.dmg_save ),			F_FLOAT},
;376:        {"hook_out",			FOFS( hook_out ),			F_INT},
;377:        {NULL}
;378:};
;379:typedef struct spawn_s{
;380:	char           *name;
;381:	void            ( *spawn ) ();
;382:} spawn_t;
;383:
;384:void SUB_Remove()
;385:{
line 386
;386:	ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 387
;387:}
LABELV $293
endproc SUB_Remove 0 4
export SUB_Null
proc SUB_Null 0 0
line 390
;388:
;389:void SUB_Null()
;390:{
line 391
;391:}
LABELV $294
endproc SUB_Null 0 0
lit
align 4
LABELV spawns
address $295
address SP_Null_tf_spawn
address $296
address SP_Null_tf_spawn
address $297
address SP_Null_tf_spawn
address $298
address SP_Null_tf_spawn
address $299
address SP_Null_tf_spawn
address $300
address SP_info_intermission
address $301
address SP_trigger_changelevel
address $302
address SUB_Null
address $49
address SP_light
address $303
address SP_light_fluoro
address $304
address SP_light_fluorospark
address $305
address SP_light_globe
address $306
address SP_light_torch_small_walltorch
address $307
address SP_light_flame_large_yellow
address $308
address SP_light_flame_small_yellow
address $309
address SP_light_flame_small_white
address $310
address SP_air_bubbles
address $311
address SP_misc_fireball
address $312
address SP_ambient_suck_wind
address $313
address SP_ambient_drone
address $314
address SP_ambient_flouro_buzz
address $315
address SP_ambient_drip
address $316
address SP_ambient_comp_hum
address $317
address SP_ambient_thunder
address $318
address SP_ambient_light_buzz
address $319
address SP_ambient_swamp1
address $320
address SP_ambient_swamp2
address $321
address SP_misc_noisemaker
address $322
address SP_misc_explobox
address $323
address SP_misc_explobox2
address $324
address SP_trap_spikeshooter
address $325
address SP_trap_shooter
address $326
address SP_func_wall
address $327
address SP_func_illusionary
address $328
address SP_func_episodegate
address $329
address SP_func_bossgate
address $330
address SP_func_door
address $331
address SP_func_door_secret
address $332
address SP_func_plat
address $333
address SP_func_train
address $334
address SP_misc_teleporttrain
address $335
address SP_func_button
address $336
address SP_trigger_multiple
address $337
address SP_trigger_once
address $338
address SP_trigger_relay
address $339
address SP_trigger_secret
address $340
address SP_trigger_counter
address $341
address SP_info_teleport_destination
address $342
address SP_trigger_teleport
address $343
address SP_trigger_setskill
address $344
address SP_trigger_onlyregistered
address $345
address SP_trigger_hurt
address $346
address SP_trigger_push
address $347
address SP_trigger_monsterjump
address $348
address SP_path_corner
address $349
address SP_item_health
address $350
address SP_item_armor1
address $351
address SP_item_armor2
address $352
address SP_item_armorInv
address $353
address SP_weapon_supershotgun
address $354
address SP_weapon_nailgun
address $355
address SP_weapon_supernailgun
address $356
address SP_weapon_grenadelauncher
address $357
address SP_weapon_rocketlauncher
address $358
address SP_weapon_lightning
address $359
address SP_item_shells
address $360
address SP_item_spikes
address $361
address SP_item_rockets
address $362
address SP_item_cells
address $363
address SP_item_weapon
address $364
address SP_item_artifact_invulnerability
address $365
address SP_item_artifact_envirosuit
address $366
address SP_item_artifact_invisibility
address $367
address SP_item_artifact_super_damage
address $368
address SP_item_sigil
address $369
address SP_item_key1
address $370
address SP_item_key2
address $371
address SUB_Remove
address $372
address SUB_Remove
address $373
address SUB_Remove
address $374
address SUB_Remove
address $375
address SUB_Remove
address $376
address SUB_Remove
address $377
address SUB_Remove
address $378
address SUB_Remove
address $379
address SUB_Remove
address $380
address SUB_Remove
address $381
address SUB_Remove
address $382
address SUB_Remove
address $383
address SUB_Remove
address $384
address SUB_Remove
address $385
address SUB_Remove
address $386
address SUB_Remove
address $387
address SUB_Remove
address $388
address SUB_Remove
address $389
address SUB_Remove
address $390
address SP_noclass
address $391
address SP_info_tfdetect
address $392
address SP_info_player_teamspawn
address $393
address SP_i_p_t
address $394
address SP_info_tfgoal
address $395
address SP_i_t_g
address $396
address SP_info_tfgoal_timer
address $397
address SP_i_t_t
address $398
address SP_item_tfgoal
address $399
address SP_info_player_team1
address $400
address SP_info_player_team2
address $401
address SP_item_flag_team2
address $402
address SP_item_flag_team1
address $403
address trigger_jumper
address $404
address func_glass
address $405
address ball
address $406
address ballstart
address $407
address sandball_goal
address $408
address ambient_sound
byte 4 0
byte 4 0
export G_CallSpawn
code
proc G_CallSpawn 8 8
line 637
;392:
;393:void            SP_light();
;394:void            SP_light_fluoro();
;395:void            SP_light_fluorospark();
;396:void            SP_light_globe();
;397:void            SP_light_torch_small_walltorch();
;398:void            SP_light_flame_large_yellow();
;399:void            SP_light_flame_small_yellow();
;400:void            SP_light_flame_small_white();
;401:
;402:void            SP_ambient_suck_wind();
;403:void            SP_ambient_drone();
;404:void            SP_ambient_flouro_buzz();
;405:void            SP_ambient_drip();
;406:void            SP_ambient_comp_hum();
;407:void            SP_ambient_thunder();
;408:void            SP_ambient_light_buzz();
;409:void            SP_ambient_swamp1();
;410:void            SP_ambient_swamp2();
;411:void            SP_misc_noisemaker();
;412:void            SP_misc_explobox();
;413:void            SP_misc_explobox2();
;414:void            SP_air_bubbles();
;415:
;416:void            SP_trap_spikeshooter();
;417:void            SP_trap_shooter();
;418:void            SP_func_wall();
;419:void            SP_func_illusionary();
;420:void            SP_func_episodegate();
;421:void            SP_func_bossgate();
;422:
;423:void            SP_func_door();
;424:void            SP_func_door_secret();
;425:void            SP_func_plat();
;426:void            SP_func_train();
;427:void            SP_misc_teleporttrain();
;428:void            SP_func_button();
;429:
;430:void            SP_trigger_multiple();
;431:void            SP_trigger_once();
;432:void            SP_trigger_relay();
;433:void            SP_trigger_secret();
;434:void            SP_trigger_counter();
;435:void            SP_info_teleport_destination();
;436:void            SP_trigger_teleport();
;437:void            SP_trigger_setskill();
;438:void            SP_trigger_onlyregistered();
;439:void            SP_trigger_hurt();
;440:void            SP_trigger_push();
;441:void            SP_trigger_monsterjump();
;442:void            SP_trigger_changelevel();
;443:void            SP_path_corner();
;444:
;445:void            SP_item_health();
;446:void            SP_item_armor1();
;447:void            SP_item_armor2();
;448:void            SP_item_armorInv();
;449:void            SP_weapon_supershotgun();
;450:void            SP_weapon_nailgun();
;451:void            SP_weapon_supernailgun();
;452:void            SP_weapon_grenadelauncher();
;453:void            SP_weapon_rocketlauncher();
;454:void            SP_weapon_lightning();
;455:void            SP_item_shells();
;456:void            SP_item_spikes();
;457:void            SP_item_rockets();
;458:void            SP_item_cells();
;459:void            SP_item_weapon();
;460:
;461:void            SP_item_artifact_invulnerability();
;462:void            SP_item_artifact_envirosuit();
;463:void            SP_item_artifact_invisibility();
;464:void            SP_item_artifact_super_damage();
;465:void            SP_item_sigil();
;466:void            SP_item_key1();
;467:void            SP_item_key2();
;468:
;469:void            SP_misc_fireball();
;470:void            SP_info_intermission();
;471:void		SP_Null_tf_spawn();
;472://TF entites
;473:void 		SP_noclass();
;474:void 		SP_info_tfdetect();
;475:
;476:void SP_info_tfdetect();
;477:void SP_info_player_teamspawn();
;478:void SP_i_p_t();
;479:void SP_info_tfgoal();
;480:void SP_i_t_g();
;481:void SP_info_tfgoal_timer();
;482:void SP_i_t_t();
;483:void SP_item_tfgoal();
;484:void SP_info_player_team1();
;485:void SP_info_player_team2();
;486:void SP_item_flag_team2();
;487:void SP_item_flag_team1();
;488:
;489:static const spawn_t         spawns[] = {
;490:	// info entities don't do anything at all, but provide positional
;491:	// information for things controlled by other processes
;492:	{"info_player_start",		SP_Null_tf_spawn},
;493:	{"info_player_start2",		SP_Null_tf_spawn},
;494:	{"info_player_deathmatch", 	SP_Null_tf_spawn},
;495:	{"info_player_coop", 		SP_Null_tf_spawn},
;496:	{"testplayerstart", 		SP_Null_tf_spawn},
;497:	{"info_intermission", 		SP_info_intermission},
;498:	{"trigger_changelevel", 	SP_trigger_changelevel},
;499:/*QUAKED info_notnull (0 0.5 0) (-4 -4 -4) (4 4 4)
;500:Used as a positional target for lightning.
;501:*/
;502:	{"info_notnull", 		SUB_Null},
;503:
;504:	{"light", 			SP_light},
;505:	{"light_fluoro", 		SP_light_fluoro},
;506:	{"light_fluorospark", 		SP_light_fluorospark},
;507:	{"light_globe", 		SP_light_globe},
;508:	{"light_torch_small_walltorch", SP_light_torch_small_walltorch},
;509:	{"light_flame_large_yellow", 	SP_light_flame_large_yellow},
;510:	{"light_flame_small_yellow", 	SP_light_flame_small_yellow},
;511:	{"light_flame_small_white", 	SP_light_flame_small_white},
;512:	{"air_bubbles", 		SP_air_bubbles},
;513:
;514:	{"misc_fireball",		SP_misc_fireball},
;515:
;516:	{"ambient_suck_wind",		SP_ambient_suck_wind},
;517:	{"ambient_drone",		SP_ambient_drone},
;518:	{"ambient_flouro_buzz",		SP_ambient_flouro_buzz},
;519:	{"ambient_drip",		SP_ambient_drip},
;520:	{"ambient_comp_hum",		SP_ambient_comp_hum},
;521:	{"ambient_thunder",		SP_ambient_thunder},
;522:	{"ambient_light_buzz",		SP_ambient_light_buzz},
;523:	{"ambient_swamp1",		SP_ambient_swamp1},
;524:	{"ambient_swamp2",		SP_ambient_swamp2},
;525:	{"misc_noisemaker",		SP_misc_noisemaker},
;526:	{"misc_explobox",		SP_misc_explobox},
;527:	{"misc_explobox2",		SP_misc_explobox2},
;528:	{"trap_spikeshooter",		SP_trap_spikeshooter},
;529:	{"trap_shooter",		SP_trap_shooter},
;530:	{"func_wall",			SP_func_wall},
;531:	{"func_illusionary",		SP_func_illusionary},
;532:	{"func_episodegate",		SP_func_episodegate},
;533:	{"func_bossgate",		SP_func_bossgate},
;534:
;535:
;536:	{"func_door",			SP_func_door},
;537:	{"func_door_secret",		SP_func_door_secret},
;538:	{"func_plat",			SP_func_plat},
;539:	{"func_train",			SP_func_train},
;540:	{"misc_teleporttrain",		SP_misc_teleporttrain},
;541:	{"func_button",			SP_func_button},
;542:
;543:	{"trigger_multiple",		SP_trigger_multiple},
;544:	{"trigger_once",		SP_trigger_once},
;545:	{"trigger_relay",		SP_trigger_relay},
;546:	{"trigger_secret",		SP_trigger_secret},
;547:	{"trigger_counter",		SP_trigger_counter},
;548:	{"info_teleport_destination",	SP_info_teleport_destination},
;549:	{"trigger_teleport",		SP_trigger_teleport},
;550:	{"trigger_setskill",		SP_trigger_setskill},
;551:	{"trigger_onlyregistered",	SP_trigger_onlyregistered},
;552:	{"trigger_hurt",		SP_trigger_hurt},
;553:	{"trigger_push",		SP_trigger_push},
;554:	{"trigger_monsterjump",		SP_trigger_monsterjump},
;555:	{"path_corner",			SP_path_corner},
;556:
;557:	{"item_health",			SP_item_health},
;558:	{"item_armor1",			SP_item_armor1},
;559:	{"item_armor2",			SP_item_armor2},
;560:	{"item_armorInv",		SP_item_armorInv},
;561:	{"weapon_supershotgun",		SP_weapon_supershotgun},
;562:	{"weapon_nailgun",		SP_weapon_nailgun},
;563:	{"weapon_supernailgun",		SP_weapon_supernailgun},
;564:	{"weapon_grenadelauncher",	SP_weapon_grenadelauncher},
;565:	{"weapon_rocketlauncher",	SP_weapon_rocketlauncher},
;566:	{"weapon_lightning",		SP_weapon_lightning},
;567:	{"item_shells",			SP_item_shells},
;568:	{"item_spikes",			SP_item_spikes},
;569:	{"item_rockets",		SP_item_rockets},
;570:	{"item_cells",			SP_item_cells},
;571:	{"item_weapon",			SP_item_weapon},
;572:	{"item_artifact_invulnerability",	SP_item_artifact_invulnerability},
;573:	{"item_artifact_envirosuit",		SP_item_artifact_envirosuit},
;574:	{"item_artifact_invisibility",		SP_item_artifact_invisibility},
;575:	{"item_artifact_super_damage",		SP_item_artifact_super_damage},
;576:	{"item_sigil",			SP_item_sigil},
;577:	{"item_key1",			SP_item_key1},
;578:	{"item_key2",			SP_item_key2},
;579:
;580://not used ents
;581:/*QUAKED info_null (0 0.5 0) (-4 -4 -4) (4 4 4)
;582:Used as a positional target for spotlights, etc.
;583:*/
;584:	{"info_null",			SUB_Remove},
;585:	{"monster_ogre",		SUB_Remove},
;586:	{"monster_demon1",		SUB_Remove},
;587:	{"monster_shambler",		SUB_Remove},
;588:	{"monster_knight",		SUB_Remove},
;589:	{"monster_army",		SUB_Remove},
;590:	{"monster_wizard",		SUB_Remove},
;591:	{"monster_dog",			SUB_Remove},
;592:	{"monster_zombie",		SUB_Remove},
;593:	{"monster_boss",		SUB_Remove},
;594:	{"monster_tarbaby",		SUB_Remove},
;595:	{"monster_hell_knight",		SUB_Remove},
;596:	{"monster_fish",		SUB_Remove},
;597:	{"monster_shalrath",		SUB_Remove},
;598:	{"monster_enforcer",		SUB_Remove},
;599:	{"monster_oldone",		SUB_Remove},
;600:	{"monster_dragon",		SUB_Remove},
;601:	{"monster_vomit",		SUB_Remove},
;602:	{"event_lightning",		SUB_Remove},
;603://TF entites
;604:	{"noclass",			SP_noclass},
;605:	{"info_tfdetect",         	SP_info_tfdetect},
;606:	{"info_player_teamspawn", 	SP_info_player_teamspawn},
;607:	{"i_p_t",         	  	SP_i_p_t},
;608:	{"info_tfgoal",         	SP_info_tfgoal},
;609:	{"i_t_g",         		SP_i_t_g},
;610:	{"info_tfgoal_timer",         	SP_info_tfgoal_timer},
;611:	{"i_t_t",	         	SP_i_t_t},
;612:	{"item_tfgoal",         	SP_item_tfgoal},
;613:	{"info_player_team1",         	SP_info_player_team1},
;614:	{"info_player_team2",         	SP_info_player_team2},
;615:	{"item_flag_team2",         	SP_item_flag_team2},
;616:	{"item_flag_team1",         	SP_item_flag_team1},
;617:// mtf entities
;618:	{"trigger_jumper",				trigger_jumper},
;619:	{"func_glass",					func_glass},
;620:	{"ball",						ball},
;621:	{"ballstart",						ballstart},
;622:	{"sandball_goal",						sandball_goal},
;623:	{"ambient_sound",			ambient_sound},
;624://	{"trigger_jumper",				trigger_jumper},
;625:	{0, 0}
;626:};
;627:
;628:/*
;629:===============
;630:G_CallSpawn
;631:
;632:Finds the spawn function for the entity and calls it,
;633:returning qfalse if not found
;634:===============
;635:*/
;636:qboolean G_CallSpawn( gedict_t * ent )
;637:{
line 642
;638:	const spawn_t        *s;
;639:
;640://      gitem_t *item;
;641:
;642:	if ( !ent->s.v.classname )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $410
line 643
;643:	{
line 644
;644:		G_dprintf( "G_CallSpawn: NULL classname\n" );
ADDRGP4 $412
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 645
;645:		return false;
CNSTI4 0
RETI4
ADDRGP4 $409
JUMPV
LABELV $410
line 657
;646:	}
;647:
;648:/*	// check item spawn functions
;649:	for ( item=bg_itemlist+1 ; item->classname ; item++ ) {
;650:		if ( !strcmp(item->classname, ent->classname) ) {
;651:			G_SpawnItem( ent, item );
;652:			return qtrue;
;653:		}
;654:	}*/
;655:
;656:	// check normal spawn functions
;657:	for ( s = spawns; s->name; s++ )
ADDRLP4 0
ADDRGP4 spawns
ASGNP4
ADDRGP4 $416
JUMPV
LABELV $413
line 658
;658:	{
line 659
;659:		if ( !strcmp( s->name, ent->s.v.classname ) )
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $417
line 660
;660:		{
line 662
;661:			// found it
;662:			self = ent;
ADDRGP4 self
ADDRFP4 0
INDIRP4
ASGNP4
line 664
;663:			//G_Printf("%8i %s\n",ent->s.v.classname,ent->s.v.classname);
;664:			s->spawn();
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 665
;665:			return true;
CNSTI4 1
RETI4
ADDRGP4 $409
JUMPV
LABELV $417
line 667
;666:		}
;667:	}
LABELV $414
line 657
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
LABELV $416
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $413
line 668
;668:	G_dprintf( "%s doesn't have a spawn function\n", ent->s.v.classname );
ADDRGP4 $419
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 669
;669:	return false;
CNSTI4 0
RETI4
LABELV $409
endproc G_CallSpawn 8 8
export G_NewString
proc G_NewString 32 4
line 681
;670:}
;671:
;672:/*
;673:=============
;674:G_NewString
;675:
;676:Builds a copy of the string, translating \n to real linefeeds
;677:so message texts can be multi-line
;678:=============
;679:*/
;680:char           *G_NewString( const char *string )
;681:{
line 685
;682:	char           *newb, *new_p;
;683:	int             i, l;
;684:
;685:	l = strlen( string ) + 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 687
;686:
;687:	newb = G_Alloc( l );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 G_Alloc
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 690
;688:	//newb = malloc( l );
;689:
;690:	new_p = newb;
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 693
;691:
;692:	// turn \n into a real linefeed
;693:	for ( i = 0; i < l; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $424
JUMPV
LABELV $421
line 694
;694:	{
line 695
;695:		if ( string[i] == '\\' && i < l - 1 )
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $425
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $425
line 696
;696:		{
line 697
;697:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 698
;698:			if ( string[i] == 'n' )
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 110
NEI4 $427
line 699
;699:			{
line 700
;700:				*new_p++ = '\n';
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI1 10
ASGNI1
line 701
;701:			} else
ADDRGP4 $426
JUMPV
LABELV $427
line 702
;702:			{
line 703
;703:				*new_p++ = '\\';
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI1 92
ASGNI1
line 704
;704:			}
line 705
;705:		} else
ADDRGP4 $426
JUMPV
LABELV $425
line 706
;706:		{
line 707
;707:			*new_p++ = string[i];
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 708
;708:		}
LABELV $426
line 709
;709:	}
LABELV $422
line 693
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $424
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $421
line 711
;710:
;711:	return newb;
ADDRLP4 12
INDIRP4
RETP4
LABELV $420
endproc G_NewString 32 4
export G_ParseField
proc G_ParseField 60 20
line 723
;712:}
;713:
;714:/*
;715:===============
;716:G_ParseField
;717:
;718:Takes a key/value pair and sets the binary values
;719:in a gentity
;720:===============
;721:*/
;722:void G_ParseField( const char *key, const char *value, gedict_t * ent )
;723:{
line 729
;724:	const field_t        *f;
;725:	byte           *b;
;726:	float           v;
;727:	vec3_t          vec;
;728:
;729:	for ( f = fields; f->name; f++ )
ADDRLP4 0
ADDRGP4 fields
ASGNP4
ADDRGP4 $433
JUMPV
LABELV $430
line 730
;730:	{
line 731
;731:		if ( !Q_stricmp( f->name, key ) )
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $434
line 732
;732:		{
line 734
;733:			// found it
;734:			b = ( byte * ) ent;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
line 736
;735:
;736:			switch ( f->type )
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $429
ADDRLP4 28
INDIRI4
CNSTI4 5
GTI4 $429
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $449
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $449
address $445
address $446
address $439
address $440
address $447
address $429
code
line 737
;737:			{
LABELV $439
line 739
;738:			case F_LSTRING:
;739:				*( char ** ) ( b + f->ofs ) = G_NewString( value );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 G_NewString
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 36
INDIRP4
ASGNP4
line 740
;740:				break;
ADDRGP4 $429
JUMPV
LABELV $440
line 742
;741:			case F_VECTOR:
;742:				sscanf( value, "%f %f %f", &vec[0], &vec[1], &vec[2] );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $22
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 8+4
ARGP4
ADDRLP4 8+8
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 743
;743:				( ( float * ) ( b + f->ofs ) )[0] = vec[0];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 744
;744:				( ( float * ) ( b + f->ofs ) )[1] = vec[1];
ADDRLP4 40
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRLP4 8+4
INDIRF4
ASGNF4
line 745
;745:				( ( float * ) ( b + f->ofs ) )[2] = vec[2];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 8+8
INDIRF4
ASGNF4
line 746
;746:				break;
ADDRGP4 $429
JUMPV
LABELV $445
line 748
;747:			case F_INT:
;748:				*( int * ) ( b + f->ofs ) = atoi( value );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 749
;749:				break;
ADDRGP4 $429
JUMPV
LABELV $446
line 751
;750:			case F_FLOAT:
;751:				*( float * ) ( b + f->ofs ) = atof( value );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 48
INDIRF4
ASGNF4
line 752
;752:				break;
ADDRGP4 $429
JUMPV
LABELV $447
line 754
;753:			case F_ANGLEHACK:
;754:				v = atof( value );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 52
INDIRF4
ASGNF4
line 755
;755:				( ( float * ) ( b + f->ofs ) )[0] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTF4 0
ASGNF4
line 756
;756:				( ( float * ) ( b + f->ofs ) )[1] = v;
ADDRLP4 56
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
line 757
;757:				( ( float * ) ( b + f->ofs ) )[2] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 758
;758:				break;
line 761
;759:			default:
;760:			case F_IGNORE:
;761:				break;
line 763
;762:			}
;763:			return;
ADDRGP4 $429
JUMPV
LABELV $434
line 765
;764:		}
;765:	}
LABELV $431
line 729
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
LABELV $433
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $430
line 766
;766:	G_dprintf( "unknown field: %s\n", key );
ADDRGP4 $450
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 767
;767:}
LABELV $429
endproc G_ParseField 60 20
export G_SpawnGEntityFromSpawnVars
proc G_SpawnGEntityFromSpawnVars 16 12
line 778
;768:
;769:/*
;770:===================
;771:G_SpawnGEntityFromSpawnVars
;772:
;773:Spawn an entity and fill in all of the level fields from
;774:level.spawnVars[], then call the class specfic spawn function
;775:===================
;776:*/
;777:void G_SpawnGEntityFromSpawnVars( void )
;778:{
line 783
;779:	int             i;
;780:	gedict_t       *ent;
;781:
;782:	// get the next free entity
;783:	ent = spawn();
ADDRLP4 8
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 785
;784:
;785:	for ( i = 0; i < numSpawnVars; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $455
JUMPV
LABELV $452
line 786
;786:	{
line 787
;787:		G_ParseField( spawnVars[i][0], spawnVars[i][1], ent );
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 spawnVars
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ADDRGP4 spawnVars+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_ParseField
CALLV
pop
line 788
;788:	}
LABELV $453
line 785
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $455
ADDRLP4 0
INDIRI4
ADDRGP4 numSpawnVars
INDIRI4
LTI4 $452
line 790
;789:
;790:	if ( ( ( int ) ent->s.v.spawnflags & SPAWNFLAG_NOT_DEATHMATCH ) )
ADDRLP4 4
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $457
line 791
;791:	{
line 792
;792:		ent_remove( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 793
;793:		return;
ADDRGP4 $451
JUMPV
LABELV $457
line 797
;794:	}
;795:
;796:	// if we didn't get a classname, don't bother spawning anything
;797:	if ( !G_CallSpawn( ent ) )
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 G_CallSpawn
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $459
line 798
;798:	{
line 799
;799:		ent_remove( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 800
;800:		return;
LABELV $459
line 803
;801:	}
;802://      if(!ent->s.v.classname)ent->s.v.classname="";
;803:}
LABELV $451
endproc G_SpawnGEntityFromSpawnVars 16 12
export G_AddSpawnVarToken
proc G_AddSpawnVarToken 16 12
line 812
;804:
;805:
;806:/*
;807:====================
;808:G_AddSpawnVarToken
;809:====================
;810:*/
;811:char           *G_AddSpawnVarToken( const char *string )
;812:{
line 816
;813:	int             l;
;814:	char           *dest;
;815:
;816:	l = strlen( string );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 817
;817:	if ( numSpawnVarChars + l + 1 > MAX_SPAWN_VARS_CHARS )
ADDRGP4 numSpawnVarChars
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 1
ADDI4
CNSTI4 4096
LEI4 $462
line 818
;818:	{
line 819
;819:		G_Error( "G_AddSpawnVarToken: MAX_SPAWN_CHARS" );
ADDRGP4 $464
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 820
;820:	}
LABELV $462
line 822
;821:
;822:	dest = spawnVarChars + numSpawnVarChars;
ADDRLP4 4
ADDRGP4 numSpawnVarChars
INDIRI4
ADDRGP4 spawnVarChars
ADDP4
ASGNP4
line 823
;823:	memcpy( dest, string, l + 1 );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 825
;824:
;825:	numSpawnVarChars += l + 1;
ADDRLP4 12
ADDRGP4 numSpawnVarChars
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ADDI4
ASGNI4
line 827
;826:
;827:	return dest;
ADDRLP4 4
INDIRP4
RETP4
LABELV $461
endproc G_AddSpawnVarToken 16 12
export G_ParseSpawnVars
proc G_ParseSpawnVars 2072 8
line 841
;828:}
;829:
;830:/*
;831:====================
;832:G_ParseSpawnVars
;833:
;834:Parses a brace bounded set of key / value pairs out of the
;835:level's entity strings into level.spawnVars[]
;836:
;837:This does not actually spawn an entity.
;838:====================
;839:*/
;840:qboolean G_ParseSpawnVars( void )
;841:{
line 845
;842:	char            keyname[MAX_TOKEN_CHARS];
;843:	char            com_token[MAX_TOKEN_CHARS];
;844:
;845:	numSpawnVars = 0;
ADDRGP4 numSpawnVars
CNSTI4 0
ASGNI4
line 846
;846:	numSpawnVarChars = 0;
ADDRGP4 numSpawnVarChars
CNSTI4 0
ASGNI4
line 849
;847:
;848:	// parse the opening brace
;849:	if ( !trap_GetEntityToken( com_token, sizeof( com_token ) ) )
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2048
ADDRGP4 trap_GetEntityToken
CALLI4
ASGNI4
ADDRLP4 2048
INDIRI4
CNSTI4 0
NEI4 $466
line 850
;850:	{
line 852
;851:		// end of spawn string
;852:		return false;
CNSTI4 0
RETI4
ADDRGP4 $465
JUMPV
LABELV $466
line 854
;853:	}
;854:	if ( com_token[0] != '{' )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $472
line 855
;855:	{
line 856
;856:		G_Error( "G_ParseSpawnVars: found %s when expecting {", com_token );
ADDRGP4 $470
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 857
;857:	}
ADDRGP4 $472
JUMPV
LABELV $471
line 860
;858:	// go through all the key / value pairs
;859:	while ( 1 )
;860:	{
line 862
;861:		// parse key
;862:		if ( !trap_GetEntityToken( keyname, sizeof( keyname ) ) )
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2052
ADDRGP4 trap_GetEntityToken
CALLI4
ASGNI4
ADDRLP4 2052
INDIRI4
CNSTI4 0
NEI4 $474
line 863
;863:		{
line 864
;864:			G_Error( "G_ParseSpawnVars: EOF without closing brace" );
ADDRGP4 $476
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 865
;865:		}
LABELV $474
line 867
;866:
;867:		if ( keyname[0] == '}' )
ADDRLP4 1024
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $477
line 868
;868:		{
line 869
;869:			break;
ADDRGP4 $473
JUMPV
LABELV $477
line 872
;870:		}
;871:		// parse value  
;872:		if ( !trap_GetEntityToken( com_token, sizeof( com_token ) ) )
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2056
ADDRGP4 trap_GetEntityToken
CALLI4
ASGNI4
ADDRLP4 2056
INDIRI4
CNSTI4 0
NEI4 $479
line 873
;873:		{
line 874
;874:			G_Error( "G_ParseSpawnVars: EOF without closing brace" );
ADDRGP4 $476
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 875
;875:		}
LABELV $479
line 877
;876://              G_Printf("%s\t%s\n",keyname,com_token);
;877:		if ( com_token[0] == '}' )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $481
line 878
;878:		{
line 879
;879:			G_Error( "G_ParseSpawnVars: closing brace without data" );
ADDRGP4 $483
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 880
;880:		}
LABELV $481
line 881
;881:		if ( numSpawnVars == MAX_SPAWN_VARS )
ADDRGP4 numSpawnVars
INDIRI4
CNSTI4 64
NEI4 $484
line 882
;882:		{
line 883
;883:			G_Error( "G_ParseSpawnVars: MAX_SPAWN_VARS" );
ADDRGP4 $486
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 884
;884:		}
LABELV $484
line 885
;885:		spawnVars[numSpawnVars][0] = G_AddSpawnVarToken( keyname );
ADDRLP4 1024
ARGP4
ADDRLP4 2060
ADDRGP4 G_AddSpawnVarToken
CALLP4
ASGNP4
ADDRGP4 numSpawnVars
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 spawnVars
ADDP4
ADDRLP4 2060
INDIRP4
ASGNP4
line 886
;886:		spawnVars[numSpawnVars][1] = G_AddSpawnVarToken( com_token );
ADDRLP4 0
ARGP4
ADDRLP4 2064
ADDRGP4 G_AddSpawnVarToken
CALLP4
ASGNP4
ADDRGP4 numSpawnVars
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 spawnVars+4
ADDP4
ADDRLP4 2064
INDIRP4
ASGNP4
line 887
;887:		numSpawnVars++;
ADDRLP4 2068
ADDRGP4 numSpawnVars
ASGNP4
ADDRLP4 2068
INDIRP4
ADDRLP4 2068
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 888
;888:	}
LABELV $472
line 859
ADDRGP4 $471
JUMPV
LABELV $473
line 890
;889:
;890:	return true;
CNSTI4 1
RETI4
LABELV $465
endproc G_ParseSpawnVars 2072 8
export G_SpawnEntitiesFromString
proc G_SpawnEntitiesFromString 12 12
line 904
;891:}
;892:
;893:void            SP_worldspawn();
;894:
;895:/*
;896:==============
;897:G_SpawnEntitiesFromString
;898:
;899:Parses textual entity definitions out of an entstring and spawns gentities.
;900:==============
;901:*/
;902:
;903:void G_SpawnEntitiesFromString( void )
;904:{
line 910
;905:	int             i;
;906:
;907:	// the worldspawn is not an actual entity, but it still
;908:	// has a "spawn" function to perform any global setup
;909:	// needed by a level (setting configstrings or cvars, etc)
;910:	if ( !G_ParseSpawnVars() )
ADDRLP4 4
ADDRGP4 G_ParseSpawnVars
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $489
line 911
;911:	{
line 912
;912:		G_Error( "SpawnEntities: no entities" );
ADDRGP4 $491
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 913
;913:	}
LABELV $489
line 914
;914:	self = world;
ADDRGP4 self
ADDRGP4 world
INDIRP4
ASGNP4
line 915
;915:	for ( i = 0; i < numSpawnVars; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $495
JUMPV
LABELV $492
line 916
;916:	{
line 917
;917:		G_ParseField( spawnVars[i][0], spawnVars[i][1], world );
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 spawnVars
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ADDRGP4 spawnVars+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 G_ParseField
CALLV
pop
line 918
;918:	}
LABELV $493
line 915
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $495
ADDRLP4 0
INDIRI4
ADDRGP4 numSpawnVars
INDIRI4
LTI4 $492
line 920
;919:
;920:	SP_worldspawn( world );
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 SP_worldspawn
CALLV
pop
ADDRGP4 $498
JUMPV
LABELV $497
line 925
;921:
;922:	// parse ents
;923:
;924:	while ( G_ParseSpawnVars() )
;925:	{
line 926
;926:		G_SpawnGEntityFromSpawnVars();
ADDRGP4 G_SpawnGEntityFromSpawnVars
CALLV
pop
line 927
;927:		trap_FlushSignon();
ADDRGP4 trap_FlushSignon
CALLV
pop
line 928
;928:	}
LABELV $498
line 924
ADDRLP4 8
ADDRGP4 G_ParseSpawnVars
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $497
line 929
;929:}
LABELV $488
endproc G_SpawnEntitiesFromString 12 12
import SP_worldspawn
import SP_item_flag_team1
import SP_item_flag_team2
import SP_info_player_team2
import SP_info_player_team1
import SP_item_tfgoal
import SP_i_t_t
import SP_info_tfgoal_timer
import SP_i_t_g
import SP_info_tfgoal
import SP_i_p_t
import SP_info_player_teamspawn
import SP_info_tfdetect
import SP_noclass
import SP_Null_tf_spawn
import SP_info_intermission
import SP_misc_fireball
import SP_item_key2
import SP_item_key1
import SP_item_sigil
import SP_item_artifact_super_damage
import SP_item_artifact_invisibility
import SP_item_artifact_envirosuit
import SP_item_artifact_invulnerability
import SP_item_weapon
import SP_item_cells
import SP_item_rockets
import SP_item_spikes
import SP_item_shells
import SP_weapon_lightning
import SP_weapon_rocketlauncher
import SP_weapon_grenadelauncher
import SP_weapon_supernailgun
import SP_weapon_nailgun
import SP_weapon_supershotgun
import SP_item_armorInv
import SP_item_armor2
import SP_item_armor1
import SP_item_health
import SP_path_corner
import SP_trigger_changelevel
import SP_trigger_monsterjump
import SP_trigger_push
import SP_trigger_hurt
import SP_trigger_onlyregistered
import SP_trigger_setskill
import SP_trigger_teleport
import SP_info_teleport_destination
import SP_trigger_counter
import SP_trigger_secret
import SP_trigger_relay
import SP_trigger_once
import SP_trigger_multiple
import SP_func_button
import SP_misc_teleporttrain
import SP_func_train
import SP_func_plat
import SP_func_door_secret
import SP_func_door
import SP_func_bossgate
import SP_func_episodegate
import SP_func_illusionary
import SP_func_wall
import SP_trap_shooter
import SP_trap_spikeshooter
import SP_air_bubbles
import SP_misc_explobox2
import SP_misc_explobox
import SP_misc_noisemaker
import SP_ambient_swamp2
import SP_ambient_swamp1
import SP_ambient_light_buzz
import SP_ambient_thunder
import SP_ambient_comp_hum
import SP_ambient_drip
import SP_ambient_flouro_buzz
import SP_ambient_drone
import SP_ambient_suck_wind
import SP_light_flame_small_white
import SP_light_flame_small_yellow
import SP_light_flame_large_yellow
import SP_light_torch_small_walltorch
import SP_light_globe
import SP_light_fluorospark
import SP_light_fluoro
import SP_light
bss
align 1
LABELV spawnVarChars
skip 4096
align 4
LABELV numSpawnVarChars
skip 4
align 4
LABELV spawnVars
skip 512
align 4
LABELV numSpawnVars
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
LABELV $491
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $486
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 83
byte 1 80
byte 1 65
byte 1 87
byte 1 78
byte 1 95
byte 1 86
byte 1 65
byte 1 82
byte 1 83
byte 1 0
align 1
LABELV $483
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 100
byte 1 97
byte 1 116
byte 1 97
byte 1 0
align 1
LABELV $476
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 69
byte 1 79
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $470
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 123
byte 1 0
align 1
LABELV $464
byte 1 71
byte 1 95
byte 1 65
byte 1 100
byte 1 100
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 84
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 58
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 83
byte 1 80
byte 1 65
byte 1 87
byte 1 78
byte 1 95
byte 1 67
byte 1 72
byte 1 65
byte 1 82
byte 1 83
byte 1 0
align 1
LABELV $450
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $419
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $412
byte 1 71
byte 1 95
byte 1 67
byte 1 97
byte 1 108
byte 1 108
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $408
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $407
byte 1 115
byte 1 97
byte 1 110
byte 1 100
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 95
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $406
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $405
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $404
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 103
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $403
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $402
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 49
byte 1 0
align 1
LABELV $401
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 50
byte 1 0
align 1
LABELV $400
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 50
byte 1 0
align 1
LABELV $399
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 49
byte 1 0
align 1
LABELV $398
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 116
byte 1 102
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $397
byte 1 105
byte 1 95
byte 1 116
byte 1 95
byte 1 116
byte 1 0
align 1
LABELV $396
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
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $395
byte 1 105
byte 1 95
byte 1 116
byte 1 95
byte 1 103
byte 1 0
align 1
LABELV $394
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
LABELV $393
byte 1 105
byte 1 95
byte 1 112
byte 1 95
byte 1 116
byte 1 0
align 1
LABELV $392
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $391
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
LABELV $390
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $389
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $388
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 118
byte 1 111
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $387
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 103
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $386
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $385
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $384
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 108
byte 1 114
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $383
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 102
byte 1 105
byte 1 115
byte 1 104
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
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 107
byte 1 110
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $381
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 98
byte 1 97
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $380
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 98
byte 1 111
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $379
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 122
byte 1 111
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 0
align 1
LABELV $378
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
LABELV $377
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 119
byte 1 105
byte 1 122
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $376
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 121
byte 1 0
align 1
LABELV $375
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 107
byte 1 110
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $374
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 109
byte 1 98
byte 1 108
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $373
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 110
byte 1 49
byte 1 0
align 1
LABELV $372
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $371
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $370
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 50
byte 1 0
align 1
LABELV $369
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 49
byte 1 0
align 1
LABELV $368
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 115
byte 1 105
byte 1 103
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $367
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $366
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $365
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 101
byte 1 110
byte 1 118
byte 1 105
byte 1 114
byte 1 111
byte 1 115
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $364
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 118
byte 1 117
byte 1 108
byte 1 110
byte 1 101
byte 1 114
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $363
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $362
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $361
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $360
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $359
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $358
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $357
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $356
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $355
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $354
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $353
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $352
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 73
byte 1 110
byte 1 118
byte 1 0
align 1
LABELV $351
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $350
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $349
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $348
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 99
byte 1 111
byte 1 114
byte 1 110
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $347
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $346
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 112
byte 1 117
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $345
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 104
byte 1 117
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $344
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 111
byte 1 110
byte 1 108
byte 1 121
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $343
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $342
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $341
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $340
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 99
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $339
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 115
byte 1 101
byte 1 99
byte 1 114
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $338
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $337
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 111
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $336
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $335
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $334
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $333
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $332
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $331
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 95
byte 1 115
byte 1 101
byte 1 99
byte 1 114
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $330
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $329
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 111
byte 1 115
byte 1 115
byte 1 103
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $328
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 101
byte 1 112
byte 1 105
byte 1 115
byte 1 111
byte 1 100
byte 1 101
byte 1 103
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $327
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 105
byte 1 108
byte 1 108
byte 1 117
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 97
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $326
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 119
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $325
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
LABELV $324
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
LABELV $323
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 98
byte 1 111
byte 1 120
byte 1 50
byte 1 0
align 1
LABELV $322
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 98
byte 1 111
byte 1 120
byte 1 0
align 1
LABELV $321
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 109
byte 1 97
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $320
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 115
byte 1 119
byte 1 97
byte 1 109
byte 1 112
byte 1 50
byte 1 0
align 1
LABELV $319
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 115
byte 1 119
byte 1 97
byte 1 109
byte 1 112
byte 1 49
byte 1 0
align 1
LABELV $318
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 98
byte 1 117
byte 1 122
byte 1 122
byte 1 0
align 1
LABELV $317
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 116
byte 1 104
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $316
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 95
byte 1 104
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $315
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 100
byte 1 114
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $314
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 102
byte 1 108
byte 1 111
byte 1 117
byte 1 114
byte 1 111
byte 1 95
byte 1 98
byte 1 117
byte 1 122
byte 1 122
byte 1 0
align 1
LABELV $313
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 100
byte 1 114
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $312
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 115
byte 1 117
byte 1 99
byte 1 107
byte 1 95
byte 1 119
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $311
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
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
LABELV $310
byte 1 97
byte 1 105
byte 1 114
byte 1 95
byte 1 98
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $309
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 95
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $308
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $307
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 108
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $306
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 116
byte 1 111
byte 1 114
byte 1 99
byte 1 104
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 95
byte 1 119
byte 1 97
byte 1 108
byte 1 108
byte 1 116
byte 1 111
byte 1 114
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $305
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 103
byte 1 108
byte 1 111
byte 1 98
byte 1 101
byte 1 0
align 1
LABELV $304
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 102
byte 1 108
byte 1 117
byte 1 111
byte 1 114
byte 1 111
byte 1 115
byte 1 112
byte 1 97
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $303
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 102
byte 1 108
byte 1 117
byte 1 111
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $302
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 110
byte 1 111
byte 1 116
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $301
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
LABELV $300
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $299
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $298
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 99
byte 1 111
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $297
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $296
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 50
byte 1 0
align 1
LABELV $295
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $292
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 95
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $291
byte 1 100
byte 1 109
byte 1 103
byte 1 95
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $290
byte 1 100
byte 1 109
byte 1 103
byte 1 95
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $289
byte 1 121
byte 1 97
byte 1 119
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $288
byte 1 105
byte 1 100
byte 1 101
byte 1 97
byte 1 108
byte 1 95
byte 1 121
byte 1 97
byte 1 119
byte 1 0
align 1
LABELV $287
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $286
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $285
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $284
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $283
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $282
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $281
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $280
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $279
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $278
byte 1 102
byte 1 105
byte 1 120
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $277
byte 1 105
byte 1 109
byte 1 112
byte 1 117
byte 1 108
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $276
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 50
byte 1 0
align 1
LABELV $275
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 49
byte 1 0
align 1
LABELV $274
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 48
byte 1 0
align 1
LABELV $273
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $272
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $271
byte 1 97
byte 1 95
byte 1 99
byte 1 0
align 1
LABELV $270
byte 1 97
byte 1 95
byte 1 114
byte 1 0
align 1
LABELV $269
byte 1 97
byte 1 95
byte 1 110
byte 1 0
align 1
LABELV $268
byte 1 97
byte 1 95
byte 1 115
byte 1 0
align 1
LABELV $267
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $266
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $265
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $264
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $263
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $262
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $261
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $260
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 107
byte 1 0
align 1
LABELV $259
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $258
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $257
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 114
byte 1 117
byte 1 110
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $256
byte 1 108
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $255
byte 1 99
byte 1 97
byte 1 109
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $254
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 0
align 1
LABELV $253
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $252
byte 1 102
byte 1 105
byte 1 110
byte 1 97
byte 1 108
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $251
byte 1 112
byte 1 111
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $250
byte 1 112
byte 1 111
byte 1 115
byte 1 49
byte 1 0
align 1
LABELV $249
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 50
byte 1 0
align 1
LABELV $248
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 49
byte 1 0
align 1
LABELV $247
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $246
byte 1 99
byte 1 97
byte 1 109
byte 1 100
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $245
byte 1 115
byte 1 101
byte 1 97
byte 1 114
byte 1 99
byte 1 104
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $244
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 109
byte 1 97
byte 1 120
byte 1 0
align 1
LABELV $243
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 109
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $242
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 95
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 109
byte 1 101
byte 1 95
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $241
byte 1 105
byte 1 109
byte 1 109
byte 1 117
byte 1 110
byte 1 101
byte 1 95
byte 1 116
byte 1 111
byte 1 95
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $240
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $239
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $238
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $237
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $236
byte 1 100
byte 1 109
byte 1 103
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $235
byte 1 98
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 99
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $234
byte 1 97
byte 1 105
byte 1 114
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $233
byte 1 115
byte 1 119
byte 1 105
byte 1 109
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $232
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $231
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 95
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $230
byte 1 97
byte 1 120
byte 1 104
byte 1 105
byte 1 116
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $229
byte 1 102
byte 1 108
byte 1 121
byte 1 95
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $228
byte 1 114
byte 1 97
byte 1 100
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $227
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 95
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $226
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $225
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $224
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $223
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 110
byte 1 99
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $222
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 110
byte 1 99
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $221
byte 1 114
byte 1 97
byte 1 100
byte 1 115
byte 1 117
byte 1 105
byte 1 116
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $220
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $219
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $218
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 110
byte 1 99
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $217
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $216
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $215
byte 1 99
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $214
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $213
byte 1 116
byte 1 95
byte 1 119
byte 1 105
byte 1 100
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $212
byte 1 116
byte 1 95
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $211
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $210
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 97
byte 1 109
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $209
byte 1 100
byte 1 111
byte 1 110
byte 1 116
byte 1 95
byte 1 100
byte 1 111
byte 1 95
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 119
byte 1 111
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $208
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $207
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $206
byte 1 97
byte 1 108
byte 1 108
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $205
byte 1 105
byte 1 110
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 52
byte 1 0
align 1
LABELV $204
byte 1 105
byte 1 110
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 51
byte 1 0
align 1
LABELV $203
byte 1 105
byte 1 110
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 50
byte 1 0
align 1
LABELV $202
byte 1 105
byte 1 110
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 49
byte 1 0
align 1
LABELV $201
byte 1 101
byte 1 120
byte 1 95
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 0
align 1
LABELV $200
byte 1 101
byte 1 120
byte 1 95
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $199
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 52
byte 1 0
align 1
LABELV $198
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 51
byte 1 0
align 1
LABELV $197
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $196
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 49
byte 1 0
align 1
LABELV $195
byte 1 114
byte 1 115
byte 1 95
byte 1 115
byte 1 95
byte 1 104
byte 1 0
align 1
LABELV $194
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 95
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $193
byte 1 114
byte 1 118
byte 1 95
byte 1 115
byte 1 95
byte 1 104
byte 1 0
align 1
LABELV $192
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $191
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 95
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $190
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $189
byte 1 105
byte 1 102
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 104
byte 1 97
byte 1 115
byte 1 110
byte 1 116
byte 1 95
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $188
byte 1 105
byte 1 102
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 104
byte 1 97
byte 1 115
byte 1 95
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $187
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $186
byte 1 114
byte 1 95
byte 1 105
byte 1 95
byte 1 103
byte 1 0
align 1
LABELV $185
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $184
byte 1 104
byte 1 110
byte 1 95
byte 1 105
byte 1 95
byte 1 103
byte 1 0
align 1
LABELV $183
byte 1 104
byte 1 97
byte 1 115
byte 1 110
byte 1 116
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $182
byte 1 104
byte 1 95
byte 1 105
byte 1 95
byte 1 103
byte 1 0
align 1
LABELV $181
byte 1 104
byte 1 97
byte 1 115
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $180
byte 1 114
byte 1 115
byte 1 95
byte 1 103
byte 1 114
byte 1 0
align 1
LABELV $179
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 95
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $178
byte 1 114
byte 1 118
byte 1 95
byte 1 103
byte 1 114
byte 1 0
align 1
LABELV $177
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 95
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $176
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 95
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $175
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 95
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $174
byte 1 114
byte 1 115
byte 1 95
byte 1 103
byte 1 0
align 1
LABELV $173
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 95
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $172
byte 1 114
byte 1 118
byte 1 95
byte 1 103
byte 1 0
align 1
LABELV $171
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $170
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 95
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $169
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 95
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $168
byte 1 105
byte 1 102
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 95
byte 1 105
byte 1 115
byte 1 95
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $167
byte 1 105
byte 1 102
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 95
byte 1 105
byte 1 115
byte 1 95
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $166
byte 1 105
byte 1 102
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 95
byte 1 105
byte 1 115
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $165
byte 1 105
byte 1 102
byte 1 95
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 105
byte 1 115
byte 1 95
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $164
byte 1 105
byte 1 102
byte 1 95
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 105
byte 1 115
byte 1 95
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $163
byte 1 105
byte 1 102
byte 1 95
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 105
byte 1 115
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $162
byte 1 101
byte 1 108
byte 1 115
byte 1 101
byte 1 95
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $161
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $160
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $159
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 100
byte 1 95
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $158
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $157
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 95
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $156
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $155
byte 1 100
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $154
byte 1 110
byte 1 111
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $153
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 95
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $152
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 95
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $151
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $150
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $149
byte 1 109
byte 1 97
byte 1 120
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $148
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $147
byte 1 109
byte 1 97
byte 1 120
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 107
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $146
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 107
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $145
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $144
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $143
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $142
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 95
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $141
byte 1 114
byte 1 101
byte 1 97
byte 1 108
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $140
byte 1 104
byte 1 97
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $139
byte 1 104
byte 1 97
byte 1 115
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
LABELV $138
byte 1 105
byte 1 110
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $137
byte 1 108
byte 1 105
byte 1 118
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $136
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 95
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $135
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 95
byte 1 99
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $134
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $133
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 0
align 1
LABELV $132
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $131
byte 1 109
byte 1 97
byte 1 120
byte 1 115
byte 1 116
byte 1 114
byte 1 97
byte 1 102
byte 1 101
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $130
byte 1 109
byte 1 97
byte 1 120
byte 1 102
byte 1 98
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $129
byte 1 109
byte 1 97
byte 1 120
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $128
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 95
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $127
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 95
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $126
byte 1 109
byte 1 97
byte 1 120
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $125
byte 1 109
byte 1 97
byte 1 120
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $124
byte 1 109
byte 1 97
byte 1 120
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $123
byte 1 109
byte 1 97
byte 1 120
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $122
byte 1 116
byte 1 102
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $121
byte 1 104
byte 1 97
byte 1 115
byte 1 95
byte 1 100
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
byte 1 0
align 1
LABELV $120
byte 1 105
byte 1 115
byte 1 95
byte 1 117
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 116
byte 1 111
byte 1 115
byte 1 112
byte 1 121
byte 1 0
align 1
LABELV $119
byte 1 105
byte 1 115
byte 1 95
byte 1 102
byte 1 101
byte 1 105
byte 1 103
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $118
byte 1 105
byte 1 115
byte 1 95
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $117
byte 1 105
byte 1 115
byte 1 95
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $116
byte 1 105
byte 1 115
byte 1 95
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $115
byte 1 105
byte 1 115
byte 1 95
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $114
byte 1 99
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 95
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $113
byte 1 103
byte 1 111
byte 1 116
byte 1 95
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $112
byte 1 116
byte 1 112
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 115
byte 1 95
byte 1 50
byte 1 0
align 1
LABELV $111
byte 1 116
byte 1 112
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 115
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $110
byte 1 110
byte 1 111
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 115
byte 1 95
byte 1 50
byte 1 0
align 1
LABELV $109
byte 1 110
byte 1 111
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 115
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $108
byte 1 116
byte 1 102
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 116
byte 1 102
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $106
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $105
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 112
byte 1 99
byte 1 0
align 1
LABELV $104
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $103
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 117
byte 1 108
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $102
byte 1 97
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $101
byte 1 100
byte 1 95
byte 1 110
byte 1 95
byte 1 110
byte 1 0
align 1
LABELV $100
byte 1 110
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 110
byte 1 111
byte 1 110
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $99
byte 1 100
byte 1 95
byte 1 110
byte 1 95
byte 1 116
byte 1 0
align 1
LABELV $98
byte 1 110
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $97
byte 1 100
byte 1 95
byte 1 110
byte 1 0
align 1
LABELV $96
byte 1 110
byte 1 111
byte 1 110
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $95
byte 1 100
byte 1 95
byte 1 116
byte 1 0
align 1
LABELV $94
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $93
byte 1 110
byte 1 95
byte 1 111
byte 1 0
align 1
LABELV $92
byte 1 110
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 115
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 97
byte 1 100
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $91
byte 1 110
byte 1 95
byte 1 110
byte 1 0
align 1
LABELV $90
byte 1 110
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 110
byte 1 111
byte 1 110
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 97
byte 1 100
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $89
byte 1 110
byte 1 95
byte 1 116
byte 1 0
align 1
LABELV $88
byte 1 110
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 97
byte 1 100
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $87
byte 1 110
byte 1 95
byte 1 98
byte 1 0
align 1
LABELV $86
byte 1 110
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 97
byte 1 100
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $85
byte 1 98
byte 1 95
byte 1 111
byte 1 0
align 1
LABELV $84
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 115
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 97
byte 1 100
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $83
byte 1 98
byte 1 95
byte 1 110
byte 1 0
align 1
LABELV $82
byte 1 110
byte 1 111
byte 1 110
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 97
byte 1 100
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $81
byte 1 98
byte 1 95
byte 1 116
byte 1 0
align 1
LABELV $80
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 97
byte 1 100
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $79
byte 1 98
byte 1 95
byte 1 98
byte 1 0
align 1
LABELV $78
byte 1 98
byte 1 114
byte 1 111
byte 1 97
byte 1 100
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $77
byte 1 110
byte 1 95
byte 1 115
byte 1 95
byte 1 99
byte 1 0
align 1
LABELV $76
byte 1 110
byte 1 111
byte 1 110
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 95
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $75
byte 1 110
byte 1 95
byte 1 115
byte 1 95
byte 1 109
byte 1 0
align 1
LABELV $74
byte 1 110
byte 1 111
byte 1 110
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 95
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $73
byte 1 110
byte 1 95
byte 1 115
byte 1 95
byte 1 104
byte 1 0
align 1
LABELV $72
byte 1 110
byte 1 111
byte 1 110
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 95
byte 1 104
byte 1 111
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $71
byte 1 116
byte 1 95
byte 1 115
byte 1 95
byte 1 99
byte 1 0
align 1
LABELV $70
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 95
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $69
byte 1 116
byte 1 95
byte 1 115
byte 1 95
byte 1 109
byte 1 0
align 1
LABELV $68
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 95
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $67
byte 1 116
byte 1 95
byte 1 115
byte 1 95
byte 1 104
byte 1 0
align 1
LABELV $66
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 95
byte 1 104
byte 1 111
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $65
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $64
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 52
byte 1 0
align 1
LABELV $63
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $62
byte 1 103
byte 1 95
byte 1 101
byte 1 0
align 1
LABELV $61
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $60
byte 1 103
byte 1 95
byte 1 97
byte 1 0
align 1
LABELV $59
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $58
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 51
byte 1 0
align 1
LABELV $57
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 50
byte 1 0
align 1
LABELV $56
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 49
byte 1 0
align 1
LABELV $55
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $54
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $53
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $52
byte 1 110
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $51
byte 1 95
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $50
byte 1 119
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $49
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $48
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $47
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $46
byte 1 109
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $45
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $44
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $43
byte 1 104
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $42
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $41
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $40
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $39
byte 1 100
byte 1 109
byte 1 103
byte 1 0
align 1
LABELV $38
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $37
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $36
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $35
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $34
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $33
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $31
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $30
byte 1 99
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $29
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $28
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $27
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $26
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $25
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $24
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $23
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $22
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 0
