lit
align 4
LABELV menus
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 31
byte 4 0
byte 4 0
address Menu_Team
address Menu_Team_Input
byte 4 -1
byte 4 0
byte 4 0
address Menu_Class
address Menu_Class_Input
byte 4 31
byte 4 5
byte 4 0
address Menu_Drop
address Menu_Drop_Input
byte 4 0
byte 4 0
byte 4 4
address Menu_Intro
byte 4 0
byte 4 512
byte 4 0
byte 4 8
address Menu_ClassHelp
address Menu_ClassHelp_Input
byte 4 0
byte 4 0
byte 4 5
address Menu_ClassHelp2
byte 4 0
byte 4 0
byte 4 0
byte 4 5
address Menu_RepeatHelp
byte 4 0
byte 4 0
byte 4 0
byte 4 0
address Menu_NULL
byte 4 0
byte 4 0
byte 4 0
byte 4 0
address Menu_NULL
byte 4 0
byte 4 0
byte 4 0
byte 4 0
address Menu_NULL
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
address Menu_Spy
address Menu_Spy_Input
byte 4 -1
byte 4 0
byte 4 0
address Menu_Spy_Skin
address Menu_Spy_Skin_Input
byte 4 -1
byte 4 0
byte 4 0
address Menu_Spy_Color
address Menu_Spy_Color_Input
byte 4 -1
byte 4 0
byte 4 0
address Menu_Engineer
address Menu_Engineer_Input
byte 4 -1
byte 4 0
byte 4 0
address Menu_EngineerFix_Dispenser
address Menu_EngineerFix_Dispenser_Input
byte 4 -1
byte 4 0
byte 4 0
address Menu_EngineerFix_SentryGun
address Menu_EngineerFix_SentryGun_Input
byte 4 0
byte 4 0
byte 4 0
address Menu_NULL
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
address Menu_Dispenser
address Menu_Dispenser_Input
byte 4 -1
byte 4 0
byte 4 0
address Menu_Class
address Menu_Class_Input
byte 4 0
byte 4 0
byte 4 0
address Menu_NULL
byte 4 0
byte 4 0
byte 4 0
byte 4 0
address Menu_NULL
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
address Menu_BirthDay
address Menu_BirthDay_Input
byte 4 -1
byte 4 0
byte 4 0
address Menu_BirthDay
address Menu_BirthDay_Input
byte 4 -1
byte 4 0
byte 4 0
address Menu_BirthDay
address Menu_BirthDay_Input
byte 4 -1
byte 4 0
byte 4 0
address TG_Main_Menu
address TG_Main_Menu_Input
byte 4 -1
byte 4 0
byte 4 0
address TG_SGOptions_Menu
address TG_SGOptions_Menu_Input
byte 4 -1
byte 4 0
byte 4 0
address TG_Detpack_Menu
address TG_Detpack_Menu_Input
byte 4 -1
byte 4 0
byte 4 0
address TG_Cheats_Menu
address TG_Cheats_Menu_Input
byte 4 -1
byte 4 0
byte 4 0
address TG_SavePosition_Menu
address TG_SavePosition_Menu_Input
byte 4 -1
byte 4 0
byte 4 0
address TG_SG_Fire_Menu
address TG_SG_Fire_Menu_Input
byte 4 -1
byte 4 0
byte 4 0
address Menu_Yell
address Menu_Yell_Input
byte 4 -1
byte 4 0
byte 4 0
address Menu_Taunt
address Menu_Taunt_Input
byte 4 -1
byte 4 0
byte 4 0
address Menu_DropStuff
address Menu_DropStuff_Input
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
data
export NUM_menus
align 4
LABELV NUM_menus
byte 4 36
export Player_Menu
code
proc Player_Menu 16 4
file "..\src\menu.c"
line 129
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
;21: *  $Id: menu.c,v 1.26 2006/03/04 15:10:06 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:#include "sentry.h"
;25:
;26:typedef struct menu_s{
;27:	int     allowed_impulses;
;28:	int     reset_impulse;
;29:	int     display_time;
;30:	void    ( *Display ) ( menunum_t );
;31:	void    ( *Input ) ( int );
;32:} menu_t;
;33:
;34:void    Menu_NULL( menunum_t menu );
;35:void    Menu_Team( menunum_t );
;36:void    Menu_Team_Input( int );
;37:void    Menu_Class( menunum_t );
;38:void    Menu_Class_Input( int );
;39:void    Menu_Drop( menunum_t );
;40:void    Menu_Drop_Input( int );
;41:void    Menu_Intro( menunum_t );
;42:void    Menu_ClassHelp( menunum_t );
;43:void    Menu_ClassHelp2( menunum_t );
;44:void    Menu_ClassHelp_Input( int );
;45:void    Menu_RepeatHelp( menunum_t );
;46:void    Menu_Engineer( menunum_t );
;47:void    Menu_Engineer_Input( int inp );
;48:void    Menu_EngineerFix_Dispenser( menunum_t );
;49:void    Menu_EngineerFix_Dispenser_Input( int inp );
;50:void    Menu_EngineerFix_SentryGun( menunum_t );
;51:void    Menu_EngineerFix_SentryGun_Input( int inp );
;52:void    Menu_Dispenser( menunum_t );
;53:void    Menu_Dispenser_Input( int inp );
;54:void    Menu_Spy( menunum_t menu );
;55:void    Menu_Spy_Input( int inp );
;56:void    Menu_Spy_Skin( menunum_t menu );
;57:void    Menu_Spy_Skin_Input( int inp );
;58:void    Menu_Spy_Color( menunum_t menu );
;59:void    Menu_Spy_Color_Input( int inp );
;60:void    Menu_BirthDay( menunum_t menu );
;61:void    Menu_BirthDay_Input( int inp );
;62://mtf
;63:void	Menu_Yell_Input( int inp );
;64:void	Menu_Taunt_Input( int inp );
;65:void	Menu_Taunt( menunum_t menu );
;66:void	Menu_Yell( menunum_t menu );
;67:void	Menu_DropStuff( menunum_t menu );
;68:void	Menu_DropStuff_Input( int inp );
;69:
;70:void    TG_Main_Menu( menunum_t menu );
;71:void    TG_Main_Menu_Input( int inp );
;72:void    TG_SGOptions_Menu_Input( int inp );
;73:void    TG_SGOptions_Menu( menunum_t menu );
;74:void    TG_Detpack_Menu( menunum_t menu );
;75:void    TG_Detpack_Menu_Input( int inp );
;76:void    TG_Cheats_Menu( menunum_t menu );
;77:void    TG_Cheats_Menu_Input( int inp );
;78:void    TG_SavePosition_Menu( menunum_t menu );
;79:void    TG_SavePosition_Menu_Input( int inp );
;80:void    TG_SG_Fire_Menu_Input( int inp );
;81:void    TG_SG_Fire_Menu( menunum_t menu );
;82:
;83:const static menu_t menus[] = {
;84:	{0, 0, 0, NULL, NULL},	//MENU_NULL,                      
;85:	{0, 0, 0, NULL, NULL},	//MENU_DEFAULT,                 
;86:	{31, 0, 0, Menu_Team, Menu_Team_Input},	//MENU_TEAM,                    
;87:	{-1, 0, 0, Menu_Class, Menu_Class_Input},	//MENU_CLASS,                   
;88:	{31, 5, 0, Menu_Drop, Menu_Drop_Input},	//MENU_DROP,                    
;89:	{0, 0, 4, Menu_Intro, NULL},	//MENU_INTRO,                   
;90:	{512, 0, 8, Menu_ClassHelp, Menu_ClassHelp_Input},	//MENU_CLASSHELP,                      
;91:	{0, 0, 5, Menu_ClassHelp2, NULL},	//MENU_CLASSHELP2,              
;92:	{0, 0, 5, Menu_RepeatHelp, NULL},	//MENU_REPEATHELP,              
;93:	{0, 0, 0, Menu_NULL, NULL},	//MENU_PICKBINDS,                       
;94:	{0, 0, 0, Menu_NULL, NULL},	//MENU_SHOWBINDS1,              
;95:	{0, 0, 0, Menu_NULL, NULL},	//MENU_SHOWBINDS2,              
;96:	{-1, 0, 0, Menu_Spy, Menu_Spy_Input},	//MENU_SPY,                     
;97:	{-1, 0, 0, Menu_Spy_Skin, Menu_Spy_Skin_Input},	//MENU_SPY_SKIN,                        
;98:	{-1, 0, 0, Menu_Spy_Color, Menu_Spy_Color_Input},	//MENU_SPY_COLOR,                       
;99:	{-1, 0, 0, Menu_Engineer, Menu_Engineer_Input},	//MENU_ENGINEER,                        
;100:	{-1, 0, 0, Menu_EngineerFix_Dispenser,
;101:	 Menu_EngineerFix_Dispenser_Input},	//MENU_ENGINEER_FIX_DISPENSER,  
;102:	{-1, 0, 0, Menu_EngineerFix_SentryGun,
;103:	 Menu_EngineerFix_SentryGun_Input},	//MENU_ENGINEER_FIX_SENTRYGUN,
;104:	{0, 0, 0, Menu_NULL, NULL},	//MENU_ENGINEER_FIX_MORTAR,     
;105:	{-1, 0, 0, Menu_Dispenser, Menu_Dispenser_Input},	//MENU_DISPENSER,                       
;106:	{-1, 0, 0, Menu_Class, Menu_Class_Input},	//MENU_CHANGECLASS              
;107:	{0, 0, 0, Menu_NULL, NULL},	//21
;108:	{0, 0, 0, Menu_NULL, NULL},	//22
;109:	{-1, 0, 0, Menu_BirthDay, Menu_BirthDay_Input},	//MENU_BIRTHDAY1
;110:	{-1, 0, 0, Menu_BirthDay, Menu_BirthDay_Input},	//MENU_BIRTHDAY2
;111:	{-1, 0, 0, Menu_BirthDay, Menu_BirthDay_Input},	//MENU_BIRTHDAY3
;112:
;113:	{-1, 0, 0, TG_Main_Menu, TG_Main_Menu_Input},
;114:	{-1, 0, 0, TG_SGOptions_Menu, TG_SGOptions_Menu_Input},
;115:	{-1, 0, 0, TG_Detpack_Menu, TG_Detpack_Menu_Input},
;116:	{-1, 0, 0, TG_Cheats_Menu, TG_Cheats_Menu_Input},
;117:	{-1, 0, 0, TG_SavePosition_Menu, TG_SavePosition_Menu_Input},
;118:	{-1, 0, 0, TG_SG_Fire_Menu, TG_SG_Fire_Menu_Input},
;119:	{-1, 0, 0, Menu_Yell, Menu_Yell_Input},	//MENU_YELL,
;120:	{-1, 0, 0, Menu_Taunt, Menu_Taunt_Input},	//MENU_TAUNT,
;121:	{-1, 0, 0, Menu_DropStuff, Menu_DropStuff_Input},	//MENU_DROPSTUFF,
;122:
;123:	{0, 0, 0, NULL, NULL}
;124:};
;125:
;126:int     NUM_menus = sizeof( menus ) / sizeof( menus[0] );
;127:
;128:void Player_Menu(  )
;129:{
line 131
;130:
;131:	if ( self->menu_count > MENU_REFRESH_RATE )
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
INDIRI4
CNSTI4 25
LEI4 $12
line 132
;132:		self->menu_count = 0;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $13
JUMPV
LABELV $12
line 134
;133:	else
;134:	{
line 135
;135:		self->menu_count++;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 136
;136:		return;
ADDRGP4 $11
JUMPV
LABELV $13
line 139
;137:	}
;138:
;139:	if ( self->current_menu <= MENU_CLASS /*MENU_DEFAULT */  )
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
CNSTI4 3
GTI4 $14
line 140
;140:	{
line 141
;141:		if ( !self->team_no && teamplay && self->lives )
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $16
ADDRGP4 teamplay
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $16
ADDRLP4 0
INDIRP4
CNSTI4 964
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $16
line 142
;142:		{
line 143
;143:			self->current_menu = MENU_TEAM;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 2
ASGNI4
line 144
;144:		} else
ADDRGP4 $17
JUMPV
LABELV $16
line 145
;145:		{
line 146
;146:			if ( !self->playerclass && self->lives )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $18
ADDRLP4 8
INDIRP4
CNSTI4 964
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $18
line 147
;147:				self->current_menu = MENU_CLASS;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 3
ASGNI4
ADDRGP4 $19
JUMPV
LABELV $18
line 149
;148:			else
;149:			{
line 150
;150:				self->current_menu = MENU_DEFAULT;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 1
ASGNI4
line 151
;151:				return;
ADDRGP4 $11
JUMPV
LABELV $19
line 153
;152:			}
;153:		}
LABELV $17
line 154
;154:	}
LABELV $14
line 156
;155:
;156:	if ( self->current_menu >= NUM_menus )
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
ADDRGP4 NUM_menus
INDIRI4
LTI4 $20
line 157
;157:	{
line 158
;158:		self->current_menu = MENU_DEFAULT;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 1
ASGNI4
line 159
;159:		return;
ADDRGP4 $11
JUMPV
LABELV $20
line 162
;160:	}
;161:
;162:	if ( self->current_menu == MENU_DEFAULT )
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
CNSTI4 1
NEI4 $22
line 163
;163:	{
line 164
;164:		self->current_menu = MENU_NULL;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 0
ASGNI4
line 165
;165:		return;
ADDRGP4 $11
JUMPV
LABELV $22
line 168
;166:	}
;167:
;168:	if ( menus[self->current_menu].Display )
CNSTI4 20
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
MULI4
ADDRGP4 menus+12
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $24
line 169
;169:		menus[self->current_menu].Display( self->current_menu );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 20
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 menus+12
ADDP4
INDIRP4
CALLV
pop
LABELV $24
line 171
;170:
;171:	if ( menus[self->current_menu].display_time )
CNSTI4 20
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
MULI4
ADDRGP4 menus+8
ADDP4
INDIRI4
CNSTI4 0
EQI4 $28
line 172
;172:	{
line 173
;173:		if ( self->menu_displaytime > menus[self->current_menu].display_time )
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 956
ADDP4
INDIRI4
CNSTI4 20
ADDRLP4 4
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
MULI4
ADDRGP4 menus+8
ADDP4
INDIRI4
LEI4 $31
line 174
;174:			self->current_menu = MENU_DEFAULT;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 1
ASGNI4
ADDRGP4 $32
JUMPV
LABELV $31
line 176
;175:		else
;176:			self->menu_displaytime++;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 956
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $32
line 177
;177:	}
LABELV $28
line 178
;178:}
LABELV $11
endproc Player_Menu 16 4
export ResetMenu
proc ResetMenu 0 8
line 181
;179:
;180:void ResetMenu(  )
;181:{
line 182
;182:	if ( !self->StatusBarSize )
ADDRGP4 self
INDIRP4
CNSTI4 1488
ADDP4
INDIRI4
CNSTI4 0
NEI4 $35
line 183
;183:		CenterPrint( self, "\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $37
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $36
JUMPV
LABELV $35
line 185
;184:	else
;185:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
LABELV $36
line 186
;186:	self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 187
;187:	self->current_menu = MENU_DEFAULT;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 1
ASGNI4
line 188
;188:}
LABELV $34
endproc ResetMenu 0 8
export Menu_Input
proc Menu_Input 12 4
line 191
;189:
;190:void Menu_Input( int impulse )
;191:{
line 194
;192:	int     ai;
;193:
;194:	if ( menus[self->current_menu].Input == NULL )
CNSTI4 20
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
MULI4
ADDRGP4 menus+16
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $40
line 195
;195:		return;
ADDRGP4 $39
JUMPV
LABELV $40
line 196
;196:	if ( menus[self->current_menu].reset_impulse == impulse )
CNSTI4 20
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
MULI4
ADDRGP4 menus+4
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $43
line 197
;197:	{
line 198
;198:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 199
;199:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 200
;200:		return;
ADDRGP4 $39
JUMPV
LABELV $43
line 203
;201:	}
;202:
;203:	ai = menus[self->current_menu].allowed_impulses;
ADDRLP4 0
CNSTI4 20
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
MULI4
ADDRGP4 menus
ADDP4
INDIRI4
ASGNI4
line 205
;204:
;205:	if ( ai < 0 || ( ai & ( 1 << ( impulse ) ) ) )
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $48
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $46
LABELV $48
line 206
;206:	{
line 207
;207:		menus[self->current_menu].Input( impulse );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 20
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
MULI4
ADDRGP4 menus+16
ADDP4
INDIRP4
CALLV
pop
line 208
;208:	}
LABELV $46
line 209
;209:}
LABELV $39
endproc Menu_Input 12 4
data
export team_menu_strings
align 4
LABELV team_menu_strings
address $50
address $51
address $52
address $53
address $54
address $55
export Menu_Team
code
proc Menu_Team 12 28
line 222
;210:
;211:extern char *team_menu_string;
;212:const char *team_menu_strings[] = {
;213:	"              ",
;214:	"êìë Team One  ",
;215:	"êîë Team Two  ",
;216:	"êïë Team Three",
;217:	"êñë Team Four ",
;218:	"êóë Auto Team ",
;219:};
;220:
;221:void Menu_Team( menunum_t menu )
;222:{
line 223
;223:	if ( ( tf_data.toggleflags & TFLAG_AUTOTEAM ) && teamplay )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 tf_data
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 0
INDIRI4
EQI4 $57
ADDRGP4 teamplay
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $57
line 224
;224:	{
line 225
;225:		if ( TeamFortress_TeamPutPlayerInTeam(  ) )
ADDRLP4 4
ADDRGP4 TeamFortress_TeamPutPlayerInTeam
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $59
line 226
;226:			return;
ADDRGP4 $56
JUMPV
LABELV $59
line 227
;227:	}
LABELV $57
line 229
;228:
;229:	if ( team_menu_string )
ADDRGP4 team_menu_string
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $61
line 230
;230:	{
line 231
;231:		CenterPrint( self, "ÕÂÁ·‘∆†ê %s ë\n\n%s", MEGATF_VER, team_menu_string );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $63
ARGP4
ADDRGP4 $64
ARGP4
ADDRGP4 team_menu_string
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 232
;232:		return;
ADDRGP4 $56
JUMPV
LABELV $61
line 234
;233:	}
;234:	if ( CTF_Map == 1 )
ADDRGP4 CTF_Map
INDIRI4
CNSTI4 1
NEI4 $65
line 235
;235:		CenterPrint( self,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $67
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $66
JUMPV
LABELV $65
line 243
;236:			     "=== Choose Your Team ===\n\n"
;237:			     "êìë Blue Team           \n"
;238:			     "êîë Red Team            \n\n\n\n"
;239:			     "êôë Bind my keys for me!\n\n"
;240:			     "For full details on this patch:\n"
;241:			     "http://www.telefragged.com/teamfortress/\n" );
;242:	else
;243:	{
line 244
;244:		if ( number_of_teams == 1 )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 1
NEI4 $68
line 245
;245:			CenterPrint( self, "=== Choose Your Team ===\n\n%s\n",
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $70
ARGP4
ADDRGP4 team_menu_strings+4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $69
JUMPV
LABELV $68
line 248
;246:				     team_menu_strings[1] );
;247:		else
;248:			CenterPrint( self,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $72
ARGP4
ADDRGP4 team_menu_strings+4
INDIRP4
ARGP4
ADDRGP4 team_menu_strings+8
INDIRP4
ARGP4
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 2
LEI4 $78
ADDRLP4 4
CNSTI4 3
ASGNI4
ADDRGP4 $79
JUMPV
LABELV $78
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $79
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_menu_strings
ADDP4
INDIRP4
ARGP4
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 3
LEI4 $80
ADDRLP4 8
CNSTI4 4
ASGNI4
ADDRGP4 $81
JUMPV
LABELV $80
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $81
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_menu_strings
ADDP4
INDIRP4
ARGP4
ADDRGP4 team_menu_strings+20
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $69
line 254
;249:				     "=== Choose Your Team ===\n\n%s\n%s\n%s\n%s\n%s\n",
;250:				     team_menu_strings[1], team_menu_strings[2],
;251:				     team_menu_strings[( number_of_teams > 2 ) ? 3 : 0],
;252:				     team_menu_strings[( number_of_teams > 3 ) ? 4 : 0],
;253:				     team_menu_strings[5] );
;254:	}
LABELV $66
line 256
;255:
;256:}
LABELV $56
endproc Menu_Team 12 28
export Menu_Team_Input
proc Menu_Team_Input 4 4
line 259
;257:
;258:void Menu_Team_Input( int inp )
;259:{
line 261
;260:
;261:	if ( inp == 5 )
ADDRFP4 0
INDIRI4
CNSTI4 5
NEI4 $83
line 262
;262:		TeamFortress_TeamPutPlayerInTeam(  );
ADDRGP4 TeamFortress_TeamPutPlayerInTeam
CALLI4
pop
ADDRGP4 $84
JUMPV
LABELV $83
line 264
;263:	else
;264:	{
line 265
;265:		if ( inp <= number_of_teams && inp > 0 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRGP4 number_of_teams
INDIRI4
GTI4 $85
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $85
line 266
;266:			TeamFortress_TeamSet( inp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 TeamFortress_TeamSet
CALLI4
pop
ADDRGP4 $86
JUMPV
LABELV $85
line 268
;267:		else
;268:		{
line 269
;269:			if ( !number_of_teams && inp <= 4 )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 0
NEI4 $87
ADDRFP4 0
INDIRI4
CNSTI4 4
GTI4 $87
line 270
;270:				TeamFortress_TeamSet( inp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 TeamFortress_TeamSet
CALLI4
pop
LABELV $87
line 271
;271:		}
LABELV $86
line 272
;272:	}
LABELV $84
line 273
;273:	ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 274
;274:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 275
;275:}
LABELV $82
endproc Menu_Team_Input 4 4
data
export class_hdr
align 4
LABELV class_hdr
address $89
export class_str
align 4
LABELV class_str
address $90
export class_spy
align 4
LABELV class_spy
address $91
export class_eng
align 4
LABELV class_eng
address $92
export class_rpc
align 4
LABELV class_rpc
address $93
export class_bd
align 4
LABELV class_bd
address $94
export Menu_Class
code
proc Menu_Class 16 28
line 287
;276:
;277:const char *class_hdr = "=== Choose Your Class ===";
;278:const char *class_str = "êìë Scout   \n"
;279:    "êîë Sniper  \n" "êïë Soldier \n" "êñë Demoman \n" "êóë Medic   \n" "êòë HWGuy   \n"
;280:    "êôë Pyro    \n";
;281:const char *class_spy = "êöë Spy     \n";
;282:const char *class_eng = "êõë Engineer\n";
;283:const char *class_rpc = "êíë RandomPC\n";
;284:const char *class_bd = "êíë The Birthday Boy\n";
;285:
;286:void Menu_Class( menunum_t menu )
;287:{
line 290
;288:	gedict_t *AD;
;289:
;290:	AD = trap_find( world, FOFS( s.v.classname ), "info_tfdetect" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $96
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 291
;291:	if ( AD )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $97
line 292
;292:	{
line 293
;293:		switch ( self->team_no )
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $99
ADDRLP4 8
INDIRI4
CNSTI4 4
GTI4 $99
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $114-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $114
address $102
address $105
address $108
address $111
code
line 294
;294:		{
LABELV $102
line 296
;295:		case 1:
;296:			if ( AD->s.v.noise1 )
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $100
line 297
;297:			{
line 298
;298:				CenterPrint( self, AD->s.v.noise1 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 299
;299:				return;
ADDRGP4 $95
JUMPV
line 301
;300:			}
;301:			break;
LABELV $105
line 303
;302:		case 2:
;303:			if ( AD->s.v.noise2 )
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $100
line 304
;304:			{
line 305
;305:				CenterPrint( self, AD->s.v.noise2 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 306
;306:				return;
ADDRGP4 $95
JUMPV
line 308
;307:			}
;308:			break;
LABELV $108
line 310
;309:		case 3:
;310:			if ( AD->s.v.noise3 )
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $100
line 311
;311:			{
line 312
;312:				CenterPrint( self, AD->s.v.noise3 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 313
;313:				return;
ADDRGP4 $95
JUMPV
line 315
;314:			}
;315:			break;
LABELV $111
line 317
;316:		case 4:
;317:			if ( AD->noise4 )
ADDRLP4 0
INDIRP4
CNSTI4 680
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $100
line 318
;318:			{
line 319
;319:				CenterPrint( self, AD->noise4 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 680
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 320
;320:				return;
ADDRGP4 $95
JUMPV
line 322
;321:			}
;322:			break;
LABELV $99
LABELV $100
line 325
;323:
;324:		}
;325:	}
LABELV $97
line 326
;326:	if ( TeamFortress_TeamIsCivilian( self->team_no ) )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 TeamFortress_TeamIsCivilian
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $116
line 327
;327:	{
line 328
;328:		CenterPrint( self, "Your team can only be Civilians.\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $118
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 329
;329:		return;
ADDRGP4 $95
JUMPV
LABELV $116
line 331
;330:	}
;331:	if ( tf_data.spy_off == 1 )
ADDRGP4 tf_data+40
INDIRI4
CNSTI4 1
NEI4 $119
line 332
;332:	{
line 333
;333:		CenterPrint( self, "%s\n\n%s%s%s", class_hdr, class_str, class_eng,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $122
ARGP4
ADDRGP4 class_hdr
INDIRP4
ARGP4
ADDRGP4 class_str
INDIRP4
ARGP4
ADDRGP4 class_eng
INDIRP4
ARGP4
ADDRGP4 class_rpc
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 335
;334:			     class_rpc );
;335:		return;
ADDRGP4 $95
JUMPV
LABELV $119
line 337
;336:	}
;337:	if ( tf_data.birthday == 1 )
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $123
line 338
;338:	{
line 339
;339:		CenterPrint( self, "%s\n\n%s%s%s%s", class_hdr, class_str, class_spy,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $126
ARGP4
ADDRGP4 class_hdr
INDIRP4
ARGP4
ADDRGP4 class_str
INDIRP4
ARGP4
ADDRGP4 class_spy
INDIRP4
ARGP4
ADDRGP4 class_eng
INDIRP4
ARGP4
ADDRGP4 class_bd
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 341
;340:			     class_eng, class_bd );
;341:		return;
ADDRGP4 $95
JUMPV
LABELV $123
line 343
;342:	}
;343:	CenterPrint( self, "%s\n\n%s%s%s%s", class_hdr, class_str, class_spy, class_eng,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $126
ARGP4
ADDRGP4 class_hdr
INDIRP4
ARGP4
ADDRGP4 class_str
INDIRP4
ARGP4
ADDRGP4 class_spy
INDIRP4
ARGP4
ADDRGP4 class_eng
INDIRP4
ARGP4
ADDRGP4 class_rpc
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 345
;344:		     class_rpc );
;345:}
LABELV $95
endproc Menu_Class 16 28
export Menu_Class_Input
proc Menu_Class_Input 8 0
line 348
;346:
;347:void Menu_Class_Input( int imp )
;348:{
line 349
;349:	int     new_class = 0;	//, opt;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 353
;350:
;351:	//char    st[10];
;352:
;353:	if ( imp > 10 && imp < 1 )
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 10
LEI4 $128
ADDRLP4 4
INDIRI4
CNSTI4 1
GEI4 $128
line 354
;354:		return;
ADDRGP4 $127
JUMPV
LABELV $128
line 355
;355:	self->s.v.impulse = imp + TF_CHANGEPC;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
ADDRFP4 0
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
line 356
;356:	if ( self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $130
line 357
;357:		new_class = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $130
line 358
;358:	TeamFortress_ChangeClass(  );
ADDRGP4 TeamFortress_ChangeClass
CALLV
pop
line 359
;359:	ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 360
;360:	if ( self->playerclass && new_class != 1 )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $132
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $132
line 361
;361:	{
line 363
;362:
;363:		if ( self->settings_bits & TF_CLASS_HELP_MASK )
ADDRGP4 self
INDIRP4
CNSTI4 1524
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $134
line 364
;364:			self->current_menu = MENU_CLASSHELP;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 6
ASGNI4
LABELV $134
line 365
;365:	}
LABELV $132
line 366
;366:	self->menu_displaytime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 956
ADDP4
CNSTI4 0
ASGNI4
line 367
;367:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 368
;368:}
LABELV $127
endproc Menu_Class_Input 8 0
export Menu_Drop
proc Menu_Drop 0 8
line 371
;369:
;370:void Menu_Drop( menunum_t menu )
;371:{
line 372
;372:	if ( self->playerclass == PC_ENGINEER )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
NEI4 $137
line 373
;373:		CenterPrint( self, "Drop or Make:                   \n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $139
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $138
JUMPV
LABELV $137
line 380
;374:			     "êìë Shells                      \n"
;375:			     "êîë Nails                       \n"
;376:			     "êïë Rockets                     \n"
;377:			     "êñë Cells                       \n"
;378:			     "êóë Nothing                     \n\n" );
;379:	else
;380:		CenterPrint( self, "Drop:                           \n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $140
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $138
line 387
;381:			     "êìë Shells                      \n"
;382:			     "êîë Nails                       \n"
;383:			     "êïë Rockets                     \n"
;384:			     "êñë Cells                       \n"
;385:			     "êóë Nothing                     \n\n" );
;386:
;387:}
LABELV $136
endproc Menu_Drop 0 8
export Menu_Drop_Input
proc Menu_Drop_Input 8 4
line 391
;388:
;389:void    TeamFortress_DropAmmo( int type );
;390:void Menu_Drop_Input( int inp )
;391:{
line 392
;392:	if ( inp > 0 && inp < 5 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $142
ADDRLP4 0
INDIRI4
CNSTI4 5
GEI4 $142
line 393
;393:		TeamFortress_DropAmmo( inp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 TeamFortress_DropAmmo
CALLV
pop
LABELV $142
line 394
;394:	if ( inp > 0 && inp < 6 )
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $144
ADDRLP4 4
INDIRI4
CNSTI4 6
GEI4 $144
line 395
;395:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
LABELV $144
line 396
;396:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 397
;397:}
LABELV $141
endproc Menu_Drop_Input 8 4
export Menu_Intro
proc Menu_Intro 2052 20
line 400
;398:
;399:void Menu_Intro( menunum_t menu )
;400:{
line 403
;401:	char    st1[1024], st2[1024];
;402:
;403:	if ( GetSVInfokeyString( "motd1", NULL, st1, sizeof( st1 ), "" ) )
ADDRGP4 $149
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $150
ARGP4
ADDRLP4 2048
ADDRGP4 GetSVInfokeyString
CALLI4
ASGNI4
ADDRLP4 2048
INDIRI4
CNSTI4 0
EQI4 $147
line 404
;404:	{
line 405
;405:		GetSVInfokeyString( "motd2", NULL, st2, sizeof( st2 ), "" );
ADDRGP4 $151
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $150
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 406
;406:		CenterPrint( self, "%s\n%s", st1, st2 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1024
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 407
;407:	} else
ADDRGP4 $148
JUMPV
LABELV $147
line 408
;408:		CenterPrint( self, "Welcome to ÕÂÁ·‘∆†êv2006-Cë\n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $153
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $148
line 413
;409:			     "C code by êsdë angel for Õ‘∆Ã\n"
;410:				 "MTF-C code by ÿavio“\n"
;411:			     "======================================\n"
;412:			     "http://www.amnesiagames.com\n" );
;413:}
LABELV $146
endproc Menu_Intro 2052 20
data
export classhelp1
align 4
LABELV classhelp1
address $150
address $154
address $155
address $156
address $157
address $158
address $159
address $160
address $161
address $162
export classhelp2
align 4
LABELV classhelp2
address $150
address $163
address $164
address $165
address $166
address $167
address $168
address $169
address $170
address $171
export class_stuffcmd
align 4
LABELV class_stuffcmd
address $150
address $172
address $173
address $174
address $175
address $176
address $177
address $178
address $179
address $180
export Menu_ClassHelp
code
proc Menu_ClassHelp 36 16
line 490
;414:
;415:const char *classhelp1[] = {
;416:	"",
;417:	"¡…“”√œ’‘ ç player details:\n"		// scout
;418:		"†˜Â·ÔÓÛ∫†††††††††††††††††\n"
;419:		"  êìë axe                 \n  êîë shotgun             \n  êñë mac-10              \n"
;420:		" ÁÚÂÓ·‰ÂÛ∫††††††††††††    \n  +grenì∫ flash grenade   \n  +grenî∫ conc grenade    \n†‰ÚÔÛ∫                   \n  dropì∫†flash mine       \n  dropï∫†disarm detpack   \n†„ÔÌÌ·Ó‰Û∫††††††††††     †\n  special∫ jetpack boost  \n",
;421:
;422:	"”Œ…–≈“ ç player details:  \n†˜Â·ÔÓÛ∫†††††††††††††††††\n  êìë axe                 \n  êîë sniper rifle        \n  êïë auto rifle          \n ÁÚÂÓ·‰ÂÛ∫††††††††††††    \n  +grenì∫ normal grenade  \n  +grenî∫ flare           \n†‰ÚÔÛ∫                   \n  dropì∫†alarm            \n  dropï∫ call airstrike   \n†„ÔÌÌ·Ó‰Û∫††††††††††     †\n  special∫ autozoom       \n",
;423:
;424:	"”œÃƒ…≈“ ç player  details:\n†˜Â·ÔÓÛ∫†††††††††††††††††\n  êìë axe                 \n  êîë shotgun             \n  êïë super shotgun       \n† êôë rocket launcher     \n ÁÚÂÓ·‰ÂÛ∫††††††††††††    \n  +grenì∫ normal grenade  \n  +grenî∫ nail grenade    \n†‰ÚÔÛ∫                   \n  dropì∫†spike trap       \n  dropï∫ proximity grenade\n†„ÔÌÌ·Ó‰Û∫††††††††††     †\n  special∫ reload         \n",
;425:
;426:	"ƒ≈ÕœÕ¡Œ ç player details: \n†˜Â·ÔÓÛ∫†††††††††††††††††\n  êìë axe                 \n  êîë shotgun             \n  êóë long-range gren.    \n  êòë grenade launcher    \n  êôë pipebomb launcher   \n ÁÚÂÓ·‰ÂÛ∫††††††††††††    \n  +grenì∫ normal grenade  \n  +grenî∫ MIRV grenade    \n†‰ÚÔÛ∫                   \n  dropì∫†launch airMIRV   \n†„ÔÌÌ·Ó‰Û∫††††††††††     †\n  special∫ detonate pipes \n  detó∫† 5 second detpack \n  detîí∫†20 second detpack\n  detóí∫†50 second detpack\n",
;427:
;428:	"Õ≈ƒ…√ ç player details:   \n†˜Â·ÔÓÛ∫†††††††††††††††††\n  êìë bioaxe              \n  êîë shotgun             \n  êïë super shotgun       \n  êóë super nailgun       \n ÁÚÂÓ·‰ÂÛ∫††††††††††††    \n  +grenì∫ normal grenade  \n  +grenî∫ conc grenade    \n†‰ÚÔÛ∫                   \n  dropì∫†infected syringe \n  dropï∫ heal self        \n",
;429:
;430:	"»◊«’Ÿ ç player details:   \n†˜Â·ÔÓÛ∫†††††††††††††††††\n  êìë axe                 \n  êîë shotgun             \n  êïë super shotgun       \n  êôë assault cannon      \n  êôë 20mm cannon         \n ÁÚÂÓ·‰ÂÛ∫††††††††††††    \n  +grenì∫ normal grenade  \n  +grenî∫ MIRV grenade    \n†‰ÚÔÛ∫                   \n  dropì∫†spike trap       \n",
;431:
;432:	"–Ÿ“œ ç player details:    \n†˜Â·ÔÓÛ∫†††††††††††††††††\n  êìë axe                 \n  êîë shotgun             \n  êòë flame-thrower       \n  êôë incendiary cannon   \n ÁÚÂÓ·‰ÂÛ∫††††††††††††    \n  +grenì∫ normal grenade  \n  +grenî∫ napalm grenade  \n†‰ÚÔÛ∫                   \n  dropì∫†lava pool        \n",
;433:
;434:	"”–Ÿ ç player details:     \n†˜Â·ÔÓÛ∫†††††††††††††††††\n  êìë blade               \n  êîë tranquilizer gun    \n  êïë super shotgun       \n  êñë mac-10              \n  êöë grappling hook      \n ÁÚÂÓ·‰ÂÛ∫††††††††††††    \n  +grenì∫ normal grenade  \n  +grenî∫ gas grenade     \n†‰ÚÔÛ∫                   \n  dropì∫†ammo trap        \n†„ÔÌÌ·Ó‰Û∫                \n  special∫ disguise menu  \n",
;435:
;436:	"≈Œ«…Œ≈≈“ ç player details:\n†˜Â·ÔÓÛ∫†††††††††††††††††\n  êìë wrench              \n  êîë laser gun           \n  êïë super shotgun       \n ÁÚÂÓ·‰ÂÛ∫††††††††††††    \n  +grenì∫ normal grenade  \n  +grenî∫ EMP grenade     \n†‰ÚÔÛ∫                   \n  dropì∫†magnet mine      \n  dropï∫†laser drone      \n†„ÔÌÌ·Ó‰Û∫                \n  special∫ build menu     \n  dropammo∫ make ammo menu\n"
;437:};
;438:const char *classhelp2[] = {
;439:	"",
;440:	"«“≈Œ¡ƒ≈”:            \nFlash Grenade       \nConcussion Grenade  \n\n”–≈√…¡Ã √œÕÕ¡Œƒ”:   \nScanner: scan10,scan50,scan250\nJetJump: jetjump\ndrop1 :  drop a Flash mine\n\n\nPress ö for alias help\n",
;441:	"«“≈Œ¡ƒ≈”:            \nHand Grenade        \nFlare               \n\n”–≈√…¡Ã √œÕÕ¡Œƒ”:   \nautozoom : Toggle Rifle Autozooming\nSet an Alarm   : drop1  \n  Call AirStrike : airstrike\n  SpotLight    : +spot  \n\nPress ö for alias help\n",
;442:	"«“≈Œ¡ƒ≈”:            \nHand Grenade        \nNail Grenade        \n\n”–≈√…¡Ã √œÕÕ¡Œƒ”:   \nDrop a Spike Trap   : Drop1\ndrop3 : Set a ProxiMine!     \n\n\nPress ö for alias help\n",
;443:	"«“≈Œ¡ƒ≈”:            \nHand Grenade        \nMirv Grenade        \n\n”–≈√…¡Ã √œÕÕ¡Œƒ”:   \nThe Detpack : det5,det20,det50\nDetonate Pipebombs : detpipe  \nAir-MIRV      : drop1      \n\nPress ö for alias help\n",
;444:	"«“≈Œ¡ƒ≈”:            \nHand Grenade        \nConcussion Grenade  \n\n”–≈√…¡Ã √œÕÕ¡Œƒ”:   \nHeal Yourself : drop3 or heal\n\n\nPress ö for alias help\n",
;445:	"«“≈Œ¡ƒ≈”:            \nHand Grenade        \nMirv Grenade        \n\n”–≈√…¡Ã √œÕÕ¡Œƒ”:   \nSet an Spike Trap : drop1  \n\n\nPress ö for alias help\n",
;446:	"«“≈Œ¡ƒ≈”:            \nHand Grenade        \nNapalm Grenade      \n\n”–≈√…¡Ã √œÕÕ¡Œƒ”:   \nDrop a lava pool  : drop1  \n\n\nPress ö for alias help\n",
;447:	"«“≈Œ¡ƒ≈”:            \nHand Grenade        \nHallucinogen Grenade\n\n”–≈√…¡Ã √œÕÕ¡Œƒ”:   \nGo Undercover : disguise\nSet an Ammo Trap : drop1  \n\nPress ö for alias help\n",
;448:	"«“≈Œ¡ƒ≈”:            \nHand Grenade        \nEMP Grenade         \n\n”–≈√…¡Ã √œÕÕ¡Œƒ”:   \nStart Building : build  \n    Set a Mag Trap : drop1  \n\n\nPress ö for alias help\n"
;449:};
;450:char   *class_stuffcmd[] = {
;451:	"",
;452:
;453:	"”√œ’‘ Details:\n◊≈¡–œŒ”:\n   2.. Shotgun\n   4.. MAC-10 \n"
;454:		"«“≈Œ¡ƒ≈”:\n   Concussion Grenade\n   Flare\n”–≈√…¡Ã √œÕÕ¡Œƒ”:\n"
;455:		"Scanner: scan10,scan30,scan100\nJetJump: jetjump\ndrop1 :  drop a Flash mine\n\n\n",
;456:
;457:	"”Œ…–≈“ Details:\n\n◊≈¡–œŒ”:\n   2.. Sniper Rifle/Auto Rifle\n"
;458:		"4.. MAC-10 \n«“≈Œ¡ƒ≈”:\n   Hand Grenade\n\n\n”–≈√…¡Ã √œÕÕ¡Œƒ”:\n"
;459:		"  autozoom : Toggle Scope Autozooming\n  drop1 : drop an alarm mine\nairstrike : call an AirStrike\n +spot : Toggle SpotLight \n\n",
;460:
;461:	"”œÃƒ…≈“ Details:\n\n◊≈¡–œŒ”:\n   2.. Shotgun\n   3.. Super Shotgun\n"
;462:		"   7.. Rocket Launcher\n«“≈Œ¡ƒ≈”:\n   Hand Grenade\n   Nail Grenade\n"
;463:		"”–≈√…¡Ã √œÕÕ¡Œƒ”:\n  drop1 : Drop a Spike Trap  \n  drop3 : Set a ProxiMine!   \n\n\n",
;464:
;465:	"ƒ≈ÕœÃ…‘…œŒ” Õ¡Œ Details:\n\n◊≈¡–œŒ”:\n   2.. Shotgun\n   5.. Long-range Grenades     \n6.. Grenade Launcher      \n7..Pipebomb Launcher\n"
;466:		"«“≈Œ¡ƒ≈”:\n   Hand Grenade\n   Mirv Grenade\n"
;467:		"”–≈√…¡Ã √œÕÕ¡Œƒ”:\n   The Detpack : det5,det20,det50\n   Detonate Pipebombs : detpipe\n  drop1 : release an AirMIRV      \n\n",
;468:
;469:	"Õ≈ƒ…√ Details:\n\n◊≈¡–œŒ”:\n   1.. Medikit/BioWeapon\n   2.. Shotgun\n   3.. Super Shotgun\n"
;470:		"   5.. Super Nailgun\n«“≈Œ¡ƒ≈”:\n   Hand Grenade\n   Concussion Grenade\n"
;471:		"”–≈√…¡Ã √œÕÕ¡Œƒ”:\n   Drop1 : drop an infected syringe\n\n\n",
;472:
;473:	"»≈¡÷Ÿ ◊≈¡–œŒ” «’Ÿ Details:\n\n◊≈¡–œŒ”:\n   2.. Shotgun\n   3.. Super Shotgun\n"
;474:		"   7.. Assault Cannon\n«“≈Œ¡ƒ≈”:\n   Hand Grenade\n"
;475:		"   Mirv Grenade\n”–≈√…¡Ã √œÕÕ¡Œƒ”:\n  drop1 : set a spike trap\n\n\n",
;476:
;477:	"–Ÿ“œ Details:\n\n◊≈¡–œŒ”:\n   2.. Shotgun\n   6.. Flamethrower\n   7.. Incendiary Cannon\n"
;478:		"«“≈Œ¡ƒ≈”:\n   Hand Grenade\n   Napalm Grenade\n"
;479:		"”–≈√…¡Ã √œÕÕ¡Œƒ”:\n   None\n\n\n",
;480:
;481:	"”–Ÿ Details:\n\n◊≈¡–œŒ”:\n   2.. Tranquiliser Gun\n   3.. Super Shotgun\n   4.. MAC-10 \n   8.. Grapple Hook \n"
;482:		"«“≈Œ¡ƒ≈”:\n   Hand Grenade\n   Hallucinogenic Grenade\n"
;483:		"”–≈√…¡Ã √œÕÕ¡Œƒ”:\n   Go Undercover : disguise\n  drop1 : drop an Ammo Trap\n\n",
;484:
;485:	"≈Œ«…Œ≈≈“ Details:\n\n◊≈¡–œŒ”:\n   1.. Spanner\n   2.. RailGun\n   3.. Super Shotgun\n"
;486:		"«“≈Œ¡ƒ≈”:\n   Hand Grenade\n   EMP Grenade\n"
;487:		"”–≈√…¡Ã √œÕÕ¡Œƒ”:\n   Start Building : build\n      Set a Mag Trap : drop1   \n\n\n"
;488:};
;489:void Menu_ClassHelp( menunum_t menu )
;490:{
line 493
;491:	char usehelp[10];
;492:
;493:	infokey( self, "tf_help", usehelp, sizeof( usehelp ) );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $182
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 infokey
CALLV
pop
line 494
;494:	if ( !strcmp( usehelp, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $185
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $183
line 495
;495:		return;
ADDRGP4 $181
JUMPV
LABELV $183
line 496
;496:	if ( self->playerclass < 1 || self->playerclass > 9 )
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $188
ADDRLP4 16
INDIRI4
CNSTI4 9
LEI4 $186
LABELV $188
line 497
;497:		return;
ADDRGP4 $181
JUMPV
LABELV $186
line 498
;498:	if ( self->menu_displaytime < 5 )
ADDRGP4 self
INDIRP4
CNSTI4 956
ADDP4
INDIRI4
CNSTI4 5
GEI4 $189
line 499
;499:		CenterPrint( self, classhelp1[self->playerclass] );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 classhelp1
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $190
JUMPV
LABELV $189
line 501
;500:	else
;501:		CenterPrint( self, classhelp2[self->playerclass] );
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 classhelp2
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $190
line 503
;502:
;503:	if ( self->menu_displaytime > menus[menu].display_time )
ADDRGP4 self
INDIRP4
CNSTI4 956
ADDP4
INDIRI4
CNSTI4 20
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 menus+8
ADDP4
INDIRI4
LEI4 $191
line 504
;504:		G_sprint( self, 2, class_stuffcmd[self->playerclass] );
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
CNSTI4 2
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
LSHI4
ADDRGP4 class_stuffcmd
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $191
line 505
;505:}
LABELV $181
endproc Menu_ClassHelp 36 16
export Menu_ClassHelp_Input
proc Menu_ClassHelp_Input 0 4
line 508
;506:
;507:void Menu_ClassHelp_Input( int inp )
;508:{
line 509
;509:	if ( inp == 8 )
ADDRFP4 0
INDIRI4
CNSTI4 8
NEI4 $195
line 510
;510:	{
line 511
;511:		Menu_ClassHelp2( MENU_CLASSHELP2 );
CNSTI4 7
ARGI4
ADDRGP4 Menu_ClassHelp2
CALLV
pop
line 512
;512:		self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 513
;513:		self->current_menu = MENU_CLASSHELP2;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 7
ASGNI4
line 514
;514:		self->menu_displaytime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 956
ADDP4
CNSTI4 0
ASGNI4
line 515
;515:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 516
;516:	}
LABELV $195
line 517
;517:}
LABELV $194
endproc Menu_ClassHelp_Input 0 4
export Menu_ClassHelp2
proc Menu_ClassHelp2 8 12
line 519
;518:void Menu_ClassHelp2( menunum_t menu )
;519:{
line 520
;520:	CenterPrint( self, "Commands:\n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $198
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 526
;521:		     "inv       : Show inventory \n"
;522:		     "+gren1    : Throw grenade 1\n"
;523:		     "+gren2    : Throw Grenade 2\n"
;524:		     "reload    : Force a reload \n" "dropammo  : drop some ammo \n\n" );
;525:
;526:	if ( self->menu_displaytime > menus[menu].display_time )
ADDRGP4 self
INDIRP4
CNSTI4 956
ADDP4
INDIRI4
CNSTI4 20
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 menus+8
ADDP4
INDIRI4
LEI4 $199
line 527
;527:		G_sprint( self, 2, class_stuffcmd[self->playerclass] );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
CNSTI4 2
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
LSHI4
ADDRGP4 class_stuffcmd
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $199
line 528
;528:}
LABELV $197
endproc Menu_ClassHelp2 8 12
export Menu_RepeatHelp
proc Menu_RepeatHelp 0 8
line 531
;529:
;530:void Menu_RepeatHelp( menunum_t menu )
;531:{
line 532
;532:	CenterPrint( self, "Press ö to see this help again\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $203
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 533
;533:	self->current_menu = MENU_DEFAULT;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 1
ASGNI4
line 534
;534:}
LABELV $202
endproc Menu_RepeatHelp 0 8
data
export menu_eng_header
align 4
LABELV menu_eng_header
address $204
export menu_eng_builddisp
align 4
LABELV menu_eng_builddisp
address $205
export menu_eng_buildsentry
align 4
LABELV menu_eng_buildsentry
address $206
export menu_eng_exit
align 4
LABELV menu_eng_exit
address $207
export menu_eng_detdisp
align 4
LABELV menu_eng_detdisp
address $208
export menu_eng_detsentry
align 4
LABELV menu_eng_detsentry
address $209
export Menu_Engineer
code
proc Menu_Engineer 16 32
line 545
;535:
;536:const char *menu_eng_header = "Action:                           \n";
;537:const char *menu_eng_builddisp = "êìë Build Ammo&Armor Dispenser   \n";
;538:const char *menu_eng_buildsentry = "êîë Build Sentry Gun             \n";
;539:const char *menu_eng_exit = "êóë Nothing                      \n\n";
;540:const char *menu_eng_detdisp = "êôë Remotely Detonate Dispenser  \n";
;541:const char *menu_eng_detsentry = "êöë Remotely Detonate Sentry Gun \n";
;542:
;543:
;544:void Menu_Engineer( menunum_t menu )
;545:{
line 546
;546:	const char *s_bdisp = "", *s_detdisp = "", *s_bsentry = "", *s_detsentry = "";
ADDRLP4 0
ADDRGP4 $150
ASGNP4
ADDRLP4 4
ADDRGP4 $150
ASGNP4
ADDRLP4 8
ADDRGP4 $150
ASGNP4
ADDRLP4 12
ADDRGP4 $150
ASGNP4
line 548
;547:
;548:	if ( self->has_dispenser )
ADDRGP4 self
INDIRP4
CNSTI4 996
ADDP4
INDIRI4
CNSTI4 0
EQI4 $211
line 549
;549:	{
line 550
;550:		s_detdisp = menu_eng_detdisp;
ADDRLP4 4
ADDRGP4 menu_eng_detdisp
INDIRP4
ASGNP4
line 551
;551:		if ( tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $213
line 552
;552:			s_bdisp = menu_eng_builddisp;
ADDRLP4 0
ADDRGP4 menu_eng_builddisp
INDIRP4
ASGNP4
ADDRGP4 $212
JUMPV
LABELV $213
line 554
;553:		else
;554:			s_bdisp = "";
ADDRLP4 0
ADDRGP4 $150
ASGNP4
line 555
;555:	} else
ADDRGP4 $212
JUMPV
LABELV $211
line 556
;556:	{
line 558
;557:
;558:		if ( ( self->s.v.ammo_cells < BUILD_COST_DISPENSER )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1120403456
GEF4 $215
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
NEI4 $215
line 560
;559:		     && !tg_data.tg_enabled )
;560:			s_bdisp = "\n";
ADDRLP4 0
ADDRGP4 $37
ASGNP4
ADDRGP4 $216
JUMPV
LABELV $215
line 562
;561:		else
;562:			s_bdisp = menu_eng_builddisp;
ADDRLP4 0
ADDRGP4 menu_eng_builddisp
INDIRP4
ASGNP4
LABELV $216
line 564
;563:
;564:		s_detdisp = "";
ADDRLP4 4
ADDRGP4 $150
ASGNP4
line 565
;565:	}
LABELV $212
line 567
;566:
;567:	if ( self->has_sentry )
ADDRGP4 self
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
CNSTI4 0
EQI4 $217
line 568
;568:	{
line 569
;569:		s_detsentry = menu_eng_detsentry;
ADDRLP4 12
ADDRGP4 menu_eng_detsentry
INDIRP4
ASGNP4
line 570
;570:		if ( tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $219
line 571
;571:			s_bsentry = menu_eng_buildsentry;
ADDRLP4 8
ADDRGP4 menu_eng_buildsentry
INDIRP4
ASGNP4
ADDRGP4 $218
JUMPV
LABELV $219
line 573
;572:		else
;573:			s_bsentry = "";
ADDRLP4 8
ADDRGP4 $150
ASGNP4
line 574
;574:	} else
ADDRGP4 $218
JUMPV
LABELV $217
line 575
;575:	{
line 576
;576:		if ( ( self->s.v.ammo_cells < BUILD_COST_SENTRYGUN )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1124204544
GEF4 $221
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
NEI4 $221
line 578
;577:		     && !tg_data.tg_enabled )
;578:			s_bsentry = "\n";
ADDRLP4 8
ADDRGP4 $37
ASGNP4
ADDRGP4 $222
JUMPV
LABELV $221
line 580
;579:		else
;580:			s_bsentry = menu_eng_buildsentry;
ADDRLP4 8
ADDRGP4 menu_eng_buildsentry
INDIRP4
ASGNP4
LABELV $222
line 582
;581:
;582:		s_detsentry = "";
ADDRLP4 12
ADDRGP4 $150
ASGNP4
line 583
;583:	}
LABELV $218
line 585
;584:
;585:	CenterPrint( self, "%s%s%s%s%s%s", menu_eng_header, s_bdisp, s_detdisp, s_bsentry,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $223
ARGP4
ADDRGP4 menu_eng_header
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 menu_eng_exit
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 587
;586:		     s_detsentry, menu_eng_exit );
;587:}
LABELV $210
endproc Menu_Engineer 16 32
export Menu_Engineer_Input
proc Menu_Engineer_Input 16 20
line 590
;588:
;589:void Menu_Engineer_Input( int inp )
;590:{
line 591
;591:	switch ( inp )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $225
ADDRLP4 0
INDIRI4
CNSTI4 8
GTI4 $225
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $252-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $252
address $227
address $236
address $225
address $225
address $251
address $225
address $243
address $247
code
line 592
;592:	{
LABELV $227
line 594
;593:	case 1:
;594:		if ( !( ( int ) self->s.v.flags & FL_ONGROUND ) )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $228
line 595
;595:		{
line 596
;596:			CenterPrint( self, "You can't build in the air!\n\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $230
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 597
;597:			ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 598
;598:			self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 599
;599:			return;
ADDRGP4 $224
JUMPV
LABELV $228
line 601
;600:		}
;601:		if ( ( self->s.v.ammo_cells >= BUILD_COST_DISPENSER
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1120403456
LTF4 $234
ADDRLP4 4
INDIRP4
CNSTI4 996
ADDP4
INDIRI4
CNSTI4 0
EQI4 $233
LABELV $234
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $226
LABELV $233
line 603
;602:		       && self->has_dispenser == 0 ) || tg_data.tg_enabled )
;603:		{
line 604
;604:			sound (self, 3, "items/repair.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $235
ARGP4
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 605
;605:			TeamFortress_Build( 1 );
CNSTI4 1
ARGI4
ADDRGP4 TeamFortress_Build
CALLV
pop
line 606
;606:			ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 607
;607:			self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 608
;608:		}
line 609
;609:		break;
ADDRGP4 $226
JUMPV
LABELV $236
line 611
;610:	case 2:
;611:		if ( !( ( int ) self->s.v.flags & FL_ONGROUND ) )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $237
line 612
;612:		{
line 613
;613:			CenterPrint( self, "You can't build in the air!\n\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $230
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 614
;614:			ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 615
;615:			self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 616
;616:			return;
ADDRGP4 $224
JUMPV
LABELV $237
line 618
;617:		}
;618:		if ( ( self->s.v.ammo_cells >= BUILD_COST_SENTRYGUN
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1124204544
LTF4 $242
ADDRLP4 8
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
CNSTI4 0
EQI4 $241
LABELV $242
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $226
LABELV $241
line 620
;619:		       && self->has_sentry == 0 ) || tg_data.tg_enabled )
;620:		{
line 621
;621:			sound (self, 3, "items/repair.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $235
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
line 622
;622:			TeamFortress_Build( 2 );
CNSTI4 2
ARGI4
ADDRGP4 TeamFortress_Build
CALLV
pop
line 623
;623:			ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 624
;624:			self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 625
;625:		}
line 626
;626:		break;
ADDRGP4 $226
JUMPV
LABELV $243
line 628
;627:	case 7:
;628:		if ( self->has_dispenser > 0 )
ADDRGP4 self
INDIRP4
CNSTI4 996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $226
line 629
;629:		{
line 630
;630:			DestroyBuilding( self, "building_dispenser" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $246
ARGP4
ADDRGP4 DestroyBuilding
CALLV
pop
line 631
;631:			ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 632
;632:			self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 633
;633:		}
line 634
;634:		break;
ADDRGP4 $226
JUMPV
LABELV $247
line 636
;635:	case 8:
;636:		if ( self->has_sentry > 0 )
ADDRGP4 self
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
CNSTI4 0
LEI4 $226
line 637
;637:		{
line 638
;638:			DestroyBuilding( self, "building_sentrygun" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $250
ARGP4
ADDRGP4 DestroyBuilding
CALLV
pop
line 639
;639:			ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 640
;640:			self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 641
;641:		}
line 642
;642:		break;
ADDRGP4 $226
JUMPV
LABELV $251
line 644
;643:	case 5:
;644:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 645
;645:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 646
;646:		break;
LABELV $225
LABELV $226
line 648
;647:	}
;648:}
LABELV $224
endproc Menu_Engineer_Input 16 20
export Menu_EngineerFix_Dispenser
proc Menu_EngineerFix_Dispenser 0 8
line 651
;649:
;650:void Menu_EngineerFix_Dispenser( menunum_t menu )
;651:{
line 652
;652:	CenterPrint( self, "Action:                            \n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $255
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 658
;653:		     "êìë Put Ammo into Dispenser     \n"
;654:		     "êîë Put Armor into Dispenser    \n"
;655:		     "êïë Repair Dispenser            \n"
;656:		     "êñë Dismantle Dispenser         \n"
;657:		     "êóë Nothing                     \n\n" );
;658:}
LABELV $254
endproc Menu_EngineerFix_Dispenser 0 8
export Menu_EngineerFix_Dispenser_Input
proc Menu_EngineerFix_Dispenser_Input 112 20
line 661
;659:
;660:void Menu_EngineerFix_Dispenser_Input( int inp )
;661:{
line 665
;662:	float   metalcost;
;663:	float   am;
;664:
;665:	if ( strneq( self->s.v.classname, "player" ) || !self->building
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $259
ARGP4
ADDRLP4 8
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $261
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 12
INDIRU4
CNSTU4 0
EQU4 $261
ADDRLP4 12
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $257
LABELV $261
line 667
;666:	     || self->building == world )
;667:		return;
ADDRGP4 $256
JUMPV
LABELV $257
line 669
;668:
;669:	switch ( inp )
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $256
ADDRLP4 16
INDIRI4
CNSTI4 5
GTI4 $256
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $298-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $298
address $264
address $281
address $287
address $290
address $263
code
line 670
;670:	{
LABELV $264
line 672
;671:	case 1:
;672:		am = 20 * 2;
ADDRLP4 0
CNSTF4 1109393408
ASGNF4
line 673
;673:		if ( am > self->s.v.ammo_shells )
ADDRLP4 0
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
LEF4 $265
line 674
;674:			am = self->s.v.ammo_shells;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ASGNF4
LABELV $265
line 675
;675:		if ( am > 400 - self->building->s.v.ammo_shells )
ADDRLP4 0
INDIRF4
CNSTF4 1137180672
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
SUBF4
LEF4 $267
line 676
;676:			am = 400 - self->building->s.v.ammo_shells;
ADDRLP4 0
CNSTF4 1137180672
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $267
line 677
;677:		self->s.v.ammo_shells = self->s.v.ammo_shells - am;
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 678
;678:		self->building->s.v.ammo_shells = self->building->s.v.ammo_shells + am;
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 679
;679:		am = 20 * 2;
ADDRLP4 0
CNSTF4 1109393408
ASGNF4
line 680
;680:		if ( am > self->s.v.ammo_nails )
ADDRLP4 0
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
LEF4 $269
line 681
;681:			am = self->s.v.ammo_nails;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ASGNF4
LABELV $269
line 682
;682:		if ( am > 600 - self->building->s.v.ammo_nails )
ADDRLP4 0
INDIRF4
CNSTF4 1142292480
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
SUBF4
LEF4 $271
line 683
;683:			am = 600 - self->building->s.v.ammo_nails;
ADDRLP4 0
CNSTF4 1142292480
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $271
line 684
;684:		self->s.v.ammo_nails = self->s.v.ammo_nails - am;
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 685
;685:		self->building->s.v.ammo_nails = self->building->s.v.ammo_nails + am;
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 686
;686:		am = 10 * 2;
ADDRLP4 0
CNSTF4 1101004800
ASGNF4
line 687
;687:		if ( am > self->s.v.ammo_rockets )
ADDRLP4 0
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
LEF4 $273
line 688
;688:			am = self->s.v.ammo_rockets;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ASGNF4
LABELV $273
line 689
;689:		if ( am > 300 - self->building->s.v.ammo_rockets )
ADDRLP4 0
INDIRF4
CNSTF4 1133903872
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
SUBF4
LEF4 $275
line 690
;690:			am = 300 - self->building->s.v.ammo_rockets;
ADDRLP4 0
CNSTF4 1133903872
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $275
line 691
;691:		self->s.v.ammo_rockets = self->s.v.ammo_rockets - am;
ADDRLP4 36
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 692
;692:		self->building->s.v.ammo_rockets = self->building->s.v.ammo_rockets + am;
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 693
;693:		am = 10 * 2;
ADDRLP4 0
CNSTF4 1101004800
ASGNF4
line 694
;694:		if ( am > self->s.v.ammo_cells )
ADDRLP4 0
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
LEF4 $277
line 695
;695:			am = self->s.v.ammo_cells;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ASGNF4
LABELV $277
line 696
;696:		if ( am > 400 - self->building->s.v.ammo_cells )
ADDRLP4 0
INDIRF4
CNSTF4 1137180672
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
SUBF4
LEF4 $279
line 697
;697:			am = 400 - self->building->s.v.ammo_cells;
ADDRLP4 0
CNSTF4 1137180672
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $279
line 698
;698:		self->s.v.ammo_cells = self->s.v.ammo_cells - am;
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 699
;699:		self->building->s.v.ammo_cells = self->building->s.v.ammo_cells + am;
ADDRLP4 48
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 700
;700:		break;
ADDRGP4 $263
JUMPV
LABELV $281
line 702
;701:	case 2:
;702:		am = 40 * 2;
ADDRLP4 0
CNSTF4 1117782016
ASGNF4
line 703
;703:		if ( am > self->s.v.armorvalue )
ADDRLP4 0
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
LEF4 $282
line 704
;704:			am = self->s.v.armorvalue;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ASGNF4
LABELV $282
line 705
;705:		if ( am > 500 - self->building->s.v.armorvalue )
ADDRLP4 0
INDIRF4
CNSTF4 1140457472
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
SUBF4
LEF4 $284
line 706
;706:			am = 500 - self->building->s.v.armorvalue;
ADDRLP4 0
CNSTF4 1140457472
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $284
line 707
;707:		self->s.v.armorvalue = self->s.v.armorvalue - am;
ADDRLP4 52
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 708
;708:		self->building->s.v.armorvalue = self->building->s.v.armorvalue + am;
ADDRLP4 56
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 428
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 709
;709:		sound (self, 3, "weapons/tnkatck4.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $286
ARGP4
ADDRLP4 60
CNSTF4 1065353216
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 710
;710:		break;
ADDRGP4 $263
JUMPV
LABELV $287
line 712
;711:	case 3:
;712:		metalcost =
ADDRLP4 64
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 64
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
SUBF4
CNSTF4 1084227584
DIVF4
ASGNF4
line 714
;713:		    ( self->building->s.v.max_health - self->building->s.v.health ) / 5;
;714:		if ( metalcost > self->s.v.ammo_cells )
ADDRLP4 4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
LEF4 $288
line 715
;715:			metalcost = self->s.v.ammo_cells;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ASGNF4
LABELV $288
line 716
;716:		self->s.v.ammo_cells = self->s.v.ammo_cells - metalcost;
ADDRLP4 68
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 717
;717:		self->building->s.v.health = self->building->s.v.health + metalcost * 5;
ADDRLP4 72
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
CNSTF4 1084227584
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
line 718
;718:		sound (self, 3, "items/repair.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $235
ARGP4
ADDRLP4 76
CNSTF4 1065353216
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 719
;719:		break;
ADDRGP4 $263
JUMPV
LABELV $290
line 721
;720:	case 4:
;721:		G_sprint( self, 2, "You dismantle the Dispenser.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $291
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 722
;722:		self->s.v.ammo_cells = self->s.v.ammo_cells + BUILD_COST_DISPENSER / 2;
ADDRLP4 80
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 723
;723:		if ( self->building->real_owner != self )
ADDRLP4 84
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 84
INDIRP4
CVPU4 4
EQU4 $292
line 724
;724:		{
line 725
;725:			G_sprint( self->building->real_owner, 2,
ADDRLP4 88
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $294
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 727
;726:				  "%s dismantled your Dispenser.\n", self->s.v.netname );
;727:			teamsprint( self->building->real_owner->team_no,
ADDRLP4 92
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 96
ADDRLP4 92
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 teamsprint
CALLV
pop
line 730
;728:				    self->building->real_owner,
;729:				    ( char * ) self->s.v.netname );
;730:			teamsprint( self->building->real_owner->team_no,
ADDRLP4 100
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
INDIRP4
ARGP4
ADDRGP4 $295
ARGP4
ADDRGP4 teamsprint
CALLV
pop
line 732
;731:				    self->building->real_owner, " dismantled " );
;732:			teamsprint( self->building->real_owner->team_no,
ADDRLP4 104
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 104
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 teamsprint
CALLV
pop
line 735
;733:				    self->building->real_owner,
;734:				    ( char * ) self->building->real_owner->s.v.netname );
;735:			teamsprint( self->building->real_owner->team_no,
ADDRLP4 108
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 $296
ARGP4
ADDRGP4 teamsprint
CALLV
pop
line 737
;736:				    self->building->real_owner, "'s Dispenser.\n" );
;737:		}
LABELV $292
line 738
;738:		dremove( self->building );
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 739
;739:		self->building->real_owner->has_dispenser -= 1;
ADDRLP4 88
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 996
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 740
;740:		break;
line 742
;741:	case 5:
;742:		break;
line 744
;743:	default:
;744:		return;
line 745
;745:		break;
LABELV $263
line 747
;746:	}
;747:	ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 748
;748:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 749
;749:	self->building = world;
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
ADDRGP4 world
INDIRP4
ASGNP4
line 750
;750:	bound_other_ammo( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 bound_other_ammo
CALLV
pop
line 751
;751:	if ( !self->s.v.armorvalue )
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
CNSTF4 0
NEF4 $300
line 752
;752:	{
line 753
;753:		self->s.v.armortype = 0;
ADDRGP4 self
INDIRP4
CNSTI4 424
ADDP4
CNSTF4 0
ASGNF4
line 754
;754:		self->armorclass = 0;
ADDRGP4 self
INDIRP4
CNSTI4 828
ADDP4
CNSTI4 0
ASGNI4
line 755
;755:		self->s.v.items =
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDRLP4 24
INDIRI4
CNSTI4 57344
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 758
;756:		    ( int ) self->s.v.items -
;757:		    ( ( int ) self->s.v.items & ( IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3 ) );
;758:	}
LABELV $300
line 759
;759:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 761
;760:
;761:}
LABELV $256
endproc Menu_EngineerFix_Dispenser_Input 112 20
data
export menu_eng_fixsg_upgrade
align 4
LABELV menu_eng_fixsg_upgrade
address $302
export menu_eng_fixsg_static
align 4
LABELV menu_eng_fixsg_static
address $303
export menu_eng_fixsg_nostatic
align 4
LABELV menu_eng_fixsg_nostatic
address $304
export Menu_EngineerFix_SentryGun
code
proc Menu_EngineerFix_SentryGun 12 16
line 768
;762:
;763:
;764:const char *menu_eng_fixsg_upgrade = "êîë Upgrade Sentry Gun          \n";
;765:const char *menu_eng_fixsg_static = "êôë Make static                 \n";
;766:const char *menu_eng_fixsg_nostatic = "êôë Make no static              \n";
;767:void Menu_EngineerFix_SentryGun( menunum_t menu )
;768:{
line 769
;769:	const char *s_upgrade = "\n", *s_static = "";
ADDRLP4 0
ADDRGP4 $37
ASGNP4
ADDRLP4 4
ADDRGP4 $150
ASGNP4
line 771
;770:
;771:	if ( self->building->s.v.weapon < 3
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
GEF4 $306
ADDRLP4 8
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1124204544
GEF4 $308
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $306
LABELV $308
line 773
;772:	     && ( self->s.v.ammo_cells >= BUILD_COST_SENTRYGUN || tg_data.tg_enabled ) )
;773:		s_upgrade = menu_eng_fixsg_upgrade;
ADDRLP4 0
ADDRGP4 menu_eng_fixsg_upgrade
INDIRP4
ASGNP4
LABELV $306
line 775
;774:
;775:	if ( tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $309
line 776
;776:	{
line 777
;777:		if ( self->building->has_sentry )
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
CNSTI4 0
EQI4 $311
line 778
;778:			s_static = menu_eng_fixsg_nostatic;
ADDRLP4 4
ADDRGP4 menu_eng_fixsg_nostatic
INDIRP4
ASGNP4
ADDRGP4 $312
JUMPV
LABELV $311
line 780
;779:		else
;780:			s_static = menu_eng_fixsg_static;
ADDRLP4 4
ADDRGP4 menu_eng_fixsg_static
INDIRP4
ASGNP4
LABELV $312
line 781
;781:	}
LABELV $309
line 782
;782:	if ( self->building->s.v.weapon == 3 )
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $313
line 783
;783:	{
line 784
;784:	CenterPrint( self, "Action:                            \n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $315
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 793
;785:		     "êìë Put Ammo into Sentry Gun    \n"
;786:		     "%s"
;787:		     "êïë Repair Sentry Gun           \n"
;788:		     "êñë Dismantle Sentry Gun        \n"
;789:		     "êóë Nothing                     \n\n"
;790:		     "êòë Rotate SentryGun            \n"
;791:			 "ê7ë Unload Rockets              \n"
;792:			 "%s", s_upgrade, s_static );
;793:	}
ADDRGP4 $314
JUMPV
LABELV $313
line 795
;794:	else
;795:	{
line 796
;796:	CenterPrint( self, "Action:                            \n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $316
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 803
;797:		     "êìë Put Ammo into Sentry Gun    \n"
;798:		     "%s"
;799:		     "êïë Repair Sentry Gun           \n"
;800:		     "êñë Dismantle Sentry Gun        \n"
;801:		     "êóë Nothing                     \n\n"
;802:		     "êòë Rotate SentryGun            \n" "%s", s_upgrade, s_static );
;803:	}
LABELV $314
line 804
;804:}
LABELV $305
endproc Menu_EngineerFix_SentryGun 12 16
export Menu_EngineerFix_SentryGun_Input
proc Menu_EngineerFix_SentryGun_Input 100 20
line 807
;805:
;806:void Menu_EngineerFix_SentryGun_Input( int inp )
;807:{
line 809
;808:	float   am;
;809:	float   metalcost = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 811
;810:
;811:	if ( !self->building->real_owner->has_sentry )
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
CNSTI4 0
NEI4 $318
line 812
;812:		return;
ADDRGP4 $317
JUMPV
LABELV $318
line 814
;813:
;814:	if ( strneq( self->s.v.classname, "player" ) || self->building == world
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $259
ARGP4
ADDRLP4 8
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $323
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 12
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $323
ADDRLP4 12
INDIRU4
CNSTU4 0
NEU4 $320
LABELV $323
line 816
;815:	     || !self->building )
;816:		return;
ADDRGP4 $317
JUMPV
LABELV $320
line 818
;817:
;818:	switch ( inp )
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $317
ADDRLP4 16
INDIRI4
CNSTI4 7
GTI4 $317
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $372-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $372
address $326
address $343
address $352
address $358
address $317
address $364
address $366
code
line 819
;819:	{
LABELV $326
line 821
;820:	case 1:
;821:		am = 20 * 2;
ADDRLP4 4
CNSTF4 1109393408
ASGNF4
line 822
;822:		if ( am > self->s.v.ammo_shells )
ADDRLP4 4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
LEF4 $327
line 823
;823:			am = self->s.v.ammo_shells;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ASGNF4
LABELV $327
line 824
;824:		if ( am >
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 904
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 20
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
SUBF4
LEF4 $329
line 826
;825:		     self->building->maxammo_shells - self->building->s.v.ammo_shells )
;826:			am = self->building->maxammo_shells -
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
CNSTI4 904
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 24
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $329
line 828
;827:			    self->building->s.v.ammo_shells;
;828:		if ( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $331
line 829
;829:			self->s.v.ammo_shells = self->s.v.ammo_shells - am;
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
LABELV $331
line 830
;830:		self->building->s.v.ammo_shells = self->building->s.v.ammo_shells + am;
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 831
;831:		if ( self->building->s.v.weapon == 3 )
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $325
line 832
;832:		{
line 833
;833:			am = 10 * 2;
ADDRLP4 4
CNSTF4 1101004800
ASGNF4
line 834
;834:			if ( am > self->s.v.ammo_rockets )
ADDRLP4 4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
LEF4 $336
line 835
;835:				am = self->s.v.ammo_rockets;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ASGNF4
LABELV $336
line 836
;836:			if ( am >
ADDRLP4 36
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 916
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
SUBF4
LEF4 $338
line 839
;837:			     self->building->maxammo_rockets -
;838:			     self->building->s.v.ammo_rockets )
;839:				am = self->building->maxammo_rockets -
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
CNSTI4 916
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $338
line 841
;840:				    self->building->s.v.ammo_rockets;
;841:			if ( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $340
line 842
;842:				self->s.v.ammo_rockets = self->s.v.ammo_rockets - am;
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
LABELV $340
line 843
;843:			self->building->s.v.ammo_rockets =
ADDRLP4 48
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 845
;844:			    self->building->s.v.ammo_rockets + am;
;845:			break;
ADDRGP4 $325
JUMPV
LABELV $343
line 847
;846:	case 2:
;847:			if ( self->building->s.v.weapon < 3
ADDRLP4 52
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
GEF4 $325
ADDRLP4 52
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1124204544
GEF4 $346
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $325
LABELV $346
line 850
;848:			     && ( self->s.v.ammo_cells >= BUILD_COST_SENTRYGUN
;849:				  || tg_data.tg_enabled ) )
;850:			{
line 851
;851:				if ( !tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
NEI4 $347
line 852
;852:					self->s.v.ammo_cells = self->s.v.ammo_cells - 130;
ADDRLP4 56
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 1124204544
SUBF4
ASGNF4
LABELV $347
line 854
;853:
;854:				self->building->s.v.weapon =
ADDRLP4 60
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 304
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 856
;855:				    self->building->s.v.weapon + 1;
;856:				self->building->s.v.max_health =
ADDRLP4 64
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 416
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTF4 1067030938
ADDRLP4 64
INDIRP4
INDIRF4
MULF4
ASGNF4
line 858
;857:				    self->building->s.v.max_health * 1.2;
;858:				self->building->s.v.health =
ADDRLP4 68
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 296
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
ASGNF4
line 860
;859:				    self->building->s.v.max_health;
;860:				self->building->maxammo_shells =
ADDRLP4 72
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 904
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTF4 1067030938
ADDRLP4 72
INDIRP4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 862
;861:				    self->building->maxammo_shells * 1.2;
;862:				if ( self->building->s.v.weapon == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $349
line 863
;863:				{
line 864
;864:					sound( self->building, 3, "weapons/tnkatck4.wav",
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $286
ARGP4
ADDRLP4 76
CNSTF4 1065353216
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 866
;865:					       1, 1 );
;866:					self->building->s.v.think =
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl2_sentry_stand
CVPU4 4
CVUI4 4
ASGNI4
line 868
;867:					    ( func_t ) lvl2_sentry_stand;
;868:					self->building->s.v.skin = 1;
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1065353216
ASGNF4
line 869
;869:				} else
ADDRGP4 $350
JUMPV
LABELV $349
line 870
;870:				{
line 871
;871:					sound( self->building, 3, "weapons/tnkatck4.wav",
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $286
ARGP4
ADDRLP4 76
CNSTF4 1065353216
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 873
;872:					       1, 1 );
;873:					self->building->s.v.think =
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl3_sentry_stand
CVPU4 4
CVUI4 4
ASGNI4
line 875
;874:					    ( func_t ) lvl3_sentry_stand;
;875:					self->building->s.v.skin = 2;
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1073741824
ASGNF4
line 876
;876:				}
LABELV $350
line 877
;877:				G_sprint( self, 2,
ADDRLP4 76
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $351
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 880
;878:					  "You upgrade the Sentry Gun to level %.0f\n",
;879:					  self->building->s.v.weapon );
;880:			}
line 881
;881:			break;
ADDRGP4 $325
JUMPV
LABELV $352
line 883
;882:	case 3:
;883:			metalcost =
ADDRLP4 56
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
SUBF4
CNSTF4 1084227584
DIVF4
ASGNF4
line 887
;884:			    ( self->building->s.v.max_health -
;885:			      self->building->s.v.health ) / 5;
;886:
;887:			if ( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $353
line 888
;888:			{
line 889
;889:				if ( metalcost > self->s.v.ammo_cells )
ADDRLP4 0
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
LEF4 $356
line 890
;890:					metalcost = self->s.v.ammo_cells;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ASGNF4
LABELV $356
line 892
;891:
;892:				self->s.v.ammo_cells = self->s.v.ammo_cells - metalcost;
ADDRLP4 60
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 893
;893:			}
LABELV $353
line 894
;894:			self->building->s.v.health =
ADDRLP4 60
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CNSTF4 1084227584
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 897
;895:			    self->building->s.v.health + metalcost * 5;
;896:
;897:			sound( self, 3, "items/repair.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $235
ARGP4
ADDRLP4 64
CNSTF4 1065353216
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 898
;898:			break;
ADDRGP4 $325
JUMPV
LABELV $358
line 900
;899:	case 4:
;900:			G_sprint( self, 2, "You dismantle the Sentry Gun.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $359
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 901
;901:			self->s.v.ammo_cells = self->s.v.ammo_cells + 130 / 2;
ADDRLP4 68
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
CNSTF4 1115815936
ADDF4
ASGNF4
line 902
;902:			if ( self->building->real_owner != self )
ADDRLP4 72
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRP4
CVPU4 4
EQU4 $360
line 903
;903:			{
line 904
;904:				G_sprint( self->building->real_owner, 2,
ADDRLP4 76
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $362
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 907
;905:					  "%s dismantled your Sentry Gun.\n",
;906:					  self->s.v.netname );
;907:				teamsprint( self->building->real_owner->team_no,
ADDRLP4 80
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 teamsprint
CALLV
pop
line 910
;908:					    self->building->real_owner,
;909:					    ( char * ) self->s.v.netname );
;910:				teamsprint( self->building->real_owner->team_no,
ADDRLP4 88
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 $295
ARGP4
ADDRGP4 teamsprint
CALLV
pop
line 912
;911:					    self->building->real_owner, " dismantled " );
;912:				teamsprint( self->building->real_owner->team_no,
ADDRLP4 92
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 teamsprint
CALLV
pop
line 915
;913:					    self->building->real_owner,
;914:					    self->building->real_owner->s.v.netname );
;915:				teamsprint( self->building->real_owner->team_no,
ADDRLP4 96
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
INDIRP4
ARGP4
ADDRGP4 $363
ARGP4
ADDRGP4 teamsprint
CALLV
pop
line 918
;916:					    self->building->real_owner,
;917:					    "'s Sentry Gun.\n" );
;918:			}
LABELV $360
line 919
;919:			dremove( self->building->trigger_field );
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 920
;920:			dremove( self->building );
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 921
;921:			self->building->real_owner->has_sentry -= 1;
ADDRLP4 76
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 922
;922:		}
line 924
;923:
;924:		break;
ADDRGP4 $325
JUMPV
LABELV $364
line 926
;925:	case 6:
;926:		G_sprint( self, 2, "Rotating 45 degrees to the left...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $365
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 927
;927:		self->building->waitmin = anglemod( self->building->waitmin + 45 );
ADDRLP4 36
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 1092
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1110704128
ADDF4
ARGF4
ADDRLP4 40
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRF4
ASGNF4
line 928
;928:		self->building->waitmax = anglemod( self->building->waitmax + 45 );
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 1096
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRF4
CNSTF4 1110704128
ADDF4
ARGF4
ADDRLP4 48
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 44
INDIRP4
ADDRLP4 48
INDIRF4
ASGNF4
line 929
;929:		break;
ADDRGP4 $325
JUMPV
LABELV $366
line 931
;930:	case 7:
;931:		if ( self->building->s.v.weapon == 3 )
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $317
line 932
;932:		{
line 933
;933:			self->s.v.ammo_rockets += self->building->s.v.ammo_rockets;
ADDRLP4 52
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 56
CNSTI4 328
ASGNI4
ADDRLP4 60
ADDRLP4 52
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
ADDRLP4 52
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 934
;934:			if ( self->s.v.ammo_rockets > self->maxammo_rockets )
ADDRLP4 64
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 916
ADDP4
INDIRI4
CVIF4 4
LEF4 $369
line 935
;935:				self->s.v.ammo_rockets = self->maxammo_rockets;
ADDRLP4 68
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 328
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 916
ADDP4
INDIRI4
CVIF4 4
ASGNF4
LABELV $369
line 936
;936:			self->building->s.v.ammo_rockets = 0;
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 328
ADDP4
CNSTF4 0
ASGNF4
line 937
;937:			G_sprint( self, 2, "You have unloaded your sentry's rocket cache.\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $371
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 938
;938:		}
line 940
;939:		else
;940:			return;
line 949
;941:/*		if ( !tg_data.tg_enabled )
;942:			return;
;943:		self->s.v.impulse = 0;
;944:		if ( self->building->has_sentry )
;945:			self->building->has_sentry = 0;
;946:		else
;947:			self->building->has_sentry = 1;
;948:		ResetMenu(  );*/
;949:		break;
line 951
;950:	default:
;951:		return;
LABELV $325
line 954
;952:	}
;953:
;954:	ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 955
;955:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 956
;956:	bound_other_ammo( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 bound_other_ammo
CALLV
pop
line 957
;957:	if ( !self->s.v.armorvalue )
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
CNSTF4 0
NEF4 $374
line 958
;958:	{
line 959
;959:		self->s.v.armortype = 0;
ADDRGP4 self
INDIRP4
CNSTI4 424
ADDP4
CNSTF4 0
ASGNF4
line 960
;960:		self->armorclass = 0;
ADDRGP4 self
INDIRP4
CNSTI4 828
ADDP4
CNSTI4 0
ASGNI4
line 961
;961:		self->s.v.items =
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDRLP4 24
INDIRI4
CNSTI4 57344
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 964
;962:		    ( int ) self->s.v.items -
;963:		    ( ( int ) self->s.v.items & ( IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3 ) );
;964:	}
LABELV $374
line 965
;965:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 967
;966:
;967:}
LABELV $317
endproc Menu_EngineerFix_SentryGun_Input 100 20
export Menu_Dispenser
proc Menu_Dispenser 0 8
line 970
;968:
;969:void Menu_Dispenser( menunum_t menu )
;970:{
line 971
;971:	CenterPrint( self, "Use Dispenser:                     \n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $377
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 975
;972:		     "êìë.. Withdraw some ammo     \n"
;973:		     "êîë.. Withdraw some Armor    \nêïë.. Health & Vaccine       \nêñë.. BioSuit (AntiToaster)  \n"
;974:		     "êóë.. Nothing                \n\n" );
;975:}
LABELV $376
endproc Menu_Dispenser 0 8
export Menu_Dispenser_Input
proc Menu_Dispenser_Input 108 20
line 978
;976:
;977:void Menu_Dispenser_Input( int inp )
;978:{
line 979
;979:	float   am, empty = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 983
;980:	float   healed;
;981:	gedict_t *te;
;982:
;983:	switch ( inp )
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $378
ADDRLP4 16
INDIRI4
CNSTI4 4
GTI4 $378
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $492-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $492
address $381
address $393
address $400
address $486
code
line 984
;984:	{
LABELV $381
line 986
;985:	case 1:
;986:		if ( !self->building->s.v.ammo_shells
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 20
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
NEF4 $382
ADDRLP4 20
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
NEF4 $382
ADDRLP4 20
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
NEF4 $382
ADDRLP4 20
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
NEF4 $382
line 990
;987:		     && !self->building->s.v.ammo_nails
;988:		     && !self->building->s.v.ammo_rockets
;989:		     && !self->building->s.v.ammo_cells )
;990:		{
line 991
;991:			empty = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 992
;992:			break;
ADDRGP4 $380
JUMPV
LABELV $382
line 994
;993:		}
;994:		am = self->maxammo_shells - self->s.v.ammo_shells;
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 28
INDIRP4
CNSTI4 904
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 28
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
SUBF4
ASGNF4
line 995
;995:		if ( am > self->building->s.v.ammo_shells )
ADDRLP4 4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
LEF4 $384
line 996
;996:			am = self->building->s.v.ammo_shells;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ASGNF4
LABELV $384
line 998
;997:
;998:		self->building->s.v.ammo_shells = self->building->s.v.ammo_shells - am;
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 999
;999:		self->s.v.ammo_shells = self->s.v.ammo_shells + am;
ADDRLP4 36
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 1001
;1000:
;1001:		am = self->maxammo_nails - self->s.v.ammo_nails;
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
CNSTI4 908
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1002
;1002:		if ( am > self->building->s.v.ammo_nails )
ADDRLP4 4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
LEF4 $386
line 1003
;1003:			am = self->building->s.v.ammo_nails;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ASGNF4
LABELV $386
line 1005
;1004:
;1005:		self->building->s.v.ammo_nails = self->building->s.v.ammo_nails - am;
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 1006
;1006:		self->s.v.ammo_nails = self->s.v.ammo_nails + am;
ADDRLP4 48
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 1007
;1007:		am = self->maxammo_rockets - self->s.v.ammo_rockets;
ADDRLP4 52
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
CNSTI4 916
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 52
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1008
;1008:		if ( am > self->building->s.v.ammo_rockets )
ADDRLP4 4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
LEF4 $388
line 1009
;1009:			am = self->building->s.v.ammo_rockets;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ASGNF4
LABELV $388
line 1010
;1010:		self->building->s.v.ammo_rockets = self->building->s.v.ammo_rockets - am;
ADDRLP4 56
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 1011
;1011:		self->s.v.ammo_rockets = self->s.v.ammo_rockets + am;
ADDRLP4 60
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 1012
;1012:		am = self->maxammo_cells - self->s.v.ammo_cells;
ADDRLP4 64
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 64
INDIRP4
CNSTI4 912
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 64
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1013
;1013:		if ( am > self->building->s.v.ammo_cells )
ADDRLP4 4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
LEF4 $390
line 1014
;1014:			am = self->building->s.v.ammo_cells;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ASGNF4
LABELV $390
line 1015
;1015:		self->building->s.v.ammo_cells = self->building->s.v.ammo_cells - am;
ADDRLP4 68
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 1016
;1016:		self->s.v.ammo_cells = self->s.v.ammo_cells + am;
ADDRLP4 72
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 1017
;1017:		sound (self, 3, "weapons/rocklr1a.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $392
ARGP4
ADDRLP4 76
CNSTF4 1065353216
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 1018
;1018:		break;
ADDRGP4 $380
JUMPV
LABELV $393
line 1020
;1019:	case 2:
;1020:		if ( !self->building->s.v.armorvalue )
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
CNSTF4 0
NEF4 $394
line 1021
;1021:		{
line 1022
;1022:			empty = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 1023
;1023:			break;
ADDRGP4 $380
JUMPV
LABELV $394
line 1025
;1024:		}
;1025:		am = self->maxarmor - self->s.v.armorvalue;
ADDRLP4 80
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 80
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 80
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1026
;1026:		if ( am > self->building->s.v.armorvalue )
ADDRLP4 4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
LEF4 $396
line 1027
;1027:			am = self->building->s.v.armorvalue;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ASGNF4
LABELV $396
line 1028
;1028:		if ( !self->s.v.armortype )
ADDRGP4 self
INDIRP4
CNSTI4 424
ADDP4
INDIRF4
CNSTF4 0
NEF4 $398
line 1029
;1029:		{
line 1030
;1030:			self->s.v.armortype = 0.3;
ADDRGP4 self
INDIRP4
CNSTI4 424
ADDP4
CNSTF4 1050253722
ASGNF4
line 1031
;1031:			self->s.v.items = ( int ) self->s.v.items | IT_ARMOR1;
ADDRLP4 84
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 8192
BORI4
CVIF4 4
ASGNF4
line 1032
;1032:		}
LABELV $398
line 1033
;1033:		self->building->s.v.armorvalue -= am;
ADDRLP4 84
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 428
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 1034
;1034:		self->s.v.armorvalue += am;
ADDRLP4 88
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 1035
;1035:		sound (self, 3, "weapons/tnkatck4.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $286
ARGP4
ADDRLP4 92
CNSTF4 1065353216
ASGNF4
ADDRLP4 92
INDIRF4
ARGF4
ADDRLP4 92
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 1036
;1036:		break;
ADDRGP4 $380
JUMPV
LABELV $400
line 1039
;1037:		// ADD: DISPENSER HEAL & BIOSUIT
;1038:	case 3:	//heal
;1039:		if ( !self->building->s.v.armorvalue )
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
CNSTF4 0
NEF4 $401
line 1040
;1040:		{
line 1041
;1041:			empty = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 1043
;1042:			//break;
;1043:		}
LABELV $401
line 1044
;1044:		if ( self->building->s.v.skin == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $403
line 1045
;1045:		{
line 1046
;1046:			healed = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1048
;1047:
;1048:			for ( te=world ; (te = trap_find( te, FOFS( s.v.classname ), "timer" ));)
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $408
JUMPV
LABELV $405
line 1049
;1049:			{
line 1050
;1050:				if ( te->s.v.owner != g_globalvars.self )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_globalvars+112
INDIRI4
EQI4 $410
line 1051
;1051:					continue;
ADDRGP4 $406
JUMPV
LABELV $410
line 1052
;1052:				if ( te->s.v.think != ( func_t ) ConcussionGrenadeTimer &&
ADDRLP4 96
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
ADDRGP4 ConcussionGrenadeTimer
CVPU4 4
CVUI4 4
EQI4 $413
ADDRLP4 96
INDIRI4
ADDRGP4 OldConcussionGrenadeTimer
CVPU4 4
CVUI4 4
EQI4 $413
line 1054
;1053:					te->s.v.think != ( func_t ) OldConcussionGrenadeTimer )
;1054:					continue;
ADDRGP4 $406
JUMPV
LABELV $413
line 1055
;1055:				if ( tf_data.old_grens == 1 )
ADDRGP4 tf_data+44
INDIRI4
CNSTI4 1
NEI4 $415
line 1056
;1056:					stuffcmd( self, "v_idlescale 0\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $418
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $415
line 1058
;1057:		//			stuffcmd( self, "v_idlescale 0\nfov 90\n" );
;1058:				dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1059
;1059:				G_sprint ( self, 2, "you have been healed of your concussion\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $419
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1060
;1060:				healed = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1061
;1061:				break;
ADDRGP4 $407
JUMPV
LABELV $406
line 1048
LABELV $408
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $409
ARGP4
ADDRLP4 96
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 96
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $405
LABELV $407
line 1063
;1062:			}
;1063:			if ( self->tfstate & TFSTATE_HALLUCINATING )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $420
line 1064
;1064:			{
line 1065
;1065:				for ( te=world ; (te = trap_find( te, FOFS( s.v.classname ), "timer" ));)
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $425
JUMPV
LABELV $422
line 1066
;1066:				{
line 1067
;1067:					if ( te->s.v.owner != g_globalvars.self )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_globalvars+112
INDIRI4
EQI4 $426
line 1068
;1068:						continue;
ADDRGP4 $423
JUMPV
LABELV $426
line 1069
;1069:					if ( te->s.v.think != ( func_t ) HallucinationTimer )
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 HallucinationTimer
CVPU4 4
CVUI4 4
EQI4 $429
line 1070
;1070:						continue;
ADDRGP4 $423
JUMPV
LABELV $429
line 1072
;1071:
;1072:					self->tfstate -= ( self->tfstate & TFSTATE_HALLUCINATING );
ADDRLP4 100
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 104
ADDRLP4 100
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRP4
ADDRLP4 104
INDIRI4
ADDRLP4 104
INDIRI4
CNSTI4 16384
BANDI4
SUBI4
ASGNI4
line 1073
;1073:					G_sprint (self, 2, "you have been healed of your hallucinations\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $431
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1074
;1074:					healed = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1076
;1075:					
;1076:					ResetGasSkins(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ResetGasSkins
CALLV
pop
line 1077
;1077:					if ( tf_data.new_gas & GAS_MASK_PALETTE) 
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $432
line 1078
;1078:						stuffcmd( self, "v_cshift; wait; bf\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $435
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $432
line 1079
;1079:					dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1080
;1080:					break;
ADDRGP4 $424
JUMPV
LABELV $423
line 1065
LABELV $425
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $409
ARGP4
ADDRLP4 100
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 100
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $422
LABELV $424
line 1082
;1081:				}
;1082:				if ( !te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $436
line 1083
;1083:					G_conprintf( "Warning: Error in Hallucination Timer logic.\n" );
ADDRGP4 $438
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
LABELV $436
line 1084
;1084:			}
LABELV $420
line 1085
;1085:			if ( self->tfstate & TFSTATE_TRANQUILISED )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $439
line 1086
;1086:			{
line 1087
;1087:				for ( te=world ; (te = trap_find( te, FOFS( s.v.classname ), "timer" ));)
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $444
JUMPV
LABELV $441
line 1088
;1088:				{
line 1089
;1089:					if ( te->s.v.owner != g_globalvars.self )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_globalvars+112
INDIRI4
EQI4 $445
line 1090
;1090:						continue;
ADDRGP4 $442
JUMPV
LABELV $445
line 1091
;1091:					if ( te->s.v.think != ( func_t ) TranquiliserTimer )
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 TranquiliserTimer
CVPU4 4
CVUI4 4
EQI4 $448
line 1092
;1092:						continue;
ADDRGP4 $442
JUMPV
LABELV $448
line 1094
;1093:
;1094:					self->tfstate -= ( self->tfstate & TFSTATE_TRANQUILISED );
ADDRLP4 100
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 104
ADDRLP4 100
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRP4
ADDRLP4 104
INDIRI4
ADDRLP4 104
INDIRI4
CNSTI4 32768
BANDI4
SUBI4
ASGNI4
line 1095
;1095:					TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 1096
;1096:					G_sprint ( self, 2, "you have been healed of your tranquilisation\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $450
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1097
;1097:					healed = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1098
;1098:					dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1099
;1099:					break;
ADDRGP4 $443
JUMPV
LABELV $442
line 1087
LABELV $444
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $409
ARGP4
ADDRLP4 100
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 100
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $441
LABELV $443
line 1101
;1100:				}
;1101:				if ( !te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $451
line 1102
;1102:					G_conprintf( "Warning: Error in Tranquilisation Timer logic.\n" );
ADDRGP4 $453
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
LABELV $451
line 1103
;1103:			}
LABELV $439
line 1104
;1104:			if ( self->FlashTime > 0 )
ADDRGP4 self
INDIRP4
CNSTI4 1472
ADDP4
INDIRF4
CNSTF4 0
LEF4 $454
line 1105
;1105:			{
line 1106
;1106:				for ( te=world ; (te = trap_find( te, FOFS( s.v.netname ), "flashtimer" ));)
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $459
JUMPV
LABELV $456
line 1107
;1107:				{
line 1108
;1108:					if ( te->s.v.owner != g_globalvars.self )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_globalvars+112
INDIRI4
EQI4 $461
line 1109
;1109:						continue;
ADDRGP4 $457
JUMPV
LABELV $461
line 1110
;1110:					if ( strneq( te->s.v.classname, "timer" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $409
ARGP4
ADDRLP4 100
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $464
line 1111
;1111:						continue;
ADDRGP4 $457
JUMPV
LABELV $464
line 1113
;1112:
;1113:					self->FlashTime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1472
ADDP4
CNSTF4 0
ASGNF4
line 1114
;1114:					healed = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1115
;1115:					if ( tf_data.new_flash )
ADDRGP4 tf_data+48
INDIRI4
CNSTI4 0
EQI4 $458
line 1116
;1116:						disableupdates( self, -1 );	/* server-side flash */
ADDRGP4 self
INDIRP4
ARGP4
CNSTF4 3212836864
ARGF4
ADDRGP4 disableupdates
CALLV
pop
line 1117
;1117:					break;
ADDRGP4 $458
JUMPV
LABELV $457
line 1106
LABELV $459
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 396
ARGI4
ADDRGP4 $460
ARGP4
ADDRLP4 100
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 100
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $456
LABELV $458
line 1119
;1118:				}
;1119:				if ( !te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $469
line 1120
;1120:				{
line 1121
;1121:					G_conprintf( "Warning: Error in Flash Timer logic.\n" );
ADDRGP4 $471
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 1122
;1122:					self->FlashTime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1472
ADDP4
CNSTF4 0
ASGNF4
line 1123
;1123:				}
LABELV $469
line 1124
;1124:			}
LABELV $454
line 1126
;1125:			// Leg shots
;1126:			if ( self->leg_damage > 0 )
ADDRGP4 self
INDIRP4
CNSTI4 1464
ADDP4
INDIRI4
CNSTI4 0
LEI4 $472
line 1127
;1127:			{
line 1128
;1128:				G_sprint ( self, 2, "Your leg wound has been healed!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $474
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1129
;1129:				self->leg_damage = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1464
ADDP4
CNSTI4 0
ASGNI4
line 1130
;1130:				TeamFortress_SetSpeed ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 1131
;1131:				healed = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1132
;1132:			}
LABELV $472
line 1133
;1133:			if ( self->numflames > 0 )
ADDRGP4 self
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CNSTI4 0
LEI4 $475
line 1134
;1134:			{
line 1135
;1135:				sound( self, 1, "items/r_item1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $477
ARGP4
ADDRLP4 100
CNSTF4 1065353216
ASGNF4
ADDRLP4 100
INDIRF4
ARGF4
ADDRLP4 100
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 1136
;1136:				self->numflames = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1396
ADDP4
CNSTI4 0
ASGNI4
line 1137
;1137:				G_sprint ( self, 2, "The flames have been doused!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $478
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1138
;1138:				healed = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1139
;1139:				return;
ADDRGP4 $378
JUMPV
LABELV $475
line 1142
;1140:			}
;1141:
;1142:			if (healed == 0)
ADDRLP4 12
INDIRF4
CNSTF4 0
NEF4 $479
line 1143
;1143:				G_sprint( self, 2, "You have nothing to cure.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $481
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $480
JUMPV
LABELV $479
line 1144
;1144:			else {
line 1145
;1145:				self->s.v.health += 25;
ADDRLP4 100
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
CNSTF4 1103626240
ADDF4
ASGNF4
line 1146
;1146:				sound ( self, 3, "items/r_item2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $482
ARGP4
ADDRLP4 104
CNSTF4 1065353216
ASGNF4
ADDRLP4 104
INDIRF4
ARGF4
ADDRLP4 104
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 1147
;1147:			}
LABELV $480
line 1148
;1148:			if ( self->s.v.health > self->s.v.max_health )
ADDRLP4 100
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
LEF4 $380
line 1149
;1149:				self->s.v.health = self->s.v.max_health;
ADDRLP4 104
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 296
ADDP4
ADDRLP4 104
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
ASGNF4
line 1150
;1150:		}
ADDRGP4 $380
JUMPV
LABELV $403
line 1152
;1151:		else
;1152:		{
line 1153
;1153:			G_sprint( self, 2, "No vaccine has been loaded by Medic\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $485
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1154
;1154:		}
line 1155
;1155:		break;
ADDRGP4 $380
JUMPV
LABELV $486
line 1157
;1156:	case 4:
;1157:		if ( self->building->s.v.skin == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $487
line 1158
;1158:		{
line 1159
;1159:			self->s.v.items = ( int ) self->s.v.items | IT_SUIT;
ADDRLP4 96
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 2097152
BORI4
CVIF4 4
ASGNF4
line 1160
;1160:			self->rad_time = 1;
ADDRGP4 self
INDIRP4
CNSTI4 772
ADDP4
CNSTF4 1065353216
ASGNF4
line 1161
;1161:			self->radsuit_finished = g_globalvars.time + 30;
ADDRGP4 self
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 1162
;1162:			G_sprint( self, 2, "You have a BioSuit\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $490
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1163
;1163:		}
ADDRGP4 $380
JUMPV
LABELV $487
line 1165
;1164:		else
;1165:		{
line 1166
;1166:			G_sprint ( self, 2, "No BioSuit has been loaded by Medic\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $491
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1167
;1167:		}
line 1168
;1168:		break;
line 1170
;1169:	default:
;1170:		return;
LABELV $380
line 1173
;1171:
;1172:	}
;1173:	if ( empty )
ADDRLP4 8
INDIRF4
CNSTF4 0
EQF4 $494
line 1174
;1174:		G_sprint( self, 2, "The dispenser is empty.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $496
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $494
line 1176
;1175:
;1176:	ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1177
;1177:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1178
;1178:	self->building = world;
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
ADDRGP4 world
INDIRP4
ASGNP4
line 1179
;1179:	self->building_wait = g_globalvars.time + 0.5;
ADDRGP4 self
INDIRP4
CNSTI4 984
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1180
;1180:	bound_other_ammo( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 bound_other_ammo
CALLV
pop
line 1181
;1181:	if ( !self->s.v.armorvalue )
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
CNSTF4 0
NEF4 $498
line 1182
;1182:	{
line 1183
;1183:		self->s.v.armortype = 0;
ADDRGP4 self
INDIRP4
CNSTI4 424
ADDP4
CNSTF4 0
ASGNF4
line 1184
;1184:		self->armorclass = 0;
ADDRGP4 self
INDIRP4
CNSTI4 828
ADDP4
CNSTI4 0
ASGNI4
line 1185
;1185:		self->s.v.items =
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDRLP4 24
INDIRI4
CNSTI4 57344
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 1188
;1186:		    ( int ) self->s.v.items -
;1187:		    ( ( int ) self->s.v.items & ( IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3 ) );
;1188:	}
LABELV $498
line 1189
;1189:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 1191
;1190:
;1191:}
LABELV $378
endproc Menu_Dispenser_Input 108 20
data
export spy_menu_feign
align 4
LABELV spy_menu_feign
address $500
export spy_menu_stop_feign
align 4
LABELV spy_menu_stop_feign
address $501
export spy_menu_undecover
align 4
LABELV spy_menu_undecover
address $502
export spy_menu_reset_skin
align 4
LABELV spy_menu_reset_skin
address $503
export spy_menu_reset_color
align 4
LABELV spy_menu_reset_color
address $504
export spy_menu_reset_skin_color
align 4
LABELV spy_menu_reset_skin_color
address $505
export Menu_Spy
code
proc Menu_Spy 24 20
line 1203
;1192:
;1193:const char *spy_menu_feign = "êïë Start Feigning              \n"
;1194:    "êñë Silent Feign                \n";
;1195:const char *spy_menu_stop_feign = "êïë Stop Feigning               \n";
;1196:const char *spy_menu_undecover = "êìë Change Skin                 \n"
;1197:    "êîë Change Color                \n";
;1198:
;1199:const char *spy_menu_reset_skin = "êóë Reset Skin                  \n";
;1200:const char *spy_menu_reset_color = "êóë Reset Color                 \n";
;1201:const char *spy_menu_reset_skin_color = "êóë Reset Skin and Color        \n";
;1202:void Menu_Spy( menunum_t menu )
;1203:{
line 1204
;1204:	const char *s_undercover = spy_menu_undecover, *s_feign = "", *s_reset = "";
ADDRLP4 8
ADDRGP4 spy_menu_undecover
INDIRP4
ASGNP4
ADDRLP4 0
ADDRGP4 $150
ASGNP4
ADDRLP4 4
ADDRGP4 $150
ASGNP4
line 1206
;1205:
;1206:	if ( self->is_feigning )
ADDRGP4 self
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $507
line 1207
;1207:		s_feign = spy_menu_stop_feign;
ADDRLP4 0
ADDRGP4 spy_menu_stop_feign
INDIRP4
ASGNP4
ADDRGP4 $508
JUMPV
LABELV $507
line 1209
;1208:	else
;1209:		s_feign = spy_menu_feign;
ADDRLP4 0
ADDRGP4 spy_menu_feign
INDIRP4
ASGNP4
LABELV $508
line 1211
;1210:
;1211:	if ( self->undercover_team && self->undercover_skin )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $509
ADDRLP4 12
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $509
line 1212
;1212:	{
line 1213
;1213:		s_reset = spy_menu_reset_skin_color;
ADDRLP4 4
ADDRGP4 spy_menu_reset_skin_color
INDIRP4
ASGNP4
line 1214
;1214:	} else
ADDRGP4 $510
JUMPV
LABELV $509
line 1215
;1215:	{
line 1216
;1216:		if ( self->undercover_skin )
ADDRGP4 self
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
CNSTI4 0
EQI4 $511
line 1217
;1217:			s_reset = spy_menu_reset_skin;
ADDRLP4 4
ADDRGP4 spy_menu_reset_skin
INDIRP4
ASGNP4
LABELV $511
line 1219
;1218:
;1219:		if ( self->undercover_team )
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
CNSTI4 0
EQI4 $513
line 1220
;1220:			s_reset = spy_menu_reset_color;
ADDRLP4 4
ADDRGP4 spy_menu_reset_color
INDIRP4
ASGNP4
LABELV $513
line 1221
;1221:	}
LABELV $510
line 1224
;1222:
;1223:
;1224:	if ( ( ( int ) self->s.v.effects & ( 8 | 4 ) ) || self->is_unabletospy == 1 )
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CVFI4 4
CNSTI4 12
BANDI4
CNSTI4 0
NEI4 $517
ADDRLP4 20
INDIRP4
CNSTI4 884
ADDP4
INDIRI4
CNSTI4 1
NEI4 $515
LABELV $517
line 1225
;1225:	{
line 1226
;1226:		s_undercover = "";
ADDRLP4 8
ADDRGP4 $150
ASGNP4
line 1227
;1227:	}
LABELV $515
line 1229
;1228:
;1229:	CenterPrint( self, "Action:                           \n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $518
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1233
;1230:		     "%s%s%s"
;1231:		     "êòë Nothing                     \n\n",
;1232:		     s_undercover, s_feign, s_reset );
;1233:}
LABELV $506
endproc Menu_Spy 24 20
export Menu_Spy_Input
proc Menu_Spy_Input 8 12
line 1236
;1234:
;1235:void Menu_Spy_Input( int inp )
;1236:{
line 1237
;1237:	if ( inp == 1 || inp == 2 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $522
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $520
LABELV $522
line 1238
;1238:	{
line 1239
;1239:		if ( ( int ) self->s.v.effects & ( 8 | 4 ) )
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CVFI4 4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $523
line 1240
;1240:		{
line 1241
;1241:			G_sprint( self, 2, "You can't go undercover while glowing.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $525
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1242
;1242:			ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1243
;1243:			self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1244
;1244:			return;
ADDRGP4 $519
JUMPV
LABELV $523
line 1246
;1245:		}
;1246:		if ( self->is_unabletospy == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 884
ADDP4
INDIRI4
CNSTI4 1
NEI4 $526
line 1247
;1247:		{
line 1248
;1248:			G_sprint( self, 2, "You can't go undercover right now.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $528
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1249
;1249:			ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1250
;1250:			self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1251
;1251:			return;
ADDRGP4 $519
JUMPV
LABELV $526
line 1253
;1252:		}
;1253:	}
LABELV $520
line 1256
;1254:
;1255:
;1256:	switch ( inp )
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
LTI4 $529
ADDRLP4 4
INDIRI4
CNSTI4 6
GTI4 $529
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $539-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $539
address $531
address $532
address $533
address $534
address $537
address $538
code
line 1257
;1257:	{
LABELV $531
line 1259
;1258:	case 1:
;1259:		Menu_Spy_Skin( MENU_SPY_SKIN );
CNSTI4 13
ARGI4
ADDRGP4 Menu_Spy_Skin
CALLV
pop
line 1260
;1260:		self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 1261
;1261:		self->current_menu = MENU_SPY_SKIN;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 13
ASGNI4
line 1262
;1262:		self->menu_displaytime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 956
ADDP4
CNSTI4 0
ASGNI4
line 1263
;1263:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1264
;1264:		break;
ADDRGP4 $530
JUMPV
LABELV $532
line 1266
;1265:	case 2:
;1266:		Menu_Spy_Color( MENU_SPY_COLOR );
CNSTI4 14
ARGI4
ADDRGP4 Menu_Spy_Color
CALLV
pop
line 1267
;1267:		self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 1268
;1268:		self->current_menu = MENU_SPY_COLOR;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 14
ASGNI4
line 1269
;1269:		self->menu_displaytime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 956
ADDP4
CNSTI4 0
ASGNI4
line 1270
;1270:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1271
;1271:		break;
ADDRGP4 $530
JUMPV
LABELV $533
line 1273
;1272:	case 3:
;1273:		TeamFortress_SpyFeignDeath( 0 );
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_SpyFeignDeath
CALLV
pop
line 1274
;1274:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1275
;1275:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1276
;1276:		break;
ADDRGP4 $530
JUMPV
LABELV $534
line 1278
;1277:	case 4:
;1278:		if ( !self->is_feigning )
ADDRGP4 self
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
NEI4 $535
line 1279
;1279:			TeamFortress_SpyFeignDeath( 1 );
CNSTI4 1
ARGI4
ADDRGP4 TeamFortress_SpyFeignDeath
CALLV
pop
LABELV $535
line 1280
;1280:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1281
;1281:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1283
;1282:
;1283:		break;
ADDRGP4 $530
JUMPV
LABELV $537
line 1285
;1284:	case 5:
;1285:		Spy_RemoveDisguise( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 Spy_RemoveDisguise
CALLV
pop
line 1286
;1286:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1287
;1287:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1288
;1288:		break;
ADDRGP4 $530
JUMPV
LABELV $538
line 1291
;1289:	case 6:
;1290:		//if ( self->undercover_team || self->undercover_skin )
;1291:		{
line 1292
;1292:			ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1293
;1293:			self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1294
;1294:		}
line 1295
;1295:		break;
LABELV $529
LABELV $530
line 1298
;1296:	}
;1297:
;1298:}
LABELV $519
endproc Menu_Spy_Input 8 12
export Menu_Spy_Skin
proc Menu_Spy_Skin 0 8
line 1300
;1299:void Menu_Spy_Skin( menunum_t menu )
;1300:{
line 1301
;1301:	CenterPrint( self,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $542
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1303
;1302:		     "Change Skin to:\nêìë Scout   \nêîë Sniper  \nêïë Soldier \nêñë Demoman \nêóë Medic   \nêòë Hvwep   \nêôë Pyro    \nêöë Spy     \nêõë Engineer\n\n" );
;1303:}
LABELV $541
endproc Menu_Spy_Skin 0 8
export Menu_Spy_Skin_Input
proc Menu_Spy_Skin_Input 4 4
line 1306
;1304:
;1305:void Menu_Spy_Skin_Input( int inp )
;1306:{
line 1307
;1307:	if ( inp < 10 && inp > 0 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
GEI4 $544
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $544
line 1308
;1308:	{
line 1309
;1309:		TeamFortress_SpyChangeSkin( inp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 TeamFortress_SpyChangeSkin
CALLV
pop
line 1310
;1310:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1311
;1311:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1312
;1312:	}
LABELV $544
line 1313
;1313:}
LABELV $543
endproc Menu_Spy_Skin_Input 4 4
export Menu_Spy_Color
proc Menu_Spy_Color 16 24
line 1315
;1314:void Menu_Spy_Color( menunum_t menu )
;1315:{
line 1316
;1316:	if ( !number_of_teams )
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 0
NEI4 $547
line 1317
;1317:	{
line 1318
;1318:		G_sprint( self, 2, "No Color changing allowed in deathmatch.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $549
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1319
;1319:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1320
;1320:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1321
;1321:		return;
ADDRGP4 $546
JUMPV
LABELV $547
line 1323
;1322:	}
;1323:	CenterPrint( self,
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $550
ARGP4
ADDRGP4 team_menu_strings+4
INDIRP4
ARGP4
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 1
LEI4 $555
ADDRLP4 0
CNSTI4 2
ASGNI4
ADDRGP4 $556
JUMPV
LABELV $555
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $556
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ADDRGP4 team_menu_strings
ADDP4
INDIRP4
ARGP4
ADDRGP4 number_of_teams
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $557
ADDRLP4 4
CNSTI4 3
ASGNI4
ADDRGP4 $558
JUMPV
LABELV $557
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $558
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_menu_strings
ADDP4
INDIRP4
ARGP4
ADDRGP4 number_of_teams
INDIRI4
CNSTI4 3
LEI4 $559
ADDRLP4 8
CNSTI4 4
ASGNI4
ADDRGP4 $560
JUMPV
LABELV $559
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $560
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_menu_strings
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1330
;1324:		     "=== Change Color to the Same Color as  ===\n\n%s\n%s\n%s\n%s\n\n",
;1325:		     team_menu_strings[1],
;1326:		     team_menu_strings[( number_of_teams > 1 ) ? 2 : 0],
;1327:		     team_menu_strings[( number_of_teams > 2 ) ? 3 : 0],
;1328:		     team_menu_strings[( number_of_teams > 3 ) ? 4 : 0] );
;1329:
;1330:}
LABELV $546
endproc Menu_Spy_Color 16 24
export Menu_Spy_Color_Input
proc Menu_Spy_Color_Input 4 4
line 1333
;1331:
;1332:void Menu_Spy_Color_Input( int inp )
;1333:{
line 1334
;1334:	if ( inp >= 1 && inp <= number_of_teams )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $562
ADDRLP4 0
INDIRI4
ADDRGP4 number_of_teams
INDIRI4
GTI4 $562
line 1335
;1335:	{
line 1336
;1336:		TeamFortress_SpyChangeColor( inp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 TeamFortress_SpyChangeColor
CALLV
pop
line 1337
;1337:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1338
;1338:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1339
;1339:	}
LABELV $562
line 1340
;1340:}
LABELV $561
endproc Menu_Spy_Color_Input 4 4
export Menu_NULL
proc Menu_NULL 0 0
line 1343
;1341:
;1342:void Menu_NULL( menunum_t menu )
;1343:{
line 1344
;1344:	self->current_menu = MENU_DEFAULT;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 1
ASGNI4
line 1345
;1345:}
LABELV $564
endproc Menu_NULL 0 0
data
export birthday_msgs
align 4
LABELV birthday_msgs
address $565
address $566
address $567
address $568
address $569
address $570
address $571
address $572
address $573
address $574
address $575
address $576
address $577
address $578
address $579
address $580
address $581
address $582
address $583
address $584
address $585
address $586
address $587
address $588
address $589
address $590
address $591
address $592
address $593
address $594
address $595
address $596
address $597
address $598
address $599
address $600
address $601
address $602
address $603
address $604
address $605
address $606
address $607
address $608
address $609
address $610
address $611
address $612
address $613
address $614
address $615
export num_birthday_msgs
align 4
LABELV num_birthday_msgs
byte 4 51
export BirthdayTimer
code
proc BirthdayTimer 36 20
line 1404
;1346:
;1347:
;1348:const char *birthday_msgs[] = {
;1349:	"\n\n\n\nHAPPY BIRTHDAY TEAMFORTRESS!\n",
;1350:	"\n\n\n\nCurrent number of Snipers on\nthe Battlements:\n%4d",
;1351:	"\n\n\n\nYeeha!\nThe 505,672nd detpack was\njust laid on the bridge!\n",
;1352:	"\n\n\n\nIs that an assault cannon in your\n pocket, or are you just playing TF?\n(Blame Ian)\n",
;1353:	"\n\n\n\n25,000 downloads\n50 donations\nDamn, but we rock!\n",
;1354:	"\n\n\n\nTeamFortress is one year old today!\n",
;1355:	"\n\n\n\nTF II available 2nd quarter 98\n",
;1356:	"\n\n\n\nhmm.... I wonder what the next\nmessage will be...\n",
;1357:	"\n\n\n\nKill your friends! Kill your family!\nSnipe your pets! Detpack your house!\nGet TF Now!\n",
;1358:	"\n\n\n\nDeath to Potatoes!\n",
;1359:	"\n\n\n\n\"You guys have really fucked up\n urinals, you know that?\"\n   - TyR in Australia\n",
;1360:	"\n\n\n\nMany potatoes were harmed in the\nmaking of this product.\n",
;1361:	"\n\n\n\nBAH! I shoulda put the Demoman\nblast armor back while I was at it!\n   - Gudlyf\n",
;1362:	"\n\n\n\nTwin Peaks will be out... uhh...\nerr... soon.\n",
;1363:	"\n\n\n\n\"Twin Peaks will be finished tomorrow.\"\n   - TyR, 16th July, 25th July, 2nd August...",
;1364:	"\n\n\n\n\"After all, TF is an INSULT to the\npurity of CTF!\"\n   - Mjollnir, who was joking... really!",
;1365:	"\n\n\n\n\"I force them to work.\nElse I cut back their supplies\"\n   - Vomitgod, on TFS\n",
;1366:	"\n\n\n\nI remember the good ol' days...\nwhen you had to use imin1 & imin2\nto join a team.\n",
;1367:	"\n\n\n\nI remember the good ol' days...\nwhen there were 2 TF servers...\nand they were always down.",
;1368:	"\n\n\n\nI remember the good ol' days...\nwhen no-one knew how to use\nhand grenades...\n",
;1369:	"\n\n\n\nI remember the good ol' days...\nwhen 2fort was the only TF map.\nWe sure have come a long\nway since then... sigh",
;1370:	"\n\n\n\nI remember the good ol' days...\nwhen the sniper rifle just\nkilled in one hit... everytime\n",
;1371:	"\n\n\n\nI remember the good ol' days...\nwhen I could download TF in\n1 minute 20 seconds\n",
;1372:	"\n\n\n\nI remember the good ol' days...\nwhen I didn't have to download\nANYTHING to play TF\n",
;1373:	"\n\n\n\nI remember the good ol' days...\nwhen players used to say\n\"What's that bubble?\"\n",
;1374:	"\n\n\n\nI remember the good ol' days...\nwhen The Well actually had a well...\n",
;1375:	"\n\n\n\nI remember the good ol' days...\nwhen the motion detector was officially\nthe Scout's best friend, at least\naccording to the readme.txt\n",
;1376:	"\n\n\n\nI remember the good ol' days...\nwhen  Ian went to jail for punching\nRobin out\n",
;1377:	"\n\n\n\nTF Newbie Quote #1:\nUmm... How do I set a detpack?\n",
;1378:	"\n\n\n\nTF Newbie Quote #2:\nUmm... How do I throw a grenade?\n",
;1379:	"\n\n\n\nTF Newbie Quote #3:\nHey, he is cheating, that soldier just jumped up to the roof!!\n",
;1380:	"\n\n\n\nTF Newbie Quote #4:\nHow do I throw the pins?\n",
;1381:	"\n\n\n\nTF Newbie Quote #5:\nWhere do I take the flag!?!?!\n",
;1382:	"\n\n\n\nTF Newbie Quote #6:\nWhere's the control room?\n",
;1383:	"\n\n\n\nTF Newbie Quote #7:\nWhy the hell are these backpacks\nexploding?\n",
;1384:	"\n\n\n\nTF Newbie Quote #8:\nWho's the maniac with the axe?\n",
;1385:	"\n\n\n\nTF Newbie Quote #9:\nStop shooting me!\nI'm on your team!\nYou tried to attack my with the axe!\n",
;1386:	"\n\n\n\nTF Newbie Quote #10:\nWhat's this key? I thought this\nwas a CTF style map, guys?\n",
;1387:	"\n\n\n\nTF Veteran Quote #1:\nUm, Red Medics, please don't\nheal the President.\n",
;1388:	"\n\n\n\nTF Veteran Quote #2:\nGuys could you NOT set up\nsentries in hunted?\n",
;1389:	"\n\n\n\nTF Veteran Quote #3:\nWho the hell is on\nthe lift?\n",
;1390:	"\n\n\n\nTF Veteran Quote #4:\nDISCARD!!\n",
;1391:	"\n\n\n\nTF Veteran Quote #5:\nDamn Snipers!\n",
;1392:	"\n\n\n\nTF Veteran Quote #6:\nDamn Snipers!\n",
;1393:	"\n\n\n\nTF Veteran Quote #7:\nGet a mask or\nget in the WATER!!\n",
;1394:	"\n\n\n\nTF Veteran Quote #8:\nSpy's, please change colors\noutside our base.\n",
;1395:	"\n\n\n\nTF Veteran Quote #9:\nI was typing!!\n",
;1396:	"\n\n\n\nTF Veteran Quote #10:\nWhy is that guy running\nout of our yard with\nthe flag???\n",
;1397:	"\n\n\n\nTF's original design docs!\nCheck it out!\nwww.teamfortress.com/files/teamfortress/tfdes_1.gif",
;1398:	"\n\n\n\nTF's original design docs!\nCheck it out!\nwww.teamfortress.com/files/teamfortress/tfdes_2.gif",
;1399:	"\n\n\n\n\"MJ: Did you hear John Cash wrote TF?\"\n   - VomitGod"
;1400:};
;1401:int     num_birthday_msgs = sizeof( birthday_msgs ) / sizeof( birthday_msgs[0] );
;1402:int     snipers_num;
;1403:void BirthdayTimer(  )
;1404:{
line 1408
;1405:	int     rnum;
;1406:	gedict_t *te;
;1407:
;1408:	if ( self->s.v.weapon > 5 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1084227584
LEF4 $617
line 1409
;1409:	{
line 1410
;1410:		self->s.v.weapon = 0;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 0
ASGNF4
line 1411
;1411:		self->s.v.nextthink = g_globalvars.time + 180 + g_random(  ) * 60;
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1127481344
ADDF4
CNSTF4 1114636288
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1412
;1412:		rnum = ( int ) ( g_random(  ) * num_birthday_msgs );
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 12
INDIRF4
ADDRGP4 num_birthday_msgs
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 1413
;1413:		self->team_str_home = NULL;
ADDRGP4 self
INDIRP4
CNSTI4 1284
ADDP4
CNSTP4 0
ASGNP4
line 1414
;1414:		if ( rnum == 1 )
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $620
line 1415
;1415:		{
line 1416
;1416:			snipers_num = TeamFortress_GetNoPlayers(  ) / 2;
ADDRLP4 16
ADDRGP4 TeamFortress_GetNoPlayers
CALLI4
ASGNI4
ADDRGP4 snipers_num
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 1417
;1417:			snipers_num = snipers_num * ( g_random(  ) + 1 );
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 24
ADDRGP4 snipers_num
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CVIF4 4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
CVFI4 4
ASGNI4
line 1418
;1418:		}
LABELV $620
line 1419
;1419:		self->team_str_moved = ( char * ) birthday_msgs[rnum];
ADDRGP4 self
INDIRP4
CNSTI4 1288
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 birthday_msgs
ADDP4
INDIRP4
ASGNP4
line 1420
;1420:	} else
ADDRGP4 $618
JUMPV
LABELV $617
line 1421
;1421:	{
line 1422
;1422:		self->s.v.nextthink = g_globalvars.time + 1.5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1069547520
ADDF4
ASGNF4
line 1423
;1423:		self->s.v.weapon += 1;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1424
;1424:	}
LABELV $618
line 1425
;1425:	for ( te = world; ( te = trap_find( te, FOFS( s.v.classname ), "player" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $626
JUMPV
LABELV $623
line 1426
;1426:	{
line 1427
;1427:		G_centerprint( te, self->team_str_moved, snipers_num );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 1288
ADDP4
INDIRP4
ARGP4
ADDRGP4 snipers_num
INDIRI4
ARGI4
ADDRGP4 G_centerprint
CALLV
pop
line 1428
;1428:		if ( self->s.v.weapon == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $627
line 1429
;1429:			sound( te, 3, "misc/b1.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $629
ARGP4
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
ADDRGP4 $628
JUMPV
LABELV $627
line 1431
;1430:		else
;1431:		{
line 1432
;1432:			if ( self->s.v.weapon <= 4 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1082130432
GTF4 $630
line 1433
;1433:			{
line 1434
;1434:				switch ( ( int ) ( g_random(  ) * 3 ) )
ADDRLP4 16
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 12
CNSTF4 1077936128
ADDRLP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $635
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $637
ADDRGP4 $632
JUMPV
line 1435
;1435:				{
LABELV $635
line 1437
;1436:				case 0:
;1437:					sound( te, 3, "misc/b2.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $636
ARGP4
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 1438
;1438:					break;
ADDRGP4 $633
JUMPV
LABELV $637
line 1440
;1439:				case 1:
;1440:					sound( te, 3, "misc/b3.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $638
ARGP4
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 1441
;1441:					break;
ADDRGP4 $633
JUMPV
LABELV $632
line 1443
;1442:				default:
;1443:					sound( te, 3, "misc/b4.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $639
ARGP4
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 1444
;1444:					break;
LABELV $633
line 1446
;1445:				}
;1446:			}
LABELV $630
line 1447
;1447:		}
LABELV $628
line 1449
;1448:
;1449:	}
LABELV $624
line 1425
LABELV $626
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $259
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
NEU4 $623
line 1450
;1450:}
LABELV $616
endproc BirthdayTimer 36 20
export Menu_BirthDay
proc Menu_BirthDay 0 8
line 1453
;1451:
;1452:void Menu_BirthDay( menunum_t menu )
;1453:{
line 1454
;1454:	if ( self->current_menu == MENU_BIRTHDAY2 )
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
CNSTI4 24
NEI4 $641
line 1455
;1455:		CenterPrint( self, "3rd Impulse\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $643
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $642
JUMPV
LABELV $641
line 1457
;1456:	else
;1457:	{
line 1458
;1458:		if ( self->current_menu == MENU_BIRTHDAY3 )
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
CNSTI4 25
NEI4 $644
line 1459
;1459:			CenterPrint( self, "4th Impulse\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $646
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $644
line 1460
;1460:	}
LABELV $642
line 1462
;1461:
;1462:}
LABELV $640
endproc Menu_BirthDay 0 8
export Menu_BirthDay_Input
proc Menu_BirthDay_Input 20 12
line 1465
;1463:
;1464:void Menu_BirthDay_Input( int inp )
;1465:{
line 1468
;1466:	gedict_t *te;
;1467:
;1468:	switch ( self->current_menu )
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 23
EQI4 $651
ADDRLP4 4
INDIRI4
CNSTI4 24
EQI4 $654
ADDRLP4 4
INDIRI4
CNSTI4 25
EQI4 $657
ADDRGP4 $648
JUMPV
line 1469
;1469:	{
LABELV $651
line 1471
;1470:	case MENU_BIRTHDAY1:
;1471:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1472
;1472:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1473
;1473:		if ( inp == 98 )
ADDRFP4 0
INDIRI4
CNSTI4 98
NEI4 $649
line 1474
;1474:			self->current_menu = MENU_BIRTHDAY2;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 24
ASGNI4
line 1475
;1475:		break;
ADDRGP4 $649
JUMPV
LABELV $654
line 1477
;1476:	case MENU_BIRTHDAY2:
;1477:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1478
;1478:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1479
;1479:		if ( inp == 156 )
ADDRFP4 0
INDIRI4
CNSTI4 156
NEI4 $649
line 1480
;1480:			self->current_menu = MENU_BIRTHDAY3;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 25
ASGNI4
line 1481
;1481:		break;
ADDRGP4 $649
JUMPV
LABELV $657
line 1484
;1482:
;1483:	case MENU_BIRTHDAY3:
;1484:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1485
;1485:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1486
;1486:		if ( inp != 96 )
ADDRFP4 0
INDIRI4
CNSTI4 96
EQI4 $658
line 1487
;1487:			break;
ADDRGP4 $649
JUMPV
LABELV $658
line 1488
;1488:		tf_data.birthday = 1;
ADDRGP4 tf_data+92
CNSTI4 1
ASGNI4
line 1489
;1489:		localcmd( "localinfo birthday on\n" );
ADDRGP4 $661
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 1490
;1490:		G_bprint( 2, "IT'S PARTY TIME\n" );
CNSTI4 2
ARGI4
ADDRGP4 $662
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 1491
;1491:		for ( te = world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $666
JUMPV
LABELV $663
line 1493
;1492:		      ( te = trap_find( te, FOFS( s.v.classname ), "player" ) ); )
;1493:			CenterPrint( te, "\n\nHAPPY BIRTHDAY TEAMFORTRESS!\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $667
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $664
line 1492
LABELV $666
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $259
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
NEU4 $663
line 1494
;1494:		te = spawn(  );
ADDRLP4 16
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1495
;1495:		te->s.v.weapon = 10;
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1092616192
ASGNF4
line 1496
;1496:		te->s.v.nextthink = g_globalvars.time + 60;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1497
;1497:		te->s.v.think = ( func_t ) BirthdayTimer;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 BirthdayTimer
CVPU4 4
CVUI4 4
ASGNI4
line 1498
;1498:		break;
LABELV $648
LABELV $649
line 1500
;1499:	}
;1500:}
LABELV $647
endproc Menu_BirthDay_Input 20 12
export TG_Main_Menu
proc TG_Main_Menu 0 8
line 1503
;1501:
;1502:void TG_Main_Menu( menunum_t menu )
;1503:{
line 1504
;1504:	CenterPrint( self, "Options:\n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $670
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1511
;1505:		     "1) SG options                 \n"
;1506:		     "2) Detpack option             \n"
;1507:		     "3) Cheats                     \n"
;1508:		     "4) Load defaults              \n"
;1509:		     "5) Saved position             \n"
;1510:		     "7) Nothing                    \n" );
;1511:}
LABELV $669
endproc TG_Main_Menu 0 8
export TG_Main_Menu_Input
proc TG_Main_Menu_Input 4 0
line 1514
;1512:
;1513:void TG_Main_Menu_Input( int inp )
;1514:{
line 1515
;1515:	switch ( inp )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $671
ADDRLP4 0
INDIRI4
CNSTI4 7
GTI4 $671
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $680-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $680
address $674
address $675
address $676
address $677
address $678
address $671
address $679
code
line 1516
;1516:	{
LABELV $674
line 1518
;1517:	case 1:
;1518:		self->current_menu = TG_MENU_SG;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 27
ASGNI4
line 1519
;1519:		break;
ADDRGP4 $673
JUMPV
LABELV $675
line 1521
;1520:	case 2:
;1521:		self->current_menu = TG_MENU_DETPACK;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 28
ASGNI4
line 1522
;1522:		break;
ADDRGP4 $673
JUMPV
LABELV $676
line 1524
;1523:	case 3:
;1524:		self->current_menu = TG_MENU_CHEATS;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 29
ASGNI4
line 1525
;1525:		break;
ADDRGP4 $673
JUMPV
LABELV $677
line 1527
;1526:	case 4:
;1527:		TG_LoadSettings(  );
ADDRGP4 TG_LoadSettings
CALLV
pop
line 1528
;1528:		break;
ADDRGP4 $673
JUMPV
LABELV $678
line 1530
;1529:	case 5:
;1530:		self->current_menu = TG_MENU_POSITION;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 30
ASGNI4
line 1531
;1531:		break;
ADDRGP4 $673
JUMPV
LABELV $679
line 1533
;1532:	case 7:
;1533:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1534
;1534:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1535
;1535:		break;
line 1537
;1536:	default:
;1537:		return;
LABELV $673
line 1540
;1538:	}
;1539:
;1540:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1541
;1541:	self->menu_count = 23;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 23
ASGNI4
line 1543
;1542:
;1543:}
LABELV $671
endproc TG_Main_Menu_Input 4 0
data
export sentry_sfire_names
align 4
LABELV sentry_sfire_names
address $682
address $683
address $684
address $685
export sentry_find_names
align 4
LABELV sentry_find_names
address $686
address $687
address $688
address $689
export TG_SGOptions_Menu
code
proc TG_SGOptions_Menu 108 40
line 1565
;1544:
;1545:const char *sentry_sfire_names[] = {
;1546:	"4) Sentry Shells Fire: NEW    \n",
;1547:	"4) Sentry Shells Fire: 2.8.1  \n",
;1548:	"4) Sentry Shells Fire: MTFL1  \n",
;1549:	"4) Sentry Shells Fire: MTFL2  \n"
;1550:};
;1551:
;1552:const char *sentry_find_names[] = {
;1553:	"6)Üignore teammates           \n",
;1554:	"6)àignore owner               \n",
;1555:	"6)âignore OFF                 \n",
;1556:	"6)áignore all targets         \n",
;1557:};
;1558:
;1559:/*const char *sentry_firetype_names[] = {
;1560:	"7) Fire bullets & rockets     \n",
;1561:	"7) Fire bullets               \n",
;1562:	"7) Fire lightning (no damage) \n"
;1563:};*/
;1564:void TG_SGOptions_Menu( menunum_t menu )
;1565:{
line 1570
;1566:	const char *s_sg_newfind, *s_sg_sfire, *s_sg_find, *s_sgfiretype, *s_sbar,*s_sg_unlimit_ammo;
;1567:	char    s_sgppl[80];
;1568:	const char *s_sg_rfire;
;1569:
;1570:	if ( tf_data.sg_newfind )
ADDRGP4 tf_data+108
INDIRI4
CNSTI4 0
EQI4 $691
line 1571
;1571:	{
line 1572
;1572:		s_sg_newfind = "1)âSentry New Find Target ON  \n";
ADDRLP4 80
ADDRGP4 $694
ASGNP4
line 1573
;1573:		_snprintf( s_sgppl, sizeof( s_sgppl ), "       %3d ppl emulation      \n",
ADDRLP4 0
ARGP4
CNSTI4 80
ARGI4
ADDRGP4 $695
ARGP4
ADDRGP4 tf_data+120
INDIRI4
ARGI4
ADDRGP4 _snprintf
CALLI4
pop
line 1575
;1574:			   tf_data.sgppl );
;1575:	} else
ADDRGP4 $692
JUMPV
LABELV $691
line 1576
;1576:	{
line 1577
;1577:		s_sg_newfind = "1)áSentry New Find Target OFF \n";
ADDRLP4 80
ADDRGP4 $697
ASGNP4
line 1578
;1578:		_snprintf( s_sgppl, sizeof( s_sgppl ), "\n" );
ADDRLP4 0
ARGP4
CNSTI4 80
ARGI4
ADDRGP4 $37
ARGP4
ADDRGP4 _snprintf
CALLI4
pop
line 1579
;1579:	}
LABELV $692
line 1580
;1580:	if ( tf_data.sg_rfire )
ADDRGP4 tf_data+116
INDIRI4
CNSTI4 0
EQI4 $698
line 1581
;1581:		s_sg_rfire = "3)âSentry Rocket Fire: NEW    \n";
ADDRLP4 104
ADDRGP4 $701
ASGNP4
ADDRGP4 $699
JUMPV
LABELV $698
line 1583
;1582:	else
;1583:		s_sg_rfire = "3)áSentry Rocket Fire: OLD    \n";
ADDRLP4 104
ADDRGP4 $702
ASGNP4
LABELV $699
line 1585
;1584:
;1585:	if ( tg_data.sg_unlimit_ammo )
ADDRGP4 tg_data+60
INDIRI4
CNSTI4 0
EQI4 $703
line 1586
;1586:		s_sg_unlimit_ammo = "5)âUnlimited ammo ON          \n";
ADDRLP4 100
ADDRGP4 $706
ASGNP4
ADDRGP4 $704
JUMPV
LABELV $703
line 1588
;1587:	else
;1588:		s_sg_unlimit_ammo = "5)áUnlimited ammo OFF         \n";
ADDRLP4 100
ADDRGP4 $707
ASGNP4
LABELV $704
line 1591
;1589:
;1590:
;1591:	if ( tf_data.sg_sfire >= SG_SFIRE_NUM )
ADDRGP4 tf_data+112
INDIRI4
CNSTI4 4
LTI4 $708
line 1592
;1592:		tf_data.sg_sfire = 0;
ADDRGP4 tf_data+112
CNSTI4 0
ASGNI4
LABELV $708
line 1593
;1593:	s_sg_sfire = sentry_sfire_names[tf_data.sg_sfire];
ADDRLP4 84
ADDRGP4 tf_data+112
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sentry_sfire_names
ADDP4
INDIRP4
ASGNP4
line 1595
;1594:
;1595:	if ( tg_data.sg_allow_find >= TG_SG_FIND_IGNORE_NUM )
ADDRGP4 tg_data+40
INDIRI4
CNSTI4 4
LTI4 $713
line 1596
;1596:		tg_data.sg_allow_find = TG_SG_FIND_IGNORE_TEAM;
ADDRGP4 tg_data+40
CNSTI4 0
ASGNI4
LABELV $713
line 1598
;1597:
;1598:	s_sg_find = sentry_find_names[tg_data.sg_allow_find];
ADDRLP4 88
ADDRGP4 tg_data+40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sentry_find_names
ADDP4
INDIRP4
ASGNP4
line 1604
;1599:
;1600:/*REMOVE!!!
;1601:  if(tg_data.sg_fire_type >= TG_SG_FIRE_NUM)
;1602:  	tg_data.sg_fire_type = TG_SG_FIRE_NORMAL;
;1603:  s_sgfiretype = sentry_firetype_names[tg_data.sg_fire_type];*/
;1604:	s_sgfiretype = "7) Fire type                  \n";
ADDRLP4 92
ADDRGP4 $718
ASGNP4
line 1605
;1605:	if ( tg_data.tg_sbar )
ADDRGP4 tg_data+64
INDIRI4
CNSTI4 0
EQI4 $719
line 1606
;1606:		s_sbar = "8)âEng Sbar for All           \n";
ADDRLP4 96
ADDRGP4 $722
ASGNP4
ADDRGP4 $720
JUMPV
LABELV $719
line 1608
;1607:	else
;1608:		s_sbar = "8)áLimited Eng Sbar           \n";
ADDRLP4 96
ADDRGP4 $723
ASGNP4
LABELV $720
line 1610
;1609:
;1610:	CenterPrint( self, "Sentry Gun Options:\n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $724
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1616
;1611:		     "%s%s%s%s"
;1612:		     "%s%s%s%s"
;1613:		     "9) Nothing                    \n",
;1614:		     s_sg_newfind, s_sgppl, s_sg_rfire, s_sg_sfire,
;1615:		     s_sg_unlimit_ammo, s_sg_find, s_sgfiretype, s_sbar );
;1616:}
LABELV $690
endproc TG_SGOptions_Menu 108 40
export TG_SGOptions_Menu_Input
proc TG_SGOptions_Menu_Input 36 0
line 1618
;1617:void TG_SGOptions_Menu_Input( int inp )
;1618:{
line 1619
;1619:	switch ( inp )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $725
ADDRLP4 0
INDIRI4
CNSTI4 9
GTI4 $725
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $764-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $764
address $728
address $725
address $734
address $740
address $745
address $751
address $756
address $757
address $763
code
line 1620
;1620:	{
LABELV $728
line 1622
;1621:	case 1:
;1622:		tf_data.sg_newfind = ( tf_data.sg_newfind ) ? 0 : 1;
ADDRGP4 tf_data+108
INDIRI4
CNSTI4 0
EQI4 $732
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $733
JUMPV
LABELV $732
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $733
ADDRGP4 tf_data+108
ADDRLP4 4
INDIRI4
ASGNI4
line 1623
;1623:		break;
ADDRGP4 $727
JUMPV
LABELV $734
line 1637
;1624:/*REMOVE!!!
;1625:		case 3:
;1626:			if( tf_data.sg_newfind )
;1627:				tf_data.sgppl++;
;1628:			break;	
;1629:		case 2:
;1630:			if( tf_data.sg_newfind )
;1631:			{
;1632:				 if(tf_data.sgppl)
;1633:				 	tf_data.sgppl--;
;1634:			}
;1635:			break;	*/
;1636:	case 3:
;1637:		tf_data.sg_rfire = ( tf_data.sg_rfire ) ? 0 : 1;
ADDRGP4 tf_data+116
INDIRI4
CNSTI4 0
EQI4 $738
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $739
JUMPV
LABELV $738
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $739
ADDRGP4 tf_data+116
ADDRLP4 8
INDIRI4
ASGNI4
line 1638
;1638:		break;
ADDRGP4 $727
JUMPV
LABELV $740
line 1640
;1639:	case 4:
;1640:		if ( ++( tf_data.sg_sfire ) >= SG_SFIRE_NUM )
ADDRLP4 12
ADDRGP4 tf_data+112
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 4
LTI4 $727
line 1641
;1641:			tf_data.sg_sfire = 0;
ADDRGP4 tf_data+112
CNSTI4 0
ASGNI4
line 1642
;1642:		break;
ADDRGP4 $727
JUMPV
LABELV $745
line 1644
;1643:	case 5:
;1644:	        tg_data.sg_unlimit_ammo = ( tg_data.sg_unlimit_ammo ) ? false : true;
ADDRGP4 tg_data+60
INDIRI4
CNSTI4 0
EQI4 $749
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $750
JUMPV
LABELV $749
ADDRLP4 20
CNSTI4 1
ASGNI4
LABELV $750
ADDRGP4 tg_data+60
ADDRLP4 20
INDIRI4
ASGNI4
line 1645
;1645:		break;
ADDRGP4 $727
JUMPV
LABELV $751
line 1647
;1646:	case 6:
;1647:		if ( ++( tg_data.sg_allow_find ) >= TG_SG_FIND_IGNORE_NUM )
ADDRLP4 24
ADDRGP4 tg_data+40
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 4
LTI4 $727
line 1648
;1648:			tg_data.sg_allow_find = 0;
ADDRGP4 tg_data+40
CNSTI4 0
ASGNI4
line 1649
;1649:		break;
ADDRGP4 $727
JUMPV
LABELV $756
line 1651
;1650:	case 7:
;1651:		self->current_menu = TG_MENU_SG_FIRE;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 31
ASGNI4
line 1655
;1652:/*			if( ++(tg_data.sg_fire_type) >= TG_SG_FIRE_NUM)
;1653:				tg_data.sg_fire_type = 0;*/
;1654:
;1655:		break;
ADDRGP4 $727
JUMPV
LABELV $757
line 1657
;1656:	case 8:
;1657:		tg_data.tg_sbar = ( tg_data.tg_sbar ) ? 0 : 1;
ADDRGP4 tg_data+64
INDIRI4
CNSTI4 0
EQI4 $761
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 $762
JUMPV
LABELV $761
ADDRLP4 32
CNSTI4 1
ASGNI4
LABELV $762
ADDRGP4 tg_data+64
ADDRLP4 32
INDIRI4
ASGNI4
line 1658
;1658:		break;
ADDRGP4 $727
JUMPV
LABELV $763
line 1660
;1659:	case 9:
;1660:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1661
;1661:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1662
;1662:		break;
line 1664
;1663:	default:
;1664:		return;
LABELV $727
line 1667
;1665:	}
;1666:
;1667:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1668
;1668:	self->menu_count = 23;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 23
ASGNI4
line 1669
;1669:}
LABELV $725
endproc TG_SGOptions_Menu_Input 36 0
export TG_SG_Fire_Menu
proc TG_SG_Fire_Menu 28 24
line 1672
;1670:
;1671:void TG_SG_Fire_Menu( menunum_t menu )
;1672:{
line 1675
;1673:	const char *s_sg_firebullets, *s_sg_firerockets, *s_sg_firelighting, *s_sg_fire;
;1674:
;1675:	s_sg_firebullets = ( tg_data.sg_fire_bullets ) ?
ADDRGP4 tg_data+48
INDIRI4
CNSTI4 0
EQI4 $771
ADDRLP4 16
ADDRGP4 $768
ASGNP4
ADDRGP4 $772
JUMPV
LABELV $771
ADDRLP4 16
ADDRGP4 $769
ASGNP4
LABELV $772
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1677
;1676:	    "2)âFire bullets ON            \n" : "2)áFire bullets OFF           \n";
;1677:	s_sg_firerockets = ( tg_data.sg_fire_rockets ) ?
ADDRGP4 tg_data+52
INDIRI4
CNSTI4 0
EQI4 $777
ADDRLP4 20
ADDRGP4 $774
ASGNP4
ADDRGP4 $778
JUMPV
LABELV $777
ADDRLP4 20
ADDRGP4 $775
ASGNP4
LABELV $778
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 1679
;1678:	    "3)âFire rockets ON            \n" : "3)áFire rockets OFF           \n";
;1679:	s_sg_firelighting = ( tg_data.sg_fire_lighting ) ?
ADDRGP4 tg_data+56
INDIRI4
CNSTI4 0
EQI4 $783
ADDRLP4 24
ADDRGP4 $780
ASGNP4
ADDRGP4 $784
JUMPV
LABELV $783
ADDRLP4 24
ADDRGP4 $781
ASGNP4
LABELV $784
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 1682
;1680:	    "4)âFire lighting ON           \n" : "4)áFire lighting OFF          \n";
;1681:
;1682:	if ( !tg_data.sg_disable_fire )
ADDRGP4 tg_data+44
INDIRI4
CNSTI4 0
NEI4 $785
line 1683
;1683:		s_sg_fire = "1)âfire ON                    \n";
ADDRLP4 12
ADDRGP4 $788
ASGNP4
ADDRGP4 $786
JUMPV
LABELV $785
line 1685
;1684:	else
;1685:		s_sg_fire = "1)áfire OFF                   \n";
ADDRLP4 12
ADDRGP4 $789
ASGNP4
LABELV $786
line 1687
;1686:
;1687:	CenterPrint( self, "Sentry Gun Fire type:\n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $790
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1692
;1688:		           "%s%s%s%s" 
;1689:		           "5) Nothing                    \n", 
;1690:		           s_sg_fire,s_sg_firebullets, s_sg_firerockets, s_sg_firelighting);
;1691:
;1692:}
LABELV $766
endproc TG_SG_Fire_Menu 28 24
export TG_SG_Fire_Menu_Input
proc TG_SG_Fire_Menu_Input 20 0
line 1694
;1693:void TG_SG_Fire_Menu_Input( int inp )
;1694:{
line 1695
;1695:	switch ( inp )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $791
ADDRLP4 0
INDIRI4
CNSTI4 5
GTI4 $791
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $819-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $819
address $794
address $800
address $806
address $812
address $818
code
line 1696
;1696:	{
LABELV $794
line 1698
;1697:	case 1:
;1698:		tg_data.sg_disable_fire = ( tg_data.sg_disable_fire ) ? 0 : 1;
ADDRGP4 tg_data+44
INDIRI4
CNSTI4 0
EQI4 $798
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $799
JUMPV
LABELV $798
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $799
ADDRGP4 tg_data+44
ADDRLP4 4
INDIRI4
ASGNI4
line 1699
;1699:		break;
ADDRGP4 $793
JUMPV
LABELV $800
line 1701
;1700:	case 2:
;1701:		tg_data.sg_fire_bullets = ( tg_data.sg_fire_bullets ) ? false : true;
ADDRGP4 tg_data+48
INDIRI4
CNSTI4 0
EQI4 $804
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $805
JUMPV
LABELV $804
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $805
ADDRGP4 tg_data+48
ADDRLP4 8
INDIRI4
ASGNI4
line 1702
;1702:		break;
ADDRGP4 $793
JUMPV
LABELV $806
line 1704
;1703:	case 3:
;1704:		tg_data.sg_fire_rockets = ( tg_data.sg_fire_rockets ) ? false : true;
ADDRGP4 tg_data+52
INDIRI4
CNSTI4 0
EQI4 $810
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $811
JUMPV
LABELV $810
ADDRLP4 12
CNSTI4 1
ASGNI4
LABELV $811
ADDRGP4 tg_data+52
ADDRLP4 12
INDIRI4
ASGNI4
line 1705
;1705:		break;
ADDRGP4 $793
JUMPV
LABELV $812
line 1707
;1706:	case 4:
;1707:		tg_data.sg_fire_lighting = ( tg_data.sg_fire_lighting ) ? false : true;
ADDRGP4 tg_data+56
INDIRI4
CNSTI4 0
EQI4 $816
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $817
JUMPV
LABELV $816
ADDRLP4 16
CNSTI4 1
ASGNI4
LABELV $817
ADDRGP4 tg_data+56
ADDRLP4 16
INDIRI4
ASGNI4
line 1708
;1708:		break;
ADDRGP4 $793
JUMPV
LABELV $818
line 1710
;1709:	case 5:
;1710:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1711
;1711:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1712
;1712:		break;
line 1714
;1713:	default:
;1714:		return;
LABELV $793
line 1717
;1715:	}
;1716:
;1717:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1718
;1718:	self->menu_count = 23;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 23
ASGNI4
line 1719
;1719:}
LABELV $791
endproc TG_SG_Fire_Menu_Input 20 0
export TG_Detpack_Menu
proc TG_Detpack_Menu 20 24
line 1722
;1720:
;1721:void TG_Detpack_Menu( menunum_t menu )
;1722:{
line 1725
;1723:	char   *s_clip, *s_disarm, *s_drop, *s_block;
;1724:
;1725:	switch ( tg_data.detpack_clip )
ADDRLP4 16
ADDRGP4 tg_data+20
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $829
ADDRLP4 16
INDIRI4
CNSTI4 1
EQI4 $827
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $825
ADDRGP4 $822
JUMPV
line 1726
;1726:	{
LABELV $825
line 1728
;1727:	case TG_DETPACK_SOLID_ALL:
;1728:		s_clip = "1)âdetpack clip is ALL        \n";
ADDRLP4 12
ADDRGP4 $826
ASGNP4
line 1729
;1729:		break;
ADDRGP4 $823
JUMPV
LABELV $827
line 1732
;1730:
;1731:	case TG_DETPACK_CLIP_ALL:
;1732:		s_clip = "1)ádetpack clip is OFF        \n";
ADDRLP4 12
ADDRGP4 $828
ASGNP4
line 1733
;1733:		break;
ADDRGP4 $823
JUMPV
LABELV $829
LABELV $822
line 1737
;1734:
;1735:	case TG_DETPACK_CLIP_OWNER:
;1736:	default:
;1737:		s_clip = "1)àdetpack clip is ON         \n";
ADDRLP4 12
ADDRGP4 $830
ASGNP4
line 1738
;1738:		break;
LABELV $823
line 1740
;1739:	}
;1740:	if ( tg_data.disable_disarm )
ADDRGP4 tg_data+28
INDIRI4
CNSTI4 0
EQI4 $831
line 1741
;1741:		s_disarm = "2)ádon't disarm detpacks      \n";
ADDRLP4 0
ADDRGP4 $834
ASGNP4
ADDRGP4 $832
JUMPV
LABELV $831
line 1743
;1742:	else
;1743:		s_disarm = "2)âdisarm detpacks            \n";
ADDRLP4 0
ADDRGP4 $835
ASGNP4
LABELV $832
line 1745
;1744:
;1745:	if ( tg_data.detpack_drop )
ADDRGP4 tg_data+24
INDIRI4
CNSTI4 0
EQI4 $836
line 1746
;1746:		s_drop = "3)âdrop detpacks              \n";
ADDRLP4 4
ADDRGP4 $839
ASGNP4
ADDRGP4 $837
JUMPV
LABELV $836
line 1748
;1747:	else
;1748:		s_drop = "3)ádon't drop detpacks        \n";
ADDRLP4 4
ADDRGP4 $840
ASGNP4
LABELV $837
line 1750
;1749:
;1750:	if ( tf_data.detpack_block )
ADDRGP4 tf_data+168
INDIRI4
CNSTI4 0
EQI4 $841
line 1751
;1751:		s_block = "4)áStack detpacks: TF2003     \n";
ADDRLP4 8
ADDRGP4 $844
ASGNP4
ADDRGP4 $842
JUMPV
LABELV $841
line 1753
;1752:	else
;1753:		s_block = "4)âStack detpacks: TF 2.8.1   \n";
ADDRLP4 8
ADDRGP4 $845
ASGNP4
LABELV $842
line 1755
;1754:
;1755:	CenterPrint( self, "Detpack options:\n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $846
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1759
;1756:		     "%s%s%s%s"
;1757:		     "5) Nothing                    \n",
;1758:		     s_clip, s_disarm, s_drop, s_block );
;1759:}
LABELV $821
endproc TG_Detpack_Menu 20 24
export TG_Detpack_Menu_Input
proc TG_Detpack_Menu_Input 24 0
line 1763
;1760:
;1761:void    Detpack_SetClip(  );
;1762:void TG_Detpack_Menu_Input( int inp )
;1763:{
line 1764
;1764:	switch ( inp )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $847
ADDRLP4 0
INDIRI4
CNSTI4 5
GTI4 $847
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $874-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $874
address $850
address $855
address $861
address $867
address $873
code
line 1765
;1765:	{
LABELV $850
line 1767
;1766:	case 1:
;1767:		if ( ++( tg_data.detpack_clip ) >= TG_DETPACK_CLIP_NUM )
ADDRLP4 4
ADDRGP4 tg_data+20
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 3
LTI4 $851
line 1768
;1768:			tg_data.detpack_clip = 0;
ADDRGP4 tg_data+20
CNSTI4 0
ASGNI4
LABELV $851
line 1769
;1769:		Detpack_SetClip(  );
ADDRGP4 Detpack_SetClip
CALLV
pop
line 1770
;1770:		break;
ADDRGP4 $849
JUMPV
LABELV $855
line 1772
;1771:	case 2:
;1772:		tg_data.disable_disarm = ( tg_data.disable_disarm ) ? 0 : 1;
ADDRGP4 tg_data+28
INDIRI4
CNSTI4 0
EQI4 $859
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $860
JUMPV
LABELV $859
ADDRLP4 12
CNSTI4 1
ASGNI4
LABELV $860
ADDRGP4 tg_data+28
ADDRLP4 12
INDIRI4
ASGNI4
line 1773
;1773:		break;
ADDRGP4 $849
JUMPV
LABELV $861
line 1775
;1774:	case 3:
;1775:		tg_data.detpack_drop = ( tg_data.detpack_drop ) ? 0 : 1;
ADDRGP4 tg_data+24
INDIRI4
CNSTI4 0
EQI4 $865
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $866
JUMPV
LABELV $865
ADDRLP4 16
CNSTI4 1
ASGNI4
LABELV $866
ADDRGP4 tg_data+24
ADDRLP4 16
INDIRI4
ASGNI4
line 1776
;1776:		break;
ADDRGP4 $849
JUMPV
LABELV $867
line 1778
;1777:	case 4:
;1778:		tf_data.detpack_block = ( tf_data.detpack_block ) ? 0 : 1;
ADDRGP4 tf_data+168
INDIRI4
CNSTI4 0
EQI4 $871
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $872
JUMPV
LABELV $871
ADDRLP4 20
CNSTI4 1
ASGNI4
LABELV $872
ADDRGP4 tf_data+168
ADDRLP4 20
INDIRI4
ASGNI4
line 1779
;1779:		break;
ADDRGP4 $849
JUMPV
LABELV $873
line 1781
;1780:	case 5:
;1781:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1782
;1782:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1783
;1783:		break;
line 1785
;1784:	default:
;1785:		return;
LABELV $849
line 1788
;1786:	}
;1787:
;1788:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1789
;1789:	self->menu_count = 23;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 23
ASGNI4
line 1790
;1790:}
LABELV $847
endproc TG_Detpack_Menu_Input 24 0
export TG_Cheats_Menu
proc TG_Cheats_Menu 40 32
line 1793
;1791:
;1792:void TG_Cheats_Menu( menunum_t menu )
;1793:{
line 1796
;1794:	char   *s_gren_effect, *s_gren_time;
;1795:
;1796:	switch ( tg_data.gren_effect )
ADDRLP4 8
ADDRGP4 tg_data+32
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $885
ADDRLP4 8
INDIRI4
CNSTI4 1
EQI4 $881
ADDRLP4 8
INDIRI4
CNSTI4 2
EQI4 $883
ADDRGP4 $877
JUMPV
line 1797
;1797:	{
LABELV $881
line 1799
;1798:	case TG_GREN_EFFECT_OFF:
;1799:		s_gren_effect = "3)áGrenade effect OFF         \n";
ADDRLP4 0
ADDRGP4 $882
ASGNP4
line 1800
;1800:		break;
ADDRGP4 $878
JUMPV
LABELV $883
line 1803
;1801:
;1802:	case TG_GREN_EFFECT_OFF_FORSELF:
;1803:		s_gren_effect = "3)àGrenade effect OFF for self\n";
ADDRLP4 0
ADDRGP4 $884
ASGNP4
line 1804
;1804:		break;
ADDRGP4 $878
JUMPV
LABELV $885
LABELV $877
line 1808
;1805:
;1806:	case TG_GREN_EFFECT_ON:
;1807:	default:
;1808:		s_gren_effect = "3)âGrenade effect ON          \n";
ADDRLP4 0
ADDRGP4 $886
ASGNP4
line 1809
;1809:		break;
LABELV $878
line 1812
;1810:
;1811:	}
;1812:	switch ( tg_data.gren_time )
ADDRLP4 16
ADDRGP4 tg_data+36
INDIRI4
ASGNI4
ADDRLP4 20
CNSTI4 5
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $892
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
GTI4 $897
LABELV $896
ADDRGP4 tg_data+36
INDIRI4
CNSTI4 0
EQI4 $890
ADDRGP4 $887
JUMPV
LABELV $897
ADDRGP4 tg_data+36
INDIRI4
CNSTI4 10
EQI4 $894
ADDRGP4 $887
JUMPV
line 1813
;1813:	{
LABELV $890
LABELV $887
line 1817
;1814:
;1815:	case 0:
;1816:	default:
;1817:		s_gren_time = "4)âGrenade effect time: full  \n";
ADDRLP4 4
ADDRGP4 $891
ASGNP4
line 1818
;1818:		break;
ADDRGP4 $888
JUMPV
LABELV $892
line 1820
;1819:	case 5:
;1820:		s_gren_time = "4)áGrenade effect time: 5 sec \n";
ADDRLP4 4
ADDRGP4 $893
ASGNP4
line 1821
;1821:		break;
ADDRGP4 $888
JUMPV
LABELV $894
line 1823
;1822:	case 10:
;1823:		s_gren_time = "4)àGrenade effect time: 10 sec\n";
ADDRLP4 4
ADDRGP4 $895
ASGNP4
line 1824
;1824:		break;
LABELV $888
line 1827
;1825:
;1826:	}
;1827:	CenterPrint( self, "Cheats menu:\n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $898
ARGP4
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
EQI4 $915
ADDRLP4 24
ADDRGP4 $900
ASGNP4
ADDRGP4 $916
JUMPV
LABELV $915
ADDRLP4 24
ADDRGP4 $901
ASGNP4
LABELV $916
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 tg_data+12
INDIRI4
CNSTI4 0
EQI4 $917
ADDRLP4 28
ADDRGP4 $904
ASGNP4
ADDRGP4 $918
JUMPV
LABELV $917
ADDRLP4 28
ADDRGP4 $905
ASGNP4
LABELV $918
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 tg_data+4
INDIRI4
CNSTI4 0
EQI4 $919
ADDRLP4 32
ADDRGP4 $908
ASGNP4
ADDRGP4 $920
JUMPV
LABELV $919
ADDRLP4 32
ADDRGP4 $909
ASGNP4
LABELV $920
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 tg_data+16
INDIRI4
CNSTI4 0
EQI4 $921
ADDRLP4 36
ADDRGP4 $912
ASGNP4
ADDRGP4 $922
JUMPV
LABELV $921
ADDRLP4 36
ADDRGP4 $913
ASGNP4
LABELV $922
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1842
;1828:		     "%s%s%s%s%s%s"
;1829:		     "7) Nothing                    \n",
;1830:		     ( tg_data.
;1831:		       unlimit_ammo ) ? "1)âUnlimited ammo ON          \n" :
;1832:		     "1)áUnlimited ammo OFF         \n",
;1833:		     ( tg_data.
;1834:		       unlimit_grens ) ? "2)âUnlimited grenades ON      \n" :
;1835:		     "2)áUnlimited grenades OFF     \n", s_gren_effect, s_gren_time,
;1836:		     ( tg_data.
;1837:		       godmode ) ? "5)âGod Mode ON                \n" :
;1838:		     "5)áGod Mode OFF               \n",
;1839:		     ( tg_data.
;1840:		       disable_reload ) ? "6)âReload Disabled            \n" :
;1841:		     "6)áReload Enabled             \n" );
;1842:}
LABELV $876
endproc TG_Cheats_Menu 40 32
export TG_Cheats_Menu_Input
proc TG_Cheats_Menu_Input 32 0
line 1845
;1843:
;1844:void TG_Cheats_Menu_Input( int inp )
;1845:{
line 1846
;1846:	switch ( inp )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $923
ADDRLP4 0
INDIRI4
CNSTI4 7
GTI4 $923
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $962-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $962
address $926
address $932
address $938
address $943
address $949
address $955
address $961
code
line 1847
;1847:	{
LABELV $926
line 1849
;1848:	case 1:
;1849:		tg_data.unlimit_ammo = ( tg_data.unlimit_ammo ) ? 0 : 1;
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
EQI4 $930
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $931
JUMPV
LABELV $930
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $931
ADDRGP4 tg_data+8
ADDRLP4 4
INDIRI4
ASGNI4
line 1850
;1850:		break;
ADDRGP4 $925
JUMPV
LABELV $932
line 1852
;1851:	case 2:
;1852:		tg_data.unlimit_grens = ( tg_data.unlimit_grens ) ? 0 : 1;
ADDRGP4 tg_data+12
INDIRI4
CNSTI4 0
EQI4 $936
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $937
JUMPV
LABELV $936
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $937
ADDRGP4 tg_data+12
ADDRLP4 8
INDIRI4
ASGNI4
line 1853
;1853:		break;
ADDRGP4 $925
JUMPV
LABELV $938
line 1855
;1854:	case 3:
;1855:		if ( ++( tg_data.gren_effect ) >= TG_GREN_EFFECT_NUM )
ADDRLP4 12
ADDRGP4 tg_data+32
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 3
LTI4 $925
line 1856
;1856:			tg_data.gren_effect = 0;
ADDRGP4 tg_data+32
CNSTI4 0
ASGNI4
line 1857
;1857:		break;
ADDRGP4 $925
JUMPV
LABELV $943
line 1859
;1858:	case 4:
;1859:		tg_data.gren_time += 5;
ADDRLP4 20
ADDRGP4 tg_data+36
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
line 1860
;1860:		if ( tg_data.gren_time > 10 )
ADDRGP4 tg_data+36
INDIRI4
CNSTI4 10
LEI4 $925
line 1861
;1861:			tg_data.gren_time = 0;
ADDRGP4 tg_data+36
CNSTI4 0
ASGNI4
line 1862
;1862:		break;
ADDRGP4 $925
JUMPV
LABELV $949
line 1864
;1863:	case 5:
;1864:		tg_data.godmode = ( tg_data.godmode ) ? 0 : 1;
ADDRGP4 tg_data+4
INDIRI4
CNSTI4 0
EQI4 $953
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $954
JUMPV
LABELV $953
ADDRLP4 24
CNSTI4 1
ASGNI4
LABELV $954
ADDRGP4 tg_data+4
ADDRLP4 24
INDIRI4
ASGNI4
line 1865
;1865:		break;
ADDRGP4 $925
JUMPV
LABELV $955
line 1867
;1866:	case 6:
;1867:		tg_data.disable_reload = ( tg_data.disable_reload ) ? 0 : 1;
ADDRGP4 tg_data+16
INDIRI4
CNSTI4 0
EQI4 $959
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRGP4 $960
JUMPV
LABELV $959
ADDRLP4 28
CNSTI4 1
ASGNI4
LABELV $960
ADDRGP4 tg_data+16
ADDRLP4 28
INDIRI4
ASGNI4
line 1868
;1868:		break;
ADDRGP4 $925
JUMPV
LABELV $961
line 1870
;1869:	case 7:
;1870:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1871
;1871:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1872
;1872:		break;
line 1874
;1873:	default:
;1874:		return;
LABELV $925
line 1877
;1875:	}
;1876:
;1877:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1878
;1878:	self->menu_count = 23;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 23
ASGNI4
line 1880
;1879:
;1880:}
LABELV $923
endproc TG_Cheats_Menu_Input 32 0
data
export savepos
align 4
LABELV savepos
byte 4 0
byte 4 0
byte 4 0
export TG_SavePosition_Menu
code
proc TG_SavePosition_Menu 8 16
line 1885
;1881:
;1882:vec3_t  savepos = { 0, 0, 0 }
;1883:,       saveangle, savevel;
;1884:void TG_SavePosition_Menu( menunum_t menu )
;1885:{
line 1886
;1886:	if ( VectorCompareF( savepos, 0, 0, 0 ) )
ADDRGP4 savepos
ARGP4
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $965
line 1887
;1887:		CenterPrint( self, "\n1) Save Position              \n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $967
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $966
JUMPV
LABELV $965
line 1893
;1888:			     "                              \n"
;1889:			     "                              \n"
;1890:			     "                              \n"
;1891:			     "5) Nothing                    " );
;1892:	else
;1893:		CenterPrint( self, "\n1) Save Position              \n"
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $968
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $966
line 1898
;1894:			     "2) Show Position              \n"
;1895:			     "3) Restore Position           \n"
;1896:			     "4) Delete saved position      \n"
;1897:			     "5) Nothing                    " );
;1898:}
LABELV $964
endproc TG_SavePosition_Menu 8 16
export TG_SavePosition_Menu_Input
proc TG_SavePosition_Menu_Input 24 24
line 1902
;1899:
;1900:
;1901:void TG_SavePosition_Menu_Input( int inp )
;1902:{
line 1903
;1903:	switch ( inp )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $969
ADDRLP4 0
INDIRI4
CNSTI4 5
GTI4 $969
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1012-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1012
address $972
address $983
address $999
address $1008
address $1011
code
line 1904
;1904:	{
LABELV $972
line 1906
;1905:	case 1:
;1906:		VectorCopy( self->s.v.origin, savepos );
ADDRGP4 savepos
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRGP4 savepos+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRGP4 savepos+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 1907
;1907:		VectorCopy( self->s.v.angles, saveangle );
ADDRGP4 saveangle
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ASGNF4
ADDRGP4 saveangle+4
ADDRGP4 self
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ASGNF4
ADDRGP4 saveangle+8
ADDRGP4 self
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
ASGNF4
line 1908
;1908:		VectorCopy( self->s.v.velocity, savevel );
ADDRGP4 savevel
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ASGNF4
ADDRGP4 savevel+4
ADDRGP4 self
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ASGNF4
ADDRGP4 savevel+8
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ASGNF4
line 1909
;1909:		trap_WriteByte( MULTICAST_PHS_R, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1910
;1910:		trap_WriteByte( MULTICAST_PHS_R, TE_TAREXPLOSION );
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1911
;1911:		trap_WriteCoord( MULTICAST_PHS_R, savepos[0] );
CNSTI4 4
ARGI4
ADDRGP4 savepos
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1912
;1912:		trap_WriteCoord( MULTICAST_PHS_R, savepos[1] );
CNSTI4 4
ARGI4
ADDRGP4 savepos+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1913
;1913:		trap_WriteCoord( MULTICAST_PHS_R, savepos[2] );
CNSTI4 4
ARGI4
ADDRGP4 savepos+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1914
;1914:		trap_multicast( PASSVEC3( savepos ), 1 );
ADDRGP4 savepos
INDIRF4
ARGF4
ADDRGP4 savepos+4
INDIRF4
ARGF4
ADDRGP4 savepos+8
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 1915
;1915:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1916
;1916:		break;
ADDRGP4 $971
JUMPV
LABELV $983
line 1918
;1917:	case 2:
;1918:		if ( VectorCompareF( savepos, 0, 0, 0 ) )
ADDRGP4 savepos
ARGP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $984
line 1919
;1919:			break;
ADDRGP4 $971
JUMPV
LABELV $984
line 1920
;1920:		trap_WriteByte( MULTICAST_PHS_R, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1921
;1921:		trap_WriteByte( MULTICAST_PHS_R, TE_TAREXPLOSION );
ADDRLP4 16
CNSTI4 4
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1922
;1922:		trap_WriteCoord( MULTICAST_PHS_R, savepos[0] );
CNSTI4 4
ARGI4
ADDRGP4 savepos
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1923
;1923:		trap_WriteCoord( MULTICAST_PHS_R, savepos[1] );
CNSTI4 4
ARGI4
ADDRGP4 savepos+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1924
;1924:		trap_WriteCoord( MULTICAST_PHS_R, savepos[2] );
CNSTI4 4
ARGI4
ADDRGP4 savepos+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1925
;1925:		trap_multicast( PASSVEC3( savepos ), 1 );
ADDRGP4 savepos
INDIRF4
ARGF4
ADDRGP4 savepos+4
INDIRF4
ARGF4
ADDRGP4 savepos+8
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 1926
;1926:		G_sprint( self, 2, "Saved position: '%.0f %.0f %.0f'\n", savepos[0],
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $990
ARGP4
ADDRGP4 savepos
INDIRF4
ARGF4
ADDRGP4 savepos+4
INDIRF4
ARGF4
ADDRGP4 savepos+8
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 1928
;1927:			  savepos[1], savepos[2] );
;1928:		G_sprint( self, 2, "angle: '%.0f %.0f %.0f'\n", saveangle[0],
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $993
ARGP4
ADDRGP4 saveangle
INDIRF4
ARGF4
ADDRGP4 saveangle+4
INDIRF4
ARGF4
ADDRGP4 saveangle+8
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 1930
;1929:			  saveangle[1], saveangle[2] );
;1930:		G_sprint( self, 2, "speed: '%.0f %.0f %.0f'\n", savevel[0], savevel[1],
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $996
ARGP4
ADDRGP4 savevel
INDIRF4
ARGF4
ADDRGP4 savevel+4
INDIRF4
ARGF4
ADDRGP4 savevel+8
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 1932
;1931:			  savevel[2] );
;1932:		break;
ADDRGP4 $971
JUMPV
LABELV $999
line 1934
;1933:	case 3:
;1934:		VectorCopy( savepos, self->s.v.origin );
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ADDRGP4 savepos
INDIRF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
ADDRGP4 savepos+4
INDIRF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
ADDRGP4 savepos+8
INDIRF4
ASGNF4
line 1935
;1935:		VectorCopy( saveangle, self->s.v.angles );
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ADDRGP4 saveangle
INDIRF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 196
ADDP4
ADDRGP4 saveangle+4
INDIRF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 200
ADDP4
ADDRGP4 saveangle+8
INDIRF4
ASGNF4
line 1936
;1936:		VectorCopy( savevel, self->s.v.velocity );
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ADDRGP4 savevel
INDIRF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 184
ADDP4
ADDRGP4 savevel+4
INDIRF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
ADDRGP4 savevel+8
INDIRF4
ASGNF4
line 1937
;1937:		setorigin( self, PASSVEC3( savepos ) );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 savepos
INDIRF4
ARGF4
ADDRGP4 savepos+4
INDIRF4
ARGF4
ADDRGP4 savepos+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 1938
;1938:		self->s.v.fixangle = 1;
ADDRGP4 self
INDIRP4
CNSTI4 380
ADDP4
CNSTF4 1065353216
ASGNF4
line 1939
;1939:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1940
;1940:		break;
ADDRGP4 $971
JUMPV
LABELV $1008
line 1942
;1941:	case 4:
;1942:		SetVector( savepos, 0, 0, 0 );
ADDRLP4 20
CNSTF4 0
ASGNF4
ADDRGP4 savepos
ADDRLP4 20
INDIRF4
ASGNF4
ADDRGP4 savepos+4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRGP4 savepos+8
CNSTF4 0
ASGNF4
line 1943
;1943:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1944
;1944:		break;
ADDRGP4 $971
JUMPV
LABELV $1011
line 1946
;1945:	case 5:
;1946:		ResetMenu(  );
ADDRGP4 ResetMenu
CALLV
pop
line 1947
;1947:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1948
;1948:		break;
line 1950
;1949:	default:
;1950:		return;
LABELV $971
line 1953
;1951:	}
;1952:
;1953:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 1954
;1954:	self->menu_count = 23;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 23
ASGNI4
line 1956
;1955:
;1956:}
LABELV $969
endproc TG_SavePosition_Menu_Input 24 24
export Menu_DropStuff
proc Menu_DropStuff 0 8
line 1960
;1957:
;1958:// megatf Menus
;1959:void Menu_DropStuff( menunum_t menu ) 
;1960:{
line 1961
;1961:	CenterPrint(self, "ÄÅÅÅ Mega-TF Menu ÅÅÅÇ\n\nÄìÇ Drop #1    \nÄîÇ Toaster    \nÄïÇ Drop #3    \nÄñÇ Holograph  \nÄóÇ NightVision\nÄòÇ Lay Mode   \nÄôÇ Taunt Menu \nÄöÇ Yell Menu  \nÄõÇ Nothing    \n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1015
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1962
;1962:};
LABELV $1014
endproc Menu_DropStuff 0 8
export Menu_DropStuff_Input
proc Menu_DropStuff_Input 0 8
line 1965
;1963:
;1964:void Menu_DropStuff_Input( int inp )
;1965:{
line 1966
;1966:	if (inp == 1)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $1017
line 1967
;1967:	{
line 1968
;1968:		stuffcmd(self, "drop1\n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1019
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1969
;1969:	}
ADDRGP4 $1018
JUMPV
LABELV $1017
line 1971
;1970:	else
;1971:	{
line 1972
;1972:		if (inp == 2)
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $1020
line 1973
;1973:		{
line 1974
;1974:			stuffcmd(self, "drop2\n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1022
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1975
;1975:		}
ADDRGP4 $1021
JUMPV
LABELV $1020
line 1977
;1976:		else
;1977:		{
line 1978
;1978:			if (inp == 3)
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $1023
line 1979
;1979:			{
line 1980
;1980:				stuffcmd(self, "drop3\n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1025
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1981
;1981:			}
ADDRGP4 $1024
JUMPV
LABELV $1023
line 1983
;1982:			else
;1983:			{
line 1984
;1984:				if (inp == 4)
ADDRFP4 0
INDIRI4
CNSTI4 4
NEI4 $1026
line 1985
;1985:				{
line 1986
;1986:					stuffcmd(self, "holo\n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1028
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1987
;1987:				}
ADDRGP4 $1027
JUMPV
LABELV $1026
line 1989
;1988:				else
;1989:				{
line 1990
;1990:					if (inp == 5)
ADDRFP4 0
INDIRI4
CNSTI4 5
NEI4 $1029
line 1991
;1991:					{
line 1992
;1992:						stuffcmd(self, "ir\n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1031
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1993
;1993:					}
ADDRGP4 $1030
JUMPV
LABELV $1029
line 1995
;1994:					else
;1995:					{
line 1996
;1996:						if (inp == 6)
ADDRFP4 0
INDIRI4
CNSTI4 6
NEI4 $1032
line 1997
;1997:						{
line 1998
;1998:							stuffcmd(self, "lay\n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1034
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1999
;1999:						}
ADDRGP4 $1033
JUMPV
LABELV $1032
line 2001
;2000:						else
;2001:						{
line 2002
;2002:							if (inp == 7)
ADDRFP4 0
INDIRI4
CNSTI4 7
NEI4 $1035
line 2003
;2003:							{
line 2004
;2004:								ResetMenu();
ADDRGP4 ResetMenu
CALLV
pop
line 2005
;2005:								self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 2006
;2006:								stuffcmd(self, "taunt\n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1037
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2007
;2007:							}
ADDRGP4 $1036
JUMPV
LABELV $1035
line 2009
;2008:							else
;2009:							{
line 2010
;2010:								if (inp == 8)
ADDRFP4 0
INDIRI4
CNSTI4 8
NEI4 $1038
line 2011
;2011:								{
line 2012
;2012:									ResetMenu();
ADDRGP4 ResetMenu
CALLV
pop
line 2013
;2013:									self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 2014
;2014:									stuffcmd(self, "yell\n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1040
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2015
;2015:								}
ADDRGP4 $1039
JUMPV
LABELV $1038
line 2017
;2016:								else
;2017:								{
line 2026
;2018:									/*if (inp == 9)
;2019:									{
;2020:										ResetMenu();
;2021:										self->s.v.impulse = 0;
;2022:										stuffcmd(self, "votemenu\n");
;2023:									}
;2024:									else
;2025:										{*/
;2026:										if (inp > 8)
ADDRFP4 0
INDIRI4
CNSTI4 8
LEI4 $1041
line 2027
;2027:										{
line 2028
;2028:											ResetMenu();
ADDRGP4 ResetMenu
CALLV
pop
line 2029
;2029:										}
LABELV $1041
line 2031
;2030:									//}
;2031:								}
LABELV $1039
line 2032
;2032:							}
LABELV $1036
line 2033
;2033:						}
LABELV $1033
line 2034
;2034:					}
LABELV $1030
line 2035
;2035:				}
LABELV $1027
line 2036
;2036:			}
LABELV $1024
line 2037
;2037:		}
LABELV $1021
line 2038
;2038:	}
LABELV $1018
line 2039
;2039:	ResetMenu();
ADDRGP4 ResetMenu
CALLV
pop
line 2040
;2040:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 2041
;2041:};
LABELV $1016
endproc Menu_DropStuff_Input 0 8
export Menu_Taunt
proc Menu_Taunt 0 8
line 2044
;2042:
;2043:void Menu_Taunt( menunum_t menu ) 
;2044:{
line 2045
;2045:	CenterPrint(self, "ÄÅÅÅ Taunt Menu ÅÅÅÇ\n\nÄìÇ R U Threat'n Me?     \nÄîÇ Come out w/ pants dwn\nÄïÇ Hey!  hehheh...      \n  ÄñÇ Do U want 2 C my bHole?\nÄóÇ Call 911!            \nÄòÇ Kick'm in the Nads!  \nÄôÇ I do the a$$ kik'n...\nÄöÇ Pathetic Looser!     \nÄõÇ Nothing              \n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1044
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 2046
;2046:};
LABELV $1043
endproc Menu_Taunt 0 8
export Menu_Yell
proc Menu_Yell 0 8
line 2049
;2047:
;2048:void Menu_Yell( menunum_t menu ) 
;2049:{
line 2050
;2050:	CenterPrint(self, "ÄÅÅÅ Yell Menu  ÅÅÅÇ\n\nÄìÇ Cover Me!            \nÄîÇ Over Here!           \nÄïÇ This Way!            \n  ÄñÇ Follow Me!             \nÄóÇ Incoming!            \nÄòÇ Holdup!              \nÄôÇ Go Go Go!            \nÄöÇ Lookout!             \nÄõÇ Fire in the hole!    \n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1046
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 2051
;2051:};
LABELV $1045
endproc Menu_Yell 0 8
export Menu_Taunt_Input
proc Menu_Taunt_Input 4 20
line 2054
;2052:
;2053:void Menu_Taunt_Input( int inp )
;2054:{
line 2055
;2055:	if (inp == 1)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $1048
line 2056
;2056:	{
line 2057
;2057:		stuffcmd(self, "bic\n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1050
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2058
;2058:	}
ADDRGP4 $1049
JUMPV
LABELV $1048
line 2060
;2059:	else
;2060:	{
line 2061
;2061:		if (inp == 2)
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $1051
line 2062
;2062:		{
line 2063
;2063:			stuffcmd(self, "impulse 250\n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1053
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2064
;2064:		}
ADDRGP4 $1052
JUMPV
LABELV $1051
line 2066
;2065:		else
;2066:		{
line 2067
;2067:			if (inp == 3)
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $1054
line 2068
;2068:			{
line 2069
;2069:				stuffcmd(self, "hey\n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1056
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2070
;2070:			}
ADDRGP4 $1055
JUMPV
LABELV $1054
line 2072
;2071:			else
;2072:			{
line 2073
;2073:				if (inp == 4)
ADDRFP4 0
INDIRI4
CNSTI4 4
NEI4 $1057
line 2074
;2074:				{
line 2075
;2075:					stuffcmd(self, "bhole\n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1059
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2076
;2076:				}
ADDRGP4 $1058
JUMPV
LABELV $1057
line 2078
;2077:				else
;2078:				{
line 2079
;2079:					if (inp == 5)
ADDRFP4 0
INDIRI4
CNSTI4 5
NEI4 $1060
line 2080
;2080:					{
line 2081
;2081:						sound(self, 1, "speech/call911.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1062
ARGP4
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2082
;2082:					}
ADDRGP4 $1061
JUMPV
LABELV $1060
line 2084
;2083:					else
;2084:					{
line 2085
;2085:						if (inp == 6)
ADDRFP4 0
INDIRI4
CNSTI4 6
NEI4 $1063
line 2086
;2086:						{
line 2087
;2087:							sound(self, 1, "speech/kicknads.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1065
ARGP4
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2088
;2088:						}
ADDRGP4 $1064
JUMPV
LABELV $1063
line 2090
;2089:						else
;2090:						{
line 2091
;2091:							if (inp == 7)
ADDRFP4 0
INDIRI4
CNSTI4 7
NEI4 $1066
line 2092
;2092:							{
line 2093
;2093:								sound(self, 1, "speech/idoasskk.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1068
ARGP4
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2094
;2094:							}
ADDRGP4 $1067
JUMPV
LABELV $1066
line 2096
;2095:							else
;2096:							{
line 2097
;2097:								if (inp == 8)
ADDRFP4 0
INDIRI4
CNSTI4 8
NEI4 $1069
line 2098
;2098:								{
line 2099
;2099:									sound(self, 1, "speech/pathetic.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1071
ARGP4
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2100
;2100:								}
ADDRGP4 $1070
JUMPV
LABELV $1069
line 2102
;2101:								else
;2102:								{
line 2103
;2103:									if (inp > 8)
ADDRFP4 0
INDIRI4
CNSTI4 8
LEI4 $1072
line 2104
;2104:									{
line 2105
;2105:										ResetMenu();
ADDRGP4 ResetMenu
CALLV
pop
line 2106
;2106:									}
LABELV $1072
line 2107
;2107:								}
LABELV $1070
line 2108
;2108:							}
LABELV $1067
line 2109
;2109:						}
LABELV $1064
line 2110
;2110:					}
LABELV $1061
line 2111
;2111:				}
LABELV $1058
line 2112
;2112:			}
LABELV $1055
line 2113
;2113:		}
LABELV $1052
line 2114
;2114:	}
LABELV $1049
line 2115
;2115:	ResetMenu();
ADDRGP4 ResetMenu
CALLV
pop
line 2116
;2116:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 2117
;2117:};
LABELV $1047
endproc Menu_Taunt_Input 4 20
export Menu_Yell_Input
proc Menu_Yell_Input 8 20
line 2120
;2118:
;2119:void Menu_Yell_Input( int inp )
;2120:{
line 2121
;2121:	trap_WriteByte(4, 23);
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 2122
;2122:	trap_WriteByte(4, 11);
CNSTI4 4
ARGI4
CNSTI4 11
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 2123
;2123:	trap_WriteCoord(4, self->s.v.origin[0]);
CNSTI4 4
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
line 2124
;2124:	trap_WriteCoord(4, self->s.v.origin[1]);
CNSTI4 4
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
line 2125
;2125:	trap_WriteCoord(4, self->s.v.origin[2]);
CNSTI4 4
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
line 2126
;2126: 	trap_multicast(PASSVEC3(self->s.v.origin), 1);
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
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
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 2128
;2127:
;2128:	if (inp == 1)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $1075
line 2129
;2129:	{
line 2130
;2130:		sound(self, 1, "speech/yell/coverme.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1077
ARGP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2131
;2131:	}
ADDRGP4 $1076
JUMPV
LABELV $1075
line 2133
;2132:	else
;2133:	{
line 2134
;2134:		if (inp == 2)
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $1078
line 2135
;2135:		{
line 2136
;2136:			sound(self, 1, "speech/yell/overhere.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1080
ARGP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2137
;2137:		}
ADDRGP4 $1079
JUMPV
LABELV $1078
line 2139
;2138:		else
;2139:		{
line 2140
;2140:			if (inp == 3)
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $1081
line 2141
;2141:			{
line 2142
;2142:				sound(self, 1, "speech/yell/thisway.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1083
ARGP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2143
;2143:			}
ADDRGP4 $1082
JUMPV
LABELV $1081
line 2145
;2144:			else
;2145:			{
line 2146
;2146:				if (inp == 4)
ADDRFP4 0
INDIRI4
CNSTI4 4
NEI4 $1084
line 2147
;2147:				{
line 2148
;2148:					sound(self, 1, "speech/yell/followme.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1086
ARGP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2149
;2149:				}
ADDRGP4 $1085
JUMPV
LABELV $1084
line 2151
;2150:				else
;2151:				{
line 2152
;2152:					if (inp == 5)
ADDRFP4 0
INDIRI4
CNSTI4 5
NEI4 $1087
line 2153
;2153:					{
line 2154
;2154:						sound(self, 1, "speech/yell/incomng.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1089
ARGP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2155
;2155:					}
ADDRGP4 $1088
JUMPV
LABELV $1087
line 2157
;2156:					else
;2157:					{
line 2158
;2158:						if (inp == 6)
ADDRFP4 0
INDIRI4
CNSTI4 6
NEI4 $1090
line 2159
;2159:						{
line 2160
;2160:							sound(self, 1, "speech/yell/holdup.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1092
ARGP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2161
;2161:						}
ADDRGP4 $1091
JUMPV
LABELV $1090
line 2163
;2162:						else
;2163:						{
line 2164
;2164:							if (inp == 7)
ADDRFP4 0
INDIRI4
CNSTI4 7
NEI4 $1093
line 2165
;2165:							{
line 2166
;2166:								sound(self, 1, "speech/yell/gogogo.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1095
ARGP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2167
;2167:							}
ADDRGP4 $1094
JUMPV
LABELV $1093
line 2169
;2168:							else
;2169:							{
line 2170
;2170:								if (inp == 8)
ADDRFP4 0
INDIRI4
CNSTI4 8
NEI4 $1096
line 2171
;2171:								{
line 2172
;2172:									sound(self, 1, "speech/yell/lookout.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1098
ARGP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2173
;2173:								}
ADDRGP4 $1097
JUMPV
LABELV $1096
line 2175
;2174:								else
;2175:								{
line 2176
;2176:									if (inp == 9)
ADDRFP4 0
INDIRI4
CNSTI4 9
NEI4 $1099
line 2177
;2177:									{
line 2178
;2178:										sound(self, 1, "speech/yell/firehole.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1101
ARGP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2179
;2179:									}
ADDRGP4 $1100
JUMPV
LABELV $1099
line 2181
;2180:									else
;2181:									{
line 2182
;2182:										if (inp > 9)
ADDRFP4 0
INDIRI4
CNSTI4 9
LEI4 $1102
line 2183
;2183:										{
line 2184
;2184:											ResetMenu();
ADDRGP4 ResetMenu
CALLV
pop
line 2185
;2185:										}
LABELV $1102
line 2186
;2186:									}
LABELV $1100
line 2187
;2187:								}
LABELV $1097
line 2188
;2188:							}
LABELV $1094
line 2189
;2189:						}
LABELV $1091
line 2190
;2190:					}
LABELV $1088
line 2191
;2191:				}
LABELV $1085
line 2192
;2192:			}
LABELV $1082
line 2193
;2193:		}
LABELV $1079
line 2194
;2194:	}
LABELV $1076
line 2195
;2195:	self->current_menu = MENU_TAUNT;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 33
ASGNI4
line 2196
;2196:	ResetMenu();
ADDRGP4 ResetMenu
CALLV
pop
line 2197
;2197:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 2198
;2198:};
LABELV $1074
endproc Menu_Yell_Input 8 20
bss
export savevel
align 4
LABELV savevel
skip 12
export saveangle
align 4
LABELV saveangle
skip 12
import Detpack_SetClip
export snipers_num
align 4
LABELV snipers_num
skip 4
import TeamFortress_DropAmmo
import CheckSentry
import Sentry_MuzzleFlash
import Sentry_Fire
import Sentry_Die
import Sentry_Pain
import Sentry_HuntTarget
import Sentry_FoundTarget
import Sentry_FindTarget_Angel
import Sentry_FindTarget
import Sentry_Rotate
import lvl3_sentry_atk3
import lvl3_sentry_atk2
import lvl3_sentry_atk1
import lvl3_sentry_stand
import lvl2_sentry_atk3
import lvl2_sentry_atk2
import lvl2_sentry_atk1
import lvl2_sentry_stand
import lvl1_sentry_atk3
import lvl1_sentry_atk2
import lvl1_sentry_atk1
import lvl1_sentry_stand
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
LABELV $1101
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 47
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 104
byte 1 111
byte 1 108
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1098
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 47
byte 1 108
byte 1 111
byte 1 111
byte 1 107
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1095
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 47
byte 1 103
byte 1 111
byte 1 103
byte 1 111
byte 1 103
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1092
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 47
byte 1 104
byte 1 111
byte 1 108
byte 1 100
byte 1 117
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1089
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 47
byte 1 105
byte 1 110
byte 1 99
byte 1 111
byte 1 109
byte 1 110
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1086
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 47
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 109
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1083
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 47
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 119
byte 1 97
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1080
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 47
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1077
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 47
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 109
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1071
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 101
byte 1 116
byte 1 105
byte 1 99
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1068
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 105
byte 1 100
byte 1 111
byte 1 97
byte 1 115
byte 1 115
byte 1 107
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1065
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 110
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1062
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 57
byte 1 49
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1059
byte 1 98
byte 1 104
byte 1 111
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1056
byte 1 104
byte 1 101
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $1053
byte 1 105
byte 1 109
byte 1 112
byte 1 117
byte 1 108
byte 1 115
byte 1 101
byte 1 32
byte 1 50
byte 1 53
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $1050
byte 1 98
byte 1 105
byte 1 99
byte 1 10
byte 1 0
align 1
LABELV $1046
byte 1 128
byte 1 129
byte 1 129
byte 1 129
byte 1 32
byte 1 89
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 32
byte 1 129
byte 1 129
byte 1 129
byte 1 130
byte 1 10
byte 1 10
byte 1 128
byte 1 147
byte 1 130
byte 1 32
byte 1 67
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 77
byte 1 101
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 148
byte 1 130
byte 1 32
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 72
byte 1 101
byte 1 114
byte 1 101
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 149
byte 1 130
byte 1 32
byte 1 84
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 87
byte 1 97
byte 1 121
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 128
byte 1 150
byte 1 130
byte 1 32
byte 1 70
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 77
byte 1 101
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 151
byte 1 130
byte 1 32
byte 1 73
byte 1 110
byte 1 99
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 152
byte 1 130
byte 1 32
byte 1 72
byte 1 111
byte 1 108
byte 1 100
byte 1 117
byte 1 112
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 153
byte 1 130
byte 1 32
byte 1 71
byte 1 111
byte 1 32
byte 1 71
byte 1 111
byte 1 32
byte 1 71
byte 1 111
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 154
byte 1 130
byte 1 32
byte 1 76
byte 1 111
byte 1 111
byte 1 107
byte 1 111
byte 1 117
byte 1 116
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 155
byte 1 130
byte 1 32
byte 1 70
byte 1 105
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
byte 1 104
byte 1 111
byte 1 108
byte 1 101
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $1044
byte 1 128
byte 1 129
byte 1 129
byte 1 129
byte 1 32
byte 1 84
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 32
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 129
byte 1 129
byte 1 129
byte 1 130
byte 1 10
byte 1 10
byte 1 128
byte 1 147
byte 1 130
byte 1 32
byte 1 82
byte 1 32
byte 1 85
byte 1 32
byte 1 84
byte 1 104
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 39
byte 1 110
byte 1 32
byte 1 77
byte 1 101
byte 1 63
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 148
byte 1 130
byte 1 32
byte 1 67
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 119
byte 1 47
byte 1 32
byte 1 112
byte 1 97
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 100
byte 1 119
byte 1 110
byte 1 10
byte 1 128
byte 1 149
byte 1 130
byte 1 32
byte 1 72
byte 1 101
byte 1 121
byte 1 33
byte 1 32
byte 1 32
byte 1 104
byte 1 101
byte 1 104
byte 1 104
byte 1 101
byte 1 104
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 128
byte 1 150
byte 1 130
byte 1 32
byte 1 68
byte 1 111
byte 1 32
byte 1 85
byte 1 32
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 32
byte 1 50
byte 1 32
byte 1 67
byte 1 32
byte 1 109
byte 1 121
byte 1 32
byte 1 98
byte 1 72
byte 1 111
byte 1 108
byte 1 101
byte 1 63
byte 1 10
byte 1 128
byte 1 151
byte 1 130
byte 1 32
byte 1 67
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 57
byte 1 49
byte 1 49
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 152
byte 1 130
byte 1 32
byte 1 75
byte 1 105
byte 1 99
byte 1 107
byte 1 39
byte 1 109
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 78
byte 1 97
byte 1 100
byte 1 115
byte 1 33
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 153
byte 1 130
byte 1 32
byte 1 73
byte 1 32
byte 1 100
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 97
byte 1 36
byte 1 36
byte 1 32
byte 1 107
byte 1 105
byte 1 107
byte 1 39
byte 1 110
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 128
byte 1 154
byte 1 130
byte 1 32
byte 1 80
byte 1 97
byte 1 116
byte 1 104
byte 1 101
byte 1 116
byte 1 105
byte 1 99
byte 1 32
byte 1 76
byte 1 111
byte 1 111
byte 1 115
byte 1 101
byte 1 114
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 155
byte 1 130
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $1040
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $1037
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $1034
byte 1 108
byte 1 97
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $1031
byte 1 105
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $1028
byte 1 104
byte 1 111
byte 1 108
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $1025
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $1022
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $1019
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $1015
byte 1 128
byte 1 129
byte 1 129
byte 1 129
byte 1 32
byte 1 77
byte 1 101
byte 1 103
byte 1 97
byte 1 45
byte 1 84
byte 1 70
byte 1 32
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 129
byte 1 129
byte 1 129
byte 1 130
byte 1 10
byte 1 10
byte 1 128
byte 1 147
byte 1 130
byte 1 32
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 32
byte 1 35
byte 1 49
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 148
byte 1 130
byte 1 32
byte 1 84
byte 1 111
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 149
byte 1 130
byte 1 32
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 32
byte 1 35
byte 1 51
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 150
byte 1 130
byte 1 32
byte 1 72
byte 1 111
byte 1 108
byte 1 111
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 104
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 151
byte 1 130
byte 1 32
byte 1 78
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 86
byte 1 105
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 10
byte 1 128
byte 1 152
byte 1 130
byte 1 32
byte 1 76
byte 1 97
byte 1 121
byte 1 32
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 153
byte 1 130
byte 1 32
byte 1 84
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 32
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 10
byte 1 128
byte 1 154
byte 1 130
byte 1 32
byte 1 89
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 32
byte 1 10
byte 1 128
byte 1 155
byte 1 130
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $996
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 58
byte 1 32
byte 1 39
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
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $993
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 39
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
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $990
byte 1 83
byte 1 97
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 39
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
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $968
byte 1 10
byte 1 49
byte 1 41
byte 1 32
byte 1 83
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 80
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 50
byte 1 41
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 32
byte 1 80
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 51
byte 1 41
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 116
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 80
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 52
byte 1 41
byte 1 32
byte 1 68
byte 1 101
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 32
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 53
byte 1 41
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $967
byte 1 10
byte 1 49
byte 1 41
byte 1 32
byte 1 83
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 80
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 53
byte 1 41
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $913
byte 1 54
byte 1 41
byte 1 135
byte 1 82
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 69
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $912
byte 1 54
byte 1 41
byte 1 137
byte 1 82
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 68
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $909
byte 1 53
byte 1 41
byte 1 135
byte 1 71
byte 1 111
byte 1 100
byte 1 32
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $908
byte 1 53
byte 1 41
byte 1 137
byte 1 71
byte 1 111
byte 1 100
byte 1 32
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $905
byte 1 50
byte 1 41
byte 1 135
byte 1 85
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
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
byte 1 79
byte 1 70
byte 1 70
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $904
byte 1 50
byte 1 41
byte 1 137
byte 1 85
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
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
byte 1 79
byte 1 78
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $901
byte 1 49
byte 1 41
byte 1 135
byte 1 85
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $900
byte 1 49
byte 1 41
byte 1 137
byte 1 85
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $898
byte 1 67
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 58
byte 1 10
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 55
byte 1 41
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $895
byte 1 52
byte 1 41
byte 1 136
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 49
byte 1 48
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 10
byte 1 0
align 1
LABELV $893
byte 1 52
byte 1 41
byte 1 135
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 53
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $891
byte 1 52
byte 1 41
byte 1 137
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $886
byte 1 51
byte 1 41
byte 1 137
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $884
byte 1 51
byte 1 41
byte 1 136
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $882
byte 1 51
byte 1 41
byte 1 135
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $846
byte 1 68
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 58
byte 1 10
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 53
byte 1 41
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $845
byte 1 52
byte 1 41
byte 1 137
byte 1 83
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 115
byte 1 58
byte 1 32
byte 1 84
byte 1 70
byte 1 32
byte 1 50
byte 1 46
byte 1 56
byte 1 46
byte 1 49
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $844
byte 1 52
byte 1 41
byte 1 135
byte 1 83
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 115
byte 1 58
byte 1 32
byte 1 84
byte 1 70
byte 1 50
byte 1 48
byte 1 48
byte 1 51
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $840
byte 1 51
byte 1 41
byte 1 135
byte 1 100
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $839
byte 1 51
byte 1 41
byte 1 137
byte 1 100
byte 1 114
byte 1 111
byte 1 112
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $835
byte 1 50
byte 1 41
byte 1 137
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 114
byte 1 109
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $834
byte 1 50
byte 1 41
byte 1 135
byte 1 100
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 114
byte 1 109
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $830
byte 1 49
byte 1 41
byte 1 136
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $828
byte 1 49
byte 1 41
byte 1 135
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $826
byte 1 49
byte 1 41
byte 1 137
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 65
byte 1 76
byte 1 76
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $790
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 58
byte 1 10
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 53
byte 1 41
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $789
byte 1 49
byte 1 41
byte 1 135
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $788
byte 1 49
byte 1 41
byte 1 137
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $781
byte 1 52
byte 1 41
byte 1 135
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $780
byte 1 52
byte 1 41
byte 1 137
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $775
byte 1 51
byte 1 41
byte 1 135
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $774
byte 1 51
byte 1 41
byte 1 137
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $769
byte 1 50
byte 1 41
byte 1 135
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $768
byte 1 50
byte 1 41
byte 1 137
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $724
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 79
byte 1 112
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 58
byte 1 10
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 57
byte 1 41
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $723
byte 1 56
byte 1 41
byte 1 135
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 69
byte 1 110
byte 1 103
byte 1 32
byte 1 83
byte 1 98
byte 1 97
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $722
byte 1 56
byte 1 41
byte 1 137
byte 1 69
byte 1 110
byte 1 103
byte 1 32
byte 1 83
byte 1 98
byte 1 97
byte 1 114
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $718
byte 1 55
byte 1 41
byte 1 32
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $707
byte 1 53
byte 1 41
byte 1 135
byte 1 85
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $706
byte 1 53
byte 1 41
byte 1 137
byte 1 85
byte 1 110
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $702
byte 1 51
byte 1 41
byte 1 135
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 79
byte 1 76
byte 1 68
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $701
byte 1 51
byte 1 41
byte 1 137
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 78
byte 1 69
byte 1 87
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $697
byte 1 49
byte 1 41
byte 1 135
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 32
byte 1 70
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 84
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $695
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 112
byte 1 112
byte 1 108
byte 1 32
byte 1 101
byte 1 109
byte 1 117
byte 1 108
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $694
byte 1 49
byte 1 41
byte 1 137
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 32
byte 1 70
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 84
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $689
byte 1 54
byte 1 41
byte 1 135
byte 1 105
byte 1 103
byte 1 110
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $688
byte 1 54
byte 1 41
byte 1 137
byte 1 105
byte 1 103
byte 1 110
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $687
byte 1 54
byte 1 41
byte 1 136
byte 1 105
byte 1 103
byte 1 110
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $686
byte 1 54
byte 1 41
byte 1 134
byte 1 105
byte 1 103
byte 1 110
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
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $685
byte 1 52
byte 1 41
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 83
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 77
byte 1 84
byte 1 70
byte 1 76
byte 1 50
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $684
byte 1 52
byte 1 41
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 83
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 77
byte 1 84
byte 1 70
byte 1 76
byte 1 49
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $683
byte 1 52
byte 1 41
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 83
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 50
byte 1 46
byte 1 56
byte 1 46
byte 1 49
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $682
byte 1 52
byte 1 41
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 83
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 78
byte 1 69
byte 1 87
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $670
byte 1 79
byte 1 112
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 58
byte 1 10
byte 1 49
byte 1 41
byte 1 32
byte 1 83
byte 1 71
byte 1 32
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 50
byte 1 41
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 51
byte 1 41
byte 1 32
byte 1 67
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 52
byte 1 41
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 53
byte 1 41
byte 1 32
byte 1 83
byte 1 97
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 55
byte 1 41
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $667
byte 1 10
byte 1 10
byte 1 72
byte 1 65
byte 1 80
byte 1 80
byte 1 89
byte 1 32
byte 1 66
byte 1 73
byte 1 82
byte 1 84
byte 1 72
byte 1 68
byte 1 65
byte 1 89
byte 1 32
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 70
byte 1 79
byte 1 82
byte 1 84
byte 1 82
byte 1 69
byte 1 83
byte 1 83
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $662
byte 1 73
byte 1 84
byte 1 39
byte 1 83
byte 1 32
byte 1 80
byte 1 65
byte 1 82
byte 1 84
byte 1 89
byte 1 32
byte 1 84
byte 1 73
byte 1 77
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $661
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 98
byte 1 105
byte 1 114
byte 1 116
byte 1 104
byte 1 100
byte 1 97
byte 1 121
byte 1 32
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $646
byte 1 52
byte 1 116
byte 1 104
byte 1 32
byte 1 73
byte 1 109
byte 1 112
byte 1 117
byte 1 108
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $643
byte 1 51
byte 1 114
byte 1 100
byte 1 32
byte 1 73
byte 1 109
byte 1 112
byte 1 117
byte 1 108
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $639
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 98
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $638
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 98
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $636
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 98
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $629
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 98
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $615
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 34
byte 1 77
byte 1 74
byte 1 58
byte 1 32
byte 1 68
byte 1 105
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 74
byte 1 111
byte 1 104
byte 1 110
byte 1 32
byte 1 67
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 119
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 84
byte 1 70
byte 1 63
byte 1 34
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 45
byte 1 32
byte 1 86
byte 1 111
byte 1 109
byte 1 105
byte 1 116
byte 1 71
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $614
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 39
byte 1 115
byte 1 32
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 105
byte 1 103
byte 1 110
byte 1 32
byte 1 100
byte 1 111
byte 1 99
byte 1 115
byte 1 33
byte 1 10
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 32
byte 1 105
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 33
byte 1 10
byte 1 119
byte 1 119
byte 1 119
byte 1 46
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 102
byte 1 111
byte 1 114
byte 1 116
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 99
byte 1 111
byte 1 109
byte 1 47
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 115
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 102
byte 1 111
byte 1 114
byte 1 116
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 47
byte 1 116
byte 1 102
byte 1 100
byte 1 101
byte 1 115
byte 1 95
byte 1 50
byte 1 46
byte 1 103
byte 1 105
byte 1 102
byte 1 0
align 1
LABELV $613
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 39
byte 1 115
byte 1 32
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 105
byte 1 103
byte 1 110
byte 1 32
byte 1 100
byte 1 111
byte 1 99
byte 1 115
byte 1 33
byte 1 10
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 32
byte 1 105
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 33
byte 1 10
byte 1 119
byte 1 119
byte 1 119
byte 1 46
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 102
byte 1 111
byte 1 114
byte 1 116
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 99
byte 1 111
byte 1 109
byte 1 47
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 115
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 102
byte 1 111
byte 1 114
byte 1 116
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 47
byte 1 116
byte 1 102
byte 1 100
byte 1 101
byte 1 115
byte 1 95
byte 1 49
byte 1 46
byte 1 103
byte 1 105
byte 1 102
byte 1 0
align 1
LABELV $612
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 86
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 49
byte 1 48
byte 1 58
byte 1 10
byte 1 87
byte 1 104
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 103
byte 1 117
byte 1 121
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 121
byte 1 97
byte 1 114
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 10
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 63
byte 1 63
byte 1 63
byte 1 10
byte 1 0
align 1
LABELV $611
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 86
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 57
byte 1 58
byte 1 10
byte 1 73
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 33
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $610
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 86
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 56
byte 1 58
byte 1 10
byte 1 83
byte 1 112
byte 1 121
byte 1 39
byte 1 115
byte 1 44
byte 1 32
byte 1 112
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 10
byte 1 111
byte 1 117
byte 1 116
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $609
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 86
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 55
byte 1 58
byte 1 10
byte 1 71
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 109
byte 1 97
byte 1 115
byte 1 107
byte 1 32
byte 1 111
byte 1 114
byte 1 10
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 33
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $608
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 86
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 54
byte 1 58
byte 1 10
byte 1 68
byte 1 97
byte 1 109
byte 1 110
byte 1 32
byte 1 83
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $607
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 86
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 53
byte 1 58
byte 1 10
byte 1 68
byte 1 97
byte 1 109
byte 1 110
byte 1 32
byte 1 83
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $606
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 86
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 52
byte 1 58
byte 1 10
byte 1 68
byte 1 73
byte 1 83
byte 1 67
byte 1 65
byte 1 82
byte 1 68
byte 1 33
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $605
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 86
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 51
byte 1 58
byte 1 10
byte 1 87
byte 1 104
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 10
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 102
byte 1 116
byte 1 63
byte 1 10
byte 1 0
align 1
LABELV $604
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 86
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 50
byte 1 58
byte 1 10
byte 1 71
byte 1 117
byte 1 121
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 78
byte 1 79
byte 1 84
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 117
byte 1 112
byte 1 10
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 104
byte 1 117
byte 1 110
byte 1 116
byte 1 101
byte 1 100
byte 1 63
byte 1 10
byte 1 0
align 1
LABELV $603
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 86
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 49
byte 1 58
byte 1 10
byte 1 85
byte 1 109
byte 1 44
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 77
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 115
byte 1 44
byte 1 32
byte 1 112
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 32
byte 1 100
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 10
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $602
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 98
byte 1 105
byte 1 101
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 49
byte 1 48
byte 1 58
byte 1 10
byte 1 87
byte 1 104
byte 1 97
byte 1 116
byte 1 39
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 63
byte 1 32
byte 1 73
byte 1 32
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 10
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 44
byte 1 32
byte 1 103
byte 1 117
byte 1 121
byte 1 115
byte 1 63
byte 1 10
byte 1 0
align 1
LABELV $601
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 98
byte 1 105
byte 1 101
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 57
byte 1 58
byte 1 10
byte 1 83
byte 1 116
byte 1 111
byte 1 112
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 109
byte 1 101
byte 1 33
byte 1 10
byte 1 73
byte 1 39
byte 1 109
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
byte 1 33
byte 1 10
byte 1 89
byte 1 111
byte 1 117
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
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 109
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 97
byte 1 120
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $600
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 98
byte 1 105
byte 1 101
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 56
byte 1 58
byte 1 10
byte 1 87
byte 1 104
byte 1 111
byte 1 39
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 105
byte 1 97
byte 1 99
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 97
byte 1 120
byte 1 101
byte 1 63
byte 1 10
byte 1 0
align 1
LABELV $599
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 98
byte 1 105
byte 1 101
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 55
byte 1 58
byte 1 10
byte 1 87
byte 1 104
byte 1 121
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 115
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 115
byte 1 10
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 63
byte 1 10
byte 1 0
align 1
LABELV $598
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 98
byte 1 105
byte 1 101
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 54
byte 1 58
byte 1 10
byte 1 87
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 39
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 32
byte 1 114
byte 1 111
byte 1 111
byte 1 109
byte 1 63
byte 1 10
byte 1 0
align 1
LABELV $597
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 98
byte 1 105
byte 1 101
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 53
byte 1 58
byte 1 10
byte 1 87
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 32
byte 1 100
byte 1 111
byte 1 32
byte 1 73
byte 1 32
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 63
byte 1 33
byte 1 63
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $596
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 98
byte 1 105
byte 1 101
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 52
byte 1 58
byte 1 10
byte 1 72
byte 1 111
byte 1 119
byte 1 32
byte 1 100
byte 1 111
byte 1 32
byte 1 73
byte 1 32
byte 1 116
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 115
byte 1 63
byte 1 10
byte 1 0
align 1
LABELV $595
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 98
byte 1 105
byte 1 101
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 51
byte 1 58
byte 1 10
byte 1 72
byte 1 101
byte 1 121
byte 1 44
byte 1 32
byte 1 104
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 44
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 115
byte 1 111
byte 1 108
byte 1 100
byte 1 105
byte 1 101
byte 1 114
byte 1 32
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 114
byte 1 111
byte 1 111
byte 1 102
byte 1 33
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $594
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 98
byte 1 105
byte 1 101
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 50
byte 1 58
byte 1 10
byte 1 85
byte 1 109
byte 1 109
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 72
byte 1 111
byte 1 119
byte 1 32
byte 1 100
byte 1 111
byte 1 32
byte 1 73
byte 1 32
byte 1 116
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 32
byte 1 97
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 63
byte 1 10
byte 1 0
align 1
LABELV $593
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 98
byte 1 105
byte 1 101
byte 1 32
byte 1 81
byte 1 117
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 35
byte 1 49
byte 1 58
byte 1 10
byte 1 85
byte 1 109
byte 1 109
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 72
byte 1 111
byte 1 119
byte 1 32
byte 1 100
byte 1 111
byte 1 32
byte 1 73
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 63
byte 1 10
byte 1 0
align 1
LABELV $592
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 73
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 111
byte 1 108
byte 1 39
byte 1 32
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 32
byte 1 73
byte 1 97
byte 1 110
byte 1 32
byte 1 119
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 106
byte 1 97
byte 1 105
byte 1 108
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 82
byte 1 111
byte 1 98
byte 1 105
byte 1 110
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $591
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 73
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 111
byte 1 108
byte 1 39
byte 1 32
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 109
byte 1 111
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 105
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 108
byte 1 121
byte 1 10
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 83
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 115
byte 1 116
byte 1 32
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 44
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 116
byte 1 10
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 114
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $590
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 73
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 111
byte 1 108
byte 1 39
byte 1 32
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 87
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 117
byte 1 97
byte 1 108
byte 1 108
byte 1 121
byte 1 32
byte 1 104
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 119
byte 1 101
byte 1 108
byte 1 108
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $589
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 73
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 111
byte 1 108
byte 1 39
byte 1 32
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 97
byte 1 121
byte 1 10
byte 1 34
byte 1 87
byte 1 104
byte 1 97
byte 1 116
byte 1 39
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 98
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 63
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $588
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 73
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 111
byte 1 108
byte 1 39
byte 1 32
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 73
byte 1 32
byte 1 100
byte 1 105
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 10
byte 1 65
byte 1 78
byte 1 89
byte 1 84
byte 1 72
byte 1 73
byte 1 78
byte 1 71
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 84
byte 1 70
byte 1 10
byte 1 0
align 1
LABELV $587
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 73
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 111
byte 1 108
byte 1 39
byte 1 32
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 73
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 84
byte 1 70
byte 1 32
byte 1 105
byte 1 110
byte 1 10
byte 1 49
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 32
byte 1 50
byte 1 48
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $586
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 73
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 111
byte 1 108
byte 1 39
byte 1 32
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 114
byte 1 105
byte 1 102
byte 1 108
byte 1 101
byte 1 32
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 10
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $585
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 73
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 111
byte 1 108
byte 1 39
byte 1 32
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 50
byte 1 102
byte 1 111
byte 1 114
byte 1 116
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 111
byte 1 110
byte 1 108
byte 1 121
byte 1 32
byte 1 84
byte 1 70
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 46
byte 1 10
byte 1 87
byte 1 101
byte 1 32
byte 1 115
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 10
byte 1 119
byte 1 97
byte 1 121
byte 1 32
byte 1 115
byte 1 105
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 110
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 115
byte 1 105
byte 1 103
byte 1 104
byte 1 0
align 1
LABELV $584
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 73
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 111
byte 1 108
byte 1 39
byte 1 32
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 110
byte 1 111
byte 1 45
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 107
byte 1 110
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 111
byte 1 119
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 10
byte 1 104
byte 1 97
byte 1 110
byte 1 100
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
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $583
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 73
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 111
byte 1 108
byte 1 39
byte 1 32
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 32
byte 1 119
byte 1 101
byte 1 114
byte 1 101
byte 1 32
byte 1 50
byte 1 32
byte 1 84
byte 1 70
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 114
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 119
byte 1 97
byte 1 121
byte 1 115
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 46
byte 1 0
align 1
LABELV $582
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 73
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 111
byte 1 108
byte 1 39
byte 1 32
byte 1 100
byte 1 97
byte 1 121
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 105
byte 1 109
byte 1 105
byte 1 110
byte 1 49
byte 1 32
byte 1 38
byte 1 32
byte 1 105
byte 1 109
byte 1 105
byte 1 110
byte 1 50
byte 1 10
byte 1 116
byte 1 111
byte 1 32
byte 1 106
byte 1 111
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
LABELV $581
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 34
byte 1 73
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 119
byte 1 111
byte 1 114
byte 1 107
byte 1 46
byte 1 10
byte 1 69
byte 1 108
byte 1 115
byte 1 101
byte 1 32
byte 1 73
byte 1 32
byte 1 99
byte 1 117
byte 1 116
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 105
byte 1 114
byte 1 32
byte 1 115
byte 1 117
byte 1 112
byte 1 112
byte 1 108
byte 1 105
byte 1 101
byte 1 115
byte 1 34
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 45
byte 1 32
byte 1 86
byte 1 111
byte 1 109
byte 1 105
byte 1 116
byte 1 103
byte 1 111
byte 1 100
byte 1 44
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 84
byte 1 70
byte 1 83
byte 1 10
byte 1 0
align 1
LABELV $580
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 34
byte 1 65
byte 1 102
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 44
byte 1 32
byte 1 84
byte 1 70
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 73
byte 1 78
byte 1 83
byte 1 85
byte 1 76
byte 1 84
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 10
byte 1 112
byte 1 117
byte 1 114
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 33
byte 1 34
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 45
byte 1 32
byte 1 77
byte 1 106
byte 1 111
byte 1 108
byte 1 108
byte 1 110
byte 1 105
byte 1 114
byte 1 44
byte 1 32
byte 1 119
byte 1 104
byte 1 111
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 106
byte 1 111
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 108
byte 1 108
byte 1 121
byte 1 33
byte 1 0
align 1
LABELV $579
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 34
byte 1 84
byte 1 119
byte 1 105
byte 1 110
byte 1 32
byte 1 80
byte 1 101
byte 1 97
byte 1 107
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 109
byte 1 111
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 46
byte 1 34
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 45
byte 1 32
byte 1 84
byte 1 121
byte 1 82
byte 1 44
byte 1 32
byte 1 49
byte 1 54
byte 1 116
byte 1 104
byte 1 32
byte 1 74
byte 1 117
byte 1 108
byte 1 121
byte 1 44
byte 1 32
byte 1 50
byte 1 53
byte 1 116
byte 1 104
byte 1 32
byte 1 74
byte 1 117
byte 1 108
byte 1 121
byte 1 44
byte 1 32
byte 1 50
byte 1 110
byte 1 100
byte 1 32
byte 1 65
byte 1 117
byte 1 103
byte 1 117
byte 1 115
byte 1 116
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $578
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 119
byte 1 105
byte 1 110
byte 1 32
byte 1 80
byte 1 101
byte 1 97
byte 1 107
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 117
byte 1 104
byte 1 104
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 101
byte 1 114
byte 1 114
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 115
byte 1 111
byte 1 111
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $577
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 66
byte 1 65
byte 1 72
byte 1 33
byte 1 32
byte 1 73
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 97
byte 1 32
byte 1 112
byte 1 117
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 109
byte 1 97
byte 1 110
byte 1 10
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 119
byte 1 104
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 73
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 105
byte 1 116
byte 1 33
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 45
byte 1 32
byte 1 71
byte 1 117
byte 1 100
byte 1 108
byte 1 121
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $576
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 77
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 112
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 119
byte 1 101
byte 1 114
byte 1 101
byte 1 32
byte 1 104
byte 1 97
byte 1 114
byte 1 109
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 10
byte 1 109
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 100
byte 1 117
byte 1 99
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $575
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 34
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 117
byte 1 121
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 108
byte 1 108
byte 1 121
byte 1 32
byte 1 102
byte 1 117
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 117
byte 1 112
byte 1 10
byte 1 32
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 97
byte 1 108
byte 1 115
byte 1 44
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 63
byte 1 34
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 45
byte 1 32
byte 1 84
byte 1 121
byte 1 82
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 65
byte 1 117
byte 1 115
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 10
byte 1 0
align 1
LABELV $574
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 80
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 101
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $573
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 115
byte 1 33
byte 1 32
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 102
byte 1 97
byte 1 109
byte 1 105
byte 1 108
byte 1 121
byte 1 33
byte 1 10
byte 1 83
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 112
byte 1 101
byte 1 116
byte 1 115
byte 1 33
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 104
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 33
byte 1 10
byte 1 71
byte 1 101
byte 1 116
byte 1 32
byte 1 84
byte 1 70
byte 1 32
byte 1 78
byte 1 111
byte 1 119
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $572
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 104
byte 1 109
byte 1 109
byte 1 46
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 73
byte 1 32
byte 1 119
byte 1 111
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 10
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 98
byte 1 101
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $571
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 70
byte 1 32
byte 1 73
byte 1 73
byte 1 32
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 50
byte 1 110
byte 1 100
byte 1 32
byte 1 113
byte 1 117
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 57
byte 1 56
byte 1 10
byte 1 0
align 1
LABELV $570
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 70
byte 1 111
byte 1 114
byte 1 116
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 121
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 100
byte 1 97
byte 1 121
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $569
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 50
byte 1 53
byte 1 44
byte 1 48
byte 1 48
byte 1 48
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 115
byte 1 10
byte 1 53
byte 1 48
byte 1 32
byte 1 100
byte 1 111
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 10
byte 1 68
byte 1 97
byte 1 109
byte 1 110
byte 1 44
byte 1 32
byte 1 98
byte 1 117
byte 1 116
byte 1 32
byte 1 119
byte 1 101
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $568
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 73
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 115
byte 1 115
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 10
byte 1 32
byte 1 112
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 44
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 84
byte 1 70
byte 1 63
byte 1 10
byte 1 40
byte 1 66
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 73
byte 1 97
byte 1 110
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $567
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 101
byte 1 101
byte 1 104
byte 1 97
byte 1 33
byte 1 10
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 53
byte 1 48
byte 1 53
byte 1 44
byte 1 54
byte 1 55
byte 1 50
byte 1 110
byte 1 100
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 10
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 108
byte 1 97
byte 1 105
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 98
byte 1 114
byte 1 105
byte 1 100
byte 1 103
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $566
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 67
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 83
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 10
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 66
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 58
byte 1 10
byte 1 37
byte 1 52
byte 1 100
byte 1 0
align 1
LABELV $565
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 72
byte 1 65
byte 1 80
byte 1 80
byte 1 89
byte 1 32
byte 1 66
byte 1 73
byte 1 82
byte 1 84
byte 1 72
byte 1 68
byte 1 65
byte 1 89
byte 1 32
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 70
byte 1 79
byte 1 82
byte 1 84
byte 1 82
byte 1 69
byte 1 83
byte 1 83
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $550
byte 1 61
byte 1 61
byte 1 61
byte 1 32
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 83
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 32
byte 1 61
byte 1 61
byte 1 61
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $549
byte 1 78
byte 1 111
byte 1 32
byte 1 67
byte 1 111
byte 1 108
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
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
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
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $542
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 58
byte 1 10
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 83
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 83
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 83
byte 1 111
byte 1 108
byte 1 100
byte 1 105
byte 1 101
byte 1 114
byte 1 32
byte 1 10
byte 1 144
byte 1 150
byte 1 145
byte 1 32
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 109
byte 1 97
byte 1 110
byte 1 32
byte 1 10
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 77
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 152
byte 1 145
byte 1 32
byte 1 72
byte 1 118
byte 1 119
byte 1 101
byte 1 112
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 153
byte 1 145
byte 1 32
byte 1 80
byte 1 121
byte 1 114
byte 1 111
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 154
byte 1 145
byte 1 32
byte 1 83
byte 1 112
byte 1 121
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 155
byte 1 145
byte 1 32
byte 1 69
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 101
byte 1 101
byte 1 114
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $528
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
byte 1 103
byte 1 111
byte 1 32
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
byte 1 32
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 110
byte 1 111
byte 1 119
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $525
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
byte 1 103
byte 1 111
byte 1 32
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
byte 1 32
byte 1 119
byte 1 104
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 103
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $518
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 144
byte 1 152
byte 1 145
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $505
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $504
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $503
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $502
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $501
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 83
byte 1 116
byte 1 111
byte 1 112
byte 1 32
byte 1 70
byte 1 101
byte 1 105
byte 1 103
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $500
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 70
byte 1 101
byte 1 105
byte 1 103
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 150
byte 1 145
byte 1 32
byte 1 83
byte 1 105
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 70
byte 1 101
byte 1 105
byte 1 103
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $496
byte 1 84
byte 1 104
byte 1 101
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
byte 1 105
byte 1 115
byte 1 32
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $491
byte 1 78
byte 1 111
byte 1 32
byte 1 66
byte 1 105
byte 1 111
byte 1 83
byte 1 117
byte 1 105
byte 1 116
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
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 77
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 10
byte 1 0
align 1
LABELV $490
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 66
byte 1 105
byte 1 111
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $485
byte 1 78
byte 1 111
byte 1 32
byte 1 118
byte 1 97
byte 1 99
byte 1 99
byte 1 105
byte 1 110
byte 1 101
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
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 77
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 10
byte 1 0
align 1
LABELV $482
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
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $481
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $478
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 115
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
byte 1 100
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $477
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
LABELV $474
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 108
byte 1 101
byte 1 103
byte 1 32
byte 1 119
byte 1 111
byte 1 117
byte 1 110
byte 1 100
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
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $471
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
LABELV $460
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
LABELV $453
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
LABELV $450
byte 1 121
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
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 101
byte 1 100
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
byte 1 10
byte 1 0
align 1
LABELV $438
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
LABELV $435
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
LABELV $431
byte 1 121
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
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 104
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
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $419
byte 1 121
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
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 99
byte 1 117
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $418
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
LABELV $409
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $392
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 108
byte 1 114
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $377
byte 1 85
byte 1 115
byte 1 101
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
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 147
byte 1 145
byte 1 46
byte 1 46
byte 1 32
byte 1 87
byte 1 105
byte 1 116
byte 1 104
byte 1 100
byte 1 114
byte 1 97
byte 1 119
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 148
byte 1 145
byte 1 46
byte 1 46
byte 1 32
byte 1 87
byte 1 105
byte 1 116
byte 1 104
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 32
byte 1 115
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 149
byte 1 145
byte 1 46
byte 1 46
byte 1 32
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 32
byte 1 38
byte 1 32
byte 1 86
byte 1 97
byte 1 99
byte 1 99
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 150
byte 1 145
byte 1 46
byte 1 46
byte 1 32
byte 1 66
byte 1 105
byte 1 111
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 32
byte 1 40
byte 1 65
byte 1 110
byte 1 116
byte 1 105
byte 1 84
byte 1 111
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 41
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 151
byte 1 145
byte 1 46
byte 1 46
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $371
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $365
byte 1 82
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 52
byte 1 53
byte 1 32
byte 1 100
byte 1 101
byte 1 103
byte 1 114
byte 1 101
byte 1 101
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $363
byte 1 39
byte 1 115
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $362
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 121
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
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $359
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $351
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 117
byte 1 112
byte 1 103
byte 1 114
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
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
byte 1 0
align 1
LABELV $316
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 80
byte 1 117
byte 1 116
byte 1 32
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 37
byte 1 115
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 82
byte 1 101
byte 1 112
byte 1 97
byte 1 105
byte 1 114
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 150
byte 1 145
byte 1 32
byte 1 68
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 144
byte 1 152
byte 1 145
byte 1 32
byte 1 82
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 101
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $315
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 80
byte 1 117
byte 1 116
byte 1 32
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 37
byte 1 115
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 82
byte 1 101
byte 1 112
byte 1 97
byte 1 105
byte 1 114
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 150
byte 1 145
byte 1 32
byte 1 68
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 144
byte 1 152
byte 1 145
byte 1 32
byte 1 82
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 101
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 55
byte 1 145
byte 1 32
byte 1 85
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $304
byte 1 144
byte 1 153
byte 1 145
byte 1 32
byte 1 77
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $303
byte 1 144
byte 1 153
byte 1 145
byte 1 32
byte 1 77
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $302
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 85
byte 1 112
byte 1 103
byte 1 114
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $296
byte 1 39
byte 1 115
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
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $295
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 0
align 1
LABELV $294
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 121
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
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $291
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
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
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $286
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 116
byte 1 110
byte 1 107
byte 1 97
byte 1 116
byte 1 99
byte 1 107
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $259
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $255
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 80
byte 1 117
byte 1 116
byte 1 32
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 80
byte 1 117
byte 1 116
byte 1 32
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 82
byte 1 101
byte 1 112
byte 1 97
byte 1 105
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 150
byte 1 145
byte 1 32
byte 1 68
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 110
byte 1 116
byte 1 108
byte 1 101
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $250
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
LABELV $246
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
LABELV $235
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 112
byte 1 97
byte 1 105
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $230
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
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 97
byte 1 105
byte 1 114
byte 1 33
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $223
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $209
byte 1 144
byte 1 154
byte 1 145
byte 1 32
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 116
byte 1 101
byte 1 108
byte 1 121
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 111
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $208
byte 1 144
byte 1 153
byte 1 145
byte 1 32
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 116
byte 1 101
byte 1 108
byte 1 121
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 111
byte 1 110
byte 1 97
byte 1 116
byte 1 101
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
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $207
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $206
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $205
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 32
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 38
byte 1 65
byte 1 114
byte 1 109
byte 1 111
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
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $204
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $203
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 154
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 97
byte 1 103
byte 1 97
byte 1 105
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $198
byte 1 67
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 58
byte 1 10
byte 1 105
byte 1 110
byte 1 118
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 58
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 10
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 49
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 58
byte 1 32
byte 1 84
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 49
byte 1 10
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 50
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 58
byte 1 32
byte 1 84
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 50
byte 1 10
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 58
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 10
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
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
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $185
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $182
byte 1 116
byte 1 102
byte 1 95
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 0
align 1
LABELV $180
byte 1 197
byte 1 206
byte 1 199
byte 1 201
byte 1 206
byte 1 197
byte 1 197
byte 1 210
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 10
byte 1 10
byte 1 215
byte 1 197
byte 1 193
byte 1 208
byte 1 207
byte 1 206
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 49
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 112
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 50
byte 1 46
byte 1 46
byte 1 32
byte 1 82
byte 1 97
byte 1 105
byte 1 108
byte 1 71
byte 1 117
byte 1 110
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 51
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 69
byte 1 77
byte 1 80
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 58
byte 1 32
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 83
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 77
byte 1 97
byte 1 103
byte 1 32
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $179
byte 1 211
byte 1 208
byte 1 217
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 10
byte 1 10
byte 1 215
byte 1 197
byte 1 193
byte 1 208
byte 1 207
byte 1 206
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 50
byte 1 46
byte 1 46
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
byte 1 101
byte 1 114
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 51
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 52
byte 1 46
byte 1 46
byte 1 32
byte 1 77
byte 1 65
byte 1 67
byte 1 45
byte 1 49
byte 1 48
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 56
byte 1 46
byte 1 46
byte 1 32
byte 1 71
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 32
byte 1 72
byte 1 111
byte 1 111
byte 1 107
byte 1 32
byte 1 10
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 72
byte 1 97
byte 1 108
byte 1 108
byte 1 117
byte 1 99
byte 1 105
byte 1 110
byte 1 111
byte 1 103
byte 1 101
byte 1 110
byte 1 105
byte 1 99
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 71
byte 1 111
byte 1 32
byte 1 85
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 103
byte 1 117
byte 1 105
byte 1 115
byte 1 101
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $178
byte 1 208
byte 1 217
byte 1 210
byte 1 207
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 10
byte 1 10
byte 1 215
byte 1 197
byte 1 193
byte 1 208
byte 1 207
byte 1 206
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 50
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 54
byte 1 46
byte 1 46
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 55
byte 1 46
byte 1 46
byte 1 32
byte 1 73
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
byte 1 67
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 110
byte 1 10
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 78
byte 1 97
byte 1 112
byte 1 97
byte 1 108
byte 1 109
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 78
byte 1 111
byte 1 110
byte 1 101
byte 1 10
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $177
byte 1 200
byte 1 197
byte 1 193
byte 1 214
byte 1 217
byte 1 32
byte 1 215
byte 1 197
byte 1 193
byte 1 208
byte 1 207
byte 1 206
byte 1 211
byte 1 32
byte 1 199
byte 1 213
byte 1 217
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 10
byte 1 10
byte 1 215
byte 1 197
byte 1 193
byte 1 208
byte 1 207
byte 1 206
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 50
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 51
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 55
byte 1 46
byte 1 46
byte 1 32
byte 1 65
byte 1 115
byte 1 115
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 32
byte 1 67
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 110
byte 1 10
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 77
byte 1 105
byte 1 114
byte 1 118
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 58
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 10
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $176
byte 1 205
byte 1 197
byte 1 196
byte 1 201
byte 1 195
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 10
byte 1 10
byte 1 215
byte 1 197
byte 1 193
byte 1 208
byte 1 207
byte 1 206
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 49
byte 1 46
byte 1 46
byte 1 32
byte 1 77
byte 1 101
byte 1 100
byte 1 105
byte 1 107
byte 1 105
byte 1 116
byte 1 47
byte 1 66
byte 1 105
byte 1 111
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 50
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 51
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 53
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 78
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 67
byte 1 111
byte 1 110
byte 1 99
byte 1 117
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 121
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $175
byte 1 196
byte 1 197
byte 1 205
byte 1 207
byte 1 204
byte 1 201
byte 1 212
byte 1 201
byte 1 207
byte 1 206
byte 1 211
byte 1 32
byte 1 205
byte 1 193
byte 1 206
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 10
byte 1 10
byte 1 215
byte 1 197
byte 1 193
byte 1 208
byte 1 207
byte 1 206
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 50
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 53
byte 1 46
byte 1 46
byte 1 32
byte 1 76
byte 1 111
byte 1 110
byte 1 103
byte 1 45
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 54
byte 1 46
byte 1 46
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 55
byte 1 46
byte 1 46
byte 1 80
byte 1 105
byte 1 112
byte 1 101
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 10
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 77
byte 1 105
byte 1 114
byte 1 118
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 53
byte 1 44
byte 1 100
byte 1 101
byte 1 116
byte 1 50
byte 1 48
byte 1 44
byte 1 100
byte 1 101
byte 1 116
byte 1 53
byte 1 48
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 111
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 80
byte 1 105
byte 1 112
byte 1 101
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 65
byte 1 105
byte 1 114
byte 1 77
byte 1 73
byte 1 82
byte 1 86
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $174
byte 1 211
byte 1 207
byte 1 204
byte 1 196
byte 1 201
byte 1 197
byte 1 210
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 10
byte 1 10
byte 1 215
byte 1 197
byte 1 193
byte 1 208
byte 1 207
byte 1 206
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 50
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 51
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 55
byte 1 46
byte 1 46
byte 1 32
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 10
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 78
byte 1 97
byte 1 105
byte 1 108
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 58
byte 1 32
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 32
byte 1 97
byte 1 32
byte 1 83
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 51
byte 1 32
byte 1 58
byte 1 32
byte 1 83
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 80
byte 1 114
byte 1 111
byte 1 120
byte 1 105
byte 1 77
byte 1 105
byte 1 110
byte 1 101
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $173
byte 1 211
byte 1 206
byte 1 201
byte 1 208
byte 1 197
byte 1 210
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 10
byte 1 10
byte 1 215
byte 1 197
byte 1 193
byte 1 208
byte 1 207
byte 1 206
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 50
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 82
byte 1 105
byte 1 102
byte 1 108
byte 1 101
byte 1 47
byte 1 65
byte 1 117
byte 1 116
byte 1 111
byte 1 32
byte 1 82
byte 1 105
byte 1 102
byte 1 108
byte 1 101
byte 1 10
byte 1 52
byte 1 46
byte 1 46
byte 1 32
byte 1 77
byte 1 65
byte 1 67
byte 1 45
byte 1 49
byte 1 48
byte 1 32
byte 1 10
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 10
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 32
byte 1 58
byte 1 32
byte 1 84
byte 1 111
byte 1 103
byte 1 103
byte 1 108
byte 1 101
byte 1 32
byte 1 83
byte 1 99
byte 1 111
byte 1 112
byte 1 101
byte 1 32
byte 1 65
byte 1 117
byte 1 116
byte 1 111
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 108
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 10
byte 1 97
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 58
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 97
byte 1 110
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
byte 1 10
byte 1 32
byte 1 43
byte 1 115
byte 1 112
byte 1 111
byte 1 116
byte 1 32
byte 1 58
byte 1 32
byte 1 84
byte 1 111
byte 1 103
byte 1 103
byte 1 108
byte 1 101
byte 1 32
byte 1 83
byte 1 112
byte 1 111
byte 1 116
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $172
byte 1 211
byte 1 195
byte 1 207
byte 1 213
byte 1 212
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 10
byte 1 215
byte 1 197
byte 1 193
byte 1 208
byte 1 207
byte 1 206
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 50
byte 1 46
byte 1 46
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 52
byte 1 46
byte 1 46
byte 1 32
byte 1 77
byte 1 65
byte 1 67
byte 1 45
byte 1 49
byte 1 48
byte 1 32
byte 1 10
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 67
byte 1 111
byte 1 110
byte 1 99
byte 1 117
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 10
byte 1 83
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 49
byte 1 48
byte 1 44
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 51
byte 1 48
byte 1 44
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 49
byte 1 48
byte 1 48
byte 1 10
byte 1 74
byte 1 101
byte 1 116
byte 1 74
byte 1 117
byte 1 109
byte 1 112
byte 1 58
byte 1 32
byte 1 106
byte 1 101
byte 1 116
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 10
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 58
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 32
byte 1 97
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 10
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $171
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 69
byte 1 77
byte 1 80
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 58
byte 1 32
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 83
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 77
byte 1 97
byte 1 103
byte 1 32
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 10
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 154
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $170
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 72
byte 1 97
byte 1 108
byte 1 108
byte 1 117
byte 1 99
byte 1 105
byte 1 110
byte 1 111
byte 1 103
byte 1 101
byte 1 110
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 71
byte 1 111
byte 1 32
byte 1 85
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 103
byte 1 117
byte 1 105
byte 1 115
byte 1 101
byte 1 10
byte 1 83
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 154
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $169
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 78
byte 1 97
byte 1 112
byte 1 97
byte 1 108
byte 1 109
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 32
byte 1 112
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 10
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 154
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $168
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 77
byte 1 105
byte 1 114
byte 1 118
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 83
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 83
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 10
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 154
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $167
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 67
byte 1 111
byte 1 110
byte 1 99
byte 1 117
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 32
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 51
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 10
byte 1 10
byte 1 10
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 154
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $166
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 77
byte 1 105
byte 1 114
byte 1 118
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 68
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 53
byte 1 44
byte 1 100
byte 1 101
byte 1 116
byte 1 50
byte 1 48
byte 1 44
byte 1 100
byte 1 101
byte 1 116
byte 1 53
byte 1 48
byte 1 10
byte 1 68
byte 1 101
byte 1 116
byte 1 111
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 80
byte 1 105
byte 1 112
byte 1 101
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 32
byte 1 32
byte 1 10
byte 1 65
byte 1 105
byte 1 114
byte 1 45
byte 1 77
byte 1 73
byte 1 82
byte 1 86
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 154
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $165
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 78
byte 1 97
byte 1 105
byte 1 108
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 32
byte 1 97
byte 1 32
byte 1 83
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 32
byte 1 32
byte 1 32
byte 1 58
byte 1 32
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 10
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 51
byte 1 32
byte 1 58
byte 1 32
byte 1 83
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 80
byte 1 114
byte 1 111
byte 1 120
byte 1 105
byte 1 77
byte 1 105
byte 1 110
byte 1 101
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 10
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 154
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $164
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 70
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 32
byte 1 58
byte 1 32
byte 1 84
byte 1 111
byte 1 103
byte 1 103
byte 1 108
byte 1 101
byte 1 32
byte 1 82
byte 1 105
byte 1 102
byte 1 108
byte 1 101
byte 1 32
byte 1 65
byte 1 117
byte 1 116
byte 1 111
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 83
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 65
byte 1 108
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 32
byte 1 32
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 67
byte 1 97
byte 1 108
byte 1 108
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
byte 1 58
byte 1 32
byte 1 97
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 107
byte 1 101
byte 1 10
byte 1 32
byte 1 32
byte 1 83
byte 1 112
byte 1 111
byte 1 116
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 58
byte 1 32
byte 1 43
byte 1 115
byte 1 112
byte 1 111
byte 1 116
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 154
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $163
byte 1 199
byte 1 210
byte 1 197
byte 1 206
byte 1 193
byte 1 196
byte 1 197
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 70
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 67
byte 1 111
byte 1 110
byte 1 99
byte 1 117
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 211
byte 1 208
byte 1 197
byte 1 195
byte 1 201
byte 1 193
byte 1 204
byte 1 32
byte 1 195
byte 1 207
byte 1 205
byte 1 205
byte 1 193
byte 1 206
byte 1 196
byte 1 211
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 83
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 49
byte 1 48
byte 1 44
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 53
byte 1 48
byte 1 44
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 50
byte 1 53
byte 1 48
byte 1 10
byte 1 74
byte 1 101
byte 1 116
byte 1 74
byte 1 117
byte 1 109
byte 1 112
byte 1 58
byte 1 32
byte 1 106
byte 1 101
byte 1 116
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 10
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 32
byte 1 58
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 32
byte 1 97
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 10
byte 1 10
byte 1 10
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 154
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $162
byte 1 197
byte 1 206
byte 1 199
byte 1 201
byte 1 206
byte 1 197
byte 1 197
byte 1 210
byte 1 32
byte 1 141
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 10
byte 1 160
byte 1 247
byte 1 229
byte 1 225
byte 1 240
byte 1 239
byte 1 238
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 119
byte 1 114
byte 1 101
byte 1 110
byte 1 99
byte 1 104
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 231
byte 1 242
byte 1 229
byte 1 238
byte 1 225
byte 1 228
byte 1 229
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 147
byte 1 186
byte 1 32
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 148
byte 1 186
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 228
byte 1 242
byte 1 239
byte 1 240
byte 1 243
byte 1 186
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 147
byte 1 186
byte 1 160
byte 1 109
byte 1 97
byte 1 103
byte 1 110
byte 1 101
byte 1 116
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 149
byte 1 186
byte 1 160
byte 1 108
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 227
byte 1 239
byte 1 237
byte 1 237
byte 1 225
byte 1 238
byte 1 228
byte 1 243
byte 1 186
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 186
byte 1 32
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 186
byte 1 32
byte 1 109
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 10
byte 1 0
align 1
LABELV $161
byte 1 211
byte 1 208
byte 1 217
byte 1 32
byte 1 141
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 247
byte 1 229
byte 1 225
byte 1 240
byte 1 239
byte 1 238
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 116
byte 1 114
byte 1 97
byte 1 110
byte 1 113
byte 1 117
byte 1 105
byte 1 108
byte 1 105
byte 1 122
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 150
byte 1 145
byte 1 32
byte 1 109
byte 1 97
byte 1 99
byte 1 45
byte 1 49
byte 1 48
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 154
byte 1 145
byte 1 32
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 231
byte 1 242
byte 1 229
byte 1 238
byte 1 225
byte 1 228
byte 1 229
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 147
byte 1 186
byte 1 32
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 148
byte 1 186
byte 1 32
byte 1 103
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 228
byte 1 242
byte 1 239
byte 1 240
byte 1 243
byte 1 186
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 147
byte 1 186
byte 1 160
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 227
byte 1 239
byte 1 237
byte 1 237
byte 1 225
byte 1 238
byte 1 228
byte 1 243
byte 1 186
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 186
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 103
byte 1 117
byte 1 105
byte 1 115
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $160
byte 1 208
byte 1 217
byte 1 210
byte 1 207
byte 1 32
byte 1 141
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 247
byte 1 229
byte 1 225
byte 1 240
byte 1 239
byte 1 238
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 97
byte 1 120
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 152
byte 1 145
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 45
byte 1 116
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 153
byte 1 145
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
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 231
byte 1 242
byte 1 229
byte 1 238
byte 1 225
byte 1 228
byte 1 229
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 147
byte 1 186
byte 1 32
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 148
byte 1 186
byte 1 32
byte 1 110
byte 1 97
byte 1 112
byte 1 97
byte 1 108
byte 1 109
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 228
byte 1 242
byte 1 239
byte 1 240
byte 1 243
byte 1 186
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 147
byte 1 186
byte 1 160
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 32
byte 1 112
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $159
byte 1 200
byte 1 215
byte 1 199
byte 1 213
byte 1 217
byte 1 32
byte 1 141
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 247
byte 1 229
byte 1 225
byte 1 240
byte 1 239
byte 1 238
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 97
byte 1 120
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 153
byte 1 145
byte 1 32
byte 1 97
byte 1 115
byte 1 115
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 153
byte 1 145
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 231
byte 1 242
byte 1 229
byte 1 238
byte 1 225
byte 1 228
byte 1 229
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 147
byte 1 186
byte 1 32
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 148
byte 1 186
byte 1 32
byte 1 77
byte 1 73
byte 1 82
byte 1 86
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 228
byte 1 242
byte 1 239
byte 1 240
byte 1 243
byte 1 186
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 147
byte 1 186
byte 1 160
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $158
byte 1 205
byte 1 197
byte 1 196
byte 1 201
byte 1 195
byte 1 32
byte 1 141
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 247
byte 1 229
byte 1 225
byte 1 240
byte 1 239
byte 1 238
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 98
byte 1 105
byte 1 111
byte 1 97
byte 1 120
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 231
byte 1 242
byte 1 229
byte 1 238
byte 1 225
byte 1 228
byte 1 229
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 147
byte 1 186
byte 1 32
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 148
byte 1 186
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 99
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 228
byte 1 242
byte 1 239
byte 1 240
byte 1 243
byte 1 186
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 147
byte 1 186
byte 1 160
byte 1 105
byte 1 110
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 121
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 149
byte 1 186
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $157
byte 1 196
byte 1 197
byte 1 205
byte 1 207
byte 1 205
byte 1 193
byte 1 206
byte 1 32
byte 1 141
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 10
byte 1 160
byte 1 247
byte 1 229
byte 1 225
byte 1 240
byte 1 239
byte 1 238
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 97
byte 1 120
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 45
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 46
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 152
byte 1 145
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 153
byte 1 145
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
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 231
byte 1 242
byte 1 229
byte 1 238
byte 1 225
byte 1 228
byte 1 229
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 147
byte 1 186
byte 1 32
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 148
byte 1 186
byte 1 32
byte 1 77
byte 1 73
byte 1 82
byte 1 86
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 228
byte 1 242
byte 1 239
byte 1 240
byte 1 243
byte 1 186
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 147
byte 1 186
byte 1 160
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 32
byte 1 97
byte 1 105
byte 1 114
byte 1 77
byte 1 73
byte 1 82
byte 1 86
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 227
byte 1 239
byte 1 237
byte 1 237
byte 1 225
byte 1 238
byte 1 228
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 160
byte 1 10
byte 1 32
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 186
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 111
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 115
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 151
byte 1 186
byte 1 160
byte 1 32
byte 1 53
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 148
byte 1 146
byte 1 186
byte 1 160
byte 1 50
byte 1 48
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 151
byte 1 146
byte 1 186
byte 1 160
byte 1 53
byte 1 48
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
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
LABELV $156
byte 1 211
byte 1 207
byte 1 204
byte 1 196
byte 1 201
byte 1 197
byte 1 210
byte 1 32
byte 1 141
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 10
byte 1 160
byte 1 247
byte 1 229
byte 1 225
byte 1 240
byte 1 239
byte 1 238
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 97
byte 1 120
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 32
byte 1 144
byte 1 153
byte 1 145
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 231
byte 1 242
byte 1 229
byte 1 238
byte 1 225
byte 1 228
byte 1 229
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 147
byte 1 186
byte 1 32
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 148
byte 1 186
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
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 228
byte 1 242
byte 1 239
byte 1 240
byte 1 243
byte 1 186
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 147
byte 1 186
byte 1 160
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 149
byte 1 186
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
byte 1 160
byte 1 227
byte 1 239
byte 1 237
byte 1 237
byte 1 225
byte 1 238
byte 1 228
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 160
byte 1 10
byte 1 32
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 186
byte 1 32
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $155
byte 1 211
byte 1 206
byte 1 201
byte 1 208
byte 1 197
byte 1 210
byte 1 32
byte 1 141
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 247
byte 1 229
byte 1 225
byte 1 240
byte 1 239
byte 1 238
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 97
byte 1 120
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 115
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 114
byte 1 105
byte 1 102
byte 1 108
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 105
byte 1 102
byte 1 108
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 231
byte 1 242
byte 1 229
byte 1 238
byte 1 225
byte 1 228
byte 1 229
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 147
byte 1 186
byte 1 32
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 148
byte 1 186
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 228
byte 1 242
byte 1 239
byte 1 240
byte 1 243
byte 1 186
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 147
byte 1 186
byte 1 160
byte 1 97
byte 1 108
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 149
byte 1 186
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 97
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 227
byte 1 239
byte 1 237
byte 1 237
byte 1 225
byte 1 238
byte 1 228
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 160
byte 1 10
byte 1 32
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 186
byte 1 32
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $154
byte 1 193
byte 1 201
byte 1 210
byte 1 211
byte 1 195
byte 1 207
byte 1 213
byte 1 212
byte 1 32
byte 1 141
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 10
byte 1 160
byte 1 247
byte 1 229
byte 1 225
byte 1 240
byte 1 239
byte 1 238
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 97
byte 1 120
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 144
byte 1 150
byte 1 145
byte 1 32
byte 1 109
byte 1 97
byte 1 99
byte 1 45
byte 1 49
byte 1 48
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 231
byte 1 242
byte 1 229
byte 1 238
byte 1 225
byte 1 228
byte 1 229
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 147
byte 1 186
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
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 43
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 148
byte 1 186
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 99
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 228
byte 1 242
byte 1 239
byte 1 240
byte 1 243
byte 1 186
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 147
byte 1 186
byte 1 160
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 32
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 149
byte 1 186
byte 1 160
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 160
byte 1 227
byte 1 239
byte 1 237
byte 1 237
byte 1 225
byte 1 238
byte 1 228
byte 1 243
byte 1 186
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 160
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 160
byte 1 10
byte 1 32
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 186
byte 1 32
byte 1 106
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 98
byte 1 111
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $153
byte 1 87
byte 1 101
byte 1 108
byte 1 99
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 205
byte 1 229
byte 1 231
byte 1 225
byte 1 212
byte 1 198
byte 1 160
byte 1 144
byte 1 118
byte 1 50
byte 1 48
byte 1 48
byte 1 54
byte 1 45
byte 1 67
byte 1 145
byte 1 10
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
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 10
byte 1 104
byte 1 116
byte 1 116
byte 1 112
byte 1 58
byte 1 47
byte 1 47
byte 1 119
byte 1 119
byte 1 119
byte 1 46
byte 1 97
byte 1 109
byte 1 110
byte 1 101
byte 1 115
byte 1 105
byte 1 97
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 46
byte 1 99
byte 1 111
byte 1 109
byte 1 10
byte 1 0
align 1
LABELV $152
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $151
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 50
byte 1 0
align 1
LABELV $150
byte 1 0
align 1
LABELV $149
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 49
byte 1 0
align 1
LABELV $140
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 83
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 78
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 150
byte 1 145
byte 1 32
byte 1 67
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $139
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 77
byte 1 97
byte 1 107
byte 1 101
byte 1 58
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 83
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 78
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 150
byte 1 145
byte 1 32
byte 1 67
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 78
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $126
byte 1 37
byte 1 115
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $122
byte 1 37
byte 1 115
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $118
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 32
byte 1 111
byte 1 110
byte 1 108
byte 1 121
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 67
byte 1 105
byte 1 118
byte 1 105
byte 1 108
byte 1 105
byte 1 97
byte 1 110
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $96
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
LABELV $94
byte 1 144
byte 1 146
byte 1 145
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 66
byte 1 105
byte 1 114
byte 1 116
byte 1 104
byte 1 100
byte 1 97
byte 1 121
byte 1 32
byte 1 66
byte 1 111
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $93
byte 1 144
byte 1 146
byte 1 145
byte 1 32
byte 1 82
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 80
byte 1 67
byte 1 10
byte 1 0
align 1
LABELV $92
byte 1 144
byte 1 155
byte 1 145
byte 1 32
byte 1 69
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 101
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $91
byte 1 144
byte 1 154
byte 1 145
byte 1 32
byte 1 83
byte 1 112
byte 1 121
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $90
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 83
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 83
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 83
byte 1 111
byte 1 108
byte 1 100
byte 1 105
byte 1 101
byte 1 114
byte 1 32
byte 1 10
byte 1 144
byte 1 150
byte 1 145
byte 1 32
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 109
byte 1 97
byte 1 110
byte 1 32
byte 1 10
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 77
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 152
byte 1 145
byte 1 32
byte 1 72
byte 1 87
byte 1 71
byte 1 117
byte 1 121
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 153
byte 1 145
byte 1 32
byte 1 80
byte 1 121
byte 1 114
byte 1 111
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $89
byte 1 61
byte 1 61
byte 1 61
byte 1 32
byte 1 67
byte 1 104
byte 1 111
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 67
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 32
byte 1 61
byte 1 61
byte 1 61
byte 1 0
align 1
LABELV $72
byte 1 61
byte 1 61
byte 1 61
byte 1 32
byte 1 67
byte 1 104
byte 1 111
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 61
byte 1 61
byte 1 61
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $70
byte 1 61
byte 1 61
byte 1 61
byte 1 32
byte 1 67
byte 1 104
byte 1 111
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 61
byte 1 61
byte 1 61
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $67
byte 1 61
byte 1 61
byte 1 61
byte 1 32
byte 1 67
byte 1 104
byte 1 111
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 61
byte 1 61
byte 1 61
byte 1 10
byte 1 10
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 10
byte 1 10
byte 1 10
byte 1 144
byte 1 153
byte 1 145
byte 1 32
byte 1 66
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 109
byte 1 121
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 109
byte 1 101
byte 1 33
byte 1 10
byte 1 10
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
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
byte 1 112
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 58
byte 1 10
byte 1 104
byte 1 116
byte 1 116
byte 1 112
byte 1 58
byte 1 47
byte 1 47
byte 1 119
byte 1 119
byte 1 119
byte 1 46
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
byte 1 46
byte 1 99
byte 1 111
byte 1 109
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 102
byte 1 111
byte 1 114
byte 1 116
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 47
byte 1 10
byte 1 0
align 1
LABELV $64
byte 1 49
byte 1 49
byte 1 46
byte 1 50
byte 1 55
byte 1 46
byte 1 48
byte 1 54
byte 1 97
byte 1 0
align 1
LABELV $63
byte 1 205
byte 1 229
byte 1 231
byte 1 225
byte 1 212
byte 1 198
byte 1 160
byte 1 144
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 145
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $55
byte 1 144
byte 1 151
byte 1 145
byte 1 32
byte 1 65
byte 1 117
byte 1 116
byte 1 111
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 0
align 1
LABELV $54
byte 1 144
byte 1 150
byte 1 145
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 70
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 0
align 1
LABELV $53
byte 1 144
byte 1 149
byte 1 145
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 84
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 0
align 1
LABELV $52
byte 1 144
byte 1 148
byte 1 145
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 84
byte 1 119
byte 1 111
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $51
byte 1 144
byte 1 147
byte 1 145
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 79
byte 1 110
byte 1 101
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $50
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $37
byte 1 10
byte 1 0
