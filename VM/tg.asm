export TG_LoadSettings
code
proc TG_LoadSettings 144 20
file "..\src\tg.c"
line 30
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
;21: *  $Id: tg.c,v 1.16 2006/03/04 13:01:15 AngelD Exp $
;22: */
;23:
;24:#include "g_local.h"
;25:
;26:tf_tg_server_data_t tg_data;
;27:void Detpack_SetClip(  );
;28:
;29:void TG_LoadSettings()
;30:{
line 33
;31:	char    st[10];
;32:		
;33:       	GetSVInfokeyString( "sg_fire", NULL, st, sizeof( st ), "on" );
ADDRGP4 $12
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $13
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 34
;34:       	if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $14
line 35
;35:       		tg_data.sg_disable_fire = 1;
ADDRGP4 tg_data+44
CNSTI4 1
ASGNI4
ADDRGP4 $15
JUMPV
LABELV $14
line 37
;36:       	else
;37:       		tg_data.sg_disable_fire = 0;
ADDRGP4 tg_data+44
CNSTI4 0
ASGNI4
LABELV $15
line 39
;38:
;39:       	GetSVInfokeyString( "sg_find", NULL, st, sizeof( st ), "" );
ADDRGP4 $19
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $20
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 40
;40:       	if ( !strcmp( st, "all" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $23
ARGP4
ADDRLP4 16
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $21
line 41
;41:       		tg_data.sg_allow_find = TG_SG_FIND_IGNORE_OFF;
ADDRGP4 tg_data+40
CNSTI4 2
ASGNI4
ADDRGP4 $22
JUMPV
LABELV $21
line 42
;42:       	else if( !strcmp( st, "self" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $27
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $25
line 43
;43:       		tg_data.sg_allow_find = TG_SG_FIND_IGNORE_OWNER;
ADDRGP4 tg_data+40
CNSTI4 1
ASGNI4
ADDRGP4 $26
JUMPV
LABELV $25
line 44
;44:       		else if( !strcmp( st, "no" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $31
ARGP4
ADDRLP4 24
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $29
line 45
;45:       				tg_data.sg_allow_find = TG_SG_FIND_IGNORE_ALL;
ADDRGP4 tg_data+40
CNSTI4 3
ASGNI4
ADDRGP4 $30
JUMPV
LABELV $29
line 47
;46:       			else
;47:       				tg_data.sg_allow_find = TG_SG_FIND_IGNORE_TEAM;
ADDRGP4 tg_data+40
CNSTI4 0
ASGNI4
LABELV $30
LABELV $26
LABELV $22
line 56
;48:       				
;49:/*       	GetSVInfokeyString( "sg_fire_type", NULL, st, sizeof( st ), "" );
;50:       	if ( !strcmp( st, "nodmg" ) )
;51:       		tg_data.sg_fire_type = TG_SG_FIRE_LIGHTING;
;52:       	else if( !strcmp( st, "bullets" ) )
;53:       			tg_data.sg_fire_type = TG_SG_FIRE_BULLETS;
;54:      		else
;55:       			tg_data.sg_fire_type = TG_SG_FIRE_NORMAL;*/
;56:       	GetSVInfokeyString( "sg_fire_bullets", NULL, st, sizeof( st ), "on" );
ADDRGP4 $34
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $13
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 57
;57:       	if( !strcmp(st,"off") )
ADDRLP4 0
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 28
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $35
line 58
;58:       	        tg_data.sg_fire_bullets = false;
ADDRGP4 tg_data+48
CNSTI4 0
ASGNI4
ADDRGP4 $36
JUMPV
LABELV $35
line 60
;59:       	else
;60:       	        tg_data.sg_fire_bullets = true;
ADDRGP4 tg_data+48
CNSTI4 1
ASGNI4
LABELV $36
line 61
;61:       	GetSVInfokeyString( "sg_fire_rockets", NULL, st, sizeof( st ), "on" );
ADDRGP4 $39
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $13
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 62
;62:       	if( !strcmp(st,"off") )
ADDRLP4 0
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 32
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $40
line 63
;63:       	        tg_data.sg_fire_rockets = false;
ADDRGP4 tg_data+52
CNSTI4 0
ASGNI4
ADDRGP4 $41
JUMPV
LABELV $40
line 65
;64:       	else
;65:       	        tg_data.sg_fire_rockets = true;
ADDRGP4 tg_data+52
CNSTI4 1
ASGNI4
LABELV $41
line 66
;66:       	GetSVInfokeyString( "sg_fire_lighting", NULL, st, sizeof( st ), "off" );
ADDRGP4 $44
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $16
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 67
;67:       	if( !strcmp(st,"off") )
ADDRLP4 0
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 36
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $45
line 68
;68:       	        tg_data.sg_fire_lighting = false;
ADDRGP4 tg_data+56
CNSTI4 0
ASGNI4
ADDRGP4 $46
JUMPV
LABELV $45
line 70
;69:       	else
;70:       	        tg_data.sg_fire_lighting = true;
ADDRGP4 tg_data+56
CNSTI4 1
ASGNI4
LABELV $46
line 71
;71:       	GetSVInfokeyString( "sg_unlimit_ammo", NULL, st, sizeof( st ), "off" );
ADDRGP4 $49
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $16
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 72
;72:       	if( !strcmp(st,"on") )
ADDRLP4 0
ARGP4
ADDRGP4 $13
ARGP4
ADDRLP4 40
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $50
line 73
;73:       	        tg_data.sg_unlimit_ammo = true;
ADDRGP4 tg_data+60
CNSTI4 1
ASGNI4
ADDRGP4 $51
JUMPV
LABELV $50
line 75
;74:       	else
;75:       	        tg_data.sg_unlimit_ammo = false;
ADDRGP4 tg_data+60
CNSTI4 0
ASGNI4
LABELV $51
line 78
;76:       	        
;77:      			
;78:       	GetSVInfokeyString( "gren_eff", NULL, st, sizeof( st ), "" );
ADDRGP4 $54
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $20
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 79
;79:       	if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 44
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $55
line 80
;80:       		tg_data.gren_effect = TG_GREN_EFFECT_OFF;
ADDRGP4 tg_data+32
CNSTI4 1
ASGNI4
ADDRGP4 $56
JUMPV
LABELV $55
line 81
;81:       	else if( !strcmp( st, "self" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $27
ARGP4
ADDRLP4 48
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $58
line 82
;82:       			tg_data.gren_effect = TG_GREN_EFFECT_OFF_FORSELF;
ADDRGP4 tg_data+32
CNSTI4 2
ASGNI4
ADDRGP4 $59
JUMPV
LABELV $58
line 84
;83:      		else
;84:       			tg_data.gren_effect = TG_GREN_EFFECT_ON;
ADDRGP4 tg_data+32
CNSTI4 0
ASGNI4
LABELV $59
LABELV $56
line 86
;85:
;86:       	GetSVInfokeyString( "gren_time", NULL, st, sizeof( st ), "" );
ADDRGP4 $62
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $20
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 87
;87:       	if ( !strcmp( st, "10" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $65
ARGP4
ADDRLP4 52
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $63
line 88
;88:       		tg_data.gren_time = 10;
ADDRGP4 tg_data+36
CNSTI4 10
ASGNI4
ADDRGP4 $64
JUMPV
LABELV $63
line 89
;89:       	else if( !strcmp( st, "5" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $69
ARGP4
ADDRLP4 56
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $67
line 90
;90:       			tg_data.gren_time = 5;
ADDRGP4 tg_data+36
CNSTI4 5
ASGNI4
ADDRGP4 $68
JUMPV
LABELV $67
line 92
;91:      		else
;92:       			tg_data.gren_time = 0;
ADDRGP4 tg_data+36
CNSTI4 0
ASGNI4
LABELV $68
LABELV $64
line 95
;93:
;94:
;95:       	GetSVInfokeyString( "god", NULL, st, sizeof( st ), "off" );
ADDRGP4 $72
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $16
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 96
;96:       	if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $13
ARGP4
ADDRLP4 60
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $73
line 97
;97:       		tg_data.godmode = 1;
ADDRGP4 tg_data+4
CNSTI4 1
ASGNI4
ADDRGP4 $74
JUMPV
LABELV $73
line 99
;98:       	else
;99:       		tg_data.godmode = 0;
ADDRGP4 tg_data+4
CNSTI4 0
ASGNI4
LABELV $74
line 101
;100:
;101:       	GetSVInfokeyString( "disable_reload", NULL, st, sizeof( st ), "off" );
ADDRGP4 $77
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $16
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 102
;102:       	if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $13
ARGP4
ADDRLP4 64
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $78
line 103
;103:       		tg_data.disable_reload = 1;
ADDRGP4 tg_data+16
CNSTI4 1
ASGNI4
ADDRGP4 $79
JUMPV
LABELV $78
line 105
;104:       	else
;105:       		tg_data.disable_reload = 0;
ADDRGP4 tg_data+16
CNSTI4 0
ASGNI4
LABELV $79
line 107
;106:
;107:       	GetSVInfokeyString( "unl_ammo", NULL, st, sizeof( st ), "off" );
ADDRGP4 $82
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $16
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 108
;108:       	if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $13
ARGP4
ADDRLP4 68
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $83
line 109
;109:       		tg_data.unlimit_ammo = 1;
ADDRGP4 tg_data+8
CNSTI4 1
ASGNI4
ADDRGP4 $84
JUMPV
LABELV $83
line 111
;110:       	else
;111:       		tg_data.unlimit_ammo = 0;
ADDRGP4 tg_data+8
CNSTI4 0
ASGNI4
LABELV $84
line 113
;112:
;113:       	GetSVInfokeyString( "unl_gren", NULL, st, sizeof( st ), "off" );
ADDRGP4 $87
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $16
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 114
;114:       	if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $13
ARGP4
ADDRLP4 72
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $88
line 115
;115:       		tg_data.unlimit_grens = 1;
ADDRGP4 tg_data+12
CNSTI4 1
ASGNI4
ADDRGP4 $89
JUMPV
LABELV $88
line 117
;116:       	else
;117:       		tg_data.unlimit_grens = 0;
ADDRGP4 tg_data+12
CNSTI4 0
ASGNI4
LABELV $89
line 120
;118:
;119:
;120:       	GetSVInfokeyString( "dp_da", NULL, st, sizeof( st ), "on" );
ADDRGP4 $92
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $13
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 121
;121:       	if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 76
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $93
line 122
;122:       		tg_data.disable_disarm = 1;
ADDRGP4 tg_data+28
CNSTI4 1
ASGNI4
ADDRGP4 $94
JUMPV
LABELV $93
line 124
;123:       	else
;124:       		tg_data.disable_disarm = 0;
ADDRGP4 tg_data+28
CNSTI4 0
ASGNI4
LABELV $94
line 126
;125:
;126:       	GetSVInfokeyString( "dp_drop", NULL, st, sizeof( st ), "off" );
ADDRGP4 $97
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $16
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 127
;127:       	if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $13
ARGP4
ADDRLP4 80
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
NEI4 $98
line 128
;128:       		tg_data.detpack_drop = 1;
ADDRGP4 tg_data+24
CNSTI4 1
ASGNI4
ADDRGP4 $99
JUMPV
LABELV $98
line 130
;129:       	else
;130:       		tg_data.detpack_drop = 0;
ADDRGP4 tg_data+24
CNSTI4 0
ASGNI4
LABELV $99
line 133
;131:
;132:
;133:       	GetSVInfokeyString( "dp_clip", NULL, st, sizeof( st ), "" );
ADDRGP4 $102
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $20
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 134
;134:       	if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 84
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $103
line 135
;135:       		tg_data.detpack_clip = TG_DETPACK_SOLID_ALL;
ADDRGP4 tg_data+20
CNSTI4 2
ASGNI4
ADDRGP4 $104
JUMPV
LABELV $103
line 136
;136:       	else if( !strcmp( st, "all" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $23
ARGP4
ADDRLP4 88
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $106
line 137
;137:       			tg_data.detpack_clip = TG_DETPACK_CLIP_ALL;
ADDRGP4 tg_data+20
CNSTI4 1
ASGNI4
ADDRGP4 $107
JUMPV
LABELV $106
line 139
;138:      		else
;139:       			tg_data.detpack_clip = TG_DETPACK_CLIP_OWNER;
ADDRGP4 tg_data+20
CNSTI4 0
ASGNI4
LABELV $107
LABELV $104
line 140
;140:       	Detpack_SetClip();
ADDRGP4 Detpack_SetClip
CALLV
pop
line 142
;141:
;142:      	tf_data.sg_newfind = true;
ADDRGP4 tf_data+108
CNSTI4 1
ASGNI4
line 143
;143:      	tf_data.sg_sfire   = SG_SFIRE_NEW;
ADDRGP4 tf_data+112
CNSTI4 0
ASGNI4
line 145
;144:
;145:      	GetSVInfokeyString( "sg", NULL, st, sizeof( st ), "new" );
ADDRGP4 $112
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $113
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 146
;146:      	if ( !strcmp( st, "old" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $116
ARGP4
ADDRLP4 92
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $114
line 147
;147:      	{
line 148
;148:      		tf_data.sg_newfind = false;
ADDRGP4 tf_data+108
CNSTI4 0
ASGNI4
line 149
;149:      		tf_data.sg_sfire   = SG_SFIRE_281;
ADDRGP4 tf_data+112
CNSTI4 1
ASGNI4
line 150
;150:      	}
LABELV $114
line 151
;151:      	if ( !strcmp( st, "fix" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $121
ARGP4
ADDRLP4 96
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $119
line 152
;152:      	{
line 153
;153:      		tf_data.sg_newfind = false;
ADDRGP4 tf_data+108
CNSTI4 0
ASGNI4
line 154
;154:      		tf_data.sg_sfire   = SG_SFIRE_MTFL2;
ADDRGP4 tf_data+112
CNSTI4 3
ASGNI4
line 155
;155:      	}
LABELV $119
line 157
;156:
;157:      	if ( !strcmp( st, "oldmtfl" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $126
ARGP4
ADDRLP4 100
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $124
line 158
;158:      	{
line 159
;159:      		tf_data.sg_newfind = false;
ADDRGP4 tf_data+108
CNSTI4 0
ASGNI4
line 160
;160:      		tf_data.sg_sfire   = SG_SFIRE_MTFL1;
ADDRGP4 tf_data+112
CNSTI4 2
ASGNI4
line 161
;161:      	}
LABELV $124
line 162
;162:      	if ( !strcmp( st, "mtflf" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $131
ARGP4
ADDRLP4 104
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $129
line 163
;163:      	{
line 164
;164:      		tf_data.sg_newfind = true;
ADDRGP4 tf_data+108
CNSTI4 1
ASGNI4
line 165
;165:      		tf_data.sg_sfire   = SG_SFIRE_MTFL1;
ADDRGP4 tf_data+112
CNSTI4 2
ASGNI4
line 166
;166:      	}
LABELV $129
line 168
;167:
;168:      	if ( !strcmp( st, "oldf" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $136
ARGP4
ADDRLP4 108
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $134
line 169
;169:      	{
line 170
;170:      		tf_data.sg_newfind = true;
ADDRGP4 tf_data+108
CNSTI4 1
ASGNI4
line 171
;171:      		tf_data.sg_sfire   = SG_SFIRE_281;
ADDRGP4 tf_data+112
CNSTI4 1
ASGNI4
line 172
;172:      	}
LABELV $134
line 174
;173:
;174:      	GetSVInfokeyString( "sg_newfind", NULL, st, sizeof( st ), "on" );
ADDRGP4 $139
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $13
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 175
;175:      	if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 112
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
NEI4 $140
line 176
;176:      		tf_data.sg_newfind = false;
ADDRGP4 tf_data+108
CNSTI4 0
ASGNI4
ADDRGP4 $141
JUMPV
LABELV $140
line 178
;177:      	else
;178:      		tf_data.sg_newfind = true;
ADDRGP4 tf_data+108
CNSTI4 1
ASGNI4
LABELV $141
line 181
;179:
;180:
;181:      	GetSVInfokeyString( "sg_sfire", NULL, st, sizeof( st ), "new" );
ADDRGP4 $144
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $113
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 183
;182:
;183:      	if( !strcmp(st, "old"))
ADDRLP4 0
ARGP4
ADDRGP4 $116
ARGP4
ADDRLP4 116
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
NEI4 $145
line 184
;184:      		tf_data.sg_sfire = SG_SFIRE_281;
ADDRGP4 tf_data+112
CNSTI4 1
ASGNI4
LABELV $145
line 186
;185:
;186:      	if( !strcmp(st, "mtfl1"))
ADDRLP4 0
ARGP4
ADDRGP4 $150
ARGP4
ADDRLP4 120
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $148
line 187
;187:      		tf_data.sg_sfire = SG_SFIRE_MTFL1;
ADDRGP4 tf_data+112
CNSTI4 2
ASGNI4
LABELV $148
line 189
;188:
;189:      	if( !strcmp(st, "mtfl2"))
ADDRLP4 0
ARGP4
ADDRGP4 $154
ARGP4
ADDRLP4 124
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
NEI4 $152
line 190
;190:      		tf_data.sg_sfire = SG_SFIRE_MTFL2;
ADDRGP4 tf_data+112
CNSTI4 3
ASGNI4
LABELV $152
line 192
;191:      		
;192:	GetSVInfokeyString( "sg_rfire", NULL, st, sizeof( st ), "old" );
ADDRGP4 $156
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $116
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 194
;193:
;194:	if( !strcmp(st, "new"))
ADDRLP4 0
ARGP4
ADDRGP4 $113
ARGP4
ADDRLP4 128
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
NEI4 $157
line 195
;195:		tf_data.sg_rfire = true;
ADDRGP4 tf_data+116
CNSTI4 1
ASGNI4
ADDRGP4 $158
JUMPV
LABELV $157
line 197
;196:	else
;197:		tf_data.sg_rfire = false;
ADDRGP4 tf_data+116
CNSTI4 0
ASGNI4
LABELV $158
line 199
;198:
;199:       	tf_data.sgppl = GetSVInfokeyInt( "sgppl", NULL, 12 );
ADDRGP4 $162
ARGP4
CNSTP4 0
ARGP4
CNSTI4 12
ARGI4
ADDRLP4 132
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 tf_data+120
ADDRLP4 132
INDIRI4
ASGNI4
line 200
;200:       	if ( tf_data.sgppl < 0 )
ADDRGP4 tf_data+120
INDIRI4
CNSTI4 0
GEI4 $163
line 201
;201:       		tf_data.sgppl = 0;
ADDRGP4 tf_data+120
CNSTI4 0
ASGNI4
LABELV $163
line 203
;202:
;203:       	GetSVInfokeyString( "dtpb", NULL, st, sizeof( st ), "on" );
ADDRGP4 $167
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $13
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 204
;204:       	if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 136
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
NEI4 $168
line 205
;205:       		tf_data.detpack_block = 0;
ADDRGP4 tf_data+168
CNSTI4 0
ASGNI4
ADDRGP4 $169
JUMPV
LABELV $168
line 207
;206:       	else
;207:       		tf_data.detpack_block = 1;
ADDRGP4 tf_data+168
CNSTI4 1
ASGNI4
LABELV $169
line 209
;208:
;209:       	GetSVInfokeyString( "tg_sbar", NULL, st, sizeof( st ), "off" );
ADDRGP4 $172
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $16
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 210
;210:       	if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $13
ARGP4
ADDRLP4 140
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $173
line 211
;211:       		tg_data.tg_sbar = 1;
ADDRGP4 tg_data+64
CNSTI4 1
ASGNI4
ADDRGP4 $174
JUMPV
LABELV $173
line 213
;212:       	else
;213:       		tg_data.tg_sbar = 0;
ADDRGP4 tg_data+64
CNSTI4 0
ASGNI4
LABELV $174
line 215
;214:
;215:}
LABELV $11
endproc TG_LoadSettings 144 20
export TG_Cmd
proc TG_Cmd 144 16
line 218
;216:
;217:void TG_Cmd()
;218:{
line 224
;219:        char    cmd_command[50];
;220:        char    st[50];
;221:        int argc;
;222:
;223:
;224:	if( !tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
NEI4 $178
line 225
;225:	{
line 226
;226:		G_sprint(self, 2, "Training Ground mode not active\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $180
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 227
;227:		return;
ADDRGP4 $177
JUMPV
LABELV $178
line 230
;228:	
;229:	}
;230:	argc = trap_CmdArgc();
ADDRLP4 104
ADDRGP4 trap_CmdArgc
CALLI4
ASGNI4
ADDRLP4 100
ADDRLP4 104
INDIRI4
ASGNI4
line 231
;231:	if(argc<2)
ADDRLP4 100
INDIRI4
CNSTI4 2
GEI4 $181
line 232
;232:		return;
ADDRGP4 $177
JUMPV
LABELV $181
line 234
;233:
;234:        trap_CmdArgv( 1, cmd_command, sizeof( cmd_command ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 235
;235:        if(!strcmp(cmd_command,"sgppl"))
ADDRLP4 0
ARGP4
ADDRGP4 $162
ARGP4
ADDRLP4 108
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $183
line 236
;236:        {
line 237
;237:                if(argc<3)
ADDRLP4 100
INDIRI4
CNSTI4 3
GEI4 $185
line 238
;238:                {
line 239
;239:                	G_sprint(self, 2, "sgppl %d\n",tf_data.sgppl);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $187
ARGP4
ADDRGP4 tf_data+120
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 240
;240:                	return;
ADDRGP4 $177
JUMPV
LABELV $185
line 243
;241:                }
;242:                	
;243:                trap_CmdArgv( 2, st, sizeof( st ) );
CNSTI4 2
ARGI4
ADDRLP4 50
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 244
;244:                tf_data.sgppl = atoi(st);
ADDRLP4 50
ARGP4
ADDRLP4 112
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 tf_data+120
ADDRLP4 112
INDIRI4
ASGNI4
line 245
;245:                if( tf_data.sgppl < 0)
ADDRGP4 tf_data+120
INDIRI4
CNSTI4 0
GEI4 $177
line 246
;246:                	tf_data.sgppl = 0;
ADDRGP4 tf_data+120
CNSTI4 0
ASGNI4
line 247
;247:                return;
ADDRGP4 $177
JUMPV
LABELV $183
line 250
;248:        }
;249:
;250:        if(!strcmp(cmd_command,"sg_fire"))
ADDRLP4 0
ARGP4
ADDRGP4 $12
ARGP4
ADDRLP4 112
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
NEI4 $194
line 251
;251:        {
line 252
;252:                if(argc<3)
ADDRLP4 100
INDIRI4
CNSTI4 3
GEI4 $196
line 253
;253:                {
line 254
;254:                	G_sprint(self, 2, "SG_Fire %s\n",(!tg_data.sg_disable_fire)?"On":"Off");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $198
ARGP4
ADDRGP4 tg_data+44
INDIRI4
CNSTI4 0
NEI4 $203
ADDRLP4 116
ADDRGP4 $200
ASGNP4
ADDRGP4 $204
JUMPV
LABELV $203
ADDRLP4 116
ADDRGP4 $201
ASGNP4
LABELV $204
ADDRLP4 116
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 255
;255:                	return;
ADDRGP4 $177
JUMPV
LABELV $196
line 258
;256:                }
;257:                	
;258:                trap_CmdArgv( 2, st, sizeof( st ) );
CNSTI4 2
ARGI4
ADDRLP4 50
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 259
;259:          	if ( !strcmp( st, "off" ) )
ADDRLP4 50
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 116
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
NEI4 $205
line 260
;260:          		tg_data.sg_disable_fire = 1;
ADDRGP4 tg_data+44
CNSTI4 1
ASGNI4
ADDRGP4 $177
JUMPV
LABELV $205
line 261
;261:          	else if( !strcmp( st, "toggle" ) )
ADDRLP4 50
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 120
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $208
line 262
;262:          	{
line 263
;263:          	        tg_data.sg_disable_fire = (tg_data.sg_disable_fire)?0:1;
ADDRGP4 tg_data+44
INDIRI4
CNSTI4 0
EQI4 $214
ADDRLP4 124
CNSTI4 0
ASGNI4
ADDRGP4 $215
JUMPV
LABELV $214
ADDRLP4 124
CNSTI4 1
ASGNI4
LABELV $215
ADDRGP4 tg_data+44
ADDRLP4 124
INDIRI4
ASGNI4
line 264
;264:          	}else
ADDRGP4 $177
JUMPV
LABELV $208
line 265
;265:          	{
line 266
;266:          		tg_data.sg_disable_fire = 0;
ADDRGP4 tg_data+44
CNSTI4 0
ASGNI4
line 267
;267:          	}
line 268
;268:                return;
ADDRGP4 $177
JUMPV
LABELV $194
line 270
;269:        }
;270:        if(!strcmp(cmd_command,"sg_find"))
ADDRLP4 0
ARGP4
ADDRGP4 $19
ARGP4
ADDRLP4 116
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
NEI4 $217
line 271
;271:        {
line 272
;272:                if(argc<3)
ADDRLP4 100
INDIRI4
CNSTI4 3
GEI4 $219
line 273
;273:                {
line 274
;274:                	G_sprint(self, 2, "SG_Find \n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $221
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 275
;275:                	return;
ADDRGP4 $177
JUMPV
LABELV $219
line 278
;276:                }
;277:                	
;278:                trap_CmdArgv( 2, st, sizeof( st ) );
CNSTI4 2
ARGI4
ADDRLP4 50
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 279
;279:          	if ( !strcmp( st, "all" ) )
ADDRLP4 50
ARGP4
ADDRGP4 $23
ARGP4
ADDRLP4 120
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $222
line 280
;280:          		tg_data.sg_allow_find = TG_SG_FIND_IGNORE_OFF;
ADDRGP4 tg_data+40
CNSTI4 2
ASGNI4
ADDRGP4 $177
JUMPV
LABELV $222
line 281
;281:          	else if( !strcmp( st, "self" ) )
ADDRLP4 50
ARGP4
ADDRGP4 $27
ARGP4
ADDRLP4 124
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
NEI4 $225
line 282
;282:          		tg_data.sg_allow_find = TG_SG_FIND_IGNORE_OWNER;
ADDRGP4 tg_data+40
CNSTI4 1
ASGNI4
ADDRGP4 $177
JUMPV
LABELV $225
line 283
;283:          		else if( !strcmp( st, "no" ) )
ADDRLP4 50
ARGP4
ADDRGP4 $31
ARGP4
ADDRLP4 128
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
NEI4 $228
line 284
;284:          				tg_data.sg_allow_find = TG_SG_FIND_IGNORE_ALL;
ADDRGP4 tg_data+40
CNSTI4 3
ASGNI4
ADDRGP4 $177
JUMPV
LABELV $228
line 286
;285:          			else
;286:          				tg_data.sg_allow_find = TG_SG_FIND_IGNORE_TEAM;
ADDRGP4 tg_data+40
CNSTI4 0
ASGNI4
line 287
;287:                return;
ADDRGP4 $177
JUMPV
LABELV $217
line 290
;288:        }
;289:
;290:        if(!strcmp(cmd_command,"sg_fire_bullets"))
ADDRLP4 0
ARGP4
ADDRGP4 $34
ARGP4
ADDRLP4 120
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $232
line 291
;291:        {
line 292
;292:                if(argc<3)
ADDRLP4 100
INDIRI4
CNSTI4 3
GEI4 $234
line 293
;293:                {
line 294
;294:                	G_sprint(self, 2, "sg_fire_bullets is %s\n", tg_data.sg_fire_bullets?"on":"off");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $236
ARGP4
ADDRGP4 tg_data+48
INDIRI4
CNSTI4 0
EQI4 $239
ADDRLP4 124
ADDRGP4 $13
ASGNP4
ADDRGP4 $240
JUMPV
LABELV $239
ADDRLP4 124
ADDRGP4 $16
ASGNP4
LABELV $240
ADDRLP4 124
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 295
;295:                	return;
ADDRGP4 $177
JUMPV
LABELV $234
line 297
;296:                }
;297:                trap_CmdArgv( 2, st, sizeof( st ) );
CNSTI4 2
ARGI4
ADDRLP4 50
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 298
;298:         	if( !strcmp(st,"off") )
ADDRLP4 50
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 124
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
NEI4 $241
line 299
;299:         	        tg_data.sg_fire_bullets = false;
ADDRGP4 tg_data+48
CNSTI4 0
ASGNI4
ADDRGP4 $177
JUMPV
LABELV $241
line 301
;300:         	else
;301:         	        tg_data.sg_fire_bullets = true;
ADDRGP4 tg_data+48
CNSTI4 1
ASGNI4
line 302
;302:         	return;
ADDRGP4 $177
JUMPV
LABELV $232
line 304
;303:        }
;304:        if(!strcmp(cmd_command,"sg_fire_rockets"))
ADDRLP4 0
ARGP4
ADDRGP4 $39
ARGP4
ADDRLP4 124
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
NEI4 $245
line 305
;305:        {
line 306
;306:                if(argc<3)
ADDRLP4 100
INDIRI4
CNSTI4 3
GEI4 $247
line 307
;307:                {
line 308
;308:                	G_sprint(self, 2, "sg_fire_rockets is %s\n", tg_data.sg_fire_rockets?"on":"off");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $249
ARGP4
ADDRGP4 tg_data+52
INDIRI4
CNSTI4 0
EQI4 $252
ADDRLP4 128
ADDRGP4 $13
ASGNP4
ADDRGP4 $253
JUMPV
LABELV $252
ADDRLP4 128
ADDRGP4 $16
ASGNP4
LABELV $253
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 309
;309:                	return;
ADDRGP4 $177
JUMPV
LABELV $247
line 311
;310:                }
;311:                trap_CmdArgv( 2, st, sizeof( st ) );
CNSTI4 2
ARGI4
ADDRLP4 50
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 312
;312:         	if( !strcmp(st,"off") )
ADDRLP4 50
ARGP4
ADDRGP4 $16
ARGP4
ADDRLP4 128
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
NEI4 $254
line 313
;313:         	        tg_data.sg_fire_rockets = false;
ADDRGP4 tg_data+52
CNSTI4 0
ASGNI4
ADDRGP4 $177
JUMPV
LABELV $254
line 315
;314:         	else
;315:         	        tg_data.sg_fire_rockets = true;
ADDRGP4 tg_data+52
CNSTI4 1
ASGNI4
line 316
;316:         	return;
ADDRGP4 $177
JUMPV
LABELV $245
line 318
;317:        }
;318:        if(!strcmp(cmd_command,"sg_fire_lighting"))
ADDRLP4 0
ARGP4
ADDRGP4 $44
ARGP4
ADDRLP4 128
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
NEI4 $258
line 319
;319:        {
line 320
;320:                if(argc<3)
ADDRLP4 100
INDIRI4
CNSTI4 3
GEI4 $260
line 321
;321:                {
line 322
;322:                	G_sprint(self, 2, "sg_fire_lighting is %s\n", tg_data.sg_fire_lighting?"on":"off");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $262
ARGP4
ADDRGP4 tg_data+56
INDIRI4
CNSTI4 0
EQI4 $265
ADDRLP4 132
ADDRGP4 $13
ASGNP4
ADDRGP4 $266
JUMPV
LABELV $265
ADDRLP4 132
ADDRGP4 $16
ASGNP4
LABELV $266
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 323
;323:                	return;
ADDRGP4 $177
JUMPV
LABELV $260
line 325
;324:                }
;325:                trap_CmdArgv( 2, st, sizeof( st ) );
CNSTI4 2
ARGI4
ADDRLP4 50
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 326
;326:         	if( strcmp(st,"on") )
ADDRLP4 50
ARGP4
ADDRGP4 $13
ARGP4
ADDRLP4 132
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $267
line 327
;327:         	        tg_data.sg_fire_lighting = false;
ADDRGP4 tg_data+56
CNSTI4 0
ASGNI4
ADDRGP4 $177
JUMPV
LABELV $267
line 329
;328:         	else
;329:         	        tg_data.sg_fire_lighting = true;
ADDRGP4 tg_data+56
CNSTI4 1
ASGNI4
line 330
;330:         	return;
ADDRGP4 $177
JUMPV
LABELV $258
line 350
;331:        }
;332:
;333:/*        if(!strcmp(cmd_command,"sg_fire_type"))
;334:        {
;335:                if(argc<3)
;336:                {
;337:                	G_sprint(self, 2, "sg_fire_type \n");
;338:                	return;
;339:                }
;340:                	
;341:                trap_CmdArgv( 2, st, sizeof( st ) );
;342:        	if ( !strcmp( st, "nodmg" ) )
;343:        		tg_data.sg_fire_type = TG_SG_FIRE_LIGHTING;
;344:        	else if( !strcmp( st, "bullets" ) )
;345:        			tg_data.sg_fire_type = TG_SG_FIRE_BULLETS;
;346:       		else
;347:        			tg_data.sg_fire_type = TG_SG_FIRE_NORMAL;
;348:                return;
;349:        }*/
;350:	if ( !strcmp( cmd_command, "eff_conc" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $273
ARGP4
ADDRLP4 132
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
NEI4 $271
line 351
;351:	{
line 352
;352:	     TG_Eff_Conc(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TG_Eff_Conc
CALLV
pop
line 353
;353:	     return;
ADDRGP4 $177
JUMPV
LABELV $271
line 356
;354:	}
;355:
;356:	if ( !strcmp( cmd_command, "god" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $72
ARGP4
ADDRLP4 136
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
NEI4 $274
line 357
;357:	{
line 359
;358:
;359:	     if ( ( int ) self->s.v.flags & FL_GODMODE )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $276
line 360
;360:	     {
line 361
;361:	        G_sprint(self,2,"God mode off\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $278
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 362
;362:	        self->s.v.flags = ( int ) self->s.v.flags - FL_GODMODE;
ADDRLP4 140
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 64
SUBI4
CVIF4 4
ASGNF4
line 363
;363:	     }else
ADDRGP4 $177
JUMPV
LABELV $276
line 364
;364:	     {
line 365
;365:	        G_sprint(self,2,"God mode on\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $279
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 366
;366:	        self->s.v.flags = ( int ) self->s.v.flags | FL_GODMODE;
ADDRLP4 140
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 64
BORI4
CVIF4 4
ASGNF4
line 367
;367:	     }
line 368
;368:	     return;
LABELV $274
line 370
;369:	}
;370:}
LABELV $177
endproc TG_Cmd 144 16
export TG_Eff_Flash
proc TG_Eff_Flash 4 8
line 379
;371:
;372:
;373:
;374:void FlashPlayer( gedict_t*p, gedict_t*attacker );
;375:void ConcPlayer( gedict_t*p, gedict_t*attacker );
;376:void ConcussionGrenadeTimer(  );
;377:void OldConcussionGrenadeTimer(  );
;378:void TG_Eff_Flash( gedict_t * te )
;379:{
line 380
;380:	if ( strneq( te->s.v.classname, "player" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 0
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $281
line 381
;381:		return;
ADDRGP4 $280
JUMPV
LABELV $281
line 382
;382:	if ( te->s.v.health <= 0 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $284
line 383
;383:		return;
ADDRGP4 $280
JUMPV
LABELV $284
line 385
;384:
;385:	FlashPlayer( te, NULL );
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 FlashPlayer
CALLV
pop
line 386
;386:}
LABELV $280
endproc TG_Eff_Flash 4 8
export TG_Eff_Conc
proc TG_Eff_Conc 4 8
line 389
;387:
;388:void TG_Eff_Conc( gedict_t * head )
;389:{
line 390
;390:	if ( strneq( head->s.v.classname, "player" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 0
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $287
line 391
;391:		return;
ADDRGP4 $286
JUMPV
LABELV $287
line 392
;392:	if ( head->s.v.health <= 0 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $289
line 393
;393:		return;
ADDRGP4 $286
JUMPV
LABELV $289
line 395
;394:
;395:	ConcPlayer( head, NULL);
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 ConcPlayer
CALLV
pop
line 396
;396:}
LABELV $286
endproc TG_Eff_Conc 4 8
export TG_Eff_Remove
proc TG_Eff_Remove 32 20
line 402
;397:
;398:void    HallucinationTimer(  );
;399:void    TranquiliserTimer(  );
;400:
;401:void TG_Eff_Remove( gedict_t * pl )
;402:{
line 406
;403:	gedict_t *te;
;404:	float   healam;
;405:
;406:	if ( strneq( pl->s.v.classname, "player" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 8
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $292
line 407
;407:		return;
ADDRGP4 $291
JUMPV
LABELV $292
line 408
;408:	if ( pl->s.v.health <= 0 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $294
line 409
;409:		return;
ADDRGP4 $291
JUMPV
LABELV $294
line 411
;410:
;411:	for ( te = world; ( te = trap_find( te, FOFS( s.v.classname ), "timer" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $299
JUMPV
LABELV $296
line 412
;412:	{
line 413
;413:		if ( te->s.v.owner != EDICT_TO_PROG( pl ) )
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
EQI4 $301
line 414
;414:			continue;
ADDRGP4 $297
JUMPV
LABELV $301
line 415
;415:		if ( te->s.v.think != ( func_t ) ConcussionGrenadeTimer &&
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 ConcussionGrenadeTimer
CVPU4 4
CVUI4 4
EQI4 $303
ADDRLP4 12
INDIRI4
ADDRGP4 OldConcussionGrenadeTimer
CVPU4 4
CVUI4 4
EQI4 $303
line 417
;416:		     te->s.v.think != ( func_t ) OldConcussionGrenadeTimer )
;417:			continue;
ADDRGP4 $297
JUMPV
LABELV $303
line 418
;418:		if ( tf_data.old_grens == 1 )
ADDRGP4 tf_data+44
INDIRI4
CNSTI4 1
NEI4 $305
line 420
;419:			//stuffcmd( pl, "v_idlescale 0\nfov 90\n" );
;420:			stuffcmd( pl, "v_idlescale 0\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $308
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $305
line 421
;421:		dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 422
;422:		break;
ADDRGP4 $298
JUMPV
LABELV $297
line 411
LABELV $299
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $300
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
NEU4 $296
LABELV $298
line 424
;423:	}
;424:	if ( pl->tfstate & TFSTATE_HALLUCINATING )
ADDRFP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $309
line 425
;425:	{
line 426
;426:		for ( te = world; ( te = trap_find( te, FOFS( s.v.classname ), "timer" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $314
JUMPV
LABELV $311
line 427
;427:		{
line 428
;428:			if ( te->s.v.owner != EDICT_TO_PROG( pl ) )
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
EQI4 $315
line 429
;429:				continue;
ADDRGP4 $312
JUMPV
LABELV $315
line 430
;430:			if ( te->s.v.think != ( func_t ) HallucinationTimer )
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 HallucinationTimer
CVPU4 4
CVUI4 4
EQI4 $317
line 431
;431:				continue;
ADDRGP4 $312
JUMPV
LABELV $317
line 433
;432:
;433:			pl->tfstate -= ( pl->tfstate & TFSTATE_HALLUCINATING );
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 16384
BANDI4
SUBI4
ASGNI4
line 435
;434:
;435:			ResetGasSkins( pl );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ResetGasSkins
CALLV
pop
line 437
;436:
;437:			if ( tf_data.new_gas & GAS_MASK_PALETTE )
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $319
line 438
;438:				stuffcmd( pl, "v_cshift; wait; bf\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $322
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $319
line 439
;439:			dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 440
;440:			break;
ADDRGP4 $313
JUMPV
LABELV $312
line 426
LABELV $314
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $300
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
NEU4 $311
LABELV $313
line 442
;441:		}
;442:		if ( !te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $323
line 443
;443:			G_conprintf( "Warning: Error in Hallucination Timer logic.\n" );
ADDRGP4 $325
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
LABELV $323
line 444
;444:	}
LABELV $309
line 445
;445:	if ( pl->tfstate & TFSTATE_TRANQUILISED )
ADDRFP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $326
line 446
;446:	{
line 447
;447:		for ( te = world; ( te = trap_find( te, FOFS( s.v.classname ), "timer" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $331
JUMPV
LABELV $328
line 448
;448:		{
line 449
;449:			if ( te->s.v.owner != EDICT_TO_PROG( pl ) )
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
EQI4 $332
line 450
;450:				continue;
ADDRGP4 $329
JUMPV
LABELV $332
line 451
;451:			if ( te->s.v.think != ( func_t ) TranquiliserTimer )
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 TranquiliserTimer
CVPU4 4
CVUI4 4
EQI4 $334
line 452
;452:				continue;
ADDRGP4 $329
JUMPV
LABELV $334
line 454
;453:
;454:			pl->tfstate -= ( pl->tfstate & TFSTATE_TRANQUILISED );
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 32768
BANDI4
SUBI4
ASGNI4
line 455
;455:			TeamFortress_SetSpeed( pl );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 456
;456:			dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 457
;457:			break;
ADDRGP4 $330
JUMPV
LABELV $329
line 447
LABELV $331
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $300
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
NEU4 $328
LABELV $330
line 459
;458:		}
;459:		if ( !te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $336
line 460
;460:			G_conprintf( "Warning: Error in Tranquilisation Timer logic.\n" );
ADDRGP4 $338
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
LABELV $336
line 461
;461:	}
LABELV $326
line 462
;462:	if ( pl->FlashTime > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 1472
ADDP4
INDIRF4
CNSTF4 0
LEF4 $339
line 463
;463:	{
line 464
;464:		for ( te = world; ( te = trap_find( te, FOFS( s.v.netname ), "flashtimer" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $344
JUMPV
LABELV $341
line 465
;465:		{
line 466
;466:			if ( te->s.v.owner != EDICT_TO_PROG( pl ) )
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
EQI4 $346
line 467
;467:				continue;
ADDRGP4 $342
JUMPV
LABELV $346
line 468
;468:			if ( strneq( te->s.v.classname, "timer" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $300
ARGP4
ADDRLP4 16
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $348
line 469
;469:				continue;
ADDRGP4 $342
JUMPV
LABELV $348
line 471
;470:
;471:			pl->FlashTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1472
ADDP4
CNSTF4 0
ASGNF4
line 472
;472:			if ( tf_data.new_flash )
ADDRGP4 tf_data+48
INDIRI4
CNSTI4 0
EQI4 $343
line 473
;473:				disableupdates( pl, -1 );	/* server-side flash */
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 3212836864
ARGF4
ADDRGP4 disableupdates
CALLV
pop
line 474
;474:			break;
ADDRGP4 $343
JUMPV
LABELV $342
line 464
LABELV $344
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 396
ARGI4
ADDRGP4 $345
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
NEU4 $341
LABELV $343
line 476
;475:		}
;476:		if ( !te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $353
line 477
;477:		{
line 478
;478:			G_conprintf( "Warning: Error in Flash Timer logic.\n" );
ADDRGP4 $355
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 479
;479:			pl->FlashTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1472
ADDP4
CNSTF4 0
ASGNF4
line 480
;480:		}
LABELV $353
line 481
;481:	}
LABELV $339
line 482
;482:	if ( pl->tfstate & TFSTATE_INFECTED )
ADDRFP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $356
line 483
;483:	{
line 484
;484:		healam = rint( pl->s.v.health / 2 );
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1073741824
DIVF4
ARGF4
ADDRLP4 16
ADDRGP4 rint
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 485
;485:		pl->tfstate -= ( pl->tfstate & TFSTATE_INFECTED );
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDRLP4 24
INDIRI4
CNSTI4 16
BANDI4
SUBI4
ASGNI4
line 486
;486:		tf_data.deathmsg = DMSG_MEDIKIT;
ADDRGP4 tf_data+88
CNSTI4 23
ASGNI4
line 487
;487:		T_Damage( pl, self, self, healam );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 488
;488:		return;
ADDRGP4 $291
JUMPV
LABELV $356
line 490
;489:	}
;490:	if ( pl->numflames > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CNSTI4 0
LEI4 $359
line 491
;491:	{
line 492
;492:		sound( pl, 1, "items/r_item1.wav", 1, 1 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $361
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
line 493
;493:		pl->numflames = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1396
ADDP4
CNSTI4 0
ASGNI4
line 494
;494:		return;
LABELV $359
line 496
;495:	}
;496:}
LABELV $291
endproc TG_Eff_Remove 32 20
import ConcPlayer
import FlashPlayer
import Detpack_SetClip
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
bss
export tg_data
align 4
LABELV tg_data
skip 68
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
LABELV $361
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 114
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $355
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 32
byte 1 108
byte 1 111
byte 1 103
byte 1 105
byte 1 99
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $345
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $338
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 84
byte 1 114
byte 1 97
byte 1 110
byte 1 113
byte 1 117
byte 1 105
byte 1 108
byte 1 105
byte 1 115
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 32
byte 1 108
byte 1 111
byte 1 103
byte 1 105
byte 1 99
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $325
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 72
byte 1 97
byte 1 108
byte 1 108
byte 1 117
byte 1 99
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 32
byte 1 108
byte 1 111
byte 1 103
byte 1 105
byte 1 99
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $322
byte 1 118
byte 1 95
byte 1 99
byte 1 115
byte 1 104
byte 1 105
byte 1 102
byte 1 116
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 59
byte 1 32
byte 1 98
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $308
byte 1 118
byte 1 95
byte 1 105
byte 1 100
byte 1 108
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $300
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $283
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $279
byte 1 71
byte 1 111
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $278
byte 1 71
byte 1 111
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $273
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
LABELV $262
byte 1 115
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $249
byte 1 115
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $236
byte 1 115
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 95
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $221
byte 1 83
byte 1 71
byte 1 95
byte 1 70
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $210
byte 1 116
byte 1 111
byte 1 103
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $201
byte 1 79
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $200
byte 1 79
byte 1 110
byte 1 0
align 1
LABELV $198
byte 1 83
byte 1 71
byte 1 95
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $187
byte 1 115
byte 1 103
byte 1 112
byte 1 112
byte 1 108
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $180
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 71
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $172
byte 1 116
byte 1 103
byte 1 95
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $167
byte 1 100
byte 1 116
byte 1 112
byte 1 98
byte 1 0
align 1
LABELV $162
byte 1 115
byte 1 103
byte 1 112
byte 1 112
byte 1 108
byte 1 0
align 1
LABELV $156
byte 1 115
byte 1 103
byte 1 95
byte 1 114
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $154
byte 1 109
byte 1 116
byte 1 102
byte 1 108
byte 1 50
byte 1 0
align 1
LABELV $150
byte 1 109
byte 1 116
byte 1 102
byte 1 108
byte 1 49
byte 1 0
align 1
LABELV $144
byte 1 115
byte 1 103
byte 1 95
byte 1 115
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $139
byte 1 115
byte 1 103
byte 1 95
byte 1 110
byte 1 101
byte 1 119
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $136
byte 1 111
byte 1 108
byte 1 100
byte 1 102
byte 1 0
align 1
LABELV $131
byte 1 109
byte 1 116
byte 1 102
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $126
byte 1 111
byte 1 108
byte 1 100
byte 1 109
byte 1 116
byte 1 102
byte 1 108
byte 1 0
align 1
LABELV $121
byte 1 102
byte 1 105
byte 1 120
byte 1 0
align 1
LABELV $116
byte 1 111
byte 1 108
byte 1 100
byte 1 0
align 1
LABELV $113
byte 1 110
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $112
byte 1 115
byte 1 103
byte 1 0
align 1
LABELV $102
byte 1 100
byte 1 112
byte 1 95
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $97
byte 1 100
byte 1 112
byte 1 95
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $92
byte 1 100
byte 1 112
byte 1 95
byte 1 100
byte 1 97
byte 1 0
align 1
LABELV $87
byte 1 117
byte 1 110
byte 1 108
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $82
byte 1 117
byte 1 110
byte 1 108
byte 1 95
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $77
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $72
byte 1 103
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $69
byte 1 53
byte 1 0
align 1
LABELV $65
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $62
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $54
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 95
byte 1 101
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $49
byte 1 115
byte 1 103
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 95
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $44
byte 1 115
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $39
byte 1 115
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 114
byte 1 101
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
LABELV $34
byte 1 115
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 95
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $31
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $27
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $23
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $20
byte 1 0
align 1
LABELV $19
byte 1 115
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $16
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $13
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $12
byte 1 115
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 0
