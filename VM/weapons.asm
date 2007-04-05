export W_Precache
code
proc W_Precache 0 4
file "..\src\weapons.c"
line 45
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
;21: *  $Id: weapons.c,v 1.34 2006/03/04 13:09:25 AngelD Exp $
;22: */
;23:
;24:#include "g_local.h"
;25:void    item_megahealth_rot(  );
;26:
;27:float   button_touch(  );
;28:void    button_fire(  );
;29:void	Toaster(  );
;30:void	W_FireBigAss(  );
;31:void	LavaPool(  );
;32:void	SpyPack(  );
;33:void	MakeHolo(  );
;34:void	Prox();
;35:void	SuperLeap();
;36:void	C_Mine();
;37:void	A_Mine();
;38:void	S_Mine();
;39:void	B_Mine();
;40:void	M_Mine();
;41:void	Drop3();
;42:
;43:
;44:void W_Precache(  )
;45:{
line 46
;46:	trap_precache_sound( "weapons/r_exp3.wav" );           // new rocket explosion               
ADDRGP4 $12
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 47
;47:	trap_precache_sound( "weapons/rocket1i.wav" );         // spike gun                          
ADDRGP4 $13
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 48
;48:	trap_precache_sound( "weapons/sgun1.wav" );                                                  
ADDRGP4 $14
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 49
;49:	trap_precache_sound( "weapons/guncock.wav" );          // player shotgun                     
ADDRGP4 $15
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 50
;50:	trap_precache_sound( "weapons/ric1.wav" );             // ricochet (used in c code)          
ADDRGP4 $16
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 51
;51:	trap_precache_sound( "weapons/ric2.wav" );             // ricochet (used in c code)          
ADDRGP4 $17
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 52
;52:	trap_precache_sound( "weapons/ric3.wav" );             // ricochet (used in c code)          
ADDRGP4 $18
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 53
;53:	trap_precache_sound( "weapons/spike2.wav" );           // super spikes                       
ADDRGP4 $19
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 54
;54:	trap_precache_sound( "weapons/tink1.wav" );            // spikes tink (used in c code)       
ADDRGP4 $20
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 55
;55:	trap_precache_sound( "weapons/grenade.wav" );          // grenade launcher                   
ADDRGP4 $21
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 56
;56:	trap_precache_sound( "weapons/bounce.wav" );           // grenade bounce                     
ADDRGP4 $22
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 57
;57:	trap_precache_sound( "weapons/shotgn2.wav" );          // super shotgun                      
ADDRGP4 $23
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 58
;58:	trap_precache_sound( "wizard/wattack.wav" );           // sniper rifle                       
ADDRGP4 $24
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 59
;59:	trap_precache_sound( "items/r_item1.wav" );            // Medikit                            
ADDRGP4 $25
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 60
;60:	trap_precache_sound( "items/r_item2.wav" );            // Medikit                            
ADDRGP4 $26
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 61
;61:	trap_precache_model( "progs/flame2.mdl" );             // Flamethrower                       
ADDRGP4 $27
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 62
;62:	trap_precache_sound( "ambience/fire1.wav" );                                                 
ADDRGP4 $28
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 63
;63:	trap_precache_sound( "blob/land1.wav" );               // Hook                               
ADDRGP4 $29
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 64
;64:	trap_precache_model( "progs/v_spike.mdl" );            // Hook                               
ADDRGP4 $30
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 65
;65:	trap_precache_sound( "hknight/hit.wav" );              	// Hook                       
ADDRGP4 $31
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 67
;66:	                                                                                             
;67:	trap_precache_sound( "weapons/detpack.wav" );           
ADDRGP4 $32
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 68
;68:	trap_precache_sound( "weapons/turrset.wav" );            // Sentry Gun Setup                 
ADDRGP4 $33
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 69
;69:	trap_precache_sound( "weapons/turrspot.wav" );           // Sentry Gun Spot                  
ADDRGP4 $34
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 70
;70:	trap_precache_sound( "weapons/turridle.wav" );           // Sentry Gun Idle                  
ADDRGP4 $35
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 71
;71:	trap_precache_sound( "weapons/sniper.wav" );             // sniper rifle                       
ADDRGP4 $36
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 72
;72:	trap_precache_sound( "weapons/flmfire2.wav" );           //flamethrower                         
ADDRGP4 $37
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 73
;73:	trap_precache_sound( "weapons/flmgrexp.wav" );           //flamethrower                       
ADDRGP4 $38
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 74
;74:	trap_precache_sound( "misc/vapeur2.wav" );               // flamethrower                     
ADDRGP4 $39
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 76
;75:	//trap_precache_sound( "weapons/asscan1.wav" );            // Assault Cannon Powerup           
;76:	trap_precache_sound( "weapons/asscan2.wav" );            // Assault Cannon Churning          
ADDRGP4 $40
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 77
;77:	trap_precache_sound( "weapons/asscan3.wav" );            // Assault Cannon Powerdown         
ADDRGP4 $41
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 78
;78:	trap_precache_sound( "weapons/asscan4.wav" );            
ADDRGP4 $42
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 79
;79:	trap_precache_sound( "weapons/railgun.wav" );            // Railgun                          
ADDRGP4 $43
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 80
;80:	trap_precache_sound( "weapons/dartgun.wav" );            // Spy's dart gun                   
ADDRGP4 $44
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 83
;81:	//trap_precache_sound( "count.wav" );                      // grenade prime sound
;82:
;83:	trap_precache_model( "progs/v_flame.mdl" );              
ADDRGP4 $45
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 84
;84:	trap_precache_model( "progs/v_tgun.mdl" );
ADDRGP4 $46
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 88
;85:
;86:	//megatf
;87:	//classes
;88:	trap_precache_sound( "hknight/slash1.wav" );			// spy jump sound
ADDRGP4 $47
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 89
;89:	trap_precache_sound( "hknight/hit.wav" );				// spy land sound
ADDRGP4 $31
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 91
;90:	//engineer
;91:	trap_precache_model( "progs/dispencr.mdl" );			// mtf engi disp model
ADDRGP4 $48
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 93
;92:	//misc
;93:	trap_precache_model( "progs/spikebal.mdl" );
ADDRGP4 $49
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 94
;94:	trap_precache_model( "progs/syringe.mdl" );
ADDRGP4 $50
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 95
;95:	trap_precache_sound( "weapons/jetjump.wav" );			// jetpack sound
ADDRGP4 $51
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 96
;96:	trap_precache_sound( "effects/mortar.wav" );			// super nailgun sound
ADDRGP4 $52
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 97
;97:	trap_precache_sound( "speech/excelent.wav" );			// headshot!
ADDRGP4 $53
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 98
;98:	trap_precache_sound( "weapons/rifle.wav" );				// sniper fire
ADDRGP4 $54
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 101
;99:	
;100:	//grenades
;101:	trap_precache_sound ("weapons/prime.wav");				// quake2 gren sound
ADDRGP4 $55
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 103
;102:	//trap_precache_sound ("weapons/throw.wav");			// toss sound - already precache'd
;103:	trap_precache_sound ("player/gas_mask.wav");			// self-gas sound
ADDRGP4 $56
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 105
;104:	//spiketrap
;105:	trap_precache_sound( "shambler/smack.wav" );
ADDRGP4 $57
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 106
;106:	trap_precache_sound( "doors/meduse.wav" );
ADDRGP4 $58
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 108
;107:	//syringe
;108:	trap_precache_sound( "player/mpain6.wav" );
ADDRGP4 $59
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 110
;109:	//alarm
;110:	trap_precache_sound( "effects/beep.wav" );
ADDRGP4 $60
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 111
;111:	trap_precache_sound( "misc/enemy.wav" );
ADDRGP4 $61
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 113
;112:	//flare
;113:	trap_precache_model( "progs/flare.spr" );				// flare sky sprite
ADDRGP4 $62
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 114
;114:	trap_precache_sound( "items/flare1.wav" );
ADDRGP4 $63
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 116
;115:	//airstrike
;116:	trap_precache_sound( "weapons/notarget.wav" );
ADDRGP4 $64
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 117
;117:	trap_precache_sound( "weapons/radioair.wav" );
ADDRGP4 $65
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 118
;118:	trap_precache_sound( "weapons/fighter.wav" );
ADDRGP4 $66
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 119
;119:	trap_precache_sound( "weapons/airstrik.wav" );
ADDRGP4 $67
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 121
;120:	//proximity nade
;121:	trap_precache_model( "progs/proxgren.mdl" );
ADDRGP4 $68
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 122
;122:	trap_precache_model( "progs/s_expl.spr" );
ADDRGP4 $69
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 123
;123:	trap_precache_sound( "buttons/switch02.wav" );
ADDRGP4 $70
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 125
;124:	// airmirv
;125:	trap_precache_model( "progs/hgren2.mdl" );
ADDRGP4 $71
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 126
;126:	trap_precache_model( "progs/air-mirv.mdl" );
ADDRGP4 $72
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 127
;127:	trap_precache_sound( "shambler/sboom.wav" );
ADDRGP4 $73
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 128
;128:	trap_precache_sound( "weapons/chngnu1a.wav" );
ADDRGP4 $74
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 130
;129:	//lavapool
;130:	trap_precache_model( "progs/lavapool.mdl" );
ADDRGP4 $75
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 131
;131:	trap_precache_model( "progs/lavaball.mdl" );
ADDRGP4 $76
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 132
;132:	trap_precache_sound( "weapons/throw.wav" );
ADDRGP4 $77
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 133
;133:	trap_precache_sound( "zombie/z_miss.wav" );
ADDRGP4 $78
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 134
;134:	trap_precache_sound( "misc/null.wav" );
ADDRGP4 $79
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 135
;135:	trap_precache_sound( "weapons/lavapool.wav" );
ADDRGP4 $80
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 137
;136:	// laser drone
;137:	trap_precache_model( "progs/lsrdrone.mdl" );
ADDRGP4 $81
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 138
;138:	trap_precache_model( "progs/beam.mdl" );
ADDRGP4 $82
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 139
;139:	trap_precache_sound( "weapons/drone.wav" );
ADDRGP4 $83
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 143
;140:	
;141:
;142:	// weapons
;143:	trap_precache_model( "progs/v_mac10.mdl" );				// MAC 10
ADDRGP4 $84
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 145
;144:	// 20mm
;145:	trap_precache_sound( "weapons/20mm.wav" );
ADDRGP4 $85
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 146
;146:	trap_precache_sound( "weapons/shell2.wav" );
ADDRGP4 $86
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 148
;147:	// assault cannon
;148:	trap_precache_sound ("weapons/chngnu1a.wav");
ADDRGP4 $74
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 149
;149:	trap_precache_sound ("weapons/chngnd1a.wav");
ADDRGP4 $87
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 151
;150:	// inc cannon
;151:	trap_precache_sound( "doors/airdoor2.wav" );
ADDRGP4 $88
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 152
;152:	trap_precache_model( "progs/incenrkt.mdl" );
ADDRGP4 $89
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 154
;153:	// grappling hook
;154:	trap_precache_model( "progs/rope.mdl" );
ADDRGP4 $90
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 155
;155:	trap_precache_sound( "doors/ddoor2.wav" );
ADDRGP4 $91
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 156
;156:	trap_precache_sound( "weapons/retract.wav" );
ADDRGP4 $92
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 157
;157:	trap_precache_sound( "weapons/unreel.wav" );
ADDRGP4 $93
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 159
;158:	//select sounds
;159:	trap_precache_sound( "weapons/rocklr1a.wav" );
ADDRGP4 $94
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 160
;160:	trap_precache_sound( "weapons/shotgr1a.wav" );		// also used with 20mm
ADDRGP4 $95
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 164
;161:	
;162:	//misc
;163:	// footsteps
;164:	trap_precache_sound( "player/step1r.wav" );  // right, left
ADDRGP4 $96
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 165
;165:	trap_precache_sound( "player/step1l.wav" );
ADDRGP4 $97
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 166
;166:	trap_precache_sound( "player/step2r.wav" );
ADDRGP4 $98
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 167
;167:	trap_precache_sound( "player/step2l.wav" );
ADDRGP4 $99
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 169
;168:	// night vision
;169:	trap_precache_sound( "items/nightvis.wav" );
ADDRGP4 $100
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 171
;170:	// ammo/weapon sounds
;171:	trap_precache_sound( "weapons/no_ammo.wav" );		// click sound when firing while reloading
ADDRGP4 $101
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 173
;172:	// holo
;173:	trap_precache_sound( "weapons/railgr1a.wav" );		// also railgun select sound
ADDRGP4 $102
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 174
;174:	trap_precache_sound( "ambient/100hzhum.wav" );
ADDRGP4 $103
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 176
;175:	// taunts
;176:	trap_precache_sound( "speech/pantsdwn.wav" );
ADDRGP4 $104
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 177
;177:	trap_precache_sound( "speech/pekaboo.wav" );
ADDRGP4 $105
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 178
;178:	trap_precache_sound( "speech/idoasskk.wav" );
ADDRGP4 $106
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 179
;179:	trap_precache_sound( "speech/pathetic.wav" );
ADDRGP4 $107
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 180
;180:	trap_precache_sound( "speech/call911.wav" );
ADDRGP4 $108
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 181
;181:	trap_precache_sound( "speech/kicknads.wav" );
ADDRGP4 $109
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 182
;182:	trap_precache_sound( "speech/threat.wav" );
ADDRGP4 $110
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 183
;183:	trap_precache_sound( "speech/hey.wav" );
ADDRGP4 $111
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 184
;184:	trap_precache_sound( "speech/cmyhole.wav" );
ADDRGP4 $112
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 186
;185:	// yells
;186:	trap_precache_sound( "speech/yell/coverme.wav" );
ADDRGP4 $113
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 187
;187:	trap_precache_sound( "speech/yell/overhere.wav" );
ADDRGP4 $114
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 188
;188:	trap_precache_sound( "speech/yell/thisway.wav" );
ADDRGP4 $115
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 189
;189:	trap_precache_sound( "speech/yell/followme.wav" );
ADDRGP4 $116
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 190
;190:	trap_precache_sound( "speech/yell/incomng.wav" );
ADDRGP4 $117
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 191
;191:	trap_precache_sound( "speech/yell/firehole.wav" );
ADDRGP4 $118
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 192
;192:	trap_precache_sound( "speech/yell/gogogo.wav" );
ADDRGP4 $119
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 193
;193:	trap_precache_sound( "speech/yell/lookout.wav" );
ADDRGP4 $120
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 194
;194:	trap_precache_sound( "speech/yell/holdup.wav" );
ADDRGP4 $121
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 197
;195:
;196:	// ammo cases
;197:	trap_precache_model( "progs/20mmcase.mdl" );
ADDRGP4 $122
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 198
;198:	trap_precache_model( "progs/shell2.mdl" );
ADDRGP4 $123
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 199
;199:	trap_precache_sound( "weapons/tink2.wav" );
ADDRGP4 $124
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 201
;200:	// sentrygun
;201:	trap_precache_sound( "items/repair.wav" );
ADDRGP4 $125
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 202
;202:	trap_precache_sound( "weapons/tnkatck4.wav" );
ADDRGP4 $126
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 203
;203:	trap_precache_sound( "weapons/plaser.wav" );
ADDRGP4 $127
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 204
;204:	trap_precache_sound( "weapons/gunidle1.wav" );
ADDRGP4 $128
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 206
;205:	// map ents
;206:	trap_precache_sound( "zombie/z_hit.wav" );		// sandball
ADDRGP4 $129
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 208
;207:	// update score sound
;208:	trap_precache_sound( "misc/update.wav" );
ADDRGP4 $130
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 210
;209:	// draw weapon sound(s)
;210:	trap_precache_sound( "weapons/knifedrw.wav" );
ADDRGP4 $131
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 212
;211:	// leave game
;212:	trap_precache_sound( "misc/eject.wav" );
ADDRGP4 $132
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 213
;213:}
LABELV $11
endproc W_Precache 0 4
export Attack_Finished
proc Attack_Finished 0 0
line 223
;214:
;215://#include "megatf\drop1.c"
;216://#include "megatf\drop3.c"
;217://#include "megatf\common.c"
;218://#include "megatf\drop2.c"
;219:
;220://======================================================================
;221:// Calculate the attack_finished time
;222:void Attack_Finished( float att_delay )
;223:{
line 224
;224:	if ( self->tfstate & TFSTATE_TRANQUILISED )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $134
line 225
;225:		self->attack_finished = g_globalvars.time + att_delay * 2;
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDRFP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $135
JUMPV
LABELV $134
line 227
;226:	else
;227:		self->attack_finished = g_globalvars.time + att_delay;
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRF4
ADDF4
ASGNF4
LABELV $135
line 228
;228:}
LABELV $133
endproc Attack_Finished 0 0
export W_FireAxe
proc W_FireAxe 60 32
line 237
;229:
;230:/*
;231:================
;232:W_FireAxe
;233:================
;234:*/
;235:
;236:void W_FireAxe(  )
;237:{
line 241
;238:	vec3_t  source, dest;
;239:	vec3_t  org, def;
;240:
;241:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 243
;242:
;243:	VectorCopy( self->s.v.origin, source );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 244
;244:	source[2] += 16;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 245
;245:	VectorScale( g_globalvars.v_forward, 64, dest );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1115684864
ARGF4
ADDRLP4 24
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 246
;246:	VectorAdd( dest, source, dest )
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
line 248
;247:        //source = self->s.v.origin + '0 0 16';
;248:        traceline( PASSVEC3( source ), PASSVEC3( dest ), false, self );
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 24+8
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
line 249
;249:	if ( g_globalvars.trace_fraction == 1.0 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $153
line 250
;250:		return;
ADDRGP4 $138
JUMPV
LABELV $153
line 252
;251:
;252:	VectorScale( g_globalvars.v_forward, 4, org );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1082130432
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 253
;253:	VectorSubtract( g_globalvars.trace_endpos, org, org );
ADDRLP4 0
ADDRGP4 g_globalvars+276
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 255
;254:// org = trace_endpos - g_globalvars.v_forward*4;
;255:	if ( PROG_TO_EDICT( g_globalvars.trace_ent )->s.v.takedamage )
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts+112+228
ADDP4
INDIRF4
CNSTF4 0
EQF4 $166
line 256
;256:	{
line 257
;257:		PROG_TO_EDICT( g_globalvars.trace_ent )->axhitme = 1;
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts+780
ADDP4
CNSTF4 1065353216
ASGNF4
line 258
;258:		SpawnBlood( org, 20 );
ADDRLP4 0
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 259
;259:		if ( self->playerclass != PC_SPY
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $179
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts+112+104
ADDP4
INDIRP4
ARGP4
ADDRGP4 $178
ARGP4
ADDRLP4 48
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $173
LABELV $179
line 261
;260:		     || strneq( PROG_TO_EDICT( g_globalvars.trace_ent )->s.v.classname, "player" ) )
;261:		{
line 262
;262:			tf_data.deathmsg = DMSG_AXE;
ADDRGP4 tf_data+88
CNSTI4 17
ASGNI4
line 263
;263:			TF_T_Damage( PROG_TO_EDICT( g_globalvars.trace_ent ), self, self, 20, 2, 0 );
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRLP4 52
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
CNSTF4 1101004800
ARGF4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 264
;264:		} else
ADDRGP4 $167
JUMPV
LABELV $173
line 265
;265:		{
line 266
;266:			self->weaponmode = 1;
ADDRGP4 self
INDIRP4
CNSTI4 940
ADDP4
CNSTI4 1
ASGNI4
line 267
;267:			self->s.v.weaponmodel = "progs/v_knife2.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $182
ASGNP4
line 268
;268:			makevectors( PROG_TO_EDICT( g_globalvars.trace_ent )->s.v.v_angle );
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts+112+272
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 269
;269:			VectorCopy( g_globalvars.v_right, def );
ADDRLP4 36
ADDRGP4 g_globalvars+252
INDIRF4
ASGNF4
ADDRLP4 36+4
ADDRGP4 g_globalvars+252+4
INDIRF4
ASGNF4
ADDRLP4 36+8
ADDRGP4 g_globalvars+252+8
INDIRF4
ASGNF4
line 271
;270:
;271:			makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 272
;272:			if ( crossproduct( def, g_globalvars.v_forward ) > 0 )
ADDRLP4 36
ARGP4
ADDRGP4 g_globalvars+228
ARGP4
ADDRLP4 52
ADDRGP4 crossproduct
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 0
LEF4 $193
line 273
;273:			{
line 274
;274:				tf_data.deathmsg = DMSG_BACKSTAB;
ADDRGP4 tf_data+88
CNSTI4 22
ASGNI4
line 275
;275:				TF_T_Damage( PROG_TO_EDICT( g_globalvars.trace_ent ), self, self, 120, 2, 0 );
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTF4 1123024896
ARGF4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 276
;276:			} else
ADDRGP4 $167
JUMPV
LABELV $193
line 277
;277:			{
line 278
;278:				tf_data.deathmsg = DMSG_AXE;
ADDRGP4 tf_data+88
CNSTI4 17
ASGNI4
line 279
;279:				TF_T_Damage( PROG_TO_EDICT( g_globalvars.trace_ent ), self, self, 40, 2, 0 );
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTF4 1109393408
ARGF4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 280
;280:			}
line 281
;281:		}
line 282
;282:	} else
ADDRGP4 $167
JUMPV
LABELV $166
line 283
;283:	{
line 284
;284:		sound( self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $200
ARGP4
ADDRLP4 48
CNSTF4 1065353216
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 286
;285:
;286:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 287
;287:		trap_WriteByte( MSG_MULTICAST, TE_GUNSHOT );
CNSTI4 4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 288
;288:		trap_WriteByte( MSG_MULTICAST, 3 );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 289
;289:		trap_WriteCoord( MSG_MULTICAST, org[0] );
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 290
;290:		trap_WriteCoord( MSG_MULTICAST, org[1] );
CNSTI4 4
ARGI4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 291
;291:		trap_WriteCoord( MSG_MULTICAST, org[2] );
CNSTI4 4
ARGI4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 292
;292:		trap_multicast( PASSVEC3( org ), MULTICAST_PVS );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 293
;293:	}
LABELV $167
line 294
;294:}
LABELV $138
endproc W_FireAxe 60 32
export W_FireSpanner
proc W_FireSpanner 108 32
line 297
;295:
;296:void W_FireSpanner(  )
;297:{
line 304
;298:	vec3_t  source;
;299:	vec3_t  org;
;300:	vec3_t  dest;
;301:	float   healam;
;302:	gedict_t *te, *trace_ent;
;303:
;304:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 305
;305:	VectorCopy( self->s.v.origin, source );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 306
;306:	source[2] += 16;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 307
;307:	VectorScale( g_globalvars.v_forward, 64, dest );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1115684864
ARGF4
ADDRLP4 24
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 308
;308:	VectorAdd( dest, source, dest ) traceline( PASSVEC3( source ), PASSVEC3( dest ), false, self );
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 24+8
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
line 309
;309:	if ( g_globalvars.trace_fraction == 1.0 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $220
line 310
;310:		return;
ADDRGP4 $205
JUMPV
LABELV $220
line 312
;311:
;312:	VectorScale( g_globalvars.v_forward, 4, org );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1082130432
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 313
;313:	VectorSubtract( g_globalvars.trace_endpos, org, org );
ADDRLP4 0
ADDRGP4 g_globalvars+276
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 314
;314:	trace_ent = PROG_TO_EDICT( g_globalvars.trace_ent );
ADDRLP4 36
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 316
;315:
;316:	if ( trace_ent->goal_activation & TFGA_SPANNER )
ADDRLP4 36
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $234
line 317
;317:	{
line 318
;318:		if ( Activated( trace_ent, self ) )
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Activated
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $236
line 319
;319:		{
line 320
;320:			DoResults( trace_ent, self, 1 );
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 DoResults
CALLV
pop
line 321
;321:			if ( streq( trace_ent->s.v.classname, "func_button" ) )
ADDRLP4 36
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $240
ARGP4
ADDRLP4 52
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $205
line 322
;322:			{
line 323
;323:				trace_ent->s.v.enemy = EDICT_TO_PROG( self );
ADDRLP4 36
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
line 324
;324:				other = self;
ADDRGP4 other
ADDRGP4 self
INDIRP4
ASGNP4
line 325
;325:				self = trace_ent;
ADDRGP4 self
ADDRLP4 36
INDIRP4
ASGNP4
line 326
;326:				self->dont_do_triggerwork = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1392
ADDP4
CNSTI4 1
ASGNI4
line 327
;327:				button_fire(  );
ADDRGP4 button_fire
CALLV
pop
line 328
;328:				self = other;
ADDRGP4 self
ADDRGP4 other
INDIRP4
ASGNP4
line 329
;329:			}
line 330
;330:		} else
ADDRGP4 $205
JUMPV
LABELV $236
line 331
;331:		{
line 332
;332:			if ( trace_ent->else_goal )
ADDRLP4 36
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $241
line 333
;333:			{
line 334
;334:				te = Findgoal( trace_ent->else_goal );
ADDRLP4 36
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 52
INDIRP4
ASGNP4
line 335
;335:				if ( te )
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $205
line 336
;336:					AttemptToActivate( te, self, trace_ent );
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 AttemptToActivate
CALLV
pop
line 337
;337:			} else
ADDRGP4 $205
JUMPV
LABELV $241
line 338
;338:			{
line 339
;339:				sound( self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $200
ARGP4
ADDRLP4 52
CNSTF4 1065353216
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 341
;340:
;341:				trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 342
;342:				trap_WriteByte( MSG_MULTICAST, TE_GUNSHOT );
CNSTI4 4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 343
;343:				trap_WriteByte( MSG_MULTICAST, 3 );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 344
;344:				trap_WriteCoord( MSG_MULTICAST, org[0] );
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 345
;345:				trap_WriteCoord( MSG_MULTICAST, org[1] );
CNSTI4 4
ARGI4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 346
;346:				trap_WriteCoord( MSG_MULTICAST, org[2] );
CNSTI4 4
ARGI4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 347
;347:				trap_multicast( PASSVEC3( org ), MULTICAST_PVS );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 348
;348:			}
line 349
;349:		}
line 350
;350:		return;
ADDRGP4 $205
JUMPV
LABELV $234
line 352
;351:	}
;352:	if ( trace_ent->s.v.takedamage )
ADDRLP4 36
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $249
line 353
;353:	{
line 354
;354:		if ( streq( trace_ent->s.v.classname, "building_dispenser" ) )
ADDRLP4 36
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $253
ARGP4
ADDRLP4 48
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $251
line 355
;355:		{
line 356
;356:			Engineer_UseDispenser( trace_ent );
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 Engineer_UseDispenser
CALLV
pop
line 357
;357:			return;
ADDRGP4 $205
JUMPV
LABELV $251
line 359
;358:		} else
;359:		{
line 360
;360:			if ( streq( trace_ent->s.v.classname, "building_sentrygun" ) )
ADDRLP4 36
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $256
ARGP4
ADDRLP4 52
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $254
line 361
;361:			{
line 362
;362:				Engineer_UseSentryGun( trace_ent );
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 Engineer_UseSentryGun
CALLV
pop
line 363
;363:				return;
ADDRGP4 $205
JUMPV
LABELV $254
line 365
;364:			} else
;365:			{
line 366
;366:				if ( streq( trace_ent->s.v.classname, "building_sentrygun_base" ) )
ADDRLP4 36
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $259
ARGP4
ADDRLP4 56
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $257
line 367
;367:				{
line 368
;368:					if ( trace_ent->oldenemy )
ADDRLP4 36
INDIRP4
CNSTI4 980
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $205
line 369
;369:						Engineer_UseSentryGun( trace_ent->oldenemy );
ADDRLP4 36
INDIRP4
CNSTI4 980
ADDP4
INDIRP4
ARGP4
ADDRGP4 Engineer_UseSentryGun
CALLV
pop
line 370
;370:					return;
ADDRGP4 $205
JUMPV
LABELV $257
line 372
;371:				} else
;372:				{
line 373
;373:					if ( streq( trace_ent->s.v.classname, "player" ) )
ADDRLP4 36
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $178
ARGP4
ADDRLP4 60
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $262
line 374
;374:					{
line 375
;375:						if ( ( TeamFortress_isTeamsAllied(trace_ent->team_no ,self->team_no)
ADDRLP4 64
CNSTI4 960
ASGNI4
ADDRLP4 36
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRLP4 68
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $268
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $268
ADDRGP4 teamplay
INDIRI4
ADDRLP4 72
INDIRI4
NEI4 $266
LABELV $268
ADDRGP4 coop
INDIRI4
CNSTI4 0
EQI4 $264
LABELV $266
line 377
;376:						       && self->team_no && teamplay ) || coop )
;377:						{
line 378
;378:							healam = WEAP_SPANNER_REPAIR;
ADDRLP4 44
CNSTF4 1092616192
ASGNF4
line 379
;379:							if ( self->s.v.ammo_cells < healam )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDRLP4 44
INDIRF4
GEF4 $269
line 380
;380:								healam = self->s.v.ammo_cells;
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ASGNF4
LABELV $269
line 381
;381:							if ( !trace_ent->s.v.armortype )
ADDRLP4 36
INDIRP4
CNSTI4 424
ADDP4
INDIRF4
CNSTF4 0
NEF4 $271
line 382
;382:								return;
ADDRGP4 $205
JUMPV
LABELV $271
line 383
;383:							if ( trace_ent->maxarmor -
ADDRLP4 36
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
SUBF4
CNSTF4 1082130432
ADDRLP4 44
INDIRF4
MULF4
GEF4 $273
line 385
;384:							     trace_ent->s.v.armorvalue < healam * 4 )
;385:								healam =
ADDRLP4 36
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
SUBF4
CNSTF4 1082130432
DIVF4
ARGF4
ADDRLP4 84
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 84
INDIRF4
ASGNF4
LABELV $273
line 387
;386:								    ceil( ( trace_ent->maxarmor - trace_ent->s.v.armorvalue ) / 4 );
;387:							if ( healam > 0 )
ADDRLP4 44
INDIRF4
CNSTF4 0
LEF4 $205
line 388
;388:							{
line 389
;389:								trace_ent->s.v.armorvalue = trace_ent->s.v.armorvalue + healam * 4;
ADDRLP4 88
ADDRLP4 36
INDIRP4
CNSTI4 428
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRLP4 44
INDIRF4
MULF4
ADDF4
ASGNF4
line 390
;390:								if ( trace_ent->s.v.armorvalue > trace_ent->maxarmor )
ADDRLP4 36
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
LEF4 $277
line 391
;391:									trace_ent->s.v.armorvalue = trace_ent->maxarmor;
ADDRLP4 36
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
ASGNF4
LABELV $277
line 392
;392:								if ( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $279
line 393
;393:									self->s.v.ammo_cells = self->s.v.ammo_cells - healam;
ADDRLP4 100
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
ASGNF4
LABELV $279
line 394
;394:								sound( trace_ent,
ADDRLP4 36
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $25
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
line 396
;395:								       CHAN_WEAPON, "items/r_item1.wav", 1, ATTN_NORM );
;396:								trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 397
;397:								trap_WriteByte( MSG_MULTICAST, TE_GUNSHOT );
CNSTI4 4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 398
;398:								trap_WriteByte( MSG_MULTICAST, 3 );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 399
;399:								trap_WriteCoord( MSG_MULTICAST, org[0] );
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 400
;400:								trap_WriteCoord( MSG_MULTICAST, org[1] );
CNSTI4 4
ARGI4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 401
;401:								trap_WriteCoord( MSG_MULTICAST, org[2] );
CNSTI4 4
ARGI4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 402
;402:								trap_multicast( PASSVEC3( org ), MULTICAST_PVS );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 403
;403:								W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 404
;404:							}
line 405
;405:							return;
ADDRGP4 $205
JUMPV
LABELV $264
line 407
;406:						}
;407:					}
LABELV $262
line 408
;408:					trace_ent->axhitme = 1;
ADDRLP4 36
INDIRP4
CNSTI4 780
ADDP4
CNSTF4 1065353216
ASGNF4
line 409
;409:					SpawnBlood( org, 20 );
ADDRLP4 0
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 410
;410:					tf_data.deathmsg = DMSG_SPANNER;
ADDRGP4 tf_data+88
CNSTI4 32
ASGNI4
line 411
;411:					TF_T_Damage( trace_ent, self, self, 20, 2, 0 );
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
CNSTF4 1101004800
ARGF4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 412
;412:				}
line 413
;413:			}
line 414
;414:		}
line 415
;415:	} else
ADDRGP4 $250
JUMPV
LABELV $249
line 416
;416:	{
line 417
;417:		sound( self, 1, "player/axhit2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $200
ARGP4
ADDRLP4 48
CNSTF4 1065353216
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 418
;418:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 419
;419:		trap_WriteByte( MSG_MULTICAST, TE_GUNSHOT );
CNSTI4 4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 420
;420:		trap_WriteByte( MSG_MULTICAST, 3 );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 421
;421:		trap_WriteCoord( MSG_MULTICAST, org[0] );
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 422
;422:		trap_WriteCoord( MSG_MULTICAST, org[1] );
CNSTI4 4
ARGI4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 423
;423:		trap_WriteCoord( MSG_MULTICAST, org[2] );
CNSTI4 4
ARGI4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 424
;424:		trap_multicast( PASSVEC3( org ), MULTICAST_PVS );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 425
;425:	}
LABELV $250
line 426
;426:}
LABELV $205
endproc W_FireSpanner 108 32
export W_FireMedikit
proc W_FireMedikit 108 32
line 429
;427:
;428:void W_FireMedikit(  )
;429:{
line 436
;430:	vec3_t  source, dest;
;431:	vec3_t  org;
;432:	float   healam;
;433:	gedict_t *te;
;434:	gedict_t *BioInfection, *trace_ent;
;435:
;436:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 438
;437:
;438:	VectorCopy( self->s.v.origin, source );
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 439
;439:	source[2] += 16;
ADDRLP4 20+8
ADDRLP4 20+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 440
;440:	VectorScale( g_globalvars.v_forward, 64, dest );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1115684864
ARGF4
ADDRLP4 32
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 441
;441:	VectorAdd( dest, source, dest )
ADDRLP4 32
ADDRLP4 32
INDIRF4
ADDRLP4 20
INDIRF4
ADDF4
ASGNF4
ADDRLP4 32+4
ADDRLP4 32+4
INDIRF4
ADDRLP4 20+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 32+8
ADDRLP4 32+8
INDIRF4
ADDRLP4 20+8
INDIRF4
ADDF4
ASGNF4
line 443
;442:	    //source = self->s.v.origin + '0 0 16';
;443:	    traceline( PASSVEC3( source ), PASSVEC3( dest ), false, self );
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20+4
INDIRF4
ARGF4
ADDRLP4 20+8
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32+4
INDIRF4
ARGF4
ADDRLP4 32+8
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
line 444
;444:	if ( g_globalvars.trace_fraction == 1.0 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $306
line 445
;445:		return;
ADDRGP4 $291
JUMPV
LABELV $306
line 447
;446:
;447:	VectorScale( g_globalvars.v_forward, 4, org );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1082130432
ARGF4
ADDRLP4 8
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 448
;448:	VectorSubtract( g_globalvars.trace_endpos, org, org );
ADDRLP4 8
ADDRGP4 g_globalvars+276
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ADDRLP4 8+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ADDRLP4 8+8
INDIRF4
SUBF4
ASGNF4
line 449
;449:	trace_ent = PROG_TO_EDICT( g_globalvars.trace_ent );
ADDRLP4 4
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 450
;450:	if ( trace_ent->s.v.takedamage )
ADDRLP4 4
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $320
line 451
;451:	{
line 452
;452:		if ( streq( trace_ent->s.v.classname, "building_dispenser" ) )
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $253
ARGP4
ADDRLP4 52
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $322
line 453
;453:		{
line 454
;454:			trace_ent->s.v.skin = 1;	// adds heal power to the dispenser
ADDRLP4 4
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1065353216
ASGNF4
line 455
;455:			return;
ADDRGP4 $291
JUMPV
LABELV $322
line 457
;456:		}
;457:		if ( streq( trace_ent->s.v.classname, "player" ) )
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $178
ARGP4
ADDRLP4 56
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $321
line 458
;458:		{
line 459
;459:			if ( ( TeamFortress_isTeamsAllied(trace_ent->team_no , self->team_no) && self->team_no ) || coop )
ADDRLP4 60
CNSTI4 960
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $329
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
NEI4 $328
LABELV $329
ADDRGP4 coop
INDIRI4
CNSTI4 0
EQI4 $326
LABELV $328
line 460
;460:			{
line 461
;461:				healam = WEAP_MEDIKIT_HEAL;
ADDRLP4 48
CNSTF4 1128792064
ASGNF4
line 462
;462:				for ( te=world ; (te = trap_find( te, FOFS( s.v.classname ), "timer" ));)
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $333
JUMPV
LABELV $330
line 463
;463:				{
line 464
;464:					if ( te->s.v.owner != g_globalvars.trace_ent )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_globalvars+304
INDIRI4
EQI4 $335
line 465
;465:						continue;
ADDRGP4 $331
JUMPV
LABELV $335
line 466
;466:					if ( te->s.v.think != ( func_t ) ConcussionGrenadeTimer &&
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
ADDRGP4 ConcussionGrenadeTimer
CVPU4 4
CVUI4 4
EQI4 $338
ADDRLP4 72
INDIRI4
ADDRGP4 OldConcussionGrenadeTimer
CVPU4 4
CVUI4 4
EQI4 $338
line 468
;467:						te->s.v.think != ( func_t ) OldConcussionGrenadeTimer )
;468:						continue;
ADDRGP4 $331
JUMPV
LABELV $338
line 469
;469:					if ( tf_data.old_grens == 1 )
ADDRGP4 tf_data+44
INDIRI4
CNSTI4 1
NEI4 $340
line 471
;470://						stuffcmd( trace_ent, "v_idlescale 0\nfov 90\n" );
;471:						stuffcmd( trace_ent, "v_idlescale 0\n" );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $343
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $340
line 472
;472:					SpawnBlood( org, 20 );
ADDRLP4 8
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 473
;473:					G_bprint( 1, "%s cured %s's concussion\n", self->s.v.netname, trace_ent->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $344
ARGP4
ADDRLP4 76
CNSTI4 396
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 474
;474:					if ( !TeamFortress_isTeamsAllied(te->team_no , self->team_no) )
ADDRLP4 80
CNSTI4 960
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $345
line 475
;475:						TF_AddFrags( self, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
LABELV $345
line 476
;476:					dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 477
;477:					break;
ADDRGP4 $332
JUMPV
LABELV $331
line 462
LABELV $333
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $334
ARGP4
ADDRLP4 72
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $330
LABELV $332
line 479
;478:				}
;479:				if ( trace_ent->tfstate & TFSTATE_HALLUCINATING )
ADDRLP4 4
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $347
line 480
;480:				{
line 481
;481:				    for ( te=world ; (te = trap_find( te, FOFS( s.v.classname ), "timer" ));)
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $352
JUMPV
LABELV $349
line 482
;482:					{
line 483
;483:						if ( te->s.v.owner != g_globalvars.trace_ent )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_globalvars+304
INDIRI4
EQI4 $353
line 484
;484:							continue;
ADDRGP4 $350
JUMPV
LABELV $353
line 485
;485:						if ( te->s.v.think != ( func_t ) HallucinationTimer )
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 HallucinationTimer
CVPU4 4
CVUI4 4
EQI4 $356
line 486
;486:							continue;
ADDRGP4 $350
JUMPV
LABELV $356
line 488
;487:
;488:						trace_ent->tfstate -= ( trace_ent->tfstate & TFSTATE_HALLUCINATING );
ADDRLP4 76
ADDRLP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 80
ADDRLP4 76
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRP4
ADDRLP4 80
INDIRI4
ADDRLP4 80
INDIRI4
CNSTI4 16384
BANDI4
SUBI4
ASGNI4
line 489
;489:						SpawnBlood( org, 20 );
ADDRLP4 8
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 490
;490:						G_bprint( 1, "%s healed %s of his hallucinations\n",
CNSTI4 1
ARGI4
ADDRGP4 $358
ARGP4
ADDRLP4 84
CNSTI4 396
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 493
;491:							  self->s.v.netname, trace_ent->s.v.netname );
;492:						
;493:						ResetGasSkins(trace_ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 ResetGasSkins
CALLV
pop
line 494
;494:						if ( tf_data.new_gas & GAS_MASK_PALETTE) 
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $359
line 495
;495:							stuffcmd( trace_ent, "v_cshift; wait; bf\n" );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $362
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $359
line 496
;496:						if ( !TeamFortress_isTeamsAllied(te->team_no , self->team_no) )
ADDRLP4 88
CNSTI4 960
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $363
line 497
;497:							TF_AddFrags( self, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
LABELV $363
line 498
;498:						dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 499
;499:						break;
ADDRGP4 $351
JUMPV
LABELV $350
line 481
LABELV $352
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $334
ARGP4
ADDRLP4 76
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 76
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $349
LABELV $351
line 501
;500:					}
;501:					if ( !te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $365
line 502
;502:						G_conprintf( "Warning: Error in Hallucination Timer logic.\n" );
ADDRGP4 $367
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
LABELV $365
line 503
;503:				}
LABELV $347
line 504
;504:				if ( trace_ent->tfstate & TFSTATE_TRANQUILISED )
ADDRLP4 4
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $368
line 505
;505:				{
line 506
;506:				    for ( te=world ; (te = trap_find( te, FOFS( s.v.classname ), "timer" ));)
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $373
JUMPV
LABELV $370
line 507
;507:					{
line 508
;508:						if ( te->s.v.owner != g_globalvars.trace_ent )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_globalvars+304
INDIRI4
EQI4 $374
line 509
;509:							continue;
ADDRGP4 $371
JUMPV
LABELV $374
line 510
;510:						if ( te->s.v.think != ( func_t ) TranquiliserTimer )
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 TranquiliserTimer
CVPU4 4
CVUI4 4
EQI4 $377
line 511
;511:							continue;
ADDRGP4 $371
JUMPV
LABELV $377
line 513
;512:
;513:						trace_ent->tfstate -= ( trace_ent->tfstate & TFSTATE_TRANQUILISED );
ADDRLP4 76
ADDRLP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 80
ADDRLP4 76
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRP4
ADDRLP4 80
INDIRI4
ADDRLP4 80
INDIRI4
CNSTI4 32768
BANDI4
SUBI4
ASGNI4
line 514
;514:						TeamFortress_SetSpeed( trace_ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 515
;515:						SpawnBlood( org, 20 );
ADDRLP4 8
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 516
;516:						G_bprint( 1, "%s healed %s's tranquilisation\n",
CNSTI4 1
ARGI4
ADDRGP4 $379
ARGP4
ADDRLP4 84
CNSTI4 396
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 518
;517:							  self->s.v.netname, trace_ent->s.v.netname );
;518:						if ( !TeamFortress_isTeamsAllied(te->team_no , self->team_no) )
ADDRLP4 88
CNSTI4 960
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $380
line 519
;519:							TF_AddFrags( self, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
LABELV $380
line 520
;520:						dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 521
;521:						break;
ADDRGP4 $372
JUMPV
LABELV $371
line 506
LABELV $373
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $334
ARGP4
ADDRLP4 76
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 76
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $370
LABELV $372
line 523
;522:					}
;523:					if ( !te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $382
line 524
;524:						G_conprintf( "Warning: Error in Tranquilisation Timer logic.\n" );
ADDRGP4 $384
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
LABELV $382
line 525
;525:				}
LABELV $368
line 526
;526:				if ( trace_ent->FlashTime > 0 )
ADDRLP4 4
INDIRP4
CNSTI4 1472
ADDP4
INDIRF4
CNSTF4 0
LEF4 $385
line 527
;527:				{
line 528
;528:				    for ( te=world ; (te = trap_find( te, FOFS( s.v.netname ), "flashtimer" ));)
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $390
JUMPV
LABELV $387
line 529
;529:					{
line 530
;530:						if ( te->s.v.owner != g_globalvars.trace_ent )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_globalvars+304
INDIRI4
EQI4 $392
line 531
;531:							continue;
ADDRGP4 $388
JUMPV
LABELV $392
line 532
;532:						if ( strneq( te->s.v.classname, "timer" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $334
ARGP4
ADDRLP4 76
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $395
line 533
;533:							continue;
ADDRGP4 $388
JUMPV
LABELV $395
line 535
;534:
;535:						trace_ent->FlashTime = 0;
ADDRLP4 4
INDIRP4
CNSTI4 1472
ADDP4
CNSTF4 0
ASGNF4
line 536
;536:						SpawnBlood( org, 20 );
ADDRLP4 8
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 537
;537:						G_bprint( 1, "%s cured %s's blindness\n",
CNSTI4 1
ARGI4
ADDRGP4 $397
ARGP4
ADDRLP4 80
CNSTI4 396
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 539
;538:							  self->s.v.netname, trace_ent->s.v.netname );
;539:						if ( !TeamFortress_isTeamsAllied(te->team_no , self->team_no) )
ADDRLP4 84
CNSTI4 960
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $398
line 540
;540:							TF_AddFrags( self, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
LABELV $398
line 541
;541:						if ( tf_data.new_flash )
ADDRGP4 tf_data+48
INDIRI4
CNSTI4 0
EQI4 $389
line 542
;542:							disableupdates( trace_ent, -1 );	/* server-side flash */
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 3212836864
ARGF4
ADDRGP4 disableupdates
CALLV
pop
line 543
;543:						break;
ADDRGP4 $389
JUMPV
LABELV $388
line 528
LABELV $390
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 396
ARGI4
ADDRGP4 $391
ARGP4
ADDRLP4 76
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 76
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $387
LABELV $389
line 545
;544:					}
;545:					if ( !te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $403
line 546
;546:					{
line 547
;547:						G_conprintf( "Warning: Error in Flash Timer logic.\n" );
ADDRGP4 $405
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 548
;548:						trace_ent->FlashTime = 0;
ADDRLP4 4
INDIRP4
CNSTI4 1472
ADDP4
CNSTF4 0
ASGNF4
line 549
;549:					}
LABELV $403
line 550
;550:				}
LABELV $385
line 551
;551:				if ( trace_ent->tfstate & TFSTATE_INFECTED )
ADDRLP4 4
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $406
line 552
;552:				{
line 553
;553:					healam = rint( trace_ent->s.v.health / 2 );
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1073741824
DIVF4
ARGF4
ADDRLP4 76
ADDRGP4 rint
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 76
INDIRI4
CVIF4 4
ASGNF4
line 554
;554:					trace_ent->tfstate -= ( trace_ent->tfstate & TFSTATE_INFECTED );
ADDRLP4 80
ADDRLP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 80
INDIRP4
ADDRLP4 84
INDIRI4
ADDRLP4 84
INDIRI4
CNSTI4 16
BANDI4
SUBI4
ASGNI4
line 555
;555:					tf_data.deathmsg = DMSG_MEDIKIT;
ADDRGP4 tf_data+88
CNSTI4 23
ASGNI4
line 556
;556:					T_Damage( trace_ent, self, self, healam );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 48
INDIRF4
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 557
;557:					SpawnBlood( org, 30 );
ADDRLP4 8
ARGP4
CNSTF4 1106247680
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 558
;558:					if ( streq( self->s.v.classname, "player" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $178
ARGP4
ADDRLP4 92
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $291
line 559
;559:					{
line 560
;560:						G_bprint( 1, "%s cured %s's infection\n",
CNSTI4 1
ARGI4
ADDRGP4 $411
ARGP4
ADDRLP4 96
CNSTI4 396
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 562
;561:							  self->s.v.netname, trace_ent->s.v.netname );
;562:						if ( !TeamFortress_isTeamsAllied(trace_ent->infection_team_no , self->team_no) )
ADDRLP4 4
INDIRP4
CNSTI4 968
ADDP4
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $291
line 563
;563:							TF_AddFrags( self, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 564
;564:					}
line 565
;565:					return;
ADDRGP4 $291
JUMPV
LABELV $406
line 567
;566:				}
;567:				if ( trace_ent->numflames > 0 )
ADDRLP4 4
INDIRP4
CNSTI4 1396
ADDP4
INDIRI4
CNSTI4 0
LEI4 $414
line 568
;568:				{
line 569
;569:					sound( trace_ent, 1, "items/r_item1.wav", 1, 1 );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $25
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
line 570
;570:					trace_ent->numflames = 0;
ADDRLP4 4
INDIRP4
CNSTI4 1396
ADDP4
CNSTI4 0
ASGNI4
line 571
;571:					if ( streq( self->s.v.classname, "player" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $178
ARGP4
ADDRLP4 80
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $291
line 572
;572:					{
line 573
;573:						G_bprint( 1, "%s put out %s's fire.\n",
CNSTI4 1
ARGI4
ADDRGP4 $418
ARGP4
ADDRLP4 84
CNSTI4 396
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 575
;574:							  self->s.v.netname, trace_ent->s.v.netname );
;575:					}
line 576
;576:					return;
ADDRGP4 $291
JUMPV
LABELV $414
line 579
;577:				}
;578:				
;579:				if ( healam > 0 && trace_ent->s.v.health < trace_ent->s.v.max_health )
ADDRLP4 48
INDIRF4
CNSTF4 0
LEF4 $419
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
GEF4 $419
line 580
;580:				{
line 581
;581:					sound( trace_ent, 1, "items/r_item1.wav", 1, 1 );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $25
ARGP4
ADDRLP4 80
CNSTF4 1065353216
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 582
;582:					trace_ent->axhitme = 1;
ADDRLP4 4
INDIRP4
CNSTI4 780
ADDP4
CNSTF4 1065353216
ASGNF4
line 583
;583:					SpawnBlood( org, 20 );
ADDRLP4 8
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 584
;584:					T_Heal( trace_ent, healam, 0 );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 48
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 T_Heal
CALLI4
pop
line 585
;585:				} else
ADDRGP4 $321
JUMPV
LABELV $419
line 586
;586:				{
line 587
;587:					if ( trace_ent->s.v.health >=
ADDRLP4 84
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ASGNF4
ADDRLP4 88
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
ASGNF4
ADDRLP4 84
INDIRF4
ADDRLP4 88
INDIRF4
LTF4 $321
ADDRLP4 84
INDIRF4
ADDRLP4 88
INDIRF4
CNSTF4 1112014848
ADDF4
GEF4 $321
line 591
;588:					     trace_ent->s.v.max_health
;589:					     && trace_ent->s.v.health <
;590:					     trace_ent->s.v.max_health + WEAP_MEDIKIT_OVERHEAL )
;591:					{
line 592
;592:						healam = 5;
ADDRLP4 48
CNSTF4 1084227584
ASGNF4
line 593
;593:						if ( healam > self->ammo_medikit * 5 )
ADDRLP4 48
INDIRF4
CNSTI4 5
ADDRGP4 self
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
MULI4
CVIF4 4
LEF4 $423
line 594
;594:							healam = self->ammo_medikit * 5;
ADDRLP4 48
CNSTI4 5
ADDRGP4 self
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
MULI4
CVIF4 4
ASGNF4
LABELV $423
line 595
;595:						if ( healam > 0 )
ADDRLP4 48
INDIRF4
CNSTF4 0
LEF4 $321
line 596
;596:						{
line 597
;597:							sound( trace_ent, 3, "items/r_item2.wav", 1, 1 );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $26
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
line 598
;598:							T_Heal( trace_ent, healam, 1 );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 48
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 T_Heal
CALLI4
pop
line 599
;599:							self->ammo_medikit -= healam / 5;
ADDRLP4 96
ADDRGP4 self
INDIRP4
CNSTI4 1044
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CVIF4 4
ADDRLP4 48
INDIRF4
CNSTF4 1084227584
DIVF4
SUBF4
CVFI4 4
ASGNI4
line 600
;600:							if ( !( ( int ) trace_ent->s.v.items & IT_SUPERHEALTH ) )
ADDRLP4 4
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
CNSTI4 65536
BANDI4
CNSTI4 0
NEI4 $427
line 601
;601:							{
line 602
;602:								trace_ent->s.v.items =
ADDRLP4 100
ADDRLP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 65536
BORI4
CVIF4 4
ASGNF4
line 604
;603:								    ( int ) trace_ent->s.v.items | IT_SUPERHEALTH;
;604:								newmis = spawn(  );
ADDRLP4 104
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 104
INDIRP4
ASGNP4
line 605
;605:								newmis->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 606
;606:								newmis->s.v.think = ( func_t ) item_megahealth_rot;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 item_megahealth_rot
CVPU4 4
CVUI4 4
ASGNI4
line 607
;607:								newmis->s.v.owner = EDICT_TO_PROG( trace_ent );
ADDRGP4 newmis
INDIRP4
CNSTI4 480
ADDP4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 608
;608:							}
LABELV $427
line 609
;609:							self->s.v.currentammo = self->ammo_medikit;
ADDRLP4 100
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 100
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 610
;610:						}
line 611
;611:					}
line 612
;612:				}
line 613
;613:			} else
ADDRGP4 $321
JUMPV
LABELV $326
line 614
;614:			{
line 616
;615://not teammate
;616:				trace_ent->axhitme = 1;
ADDRLP4 4
INDIRP4
CNSTI4 780
ADDP4
CNSTF4 1065353216
ASGNF4
line 617
;617:				SpawnBlood( org, 20 );
ADDRLP4 8
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 618
;618:				tf_data.deathmsg = DMSG_BIOWEAPON_ATT;
ADDRGP4 tf_data+88
CNSTI4 14
ASGNI4
line 619
;619:				T_Damage( trace_ent, self, self, 10 );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
CNSTF4 1092616192
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 620
;620:				if ( trace_ent->playerclass == PC_MEDIC )
ADDRLP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 5
NEI4 $431
line 621
;621:					return;
ADDRGP4 $291
JUMPV
LABELV $431
line 622
;622:				if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $433
line 623
;623:					return;
ADDRGP4 $291
JUMPV
LABELV $433
line 624
;624:				if ( trace_ent->tfstate & TFSTATE_INFECTED )
ADDRLP4 4
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $437
line 625
;625:					return;
ADDRGP4 $291
JUMPV
LABELV $437
line 626
;626:				trace_ent->tfstate |= TFSTATE_INFECTED;
ADDRLP4 76
ADDRLP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 627
;627:				BioInfection = spawn(  );
ADDRLP4 80
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 80
INDIRP4
ASGNP4
line 628
;628:				BioInfection->s.v.classname = "timer";
ADDRLP4 44
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $334
ASGNP4
line 629
;629:				BioInfection->s.v.owner = EDICT_TO_PROG( trace_ent );
ADDRLP4 44
INDIRP4
CNSTI4 480
ADDP4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 630
;630:				BioInfection->s.v.nextthink = g_globalvars.time + 2;
ADDRLP4 44
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 631
;631:				BioInfection->s.v.think = ( func_t ) BioInfection_Decay;
ADDRLP4 44
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 BioInfection_Decay
CVPU4 4
CVUI4 4
ASGNI4
line 632
;632:				BioInfection->s.v.enemy = EDICT_TO_PROG( self );
ADDRLP4 44
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
line 633
;633:				trace_ent->infection_team_no = self->team_no;
ADDRLP4 4
INDIRP4
CNSTI4 968
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
line 634
;634:			}
line 635
;635:		}
line 636
;636:	} else
ADDRGP4 $321
JUMPV
LABELV $320
line 637
;637:	{
line 638
;638:		sound( self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $200
ARGP4
ADDRLP4 52
CNSTF4 1065353216
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 640
;639:
;640:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 641
;641:		trap_WriteByte( MSG_MULTICAST, TE_GUNSHOT );
CNSTI4 4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 642
;642:		trap_WriteByte( MSG_MULTICAST, 3 );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 643
;643:		trap_WriteCoord( MSG_MULTICAST, org[0] );
CNSTI4 4
ARGI4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 644
;644:		trap_WriteCoord( MSG_MULTICAST, org[1] );
CNSTI4 4
ARGI4
ADDRLP4 8+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 645
;645:		trap_WriteCoord( MSG_MULTICAST, org[2] );
CNSTI4 4
ARGI4
ADDRLP4 8+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 646
;646:		trap_multicast( PASSVEC3( org ), MULTICAST_PVS );
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8+4
INDIRF4
ARGF4
ADDRLP4 8+8
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 647
;647:	}
LABELV $321
line 648
;648:}
LABELV $291
endproc W_FireMedikit 108 32
export W_FireBioweapon
proc W_FireBioweapon 72 32
line 651
;649:
;650:void W_FireBioweapon(  )
;651:{
line 657
;652:	vec3_t  source, dest;
;653:
;654:	vec3_t  org;
;655:	gedict_t *BioInfection, *trace_ent;
;656:
;657:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 659
;658:
;659:	VectorCopy( self->s.v.origin, source );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 660
;660:	source[2] += 16;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 661
;661:	VectorScale( g_globalvars.v_forward, 64, dest );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1115684864
ARGF4
ADDRLP4 24
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 662
;662:	VectorAdd( dest, source, dest )
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
line 664
;663:	    //source = self->s.v.origin + '0 0 16';
;664:	    traceline( PASSVEC3( source ), PASSVEC3( dest ), false, self );
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 24+8
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
line 665
;665:	if ( g_globalvars.trace_fraction == 1.0 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $459
line 666
;666:		return;
ADDRGP4 $444
JUMPV
LABELV $459
line 668
;667:
;668:	VectorScale( g_globalvars.v_forward, 4, org );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1082130432
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 669
;669:	VectorSubtract( g_globalvars.trace_endpos, org, org );
ADDRLP4 0
ADDRGP4 g_globalvars+276
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 670
;670:	trace_ent = PROG_TO_EDICT( g_globalvars.trace_ent );
ADDRLP4 36
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 672
;671:
;672:	if ( trace_ent->s.v.takedamage )
ADDRLP4 36
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $473
line 673
;673:	{
line 674
;674:		if ( streq( trace_ent->s.v.classname, "player" ) )
ADDRLP4 36
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $178
ARGP4
ADDRLP4 44
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $475
line 675
;675:		{
line 676
;676:			if ( ( !TeamFortress_isTeamsAllied(trace_ent->team_no , self->team_no) && self->team_no && teamplay ) || !teamplay )
ADDRLP4 48
CNSTI4 960
ASGNI4
ADDRLP4 36
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $481
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $481
ADDRGP4 teamplay
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $479
LABELV $481
ADDRGP4 teamplay
INDIRI4
CNSTI4 0
NEI4 $474
LABELV $479
line 677
;677:			{
line 678
;678:				trace_ent->axhitme = 1;
ADDRLP4 36
INDIRP4
CNSTI4 780
ADDP4
CNSTF4 1065353216
ASGNF4
line 679
;679:				SpawnBlood( org, 20 );
ADDRLP4 0
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 680
;680:				tf_data.deathmsg = DMSG_BIOWEAPON_ATT;
ADDRGP4 tf_data+88
CNSTI4 14
ASGNI4
line 681
;681:				T_Damage( trace_ent, self, self, 10 );
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
CNSTF4 1092616192
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 682
;682:				if ( trace_ent->playerclass == PC_MEDIC )
ADDRLP4 36
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 5
NEI4 $483
line 683
;683:					return;
ADDRGP4 $444
JUMPV
LABELV $483
line 684
;684:				if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $485
line 685
;685:					return;
ADDRGP4 $444
JUMPV
LABELV $485
line 686
;686:				trace_ent->tfstate |= TFSTATE_INFECTED;
ADDRLP4 64
ADDRLP4 36
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 687
;687:				BioInfection = spawn(  );
ADDRLP4 68
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 68
INDIRP4
ASGNP4
line 688
;688:				BioInfection->s.v.classname = "timer";
ADDRLP4 40
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $334
ASGNP4
line 689
;689:				BioInfection->s.v.owner = g_globalvars.trace_ent;
ADDRLP4 40
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 g_globalvars+304
INDIRI4
ASGNI4
line 690
;690:				BioInfection->s.v.nextthink = g_globalvars.time + 2;
ADDRLP4 40
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 691
;691:				BioInfection->s.v.think = ( func_t ) BioInfection_Decay;
ADDRLP4 40
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 BioInfection_Decay
CVPU4 4
CVUI4 4
ASGNI4
line 692
;692:				BioInfection->s.v.enemy = EDICT_TO_PROG( self );
ADDRLP4 40
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
line 693
;693:				trace_ent->infection_team_no = self->team_no;
ADDRLP4 36
INDIRP4
CNSTI4 968
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
line 694
;694:			}
line 695
;695:		} else
ADDRGP4 $474
JUMPV
LABELV $475
line 696
;696:		{
line 697
;697:			if ( ( int ) trace_ent->s.v.flags & FL_MONSTER )
ADDRLP4 36
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $491
line 698
;698:			{
line 699
;699:				if ( streq( trace_ent->s.v.classname, "monster_zombie" ) )
ADDRLP4 36
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $495
ARGP4
ADDRLP4 48
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $493
line 700
;700:					T_Damage( trace_ent, self, self, 200 );
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
CNSTF4 1128792064
ARGF4
ADDRGP4 T_Damage
CALLV
pop
LABELV $493
line 701
;701:				trace_ent->axhitme = 1;
ADDRLP4 36
INDIRP4
CNSTI4 780
ADDP4
CNSTF4 1065353216
ASGNF4
line 702
;702:				SpawnBlood( org, 20 );
ADDRLP4 0
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 703
;703:				T_Damage( trace_ent, self, self, 10 );
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTF4 1092616192
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 704
;704:				BioInfection = spawn(  );
ADDRLP4 60
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 60
INDIRP4
ASGNP4
line 705
;705:				BioInfection->s.v.classname = "timer";
ADDRLP4 40
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $334
ASGNP4
line 706
;706:				BioInfection->s.v.nextthink = g_globalvars.time + 2;
ADDRLP4 40
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 707
;707:				BioInfection->s.v.think = ( func_t ) BioInfection_MonsterDecay;
ADDRLP4 40
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 BioInfection_MonsterDecay
CVPU4 4
CVUI4 4
ASGNI4
line 708
;708:				BioInfection->s.v.owner = EDICT_TO_PROG( self );
ADDRLP4 40
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
line 709
;709:				BioInfection->s.v.enemy = g_globalvars.trace_ent;
ADDRLP4 40
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 g_globalvars+304
INDIRI4
ASGNI4
line 710
;710:			} else
ADDRGP4 $474
JUMPV
LABELV $491
line 711
;711:			{
line 712
;712:				trace_ent->axhitme = 1;
ADDRLP4 36
INDIRP4
CNSTI4 780
ADDP4
CNSTF4 1065353216
ASGNF4
line 713
;713:				SpawnBlood( org, 30 );
ADDRLP4 0
ARGP4
CNSTF4 1106247680
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 714
;714:				T_Damage( trace_ent, self, self, 40 );
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
CNSTF4 1109393408
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 715
;715:			}
line 716
;716:		}
line 717
;717:	} else
ADDRGP4 $474
JUMPV
LABELV $473
line 718
;718:	{
line 719
;719:		sound( self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $200
ARGP4
ADDRLP4 44
CNSTF4 1065353216
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 721
;720:
;721:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 722
;722:		trap_WriteByte( MSG_MULTICAST, TE_GUNSHOT );
CNSTI4 4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 723
;723:		trap_WriteByte( MSG_MULTICAST, 3 );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 724
;724:		trap_WriteCoord( MSG_MULTICAST, org[0] );
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 725
;725:		trap_WriteCoord( MSG_MULTICAST, org[1] );
CNSTI4 4
ARGI4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 726
;726:		trap_WriteCoord( MSG_MULTICAST, org[2] );
CNSTI4 4
ARGI4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 727
;727:		trap_multicast( PASSVEC3( org ), MULTICAST_PVS );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 728
;728:	}
LABELV $474
line 729
;729:}
LABELV $444
endproc W_FireBioweapon 72 32
export wall_velocity
proc wall_velocity 36 12
line 737
;730:
;731://============================================================================
;732:
;733:
;734://============================================================================
;735:
;736:void wall_velocity( vec3_t v )
;737:{
line 740
;738:	vec3_t  vel;
;739:
;740:	normalize( self->s.v.velocity, vel );
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 normalize
CALLV
pop
line 742
;741:
;742:	vel[0] += g_globalvars.v_up[0] * ( g_random(  ) - 0.5 ) + g_globalvars.v_right[0] * ( g_random(  ) - 0.5 );
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 16
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 g_globalvars+240
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRGP4 g_globalvars+252
INDIRF4
ADDRLP4 16
INDIRF4
CNSTF4 1056964608
SUBF4
MULF4
ADDF4
ADDF4
ASGNF4
line 744
;743:
;744:	vel[1] += g_globalvars.v_up[1] * ( g_random(  ) - 0.5 ) + g_globalvars.v_right[1] * ( g_random(  ) - 0.5 );
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 24
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 g_globalvars+240+4
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRGP4 g_globalvars+252+4
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1056964608
SUBF4
MULF4
ADDF4
ADDF4
ASGNF4
line 745
;745:	vel[2] += g_globalvars.v_up[2] * ( g_random(  ) - 0.5 ) + g_globalvars.v_right[2] * ( g_random(  ) - 0.5 );
ADDRLP4 28
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 32
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 g_globalvars+240+8
INDIRF4
ADDRLP4 28
INDIRF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRGP4 g_globalvars+252+8
INDIRF4
ADDRLP4 32
INDIRF4
CNSTF4 1056964608
SUBF4
MULF4
ADDF4
ADDF4
ASGNF4
line 747
;746:
;747:	VectorNormalize( vel );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 749
;748:
;749:	vel[0] += 2 * g_globalvars.trace_plane_normal[0];
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
ADDRGP4 g_globalvars+288
INDIRF4
MULF4
ADDF4
ASGNF4
line 750
;750:	vel[1] += 2 * g_globalvars.trace_plane_normal[1];
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1073741824
ADDRGP4 g_globalvars+288+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 751
;751:	vel[2] += 2 * g_globalvars.trace_plane_normal[2];
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1073741824
ADDRGP4 g_globalvars+288+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 753
;752:
;753:	VectorScale( vel, 200, v );
ADDRLP4 0
ARGP4
CNSTF4 1128792064
ARGF4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 756
;754:
;755:	//return vel;
;756:}
LABELV $502
endproc wall_velocity 36 12
export SpawnMeatSpray
proc SpawnMeatSpray 24 28
line 764
;757:
;758:/*
;759:================
;760:SpawnMeatSpray
;761:================
;762:*/
;763:void SpawnMeatSpray( vec3_t org, vec3_t vel )
;764:{
line 767
;765:	gedict_t *missile;
;766:
;767:	missile = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 768
;768:	missile->s.v.owner = EDICT_TO_PROG( self );
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
line 769
;769:	missile->s.v.movetype = MOVETYPE_BOUNCE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 770
;770:	missile->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 772
;771:
;772:	makevectors( self->s.v.angles );
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 774
;773:
;774:	VectorCopy( vel, missile->s.v.velocity );
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRFP4 4
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 775
;775:	missile->s.v.velocity[2] = missile->s.v.velocity[2] + 250 + 50 * g_random(  );
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1132068864
ADDF4
CNSTF4 1112014848
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 777
;776:
;777:	SetVector( missile->s.v.avelocity, 3000, 1000, 2000 );
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1161527296
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1148846080
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1157234688
ASGNF4
line 780
;778:
;779:// set missile duration
;780:	missile->s.v.nextthink = g_globalvars.time + 1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 781
;781:	missile->s.v.think = ( func_t ) SUB_Remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 783
;782:
;783:	setmodel( missile, "progs/zom_gib.mdl" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $524
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 784
;784:	setsize( missile, 0, 0, 0, 0, 0, 0 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 785
;785:	setorigin( missile, PASSVEC3( org ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 786
;786:}
LABELV $522
endproc SpawnMeatSpray 24 28
export SpawnBlood
proc SpawnBlood 8 16
line 794
;787:
;788:/*
;789:================
;790:SpawnBlood
;791:================
;792:*/
;793:void SpawnBlood( vec3_t org, float damage )
;794:{
line 795
;795:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 796
;796:	trap_WriteByte( MSG_MULTICAST, TE_BLOOD );
CNSTI4 4
ARGI4
CNSTI4 12
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 797
;797:	trap_WriteByte( MSG_MULTICAST, 1 );
CNSTI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 798
;798:	trap_WriteCoord( MSG_MULTICAST, org[0] );
CNSTI4 4
ARGI4
ADDRFP4 0
INDIRP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 799
;799:	trap_WriteCoord( MSG_MULTICAST, org[1] );
ADDRLP4 0
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 800
;800:	trap_WriteCoord( MSG_MULTICAST, org[2] );
CNSTI4 4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 801
;801:	trap_multicast( PASSVEC3( org ), MULTICAST_PVS );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 802
;802:}
LABELV $525
endproc SpawnBlood 8 16
export spawn_touchblood
proc spawn_touchblood 12 12
line 811
;803:
;804:/*
;805:================
;806:spawn_touchblood
;807:================
;808:*/
;809:
;810:void spawn_touchblood( float damage )
;811:{
line 814
;812:	vec3_t  vel;
;813:
;814:	wall_velocity( vel );
ADDRLP4 0
ARGP4
ADDRGP4 wall_velocity
CALLV
pop
line 815
;815:	VectorScale( vel, 0.2 * 0.01, vel );
ADDRLP4 0
ARGP4
CNSTF4 990057071
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 816
;816:	VectorAdd( self->s.v.origin, vel, vel );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 817
;817:	SpawnBlood( vel, damage );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRF4
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 818
;818:}
LABELV $526
endproc spawn_touchblood 12 12
export SpawnChunk
proc SpawnChunk 0 0
line 821
;819:
;820:void SpawnChunk( vec3_t org, vec3_t vel )
;821:{
line 823
;822:	//particle(org, vel * 0.02, 0, 10); //not exist in qw server
;823:}
LABELV $531
endproc SpawnChunk 0 0
export ClearMultiDamage
proc ClearMultiDamage 0 0
line 844
;824:
;825:/*
;826:==============================================================================
;827:
;828:MULTI-DAMAGE
;829:
;830:Collects multiple small damages into a single damage
;831:
;832:==============================================================================
;833:*/
;834:static gedict_t *multi_ent;
;835:static float   multi_damage;
;836:
;837:static vec3_t  blood_org;
;838:static float   blood_count;
;839:
;840:vec3_t  puff_org;
;841:static float   puff_count;
;842:
;843:void ClearMultiDamage(  )
;844:{
line 845
;845:	multi_ent = world;
ADDRGP4 multi_ent
ADDRGP4 world
INDIRP4
ASGNP4
line 846
;846:	multi_damage = 0;
ADDRGP4 multi_damage
CNSTF4 0
ASGNF4
line 847
;847:	blood_count = 0;
ADDRGP4 blood_count
CNSTF4 0
ASGNF4
line 848
;848:	puff_count = 0;
ADDRGP4 puff_count
CNSTF4 0
ASGNF4
line 849
;849:}
LABELV $532
endproc ClearMultiDamage 0 0
export ApplyMultiDamage
proc ApplyMultiDamage 8 24
line 852
;850:
;851:void ApplyMultiDamage(  )
;852:{
line 853
;853:	if ( multi_ent == world || !multi_ent )
ADDRLP4 0
ADDRGP4 multi_ent
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 0
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $536
ADDRLP4 0
INDIRU4
CNSTU4 0
NEU4 $534
LABELV $536
line 854
;854:		return;
ADDRGP4 $533
JUMPV
LABELV $534
line 855
;855:	TF_T_Damage( multi_ent, self, self, multi_damage, 2, 1 );
ADDRGP4 multi_ent
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 multi_damage
INDIRF4
ARGF4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 856
;856:}
LABELV $533
endproc ApplyMultiDamage 8 24
export AddMultiDamage
proc AddMultiDamage 4 0
line 859
;857:
;858:void AddMultiDamage( gedict_t * hit, float damage )
;859:{
line 860
;860:	if ( !hit )
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $538
line 861
;861:		return;
ADDRGP4 $537
JUMPV
LABELV $538
line 862
;862:	if ( hit != multi_ent )
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 multi_ent
INDIRP4
CVPU4 4
EQU4 $540
line 863
;863:	{
line 864
;864:		ApplyMultiDamage(  );
ADDRGP4 ApplyMultiDamage
CALLV
pop
line 865
;865:		multi_damage = damage;
ADDRGP4 multi_damage
ADDRFP4 4
INDIRF4
ASGNF4
line 866
;866:		multi_ent = hit;
ADDRGP4 multi_ent
ADDRFP4 0
INDIRP4
ASGNP4
line 867
;867:	} else
ADDRGP4 $541
JUMPV
LABELV $540
line 868
;868:		multi_damage = multi_damage + damage;
ADDRLP4 0
ADDRGP4 multi_damage
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
ADDF4
ASGNF4
LABELV $541
line 869
;869:}
LABELV $537
endproc AddMultiDamage 4 0
export Multi_Finish
proc Multi_Finish 0 16
line 872
;870:
;871:void Multi_Finish(  )
;872:{
line 873
;873:	if ( puff_count )
ADDRGP4 puff_count
INDIRF4
CNSTF4 0
EQF4 $543
line 874
;874:	{
line 875
;875:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 876
;876:		trap_WriteByte( MSG_MULTICAST, TE_GUNSHOT );
CNSTI4 4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 877
;877:		trap_WriteByte( MSG_MULTICAST, puff_count );
CNSTI4 4
ARGI4
ADDRGP4 puff_count
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 878
;878:		trap_WriteCoord( MSG_MULTICAST, puff_org[0] );
CNSTI4 4
ARGI4
ADDRGP4 puff_org
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 879
;879:		trap_WriteCoord( MSG_MULTICAST, puff_org[1] );
CNSTI4 4
ARGI4
ADDRGP4 puff_org+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 880
;880:		trap_WriteCoord( MSG_MULTICAST, puff_org[2] );
CNSTI4 4
ARGI4
ADDRGP4 puff_org+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 881
;881:		trap_multicast( PASSVEC3( puff_org ), MULTICAST_PVS );
ADDRGP4 puff_org
INDIRF4
ARGF4
ADDRGP4 puff_org+4
INDIRF4
ARGF4
ADDRGP4 puff_org+8
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 882
;882:	}
LABELV $543
line 884
;883:
;884:	if ( blood_count )
ADDRGP4 blood_count
INDIRF4
CNSTF4 0
EQF4 $549
line 885
;885:	{
line 886
;886:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 887
;887:		trap_WriteByte( MSG_MULTICAST, TE_BLOOD );
CNSTI4 4
ARGI4
CNSTI4 12
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 888
;888:		trap_WriteByte( MSG_MULTICAST, blood_count );
CNSTI4 4
ARGI4
ADDRGP4 blood_count
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 889
;889:		trap_WriteCoord( MSG_MULTICAST, blood_org[0] );
CNSTI4 4
ARGI4
ADDRGP4 blood_org
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 890
;890:		trap_WriteCoord( MSG_MULTICAST, blood_org[1] );
CNSTI4 4
ARGI4
ADDRGP4 blood_org+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 891
;891:		trap_WriteCoord( MSG_MULTICAST, blood_org[2] );
CNSTI4 4
ARGI4
ADDRGP4 blood_org+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 892
;892:		trap_multicast( PASSVEC3( puff_org ), MULTICAST_PVS );
ADDRGP4 puff_org
INDIRF4
ARGF4
ADDRGP4 puff_org+4
INDIRF4
ARGF4
ADDRGP4 puff_org+8
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 893
;893:	}
LABELV $549
line 894
;894:}
LABELV $542
endproc Multi_Finish 0 16
export TraceAttack
proc TraceAttack 28 12
line 908
;895:
;896:/*
;897:==============================================================================
;898:BULLETS
;899:==============================================================================
;900:*/
;901:/*
;902:================
;903:TraceAttack
;904:================
;905:*/
;906:// dir must be normalized
;907:void TraceAttack( float damage, vec3_t dir )
;908:{
line 912
;909:	vec3_t  	org, tmp;
;910:
;911:	// org = trace_endpos - dir*4;
;912:	VectorScale( dir, 4, tmp );
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1082130432
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 913
;913:	VectorSubtract( g_globalvars.trace_endpos, tmp, org );
ADDRLP4 0
ADDRGP4 g_globalvars+276
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ADDRLP4 12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ADDRLP4 12+8
INDIRF4
SUBF4
ASGNF4
line 915
;914:	
;915:	if ( PROG_TO_EDICT( g_globalvars.trace_ent )->s.v.takedamage )
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts+112+228
ADDP4
INDIRF4
CNSTF4 0
EQF4 $565
line 916
;916:	{
line 917
;917:		blood_count = blood_count + 1;
ADDRLP4 24
ADDRGP4 blood_count
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 918
;918:		VectorCopy( org, blood_org );	//  blood_org = org;
ADDRGP4 blood_org
ADDRLP4 0
INDIRF4
ASGNF4
ADDRGP4 blood_org+4
ADDRLP4 0+4
INDIRF4
ASGNF4
ADDRGP4 blood_org+8
ADDRLP4 0+8
INDIRF4
ASGNF4
line 919
;919:		AddMultiDamage( PROG_TO_EDICT( g_globalvars.trace_ent ), damage );
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRFP4 0
INDIRF4
ARGF4
ADDRGP4 AddMultiDamage
CALLV
pop
line 920
;920:	} else
ADDRGP4 $566
JUMPV
LABELV $565
line 921
;921:	{
line 922
;922:		puff_count = puff_count + 1;
ADDRLP4 24
ADDRGP4 puff_count
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 923
;923:	}
LABELV $566
line 924
;924:}
LABELV $555
endproc TraceAttack 28 12
export FireBullets
proc FireBullets 60 32
line 935
;925:
;926:/*
;927:================
;928:FireBullets
;929:
;930:Used by shotgun, super shotgun, and enemy soldier firing
;931:Go to the trouble of combining multiple pellets into a single damage call.
;932:================
;933:*/
;934:void FireBullets( float shotcount, vec3_t dir, float spread_x, float spread_y, float spread_z )
;935:{
line 939
;936:	vec3_t  direction;
;937:	vec3_t  src, tmp,end;
;938:
;939:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 940
;940:	VectorScale( g_globalvars.v_forward, 10, tmp );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1092616192
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 941
;941:	VectorAdd( self->s.v.origin, tmp, src );
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 24+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 24+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 943
;942:	//src = self->s.v.origin + g_globalvars.v_forward*10;
;943:	src[2] = self->s.v.absmin[2] + self->s.v.size[2] * 0.7;
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24+8
ADDRLP4 48
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1060320051
ADDRLP4 48
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 945
;944:
;945:	ClearMultiDamage(  );
ADDRGP4 ClearMultiDamage
CALLV
pop
line 947
;946:#ifdef NEWHWGUY
;947:	if (self->current_weapon != WEAP_ASSAULT_CANNON ) {
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 32768
EQI4 $582
line 949
;948:#endif
;949:        VectorScale( dir, 2048 ,end);
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1157627904
ARGF4
ADDRLP4 36
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 950
;950:        VectorAdd( src, end ,end );
ADDRLP4 36
ADDRLP4 24
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 951
;951:	traceline( PASSVEC3( src ), PASSVEC3( end ), false, self );
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 24+8
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36+4
INDIRF4
ARGF4
ADDRLP4 36+8
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
line 952
;952:	VectorScale( dir, 4, tmp );
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1082130432
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 953
;953:	VectorSubtract( g_globalvars.trace_endpos, tmp, puff_org );	// puff_org = trace_endpos - dir*4;
ADDRGP4 puff_org
ADDRGP4 g_globalvars+276
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRGP4 puff_org+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 puff_org+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 955
;954:#ifdef NEWHWGUY
;955:	}else{
ADDRGP4 $635
JUMPV
LABELV $582
line 957
;956:
;957:	VectorScale( g_globalvars.v_right, crandom(  ) * spread_x / 1.5 , tmp );
ADDRLP4 52
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRGP4 g_globalvars+252
ARGP4
ADDRLP4 52
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
CNSTF4 1069547520
DIVF4
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 958
;958:	VectorAdd( dir, tmp, direction );
ADDRLP4 12
ADDRFP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 959
;959:	VectorScale( g_globalvars.v_up, crandom(  ) * spread_y /1.5 , tmp );
ADDRLP4 56
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRGP4 g_globalvars+240
ARGP4
ADDRLP4 56
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
CNSTF4 1069547520
DIVF4
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 960
;960:	VectorAdd( direction, tmp, direction );
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 962
;961:
;962:        VectorScale( direction, 2048 ,end);
ADDRLP4 12
ARGP4
CNSTF4 1157627904
ARGF4
ADDRLP4 36
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 963
;963:        VectorAdd( src, end ,end );
ADDRLP4 36
ADDRLP4 24
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 965
;964:        
;965:        traceline( PASSVEC3( src ), PASSVEC3( end ), false, self );
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 24+8
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36+4
INDIRF4
ARGF4
ADDRLP4 36+8
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
line 967
;966:
;967:	normalize( dir, tmp );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 normalize
CALLV
pop
line 968
;968:	VectorScale( tmp, 4, tmp );
ADDRLP4 0
ARGP4
CNSTF4 1082130432
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 969
;969:	VectorSubtract( g_globalvars.trace_endpos, tmp, puff_org );
ADDRGP4 puff_org
ADDRGP4 g_globalvars+276
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRGP4 puff_org+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 puff_org+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 970
;970:	}
ADDRGP4 $635
JUMPV
LABELV $634
line 974
;971:#endif
;972:
;973:	while ( shotcount > 0 )
;974:	{
line 975
;975:		VectorScale( g_globalvars.v_right, crandom(  ) * spread_x, tmp );
ADDRLP4 52
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRGP4 g_globalvars+252
ARGP4
ADDRLP4 52
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 976
;976:		VectorAdd( dir, tmp, direction );
ADDRLP4 12
ADDRFP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 977
;977:		VectorScale( g_globalvars.v_up, crandom(  ) * spread_y, tmp );
ADDRLP4 56
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRGP4 g_globalvars+240
ARGP4
ADDRLP4 56
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 978
;978:		VectorAdd( direction, tmp, direction );
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 980
;979:
;980:		VectorScale( direction, 2048, tmp );
ADDRLP4 12
ARGP4
CNSTF4 1157627904
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 981
;981:		VectorAdd( src, tmp, tmp );
ADDRLP4 0
ADDRLP4 24
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 982
;982:		traceline( PASSVEC3( src ), PASSVEC3( tmp ), false, self );
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 24+8
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
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
line 983
;983:		if ( g_globalvars.trace_fraction != 1.0 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $659
line 984
;984:		{
line 986
;985:#ifndef NEWHWGUYold
;986:			if ( self->s.v.weapon != WEAP_ASSAULT_CANNON )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1191182336
EQF4 $662
line 990
;987:#else
;988:			if ( self->current_weapon != WEAP_ASSAULT_CANNON )
;989:#endif
;990:				TraceAttack( 4, direction );
CNSTF4 1082130432
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 TraceAttack
CALLV
pop
ADDRGP4 $663
JUMPV
LABELV $662
line 992
;991:			else
;992:				TraceAttack( 12, direction );
CNSTF4 1094713344
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 TraceAttack
CALLV
pop
LABELV $663
line 993
;993:		}
LABELV $659
line 994
;994:		shotcount = shotcount - 1;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 995
;995:	}
LABELV $635
line 973
ADDRFP4 0
INDIRF4
CNSTF4 0
GTF4 $634
line 997
;996:
;997:	ApplyMultiDamage(  );
ADDRGP4 ApplyMultiDamage
CALLV
pop
line 998
;998:	Multi_Finish(  );
ADDRGP4 Multi_Finish
CALLV
pop
line 999
;999:}
LABELV $575
endproc FireBullets 60 32
export W_FireShotgun
proc W_FireShotgun 32 20
line 1007
;1000:
;1001:/*
;1002:================
;1003:W_FireShotgun
;1004:================
;1005:*/
;1006:void W_FireShotgun(  )
;1007:{
line 1010
;1008:	vec3_t  dir;
;1009:
;1010:	sound( self, CHAN_WEAPON, "weapons/guncock.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $15
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
line 1011
;1011:	KickPlayer( -2, self );
CNSTI4 -2
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1012
;1012:	if ( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $665
line 1013
;1013:		self->s.v.currentammo = --( self->s.v.ammo_shells );
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
LABELV $665
line 1014
;1014:	aim( dir );
ADDRLP4 0
ARGP4
ADDRGP4 aim
CALLV
pop
line 1015
;1015:	tf_data.deathmsg = DMSG_SHOTGUN;
ADDRGP4 tf_data+88
CNSTI4 1
ASGNI4
line 1016
;1016:	FireBullets( 6, dir, 0.04, 0.04, 0 );
CNSTF4 1086324736
ARGF4
ADDRLP4 0
ARGP4
ADDRLP4 28
CNSTF4 1025758986
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 FireBullets
CALLV
pop
line 1017
;1017:	EjectShell ( );
ADDRGP4 EjectShell
CALLV
pop
line 1018
;1018:}
LABELV $664
endproc W_FireShotgun 32 20
export W_FireSuperShotgun
proc W_FireSuperShotgun 28 20
line 1026
;1019:
;1020:/*
;1021:================
;1022:W_FireSuperShotgun
;1023:================
;1024:*/
;1025:void W_FireSuperShotgun(  )
;1026:{
line 1029
;1027:	vec3_t  dir;
;1028:
;1029:	if ( self->s.v.currentammo == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 316
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $670
line 1030
;1030:	{
line 1031
;1031:		W_FireShotgun(  );
ADDRGP4 W_FireShotgun
CALLV
pop
line 1032
;1032:		return;
ADDRGP4 $669
JUMPV
LABELV $670
line 1034
;1033:	}
;1034:	sound( self, CHAN_WEAPON, "weapons/shotgn2.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $23
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
line 1035
;1035:	KickPlayer( -4, self );
CNSTI4 -4
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1036
;1036:	if ( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $672
line 1037
;1037:		self->s.v.currentammo = self->s.v.ammo_shells = self->s.v.ammo_shells - 2;
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
LABELV $672
line 1038
;1038:	aim( dir );
ADDRLP4 0
ARGP4
ADDRGP4 aim
CALLV
pop
line 1039
;1039:	tf_data.deathmsg = DMSG_SSHOTGUN;
ADDRGP4 tf_data+88
CNSTI4 2
ASGNI4
line 1040
;1040:	FireBullets( 14, dir, 0.14, 0.08, 0 );
CNSTF4 1096810496
ARGF4
ADDRLP4 0
ARGP4
CNSTF4 1041194025
ARGF4
CNSTF4 1034147594
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 FireBullets
CALLV
pop
line 1041
;1041:	EjectShell( );
ADDRGP4 EjectShell
CALLV
pop
line 1042
;1042:	EjectShell( );
ADDRGP4 EjectShell
CALLV
pop
line 1043
;1043:}
LABELV $669
endproc W_FireSuperShotgun 28 20
export FireSniperBullet
proc FireSniperBullet 28 32
line 1052
;1044:
;1045:/*
;1046:================
;1047:FireSniperBullet
;1048:================
;1049:*/
;1050:
;1051:void FireSniperBullet( vec3_t direction, float damage )
;1052:{
line 1055
;1053:	vec3_t  src;
;1054:
;1055:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 1057
;1056:
;1057:	src[0] = self->s.v.origin[0] + g_globalvars.v_forward[0] * 10;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1092616192
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
ADDF4
ASGNF4
line 1058
;1058:	src[1] = self->s.v.origin[1] + g_globalvars.v_forward[1] * 10;
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1092616192
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1059
;1059:	src[2] = self->s.v.absmin[2] + self->s.v.size[2] * 0.7;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 12
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1060320051
ADDRLP4 12
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1060
;1060:	ClearMultiDamage(  );
ADDRGP4 ClearMultiDamage
CALLV
pop
line 1061
;1061:	traceline( PASSVEC3( src ), src[0] + direction[0] * 4096, src[1] + direction[1] * 4096,
ADDRLP4 16
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 20
CNSTF4 1166016512
ASGNF4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRP4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 1064
;1062:		   src[2] + direction[2] * 4096, false, self );
;1063:
;1064:	if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $686
line 1065
;1065:		TraceAttack( damage, direction );
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TraceAttack
CALLV
pop
LABELV $686
line 1066
;1066:	if ( !g_globalvars.trace_ent )
ADDRGP4 g_globalvars+304
INDIRI4
CNSTI4 0
NEI4 $689
line 1067
;1067:	{
line 1068
;1068:		trap_WriteByte( MSG_BROADCAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1069
;1069:		trap_WriteByte( MSG_BROADCAST, TE_SPIKE );
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1070
;1070:		trap_WriteCoord( MSG_BROADCAST, g_globalvars.trace_endpos[0] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1071
;1071:		trap_WriteCoord( MSG_BROADCAST, g_globalvars.trace_endpos[1] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1072
;1072:		trap_WriteCoord( MSG_BROADCAST, g_globalvars.trace_endpos[2] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1073
;1073:		trap_multicast( PASSVEC3( g_globalvars.trace_endpos ), MULTICAST_PHS );
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
ADDRGP4 trap_multicast
CALLI4
pop
line 1074
;1074:	}
LABELV $689
line 1076
;1075:
;1076:	ApplyMultiDamage(  );
ADDRGP4 ApplyMultiDamage
CALLV
pop
line 1077
;1077:}
LABELV $676
endproc FireSniperBullet 28 32
export W_FireSniperRifle
proc W_FireSniperRifle 156 32
line 1080
;1078:
;1079:void W_FireSniperRifle(  )
;1080:{
line 1090
;1081:	vec3_t  dir, src;
;1082:	float   dam_mult;
;1083:	float   zdif;
;1084:	//float   use_this;
;1085:	vec3_t  f;
;1086:	vec3_t  g;
;1087:	vec3_t  h, tmp;
;1088:	gedict_t *trace_ent;
;1089:
;1090:	if ( tf_data.snip_fps )
ADDRGP4 tf_data+128
INDIRI4
CNSTI4 0
EQI4 $703
line 1091
;1091:	{
line 1092
;1092:		self->heat = ( g_globalvars.time - self->heat ) * tf_data.snip_fps * 3 + SR_INITDAMAGE;
ADDRLP4 84
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTF4 1077936128
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 84
INDIRP4
INDIRF4
SUBF4
ADDRGP4 tf_data+128
INDIRI4
CVIF4 4
MULF4
MULF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 1094
;1093:
;1094:		if ( self->heat > SR_MAXDAMAGE )
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 1137115136
LEF4 $708
line 1095
;1095:			self->heat = SR_MAXDAMAGE;
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 1137115136
ASGNF4
LABELV $708
line 1096
;1096:	}
LABELV $703
line 1098
;1097:
;1098:	sound( self, 1, "weapons/rifle.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $54
ARGP4
ADDRLP4 84
CNSTF4 1065353216
ASGNF4
ADDRLP4 84
INDIRF4
ARGF4
ADDRLP4 84
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 1099
;1099:	EjectShell( );
ADDRGP4 EjectShell
CALLV
pop
line 1100
;1100:	KickPlayer( -2, self );
CNSTI4 -2
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1101
;1101:	if ( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $710
line 1102
;1102:		self->s.v.currentammo = ( self->s.v.ammo_shells -= tf_data.snip_ammo);
ADDRLP4 88
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 92
ADDRLP4 88
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 96
ADDRLP4 92
INDIRP4
INDIRF4
ADDRGP4 tf_data+132
INDIRI4
CVIF4 4
SUBF4
ASGNF4
ADDRLP4 92
INDIRP4
ADDRLP4 96
INDIRF4
ASGNF4
ADDRLP4 88
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 96
INDIRF4
ASGNF4
LABELV $710
line 1103
;1103:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 1104
;1104:	VectorCopy( g_globalvars.v_forward, dir );
ADDRLP4 12
ADDRGP4 g_globalvars+228
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRGP4 g_globalvars+228+4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 g_globalvars+228+8
INDIRF4
ASGNF4
line 1106
;1105:
;1106:	src[0] = self->s.v.origin[0] + g_globalvars.v_forward[0] * 10;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1092616192
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
ADDF4
ASGNF4
line 1107
;1107:	src[1] = self->s.v.origin[1] + g_globalvars.v_forward[1] * 10;
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1092616192
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1108
;1108:	src[2] = self->s.v.absmin[2] + self->s.v.size[2] * 0.7;
ADDRLP4 100
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 100
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1060320051
ADDRLP4 100
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1110
;1109:
;1110:	if ( tf_data.snip_range_fix )
ADDRGP4 tf_data+124
INDIRI4
CNSTI4 0
EQI4 $726
line 1111
;1111:	       traceline( PASSVEC3( src ), src[0] + dir[0] * 8092, src[1] + dir[1] * 8092,
ADDRLP4 104
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 104
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 108
CNSTF4 1174200320
ASGNF4
ADDRLP4 104
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
ADDRGP4 $727
JUMPV
LABELV $726
line 1114
;1112:	       	       src[2] + dir[2] * 8092, false, self );
;1113:	else
;1114:		traceline( PASSVEC3( src ), src[0] + dir[0] * 3072, src[1] + dir[1] * 3072,
ADDRLP4 112
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 112
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 116
CNSTF4 1161822208
ASGNF4
ADDRLP4 112
INDIRF4
ADDRLP4 116
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 116
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 116
INDIRF4
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
LABELV $727
line 1118
;1115:			   src[2] + dir[2] * 3072, false, self );
;1116:	        
;1117:	        
;1118:	trace_ent = PROG_TO_EDICT( g_globalvars.trace_ent );
ADDRLP4 24
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 1120
;1119:
;1120:	KickPlayer( -4, self );
CNSTI4 -4
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1122
;1121:
;1122:	tf_data.deathmsg = DMSG_SNIPERRIFLE;
ADDRGP4 tf_data+88
CNSTI4 18
ASGNI4
line 1123
;1123:	dam_mult = 1;
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
line 1124
;1124:	if ( g_globalvars.trace_ent )
ADDRGP4 g_globalvars+304
INDIRI4
CNSTI4 0
EQI4 $743
line 1125
;1125:	{
line 1126
;1126:		if ( streq( trace_ent->s.v.classname, "player" ) )
ADDRLP4 24
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $178
ARGP4
ADDRLP4 120
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
EQI4 $744
line 1127
;1127:		{
line 1128
;1128:			if ( trace_ent->team_no == self->team_no )
ADDRLP4 124
CNSTI4 960
ASGNI4
ADDRLP4 24
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRI4
NEI4 $748
line 1129
;1129:			{
line 1130
;1130:				G_sprint ( self, 1, "Stop shooting team mates!!!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $750
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1131
;1131:				return;
ADDRGP4 $702
JUMPV
LABELV $748
line 1133
;1132:			}
;1133:			VectorSubtract( g_globalvars.trace_endpos, src, f );
ADDRLP4 28
ADDRGP4 g_globalvars+276
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 1134
;1134:			g[0] = g_globalvars.trace_endpos[0];
ADDRLP4 44
ADDRGP4 g_globalvars+276
INDIRF4
ASGNF4
line 1135
;1135:			g[1] = g_globalvars.trace_endpos[1];
ADDRLP4 44+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ASGNF4
line 1136
;1136:			g[2] = 0;
ADDRLP4 44+8
CNSTF4 0
ASGNF4
line 1137
;1137:			h[0] = trace_ent->s.v.origin[0];
ADDRLP4 56
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
line 1138
;1138:			h[1] = trace_ent->s.v.origin[1];
ADDRLP4 56+4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
line 1139
;1139:			h[2] = 0;
ADDRLP4 56+8
CNSTF4 0
ASGNF4
line 1140
;1140:			VectorSubtract( g, h, tmp );
ADDRLP4 68
ADDRLP4 44
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 44+4
INDIRF4
ADDRLP4 56+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 44+8
INDIRF4
ADDRLP4 56+8
INDIRF4
SUBF4
ASGNF4
line 1141
;1141:			VectorNormalize( f );
ADDRLP4 28
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1142
;1142:			VectorScale( f, vlen( tmp ), f );
ADDRLP4 68
ARGP4
ADDRLP4 128
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 28
ARGP4
ADDRLP4 128
INDIRF4
ARGF4
ADDRLP4 28
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1143
;1143:			VectorAdd( f, g_globalvars.trace_endpos, f );
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRGP4 g_globalvars+276
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 28+4
INDIRF4
ADDRGP4 g_globalvars+276+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
ADDRGP4 g_globalvars+276+8
INDIRF4
ADDF4
ASGNF4
line 1145
;1144:			//f = normalize(f) * x + g_globalvars.trace_endpos;
;1145:			zdif = f[2] - trace_ent->s.v.origin[2];
ADDRLP4 80
ADDRLP4 28+8
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1146
;1146:			tf_data.deathmsg = DMSG_SNIPERRIFLE;
ADDRGP4 tf_data+88
CNSTI4 18
ASGNI4
line 1147
;1147:			SetVector( trace_ent->head_shot_vector, 0, 0, 0 );
ADDRLP4 24
INDIRP4
CNSTI4 1452
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 1456
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 1460
ADDP4
CNSTF4 0
ASGNF4
line 1148
;1148:			if ( zdif < 0 && ( trace_ent->is_squating == FALSE ) )
ADDRLP4 80
INDIRF4
CNSTF4 0
GEF4 $784
ADDRLP4 24
INDIRP4
CNSTI4 1776
ADDP4
INDIRI4
CNSTI4 0
NEI4 $784
line 1149
;1149:			{
line 1150
;1150:				dam_mult = 0.5;
ADDRLP4 40
CNSTF4 1056964608
ASGNF4
line 1151
;1151:				trace_ent->leg_damage = trace_ent->leg_damage + 1;
ADDRLP4 132
ADDRLP4 24
INDIRP4
CNSTI4 1464
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1152
;1152:				TeamFortress_SetSpeed( trace_ent );
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 1153
;1153:				tf_data.deathmsg = DMSG_SNIPERLEGSHOT;
ADDRGP4 tf_data+88
CNSTI4 28
ASGNI4
line 1154
;1154:				TF_T_Damage( trace_ent, self, self, self->heat * dam_mult, 2, 1 );
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
ARGP4
ADDRLP4 136
INDIRP4
ARGP4
ADDRLP4 136
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ARGF4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 1155
;1155:				if ( trace_ent->s.v.health > 0 )
ADDRLP4 24
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $702
line 1156
;1156:				{
line 1157
;1157:					G_sprint( trace_ent, 0, "Leg injury!\n" );
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $789
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1158
;1158:					G_sprint( self, 1, "Leg shot - that'll slow him down!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $790
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1159
;1159:				}
line 1160
;1160:				return;
ADDRGP4 $702
JUMPV
LABELV $784
line 1162
;1161:			} else
;1162:			{
line 1163
;1163:				if ( zdif > 20 || trace_ent->is_squating == TRUE )
ADDRLP4 80
INDIRF4
CNSTF4 1101004800
GTF4 $793
ADDRLP4 24
INDIRP4
CNSTI4 1776
ADDP4
INDIRI4
CNSTI4 1
NEI4 $791
LABELV $793
line 1164
;1164:				{
line 1165
;1165:					dam_mult = 3/*2*/;
ADDRLP4 40
CNSTF4 1077936128
ASGNF4
line 1166
;1166:					stuffcmd( trace_ent, "bf\n" );
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 $794
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1167
;1167:					VectorSubtract( trace_ent->s.v.origin, self->s.v.origin,
ADDRLP4 136
CNSTI4 156
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 1452
ADDP4
ADDRLP4 24
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144
CNSTI4 160
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 1456
ADDP4
ADDRLP4 24
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 152
CNSTI4 164
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 1460
ADDP4
ADDRLP4 24
INDIRP4
ADDRLP4 152
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 152
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1170
;1168:							trace_ent->head_shot_vector );
;1169:					//trace_ent->head_shot_vector = trace_ent->s.v.origin - self->s.v.origin;
;1170:					tf_data.deathmsg = DMSG_SNIPERHEADSHOT;
ADDRGP4 tf_data+88
CNSTI4 29
ASGNI4
line 1171
;1171:					sound ( self, 0, "speech/excelent.wav", 1, 0 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $53
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 1172
;1172:					TF_T_Damage( trace_ent, self, self, self->heat * dam_mult, 2, 1 );
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ARGF4
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 1173
;1173:					if ( trace_ent->s.v.health > 0 )
ADDRLP4 24
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $702
line 1174
;1174:					{
line 1175
;1175:						G_sprint( trace_ent, 0, "Head injury!\n" );
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $798
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1176
;1176:						G_sprint( self, 1, "Head shot - that's gotta hurt!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $799
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1177
;1177:					}
line 1178
;1178:					return;
ADDRGP4 $702
JUMPV
LABELV $791
line 1180
;1179:				} else
;1180:					tf_data.deathmsg = DMSG_SNIPERRIFLE;
ADDRGP4 tf_data+88
CNSTI4 18
ASGNI4
line 1181
;1181:			}
line 1182
;1182:		}
line 1183
;1183:	}else
ADDRGP4 $744
JUMPV
LABELV $743
line 1184
;1184:	{
line 1185
;1185:		trap_WriteByte( MSG_BROADCAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1186
;1186:		trap_WriteByte( MSG_BROADCAST, TE_SPIKE );
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1187
;1187:		trap_WriteCoord( MSG_BROADCAST, g_globalvars.trace_endpos[0] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1188
;1188:		trap_WriteCoord( MSG_BROADCAST, g_globalvars.trace_endpos[1] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1189
;1189:		trap_WriteCoord( MSG_BROADCAST, g_globalvars.trace_endpos[2] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1190
;1190:		trap_multicast( PASSVEC3( g_globalvars.trace_endpos ), MULTICAST_PHS );
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
ADDRGP4 trap_multicast
CALLI4
pop
line 1191
;1191:	}
LABELV $744
line 1192
;1192:	ClearMultiDamage(  );
ADDRGP4 ClearMultiDamage
CALLV
pop
line 1193
;1193:	if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $811
line 1194
;1194:	{
line 1195
;1195:		TraceAttack( self->heat * dam_mult, dir );
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 TraceAttack
CALLV
pop
line 1196
;1196:	}
LABELV $811
line 1197
;1197:	ApplyMultiDamage(  );
ADDRGP4 ApplyMultiDamage
CALLV
pop
line 1198
;1198:}
LABELV $702
endproc W_FireSniperRifle 156 32
export W_FireAutoRifle
proc W_FireAutoRifle 28 20
line 1201
;1199:
;1200:void W_FireAutoRifle(  )
;1201:{
line 1204
;1202:	vec3_t  dir;
;1203:
;1204:	sound( self, 1, "weapons/rifle.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $54
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
line 1205
;1205:	KickPlayer( -1, self );
CNSTI4 -1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1206
;1206:	if ( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $815
line 1207
;1207:		self->s.v.currentammo = --( self->s.v.ammo_shells );
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
LABELV $815
line 1208
;1208:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 1209
;1209:	VectorCopy( g_globalvars.v_forward, dir );
ADDRLP4 0
ADDRGP4 g_globalvars+228
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 g_globalvars+228+4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 g_globalvars+228+8
INDIRF4
ASGNF4
line 1210
;1210:	tf_data.deathmsg = DMSG_AUTORIFLE;
ADDRGP4 tf_data+88
CNSTI4 19
ASGNI4
line 1211
;1211:	FireSniperBullet( dir, 8 );
ADDRLP4 0
ARGP4
CNSTF4 1090519040
ARGF4
ADDRGP4 FireSniperBullet
CALLV
pop
line 1212
;1212:}
LABELV $814
endproc W_FireAutoRifle 28 20
lit
align 4
LABELV $827
byte 4 1025758986
byte 4 1025758986
byte 4 0
export W_FireAssaultCannon
code
proc W_FireAssaultCannon 52 20
line 1215
;1213:
;1214:void W_FireAssaultCannon(  )
;1215:{
line 1219
;1216:	vec3_t  dir, vtemp;
;1217:
;1218:#ifdef 	NEWHWGUY
;1219:	vec3_t  spread = { 0.04, 0.04, 0 };
ADDRLP4 12
ADDRGP4 $827
INDIRB
ASGNB 12
line 1221
;1220:
;1221:	if ( self->heat < ( ( ASSAULT_SPREAD_TIME / 0.2 ) * 0.1 ) )
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 1069547520
GEF4 $828
line 1222
;1222:	{
line 1223
;1223:		VectorScale( spread,
ADDRLP4 12
ARGP4
CNSTF4 1073741824
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 1069547520
DIVF4
MULF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1228
;1224:			     ( 1 +
;1225:			       ( self->heat / ( ( ASSAULT_SPREAD_TIME / 0.2 ) * 0.1 ) ) * ( ASSAULT_SPREAD_MULTIPLY -
;1226:											    1 ) ), spread );
;1227:		//spread=spread*(1+(self.heat/((ASSAULT_SPREAD_TIME/0.2)*0.1))*( ASSAULT_SPREAD_MULTIPLY - 1));
;1228:	} else
ADDRGP4 $829
JUMPV
LABELV $828
line 1229
;1229:		VectorScale( spread, ASSAULT_SPREAD_MULTIPLY, spread );
ADDRLP4 12
ARGP4
CNSTF4 1077936128
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 VectorScale
CALLV
pop
LABELV $829
line 1231
;1230:#endif
;1231:	KickPlayer( -4, self );
CNSTI4 -4
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1233
;1232:
;1233:		if ( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $830
line 1234
;1234:			self->s.v.currentammo = --( self->s.v.ammo_shells );
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 44
ADDRLP4 40
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 36
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 44
INDIRF4
ASGNF4
LABELV $830
line 1237
;1235:
;1236:	//aim( dir );
;1237:	vtemp[0] = g_globalvars.v_forward[0] * 10;
ADDRLP4 0
CNSTF4 1092616192
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
ASGNF4
line 1238
;1238:	vtemp[1] = g_globalvars.v_forward[1] * 10;
ADDRLP4 0+4
CNSTF4 1092616192
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
ASGNF4
line 1239
;1239:	vtemp[2] = g_globalvars.v_forward[2] * 10;
ADDRLP4 0+8
CNSTF4 1092616192
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
ASGNF4
line 1240
;1240:	VectorCopy( vtemp, dir );
ADDRLP4 24
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 0+4
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 0+8
INDIRF4
ASGNF4
line 1241
;1241:	tf_data.deathmsg = DMSG_ASSAULTCANNON;
ADDRGP4 tf_data+88
CNSTI4 20
ASGNI4
line 1243
;1242:
;1243:	FireBullets( 6, dir, 0.04, 0.04, 0 );
CNSTF4 1086324736
ARGF4
ADDRLP4 24
ARGP4
ADDRLP4 48
CNSTF4 1025758986
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 FireBullets
CALLV
pop
line 1246
;1244:	//FireBullets( 5, dir, 0.04, 0.04, 0 );
;1245:#ifdef NEWHWGUY
;1246:	FireBullets( 5, dir, PASSVEC3( spread ) );
CNSTF4 1084227584
ARGF4
ADDRLP4 24
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRGP4 FireBullets
CALLV
pop
line 1248
;1247:#endif
;1248:}
LABELV $826
endproc W_FireAssaultCannon 52 20
export check_water
proc check_water 20 32
line 1266
;1249:
;1250:/*
;1251:==============================================================================
;1252:
;1253:ROCKETS
;1254:
;1255:==============================================================================
;1256:*/
;1257:
;1258:void    s_explode1(  );
;1259:void    s_explode2(  );
;1260:void    s_explode3(  );
;1261:void    s_explode4(  );
;1262:void    s_explode5(  );
;1263:void    s_explode6(  );
;1264:
;1265:void check_water()
;1266:{
line 1267
;1267: traceline(PASSVEC3(self->s.v.origin), PASSVEC3(self->s.v.origin), 1, self);
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 1268
;1268: if (g_globalvars.trace_inwater) {
ADDRGP4 g_globalvars+312
INDIRF4
CNSTF4 0
EQF4 $848
line 1269
;1269:   sound(self, 2, "misc/vapeur2.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $39
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
line 1270
;1270:   dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1271
;1271:  }
LABELV $848
line 1272
;1272:}
LABELV $847
endproc check_water 20 32
export s_explode1
proc s_explode1 0 0
line 1275
;1273:
;1274:void s_explode1(  )
;1275:{
line 1276
;1276:	self->s.v.frame = 0;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 1277
;1277:	self->s.v.think = ( func_t ) s_explode2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s_explode2
CVPU4 4
CVUI4 4
ASGNI4
line 1278
;1278:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1279
;1279:	check_water();
ADDRGP4 check_water
CALLV
pop
line 1280
;1280:}
LABELV $851
endproc s_explode1 0 0
export s_explode2
proc s_explode2 0 0
line 1283
;1281:
;1282:void s_explode2(  )
;1283:{
line 1284
;1284:	self->s.v.frame = 1;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1065353216
ASGNF4
line 1285
;1285:	self->s.v.think = ( func_t ) s_explode3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s_explode3
CVPU4 4
CVUI4 4
ASGNI4
line 1286
;1286:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1287
;1287:	check_water();
ADDRGP4 check_water
CALLV
pop
line 1288
;1288:}
LABELV $853
endproc s_explode2 0 0
export s_explode3
proc s_explode3 0 0
line 1291
;1289:
;1290:void s_explode3(  )
;1291:{
line 1292
;1292:	self->s.v.frame = 2;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1073741824
ASGNF4
line 1293
;1293:	self->s.v.think = ( func_t ) s_explode4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s_explode4
CVPU4 4
CVUI4 4
ASGNI4
line 1294
;1294:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1295
;1295:	check_water();
ADDRGP4 check_water
CALLV
pop
line 1296
;1296:}
LABELV $855
endproc s_explode3 0 0
export s_explode4
proc s_explode4 0 0
line 1299
;1297:
;1298:void s_explode4(  )
;1299:{
line 1300
;1300:	self->s.v.frame = 3;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1077936128
ASGNF4
line 1301
;1301:	self->s.v.think = ( func_t ) s_explode5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s_explode5
CVPU4 4
CVUI4 4
ASGNI4
line 1302
;1302:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1303
;1303:	check_water();
ADDRGP4 check_water
CALLV
pop
line 1304
;1304:}
LABELV $857
endproc s_explode4 0 0
export s_explode5
proc s_explode5 0 0
line 1307
;1305:
;1306:void s_explode5(  )
;1307:{
line 1308
;1308:	self->s.v.frame = 4;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1082130432
ASGNF4
line 1309
;1309:	self->s.v.think = ( func_t ) s_explode6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s_explode6
CVPU4 4
CVUI4 4
ASGNI4
line 1310
;1310:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1311
;1311:	check_water();
ADDRGP4 check_water
CALLV
pop
line 1312
;1312:}
LABELV $859
endproc s_explode5 0 0
export s_explode6
proc s_explode6 0 0
line 1315
;1313:
;1314:void s_explode6(  )
;1315:{
line 1316
;1316:	self->s.v.frame = 5;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1084227584
ASGNF4
line 1317
;1317:	self->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 1318
;1318:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1319
;1319:	check_water();
ADDRGP4 check_water
CALLV
pop
line 1320
;1320:}
LABELV $861
endproc s_explode6 0 0
export BecomeExplosion
proc BecomeExplosion 0 4
line 1323
;1321:
;1322:void BecomeExplosion(  )
;1323:{
line 1324
;1324:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1325
;1325:}
LABELV $863
endproc BecomeExplosion 0 4
export T_MissileTouch
proc T_MissileTouch 48 24
line 1328
;1326:
;1327:void T_MissileTouch(  )
;1328:{
line 1332
;1329:	float   damg;
;1330:	vec3_t  tmp;
;1331:
;1332:	if ( self->voided )
ADDRGP4 self
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
EQI4 $865
line 1333
;1333:	{
line 1334
;1334:		return;
ADDRGP4 $864
JUMPV
LABELV $865
line 1336
;1335:	}
;1336:	self->voided = 1;
ADDRGP4 self
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 1337
;1337:	if ( trap_pointcontents( PASSVEC3( self->s.v.origin ) ) == CONTENT_SKY )
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 -6
NEI4 $867
line 1338
;1338:	{
line 1339
;1339:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 1340
;1340:		return;
ADDRGP4 $864
JUMPV
LABELV $867
line 1342
;1341:	}
;1342:	damg = 92 + g_random(  ) * 20;
ADDRLP4 24
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 12
CNSTF4 1101004800
ADDRLP4 24
INDIRF4
MULF4
CNSTF4 1119354880
ADDF4
ASGNF4
line 1343
;1343:	tf_data.deathmsg = self->s.v.weapon;
ADDRGP4 tf_data+88
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1344
;1344:	if ( other->s.v.health )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $870
line 1345
;1345:		TF_T_Damage( other, self, PROG_TO_EDICT( self->s.v.owner ), damg, 0, 4 );
ADDRGP4 other
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
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
LABELV $870
line 1349
;1346://	if ( streq( PROG_TO_EDICT( self->s.v.owner )->s.v.classname, "building_sentrygun" ) )
;1347://		T_RadiusDamage( self, PROG_TO_EDICT( self->s.v.owner ), 150, other );
;1348://	else
;1349:		T_RadiusDamage( self, PROG_TO_EDICT( self->s.v.owner ), 92, other );
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1119354880
ARGF4
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 1350
;1350:	normalize( self->s.v.velocity, tmp );
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 normalize
CALLV
pop
line 1351
;1351:	VectorScale( tmp, -8, tmp );
ADDRLP4 0
ARGP4
CNSTF4 3238002688
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1352
;1352:	VectorAdd( self->s.v.origin, tmp, self->s.v.origin ) trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
ADDRLP4 36
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1353
;1353:	trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1354
;1354:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 1355
;1355:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 1356
;1356:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 1357
;1357:	trap_multicast( PASSVEC3( self->s.v.origin ), MULTICAST_PHS );
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
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
line 1358
;1358:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1359
;1359:}
LABELV $864
endproc T_MissileTouch 48 24
export W_FireRocket
proc W_FireRocket 36 28
line 1367
;1360:
;1361:/*
;1362:================
;1363:W_FireRocket
;1364:================
;1365:*/
;1366:void W_FireRocket(  )
;1367:{
line 1368
;1368:	if ( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $875
line 1369
;1369:		self->s.v.currentammo = --( self->s.v.ammo_rockets );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $875
line 1370
;1370:	sound( self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $14
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
line 1371
;1371:	KickPlayer( -2, self );
CNSTI4 -2
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1372
;1372:	newmis = spawn(  );
ADDRLP4 16
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 16
INDIRP4
ASGNP4
line 1373
;1373:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1374
;1374:	newmis->s.v.owner = EDICT_TO_PROG( self );
ADDRGP4 newmis
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
line 1375
;1375:	newmis->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 1376
;1376:	newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 1379
;1377:
;1378:// set newmis speed     
;1379:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 1381
;1380://	VectorScale( g_globalvars.v_forward, 900, newmis->s.v.velocity );
;1381:	VectorScale( g_globalvars.v_forward, 1350, newmis->s.v.velocity );	// mtf speed is 1350
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1151909888
ARGF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1383
;1382:
;1383:	vectoangles( newmis->s.v.velocity, newmis->s.v.angles );
ADDRLP4 20
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1385
;1384:
;1385:	newmis->s.v.classname = "rocket";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $880
ASGNP4
line 1386
;1386:	newmis->s.v.touch = ( func_t ) T_MissileTouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 T_MissileTouch
CVPU4 4
CVUI4 4
ASGNI4
line 1387
;1387:	newmis->voided = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 0
ASGNI4
line 1389
;1388:// set newmis duration
;1389:	newmis->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 1390
;1390:	newmis->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 1391
;1391:	newmis->s.v.weapon = 6;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1086324736
ASGNF4
line 1392
;1392:	setmodel( newmis, "progs/missile.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $882
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1393
;1393:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1394
;1394:	setorigin( newmis, self->s.v.origin[0] + g_globalvars.v_forward[0] * 8,
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
CNSTF4 1090519040
ASGNF4
ADDRLP4 28
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
ADDF4
CNSTF4 1098907648
ADDF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 1397
;1395:		   self->s.v.origin[1] + g_globalvars.v_forward[1] * 8,
;1396:		   self->s.v.origin[2] + g_globalvars.v_forward[2] * 8 + 16 );
;1397:}
LABELV $874
endproc W_FireRocket 36 28
export LightningHit
proc LightningHit 4 24
line 1405
;1398:
;1399:/*
;1400:===============================================================================
;1401:LIGHTNING
;1402:===============================================================================
;1403:*/
;1404:void LightningHit( gedict_t * from, float damage )
;1405:{
line 1406
;1406:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1407
;1407:	trap_WriteByte( MSG_MULTICAST, TE_LIGHTNINGBLOOD );
CNSTI4 4
ARGI4
CNSTI4 13
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1408
;1408:	trap_WriteCoord( MSG_MULTICAST, g_globalvars.trace_endpos[0] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1409
;1409:	trap_WriteCoord( MSG_MULTICAST, g_globalvars.trace_endpos[1] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1410
;1410:	trap_WriteCoord( MSG_MULTICAST, g_globalvars.trace_endpos[2] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1411
;1411:	trap_multicast( PASSVEC3( g_globalvars.trace_endpos ), MULTICAST_PVS );
ADDRGP4 g_globalvars+276
INDIRF4
ARGF4
ADDRGP4 g_globalvars+276+4
INDIRF4
ARGF4
ADDRGP4 g_globalvars+276+8
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 1413
;1412:
;1413:	TF_T_Damage( PROG_TO_EDICT( g_globalvars.trace_ent ), from, from, damage, 2, 8 );
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 2
ARGI4
CNSTI4 8
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 1414
;1414:}
LABELV $888
endproc LightningHit 4 24
export LightningDamage
proc LightningDamage 84 32
line 1423
;1415:
;1416:/*
;1417:=================
;1418:LightningDamage
;1419:=================
;1420:*/
;1421:
;1422:void LightningDamage( vec3_t p1, vec3_t p2, gedict_t * from, float damage )
;1423:{
line 1428
;1424:	gedict_t *e1;
;1425:	gedict_t *e2;
;1426:	vec3_t  f;
;1427:
;1428:	VectorSubtract( p2, p1, f );	// f = p2 - p1;
ADDRLP4 0
ADDRFP4 4
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1429
;1429:	VectorNormalize( f );	// normalize (f);
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1431
;1430:
;1431:	f[0] = 0 - f[1];
ADDRLP4 0
CNSTF4 0
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
line 1432
;1432:	f[1] = f[0];
ADDRLP4 0+4
ADDRLP4 0
INDIRF4
ASGNF4
line 1433
;1433:	f[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1434
;1434:	VectorScale( f, 16, f );	//f = f*16;
ADDRLP4 0
ARGP4
CNSTF4 1098907648
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1436
;1435:
;1436:	e1 = e2 = world;
ADDRLP4 20
ADDRGP4 world
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 1437
;1437:	traceline( PASSVEC3( p1 ), PASSVEC3( p2 ), false, self );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
CNSTI4 4
ASGNI4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
CNSTI4 8
ASGNI4
ADDRLP4 24
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
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
line 1439
;1438:
;1439:	if ( PROG_TO_EDICT( g_globalvars.trace_ent )->s.v.takedamage )
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts+112+228
ADDP4
INDIRF4
CNSTF4 0
EQF4 $906
line 1440
;1440:	{
line 1441
;1441:		LightningHit( from, damage );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 LightningHit
CALLV
pop
line 1442
;1442:		if ( streq( self->s.v.classname, "player" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $178
ARGP4
ADDRLP4 40
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $911
line 1443
;1443:		{
line 1444
;1444:			if ( streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $178
ARGP4
ADDRLP4 44
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $913
line 1445
;1445:				PROG_TO_EDICT( g_globalvars.trace_ent )->s.v.velocity[2] += 400;
ADDRLP4 48
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts+112+68+8
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
CNSTF4 1137180672
ADDF4
ASGNF4
LABELV $913
line 1446
;1446:		}
LABELV $911
line 1447
;1447:	}
LABELV $906
line 1448
;1448:	e1 = PROG_TO_EDICT( g_globalvars.trace_ent );
ADDRLP4 12
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 1450
;1449:
;1450:	traceline( p1[0] + f[0], p1[1] + f[1], p1[2] + f[2], p2[0] + f[0], p2[1] + f[1], p2[2] + f[2], false, self );
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 44
INDIRF4
ADDF4
ARGF4
ADDRLP4 48
CNSTI4 4
ASGNI4
ADDRLP4 40
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ARGF4
ADDRLP4 52
CNSTI4 8
ASGNI4
ADDRLP4 40
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ARGF4
ADDRLP4 56
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 44
INDIRF4
ADDF4
ARGF4
ADDRLP4 56
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ARGF4
ADDRLP4 56
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 1451
;1451:	if ( PROG_TO_EDICT( g_globalvars.trace_ent ) != e1 && PROG_TO_EDICT( g_globalvars.trace_ent )->s.v.takedamage )
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
ADDRLP4 12
INDIRP4
CVPU4 4
EQU4 $924
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts+112+228
ADDP4
INDIRF4
CNSTF4 0
EQF4 $924
line 1452
;1452:	{
line 1453
;1453:		LightningHit( from, damage );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 LightningHit
CALLV
pop
line 1454
;1454:	}
LABELV $924
line 1455
;1455:	e2 = PROG_TO_EDICT( g_globalvars.trace_ent );
ADDRLP4 16
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 1457
;1456:
;1457:	traceline( p1[0] - f[0], p1[1] - f[1], p1[2] - f[2], p2[0] - f[0], p2[1] - f[1], p2[2] - f[2], false, self );
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 64
INDIRF4
SUBF4
ARGF4
ADDRLP4 68
CNSTI4 4
ASGNI4
ADDRLP4 60
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ARGF4
ADDRLP4 72
CNSTI4 8
ASGNI4
ADDRLP4 60
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ARGF4
ADDRLP4 76
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 64
INDIRF4
SUBF4
ARGF4
ADDRLP4 76
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ARGF4
ADDRLP4 76
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 1458
;1458:	if ( PROG_TO_EDICT( g_globalvars.trace_ent ) != e1
ADDRLP4 80
ADDRGP4 g_edicts
ASGNP4
ADDRGP4 g_globalvars+304
INDIRI4
ADDRLP4 80
INDIRP4
ADDP4
CVPU4 4
ADDRLP4 12
INDIRP4
CVPU4 4
EQU4 $935
ADDRGP4 g_globalvars+304
INDIRI4
ADDRLP4 80
INDIRP4
ADDP4
CVPU4 4
ADDRLP4 16
INDIRP4
CVPU4 4
EQU4 $935
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts+112+228
ADDP4
INDIRF4
CNSTF4 0
EQF4 $935
line 1461
;1459:	     && PROG_TO_EDICT( g_globalvars.trace_ent ) != e2
;1460:	     && PROG_TO_EDICT( g_globalvars.trace_ent )->s.v.takedamage )
;1461:	{
line 1462
;1462:		LightningHit( from, damage );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 LightningHit
CALLV
pop
line 1463
;1463:	}
LABELV $935
line 1464
;1464:}
LABELV $900
endproc LightningDamage 84 32
export W_FireLightning
proc W_FireLightning 52 32
line 1467
;1465:
;1466:void W_FireLightning(  )
;1467:{
line 1472
;1468:	vec3_t  org;
;1469:	float   cells;
;1470:	vec3_t  tmp;
;1471:
;1472:	if ( self->s.v.ammo_cells < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $943
line 1473
;1473:	{
line 1474
;1474:		self->last_weapon = self->current_weapon;
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1036
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
line 1475
;1475:		self->last_weaponmode = self->weaponmode;
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 1040
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
ASGNI4
line 1476
;1476:		self->current_weapon = W_BestWeapon(  );
ADDRLP4 36
ADDRGP4 W_BestWeapon
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 1477
;1477:		W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 1478
;1478:		W_PrintWeaponMessage(  );
ADDRGP4 W_PrintWeaponMessage
CALLV
pop
line 1479
;1479:		return;
ADDRGP4 $942
JUMPV
LABELV $943
line 1481
;1480:	}
;1481:	if ( self->s.v.waterlevel > 1 )
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $945
line 1482
;1482:	{
line 1483
;1483:		cells = self->s.v.ammo_cells;
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ASGNF4
line 1484
;1484:		self->s.v.ammo_cells = 0;
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
CNSTF4 0
ASGNF4
line 1485
;1485:		W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 1486
;1486:		tf_data.deathmsg = DMSG_LIGHTNING;
ADDRGP4 tf_data+88
CNSTI4 7
ASGNI4
line 1487
;1487:		T_RadiusDamage( self, self, 35 * cells, world );
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
CNSTF4 1108082688
ADDRLP4 24
INDIRF4
MULF4
ARGF4
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 1488
;1488:		return;
ADDRGP4 $942
JUMPV
LABELV $945
line 1490
;1489:	}
;1490:	if ( self->t_width < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 652
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $948
line 1491
;1491:	{
line 1492
;1492:		sound( self, 1, "weapons/lhit.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $951
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
line 1493
;1493:		self->t_width = g_globalvars.time + 0.6;
ADDRGP4 self
INDIRP4
CNSTI4 652
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1058642330
ADDF4
ASGNF4
line 1494
;1494:	}
LABELV $948
line 1495
;1495:	KickPlayer( -2, self );
CNSTI4 -2
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1496
;1496:	if ( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $953
line 1497
;1497:		self->s.v.currentammo = --( self->s.v.ammo_cells );
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 28
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
LABELV $953
line 1499
;1498:
;1499:	VectorCopy( self->s.v.origin, org );	//org = self->s.v.origin + '0 0 16';
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 1500
;1500:	org[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1501
;1501:	traceline( PASSVEC3( org ), org[0] + g_globalvars.v_forward[0] * 600,
ADDRLP4 40
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 44
CNSTF4 1142292480
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44
INDIRF4
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 44
INDIRF4
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
ADDF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 1503
;1502:		   org[1] + g_globalvars.v_forward[1] * 600, org[2] + g_globalvars.v_forward[2] * 600, true, self );
;1503:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1504
;1504:	trap_WriteByte( MSG_MULTICAST, TE_LIGHTNING2 );
CNSTI4 4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1505
;1505:	WriteEntity( MSG_MULTICAST, self );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 WriteEntity
CALLV
pop
line 1506
;1506:	trap_WriteCoord( MSG_MULTICAST, org[0] );
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1507
;1507:	trap_WriteCoord( MSG_MULTICAST, org[1] );
CNSTI4 4
ARGI4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1508
;1508:	trap_WriteCoord( MSG_MULTICAST, org[2] );
CNSTI4 4
ARGI4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1509
;1509:	trap_WriteCoord( MSG_MULTICAST, g_globalvars.trace_endpos[0] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1510
;1510:	trap_WriteCoord( MSG_MULTICAST, g_globalvars.trace_endpos[1] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1511
;1511:	trap_WriteCoord( MSG_MULTICAST, g_globalvars.trace_endpos[2] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1513
;1512:
;1513:	trap_multicast( PASSVEC3( org ), MULTICAST_PHS );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 1515
;1514:
;1515:	VectorScale( g_globalvars.v_forward, 4, tmp );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1082130432
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1516
;1516:	VectorAdd( g_globalvars.trace_endpos, tmp, tmp );
ADDRLP4 12
ADDRGP4 g_globalvars+276
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
line 1517
;1517:	LightningDamage( self->s.v.origin, tmp, self, 30 );
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
CNSTF4 1106247680
ARGF4
ADDRGP4 LightningDamage
CALLV
pop
line 1518
;1518:}
LABELV $942
endproc W_FireLightning 52 32
export CountPlayerPipebombs
proc CountPlayerPipebombs 16 12
line 1521
;1519:
;1520:int CountPlayerPipebombs( gedict_t * player )
;1521:{
line 1525
;1522:	gedict_t *old;
;1523:	int     num_pipes;
;1524:
;1525:	num_pipes = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1526
;1526:	old = trap_find( world, FOFS( s.v.classname ), "pipebomb" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $988
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $990
JUMPV
LABELV $989
line 1528
;1527:	while ( old )
;1528:	{
line 1529
;1529:		if ( old->s.v.owner == EDICT_TO_PROG( player ) )
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
NEI4 $992
line 1530
;1530:			num_pipes++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $992
line 1531
;1531:		old = trap_find( old, FOFS( s.v.classname ), "pipebomb" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $988
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1532
;1532:	}
LABELV $990
line 1527
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $989
line 1533
;1533:	return num_pipes;
ADDRLP4 4
INDIRI4
RETI4
LABELV $987
endproc CountPlayerPipebombs 16 12
export ExplodeOldPipebomb
proc ExplodeOldPipebomb 20 12
line 1539
;1534:}
;1535:
;1536:static int     num_team_pipebombs[5];
;1537:
;1538:void ExplodeOldPipebomb( int tno, int extra )
;1539:{
line 1543
;1540:	gedict_t *old;
;1541:	int     index;
;1542:
;1543:	if ( tno )
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $995
line 1544
;1544:	{
line 1545
;1545:		index = num_team_pipebombs[tno];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 num_team_pipebombs
ADDP4
INDIRI4
ASGNI4
line 1546
;1546:		index = index - MAX_WORLD_PIPEBOMBS / number_of_teams;	//- 1 ;//extra pipepomb
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRGP4 MAX_WORLD_PIPEBOMBS
INDIRI4
ADDRGP4 number_of_teams
INDIRI4
DIVI4
SUBI4
ASGNI4
line 1547
;1547:		if ( extra )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $996
line 1548
;1548:			index = index - 1;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1549
;1549:	} else
ADDRGP4 $996
JUMPV
LABELV $995
line 1550
;1550:		index = num_team_pipebombs[0] - MAX_WORLD_PIPEBOMBS;
ADDRLP4 4
ADDRGP4 num_team_pipebombs
INDIRI4
ADDRGP4 MAX_WORLD_PIPEBOMBS
INDIRI4
SUBI4
ASGNI4
LABELV $996
line 1551
;1551:	old = trap_find( world, FOFS( s.v.classname ), "pipebomb" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $988
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $1000
JUMPV
LABELV $999
line 1553
;1552:	while ( index > 0 )
;1553:	{
line 1554
;1554:		if ( !old )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1002
line 1555
;1555:		{
line 1556
;1556:			num_team_pipebombs[0] = 0;
ADDRGP4 num_team_pipebombs
CNSTI4 0
ASGNI4
line 1557
;1557:			num_team_pipebombs[1] = 0;
ADDRGP4 num_team_pipebombs+4
CNSTI4 0
ASGNI4
line 1558
;1558:			num_team_pipebombs[2] = 0;
ADDRGP4 num_team_pipebombs+8
CNSTI4 0
ASGNI4
line 1559
;1559:			num_team_pipebombs[3] = 0;
ADDRGP4 num_team_pipebombs+12
CNSTI4 0
ASGNI4
line 1560
;1560:			num_team_pipebombs[4] = 0;
ADDRGP4 num_team_pipebombs+16
CNSTI4 0
ASGNI4
line 1561
;1561:			return;
ADDRGP4 $994
JUMPV
LABELV $1002
line 1563
;1562:		}
;1563:		if ( PROG_TO_EDICT( old->s.v.owner )->team_no == tno || !tno )
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1011
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1008
LABELV $1011
line 1564
;1564:		{
line 1565
;1565:			old->s.v.nextthink = g_globalvars.time + 0.5;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1566
;1566:			index = index - 1;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1567
;1567:		}
LABELV $1008
line 1568
;1568:		old = trap_find( old, FOFS( s.v.classname ), "pipebomb" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $988
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1569
;1569:	}
LABELV $1000
line 1552
ADDRLP4 4
INDIRI4
CNSTI4 0
GTI4 $999
line 1570
;1570:}
LABELV $994
endproc ExplodeOldPipebomb 20 12
export increment_team_pipebombs
proc increment_team_pipebombs 8 0
line 1573
;1571:
;1572:void increment_team_pipebombs( int tno )
;1573:{
line 1574
;1574:	if ( tno < 0 || tno > 4 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1016
ADDRLP4 0
INDIRI4
CNSTI4 4
LEI4 $1014
LABELV $1016
line 1575
;1575:		return;
ADDRGP4 $1013
JUMPV
LABELV $1014
line 1576
;1576:	num_team_pipebombs[tno]++;
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 num_team_pipebombs
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1577
;1577:}
LABELV $1013
endproc increment_team_pipebombs 8 0
export decrement_team_pipebombs
proc decrement_team_pipebombs 8 0
line 1580
;1578:
;1579:void decrement_team_pipebombs( int tno )
;1580:{
line 1581
;1581:	if ( tno < 0 || tno > 4 )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1020
ADDRLP4 0
INDIRI4
CNSTI4 4
LEI4 $1018
LABELV $1020
line 1582
;1582:		return;
ADDRGP4 $1017
JUMPV
LABELV $1018
line 1583
;1583:	num_team_pipebombs[tno]--;
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 num_team_pipebombs
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1585
;1584:
;1585:}
LABELV $1017
endproc decrement_team_pipebombs 8 0
export GrenadeExplode
proc GrenadeExplode 32 16
line 1590
;1586:
;1587://=============================================================================
;1588:
;1589:void GrenadeExplode(  )
;1590:{
line 1593
;1591:	gedict_t *te;
;1592:
;1593:	if ( self->voided )
ADDRGP4 self
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1022
line 1594
;1594:	{
line 1595
;1595:		return;
ADDRGP4 $1021
JUMPV
LABELV $1022
line 1597
;1596:	}
;1597:	self->voided = 1;
ADDRGP4 self
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 1599
;1598:
;1599:	if ( streq( self->s.v.classname, "pipebomb" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $988
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1024
line 1600
;1600:	{
line 1601
;1601:		decrement_team_pipebombs( self->team_no );
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRGP4 decrement_team_pipebombs
CALLV
pop
line 1603
;1602:
;1603:		if ( !( ( int ) self->s.v.flags & FL_ONGROUND ) )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $1026
line 1604
;1604:			self->s.v.weapon = DMSG_PIPEBOMB;	// TRAP
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1109393408
ASGNF4
LABELV $1026
line 1605
;1605:	}
LABELV $1024
line 1606
;1606:	if ( PROG_TO_EDICT( self->s.v.owner )->has_disconnected != 1 )
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+888
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1028
line 1607
;1607:	{
line 1608
;1608:		tf_data.deathmsg = self->s.v.weapon;
ADDRGP4 tf_data+88
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1609
;1609:		T_RadiusDamage( self, PROG_TO_EDICT( self->s.v.owner ), 120, world );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1123024896
ARGF4
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 1610
;1610:	}
LABELV $1028
line 1611
;1611:	if ( self->no_active_nail_grens )
ADDRGP4 self
INDIRP4
CNSTI4 1088
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1032
line 1612
;1612:	{
line 1613
;1613:		self->no_active_nail_grens = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1088
ADDP4
CNSTI4 0
ASGNI4
line 1614
;1614:		PROG_TO_EDICT( self->s.v.owner )->no_active_nail_grens -= 1;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+1088
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1615
;1615:		te = trap_find( world, FOFS( s.v.classname ), "grenade" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $1035
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRGP4 $1037
JUMPV
LABELV $1036
line 1617
;1616:		while ( te )
;1617:		{
line 1618
;1618:			if ( te->s.v.owner == self->s.v.owner && te->no_active_nail_grens )
ADDRLP4 20
CNSTI4 480
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
NEI4 $1039
ADDRLP4 0
INDIRP4
CNSTI4 1088
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1039
line 1619
;1619:				te->no_active_nail_grens -= 1;
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 1088
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1039
line 1620
;1620:			te = trap_find( te, FOFS( s.v.classname ), "grenade" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $1035
ARGP4
ADDRLP4 28
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 1621
;1621:		}
LABELV $1037
line 1616
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1036
line 1622
;1622:	}
LABELV $1032
line 1623
;1623:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1624
;1624:	trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1625
;1625:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 1626
;1626:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 1627
;1627:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 1628
;1628:	trap_multicast( PASSVEC3( self->s.v.origin ), MULTICAST_PHS );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
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
line 1629
;1629:	BecomeExplosion(  );
ADDRGP4 BecomeExplosion
CALLV
pop
line 1630
;1630:}
LABELV $1021
endproc GrenadeExplode 32 16
export GrenadeTouch
proc GrenadeTouch 12 20
line 1633
;1631:
;1632:void GrenadeTouch(  )
;1633:{
line 1634
;1634:	if ( other == PROG_TO_EDICT( self->s.v.owner ) )
ADDRGP4 other
INDIRP4
CVPU4 4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
NEU4 $1042
line 1635
;1635:		return;		// don't explode on owner
ADDRGP4 $1041
JUMPV
LABELV $1042
line 1636
;1636:	if ( other->s.v.takedamage == DAMAGE_AIM )
ADDRGP4 other
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $1044
line 1637
;1637:	{
line 1638
;1638:		GrenadeExplode(  );
ADDRGP4 GrenadeExplode
CALLV
pop
line 1639
;1639:		return;
ADDRGP4 $1041
JUMPV
LABELV $1044
line 1641
;1640:	}
;1641:	sound( self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM );	// bounce sound
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $22
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
line 1642
;1642:	if ( VectorCompareF( self->s.v.velocity, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1046
line 1643
;1643:		SetVector( self->s.v.avelocity, 0, 0, 0 );
ADDRGP4 self
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 0
ASGNF4
LABELV $1046
line 1644
;1644:}
LABELV $1041
endproc GrenadeTouch 12 20
export W_FireGrenade
proc W_FireGrenade 40 28
line 1652
;1645:
;1646:/*
;1647:================
;1648:W_FireGrenade
;1649:================
;1650:*/
;1651:void W_FireGrenade(  )
;1652:{
line 1656
;1653:	int     num_pipes;
;1654:	int     num_team_pipes;
;1655:
;1656:	if ( !tg_data.unlimit_ammo  ) {
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $1049
line 1657
;1657:		self->s.v.currentammo = --( self->s.v.ammo_rockets );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
line 1658
;1658:		if ( self->option == OPT_LRG ) {
ADDRGP4 self
INDIRP4
CNSTI4 1780
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1052
line 1660
;1659:			//self->s.v.ammo_rockets -= 1;
;1660:			self->s.v.currentammo = --( self->s.v.ammo_rockets );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 20
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
line 1661
;1661:		}
LABELV $1052
line 1662
;1662:	}
LABELV $1049
line 1664
;1663:
;1664:	sound( self, 1, "weapons/grenade.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $21
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
line 1665
;1665:	KickPlayer( -2, self );
CNSTI4 -2
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1666
;1666:	newmis = spawn(  );
ADDRLP4 12
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 12
INDIRP4
ASGNP4
line 1667
;1667:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1668
;1668:	newmis->voided = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 0
ASGNI4
line 1669
;1669:	newmis->s.v.owner = EDICT_TO_PROG( self );
ADDRGP4 newmis
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
line 1670
;1670:	newmis->s.v.movetype = MOVETYPE_BOUNCE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 1671
;1671:	newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 1672
;1672:	if ( !self->weaponmode || ( tf_data.cb_prematch_time > g_globalvars.time ) )
ADDRGP4 self
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1059
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $1055
LABELV $1059
line 1673
;1673:	{
line 1674
;1674:		newmis->s.v.weapon = 5;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1084227584
ASGNF4
line 1675
;1675:		newmis->s.v.classname = "grenade";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $1035
ASGNP4
line 1676
;1676:		newmis->s.v.skin = 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1065353216
ASGNF4
line 1677
;1677:		newmis->s.v.touch = ( func_t ) GrenadeTouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 GrenadeTouch
CVPU4 4
CVUI4 4
ASGNI4
line 1678
;1678:		newmis->s.v.nextthink = g_globalvars.time + 2.5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1075838976
ADDF4
ASGNF4
line 1679
;1679:	} else
ADDRGP4 $1056
JUMPV
LABELV $1055
line 1680
;1680:	{
line 1681
;1681:		num_pipes = CountPlayerPipebombs( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 CountPlayerPipebombs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 1682
;1682:		if ( self->team_no )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1061
line 1683
;1683:		{
line 1684
;1684:			increment_team_pipebombs( self->team_no );
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRGP4 increment_team_pipebombs
CALLV
pop
line 1685
;1685:			num_team_pipes = num_team_pipebombs[self->team_no];
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 num_team_pipebombs
ADDP4
INDIRI4
ASGNI4
line 1687
;1686:
;1687:			if ( num_pipes == 0  && tf_data.add_pipe == 1)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1063
ADDRGP4 tf_data+140
INDIRI4
CNSTI4 1
NEI4 $1063
line 1688
;1688:			{
line 1689
;1689:				if ( num_team_pipes > MAX_WORLD_PIPEBOMBS / number_of_teams + 1 )
ADDRLP4 4
INDIRI4
ADDRGP4 MAX_WORLD_PIPEBOMBS
INDIRI4
ADDRGP4 number_of_teams
INDIRI4
DIVI4
CNSTI4 1
ADDI4
LEI4 $1062
line 1690
;1690:					ExplodeOldPipebomb( self->team_no, 1 );
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 ExplodeOldPipebomb
CALLV
pop
line 1691
;1691:			} else
ADDRGP4 $1062
JUMPV
LABELV $1063
line 1692
;1692:			{
line 1693
;1693:				if ( num_team_pipes > ( MAX_WORLD_PIPEBOMBS / number_of_teams ) )
ADDRLP4 4
INDIRI4
ADDRGP4 MAX_WORLD_PIPEBOMBS
INDIRI4
ADDRGP4 number_of_teams
INDIRI4
DIVI4
LEI4 $1062
line 1694
;1694:					ExplodeOldPipebomb( self->team_no, 0 );
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 ExplodeOldPipebomb
CALLV
pop
line 1695
;1695:			}
line 1696
;1696:		} else
ADDRGP4 $1062
JUMPV
LABELV $1061
line 1697
;1697:		{
line 1698
;1698:			increment_team_pipebombs( self->team_no );
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRGP4 increment_team_pipebombs
CALLV
pop
line 1699
;1699:			if ( num_pipes == 0 && tf_data.add_pipe == 1)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1070
ADDRGP4 tf_data+140
INDIRI4
CNSTI4 1
NEI4 $1070
line 1700
;1700:			{
line 1701
;1701:				if ( num_team_pipebombs[0] > MAX_WORLD_PIPEBOMBS + 1 )
ADDRGP4 num_team_pipebombs
INDIRI4
ADDRGP4 MAX_WORLD_PIPEBOMBS
INDIRI4
CNSTI4 1
ADDI4
LEI4 $1071
line 1702
;1702:					ExplodeOldPipebomb( 0, 1 );
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 ExplodeOldPipebomb
CALLV
pop
line 1703
;1703:			} else
ADDRGP4 $1071
JUMPV
LABELV $1070
line 1704
;1704:			{
line 1705
;1705:				if ( num_team_pipebombs[0] > MAX_WORLD_PIPEBOMBS )
ADDRGP4 num_team_pipebombs
INDIRI4
ADDRGP4 MAX_WORLD_PIPEBOMBS
INDIRI4
LEI4 $1075
line 1706
;1706:					ExplodeOldPipebomb( 0, 0 );
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 ExplodeOldPipebomb
CALLV
pop
LABELV $1075
line 1707
;1707:			}
LABELV $1071
line 1708
;1708:		}
LABELV $1062
line 1709
;1709:		newmis->s.v.classname = "pipebomb";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $988
ASGNP4
line 1710
;1710:		newmis->s.v.skin = 2;
ADDRGP4 newmis
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1073741824
ASGNF4
line 1711
;1711:		newmis->s.v.touch = ( func_t ) PipebombTouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 PipebombTouch
CVPU4 4
CVUI4 4
ASGNI4
line 1712
;1712:		newmis->s.v.nextthink = g_globalvars.time + 120;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1713
;1713:		newmis->s.v.weapon = 11;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1093664768
ASGNF4
line 1714
;1714:		newmis->team_no = self->team_no;
ADDRLP4 20
CNSTI4 960
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
INDIRI4
ASGNI4
line 1715
;1715:	}
LABELV $1056
line 1716
;1716:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 1717
;1717:	if ( self->s.v.v_angle[0] )
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1078
line 1718
;1718:	{
line 1719
;1719:		if ( self->option != OPT_LRG )
ADDRGP4 self
INDIRP4
CNSTI4 1780
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1080
line 1720
;1720:		{
line 1721
;1721:			newmis->s.v.velocity[0] =
ADDRLP4 16
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 20
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1142292480
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
CNSTF4 1128792064
ADDRGP4 g_globalvars+240
INDIRF4
MULF4
ADDF4
CNSTF4 1092616192
ADDRLP4 16
INDIRF4
ADDRGP4 g_globalvars+252
INDIRF4
MULF4
MULF4
ADDF4
CNSTF4 1092616192
ADDRLP4 20
INDIRF4
ADDRGP4 g_globalvars+240
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1724
;1722:			    g_globalvars.v_forward[0] * 600 + g_globalvars.v_up[0] * 200 +
;1723:			    crandom(  ) * g_globalvars.v_right[0] * 10 + crandom(  ) * g_globalvars.v_up[0] * 10;
;1724:			newmis->s.v.velocity[1] =
ADDRLP4 24
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 28
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1142292480
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
CNSTF4 1128792064
ADDRGP4 g_globalvars+240+4
INDIRF4
MULF4
ADDF4
CNSTF4 1092616192
ADDRLP4 24
INDIRF4
ADDRGP4 g_globalvars+252+4
INDIRF4
MULF4
MULF4
ADDF4
CNSTF4 1092616192
ADDRLP4 28
INDIRF4
ADDRGP4 g_globalvars+240+4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1727
;1725:			    g_globalvars.v_forward[1] * 600 + g_globalvars.v_up[1] * 200 +
;1726:			    crandom(  ) * g_globalvars.v_right[1] * 10 + crandom(  ) * g_globalvars.v_up[1] * 10;
;1727:			newmis->s.v.velocity[2] =
ADDRLP4 32
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 36
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1142292480
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
CNSTF4 1128792064
ADDRGP4 g_globalvars+240+8
INDIRF4
MULF4
ADDF4
CNSTF4 1092616192
ADDRLP4 32
INDIRF4
ADDRGP4 g_globalvars+252+8
INDIRF4
MULF4
MULF4
ADDF4
CNSTF4 1092616192
ADDRLP4 36
INDIRF4
ADDRGP4 g_globalvars+240
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1730
;1728:			    g_globalvars.v_forward[2] * 600 + g_globalvars.v_up[2] * 200 +
;1729:			    crandom(  ) * g_globalvars.v_right[2] * 10 + crandom(  ) * g_globalvars.v_up[0] * 10;
;1730:		}
ADDRGP4 $1079
JUMPV
LABELV $1080
line 1732
;1731:		else
;1732:		{
line 1733
;1733:			newmis->s.v.velocity[0] =
ADDRLP4 16
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 20
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1150681088
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
CNSTF4 1128792064
ADDRGP4 g_globalvars+240
INDIRF4
MULF4
ADDF4
CNSTF4 1092616192
ADDRLP4 16
INDIRF4
ADDRGP4 g_globalvars+252
INDIRF4
MULF4
MULF4
ADDF4
CNSTF4 1092616192
ADDRLP4 20
INDIRF4
ADDRGP4 g_globalvars+240
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1736
;1734:			    g_globalvars.v_forward[0] * 1200 + g_globalvars.v_up[0] * 200 +
;1735:			    crandom(  ) * g_globalvars.v_right[0] * 10 + crandom(  ) * g_globalvars.v_up[0] * 10;
;1736:			newmis->s.v.velocity[1] =
ADDRLP4 24
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 28
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1150681088
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
CNSTF4 1128792064
ADDRGP4 g_globalvars+240+4
INDIRF4
MULF4
ADDF4
CNSTF4 1092616192
ADDRLP4 24
INDIRF4
ADDRGP4 g_globalvars+252+4
INDIRF4
MULF4
MULF4
ADDF4
CNSTF4 1092616192
ADDRLP4 28
INDIRF4
ADDRGP4 g_globalvars+240+4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1739
;1737:			    g_globalvars.v_forward[1] * 1200 + g_globalvars.v_up[1] * 200 +
;1738:			    crandom(  ) * g_globalvars.v_right[1] * 10 + crandom(  ) * g_globalvars.v_up[1] * 10;
;1739:			newmis->s.v.velocity[2] =
ADDRLP4 32
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 36
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1150681088
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
CNSTF4 1128792064
ADDRGP4 g_globalvars+240+8
INDIRF4
MULF4
ADDF4
CNSTF4 1092616192
ADDRLP4 32
INDIRF4
ADDRGP4 g_globalvars+252+8
INDIRF4
MULF4
MULF4
ADDF4
CNSTF4 1092616192
ADDRLP4 36
INDIRF4
ADDRGP4 g_globalvars+240
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1743
;1740:			    g_globalvars.v_forward[2] * 1200 + g_globalvars.v_up[2] * 200 +
;1741:			    crandom(  ) * g_globalvars.v_right[2] * 10 + crandom(  ) * g_globalvars.v_up[0] * 10;
;1742:
;1743:		}
line 1744
;1744:	} else
ADDRGP4 $1079
JUMPV
LABELV $1078
line 1745
;1745:	{
line 1746
;1746:		aim( newmis->s.v.velocity );	// = aim(self, 10000);
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 aim
CALLV
pop
line 1747
;1747:		if ( self->option == OPT_LRG )
ADDRGP4 self
INDIRP4
CNSTI4 1780
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1120
line 1748
;1748:			VectorScale( newmis->s.v.velocity, 1200, newmis->s.v.velocity );
ADDRLP4 16
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 1150681088
ARGF4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
ADDRGP4 $1121
JUMPV
LABELV $1120
line 1750
;1749:		else
;1750:			VectorScale( newmis->s.v.velocity, 600, newmis->s.v.velocity );	// * 600;
ADDRLP4 20
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1142292480
ARGF4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
LABELV $1121
line 1751
;1751:		newmis->s.v.velocity[2] = 200;
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1128792064
ASGNF4
line 1752
;1752:	}
LABELV $1079
line 1753
;1753:	SetVector( newmis->s.v.avelocity, 300, 300, 300 );
ADDRGP4 newmis
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1133903872
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
CNSTF4 1133903872
ASGNF4
line 1754
;1754:	vectoangles( newmis->s.v.velocity, newmis->s.v.angles );
ADDRLP4 16
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1755
;1755:	newmis->s.v.think = ( func_t ) GrenadeExplode;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 GrenadeExplode
CVPU4 4
CVUI4 4
ASGNI4
line 1756
;1756:	if ( tf_data.birthday == 1 && g_random(  ) < 0.2 )
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $1122
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 1045220557
GEF4 $1122
line 1757
;1757:		setmodel( newmis, "progs/grenade3.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $1125
ARGP4
ADDRGP4 setmodel
CALLV
pop
ADDRGP4 $1123
JUMPV
LABELV $1122
line 1759
;1758:	else
;1759:		setmodel( newmis, "progs/grenade2.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $1126
ARGP4
ADDRGP4 setmodel
CALLV
pop
LABELV $1123
line 1760
;1760:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1761
;1761:	setorigin( newmis, PASSVEC3( self->s.v.origin ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 1762
;1762:}
LABELV $1048
endproc W_FireGrenade 40 28
export launch_spike
proc launch_spike 12 28
line 1778
;1763:
;1764:
;1765://=============================================================================
;1766:
;1767:void    spike_touch(  );
;1768:void    superspike_touch(  );
;1769:
;1770:/*
;1771:===============
;1772:launch_spike
;1773:
;1774:Used for both the player and the traps
;1775:===============
;1776:*/
;1777:void launch_spike( vec3_t org, vec3_t dir )
;1778:{
line 1779
;1779:	newmis = spawn(  );
ADDRLP4 0
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 0
INDIRP4
ASGNP4
line 1780
;1780:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1781
;1781:	newmis->voided = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 0
ASGNI4
line 1782
;1782:	newmis->s.v.owner = EDICT_TO_PROG( self );
ADDRGP4 newmis
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
line 1783
;1783:	newmis->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 1784
;1784:	newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 1786
;1785:
;1786:	vectoangles( dir, newmis->s.v.angles );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 newmis
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1788
;1787:
;1788:	newmis->s.v.touch = ( func_t ) spike_touch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 spike_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1789
;1789:	newmis->s.v.weapon = 3;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1077936128
ASGNF4
line 1790
;1790:	newmis->s.v.classname = "spike";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $1129
ASGNP4
line 1791
;1791:	newmis->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 1792
;1792:	newmis->s.v.nextthink = g_globalvars.time + 6;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1086324736
ADDF4
ASGNF4
line 1793
;1793:	setmodel( newmis, "progs/spike.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $1131
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1794
;1794:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1795
;1795:	setorigin( newmis, PASSVEC3( org ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 1796
;1796:	VectorScale( dir, 2000, newmis->s.v.velocity );
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1157234688
ARGF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1797
;1797:}
LABELV $1127
endproc launch_spike 12 28
export W_FireSuperSpikes
proc W_FireSuperSpikes 44 28
line 1800
;1798:
;1799:void W_FireSuperSpikes(  )
;1800:{
line 1803
;1801:	vec3_t  dir, tmp;
;1802:
;1803:	sound( self, CHAN_WEAPON, "weapons/spike2.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $19
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
line 1804
;1804:	if ( !tg_data.unlimit_ammo  )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $1133
line 1805
;1805:		self->s.v.currentammo = self->s.v.ammo_nails = self->s.v.ammo_nails - 4;
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
INDIRF4
CNSTF4 1082130432
SUBF4
ASGNF4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 28
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
LABELV $1133
line 1806
;1806:	aim( dir );		//dir = aim (self, 1000);
ADDRLP4 12
ARGP4
ADDRGP4 aim
CALLV
pop
line 1808
;1807:
;1808:	VectorCopy( self->s.v.origin, tmp );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 1809
;1809:	tmp[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1810
;1810:	launch_spike( tmp, dir );
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 launch_spike
CALLV
pop
line 1811
;1811:	newmis->s.v.touch = ( func_t ) superspike_touch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 superspike_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1812
;1812:	newmis->s.v.weapon = 4;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1082130432
ASGNF4
line 1813
;1813:	setmodel( newmis, "progs/s_spike.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $1139
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1814
;1814:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 40
CNSTF4 0
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1815
;1815:	KickPlayer( -2, self );
CNSTI4 -2
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1816
;1816:}
LABELV $1132
endproc W_FireSuperSpikes 44 28
export W_FireMTFSpikes
proc W_FireMTFSpikes 44 20
line 1819
;1817:
;1818:void W_FireMTFSpikes( float ox )
;1819:{
line 1822
;1820:	vec3_t  dir, tmp;
;1821:
;1822:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 1823
;1823:	if ( self->s.v.ammo_nails >= 1 && self->current_weapon == WEAP_SUPER_NAILGUN )
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $1141
ADDRLP4 24
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 1024
NEI4 $1141
line 1824
;1824:	{
line 1825
;1825:		sound (self, 1, "effects/mortar.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $52
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
line 1826
;1826:		mtf_deathmsg( 4 );
CNSTF4 1082130432
ARGF4
ADDRGP4 mtf_deathmsg
CALLV
pop
line 1828
;1827:		//deathmsg = 4;
;1828:		Attack_Finished ( 0.1 );
CNSTF4 1036831949
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 1831
;1829://		self.ammo_nails = (self.ammo_nails - 2);
;1830://		self.currentammo = (self.ammo_nails - 1);
;1831:		self->s.v.currentammo = self->s.v.ammo_nails = self->s.v.ammo_nails - 2;
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 32
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
line 1832
;1832:		aim( dir );
ADDRLP4 12
ARGP4
ADDRGP4 aim
CALLV
pop
line 1833
;1833:		FireSniperBullet ( dir, 10 );
ADDRLP4 12
ARGP4
CNSTF4 1092616192
ARGF4
ADDRGP4 FireSniperBullet
CALLV
pop
line 1834
;1834:		KickPlayer (-4, self);
CNSTI4 -4
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1835
;1835:		return;
ADDRGP4 $1140
JUMPV
LABELV $1141
line 1837
;1836:	}
;1837:	if ( self->s.v.ammo_nails < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1143
line 1838
;1838:	{
line 1839
;1839:		self->last_weapon = self->current_weapon;
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1036
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
line 1840
;1840:		self->last_weaponmode = self->weaponmode;
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 1040
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
ASGNI4
line 1841
;1841:		self->current_weapon = W_BestWeapon(  );
ADDRLP4 36
ADDRGP4 W_BestWeapon
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 1842
;1842:		W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 1843
;1843:		W_PrintWeaponMessage(  );
ADDRGP4 W_PrintWeaponMessage
CALLV
pop
line 1844
;1844:		return;
ADDRGP4 $1140
JUMPV
LABELV $1143
line 1846
;1845:	}
;1846:	sound( self, 1, "weapons/sniper.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $36
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
line 1847
;1847:	if ( self->s.v.ammo_nails == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $1145
line 1848
;1848:	{
line 1849
;1849:		if ( !tg_data.unlimit_ammo  )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $1146
line 1850
;1850:			self->s.v.currentammo = self->s.v.ammo_nails = self->s.v.ammo_nails - 1;
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 32
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
line 1851
;1851:	} else
ADDRGP4 $1146
JUMPV
LABELV $1145
line 1852
;1852:	{
line 1853
;1853:		if ( !tg_data.unlimit_ammo  )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $1150
line 1854
;1854:			self->s.v.currentammo = self->s.v.ammo_nails = self->s.v.ammo_nails - 1;
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 32
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
LABELV $1150
line 1855
;1855:	}
LABELV $1146
line 1856
;1856:	aim( dir );		// dir = aim (self, 1000);
ADDRLP4 12
ARGP4
ADDRGP4 aim
CALLV
pop
line 1857
;1857:	VectorScale( g_globalvars.v_right, ox, tmp );
ADDRGP4 g_globalvars+252
ARGP4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1858
;1858:	VectorAdd( tmp, self->s.v.origin, tmp );
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
line 1859
;1859:	tmp[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1861
;1860:	//launch_spike( tmp, dir );
;1861:	Attack_Finished (0.1);
CNSTF4 1036831949
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 1862
;1862:	FireSniperBullet (dir, 4);
ADDRLP4 12
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 FireSniperBullet
CALLV
pop
line 1863
;1863:	KickPlayer( -2, self );
CNSTI4 -2
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1864
;1864:}
LABELV $1140
endproc W_FireMTFSpikes 44 20
export W_FireSpikes
proc W_FireSpikes 44 20
line 1867
;1865:
;1866:void W_FireSpikes( float ox )
;1867:{
line 1870
;1868:	vec3_t  dir, tmp;
;1869:
;1870:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 1871
;1871:	if ( self->s.v.ammo_nails >= 4 && self->current_weapon == WEAP_SUPER_NAILGUN )
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1082130432
LTF4 $1160
ADDRLP4 24
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 1024
NEI4 $1160
line 1872
;1872:	{
line 1873
;1873:		W_FireSuperSpikes(  );
ADDRGP4 W_FireSuperSpikes
CALLV
pop
line 1874
;1874:		return;
ADDRGP4 $1159
JUMPV
LABELV $1160
line 1876
;1875:	}
;1876:	if ( self->s.v.ammo_nails < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1162
line 1877
;1877:	{
line 1878
;1878:		self->last_weapon = self->current_weapon;
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1036
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
line 1879
;1879:		self->last_weaponmode = self->weaponmode;
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 1040
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
ASGNI4
line 1880
;1880:		self->current_weapon = W_BestWeapon(  );
ADDRLP4 36
ADDRGP4 W_BestWeapon
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 1881
;1881:		W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 1882
;1882:		W_PrintWeaponMessage(  );
ADDRGP4 W_PrintWeaponMessage
CALLV
pop
line 1883
;1883:		return;
ADDRGP4 $1159
JUMPV
LABELV $1162
line 1885
;1884:	}
;1885:	sound( self, 1, "weapons/rocket1i.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $13
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
line 1886
;1886:	if ( self->s.v.ammo_nails == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $1164
line 1887
;1887:	{
line 1888
;1888:		if ( !tg_data.unlimit_ammo  )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $1165
line 1889
;1889:			self->s.v.currentammo = self->s.v.ammo_nails = self->s.v.ammo_nails - 1;
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 32
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
line 1890
;1890:	} else
ADDRGP4 $1165
JUMPV
LABELV $1164
line 1891
;1891:	{
line 1892
;1892:		if ( !tg_data.unlimit_ammo  )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $1169
line 1893
;1893:			self->s.v.currentammo = self->s.v.ammo_nails = self->s.v.ammo_nails - 2;
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 32
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
LABELV $1169
line 1894
;1894:	}
LABELV $1165
line 1895
;1895:	aim( dir );		// dir = aim (self, 1000);
ADDRLP4 12
ARGP4
ADDRGP4 aim
CALLV
pop
line 1896
;1896:	VectorScale( g_globalvars.v_right, ox, tmp );
ADDRGP4 g_globalvars+252
ARGP4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1897
;1897:	VectorAdd( tmp, self->s.v.origin, tmp );
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
line 1898
;1898:	tmp[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1899
;1899:	launch_spike( tmp, dir );
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 launch_spike
CALLV
pop
line 1900
;1900:	KickPlayer( -2, self );
CNSTI4 -2
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1901
;1901:}
LABELV $1159
endproc W_FireSpikes 44 20
export spike_touch
proc spike_touch 28 24
line 1906
;1902:
;1903:
;1904:
;1905:void spike_touch(  )
;1906:{
line 1907
;1907:	if ( self->voided )
ADDRGP4 self
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1179
line 1908
;1908:	{
line 1909
;1909:		return;
ADDRGP4 $1178
JUMPV
LABELV $1179
line 1911
;1910:	}
;1911:	self->voided = 1;
ADDRGP4 self
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 1913
;1912:
;1913:	if ( other->s.v.solid == SOLID_TRIGGER )
ADDRGP4 other
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $1181
line 1914
;1914:		return;		// trigger field, do nothing
ADDRGP4 $1178
JUMPV
LABELV $1181
line 1916
;1915:
;1916:	if ( trap_pointcontents( PASSVEC3( self->s.v.origin ) ) == CONTENT_SKY )
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
ADDRLP4 4
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 -6
NEI4 $1183
line 1917
;1917:	{
line 1918
;1918:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1919
;1919:		return;
ADDRGP4 $1178
JUMPV
LABELV $1183
line 1922
;1920:	}
;1921:// hit something that bleeds
;1922:	if ( other->s.v.takedamage )
ADDRGP4 other
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1185
line 1923
;1923:	{
line 1924
;1924:		spawn_touchblood( 9 );
CNSTF4 1091567616
ARGF4
ADDRGP4 spawn_touchblood
CALLV
pop
line 1925
;1925:		tf_data.deathmsg = self->s.v.weapon;
ADDRGP4 tf_data+88
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1926
;1926:		if ( streq( PROG_TO_EDICT( self->s.v.owner )->s.v.classname, "grenade" ) )
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+104
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1035
ARGP4
ADDRLP4 8
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1188
line 1927
;1927:			TF_T_Damage( other, self, PROG_TO_EDICT( PROG_TO_EDICT( self->s.v.owner )->s.v.owner ), 9, 2, 2 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+368
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1091567616
ARGF4
ADDRLP4 16
CNSTI4 2
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
ADDRGP4 $1186
JUMPV
LABELV $1188
line 1929
;1928:		else
;1929:			TF_T_Damage( other, self, PROG_TO_EDICT( self->s.v.owner ), 18, 2, 2 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1099956224
ARGF4
ADDRLP4 24
CNSTI4 2
ASGNI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 1930
;1930:	} else
ADDRGP4 $1186
JUMPV
LABELV $1185
line 1931
;1931:	{
line 1932
;1932:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1933
;1933:		if ( !strcmp( self->s.v.classname, "wizspike" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1196
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1194
line 1934
;1934:			trap_WriteByte( MSG_MULTICAST, TE_WIZSPIKE );
CNSTI4 4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
ADDRGP4 $1195
JUMPV
LABELV $1194
line 1935
;1935:		else if ( !strcmp( self->s.v.classname, "knightspike" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1199
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1197
line 1936
;1936:			trap_WriteByte( MSG_MULTICAST, TE_KNIGHTSPIKE );
CNSTI4 4
ARGI4
CNSTI4 8
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
ADDRGP4 $1198
JUMPV
LABELV $1197
line 1938
;1937:		else
;1938:			trap_WriteByte( MSG_MULTICAST, TE_SPIKE );
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
LABELV $1198
LABELV $1195
line 1939
;1939:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 1940
;1940:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 1941
;1941:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 1942
;1942:		trap_multicast( PASSVEC3( self->s.v.origin ), MULTICAST_PHS );
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
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
line 1943
;1943:	}
LABELV $1186
line 1944
;1944:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1945
;1945:}
LABELV $1178
endproc spike_touch 28 24
export superspike_touch
proc superspike_touch 32 24
line 1948
;1946:
;1947:void superspike_touch(  )
;1948:{
line 1951
;1949:	float   ndmg;
;1950:
;1951:	if ( self->voided )
ADDRGP4 self
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1201
line 1952
;1952:	{
line 1953
;1953:		return;
ADDRGP4 $1200
JUMPV
LABELV $1201
line 1955
;1954:	}
;1955:	self->voided = 1;
ADDRGP4 self
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 1958
;1956:
;1957:
;1958:	if ( other->s.v.solid == SOLID_TRIGGER )
ADDRGP4 other
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $1203
line 1959
;1959:		return;		// trigger field, do nothing
ADDRGP4 $1200
JUMPV
LABELV $1203
line 1961
;1960:
;1961:	if ( trap_pointcontents( PASSVEC3( self->s.v.origin ) ) == CONTENT_SKY )
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 -6
NEI4 $1205
line 1962
;1962:	{
line 1963
;1963:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 1964
;1964:		return;
ADDRGP4 $1200
JUMPV
LABELV $1205
line 1967
;1965:	}
;1966:// hit something that bleeds
;1967:	if ( other->s.v.takedamage )
ADDRGP4 other
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1207
line 1968
;1968:	{
line 1969
;1969:		spawn_touchblood( 18 );
CNSTF4 1099956224
ARGF4
ADDRGP4 spawn_touchblood
CALLV
pop
line 1970
;1970:		tf_data.deathmsg = self->s.v.weapon;
ADDRGP4 tf_data+88
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1971
;1971:		if ( tf_data.deathmsg == DMSG_GREN_NAIL )
ADDRGP4 tf_data+88
INDIRI4
CNSTI4 9
NEI4 $1210
line 1972
;1972:			ndmg = 40;
ADDRLP4 0
CNSTF4 1109393408
ASGNF4
ADDRGP4 $1211
JUMPV
LABELV $1210
line 1974
;1973:		else
;1974:			ndmg = 26;
ADDRLP4 0
CNSTF4 1104150528
ASGNF4
LABELV $1211
line 1975
;1975:		if ( streq( PROG_TO_EDICT( self->s.v.owner )->s.v.classname, "grenade" ) )
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+104
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1035
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1213
line 1976
;1976:			TF_T_Damage( other, self, PROG_TO_EDICT( PROG_TO_EDICT( self->s.v.owner )->s.v.owner ), ndmg, 2, 2 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+368
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 20
CNSTI4 2
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
ADDRGP4 $1208
JUMPV
LABELV $1213
line 1978
;1977:		else
;1978:			TF_T_Damage( other, self, PROG_TO_EDICT( self->s.v.owner ), ndmg, 2, 2 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 28
CNSTI4 2
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 1979
;1979:	} else
ADDRGP4 $1208
JUMPV
LABELV $1207
line 1980
;1980:	{
line 1981
;1981:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1982
;1982:		trap_WriteByte( MSG_MULTICAST, TE_SUPERSPIKE );
CNSTI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1983
;1983:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 1984
;1984:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 1985
;1985:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 1986
;1986:		trap_multicast( PASSVEC3( self->s.v.origin ), MULTICAST_PHS );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
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
line 1987
;1987:	}
LABELV $1208
line 1988
;1988:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1989
;1989:}
LABELV $1200
endproc superspike_touch 32 24
export W_SetCurrentAmmo
proc W_SetCurrentAmmo 164 0
line 2000
;1990:
;1991:/*
;1992:===============================================================================
;1993:
;1994:PLAYER WEAPON USE
;1995:
;1996:===============================================================================
;1997:*/
;1998:
;1999:void W_SetCurrentAmmo(  )
;2000:{
line 2003
;2001:	int     items;
;2002:
;2003:	if ( self->s.v.health <= 0 || !self->current_weapon )
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $1222
ADDRLP4 4
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1220
LABELV $1222
line 2004
;2004:		return;
ADDRGP4 $1219
JUMPV
LABELV $1220
line 2005
;2005:	if ( self->current_weapon == WEAP_ASSAULT_CANNON && ( self->tfstate & TFSTATE_AIMING ) )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 32768
NEI4 $1223
ADDRLP4 8
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1223
line 2006
;2006:		return;
ADDRGP4 $1219
JUMPV
LABELV $1223
line 2007
;2007:	player_run(  );
ADDRGP4 player_run
CALLV
pop
line 2008
;2008:	items = self->s.v.items;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2009
;2009:	items -= items & ( IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS );
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 3840
BANDI4
SUBI4
ASGNI4
line 2010
;2010:	self->s.v.weapon = 0;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 0
ASGNF4
line 2011
;2011:	switch ( self->current_weapon )
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
CNSTI4 2048
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1252
ADDRLP4 16
INDIRI4
ADDRLP4 24
INDIRI4
GTI4 $1300
LABELV $1299
ADDRLP4 32
CNSTI4 64
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $1274
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRI4
GTI4 $1302
LABELV $1301
ADDRLP4 40
CNSTI4 16
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $1228
ADDRLP4 16
INDIRI4
ADDRLP4 40
INDIRI4
GTI4 $1304
LABELV $1303
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $1225
ADDRLP4 16
INDIRI4
CNSTI4 8
GTI4 $1225
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1305-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1305
address $1232
address $1289
address $1225
address $1287
address $1225
address $1225
address $1225
address $1234
code
LABELV $1304
ADDRLP4 16
INDIRI4
CNSTI4 32
EQI4 $1270
ADDRGP4 $1225
JUMPV
LABELV $1302
ADDRLP4 52
CNSTI4 256
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $1240
ADDRLP4 16
INDIRI4
ADDRLP4 52
INDIRI4
GTI4 $1308
LABELV $1307
ADDRLP4 16
INDIRI4
CNSTI4 128
EQI4 $1236
ADDRGP4 $1225
JUMPV
LABELV $1308
ADDRLP4 60
CNSTI4 512
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $1244
ADDRLP4 16
INDIRI4
ADDRLP4 60
INDIRI4
LTI4 $1225
LABELV $1309
ADDRLP4 16
INDIRI4
CNSTI4 1024
EQI4 $1248
ADDRGP4 $1225
JUMPV
LABELV $1300
ADDRLP4 68
CNSTI4 32768
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $1277
ADDRLP4 16
INDIRI4
ADDRLP4 68
INDIRI4
GTI4 $1311
LABELV $1310
ADDRLP4 76
CNSTI4 8192
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 76
INDIRI4
EQI4 $1259
ADDRLP4 16
INDIRI4
ADDRLP4 76
INDIRI4
GTI4 $1313
LABELV $1312
ADDRLP4 16
INDIRI4
CNSTI4 4096
EQI4 $1281
ADDRGP4 $1225
JUMPV
LABELV $1313
ADDRLP4 16
INDIRI4
CNSTI4 16384
EQI4 $1284
ADDRGP4 $1225
JUMPV
LABELV $1311
ADDRLP4 84
CNSTI4 262144
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 84
INDIRI4
EQI4 $1291
ADDRLP4 16
INDIRI4
ADDRLP4 84
INDIRI4
GTI4 $1315
LABELV $1314
ADDRLP4 16
INDIRI4
CNSTI4 65536
EQI4 $1266
ADDRGP4 $1225
JUMPV
LABELV $1315
ADDRLP4 92
CNSTI4 524288
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 92
INDIRI4
EQI4 $1294
ADDRLP4 16
INDIRI4
ADDRLP4 92
INDIRI4
LTI4 $1225
LABELV $1316
ADDRLP4 16
INDIRI4
CNSTI4 1048576
EQI4 $1263
ADDRGP4 $1225
JUMPV
line 2012
;2012:	{
LABELV $1228
line 2014
;2013:	case WEAP_AXE:
;2014:		self->s.v.currentammo = 0;
ADDRGP4 self
INDIRP4
CNSTI4 316
ADDP4
CNSTF4 0
ASGNF4
line 2017
;2015://		if ( self->playerclass == PC_SPY )
;2016://		{
;2017:			if ( !self->weaponmode )
ADDRGP4 self
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1229
line 2018
;2018:				self->s.v.weaponmodel = "progs/v_knife.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1231
ASGNP4
ADDRGP4 $1230
JUMPV
LABELV $1229
line 2020
;2019:			else
;2020:				self->s.v.weaponmodel = "progs/v_knife2.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $182
ASGNP4
LABELV $1230
line 2023
;2021://		} else
;2022://			self->s.v.weaponmodel = "progs/v_axe.mdl";
;2023:		self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2025
;2024:
;2025:		break;
ADDRGP4 $1226
JUMPV
LABELV $1232
line 2027
;2026:	case WEAP_HOOK:
;2027:		self->s.v.currentammo = self->s.v.ammo_cells/*0*/;
ADDRLP4 96
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 96
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ASGNF4
line 2028
;2028:		self->s.v.weaponmodel = "progs/v_grap.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1233
ASGNP4
line 2029
;2029:		self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2030
;2030:		break;
ADDRGP4 $1226
JUMPV
LABELV $1234
line 2032
;2031:	case WEAP_SPANNER:
;2032:		self->s.v.currentammo = self->s.v.ammo_cells;
ADDRLP4 100
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 100
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ASGNF4
line 2033
;2033:		self->s.v.weaponmodel = "progs/v_span.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1235
ASGNP4
line 2034
;2034:		self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2035
;2035:		break;
ADDRGP4 $1226
JUMPV
LABELV $1236
line 2037
;2036:	case WEAP_SHOTGUN:
;2037:		self->s.v.currentammo = self->s.v.ammo_shells;
ADDRLP4 104
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 104
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ASGNF4
line 2038
;2038:		items |= 2048;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 2039
;2039:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1237
line 2040
;2040:		{
line 2041
;2041:			self->s.v.weaponmodel = "progs/v_shot.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1239
ASGNP4
line 2042
;2042:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2043
;2043:		}
LABELV $1237
line 2044
;2044:		items |= 256;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2045
;2045:		self->s.v.weapon = 1;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1065353216
ASGNF4
line 2046
;2046:		break;
ADDRGP4 $1226
JUMPV
LABELV $1240
line 2048
;2047:	case WEAP_SUPER_SHOTGUN:
;2048:		self->s.v.currentammo = self->s.v.ammo_shells;
ADDRLP4 108
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 108
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ASGNF4
line 2049
;2049:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1241
line 2050
;2050:		{
line 2051
;2051:			self->s.v.weaponmodel = "progs/v_shot2.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1243
ASGNP4
line 2052
;2052:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2053
;2053:		}
LABELV $1241
line 2054
;2054:		items |= 256;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2055
;2055:		self->s.v.weapon = 2;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1073741824
ASGNF4
line 2056
;2056:		break;
ADDRGP4 $1226
JUMPV
LABELV $1244
line 2058
;2057:	case WEAP_NAILGUN:
;2058:		self->s.v.currentammo = self->s.v.ammo_nails;
ADDRLP4 112
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 112
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 112
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ASGNF4
line 2059
;2059:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1245
line 2060
;2060:		{
line 2061
;2061:			self->s.v.weaponmodel = "progs/v_nail.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1247
ASGNP4
line 2062
;2062:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2063
;2063:		}
LABELV $1245
line 2064
;2064:		items |= 512;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 2065
;2065:		self->s.v.weapon = 4;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1082130432
ASGNF4
line 2066
;2066:		break;
ADDRGP4 $1226
JUMPV
LABELV $1248
line 2068
;2067:	case WEAP_SUPER_NAILGUN:
;2068:		self->s.v.currentammo = self->s.v.ammo_nails;
ADDRLP4 116
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 116
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ASGNF4
line 2069
;2069:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1249
line 2070
;2070:		{
line 2071
;2071:			self->s.v.weaponmodel = "progs/v_nail2.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1251
ASGNP4
line 2072
;2072:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2073
;2073:		}
LABELV $1249
line 2074
;2074:		items |= 512;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 2075
;2075:		self->s.v.weapon = 8;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1090519040
ASGNF4
line 2076
;2076:		break;
ADDRGP4 $1226
JUMPV
LABELV $1252
line 2078
;2077:	case WEAP_GRENADE_LAUNCHER:
;2078:		self->s.v.currentammo = self->s.v.ammo_rockets;
ADDRLP4 120
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 120
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ASGNF4
line 2079
;2079:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1253
line 2080
;2080:		{
line 2081
;2081:			if ( self->weaponmode == GL_NORMAL )
ADDRGP4 self
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1255
line 2082
;2082:				self->s.v.weaponmodel = "progs/v_rock.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1257
ASGNP4
ADDRGP4 $1256
JUMPV
LABELV $1255
line 2084
;2083:			else
;2084:				self->s.v.weaponmodel = "progs/v_pipe.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1258
ASGNP4
LABELV $1256
line 2085
;2085:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2086
;2086:		}
LABELV $1253
line 2087
;2087:		self->s.v.weapon = 16;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1098907648
ASGNF4
line 2088
;2088:		items |= 1024;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 2089
;2089:		break;
ADDRGP4 $1226
JUMPV
LABELV $1259
line 2091
;2090:	case WEAP_ROCKET_LAUNCHER:
;2091:		self->s.v.currentammo = self->s.v.ammo_rockets;
ADDRLP4 124
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 124
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 124
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ASGNF4
line 2092
;2092:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1260
line 2093
;2093:		{
line 2094
;2094:			self->s.v.weaponmodel = "progs/v_rock2.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1262
ASGNP4
line 2095
;2095:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2096
;2096:		}
LABELV $1260
line 2097
;2097:		items |= 1024;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 2098
;2098:		self->s.v.weapon = 32;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1107296256
ASGNF4
line 2099
;2099:		break;
ADDRGP4 $1226
JUMPV
LABELV $1263
line 2101
;2100:	case WEAP_MAC10:
;2101:		self->s.v.currentammo = self->s.v.ammo_nails;
ADDRLP4 128
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 128
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ASGNF4
line 2102
;2102:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1264
line 2103
;2103:		{
line 2104
;2104:			self->s.v.weaponmodel = "progs/v_mac10.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $84
ASGNP4
line 2105
;2105:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2106
;2106:		}
LABELV $1264
line 2107
;2107:		items |= 512;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 2108
;2108:		self->s.v.weapon = 4;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1082130432
ASGNF4
line 2109
;2109:		break;
ADDRGP4 $1226
JUMPV
LABELV $1266
line 2111
;2110:	case WEAP_LIGHTNING:
;2111:		self->s.v.currentammo = self->s.v.ammo_cells;
ADDRLP4 132
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 132
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ASGNF4
line 2112
;2112:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1267
line 2113
;2113:		{
line 2114
;2114:			self->s.v.weaponmodel = "progs/v_light.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1269
ASGNP4
line 2115
;2115:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2116
;2116:		}
LABELV $1267
line 2117
;2117:		items |= 2048;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 2118
;2118:		self->s.v.weapon = 64;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1115684864
ASGNF4
line 2119
;2119:		break;
ADDRGP4 $1226
JUMPV
LABELV $1270
line 2121
;2120:	case WEAP_SNIPER_RIFLE:
;2121:		self->s.v.currentammo = self->s.v.ammo_shells;
ADDRLP4 136
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 136
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ASGNF4
line 2122
;2122:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1271
line 2123
;2123:		{
line 2124
;2124:			self->s.v.weaponmodel = "progs/v_srifle.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1273
ASGNP4
line 2125
;2125:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2126
;2126:		}
LABELV $1271
line 2127
;2127:		items |= 256;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2128
;2128:		self->s.v.weapon = 1;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1065353216
ASGNF4
line 2129
;2129:		break;
ADDRGP4 $1226
JUMPV
LABELV $1274
line 2131
;2130:	case WEAP_AUTO_RIFLE:
;2131:		self->s.v.currentammo = self->s.v.ammo_shells;
ADDRLP4 140
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 140
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ASGNF4
line 2132
;2132:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1275
line 2133
;2133:		{
line 2134
;2134:			self->s.v.weaponmodel = "progs/v_srifle.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1273
ASGNP4
line 2135
;2135:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2136
;2136:		}
LABELV $1275
line 2137
;2137:		items |= 256;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2138
;2138:		self->s.v.weapon = 2;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1073741824
ASGNF4
line 2139
;2139:		break;
ADDRGP4 $1226
JUMPV
LABELV $1277
line 2141
;2140:	case WEAP_ASSAULT_CANNON:
;2141:		self->s.v.currentammo = self->s.v.ammo_shells;
ADDRLP4 144
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 144
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ASGNF4
line 2142
;2142:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1278
line 2143
;2143:		{
line 2144
;2144:			self->s.v.weaponmodel = "progs/v_asscan.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1280
ASGNP4
line 2145
;2145:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2146
;2146:		}
LABELV $1278
line 2147
;2147:		items |= 256;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2148
;2148:		self->s.v.weapon = 32;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1107296256
ASGNF4
line 2149
;2149:		break;
ADDRGP4 $1226
JUMPV
LABELV $1281
line 2151
;2150:	case WEAP_FLAMETHROWER:
;2151:		self->s.v.currentammo = self->s.v.ammo_cells;
ADDRLP4 148
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 148
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ASGNF4
line 2152
;2152:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1282
line 2153
;2153:		{
line 2154
;2154:			self->s.v.weaponmodel = "progs/v_flame.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $45
ASGNP4
line 2155
;2155:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2156
;2156:		}
LABELV $1282
line 2157
;2157:		items |= 2048;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 2158
;2158:		self->s.v.weapon = 16;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1098907648
ASGNF4
line 2159
;2159:		break;
ADDRGP4 $1226
JUMPV
LABELV $1284
line 2161
;2160:	case WEAP_INCENDIARY:
;2161:		self->s.v.currentammo = self->s.v.ammo_rockets;
ADDRLP4 152
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 152
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ASGNF4
line 2162
;2162:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1285
line 2163
;2163:		{
line 2164
;2164:			self->s.v.weaponmodel = "progs/v_rock2.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1262
ASGNP4
line 2165
;2165:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2166
;2166:		}
LABELV $1285
line 2167
;2167:		items |= 1024;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 2168
;2168:		self->s.v.weapon = 32;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1107296256
ASGNF4
line 2169
;2169:		break;
ADDRGP4 $1226
JUMPV
LABELV $1287
line 2171
;2170:	case WEAP_MEDIKIT:
;2171:        self->s.v.currentammo = 0;
ADDRGP4 self
INDIRP4
CNSTI4 316
ADDP4
CNSTF4 0
ASGNF4
line 2173
;2172:		//self->s.v.currentammo = self->ammo_medikit;
;2173:		self->s.v.weaponmodel = "progs/v_medi.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1288
ASGNP4
line 2174
;2174:		self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2175
;2175:		break;
ADDRGP4 $1226
JUMPV
LABELV $1289
line 2177
;2176:	case WEAP_BIOWEAPON:
;2177:		self->s.v.currentammo = 0;
ADDRGP4 self
INDIRP4
CNSTI4 316
ADDP4
CNSTF4 0
ASGNF4
line 2178
;2178:		self->s.v.weaponmodel = "progs/v_bio.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1290
ASGNP4
line 2179
;2179:		self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2180
;2180:		break;
ADDRGP4 $1226
JUMPV
LABELV $1291
line 2182
;2181:	case WEAP_TRANQ:
;2182:		self->s.v.currentammo = self->s.v.ammo_shells;
ADDRLP4 156
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 156
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ASGNF4
line 2183
;2183:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1292
line 2184
;2184:		{
line 2185
;2185:			self->s.v.weaponmodel = "progs/v_tgun.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $46
ASGNP4
line 2186
;2186:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2187
;2187:		}
LABELV $1292
line 2188
;2188:		items |= 256;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2189
;2189:		self->s.v.weapon = 1;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1065353216
ASGNF4
line 2190
;2190:		break;
ADDRGP4 $1226
JUMPV
LABELV $1294
line 2192
;2191:	case WEAP_LASER:
;2192:		self->s.v.currentammo = self->s.v.ammo_nails;
ADDRLP4 160
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 160
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ASGNF4
line 2193
;2193:		if ( !( self->tfstate & TFSTATE_RELOADING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1295
line 2194
;2194:		{
line 2195
;2195:			self->s.v.weaponmodel = "progs/v_rail.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1297
ASGNP4
line 2196
;2196:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2197
;2197:		}
LABELV $1295
line 2198
;2198:		items |= 512;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 2199
;2199:		self->s.v.weapon = 1;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1065353216
ASGNF4
line 2200
;2200:		break;
ADDRGP4 $1226
JUMPV
LABELV $1225
line 2202
;2201:	default:
;2202:		self->s.v.currentammo = 0;
ADDRGP4 self
INDIRP4
CNSTI4 316
ADDP4
CNSTF4 0
ASGNF4
line 2203
;2203:		self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1298
ASGNP4
line 2204
;2204:		self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2205
;2205:		break;
LABELV $1226
line 2207
;2206:	}
;2207:	self->s.v.items = items;
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
ADDRLP4 0
INDIRI4
CVIF4 4
ASGNF4
line 2208
;2208:}
LABELV $1219
endproc W_SetCurrentAmmo 164 0
export W_BestWeapon
proc W_BestWeapon 16 0
line 2211
;2209:
;2210:int W_BestWeapon(  )
;2211:{
line 2214
;2212:	int     it;
;2213:
;2214:	it = self->weapons_carried;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ASGNI4
line 2215
;2215:	if ( self->s.v.ammo_cells >= 1 && ( it & WEAP_LIGHTNING ) && self->s.v.waterlevel <= 1 )
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
LTF4 $1318
ADDRLP4 0
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $1318
ADDRLP4 4
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
GTF4 $1318
line 2216
;2216:		return WEAP_LIGHTNING;
CNSTI4 65536
RETI4
ADDRGP4 $1317
JUMPV
LABELV $1318
line 2218
;2217:	else
;2218:	{
line 2219
;2219:		if ( self->s.v.ammo_cells >= 6 && self->s.v.ammo_shells > self->assault_min_shells
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1086324736
LTF4 $1320
ADDRLP4 12
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 1504
ADDP4
INDIRI4
CVIF4 4
LEF4 $1320
ADDRLP4 0
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $1320
line 2221
;2220:		     && ( it & WEAP_ASSAULT_CANNON ) )
;2221:			return WEAP_ASSAULT_CANNON;
CNSTI4 32768
RETI4
ADDRGP4 $1317
JUMPV
LABELV $1320
line 2223
;2222:		else
;2223:		{
line 2224
;2224:			if ( self->s.v.ammo_cells >= 1 && ( it & WEAP_FLAMETHROWER ) )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $1322
ADDRLP4 0
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1322
line 2225
;2225:				return WEAP_FLAMETHROWER;
CNSTI4 4096
RETI4
ADDRGP4 $1317
JUMPV
LABELV $1322
line 2227
;2226:			else
;2227:			{
line 2228
;2228:				if ( self->s.v.ammo_nails >= 2 && ( it & WEAP_SUPER_NAILGUN ) )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1073741824
LTF4 $1324
ADDRLP4 0
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1324
line 2229
;2229:					return WEAP_SUPER_NAILGUN;
CNSTI4 1024
RETI4
ADDRGP4 $1317
JUMPV
LABELV $1324
line 2231
;2230:				else
;2231:				{
line 2232
;2232:					if ( self->s.v.ammo_shells >= 2 && ( it & WEAP_SUPER_SHOTGUN ) )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1073741824
LTF4 $1326
ADDRLP4 0
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1326
line 2233
;2233:						return WEAP_SUPER_SHOTGUN;
CNSTI4 256
RETI4
ADDRGP4 $1317
JUMPV
LABELV $1326
line 2235
;2234:					else
;2235:					{
line 2236
;2236:						if ( self->s.v.ammo_nails >= 1 && ( it & WEAP_LASER ) )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $1328
ADDRLP4 0
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $1328
line 2237
;2237:							return WEAP_LASER;
CNSTI4 524288
RETI4
ADDRGP4 $1317
JUMPV
LABELV $1328
line 2239
;2238:						else
;2239:						{
line 2240
;2240:							if ( self->s.v.ammo_nails >= 1 && ( it & WEAP_NAILGUN ) )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $1330
ADDRLP4 0
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1330
line 2241
;2241:								return WEAP_NAILGUN;
CNSTI4 512
RETI4
ADDRGP4 $1317
JUMPV
LABELV $1330
line 2243
;2242:							else
;2243:							{
line 2244
;2244:								if ( self->s.v.ammo_shells >= 1
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $1332
ADDRLP4 0
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1332
line 2246
;2245:								     && ( it & WEAP_SHOTGUN ) )
;2246:									return WEAP_SHOTGUN;
CNSTI4 128
RETI4
ADDRGP4 $1317
JUMPV
LABELV $1332
line 2248
;2247:								else
;2248:								{
line 2249
;2249:									if ( self->s.v.ammo_shells >= 1
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $1334
ADDRLP4 0
INDIRI4
CNSTI4 262144
BANDI4
CNSTI4 0
EQI4 $1334
line 2251
;2250:									     && ( it & WEAP_TRANQ ) )
;2251:										return WEAP_TRANQ;
CNSTI4 262144
RETI4
ADDRGP4 $1317
JUMPV
LABELV $1334
line 2253
;2252:									else
;2253:									{
line 2254
;2254:										if ( it & WEAP_MEDIKIT )
ADDRLP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1336
line 2255
;2255:											return WEAP_MEDIKIT;
CNSTI4 4
RETI4
ADDRGP4 $1317
JUMPV
LABELV $1336
line 2257
;2256:										else
;2257:										{
line 2258
;2258:											if ( it & WEAP_SPANNER )
ADDRLP4 0
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1338
line 2259
;2259:												return WEAP_SPANNER;
CNSTI4 8
RETI4
ADDRGP4 $1317
JUMPV
LABELV $1338
line 2261
;2260:											else
;2261:											{
line 2262
;2262:												if ( self->s.v.ammo_nails >= 1 && ( it & WEAP_MAC10 ) )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $1340
ADDRLP4 0
INDIRI4
CNSTI4 1048576
BANDI4
CNSTI4 0
EQI4 $1340
line 2263
;2263:													return WEAP_MAC10;
CNSTI4 1048576
RETI4
ADDRGP4 $1317
JUMPV
LABELV $1340
line 2265
;2264:												else
;2265:												{
line 2266
;2266:													if ( it & WEAP_AXE )
ADDRLP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1342
line 2267
;2267:														return WEAP_AXE;
CNSTI4 16
RETI4
ADDRGP4 $1317
JUMPV
LABELV $1342
line 2268
;2268:												}
line 2269
;2269:											}
line 2270
;2270:										}
line 2271
;2271:									}
line 2272
;2272:								}
line 2273
;2273:							}
line 2274
;2274:						}
line 2275
;2275:					}
line 2276
;2276:				}
line 2277
;2277:			}
line 2278
;2278:		}
line 2279
;2279:	}
line 2280
;2280:	return 0;
CNSTI4 0
RETI4
LABELV $1317
endproc W_BestWeapon 16 0
export W_CheckNoAmmo
proc W_CheckNoAmmo 4 0
line 2284
;2281:}
;2282:
;2283:int W_CheckNoAmmo(  )
;2284:{
line 2285
;2285:	if ( self->current_weapon == WEAP_MEDIKIT )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1345
line 2286
;2286:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $1344
JUMPV
LABELV $1345
line 2288
;2287:	else
;2288:	{
line 2289
;2289:		if ( self->current_weapon == WEAP_BIOWEAPON )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1347
line 2290
;2290:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $1344
JUMPV
LABELV $1347
line 2292
;2291:		else
;2292:		{
line 2293
;2293:			if ( self->current_weapon == WEAP_AXE || self->current_weapon == WEAP_HOOK
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
EQI4 $1352
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $1352
ADDRLP4 0
INDIRI4
CNSTI4 8
NEI4 $1349
LABELV $1352
line 2295
;2294:			     || self->current_weapon == WEAP_SPANNER )
;2295:				return 1;
CNSTI4 1
RETI4
ADDRGP4 $1344
JUMPV
LABELV $1349
line 2297
;2296:			else
;2297:			{
line 2298
;2298:				if ( self->current_weapon == WEAP_INCENDIARY )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 16384
NEI4 $1353
line 2299
;2299:				{
line 2300
;2300:					if ( self->s.v.currentammo >= 3 )
ADDRGP4 self
INDIRP4
CNSTI4 316
ADDP4
INDIRF4
CNSTF4 1077936128
LTF4 $1354
line 2301
;2301:						return 1;
CNSTI4 1
RETI4
ADDRGP4 $1344
JUMPV
line 2302
;2302:				} else
LABELV $1353
line 2303
;2303:				{
line 2305
;2304:				
;2305:					if( self->current_weapon == WEAP_SNIPER_RIFLE )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 32
NEI4 $1357
line 2306
;2306:					{
line 2307
;2307:						if ( self->s.v.currentammo >= tf_data.snip_ammo )
ADDRGP4 self
INDIRP4
CNSTI4 316
ADDP4
INDIRF4
ADDRGP4 tf_data+132
INDIRI4
CVIF4 4
LTF4 $1358
line 2308
;2308:							return 1;
CNSTI4 1
RETI4
ADDRGP4 $1344
JUMPV
line 2309
;2309:					}else
LABELV $1357
line 2310
;2310:					{
line 2311
;2311:						if ( self->s.v.currentammo > 0 )
ADDRGP4 self
INDIRP4
CNSTI4 316
ADDP4
INDIRF4
CNSTF4 0
LEF4 $1362
line 2312
;2312:							return 1;
CNSTI4 1
RETI4
ADDRGP4 $1344
JUMPV
LABELV $1362
line 2313
;2313:					}
LABELV $1358
line 2314
;2314:				}
LABELV $1354
line 2315
;2315:			}
line 2316
;2316:		}
line 2317
;2317:	}
line 2318
;2318:	self->current_weapon = W_BestWeapon(  );
ADDRLP4 0
ADDRGP4 W_BestWeapon
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2319
;2319:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 2320
;2320:	W_PrintWeaponMessage(  );
ADDRGP4 W_PrintWeaponMessage
CALLV
pop
line 2321
;2321:	return 0;
CNSTI4 0
RETI4
LABELV $1344
endproc W_CheckNoAmmo 4 0
export W_Reload_shotgun
proc W_Reload_shotgun 16 20
line 2325
;2322:}
;2323:
;2324:void W_Reload_shotgun(  )
;2325:{
line 2326
;2326:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 2328
;2327:
;2328:	owner->tfstate -= ( owner->tfstate & TFSTATE_RELOADING );
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
CNSTI4 2
BANDI4
SUBI4
ASGNI4
line 2329
;2329:	owner->s.v.weaponmodel = "progs/v_shot.mdl";
ADDRLP4 0
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1239
ASGNP4
line 2330
;2330:	sound ( owner, 1, "weapons/pkup.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1365
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
line 2331
;2331:	G_sprint( owner, 0, "finished reloading\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $1366
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2332
;2332:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 2333
;2333:	owner->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2334
;2334:}
LABELV $1364
endproc W_Reload_shotgun 16 20
export W_Reload_super_shotgun
proc W_Reload_super_shotgun 16 20
line 2337
;2335:
;2336:void W_Reload_super_shotgun(  )
;2337:{
line 2338
;2338:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 2340
;2339:
;2340:	owner->tfstate -= ( owner->tfstate & TFSTATE_RELOADING );
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
CNSTI4 2
BANDI4
SUBI4
ASGNI4
line 2341
;2341:	owner->s.v.weaponmodel = "progs/v_shot2.mdl";
ADDRLP4 0
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1243
ASGNP4
line 2342
;2342:	sound ( owner, 1, "weapons/pkup.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1365
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
line 2343
;2343:	G_sprint( owner, 0, "finished reloading\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $1366
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2344
;2344:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 2345
;2345:	owner->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2346
;2346:}
LABELV $1368
endproc W_Reload_super_shotgun 16 20
export W_Reload_grenade_launcher
proc W_Reload_grenade_launcher 16 20
line 2349
;2347:
;2348:void W_Reload_grenade_launcher(  )
;2349:{
line 2350
;2350:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 2352
;2351:
;2352:	owner->tfstate -= ( owner->tfstate & TFSTATE_RELOADING );
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
CNSTI4 2
BANDI4
SUBI4
ASGNI4
line 2353
;2353:	if ( owner->weaponmode == GL_NORMAL )
ADDRLP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1371
line 2354
;2354:		owner->s.v.weaponmodel = "progs/v_rock.mdl";
ADDRLP4 0
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1257
ASGNP4
ADDRGP4 $1372
JUMPV
LABELV $1371
line 2356
;2355:	else
;2356:		owner->s.v.weaponmodel = "progs/v_pipe.mdl";
ADDRLP4 0
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1258
ASGNP4
LABELV $1372
line 2358
;2357:
;2358:	sound( owner, 1, "weapons/rocklr1a.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $94
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
line 2359
;2359:	G_sprint( owner, 0, "finished reloading\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $1366
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2360
;2360:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 2361
;2361:	owner->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2362
;2362:}
LABELV $1370
endproc W_Reload_grenade_launcher 16 20
export W_Reload_rocket_launcher
proc W_Reload_rocket_launcher 16 20
line 2365
;2363:
;2364:void W_Reload_rocket_launcher(  )
;2365:{
line 2366
;2366:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 2368
;2367:
;2368:	owner->tfstate -= ( owner->tfstate & TFSTATE_RELOADING );
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
CNSTI4 2
BANDI4
SUBI4
ASGNI4
line 2369
;2369:	owner->s.v.weaponmodel = "progs/v_rock2.mdl";
ADDRLP4 0
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1262
ASGNP4
line 2370
;2370:	sound ( owner, 1, "weapons/rocklr1a.wav", 1, 1);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $94
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
line 2371
;2371:	G_sprint( owner, 0, "finished reloading\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $1366
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2372
;2372:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 2373
;2373:	owner->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2374
;2374:}
LABELV $1374
endproc W_Reload_rocket_launcher 16 20
export CheckForReload
proc CheckForReload 52 12
line 2377
;2375:
;2376:float CheckForReload(  )
;2377:{
line 2380
;2378:	gedict_t *tWeapon;
;2379:
;2380: 	if( tg_data.disable_reload )
ADDRGP4 tg_data+16
INDIRI4
CNSTI4 0
EQI4 $1377
line 2381
;2381:	{
line 2382
;2382:		self->reload_shotgun = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1060
ADDP4
CNSTI4 0
ASGNI4
line 2383
;2383:		self->reload_super_shotgun = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1064
ADDP4
CNSTI4 0
ASGNI4
line 2384
;2384:		self->reload_grenade_launcher = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1068
ADDP4
CNSTI4 0
ASGNI4
line 2385
;2385:		self->reload_rocket_launcher = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1072
ADDP4
CNSTI4 0
ASGNI4
line 2386
;2386:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $1376
JUMPV
LABELV $1377
line 2389
;2387:	}
;2388:
;2389:	switch ( self->current_weapon )
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
CNSTI4 256
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1390
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
GTI4 $1411
LABELV $1410
ADDRLP4 4
INDIRI4
CNSTI4 128
EQI4 $1383
ADDRGP4 $1380
JUMPV
LABELV $1411
ADDRLP4 20
CNSTI4 2048
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $1398
ADDRLP4 4
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $1380
LABELV $1412
ADDRLP4 4
INDIRI4
CNSTI4 8192
EQI4 $1404
ADDRGP4 $1380
JUMPV
line 2390
;2390:	{
LABELV $1383
line 2392
;2391:	case WEAP_SHOTGUN:
;2392:		if ( self->reload_shotgun >= 8 && self->s.v.ammo_shells > 0 )
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
CNSTI4 8
LTI4 $1381
ADDRLP4 24
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 0
LEF4 $1381
line 2393
;2393:		{
line 2394
;2394:			self->reload_shotgun = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1060
ADDP4
CNSTI4 0
ASGNI4
line 2395
;2395:			if ( self->s.v.ammo_shells < 8 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1090519040
GEF4 $1386
line 2396
;2396:				self->reload_shotgun = 8 - self->s.v.ammo_shells;
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1060
ADDP4
CNSTF4 1090519040
ADDRLP4 28
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
SUBF4
CVFI4 4
ASGNI4
LABELV $1386
line 2397
;2397:			G_sprint( self, 2, "reloading...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1388
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2398
;2398:			self->tfstate = self->tfstate | TFSTATE_RELOADING;
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 2399
;2399:			tWeapon = spawn(  );
ADDRLP4 36
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 2400
;2400:			tWeapon->s.v.owner = EDICT_TO_PROG( self );
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
line 2401
;2401:			tWeapon->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $334
ASGNP4
line 2402
;2402:			tWeapon->s.v.nextthink = g_globalvars.time + 2;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 2403
;2403:			tWeapon->s.v.think = ( func_t ) W_Reload_shotgun;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 W_Reload_shotgun
CVPU4 4
CVUI4 4
ASGNI4
line 2404
;2404:			self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1298
ASGNP4
line 2405
;2405:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2406
;2406:			return 1;
CNSTF4 1065353216
RETF4
ADDRGP4 $1376
JUMPV
line 2408
;2407:		}
;2408:		break;
LABELV $1390
line 2410
;2409:	case WEAP_SUPER_SHOTGUN:
;2410:		if ( self->reload_super_shotgun > 16 )
ADDRGP4 self
INDIRP4
CNSTI4 1064
ADDP4
INDIRI4
CNSTI4 16
LEI4 $1391
line 2411
;2411:			self->reload_super_shotgun = 16;
ADDRGP4 self
INDIRP4
CNSTI4 1064
ADDP4
CNSTI4 16
ASGNI4
LABELV $1391
line 2412
;2412:		if ( self->reload_super_shotgun >= 16 && self->s.v.ammo_shells > 0 )
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1064
ADDP4
INDIRI4
CNSTI4 16
LTI4 $1381
ADDRLP4 28
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 0
LEF4 $1381
line 2413
;2413:		{
line 2414
;2414:			self->reload_super_shotgun = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1064
ADDP4
CNSTI4 0
ASGNI4
line 2415
;2415:			if ( self->s.v.ammo_shells < 16 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1098907648
GEF4 $1395
line 2416
;2416:				self->reload_super_shotgun = 16 - self->s.v.ammo_shells;
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 1064
ADDP4
CNSTF4 1098907648
ADDRLP4 32
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
SUBF4
CVFI4 4
ASGNI4
LABELV $1395
line 2417
;2417:			G_sprint( self, 2, "reloading...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1388
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2418
;2418:			self->tfstate = self->tfstate | TFSTATE_RELOADING;
ADDRLP4 36
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 2419
;2419:			tWeapon = spawn(  );
ADDRLP4 40
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 2420
;2420:			tWeapon->s.v.owner = EDICT_TO_PROG( self );
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
line 2421
;2421:			tWeapon->s.v.nextthink = g_globalvars.time + 3;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 2422
;2422:			tWeapon->s.v.think = ( func_t ) W_Reload_super_shotgun;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 W_Reload_super_shotgun
CVPU4 4
CVUI4 4
ASGNI4
line 2423
;2423:			self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1298
ASGNP4
line 2424
;2424:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2425
;2425:			return 1;
CNSTF4 1065353216
RETF4
ADDRGP4 $1376
JUMPV
line 2427
;2426:		}
;2427:		break;
LABELV $1398
line 2429
;2428:	case WEAP_GRENADE_LAUNCHER:
;2429:		if ( self->reload_grenade_launcher >= 6 && self->s.v.ammo_rockets > 0 )
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 1068
ADDP4
INDIRI4
CNSTI4 6
LTI4 $1381
ADDRLP4 32
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 0
LEF4 $1381
line 2430
;2430:		{
line 2431
;2431:			self->reload_grenade_launcher = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1068
ADDP4
CNSTI4 0
ASGNI4
line 2432
;2432:			if ( self->s.v.ammo_rockets < 6 )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1086324736
GEF4 $1401
line 2433
;2433:				self->reload_grenade_launcher = 6 - self->s.v.ammo_rockets;
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 1068
ADDP4
CNSTF4 1086324736
ADDRLP4 36
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
SUBF4
CVFI4 4
ASGNI4
LABELV $1401
line 2434
;2434:			G_sprint( self, 2, "reloading...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1388
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2435
;2435:			self->tfstate = self->tfstate | TFSTATE_RELOADING;
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 2436
;2436:			tWeapon = spawn(  );
ADDRLP4 44
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 44
INDIRP4
ASGNP4
line 2437
;2437:			tWeapon->s.v.owner = EDICT_TO_PROG( self );
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
line 2438
;2438:			tWeapon->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $334
ASGNP4
line 2439
;2439:			tWeapon->s.v.nextthink = g_globalvars.time + 4;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1082130432
ADDF4
ASGNF4
line 2440
;2440:			tWeapon->s.v.think = ( func_t ) W_Reload_grenade_launcher;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 W_Reload_grenade_launcher
CVPU4 4
CVUI4 4
ASGNI4
line 2441
;2441:			self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1298
ASGNP4
line 2442
;2442:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2443
;2443:			return 1;
CNSTF4 1065353216
RETF4
ADDRGP4 $1376
JUMPV
line 2445
;2444:		}
;2445:		break;
LABELV $1404
line 2447
;2446:	case WEAP_ROCKET_LAUNCHER:
;2447:		if ( self->reload_rocket_launcher >= 4 && self->s.v.ammo_rockets > 0 )
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 1072
ADDP4
INDIRI4
CNSTI4 4
LTI4 $1381
ADDRLP4 36
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 0
LEF4 $1381
line 2448
;2448:		{
line 2449
;2449:			self->reload_rocket_launcher = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1072
ADDP4
CNSTI4 0
ASGNI4
line 2450
;2450:			if ( self->s.v.ammo_rockets < 4 )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1082130432
GEF4 $1407
line 2451
;2451:				self->reload_rocket_launcher = 4 - self->s.v.ammo_rockets;
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 1072
ADDP4
CNSTF4 1082130432
ADDRLP4 40
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
SUBF4
CVFI4 4
ASGNI4
LABELV $1407
line 2452
;2452:			G_sprint( self, 2, "reloading...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1388
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2453
;2453:			self->tfstate = self->tfstate | TFSTATE_RELOADING;
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 2454
;2454:			tWeapon = spawn(  );
ADDRLP4 48
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 48
INDIRP4
ASGNP4
line 2455
;2455:			tWeapon->s.v.owner = EDICT_TO_PROG( self );
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
line 2456
;2456:			tWeapon->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $334
ASGNP4
line 2457
;2457:			tWeapon->s.v.nextthink = g_globalvars.time + 5;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 2458
;2458:			tWeapon->s.v.think = ( func_t ) W_Reload_rocket_launcher;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 W_Reload_rocket_launcher
CVPU4 4
CVUI4 4
ASGNI4
line 2459
;2459:			self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $1298
ASGNP4
line 2460
;2460:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 2461
;2461:			return 1;
CNSTF4 1065353216
RETF4
ADDRGP4 $1376
JUMPV
line 2463
;2462:		}
;2463:		break;
LABELV $1380
LABELV $1381
line 2465
;2464:	}
;2465:	return 0;
CNSTF4 0
RETF4
LABELV $1376
endproc CheckForReload 52 12
export W_Attack
proc W_Attack 216 20
line 2496
;2466:}
;2467:
;2468:
;2469:void    player_axe1(  );
;2470:void    player_axeb1(  );
;2471:void    player_axec1(  );
;2472:void    player_axed1(  );
;2473:void    player_shot1(  );
;2474:void    player_nail1(  );
;2475:void    player_light1(  );
;2476:void    player_rocket1(  );
;2477:void    player_autorifle1(  );
;2478:void    player_assaultcannon1(  );
;2479:void    player_assaultcannonup1(  );
;2480:void    player_assaultcannondown1(  );
;2481:void    player_medikit1(  );
;2482:void    player_medikitb1(  );
;2483:void    player_medikitc1(  );
;2484:void    player_medikitd1(  );
;2485:void    player_bioweapon1(  );
;2486:void    player_bioweaponb1(  );
;2487:void    player_bioweaponc1(  );
;2488:void    player_bioweapond1(  );
;2489:void    player_chain1(  );
;2490:void    player_chain2(  );
;2491:void    player_chain3(  );
;2492:void    player_chain4(  );
;2493:void    player_chain5(  );
;2494:
;2495:void W_Attack(  )
;2496:{
line 2498
;2497:
;2498:	if ( !W_CheckNoAmmo(  ) ) {
ADDRLP4 0
ADDRGP4 W_CheckNoAmmo
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1414
line 2499
;2499:		sound (self, 1, "buttons/switch02.wav", 0.8, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $70
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 2500
;2500:		Attack_Finished (0.05);
CNSTF4 1028443341
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2501
;2501:		return;
ADDRGP4 $1413
JUMPV
LABELV $1414
line 2504
;2502:	}
;2503:	//G_bprint(2,"%s\n",self->s.v.weaponmodel);
;2504:	if ( streq( self->s.v.weaponmodel, "progs/proxgren.mdl" ) ) {
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
INDIRP4
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1416
line 2506
;2505:	//if ( self->s.v.weaponmodel == "progs/proxgren.mdl" ) {
;2506:		Prox ( );
ADDRGP4 Prox
CALLV
pop
line 2507
;2507:		Attack_Finished (0.2);
CNSTF4 1045220557
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2508
;2508:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 2509
;2509:		return;
ADDRGP4 $1413
JUMPV
LABELV $1416
line 2511
;2510:	}
;2511:	if ( self->has_disconnected == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1418
line 2512
;2512:		return;
ADDRGP4 $1413
JUMPV
LABELV $1418
line 2513
;2513:	if ( self->tfstate & TFSTATE_RELOADING ) {
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1420
line 2514
;2514:		sound( self, 1, "weapons/no_ammo.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $101
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 2515
;2515:		Attack_Finished ( 0.2 );
CNSTF4 1045220557
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2516
;2516:		return;
ADDRGP4 $1413
JUMPV
LABELV $1420
line 2518
;2517:	}
;2518:	if ( self->is_undercover || self->undercover_team || self->undercover_skin )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 868
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $1425
ADDRLP4 8
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $1425
ADDRLP4 8
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1422
LABELV $1425
line 2519
;2519:		Spy_RemoveDisguise( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 Spy_RemoveDisguise
CALLV
pop
LABELV $1422
line 2520
;2520:	if ( self->is_squating )
ADDRGP4 self
INDIRP4
CNSTI4 1776
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1426
line 2521
;2521:		unlay ( );
ADDRGP4 unlay
CALLV
pop
LABELV $1426
line 2522
;2522:	makevectors( self->s.v.v_angle );	// calculate forward angle for velocity
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 2523
;2523:	self->show_hostile = g_globalvars.time + 1;	// wake monsters up
ADDRGP4 self
INDIRP4
CNSTI4 784
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2525
;2524:
;2525:	switch ( self->current_weapon )
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
CNSTI4 2048
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1455
ADDRLP4 16
INDIRI4
ADDRLP4 24
INDIRI4
GTI4 $1505
LABELV $1504
ADDRLP4 32
CNSTI4 64
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $1473
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRI4
GTI4 $1507
LABELV $1506
ADDRLP4 40
CNSTI4 16
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $1432
ADDRLP4 16
INDIRI4
ADDRLP4 40
INDIRI4
GTI4 $1509
LABELV $1508
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $1429
ADDRLP4 16
INDIRI4
CNSTI4 8
GTI4 $1429
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1510-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1510
address $1441
address $1494
address $1429
address $1487
address $1429
address $1429
address $1429
address $1440
code
LABELV $1509
ADDRLP4 16
INDIRI4
CNSTI4 32
EQI4 $1467
ADDRGP4 $1429
JUMPV
LABELV $1507
ADDRLP4 52
CNSTI4 256
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $1450
ADDRLP4 16
INDIRI4
ADDRLP4 52
INDIRI4
GTI4 $1513
LABELV $1512
ADDRLP4 16
INDIRI4
CNSTI4 128
EQI4 $1446
ADDRGP4 $1429
JUMPV
LABELV $1513
ADDRLP4 60
CNSTI4 512
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $1454
ADDRLP4 16
INDIRI4
ADDRLP4 60
INDIRI4
LTI4 $1429
LABELV $1514
ADDRLP4 16
INDIRI4
CNSTI4 1024
EQI4 $1454
ADDRGP4 $1429
JUMPV
LABELV $1505
ADDRLP4 68
CNSTI4 32768
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $1474
ADDRLP4 16
INDIRI4
ADDRLP4 68
INDIRI4
GTI4 $1516
LABELV $1515
ADDRLP4 76
CNSTI4 8192
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 76
INDIRI4
EQI4 $1461
ADDRLP4 16
INDIRI4
ADDRLP4 76
INDIRI4
GTI4 $1518
LABELV $1517
ADDRLP4 16
INDIRI4
CNSTI4 4096
EQI4 $1483
ADDRGP4 $1429
JUMPV
LABELV $1518
ADDRLP4 16
INDIRI4
CNSTI4 16384
EQI4 $1486
ADDRGP4 $1429
JUMPV
LABELV $1516
ADDRLP4 84
CNSTI4 262144
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 84
INDIRI4
EQI4 $1501
ADDRLP4 16
INDIRI4
ADDRLP4 84
INDIRI4
GTI4 $1520
LABELV $1519
ADDRLP4 16
INDIRI4
CNSTI4 65536
EQI4 $1465
ADDRGP4 $1429
JUMPV
LABELV $1520
ADDRLP4 92
CNSTI4 524288
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 92
INDIRI4
EQI4 $1502
ADDRLP4 16
INDIRI4
ADDRLP4 92
INDIRI4
LTI4 $1429
LABELV $1521
ADDRLP4 16
INDIRI4
CNSTI4 1048576
EQI4 $1454
ADDRGP4 $1429
JUMPV
line 2526
;2526:	{
LABELV $1432
line 2528
;2527:	case WEAP_AXE:
;2528:		Attack_Finished( 0.5 );
CNSTF4 1056964608
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2529
;2529:		sound( self, 1, "weapons/ax1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1433
ARGP4
ADDRLP4 96
CNSTF4 1065353216
ASGNF4
ADDRLP4 96
INDIRF4
ARGF4
ADDRLP4 96
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2530
;2530:		switch ( ( int ) ( g_random(  ) * 4 ) )
ADDRLP4 104
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 100
CNSTF4 1082130432
ADDRLP4 104
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $1437
ADDRLP4 100
INDIRI4
CNSTI4 1
EQI4 $1438
ADDRLP4 100
INDIRI4
CNSTI4 2
EQI4 $1439
ADDRGP4 $1434
JUMPV
line 2531
;2531:		{
LABELV $1437
line 2533
;2532:		case 0:
;2533:			player_axe1(  );
ADDRGP4 player_axe1
CALLV
pop
line 2534
;2534:			break;
ADDRGP4 $1430
JUMPV
LABELV $1438
line 2536
;2535:		case 1:
;2536:			player_axeb1(  );
ADDRGP4 player_axeb1
CALLV
pop
line 2537
;2537:			break;
ADDRGP4 $1430
JUMPV
LABELV $1439
line 2539
;2538:		case 2:
;2539:			player_axec1(  );
ADDRGP4 player_axec1
CALLV
pop
line 2540
;2540:			break;
ADDRGP4 $1430
JUMPV
LABELV $1434
line 2542
;2541:		default:
;2542:			player_axed1(  );
ADDRGP4 player_axed1
CALLV
pop
line 2543
;2543:			break;
line 2545
;2544:		}
;2545:		break;
ADDRGP4 $1430
JUMPV
LABELV $1440
line 2547
;2546:	case WEAP_SPANNER:
;2547:		Attack_Finished( 0.5 );
CNSTF4 1056964608
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2548
;2548:		sound( self, 1, "weapons/ax1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1433
ARGP4
ADDRLP4 112
CNSTF4 1065353216
ASGNF4
ADDRLP4 112
INDIRF4
ARGF4
ADDRLP4 112
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2549
;2549:		player_axe1(  );
ADDRGP4 player_axe1
CALLV
pop
line 2550
;2550:		break;
ADDRGP4 $1430
JUMPV
LABELV $1441
line 2552
;2551:	case WEAP_HOOK:
;2552:		if ( !self->hook_out &&  self->s.v.ammo_cells > 24 && !self->is_feigning )
ADDRLP4 116
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 120
CNSTI4 0
ASGNI4
ADDRLP4 116
INDIRP4
CNSTI4 1436
ADDP4
INDIRI4
ADDRLP4 120
INDIRI4
NEI4 $1442
ADDRLP4 116
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1103101952
LEF4 $1442
ADDRLP4 116
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
ADDRLP4 120
INDIRI4
NEI4 $1442
line 2553
;2553:		{
line 2554
;2554:			player_chain1(  );
ADDRGP4 player_chain1
CALLV
pop
line 2555
;2555:			self->immune_to_check = g_globalvars.time + 4;
ADDRGP4 self
INDIRP4
CNSTI4 1080
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1082130432
ADDF4
ASGNF4
line 2556
;2556:			sound( self, 1, "weapons/sniper.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $36
ARGP4
ADDRLP4 124
CNSTF4 1065353216
ASGNF4
ADDRLP4 124
INDIRF4
ARGF4
ADDRLP4 124
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2557
;2557:			sound( self, 3, "weapons/unreel.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $93
ARGP4
ADDRLP4 128
CNSTF4 1065353216
ASGNF4
ADDRLP4 128
INDIRF4
ARGF4
ADDRLP4 128
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2558
;2558:			Attack_Finished( 0.1 );
CNSTF4 1036831949
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2559
;2559:		}
ADDRGP4 $1430
JUMPV
LABELV $1442
line 2561
;2560:		else
;2561:		{
line 2562
;2562:			G_sprint( self, 2, "Not enough power cells...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1445
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2563
;2563:			Attack_Finished( 1.0 );
CNSTF4 1065353216
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2564
;2564:		}
line 2565
;2565:		break;
ADDRGP4 $1430
JUMPV
LABELV $1446
line 2567
;2566:	case WEAP_SHOTGUN:
;2567:		if ( CheckForReload(  ) == 1 )
ADDRLP4 124
ADDRGP4 CheckForReload
CALLF4
ASGNF4
ADDRLP4 124
INDIRF4
CNSTF4 1065353216
NEF4 $1447
line 2568
;2568:			return;
ADDRGP4 $1413
JUMPV
LABELV $1447
line 2569
;2569:		player_shot1(  );
ADDRGP4 player_shot1
CALLV
pop
line 2570
;2570:		W_FireShotgun(  );
ADDRGP4 W_FireShotgun
CALLV
pop
line 2571
;2571:		self->reload_shotgun += 1;
ADDRLP4 128
ADDRGP4 self
INDIRP4
CNSTI4 1060
ADDP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2572
;2572:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2573
;2573:		CheckForReload(  );
ADDRGP4 CheckForReload
CALLF4
pop
line 2574
;2574:		Attack_Finished( 0.5 );
CNSTF4 1056964608
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2575
;2575:		break;
ADDRGP4 $1430
JUMPV
LABELV $1450
line 2577
;2576:	case WEAP_SUPER_SHOTGUN:
;2577:		if ( CheckForReload(  ) == 1 )
ADDRLP4 132
ADDRGP4 CheckForReload
CALLF4
ASGNF4
ADDRLP4 132
INDIRF4
CNSTF4 1065353216
NEF4 $1451
line 2578
;2578:			return;
ADDRGP4 $1413
JUMPV
LABELV $1451
line 2579
;2579:		player_shot1(  );
ADDRGP4 player_shot1
CALLV
pop
line 2580
;2580:		W_FireSuperShotgun(  );
ADDRGP4 W_FireSuperShotgun
CALLV
pop
line 2581
;2581:		self->reload_super_shotgun += 2;
ADDRLP4 136
ADDRGP4 self
INDIRP4
CNSTI4 1064
ADDP4
ASGNP4
ADDRLP4 136
INDIRP4
ADDRLP4 136
INDIRP4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 2582
;2582:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2583
;2583:		CheckForReload(  );
ADDRGP4 CheckForReload
CALLF4
pop
line 2584
;2584:		Attack_Finished( 0.7 );
CNSTF4 1060320051
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2585
;2585:		break;
ADDRGP4 $1430
JUMPV
LABELV $1454
line 2592
;2586:	case WEAP_NAILGUN:
;2587:/*	case WEAP_SUPER_NAILGUN:
;2588:		player_nail1(  );
;2589:		break;*/
;2590:	case WEAP_MAC10:
;2591:	case WEAP_SUPER_NAILGUN:
;2592:		player_mtf_nail1(  );
ADDRGP4 player_mtf_nail1
CALLV
pop
line 2593
;2593:		break;
ADDRGP4 $1430
JUMPV
LABELV $1455
line 2595
;2594:	case WEAP_GRENADE_LAUNCHER:
;2595:		if ( CheckForReload(  ) == 1 )
ADDRLP4 140
ADDRGP4 CheckForReload
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1065353216
NEF4 $1456
line 2596
;2596:			return;
ADDRGP4 $1413
JUMPV
LABELV $1456
line 2597
;2597:		player_rocket1(  );
ADDRGP4 player_rocket1
CALLV
pop
line 2598
;2598:		W_FireGrenade(  );
ADDRGP4 W_FireGrenade
CALLV
pop
line 2599
;2599:		if ( self->option == OPT_LRG )
ADDRGP4 self
INDIRP4
CNSTI4 1780
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1458
line 2600
;2600:			self->reload_grenade_launcher += 2;
ADDRLP4 144
ADDRGP4 self
INDIRP4
CNSTI4 1068
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
ADDRGP4 $1459
JUMPV
LABELV $1458
line 2602
;2601:		else
;2602:			self->reload_grenade_launcher += 1;
ADDRLP4 148
ADDRGP4 self
INDIRP4
CNSTI4 1068
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1459
line 2603
;2603:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2604
;2604:		CheckForReload(  );
ADDRGP4 CheckForReload
CALLF4
pop
line 2605
;2605:		Attack_Finished( 0.6 );
CNSTF4 1058642330
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2606
;2606:		break;
ADDRGP4 $1430
JUMPV
LABELV $1461
line 2608
;2607:	case WEAP_ROCKET_LAUNCHER:
;2608:		if ( CheckForReload(  ) == 1 )
ADDRLP4 152
ADDRGP4 CheckForReload
CALLF4
ASGNF4
ADDRLP4 152
INDIRF4
CNSTF4 1065353216
NEF4 $1462
line 2609
;2609:			return;
ADDRGP4 $1413
JUMPV
LABELV $1462
line 2610
;2610:		player_rocket1(  );
ADDRGP4 player_rocket1
CALLV
pop
line 2611
;2611:		W_FireRocket(  );
ADDRGP4 W_FireRocket
CALLV
pop
line 2612
;2612:		self->reload_rocket_launcher += 1;
ADDRLP4 156
ADDRGP4 self
INDIRP4
CNSTI4 1072
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2613
;2613:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2614
;2614:		CheckForReload(  );
ADDRGP4 CheckForReload
CALLF4
pop
line 2615
;2615:		Attack_Finished( 0.8 );
CNSTF4 1061997773
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2616
;2616:		break;
ADDRGP4 $1430
JUMPV
LABELV $1465
line 2618
;2617:	case WEAP_LIGHTNING:
;2618:		player_light1(  );
ADDRGP4 player_light1
CALLV
pop
line 2619
;2619:		Attack_Finished( 0.1 );
CNSTF4 1036831949
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2620
;2620:		sound( self, 0, "weapons/lstart.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $1466
ARGP4
ADDRLP4 160
CNSTF4 1065353216
ASGNF4
ADDRLP4 160
INDIRF4
ARGF4
ADDRLP4 160
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2621
;2621:		break;
ADDRGP4 $1430
JUMPV
LABELV $1467
line 2623
;2622:	case WEAP_SNIPER_RIFLE:
;2623:		if ( ( ( int ) self->s.v.flags & FL_ONGROUND ) || self->hook_out )
ADDRLP4 164
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 168
CNSTI4 0
ASGNI4
ADDRLP4 164
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
ADDRLP4 168
INDIRI4
NEI4 $1470
ADDRLP4 164
INDIRP4
CNSTI4 1436
ADDP4
INDIRI4
ADDRLP4 168
INDIRI4
EQI4 $1430
LABELV $1470
line 2624
;2624:		{
line 2625
;2625:			player_shot1(  );
ADDRGP4 player_shot1
CALLV
pop
line 2626
;2626:			W_FireSniperRifle(  );
ADDRGP4 W_FireSniperRifle
CALLV
pop
line 2627
;2627:			self->allow_snip_time = g_globalvars.time + tf_data.snip_time;
ADDRGP4 self
INDIRP4
CNSTI4 1588
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 tf_data+136
INDIRF4
ADDF4
ASGNF4
line 2628
;2628:			Attack_Finished( 1.5 );
CNSTF4 1069547520
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2629
;2629:		}
line 2630
;2630:		break;
ADDRGP4 $1430
JUMPV
LABELV $1473
line 2632
;2631:	case WEAP_AUTO_RIFLE:
;2632:		player_autorifle1(  );
ADDRGP4 player_autorifle1
CALLV
pop
line 2633
;2633:		W_FireAutoRifle(  );
ADDRGP4 W_FireAutoRifle
CALLV
pop
line 2634
;2634:		Attack_Finished( 0.1 );
CNSTF4 1036831949
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2635
;2635:		break;
ADDRGP4 $1430
JUMPV
LABELV $1474
line 2637
;2636:	case WEAP_ASSAULT_CANNON:
;2637:		if ( ( self->playerclass == PC_HVYWEAP ) && ( self->option4 == OPT_20MM ) ) {
ADDRLP4 172
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 6
NEI4 $1475
ADDRLP4 172
INDIRP4
CNSTI4 1784
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1475
line 2638
;2638:			W_FireBigAss ( );
ADDRGP4 W_FireBigAss
CALLV
pop
line 2639
;2639:			Attack_Finished (0.2);
CNSTF4 1045220557
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2641
;2640:			//self.impulse = 0;
;2641:			break;
ADDRGP4 $1430
JUMPV
LABELV $1475
line 2643
;2642:		}
;2643:		if ( self->s.v.ammo_cells < 4 )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1082130432
GEF4 $1477
line 2644
;2644:			G_sprint( self, 1, "Insufficient cells to power up the Assault Cannon.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1479
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1430
JUMPV
LABELV $1477
line 2646
;2645:		else
;2646:		{
line 2647
;2647:                        if( !tg_data.unlimit_ammo )
ADDRGP4 tg_data+8
INDIRI4
CNSTI4 0
NEI4 $1480
line 2648
;2648:				self->s.v.ammo_cells -= 4;
ADDRLP4 176
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRF4
CNSTF4 1082130432
SUBF4
ASGNF4
LABELV $1480
line 2650
;2649:
;2650:			self->heat = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 1065353216
ASGNF4
line 2651
;2651:			self->tfstate |= TFSTATE_AIMING;
ADDRLP4 180
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 180
INDIRP4
ADDRLP4 180
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 2652
;2652:			TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 2653
;2653:			player_assaultcannonup1(  );
ADDRGP4 player_assaultcannonup1
CALLV
pop
line 2654
;2654:		}
line 2655
;2655:		break;
ADDRGP4 $1430
JUMPV
LABELV $1483
line 2657
;2656:	case WEAP_FLAMETHROWER:
;2657:		player_shot1(  );
ADDRGP4 player_shot1
CALLV
pop
line 2658
;2658:		W_FireFlame(  );
ADDRGP4 W_FireFlame
CALLV
pop
line 2659
;2659:		if ( self->s.v.waterlevel > 2 )
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1073741824
LEF4 $1484
line 2660
;2660:			Attack_Finished( 1 );
CNSTF4 1065353216
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
ADDRGP4 $1430
JUMPV
LABELV $1484
line 2662
;2661:		else
;2662:		{
line 2663
;2663:			Attack_Finished( 0.15 );
CNSTF4 1041865114
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2664
;2664:		}
line 2665
;2665:		break;
ADDRGP4 $1430
JUMPV
LABELV $1486
line 2667
;2666:	case WEAP_INCENDIARY:
;2667:		player_rocket1(  );
ADDRGP4 player_rocket1
CALLV
pop
line 2668
;2668:		W_FireIncendiaryCannon(  );
ADDRGP4 W_FireIncendiaryCannon
CALLV
pop
line 2669
;2669:		Attack_Finished( 1.2 );
CNSTF4 1067030938
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2670
;2670:		break;
ADDRGP4 $1430
JUMPV
LABELV $1487
line 2672
;2671:	case WEAP_MEDIKIT:
;2672:		sound( self, 1, "weapons/ax1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1433
ARGP4
ADDRLP4 176
CNSTF4 1065353216
ASGNF4
ADDRLP4 176
INDIRF4
ARGF4
ADDRLP4 176
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2673
;2673:		switch ( ( int ) ( g_random(  ) * 4 ) )
ADDRLP4 184
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 180
CNSTF4 1082130432
ADDRLP4 184
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $1491
ADDRLP4 180
INDIRI4
CNSTI4 1
EQI4 $1492
ADDRLP4 180
INDIRI4
CNSTI4 2
EQI4 $1493
ADDRGP4 $1488
JUMPV
line 2674
;2674:		{
LABELV $1491
line 2676
;2675:		case 0:
;2676:			player_medikit1(  );
ADDRGP4 player_medikit1
CALLV
pop
line 2677
;2677:			break;
ADDRGP4 $1489
JUMPV
LABELV $1492
line 2679
;2678:		case 1:
;2679:			player_medikitb1(  );
ADDRGP4 player_medikitb1
CALLV
pop
line 2680
;2680:			break;
ADDRGP4 $1489
JUMPV
LABELV $1493
line 2682
;2681:		case 2:
;2682:			player_medikitc1(  );
ADDRGP4 player_medikitc1
CALLV
pop
line 2683
;2683:			break;
ADDRGP4 $1489
JUMPV
LABELV $1488
line 2685
;2684:		default:
;2685:			player_medikitd1(  );
ADDRGP4 player_medikitd1
CALLV
pop
line 2686
;2686:			break;
LABELV $1489
line 2688
;2687:		}
;2688:		Attack_Finished( 0.5 );
CNSTF4 1056964608
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2689
;2689:		break;
ADDRGP4 $1430
JUMPV
LABELV $1494
line 2691
;2690:	case WEAP_BIOWEAPON:
;2691:		sound( self, 1, "weapons/ax1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1433
ARGP4
ADDRLP4 192
CNSTF4 1065353216
ASGNF4
ADDRLP4 192
INDIRF4
ARGF4
ADDRLP4 192
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2692
;2692:		switch ( ( int ) ( g_random(  ) * 4 ) )
ADDRLP4 200
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 196
CNSTF4 1082130432
ADDRLP4 200
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $1498
ADDRLP4 196
INDIRI4
CNSTI4 1
EQI4 $1499
ADDRLP4 196
INDIRI4
CNSTI4 2
EQI4 $1500
ADDRGP4 $1495
JUMPV
line 2693
;2693:		{
LABELV $1498
line 2695
;2694:		case 0:
;2695:			player_bioweapon1(  );
ADDRGP4 player_bioweapon1
CALLV
pop
line 2696
;2696:			break;
ADDRGP4 $1496
JUMPV
LABELV $1499
line 2698
;2697:		case 1:
;2698:			player_bioweaponb1(  );
ADDRGP4 player_bioweaponb1
CALLV
pop
line 2699
;2699:			break;
ADDRGP4 $1496
JUMPV
LABELV $1500
line 2701
;2700:		case 2:
;2701:			player_bioweaponc1(  );
ADDRGP4 player_bioweaponc1
CALLV
pop
line 2702
;2702:			break;
ADDRGP4 $1496
JUMPV
LABELV $1495
line 2704
;2703:		default:
;2704:			player_bioweapond1(  );
ADDRGP4 player_bioweapond1
CALLV
pop
line 2705
;2705:			break;
LABELV $1496
line 2707
;2706:		}
;2707:		Attack_Finished( 0.5 );
CNSTF4 1056964608
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2708
;2708:		break;
ADDRGP4 $1430
JUMPV
LABELV $1501
line 2710
;2709:	case WEAP_TRANQ:
;2710:		sound( self, 1, "weapons/dartgun.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $44
ARGP4
ADDRLP4 208
CNSTF4 1065353216
ASGNF4
ADDRLP4 208
INDIRF4
ARGF4
ADDRLP4 208
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2711
;2711:		player_shot1(  );
ADDRGP4 player_shot1
CALLV
pop
line 2712
;2712:		W_FireTranq(  );
ADDRGP4 W_FireTranq
CALLV
pop
line 2713
;2713:		Attack_Finished( 1.5 );
CNSTF4 1069547520
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2714
;2714:		break;
ADDRGP4 $1430
JUMPV
LABELV $1502
line 2716
;2715:	case WEAP_LASER:
;2716:		sound( self, 1, "enforcer/enfire.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1503
ARGP4
ADDRLP4 212
CNSTF4 1065353216
ASGNF4
ADDRLP4 212
INDIRF4
ARGF4
ADDRLP4 212
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2717
;2717:		player_shot1(  );
ADDRGP4 player_shot1
CALLV
pop
line 2718
;2718:		W_FireLaser(  );
ADDRGP4 W_FireLaser
CALLV
pop
line 2719
;2719:		Attack_Finished( 0.4 );
CNSTF4 1053609165
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 2720
;2720:		break;
LABELV $1429
LABELV $1430
line 2722
;2721:	}
;2722:}
LABELV $1413
endproc W_Attack 216 20
export W_PrintWeaponMessage
proc W_PrintWeaponMessage 36 12
line 2725
;2723:
;2724:void W_PrintWeaponMessage(  )
;2725:{
line 2726
;2726:	switch ( self->current_weapon )
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
CNSTI4 32
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $1550
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
GTI4 $1561
LABELV $1560
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1533
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $1556
ADDRLP4 0
INDIRI4
CNSTI4 4
EQI4 $1558
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $1523
LABELV $1562
ADDRLP4 0
INDIRI4
CNSTI4 16
EQI4 $1526
ADDRGP4 $1523
JUMPV
LABELV $1561
ADDRLP4 24
CNSTI4 2048
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1535
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
GTI4 $1564
LABELV $1563
ADDRLP4 0
INDIRI4
CNSTI4 64
EQI4 $1552
ADDRGP4 $1523
JUMPV
LABELV $1564
ADDRLP4 0
INDIRI4
CNSTI4 262144
EQI4 $1554
ADDRGP4 $1523
JUMPV
line 2727
;2727:	{
LABELV $1526
line 2729
;2728:	case WEAP_AXE:
;2729:		if ( tf_data.allow_hook )
ADDRGP4 tf_data+64
INDIRI4
CNSTI4 0
EQI4 $1524
line 2730
;2730:			if ( self->playerclass != PC_SPY )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
EQI4 $1524
line 2731
;2731:				G_sprint( self, 1, "Axe selected\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1532
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2732
;2732:		break;
ADDRGP4 $1524
JUMPV
LABELV $1533
line 2734
;2733:	case WEAP_HOOK:
;2734:		G_sprint( self, 1, "grappling hook selected\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1534
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2735
;2735:		break;
ADDRGP4 $1524
JUMPV
LABELV $1535
line 2737
;2736:	case WEAP_GRENADE_LAUNCHER:
;2737:		if ( self->weaponmode == GL_NORMAL && self->option != OPT_LRG )
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1536
ADDRLP4 28
INDIRP4
CNSTI4 1780
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1536
line 2738
;2738:			G_sprint( self, 1, "Normal grenade mode\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1538
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1524
JUMPV
LABELV $1536
line 2740
;2739:		else
;2740:		{
line 2741
;2741:			if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $1539
line 2742
;2742:				G_sprint( self, 1, "Pipebomb mode not available in PreMatch\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1543
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1524
JUMPV
LABELV $1539
line 2744
;2743:			else
;2744:			{
line 2745
;2745:				if ( self->weaponmode == GL_PIPEBOMB )
ADDRGP4 self
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1544
line 2746
;2746:					G_sprint( self, 1, "Pipebomb mode\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1546
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1524
JUMPV
LABELV $1544
line 2748
;2747:				else
;2748:				{
line 2749
;2749:					if ( self->weaponmode == GL_NORMAL && self->option == OPT_LRG )
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1524
ADDRLP4 32
INDIRP4
CNSTI4 1780
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1524
line 2750
;2750:						G_sprint( self, 1, "Long-range grenade mode\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1549
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2751
;2751:				}
line 2752
;2752:			}
line 2753
;2753:		}
line 2754
;2754:		break;
ADDRGP4 $1524
JUMPV
LABELV $1550
line 2756
;2755:	case WEAP_SNIPER_RIFLE:
;2756:		G_sprint( self, 1, "Sniper rifle ready\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1551
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2757
;2757:		break;
ADDRGP4 $1524
JUMPV
LABELV $1552
line 2759
;2758:	case WEAP_AUTO_RIFLE:
;2759:		G_sprint( self, 1, "rifle on fully auto\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1553
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2760
;2760:		break;
ADDRGP4 $1524
JUMPV
LABELV $1554
line 2762
;2761:	case WEAP_TRANQ:
;2762:		G_sprint( self, 1, "Tranquiliser gun selected\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1555
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2763
;2763:		break;
ADDRGP4 $1524
JUMPV
LABELV $1556
line 2765
;2764:	case WEAP_BIOWEAPON:
;2765:		G_sprint( self, 1, "BioWeapon readied\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1557
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2766
;2766:		break;
ADDRGP4 $1524
JUMPV
LABELV $1558
line 2768
;2767:	case WEAP_MEDIKIT:
;2768:		G_sprint( self, 1, "Medikit/Bioweapon readied\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1559
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2769
;2769:		break;
LABELV $1523
LABELV $1524
line 2771
;2770:	}
;2771:}
LABELV $1522
endproc W_PrintWeaponMessage 36 12
export W_ChangeWeapon
proc W_ChangeWeapon 44 20
line 2774
;2772:
;2773:void W_ChangeWeapon(  )
;2774:{
line 2775
;2775:	int     it, am, fl, wm = 0, have_weapon, usable;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2777
;2776:
;2777:	if ( streq( self->s.v.weaponmodel, "progs/proxgren.mdl" ) ) {
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
INDIRP4
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 24
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1566
line 2778
;2778:		if ( self->oldweaponmodel != "" ) {
ADDRGP4 self
INDIRP4
CNSTI4 1008
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 $1298
CVPU4 4
EQU4 $1568
line 2779
;2779:			self->tfstate = (self->tfstate - ( self->tfstate & TFSTATE_RELOADING ) );
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRI4
ADDRLP4 32
INDIRI4
CNSTI4 2
BANDI4
SUBI4
ASGNI4
line 2780
;2780:		}
LABELV $1568
line 2781
;2781:		self->s.v.weaponmodel = self->oldweaponmodel;
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 308
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 1008
ADDP4
INDIRP4
ASGNP4
line 2782
;2782:		self->s.v.currentammo = self->oldcurrentammo;
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 1012
ADDP4
INDIRF4
ASGNF4
line 2783
;2783:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2784
;2784:	}
LABELV $1566
line 2786
;2785:
;2786:	if ( self->tfstate & TFSTATE_RELOADING )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1571
line 2787
;2787:		return;
ADDRGP4 $1565
JUMPV
LABELV $1571
line 2788
;2788:	it = self->weapons_carried;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ASGNI4
line 2789
;2789:	fl = self->current_weapon;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
line 2790
;2790:	am = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 2791
;2791:	usable = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2792
;2792:	have_weapon = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 2793
;2793:	if ( self->s.v.impulse == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $1573
line 2794
;2794:	{
line 2795
;2795:		if ( !( it & ( 1 | 2 | 4 | 16 | 8 ) ) )
ADDRLP4 12
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 0
NEI4 $1575
line 2796
;2796:			have_weapon = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1575
line 2797
;2797:		if ( fl != 16 && self->playerclass != PC_SPY )
ADDRLP4 0
INDIRI4
CNSTI4 16
EQI4 $1580
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
EQI4 $1580
line 2798
;2798:			sound( self, 1, "weapons/knifedrw.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $131
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
ADDRGP4 $1580
JUMPV
LABELV $1579
line 2800
;2799:		while ( !usable && have_weapon )
;2800:		{
line 2801
;2801:			if ( fl == 8 )
ADDRLP4 0
INDIRI4
CNSTI4 8
NEI4 $1582
line 2802
;2802:			{
line 2803
;2803:				fl = 2;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 2804
;2804:				if ( it & 2 )
ADDRLP4 12
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1584
line 2805
;2805:					usable = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $1584
line 2806
;2806:				usable = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2807
;2807:			} else
ADDRGP4 $1583
JUMPV
LABELV $1582
line 2808
;2808:			{
line 2809
;2809:				if ( fl == 2 )
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $1586
line 2810
;2810:				{
line 2811
;2811:					fl = 4;
ADDRLP4 0
CNSTI4 4
ASGNI4
line 2812
;2812:					if ( it & 4 )
ADDRLP4 12
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1587
line 2813
;2813:						usable = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 2814
;2814:				} else
ADDRGP4 $1587
JUMPV
LABELV $1586
line 2815
;2815:				{
line 2816
;2816:					if ( fl == 4 )
ADDRLP4 0
INDIRI4
CNSTI4 4
NEI4 $1590
line 2817
;2817:					{
line 2818
;2818:						fl = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2819
;2819:						if ( tf_data.allow_hook && ( fl & 1 ) )
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 tf_data+64
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $1592
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 32
INDIRI4
EQI4 $1592
line 2820
;2820:							usable = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $1592
line 2821
;2821:						if ( self->hook_out )
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1591
line 2822
;2822:							Reset_Grapple( self->hook );
ADDRGP4 self
INDIRP4
CNSTI4 1440
ADDP4
INDIRP4
ARGP4
ADDRGP4 Reset_Grapple
CALLV
pop
line 2823
;2823:					} else
ADDRGP4 $1591
JUMPV
LABELV $1590
line 2824
;2824:					{
line 2825
;2825:						if ( fl == 1 )
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $1597
line 2826
;2826:						{
line 2827
;2827:							fl = 16;
ADDRLP4 0
CNSTI4 16
ASGNI4
line 2828
;2828:							if ( it & 16 )
ADDRLP4 12
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1598
line 2829
;2829:								usable = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 2830
;2830:						} else
ADDRGP4 $1598
JUMPV
LABELV $1597
line 2831
;2831:						{
line 2832
;2832:							fl = 8;
ADDRLP4 0
CNSTI4 8
ASGNI4
line 2833
;2833:							if ( it & 8 )
ADDRLP4 12
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1601
line 2834
;2834:								usable = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $1601
line 2835
;2835:						}
LABELV $1598
line 2836
;2836:					}
LABELV $1591
line 2837
;2837:				}
LABELV $1587
line 2838
;2838:			}
LABELV $1583
line 2839
;2839:		}
LABELV $1580
line 2799
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $1603
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $1579
LABELV $1603
line 2840
;2840:	} else
ADDRGP4 $1574
JUMPV
LABELV $1573
line 2841
;2841:	{
line 2842
;2842:		if ( tf_data.allow_hook && ( self->s.v.impulse == 22 || self->s.v.impulse == 39 ) )
ADDRGP4 tf_data+64
INDIRI4
CNSTI4 0
EQI4 $1604
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
INDIRF4
CNSTF4 1102053376
EQF4 $1607
ADDRLP4 28
INDIRF4
CNSTF4 1109131264
NEF4 $1604
LABELV $1607
line 2843
;2843:			fl = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1605
JUMPV
LABELV $1604
line 2845
;2844:		else
;2845:		{
line 2846
;2846:			if ( self->s.v.impulse == 40 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1109393408
NEF4 $1608
line 2847
;2847:			{
line 2848
;2848:				if ( !( it & ( 2 | 4 | 16 | 8 ) ) )
ADDRLP4 12
INDIRI4
CNSTI4 30
BANDI4
CNSTI4 0
NEI4 $1613
line 2849
;2849:					have_weapon = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1613
JUMPV
LABELV $1612
line 2851
;2850:				while ( !usable && have_weapon )
;2851:				{
line 2852
;2852:					if ( fl == 8 )
ADDRLP4 0
INDIRI4
CNSTI4 8
NEI4 $1615
line 2853
;2853:					{
line 2854
;2854:						fl = 2;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 2855
;2855:						if ( it & 2 )
ADDRLP4 12
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1617
line 2856
;2856:							usable = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $1617
line 2857
;2857:						usable = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2858
;2858:					} else
ADDRGP4 $1616
JUMPV
LABELV $1615
line 2859
;2859:					{
line 2860
;2860:						if ( fl == 2 )
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $1619
line 2861
;2861:						{
line 2862
;2862:							fl = 4;
ADDRLP4 0
CNSTI4 4
ASGNI4
line 2863
;2863:							if ( it & 4 )
ADDRLP4 12
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1620
line 2864
;2864:								usable = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 2865
;2865:						} else
ADDRGP4 $1620
JUMPV
LABELV $1619
line 2866
;2866:						{
line 2867
;2867:							if ( fl == 4 )
ADDRLP4 0
INDIRI4
CNSTI4 4
NEI4 $1623
line 2868
;2868:							{
line 2869
;2869:								fl = 16;
ADDRLP4 0
CNSTI4 16
ASGNI4
line 2870
;2870:								if ( it & 16 )
ADDRLP4 12
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1624
line 2871
;2871:									usable = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 2872
;2872:							} else
ADDRGP4 $1624
JUMPV
LABELV $1623
line 2873
;2873:							{
line 2874
;2874:								fl = 8;
ADDRLP4 0
CNSTI4 8
ASGNI4
line 2875
;2875:								if ( it & 8 )
ADDRLP4 12
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1627
line 2876
;2876:									usable = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $1627
line 2877
;2877:							}
LABELV $1624
line 2878
;2878:						}
LABELV $1620
line 2879
;2879:					}
LABELV $1616
line 2880
;2880:				}
LABELV $1613
line 2850
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $1629
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $1612
LABELV $1629
line 2881
;2881:			} else
ADDRGP4 $1609
JUMPV
LABELV $1608
line 2882
;2882:			{
line 2883
;2883:				if ( self->s.v.impulse == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $1630
line 2884
;2884:				{
line 2885
;2885:					if ( it & 32 )
ADDRLP4 12
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1632
line 2886
;2886:					{
line 2887
;2887:						fl = 32;
ADDRLP4 0
CNSTI4 32
ASGNI4
line 2888
;2888:						if ( self->s.v.ammo_shells < tf_data.snip_ammo )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRGP4 tf_data+132
INDIRI4
CVIF4 4
GEF4 $1634
line 2889
;2889:							am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1631
JUMPV
LABELV $1634
line 2891
;2890:						else
;2891:							sound ( self, 1, "weapons/shotgr1a.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $95
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 2892
;2892:					} else
ADDRGP4 $1631
JUMPV
LABELV $1632
line 2893
;2893:					{
line 2894
;2894:						if ( it & 128 )
ADDRLP4 12
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1637
line 2895
;2895:						{
line 2896
;2896:							fl = 128;
ADDRLP4 0
CNSTI4 128
ASGNI4
line 2897
;2897:							if ( self->s.v.ammo_shells < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1639
line 2898
;2898:								am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1631
JUMPV
LABELV $1639
line 2900
;2899:							else
;2900:								if (self->playerclass != 8)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
EQI4 $1631
line 2901
;2901:									sound ( self, 1, "weapons/shotgr1a.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $95
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 2902
;2902:						} else
ADDRGP4 $1631
JUMPV
LABELV $1637
line 2903
;2903:						{
line 2904
;2904:							if ( it & 262144 )
ADDRLP4 12
INDIRI4
CNSTI4 262144
BANDI4
CNSTI4 0
EQI4 $1643
line 2905
;2905:							{
line 2906
;2906:								fl = 262144;
ADDRLP4 0
CNSTI4 262144
ASGNI4
line 2907
;2907:								if ( self->s.v.ammo_shells < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1645
line 2908
;2908:									am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1631
JUMPV
LABELV $1645
line 2910
;2909:								else
;2910:									if (self->playerclass != 8)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
EQI4 $1631
line 2911
;2911:										sound ( self, 1, "weapons/shotgr1a.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $95
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 2912
;2912:							} else
ADDRGP4 $1631
JUMPV
LABELV $1643
line 2913
;2913:							{
line 2914
;2914:								if ( it & 524288 )
ADDRLP4 12
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $1649
line 2915
;2915:								{
line 2916
;2916:									fl = 524288;
ADDRLP4 0
CNSTI4 524288
ASGNI4
line 2917
;2917:									if ( self->s.v.ammo_nails < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1651
line 2918
;2918:										am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1631
JUMPV
LABELV $1651
line 2920
;2919:									else
;2920:										sound( self, 1, "weapons/railgr1a.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $102
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 2921
;2921:								} else
ADDRGP4 $1631
JUMPV
LABELV $1649
line 2922
;2922:									have_weapon = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2923
;2923:							}
line 2924
;2924:						}
line 2925
;2925:					}
line 2926
;2926:				} else
ADDRGP4 $1631
JUMPV
LABELV $1630
line 2927
;2927:				{
line 2928
;2928:					if ( self->s.v.impulse == 3 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $1653
line 2929
;2929:					{
line 2930
;2930:						if ( it & 64 )
ADDRLP4 12
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1655
line 2931
;2931:						{
line 2932
;2932:							fl = 64;
ADDRLP4 0
CNSTI4 64
ASGNI4
line 2933
;2933:							if ( self->s.v.ammo_shells < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1657
line 2934
;2934:								am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1654
JUMPV
LABELV $1657
line 2936
;2935:							else
;2936:								if (self->playerclass != 8)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
EQI4 $1654
line 2937
;2937:									sound ( self, 1, "weapons/shotgr1a.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $95
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 2938
;2938:						} else
ADDRGP4 $1654
JUMPV
LABELV $1655
line 2939
;2939:						{
line 2940
;2940:							fl = 256;
ADDRLP4 0
CNSTI4 256
ASGNI4
line 2941
;2941:							if ( self->s.v.ammo_shells < 2 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1073741824
GEF4 $1661
line 2942
;2942:								am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1654
JUMPV
LABELV $1661
line 2944
;2943:							else
;2944:								sound ( self, 1, "weapons/shotgr1a.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $95
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 2945
;2945:						}
line 2946
;2946:					} else
ADDRGP4 $1654
JUMPV
LABELV $1653
line 2947
;2947:					{
line 2948
;2948:						if ( self->s.v.impulse == 4 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1082130432
NEF4 $1663
line 2949
;2949:						{
line 2951
;2950://							fl = 512;
;2951:							fl = 1048576;
ADDRLP4 0
CNSTI4 1048576
ASGNI4
line 2952
;2952:							if ( self->s.v.ammo_nails < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1665
line 2953
;2953:								am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1664
JUMPV
LABELV $1665
line 2955
;2954:							else
;2955:								if (self->playerclass != 8)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
EQI4 $1664
line 2956
;2956:									sound ( self, 1, "weapons/shotgr1a.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $95
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 2957
;2957:						} else
ADDRGP4 $1664
JUMPV
LABELV $1663
line 2958
;2958:						{
line 2959
;2959:							if ( self->s.v.impulse == 5 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1084227584
NEF4 $1669
line 2960
;2960:							{
line 2961
;2961:								if ( /*it & 4096*/self->playerclass == PC_MEDIC ) {
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1671
line 2962
;2962:									fl = 1024;
ADDRLP4 0
CNSTI4 1024
ASGNI4
line 2963
;2963:									if ( self->s.v.ammo_nails < 2 )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1073741824
GEF4 $1673
line 2964
;2964:										am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1670
JUMPV
LABELV $1673
line 2966
;2965:									else
;2966:										sound ( self, 1, "weapons/shotgr1a.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $95
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 2967
;2967:								}
ADDRGP4 $1670
JUMPV
LABELV $1671
line 2968
;2968:								else {
line 2969
;2969:									if ( it & 2048 ) {
ADDRLP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1670
line 2970
;2970:										fl = 2048;
ADDRLP4 0
CNSTI4 2048
ASGNI4
line 2971
;2971:										if ( self->s.v.ammo_rockets < 3 )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1077936128
GEF4 $1677
line 2972
;2972:											am = 3;
ADDRLP4 16
CNSTI4 3
ASGNI4
ADDRGP4 $1678
JUMPV
LABELV $1677
line 2974
;2973:										else
;2974:											sound (self, 1, "weapons/rocklr1a.wav", 0.8, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $94
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
LABELV $1678
line 2975
;2975:										self->weaponmode = 0;
ADDRGP4 self
INDIRP4
CNSTI4 940
ADDP4
CNSTI4 0
ASGNI4
line 2976
;2976:										self->option = OPT_LRG;
ADDRGP4 self
INDIRP4
CNSTI4 1780
ADDP4
CNSTI4 1
ASGNI4
line 2977
;2977:									}
line 2978
;2978:								}
line 2979
;2979:							} else
ADDRGP4 $1670
JUMPV
LABELV $1669
line 2980
;2980:							{
line 2981
;2981:								if ( self->s.v.impulse == 6 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1086324736
NEF4 $1679
line 2982
;2982:								{
line 2983
;2983:									if ( it & 4096 )
ADDRLP4 12
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1681
line 2984
;2984:									{
line 2985
;2985:										fl = 4096;
ADDRLP4 0
CNSTI4 4096
ASGNI4
line 2986
;2986:										if ( self->s.v.ammo_cells < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1683
line 2987
;2987:											am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1680
JUMPV
LABELV $1683
line 2989
;2988:										else
;2989:											sound (self, 1, "weapons/rocklr1a.wav", 0.8, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $94
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 2990
;2990:									} else
ADDRGP4 $1680
JUMPV
LABELV $1681
line 2991
;2991:									{
line 2992
;2992:										if ( it & 2048 )
ADDRLP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1685
line 2993
;2993:										{
line 2994
;2994:											fl = 2048;
ADDRLP4 0
CNSTI4 2048
ASGNI4
line 2995
;2995:											if ( self->s.v.ammo_rockets <
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1687
line 2997
;2996:											     1 )
;2997:												am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1688
JUMPV
LABELV $1687
line 2999
;2998:											else
;2999:												sound (self, 1, "weapons/rocklr1a.wav", 0.8, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $94
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
LABELV $1688
line 3000
;3000:											wm = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 3001
;3001:											self->option = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1780
ADDP4
CNSTI4 0
ASGNI4
line 3002
;3002:										} else
ADDRGP4 $1680
JUMPV
LABELV $1685
line 3003
;3003:											have_weapon = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3004
;3004:									}
line 3005
;3005:								} else
ADDRGP4 $1680
JUMPV
LABELV $1679
line 3006
;3006:								{
line 3007
;3007:									if ( self->s.v.impulse == 7 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1088421888
NEF4 $1689
line 3008
;3008:									{
line 3009
;3009:										if ( it & 16384 )
ADDRLP4 12
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $1691
line 3010
;3010:										{
line 3011
;3011:											fl = 16384;
ADDRLP4 0
CNSTI4 16384
ASGNI4
line 3012
;3012:											if ( self->s.v.ammo_rockets <
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1077936128
GEF4 $1693
line 3014
;3013:											     3 )
;3014:												am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1690
JUMPV
LABELV $1693
line 3016
;3015:											else
;3016:												sound (self, 1, "weapons/rocklr1a.wav", 0.8, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $94
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 3017
;3017:										} else
ADDRGP4 $1690
JUMPV
LABELV $1691
line 3018
;3018:										{
line 3019
;3019:											if ( it & 8192 )
ADDRLP4 12
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1695
line 3020
;3020:											{
line 3021
;3021:												fl = 8192;
ADDRLP4 0
CNSTI4 8192
ASGNI4
line 3022
;3022:												if ( self->s.v.
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1697
line 3024
;3023:												     ammo_rockets < 1 )
;3024:													am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1690
JUMPV
LABELV $1697
line 3026
;3025:												else
;3026:													sound (self, 1, "weapons/rocklr1a.wav", 0.8, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $94
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 3027
;3027:											} else
ADDRGP4 $1690
JUMPV
LABELV $1695
line 3028
;3028:											{
line 3029
;3029:												if ( it & 32768 )
ADDRLP4 12
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $1699
line 3030
;3030:												{
line 3031
;3031:													if ( self->option4 )
ADDRGP4 self
INDIRP4
CNSTI4 1784
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1701
line 3032
;3032:													{
line 3033
;3033:														self->option4 = 0;	// regular ass. cannon
ADDRGP4 self
INDIRP4
CNSTI4 1784
ADDP4
CNSTI4 0
ASGNI4
line 3034
;3034:														G_sprint ( self, 2, "Assault cannon selected\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1703
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3035
;3035:														if ( self->s.v.ammo_cells < 4 )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1082130432
GEF4 $1702
line 3036
;3036:															am = 2;
ADDRLP4 16
CNSTI4 2
ASGNI4
line 3037
;3037:													}
ADDRGP4 $1702
JUMPV
LABELV $1701
line 3039
;3038:													else
;3039:													{
line 3040
;3040:														self->option4 = OPT_20MM;
ADDRGP4 self
INDIRP4
CNSTI4 1784
ADDP4
CNSTI4 1
ASGNI4
line 3041
;3041:														G_sprint ( self, 2 , "20mm cannon selected\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1706
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3042
;3042:													}
LABELV $1702
line 3043
;3043:													fl = 32768;
ADDRLP4 0
CNSTI4 32768
ASGNI4
line 3044
;3044:													if ( self->s.v.
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 1504
ADDP4
INDIRI4
CVIF4 4
GTF4 $1707
line 3048
;3045:													     ammo_shells
;3046:													     <=
;3047:													     self->assault_min_shells )
;3048:														am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1690
JUMPV
LABELV $1707
line 3050
;3049:													else
;3050:													{
line 3051
;3051:														sound ( self, 1, "weapons/shotgr1a.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $95
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 3052
;3052:														if ( self->s.v.ammo_cells < 4 )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1082130432
GEF4 $1690
line 3053
;3053:															am = 2;
ADDRLP4 16
CNSTI4 2
ASGNI4
line 3054
;3054:													}
line 3055
;3055:												} else
ADDRGP4 $1690
JUMPV
LABELV $1699
line 3056
;3056:												{
line 3057
;3057:													if ( it & 2048 )
ADDRLP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1711
line 3058
;3058:													{
line 3059
;3059:														fl = 2048;
ADDRLP4 0
CNSTI4 2048
ASGNI4
line 3060
;3060:														wm = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 3061
;3061:														if ( self->s.v.ammo_rockets < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1713
line 3062
;3062:															am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1690
JUMPV
LABELV $1713
line 3063
;3063:														else {
line 3064
;3064:															sound (self, 1, "weapons/rocklr1a.wav", 0.8, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $94
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 3065
;3065:															self->option = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1780
ADDP4
CNSTI4 0
ASGNI4
line 3066
;3066:														}
line 3068
;3067:
;3068:													} else
ADDRGP4 $1690
JUMPV
LABELV $1711
line 3069
;3069:														have_weapon
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3071
;3070:														    = 0;
;3071:												}
line 3072
;3072:											}
line 3073
;3073:										}
line 3074
;3074:									} else
ADDRGP4 $1690
JUMPV
LABELV $1689
line 3075
;3075:									{
line 3076
;3076:										if ( self->s.v.impulse == 8 && self->playerclass == PC_SPY )
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1090519040
NEF4 $1715
ADDRLP4 32
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1715
line 3077
;3077:										{
line 3080
;3078:											//if (self->playerclass == PC_SPY)
;3079:											//{
;3080:												fl = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 3081
;3081:												am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 3089
;3082:											//}
;3083:											//else
;3084:											//{
;3085:											/*	fl = 65536;
;3086:												if ( self->s.v.ammo_cells < 1 )
;3087:													am = 1;*/
;3088:											//}
;3089:										} else
ADDRGP4 $1716
JUMPV
LABELV $1715
line 3090
;3090:										{
line 3091
;3091:											if ( self->s.v.impulse == 176 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1127219200
NEF4 $1717
line 3092
;3092:											{
line 3093
;3093:												fl = 4;
ADDRLP4 0
CNSTI4 4
ASGNI4
line 3094
;3094:												if ( it & 4 )
ADDRLP4 12
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1718
line 3095
;3095:													usable = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 3096
;3096:											} else
ADDRGP4 $1718
JUMPV
LABELV $1717
line 3097
;3097:											{
line 3098
;3098:												if ( self->s.v.
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1116340224
NEF4 $1721
line 3100
;3099:												     impulse == 69 )
;3100:												{
line 3101
;3101:													fl = self->
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
ASGNI4
line 3103
;3102:													    last_weapon;
;3103:													if ( ( fl &
ADDRLP4 0
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $1723
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 1504
ADDP4
INDIRI4
CVIF4 4
GTF4 $1723
line 3110
;3104:													       WEAP_ASSAULT_CANNON )
;3105:													     && self->s.
;3106:													     v.
;3107:													     ammo_shells
;3108:													     <=
;3109:													     self->assault_min_shells )
;3110:														am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
LABELV $1723
line 3111
;3111:													if ( it & self->
ADDRLP4 12
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $1725
line 3113
;3112:													     last_weapon )
;3113:														usable =
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $1725
line 3115
;3114:														    1;
;3115:													if ( fl &
ADDRLP4 0
INDIRI4
CNSTI4 295360
BANDI4
CNSTI4 0
EQI4 $1727
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1727
line 3124
;3116:													     (  64 |
;3117:													       128 | 256
;3118:													       | 32768 |
;3119:													       262144 )
;3120:													     && self->s.
;3121:													     v.
;3122:													     ammo_shells
;3123:													     < 1 )
;3124:													{
line 3125
;3125:														am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 3126
;3126:													}else
ADDRGP4 $1728
JUMPV
LABELV $1727
line 3127
;3127:													{
line 3128
;3128:                                                                                                          if( (fl & 32) && self->s.v.ammo_shells < tf_data.snip_ammo)
ADDRLP4 0
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1729
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRGP4 tf_data+132
INDIRI4
CVIF4 4
GEF4 $1729
line 3129
;3129:                                                                                                          	am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1730
JUMPV
LABELV $1729
line 3131
;3130:													else
;3131:													{
line 3132
;3132:														if ( fl
ADDRLP4 0
INDIRI4
CNSTI4 525824
BANDI4
CNSTI4 0
EQI4 $1732
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1732
line 3146
;3133:														     &
;3134:														     ( 512
;3135:														       |
;3136:														       1024
;3137:														       |
;3138:														       524288 )
;3139:														     &&
;3140:														     self->
;3141:														     s.
;3142:														     v.
;3143:														     ammo_nails
;3144:														     <
;3145:														     1 )
;3146:															am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1733
JUMPV
LABELV $1732
line 3148
;3147:														else
;3148:														{
line 3149
;3149:															if ( fl & ( 2048 | 8192 ) && self->s.v.ammo_rockets < 1 )
ADDRLP4 0
INDIRI4
CNSTI4 10240
BANDI4
CNSTI4 0
EQI4 $1734
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1734
line 3150
;3150:																am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1735
JUMPV
LABELV $1734
line 3152
;3151:															else
;3152:															{
line 3153
;3153:																if ( fl & ( 4096 | 65536 ) && self->s.v.ammo_cells < 1 )
ADDRLP4 0
INDIRI4
CNSTI4 69632
BANDI4
CNSTI4 0
EQI4 $1736
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1736
line 3154
;3154:																	am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1737
JUMPV
LABELV $1736
line 3156
;3155:																else
;3156:																{
line 3157
;3157:																	if ( fl == 16384 && self->s.v.ammo_rockets < 3 )
ADDRLP4 0
INDIRI4
CNSTI4 16384
NEI4 $1738
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1077936128
GEF4 $1738
line 3158
;3158:																		am = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $1739
JUMPV
LABELV $1738
line 3160
;3159:																	else
;3160:																	{
line 3161
;3161:																		if ( fl == WEAP_ASSAULT_CANNON && self->s.v.ammo_cells < 4 )
ADDRLP4 0
INDIRI4
CNSTI4 32768
NEI4 $1740
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1082130432
GEF4 $1740
line 3162
;3162:																			am = 2;
ADDRLP4 16
CNSTI4 2
ASGNI4
LABELV $1740
line 3163
;3163:																	}
LABELV $1739
line 3164
;3164:																}
LABELV $1737
line 3165
;3165:															}
LABELV $1735
line 3166
;3166:														}
LABELV $1733
line 3167
;3167:													}
LABELV $1730
line 3168
;3168:													if ( !am )
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $1742
line 3169
;3169:														wm = self->last_weaponmode;
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 1040
ADDP4
INDIRI4
ASGNI4
LABELV $1742
line 3170
;3170:													}
LABELV $1728
line 3171
;3171:												}
LABELV $1721
line 3172
;3172:											}
LABELV $1718
line 3173
;3173:										}
LABELV $1716
line 3174
;3174:									}
LABELV $1690
line 3175
;3175:								}
LABELV $1680
line 3176
;3176:							}
LABELV $1670
line 3177
;3177:						}
LABELV $1664
line 3178
;3178:					}
LABELV $1654
line 3179
;3179:				}
LABELV $1631
line 3180
;3180:			}
LABELV $1609
line 3181
;3181:		}
LABELV $1605
line 3182
;3182:	}
LABELV $1574
line 3183
;3183:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3184
;3184:	if ( !have_weapon || !( it & fl ) )
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $1746
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
BANDI4
ADDRLP4 28
INDIRI4
NEI4 $1744
LABELV $1746
line 3185
;3185:	{
line 3186
;3186:		G_sprint( self, 2, "no weapon.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1747
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3187
;3187:		return;
ADDRGP4 $1565
JUMPV
LABELV $1744
line 3189
;3188:	}
;3189:	if ( am == 1 && (self->playerclass != PC_SPY && fl != 1))
ADDRLP4 32
CNSTI4 1
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $1748
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
EQI4 $1748
ADDRLP4 0
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $1748
line 3190
;3190:	{
line 3191
;3191:		G_sprint( self, 2, "not enough ammo.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1750
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3192
;3192:		return;
ADDRGP4 $1565
JUMPV
LABELV $1748
line 3199
;3193:	}
;3194:/*	if ( ( self->playerclass == PC_SPY && fl == 1 ) && self->s.v.ammo_cells < 25 )
;3195:	{
;3196:		G_sprint( self, 2, "not enough ammo.\n" );
;3197:		return;
;3198:	}*/
;3199:	if ( am == 2 )
ADDRLP4 16
INDIRI4
CNSTI4 2
NEI4 $1751
line 3200
;3200:	{
line 3201
;3201:		G_sprint( self, 2, "not enough cells to power assault cannon.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1753
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3202
;3202:		return;
ADDRGP4 $1565
JUMPV
LABELV $1751
line 3204
;3203:	}
;3204:	self->last_weaponmode = self->weaponmode;
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 1040
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
ASGNI4
line 3205
;3205:	self->last_weapon = self->current_weapon;
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 1036
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
line 3206
;3206:	self->current_weapon = fl;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 3207
;3207:	self->weaponmode = wm;
ADDRGP4 self
INDIRP4
CNSTI4 940
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 3208
;3208:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 3209
;3209:	W_PrintWeaponMessage(  );
ADDRGP4 W_PrintWeaponMessage
CALLV
pop
line 3210
;3210:	self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 3211
;3211:}
LABELV $1565
endproc W_ChangeWeapon 44 20
export CycleWeaponCommand
proc CycleWeaponCommand 40 0
line 3214
;3212:
;3213:void CycleWeaponCommand(  )
;3214:{
line 3221
;3215:	float   it;
;3216:	float   am;
;3217:	float   cont;
;3218:	float   loopcount;
;3219:	float   lw;
;3220:
;3221:	if ( self->s.v.weaponmodel[0] == 0 || !self->current_weapon )
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 308
ADDP4
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRI4
EQI4 $1758
ADDRLP4 20
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $1756
LABELV $1758
line 3222
;3222:		return;
ADDRGP4 $1755
JUMPV
LABELV $1756
line 3223
;3223:	if ( self->tfstate & TFSTATE_RELOADING )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1759
line 3224
;3224:		return;
ADDRGP4 $1755
JUMPV
LABELV $1759
line 3225
;3225:	it = self->weapons_carried;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 3226
;3226:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3227
;3227:	loopcount = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 3228
;3228:	lw = self->current_weapon;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $1762
JUMPV
LABELV $1761
line 3230
;3229:	while ( 1 )
;3230:	{
line 3231
;3231:		am = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 3232
;3232:		cont = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 3233
;3233:		if ( self->current_weapon == WEAP_AXE )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 16
NEI4 $1764
line 3234
;3234:			self->current_weapon = WEAP_SPANNER;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 8
ASGNI4
ADDRGP4 $1765
JUMPV
LABELV $1764
line 3236
;3235:		else
;3236:		{
line 3237
;3237:			if ( self->current_weapon == WEAP_SPANNER )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1766
line 3238
;3238:			{
line 3239
;3239:				self->current_weapon = WEAP_SHOTGUN;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 128
ASGNI4
line 3240
;3240:				if ( self->s.v.ammo_shells < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1767
line 3241
;3241:					am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3242
;3242:			} else
ADDRGP4 $1767
JUMPV
LABELV $1766
line 3243
;3243:			{
line 3244
;3244:				if ( self->current_weapon == WEAP_SHOTGUN )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 128
NEI4 $1770
line 3245
;3245:				{
line 3246
;3246:					self->current_weapon = WEAP_LASER;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 524288
ASGNI4
line 3247
;3247:					if ( self->s.v.ammo_nails < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1771
line 3248
;3248:						am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3249
;3249:				} else
ADDRGP4 $1771
JUMPV
LABELV $1770
line 3250
;3250:				{
line 3251
;3251:					if ( self->current_weapon == WEAP_LASER )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 524288
NEI4 $1774
line 3252
;3252:					{
line 3253
;3253:						self->current_weapon = WEAP_TRANQ;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 262144
ASGNI4
line 3254
;3254:						if ( self->s.v.ammo_shells < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1775
line 3255
;3255:							am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3256
;3256:					} else
ADDRGP4 $1775
JUMPV
LABELV $1774
line 3257
;3257:					{
line 3258
;3258:						if ( self->current_weapon == WEAP_TRANQ )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 262144
NEI4 $1778
line 3259
;3259:						{
line 3260
;3260:							self->current_weapon = WEAP_SNIPER_RIFLE;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 32
ASGNI4
line 3261
;3261:							if ( self->s.v.ammo_shells < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1779
line 3262
;3262:								am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3263
;3263:						} else
ADDRGP4 $1779
JUMPV
LABELV $1778
line 3264
;3264:						{
line 3265
;3265:							if ( self->current_weapon == WEAP_SNIPER_RIFLE )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 32
NEI4 $1782
line 3266
;3266:							{
line 3267
;3267:								self->current_weapon = WEAP_AUTO_RIFLE;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 64
ASGNI4
line 3268
;3268:								if ( self->s.v.ammo_shells < tf_data.snip_ammo )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRGP4 tf_data+132
INDIRI4
CVIF4 4
GEF4 $1783
line 3269
;3269:									am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3270
;3270:							} else
ADDRGP4 $1783
JUMPV
LABELV $1782
line 3271
;3271:							{
line 3272
;3272:								if ( self->current_weapon == WEAP_AUTO_RIFLE )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 64
NEI4 $1787
line 3273
;3273:								{
line 3274
;3274:									self->current_weapon = WEAP_SUPER_SHOTGUN;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 256
ASGNI4
line 3275
;3275:									if ( self->s.v.ammo_shells < 2 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1073741824
GEF4 $1788
line 3276
;3276:										am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3277
;3277:								} else
ADDRGP4 $1788
JUMPV
LABELV $1787
line 3278
;3278:								{
line 3279
;3279:									if ( self->current_weapon ==
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 256
NEI4 $1791
line 3281
;3280:									     WEAP_SUPER_SHOTGUN )
;3281:									{
line 3283
;3282:										//self->current_weapon = WEAP_NAILGUN;
;3283:										self->current_weapon = WEAP_MAC10;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 1048576
ASGNI4
line 3284
;3284:										if ( self->s.v.ammo_nails < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1792
line 3285
;3285:											am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3286
;3286:									} else
ADDRGP4 $1792
JUMPV
LABELV $1791
line 3287
;3287:									{
line 3288
;3288:										if ( self->current_weapon ==
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 1048576
NEI4 $1795
line 3291
;3289:											 WEAP_MAC10 )
;3290://										     WEAP_NAILGUN )
;3291:										{
line 3292
;3292:											self->current_weapon =
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 1024
ASGNI4
line 3294
;3293:											    WEAP_SUPER_NAILGUN;
;3294:											if ( self->s.v.ammo_nails < 2 )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1073741824
GEF4 $1796
line 3295
;3295:												am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3296
;3296:										} else
ADDRGP4 $1796
JUMPV
LABELV $1795
line 3297
;3297:										{
line 3298
;3298:											if ( self->current_weapon ==
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 1024
NEI4 $1799
line 3300
;3299:											     WEAP_SUPER_NAILGUN )
;3300:											{
line 3301
;3301:												self->current_weapon =
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 2048
ASGNI4
line 3303
;3302:												    WEAP_GRENADE_LAUNCHER;
;3303:												self->weaponmode = 0;
ADDRGP4 self
INDIRP4
CNSTI4 940
ADDP4
CNSTI4 0
ASGNI4
line 3304
;3304:												if ( self->s.v.
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1800
line 3306
;3305:												     ammo_rockets < 1 )
;3306:													am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3307
;3307:											} else
ADDRGP4 $1800
JUMPV
LABELV $1799
line 3308
;3308:											{
line 3309
;3309:												if ( self->
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2048
NEI4 $1803
ADDRLP4 28
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1803
line 3314
;3310:												     current_weapon ==
;3311:												     WEAP_GRENADE_LAUNCHER
;3312:												     && !self->
;3313:												     weaponmode )
;3314:												{
line 3315
;3315:													self->
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 2048
ASGNI4
line 3319
;3316:													    current_weapon
;3317:													    =
;3318:													    WEAP_GRENADE_LAUNCHER;
;3319:													self->
ADDRGP4 self
INDIRP4
CNSTI4 940
ADDP4
CNSTI4 1
ASGNI4
line 3322
;3320:													    weaponmode =
;3321:													    1;
;3322:													if ( self->s.v.
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1804
line 3325
;3323:													     ammo_rockets
;3324:													     < 1 )
;3325:														am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3326
;3326:												} else
ADDRGP4 $1804
JUMPV
LABELV $1803
line 3327
;3327:												{
line 3328
;3328:													if ( self->
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2048
NEI4 $1807
ADDRLP4 32
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1807
line 3335
;3329:													     current_weapon
;3330:													     ==
;3331:													     WEAP_GRENADE_LAUNCHER
;3332:													     && self->
;3333:													     weaponmode
;3334:													     == 1 )
;3335:													{
line 3336
;3336:														self->
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 8192
ASGNI4
line 3340
;3337:														    current_weapon
;3338:														    =
;3339:														    WEAP_ROCKET_LAUNCHER;
;3340:														if ( self->s.v.ammo_rockets < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1808
line 3341
;3341:															am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3342
;3342:													} else
ADDRGP4 $1808
JUMPV
LABELV $1807
line 3343
;3343:													{
line 3344
;3344:														if ( self->current_weapon == WEAP_ROCKET_LAUNCHER )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 8192
NEI4 $1811
line 3345
;3345:														{
line 3346
;3346:															self->
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 65536
ASGNI4
line 3350
;3347:															    current_weapon
;3348:															    =
;3349:															    WEAP_LIGHTNING;
;3350:															if ( self->s.v.ammo_cells < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1812
line 3351
;3351:																am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3352
;3352:														} else
ADDRGP4 $1812
JUMPV
LABELV $1811
line 3353
;3353:														{
line 3354
;3354:															if ( self->current_weapon == WEAP_LIGHTNING )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 65536
NEI4 $1815
line 3355
;3355:															{
line 3356
;3356:																self->
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 4096
ASGNI4
line 3360
;3357:																    current_weapon
;3358:																    =
;3359:																    WEAP_FLAMETHROWER;
;3360:																if ( self->s.v.ammo_cells < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $1816
line 3361
;3361:																	am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3362
;3362:															} else
ADDRGP4 $1816
JUMPV
LABELV $1815
line 3363
;3363:															{
line 3364
;3364:																if ( self->current_weapon == WEAP_FLAMETHROWER )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 4096
NEI4 $1819
line 3365
;3365:																{
line 3366
;3366:																	self->
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 16384
ASGNI4
line 3370
;3367:																	    current_weapon
;3368:																	    =
;3369:																	    WEAP_INCENDIARY;
;3370:																	if ( self->s.v.ammo_rockets < 3 )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1077936128
GEF4 $1820
line 3371
;3371:																		am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3372
;3372:																} else
ADDRGP4 $1820
JUMPV
LABELV $1819
line 3373
;3373:																{
line 3374
;3374:																	if ( self->current_weapon == WEAP_INCENDIARY )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 16384
NEI4 $1823
line 3375
;3375:																	{
line 3376
;3376:																		self->
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 32768
ASGNI4
line 3380
;3377:																		    current_weapon
;3378:																		    =
;3379:																		    WEAP_ASSAULT_CANNON;
;3380:																		if ( self->s.v.ammo_cells < 4 )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1082130432
GEF4 $1825
line 3381
;3381:																			am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
LABELV $1825
line 3382
;3382:																		if ( self->s.v.ammo_shells <= self->assault_min_shells )
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 1504
ADDP4
INDIRI4
CVIF4 4
GTF4 $1824
line 3383
;3383:																			am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3384
;3384:																	} else
ADDRGP4 $1824
JUMPV
LABELV $1823
line 3385
;3385:																	{
line 3386
;3386:																		if ( self->current_weapon == WEAP_ASSAULT_CANNON )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 32768
NEI4 $1829
line 3387
;3387:																		{
line 3388
;3388:																			self->
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 1
ASGNI4
line 3392
;3389:																			    current_weapon
;3390:																			    =
;3391:																			    WEAP_HOOK;
;3392:																			if ( /*self->s.v.ammo_cells < 25*/self->playerclass != PC_SPY )//!tf_data.allow_hook )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
EQI4 $1830
line 3393
;3393:																				am = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 3394
;3394:																		} else
ADDRGP4 $1830
JUMPV
LABELV $1829
line 3395
;3395:																		{
line 3396
;3396:																			if ( self->current_weapon == WEAP_HOOK )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1833
line 3397
;3397:																				self->
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 4
ASGNI4
ADDRGP4 $1834
JUMPV
LABELV $1833
line 3402
;3398:																				    current_weapon
;3399:																				    =
;3400:																				    WEAP_MEDIKIT;
;3401:																			else
;3402:																			{
line 3403
;3403:																				if ( self->current_weapon == WEAP_BIOWEAPON )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1835
line 3404
;3404:																					self->
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 4
ASGNI4
ADDRGP4 $1836
JUMPV
LABELV $1835
line 3409
;3405:																					    current_weapon
;3406:																					    =
;3407:																					    WEAP_MEDIKIT;
;3408:																				else
;3409:																				{
line 3410
;3410:																					if ( self->current_weapon == WEAP_MEDIKIT )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1837
line 3411
;3411:																						self->
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 16
ASGNI4
ADDRGP4 $1838
JUMPV
LABELV $1837
line 3416
;3412:																						    current_weapon
;3413:																						    =
;3414:																							WEAP_AXE;
;3415:																					else
;3416:																					{
line 3417
;3417:																						if ( self->current_weapon == WEAP_MAC10 && self->playerclass == PC_SPY )
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 1048576
NEI4 $1839
ADDRLP4 36
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1839
line 3418
;3418:																							self->
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 1
ASGNI4
LABELV $1839
line 3422
;3419:																								current_weapon
;3420:																								=
;3421:																								WEAP_HOOK;
;3422:																					}
LABELV $1838
line 3423
;3423:																				}
LABELV $1836
line 3424
;3424:																			}
LABELV $1834
line 3425
;3425:																		}
LABELV $1830
line 3426
;3426:																	}
LABELV $1824
line 3427
;3427:																}
LABELV $1820
line 3428
;3428:															}
LABELV $1816
line 3429
;3429:														}
LABELV $1812
line 3430
;3430:													}
LABELV $1808
line 3431
;3431:												}
LABELV $1804
line 3432
;3432:											}
LABELV $1800
line 3433
;3433:										}
LABELV $1796
line 3434
;3434:									}
LABELV $1792
line 3435
;3435:								}
LABELV $1788
line 3436
;3436:							}
LABELV $1783
line 3437
;3437:						}
LABELV $1779
line 3438
;3438:					}
LABELV $1775
line 3439
;3439:				}
LABELV $1771
line 3440
;3440:			}
LABELV $1767
line 3441
;3441:		}
LABELV $1765
line 3442
;3442:		if ( loopcount > 30 )
ADDRLP4 0
INDIRF4
CNSTF4 1106247680
LEF4 $1841
line 3443
;3443:			return;
ADDRGP4 $1755
JUMPV
LABELV $1841
line 3444
;3444:		loopcount = loopcount + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3445
;3445:		if ( ( self->weapons_carried & self->current_weapon ) && !am )
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $1843
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $1843
line 3446
;3446:		{
line 3447
;3447:			if ( self->current_weapon != 2048 )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2048
EQI4 $1845
line 3448
;3448:				self->weaponmode = 0;
ADDRGP4 self
INDIRP4
CNSTI4 940
ADDP4
CNSTI4 0
ASGNI4
LABELV $1845
line 3449
;3449:			self->last_weapon = lw;
ADDRGP4 self
INDIRP4
CNSTI4 1036
ADDP4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 3450
;3450:			W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 3451
;3451:			W_PrintWeaponMessage(  );
ADDRGP4 W_PrintWeaponMessage
CALLV
pop
line 3452
;3452:			self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 3453
;3453:			return;
ADDRGP4 $1755
JUMPV
LABELV $1843
line 3455
;3454:		}
;3455:	}
LABELV $1762
line 3229
ADDRGP4 $1761
JUMPV
line 3456
;3456:}
LABELV $1755
endproc CycleWeaponCommand 40 0
export ImpulseCommands
proc ImpulseCommands 72 20
line 3461
;3457:
;3458://#include "megatf\mtf_scout.c"
;3459:
;3460:void ImpulseCommands(  )
;3461:{
line 3464
;3462:        char st[20];
;3463:
;3464:	if ( self->last_impulse == TF_DETPACK && self->s.v.impulse )
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
CNSTI4 168
NEI4 $1849
ADDRLP4 20
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1849
line 3465
;3465:		TeamFortress_SetDetpack( self->s.v.impulse );
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
ARGF4
ADDRGP4 TeamFortress_SetDetpack
CALLV
pop
ADDRGP4 $1850
JUMPV
LABELV $1849
line 3467
;3466:	else
;3467:	{
line 3468
;3468:		if ( self->last_impulse == TF_SCAN && self->s.v.impulse )
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
CNSTI4 159
NEI4 $1851
ADDRLP4 24
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1851
line 3469
;3469:			TeamFortress_Scan_Angel( self->s.v.impulse, 0 );
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Scan_Angel
CALLV
pop
LABELV $1851
line 3470
;3470:		if ( self->s.v.impulse == TF_SCAN_ENEMY || self->s.v.impulse == TF_SCAN_FRIENDLY )
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
INDIRF4
CNSTF4 1126170624
EQF4 $1855
ADDRLP4 28
INDIRF4
CNSTF4 1126236160
NEF4 $1853
LABELV $1855
line 3471
;3471:			TeamFortress_Scan_Angel( self->s.v.impulse, 0 );
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Scan_Angel
CALLV
pop
LABELV $1853
line 3472
;3472:	}
LABELV $1850
line 3474
;3473:
;3474:	if ( self->s.v.impulse == 8 && self->current_menu != MENU_CLASSHELP )
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1090519040
NEF4 $1856
ADDRLP4 24
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
CNSTI4 6
EQI4 $1856
line 3475
;3475:	{
line 3476
;3476:		self->current_menu = MENU_CLASSHELP;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 6
ASGNI4
line 3477
;3477:		self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 3478
;3478:		self->menu_displaytime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 956
ADDP4
CNSTI4 0
ASGNI4
line 3479
;3479:	}
LABELV $1856
line 3481
;3480:
;3481:	if ( self->s.v.impulse == 242 && !tf_data.birthday )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1131544576
NEF4 $1858
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 0
NEI4 $1858
line 3482
;3482:	{
line 3483
;3483:		GetSVInfokeyString( "bd", "birthday", st, sizeof( st ), "" );
ADDRGP4 $1861
ARGP4
ADDRGP4 $1862
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 $1298
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 3484
;3484:		if ( strneq( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $1865
ARGP4
ADDRLP4 28
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $1863
line 3485
;3485:		{
line 3486
;3486:			self->current_menu = MENU_BIRTHDAY1;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 23
ASGNI4
line 3487
;3487:			self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 3488
;3488:			self->menu_displaytime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 956
ADDP4
CNSTI4 0
ASGNI4
line 3489
;3489:			self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3490
;3490:			return;
ADDRGP4 $1848
JUMPV
LABELV $1863
line 3492
;3491:		}
;3492:	}
LABELV $1858
line 3493
;3493:	if ( ( tf_data.cb_prematch_time > g_globalvars.time ) || tf_data.cease_fire )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GTF4 $1871
ADDRGP4 tf_data+72
INDIRI4
CNSTI4 0
EQI4 $1866
LABELV $1871
line 3494
;3494:	{
line 3495
;3495:		PreMatchImpulses(  );
ADDRGP4 PreMatchImpulses
CALLV
pop
line 3496
;3496:		DeadImpulses(  );
ADDRGP4 DeadImpulses
CALLV
pop
line 3497
;3497:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3498
;3498:		return;
ADDRGP4 $1848
JUMPV
LABELV $1866
line 3500
;3499:	}
;3500:	if ( self->s.v.impulse == 171 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1126891520
NEF4 $1872
line 3501
;3501:		UseSpecialSkill(  );
ADDRGP4 UseSpecialSkill
CALLV
pop
LABELV $1872
line 3503
;3502:
;3503:        if( tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $1874
line 3504
;3504:        {
line 3505
;3505:         	switch ( ( int ) self->s.v.impulse )
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 36
CNSTI4 205
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $1885
ADDRLP4 28
INDIRI4
CNSTI4 206
EQI4 $1886
ADDRLP4 28
INDIRI4
CNSTI4 207
EQI4 $1887
ADDRLP4 28
INDIRI4
ADDRLP4 36
INDIRI4
LTI4 $1876
LABELV $1888
ADDRLP4 28
INDIRI4
CNSTI4 220
LTI4 $1876
ADDRLP4 28
INDIRI4
CNSTI4 225
GTI4 $1876
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1889-880
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1889
address $1879
address $1880
address $1881
address $1882
address $1883
address $1884
code
line 3506
;3506:         	{
LABELV $1879
line 3508
;3507:         	case TG_MAINMENU_IMPULSE:
;3508:         		self->current_menu = TG_MENU_MAIN;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 26
ASGNI4
line 3509
;3509:         		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3510
;3510:         		break;
ADDRGP4 $1877
JUMPV
LABELV $1880
line 3512
;3511:         	case TG_SG_REBUILD_IMPULSE:
;3512:         		Eng_StaticSG_Activate(  );
ADDRGP4 Eng_StaticSG_Activate
CALLV
pop
line 3513
;3513:         		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3514
;3514:         		break;
ADDRGP4 $1877
JUMPV
LABELV $1881
line 3516
;3515:         	case TG_SG_RELOAD_IMPULSE:
;3516:         		Eng_SGReload(  );
ADDRGP4 Eng_SGReload
CALLV
pop
line 3517
;3517:         		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3518
;3518:         		break;
ADDRGP4 $1877
JUMPV
LABELV $1882
line 3520
;3519:         	case TG_SG_UPGRADE_IMPULSE:
;3520:         		Eng_SGUp(  );
ADDRGP4 Eng_SGUp
CALLV
pop
line 3521
;3521:         		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3522
;3522:         		break;
ADDRGP4 $1877
JUMPV
LABELV $1883
line 3524
;3523:         	case TG_DISP_LOAD_IMPULSE:
;3524:         		Eng_DispLoad(  );
ADDRGP4 Eng_DispLoad
CALLV
pop
line 3525
;3525:         		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3526
;3526:         		break;
ADDRGP4 $1877
JUMPV
LABELV $1884
line 3528
;3527:         	case TG_DISP_UNLOAD_IMPULSE:
;3528:         		Eng_DispUnload(  );
ADDRGP4 Eng_DispUnload
CALLV
pop
line 3529
;3529:         		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3530
;3530:         		break;
ADDRGP4 $1877
JUMPV
LABELV $1885
line 3532
;3531:         	case TG_CONC_IMPULSE:
;3532:         		TG_Eff_Conc( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TG_Eff_Conc
CALLV
pop
line 3533
;3533:         		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3534
;3534:         		break;
ADDRGP4 $1877
JUMPV
LABELV $1886
line 3536
;3535:         	case TG_FLASH_IMPULSE:
;3536:         		TG_Eff_Flash( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TG_Eff_Flash
CALLV
pop
line 3537
;3537:         		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3538
;3538:         		break;
ADDRGP4 $1877
JUMPV
LABELV $1887
line 3540
;3539:         	case TG_EFF_REMOVE_IMPULSE:
;3540:         		TG_Eff_Remove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TG_Eff_Remove
CALLV
pop
line 3541
;3541:         		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3542
;3542:         		break;
LABELV $1876
LABELV $1877
line 3544
;3543:         	}
;3544:        }
LABELV $1874
line 3546
;3545:
;3546:	if ( !self->is_building && !self->is_detpacking && !self->is_feigning )
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRP4
CNSTI4 872
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $1891
ADDRLP4 28
INDIRP4
CNSTI4 876
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $1891
ADDRLP4 28
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $1891
line 3547
;3547:	{
line 3548
;3548:		switch ( ( int ) self->s.v.impulse )
ADDRLP4 36
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 44
CNSTI4 69
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $1901
ADDRLP4 36
INDIRI4
ADDRLP4 44
INDIRI4
GTI4 $1916
LABELV $1915
ADDRLP4 36
INDIRI4
CNSTI4 1
LTI4 $1893
ADDRLP4 36
INDIRI4
CNSTI4 22
GTI4 $1917
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1918-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1918
address $1896
address $1896
address $1896
address $1896
address $1896
address $1896
address $1896
address $1896
address $1893
address $1904
address $1893
address $1904
address $1893
address $1893
address $1893
address $1893
address $1893
address $1893
address $1893
address $1893
address $1893
address $1897
code
LABELV $1917
ADDRLP4 36
INDIRI4
CNSTI4 39
EQI4 $1897
ADDRLP4 36
INDIRI4
CNSTI4 40
EQI4 $1896
ADDRGP4 $1893
JUMPV
LABELV $1916
ADDRLP4 36
INDIRI4
CNSTI4 162
LTI4 $1920
ADDRLP4 36
INDIRI4
CNSTI4 176
GTI4 $1921
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1922-648
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1922
address $1906
address $1907
address $1908
address $1909
address $1910
address $1911
address $1893
address $1893
address $1893
address $1893
address $1912
address $1913
address $1893
address $1893
address $1896
code
LABELV $1920
ADDRLP4 36
INDIRI4
CNSTI4 150
EQI4 $1905
ADDRLP4 36
INDIRI4
CNSTI4 151
EQI4 $1905
ADDRGP4 $1893
JUMPV
LABELV $1921
ADDRLP4 36
INDIRI4
CNSTI4 184
EQI4 $1914
ADDRGP4 $1893
JUMPV
line 3549
;3549:		{
LABELV $1896
line 3560
;3550:		case 1:
;3551:		case 2:
;3552:		case 3:
;3553:		case 4:
;3554:		case 5:
;3555:		case 6:
;3556:		case 7:
;3557:		case 8:
;3558:		case 176:
;3559:		case 40:
;3560:			W_ChangeWeapon(  );
ADDRGP4 W_ChangeWeapon
CALLV
pop
line 3561
;3561:			break;
ADDRGP4 $1894
JUMPV
LABELV $1897
line 3564
;3562:		case 22:
;3563:		case 39:
;3564:			if ( tf_data.allow_hook )
ADDRGP4 tf_data+64
INDIRI4
CNSTI4 0
EQI4 $1894
line 3565
;3565:				W_ChangeWeapon(  );
ADDRGP4 W_ChangeWeapon
CALLV
pop
line 3566
;3566:			break;
ADDRGP4 $1894
JUMPV
LABELV $1901
line 3568
;3567:		case 69:
;3568:			if ( self->last_weapon )
ADDRGP4 self
INDIRP4
CNSTI4 1036
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1894
line 3569
;3569:				W_ChangeWeapon(  );
ADDRGP4 W_ChangeWeapon
CALLV
pop
line 3570
;3570:			break;
ADDRGP4 $1894
JUMPV
LABELV $1904
line 3573
;3571:		case 10:
;3572:		case 12:
;3573:			CycleWeaponCommand(  );
ADDRGP4 CycleWeaponCommand
CALLV
pop
line 3574
;3574:			break;
ADDRGP4 $1894
JUMPV
LABELV $1905
line 3577
;3575:		case 150:
;3576:		case 151:
;3577:			TeamFortress_PrimeGrenade(  );
ADDRGP4 TeamFortress_PrimeGrenade
CALLV
pop
line 3578
;3578:			break;
ADDRGP4 $1894
JUMPV
LABELV $1906
line 3580
;3579:		case 162:
;3580:			TeamFortress_Scan_Angel( 10, 0 );
CNSTI4 10
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Scan_Angel
CALLV
pop
line 3581
;3581:			break;
ADDRGP4 $1894
JUMPV
LABELV $1907
line 3583
;3582:		case 163:
;3583:			TeamFortress_Scan_Angel( 30, 0 );
CNSTI4 30
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Scan_Angel
CALLV
pop
line 3584
;3584:			break;
ADDRGP4 $1894
JUMPV
LABELV $1908
line 3586
;3585:		case 164:
;3586:			TeamFortress_Scan_Angel( 100, 0 );
CNSTI4 100
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_Scan_Angel
CALLV
pop
line 3587
;3587:			break;
ADDRGP4 $1894
JUMPV
LABELV $1909
line 3589
;3588:		case 165:
;3589:			TeamFortress_SetDetpack( 5 );
CNSTF4 1084227584
ARGF4
ADDRGP4 TeamFortress_SetDetpack
CALLV
pop
line 3590
;3590:			break;
ADDRGP4 $1894
JUMPV
LABELV $1910
line 3592
;3591:		case 166:
;3592:			TeamFortress_SetDetpack( 20 );
CNSTF4 1101004800
ARGF4
ADDRGP4 TeamFortress_SetDetpack
CALLV
pop
line 3593
;3593:			break;
ADDRGP4 $1894
JUMPV
LABELV $1911
line 3595
;3594:		case 167:
;3595:			TeamFortress_SetDetpack( 50 );
CNSTF4 1112014848
ARGF4
ADDRGP4 TeamFortress_SetDetpack
CALLV
pop
line 3596
;3596:			break;
ADDRGP4 $1894
JUMPV
LABELV $1912
line 3598
;3597:		case 172:
;3598:			self->current_menu = MENU_DROP;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 4
ASGNI4
line 3599
;3599:			self->menu_count = MENU_REFRESH_RATE - 5;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 20
ASGNI4
line 3600
;3600:			break;
ADDRGP4 $1894
JUMPV
LABELV $1913
line 3602
;3601:		case 173:
;3602:			TeamFortress_ReloadCurrentWeapon(  );
ADDRGP4 TeamFortress_ReloadCurrentWeapon
CALLV
pop
line 3603
;3603:			break;
ADDRGP4 $1894
JUMPV
LABELV $1914
line 3605
;3604:		case 184:
;3605:			TeamFortress_Discard(  );
ADDRGP4 TeamFortress_Discard
CALLV
pop
line 3606
;3606:			break;
LABELV $1893
LABELV $1894
line 3608
;3607:		}
;3608:	}
LABELV $1891
line 3609
;3609:	switch ( ( int ) self->s.v.impulse )
ADDRLP4 36
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 44
CNSTI4 135
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $1927
ADDRLP4 36
INDIRI4
ADDRLP4 44
INDIRI4
GTI4 $2063
LABELV $2062
ADDRLP4 36
INDIRI4
CNSTI4 50
LTI4 $2064
ADDRLP4 36
INDIRI4
CNSTI4 61
GTI4 $2065
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2066-200
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2066
address $2025
address $1924
address $1924
address $1969
address $1924
address $2030
address $1972
address $1975
address $1983
address $1924
address $1924
address $1962
code
LABELV $2064
ADDRLP4 36
INDIRI4
CNSTI4 23
EQI4 $2058
ADDRGP4 $1924
JUMPV
LABELV $2065
ADDRLP4 36
INDIRI4
CNSTI4 118
EQI4 $2061
ADDRGP4 $1924
JUMPV
LABELV $2063
ADDRLP4 36
INDIRI4
CNSTI4 169
LTI4 $2068
ADDRLP4 36
INDIRI4
CNSTI4 201
GTI4 $2069
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2070-676
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2070
address $1953
address $1952
address $1924
address $1924
address $1924
address $1924
address $1924
address $1924
address $2042
address $2045
address $2051
address $1924
address $1928
address $1924
address $1924
address $1924
address $1931
address $1932
address $1958
address $1954
address $1924
address $1999
address $1924
address $1924
address $1924
address $1949
address $1924
address $2032
address $2037
address $1924
address $2048
address $2024
address $2031
code
LABELV $2068
ADDRLP4 36
INDIRI4
CNSTI4 152
LTI4 $1924
ADDRLP4 36
INDIRI4
CNSTI4 158
GTI4 $1924
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2072-608
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2072
address $1933
address $1924
address $1934
address $1941
address $1978
address $1988
address $1944
code
LABELV $2069
ADDRLP4 64
CNSTI4 210
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $2055
ADDRLP4 36
INDIRI4
ADDRLP4 64
INDIRI4
LTI4 $1924
LABELV $2074
ADDRLP4 36
INDIRI4
CNSTI4 250
EQI4 $1993
ADDRGP4 $1924
JUMPV
line 3610
;3610:	{
LABELV $1927
line 3612
;3611:	case 135:
;3612:		TeamFortress_Inventory(  );
ADDRGP4 TeamFortress_Inventory
CALLV
pop
line 3613
;3613:		break;
ADDRGP4 $1925
JUMPV
LABELV $1928
line 3615
;3614:	case 181:
;3615:		if ( self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1925
line 3616
;3616:			TeamFortress_SaveMe(  );
ADDRGP4 TeamFortress_SaveMe
CALLV
pop
line 3617
;3617:		break;
ADDRGP4 $1925
JUMPV
LABELV $1931
line 3619
;3618:	case 185:
;3619:		TeamFortress_ID(  );
ADDRGP4 TeamFortress_ID
CALLV
pop
line 3620
;3620:		break;
ADDRGP4 $1925
JUMPV
LABELV $1932
line 3622
;3621:	case 186:
;3622:		TeamFortress_ShowIDs(  );
ADDRGP4 TeamFortress_ShowIDs
CALLV
pop
line 3623
;3623:		break;
ADDRGP4 $1925
JUMPV
LABELV $1933
line 3625
;3624:	case 152:
;3625:		TeamFortress_ThrowGrenade(  );
ADDRGP4 TeamFortress_ThrowGrenade
CALLV
pop
line 3626
;3626:		break;
ADDRGP4 $1925
JUMPV
LABELV $1934
line 3628
;3627:	case 154:
;3628:		G_sprint( self, 2, "--- Airscout Info ---\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1935
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3629
;3629:		G_sprint( self, 2, "Def: A Scout that can jump very high\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1936
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3630
;3630:		G_sprint( self, 2, "Cmd: 'jetjump' or Impulse 155.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1937
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3631
;3631:		G_sprint( self, 2, "    Uses 25 battery cells per jump.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1938
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3632
;3632:		G_sprint( self, 2, "    Aim higher than you want to go.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1939
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3633
;3633:		G_sprint( self, 2, "Use:  Must be a scout,\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1940
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3634
;3634:		break;
ADDRGP4 $1925
JUMPV
LABELV $1941
line 3636
;3635:	case 155:
;3636:		if ( self->playerclass == PC_SCOUT )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1925
line 3637
;3637:			SuperLeap(  );
ADDRGP4 SuperLeap
CALLV
pop
line 3638
;3638:		break;
ADDRGP4 $1925
JUMPV
LABELV $1944
line 3640
;3639:	case 158:
;3640:		if ( self->is_squating == TRUE )
ADDRGP4 self
INDIRP4
CNSTI4 1776
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1945
line 3641
;3641:		{
line 3642
;3642:			self->is_squating = FALSE;
ADDRGP4 self
INDIRP4
CNSTI4 1776
ADDP4
CNSTI4 0
ASGNI4
line 3643
;3643:			self->s.v.frame = 0;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 3644
;3644:			unlay ( );
ADDRGP4 unlay
CALLV
pop
line 3645
;3645:			G_sprint ( self, 2, "Standing mode, (normal)\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1947
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3646
;3646:		}
ADDRGP4 $1925
JUMPV
LABELV $1945
line 3648
;3647:		else
;3648:		{
line 3649
;3649:			self->is_squating = TRUE;
ADDRGP4 self
INDIRP4
CNSTI4 1776
ADDP4
CNSTI4 1
ASGNI4
line 3650
;3650:			lay ( );
ADDRGP4 lay
CALLV
pop
line 3651
;3651:			G_sprint ( self, 2, "Laying mode, (stop walking to lay)\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1948
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3652
;3652:		}
line 3653
;3653:		break;
ADDRGP4 $1925
JUMPV
LABELV $1949
line 3655
;3654:	case 194:
;3655:		if ( self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1925
line 3656
;3656:			DropGoalItems(  );
ADDRGP4 DropGoalItems
CALLV
pop
line 3657
;3657:		break;
ADDRGP4 $1925
JUMPV
LABELV $1952
line 3659
;3658:	case 170:
;3659:		TeamFortress_DetonatePipebombs(  );
ADDRGP4 TeamFortress_DetonatePipebombs
CALLV
pop
line 3660
;3660:		break;
ADDRGP4 $1925
JUMPV
LABELV $1953
line 3662
;3661:	case 169:
;3662:		TeamFortress_DetpackStop(  );
ADDRGP4 TeamFortress_DetpackStop
CALLV
pop
line 3663
;3663:		break;
ADDRGP4 $1925
JUMPV
LABELV $1954
line 3665
;3664:	case 188:
;3665:		if ( self->playerclass == PC_ENGINEER || tg_data.tg_enabled )			
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
EQI4 $1957
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $1925
LABELV $1957
line 3666
;3666:			DestroyBuilding( self, "building_sentrygun" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $256
ARGP4
ADDRGP4 DestroyBuilding
CALLV
pop
line 3667
;3667:		break;
ADDRGP4 $1925
JUMPV
LABELV $1958
line 3669
;3668:	case 187:
;3669:		if ( self->playerclass == PC_ENGINEER || tg_data.tg_enabled )			
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
EQI4 $1961
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $1925
LABELV $1961
line 3670
;3670:			DestroyBuilding( self, "building_dispenser" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $253
ARGP4
ADDRGP4 DestroyBuilding
CALLV
pop
line 3671
;3671:		break;
ADDRGP4 $1925
JUMPV
LABELV $1962
line 3675
;3672:	//mtf
;3673:	// sniper sight
;3674:	case 61:
;3675:		if ( self->playerclass == PC_SNIPER )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1925
line 3676
;3676:		{
line 3677
;3677:			if ( self->option4 == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 1784
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1965
line 3678
;3678:			{
line 3679
;3679:				G_sprint (self, 2, "Laser Sight On\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1967
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3680
;3680:				self->option4 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1784
ADDP4
CNSTI4 0
ASGNI4
line 3681
;3681:			}
ADDRGP4 $1925
JUMPV
LABELV $1965
line 3683
;3682:			else
;3683:			{
line 3684
;3684:				G_sprint (self, 2, "Laser Sight Off\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1968
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3685
;3685:				self->option4 = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1784
ADDP4
CNSTI4 1
ASGNI4
line 3686
;3686:			}
line 3687
;3687:		}
line 3688
;3688:		break;
ADDRGP4 $1925
JUMPV
LABELV $1969
line 3691
;3689:	//menus
;3690:	case 53:
;3691:		if (self->playerclass == 0)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1970
line 3692
;3692:			break;
ADDRGP4 $1925
JUMPV
LABELV $1970
line 3693
;3693:		self->current_menu = MENU_TAUNT;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 33
ASGNI4
line 3694
;3694:		self->menu_count = MENU_TAUNT;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 33
ASGNI4
line 3695
;3695:		break;
ADDRGP4 $1925
JUMPV
LABELV $1972
line 3697
;3696:	case 56:
;3697:		if (self->playerclass == 0)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1973
line 3698
;3698:			break;
ADDRGP4 $1925
JUMPV
LABELV $1973
line 3699
;3699:		self->current_menu = MENU_YELL;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 32
ASGNI4
line 3700
;3700:		self->menu_count = MENU_YELL;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 32
ASGNI4
line 3701
;3701:		break;
ADDRGP4 $1925
JUMPV
LABELV $1975
line 3703
;3702:	case 57:
;3703:		if (self->playerclass == 0)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1976
line 3704
;3704:			break;
ADDRGP4 $1925
JUMPV
LABELV $1976
line 3705
;3705:		self->current_menu = MENU_DROPSTUFF;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 34
ASGNI4
line 3706
;3706:		self->menu_count = MENU_DROPSTUFF;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 34
ASGNI4
line 3707
;3707:		break;	
ADDRGP4 $1925
JUMPV
LABELV $1978
line 3710
;3708:	// taunts
;3709:	case 156:
;3710:		if (self->last_saveme_sound <= g_globalvars.time) {
ADDRGP4 self
INDIRP4
CNSTI4 1084
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GTF4 $1925
line 3711
;3711:			self->last_saveme_sound = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 1084
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 3712
;3712:			muzzleflash( );
ADDRGP4 muzzleflash
CALLV
pop
line 3713
;3713:			sound( self, 0, "speech/hey.wav", 0.7, 0 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $111
ARGP4
CNSTF4 1060320051
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 3714
;3714:		}
line 3715
;3715:		break;
ADDRGP4 $1925
JUMPV
LABELV $1983
line 3717
;3716:	case 58:
;3717:		if (self->last_saveme_sound <= g_globalvars.time) {
ADDRGP4 self
INDIRP4
CNSTI4 1084
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GTF4 $1925
line 3718
;3718:			self->last_saveme_sound = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 1084
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 3719
;3719:			muzzleflash( );
ADDRGP4 muzzleflash
CALLV
pop
line 3720
;3720:			sound( self, 0, "speech/threat.wav", 0.7, 0 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $110
ARGP4
CNSTF4 1060320051
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 3721
;3721:		}
line 3722
;3722:		break;
ADDRGP4 $1925
JUMPV
LABELV $1988
line 3724
;3723:	case 157:
;3724:		if (self->last_saveme_sound <= g_globalvars.time) {
ADDRGP4 self
INDIRP4
CNSTI4 1084
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GTF4 $1925
line 3725
;3725:			self->last_saveme_sound = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 1084
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 3726
;3726:			muzzleflash( );
ADDRGP4 muzzleflash
CALLV
pop
line 3727
;3727:			sound( self, 0, "speech/cmyhole.wav", 0.7, 0 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $112
ARGP4
CNSTF4 1060320051
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 3728
;3728:		}
line 3729
;3729:		break;
ADDRGP4 $1925
JUMPV
LABELV $1993
line 3731
;3730:	case 250:
;3731:		if (self->last_saveme_sound <= g_globalvars.time) {
ADDRGP4 self
INDIRP4
CNSTI4 1084
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GTF4 $1925
line 3732
;3732:			self->last_saveme_sound = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 1084
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 3733
;3733:			muzzleflash( );
ADDRGP4 muzzleflash
CALLV
pop
line 3734
;3734:			sound( self, 1, "speech/pantsdwn.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $104
ARGP4
ADDRLP4 68
CNSTF4 1065353216
ASGNF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 3735
;3735:			G_sprint( self, 1, MEGATF_VERSION );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1998
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3736
;3736:		}
line 3737
;3737:		break;
ADDRGP4 $1925
JUMPV
LABELV $1999
line 3740
;3738:	// drop1
;3739:	case 190:
;3740:		if (!tf_data.drop1) {
ADDRGP4 tf_data+212
INDIRI4
CNSTI4 0
NEI4 $2000
line 3741
;3741:			G_sprint (self, 2, "Type 1 weapons disabled by Admin!\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $2003
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3742
;3742:			break;
ADDRGP4 $1925
JUMPV
LABELV $2000
line 3744
;3743:		}
;3744:		if ( ( int ) self->s.v.flags & FL_ONGROUND )	// player must be on ground to drop
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1925
line 3745
;3745:		{
line 3746
;3746:			if ( self->playerclass == PC_SCOUT )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2006
line 3747
;3747:				C_Mine ( );
ADDRGP4 C_Mine
CALLV
pop
ADDRGP4 $1925
JUMPV
LABELV $2006
line 3748
;3748:			else if (self->playerclass == PC_SNIPER)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2008
line 3749
;3749:				A_Mine ( );
ADDRGP4 A_Mine
CALLV
pop
ADDRGP4 $1925
JUMPV
LABELV $2008
line 3750
;3750:			else if (self->playerclass == PC_SOLDIER)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2010
line 3751
;3751:				S_Mine ( );
ADDRGP4 S_Mine
CALLV
pop
ADDRGP4 $1925
JUMPV
LABELV $2010
line 3752
;3752:			else if (self->playerclass == PC_DEMOMAN)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
NEI4 $2012
line 3753
;3753:				BalloonMIRV ( );
ADDRGP4 BalloonMIRV
CALLV
pop
ADDRGP4 $1925
JUMPV
LABELV $2012
line 3754
;3754:			else if (self->playerclass == PC_MEDIC)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 5
NEI4 $2014
line 3755
;3755:				B_Mine ( );
ADDRGP4 B_Mine
CALLV
pop
ADDRGP4 $1925
JUMPV
LABELV $2014
line 3756
;3756:			else if (self->playerclass == PC_HVYWEAP)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2016
line 3757
;3757:				S_Mine ( );
ADDRGP4 S_Mine
CALLV
pop
ADDRGP4 $1925
JUMPV
LABELV $2016
line 3758
;3758:			else if (self->playerclass == PC_PYRO)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 7
NEI4 $2018
line 3759
;3759:				LavaPool ( );
ADDRGP4 LavaPool
CALLV
pop
ADDRGP4 $1925
JUMPV
LABELV $2018
line 3760
;3760:			else if (self->playerclass == PC_SPY)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $2020
line 3761
;3761:				SpyPack ( );
ADDRGP4 SpyPack
CALLV
pop
ADDRGP4 $1925
JUMPV
LABELV $2020
line 3762
;3762:			else if (self->playerclass == PC_ENGINEER)
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1925
line 3763
;3763:				M_Mine ( );
ADDRGP4 M_Mine
CALLV
pop
line 3764
;3764:		}
line 3765
;3765:		break;
ADDRGP4 $1925
JUMPV
LABELV $2024
line 3767
;3766:	case 200:
;3767:		MakeHolo( );
ADDRGP4 MakeHolo
CALLV
pop
line 3768
;3768:		break;
ADDRGP4 $1925
JUMPV
LABELV $2025
line 3771
;3769:	case 50:
;3770:		//night vision
;3771:		if ( self->vision != 1 ) {
ADDRGP4 self
INDIRP4
CNSTI4 1792
ADDP4
INDIRI4
CNSTI4 1
EQI4 $2026
line 3772
;3772:			self->vision = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1792
ADDP4
CNSTI4 1
ASGNI4
line 3773
;3773:			stuffcmd( self, "v_cshift 0 100 0 100\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $2028
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 3774
;3774:		}
ADDRGP4 $1925
JUMPV
LABELV $2026
line 3775
;3775:		else {
line 3776
;3776:			self->vision = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1792
ADDP4
CNSTI4 0
ASGNI4
line 3777
;3777:			stuffcmd( self, "v_cshift 0 0 0 0\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $2029
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 3778
;3778:		}
line 3779
;3779:		break;
ADDRGP4 $1925
JUMPV
LABELV $2030
line 3781
;3780:	case 55:
;3781:		Drop3 ( );
ADDRGP4 Drop3
CALLV
pop
line 3782
;3782:		break;
ADDRGP4 $1925
JUMPV
LABELV $2031
line 3784
;3783:	case 201:
;3784:		Toaster ( );
ADDRGP4 Toaster
CALLV
pop
line 3785
;3785:		break;
ADDRGP4 $1925
JUMPV
LABELV $2032
line 3787
;3786:	case 196:
;3787:		if ( self->playerclass == PC_ENGINEER || tg_data.tg_enabled )			
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
EQI4 $2035
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $1925
LABELV $2035
line 3788
;3788:			DestroyBuilding( self, "building_teleporter_exit" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $2036
ARGP4
ADDRGP4 DestroyBuilding
CALLV
pop
line 3789
;3789:		break;
ADDRGP4 $1925
JUMPV
LABELV $2037
line 3791
;3790:	case 197:
;3791:		if ( self->playerclass == PC_ENGINEER || tg_data.tg_enabled )			
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
EQI4 $2040
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $1925
LABELV $2040
line 3792
;3792:			DestroyBuilding( self, "building_teleporter_entrance" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $2041
ARGP4
ADDRGP4 DestroyBuilding
CALLV
pop
line 3793
;3793:		break;
ADDRGP4 $1925
JUMPV
LABELV $2042
line 3795
;3794:	case 177:
;3795:		if ( self->playerclass == PC_SPY )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1925
line 3796
;3796:			TeamFortress_SpyGoUndercover(  );
ADDRGP4 TeamFortress_SpyGoUndercover
CALLV
pop
line 3797
;3797:		break;
ADDRGP4 $1925
JUMPV
LABELV $2045
line 3799
;3798:	case 178:
;3799:		if ( self->playerclass == PC_SPY )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1925
line 3800
;3800:			TeamFortress_SpyFeignDeath( 0 );
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_SpyFeignDeath
CALLV
pop
line 3801
;3801:		break;
ADDRGP4 $1925
JUMPV
LABELV $2048
line 3803
;3802:	case TF_SPY_SFEIGN_IMPULSE:
;3803:		if ( self->playerclass == PC_SPY )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1925
line 3804
;3804:			TeamFortress_SpyFeignDeath( 1 );
CNSTI4 1
ARGI4
ADDRGP4 TeamFortress_SpyFeignDeath
CALLV
pop
line 3805
;3805:		break;
ADDRGP4 $1925
JUMPV
LABELV $2051
line 3807
;3806:	case 179:
;3807:		if ( self->playerclass == PC_ENGINEER || tg_data.tg_enabled )			
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
EQI4 $2054
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $1925
LABELV $2054
line 3808
;3808:			TeamFortress_EngineerBuild(  );
ADDRGP4 TeamFortress_EngineerBuild
CALLV
pop
line 3809
;3809:		break;
ADDRGP4 $1925
JUMPV
LABELV $2055
line 3811
;3810:	case AUTOSCAN_IMPULSE:
;3811:		if ( self->playerclass == PC_SCOUT )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1925
line 3812
;3812:			ScannerSwitch(  );
ADDRGP4 ScannerSwitch
CALLV
pop
line 3813
;3813:		break;
ADDRGP4 $1925
JUMPV
LABELV $2058
line 3815
;3814:	case 23:
;3815:		if ( CTF_Map == 1 )
ADDRGP4 CTF_Map
INDIRI4
CNSTI4 1
NEI4 $2059
line 3816
;3816:			TeamFortress_CTF_FlagInfo(  );
ADDRGP4 TeamFortress_CTF_FlagInfo
CALLV
pop
ADDRGP4 $1925
JUMPV
LABELV $2059
line 3818
;3817:		else
;3818:			TeamFortress_DisplayDetectionItems(  );
ADDRGP4 TeamFortress_DisplayDetectionItems
CALLV
pop
line 3819
;3819:		break;
ADDRGP4 $1925
JUMPV
LABELV $2061
line 3821
;3820:	case 118:
;3821:		display_location(  );
ADDRGP4 display_location
CALLV
pop
line 3822
;3822:		break;
ADDRGP4 $1925
JUMPV
LABELV $1924
line 3824
;3823:	default:
;3824:		DeadImpulses(  );
ADDRGP4 DeadImpulses
CALLV
pop
line 3825
;3825:		break;
LABELV $1925
line 3827
;3826:	}
;3827:	if ( self->s.v.impulse == 168 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1126694912
NEF4 $2075
line 3828
;3828:	{
line 3829
;3829:		self->last_impulse = self->s.v.impulse;
ADDRLP4 68
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 688
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 3830
;3830:	}
LABELV $2075
line 3831
;3831:	if ( self->s.v.impulse == 159 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1126105088
NEF4 $2077
line 3832
;3832:		self->last_impulse = self->s.v.impulse;
ADDRLP4 68
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 688
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ASGNI4
LABELV $2077
line 3833
;3833:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3834
;3834:}
LABELV $1848
endproc ImpulseCommands 72 20
export PreMatchImpulses
proc PreMatchImpulses 36 0
line 3837
;3835:
;3836:void PreMatchImpulses(  )
;3837:{
line 3838
;3838:	switch ( ( int ) self->s.v.impulse )
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 39
EQI4 $2084
ADDRLP4 8
CNSTI4 40
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $2083
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
GTI4 $2090
LABELV $2089
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $2080
ADDRLP4 0
INDIRI4
CNSTI4 22
GTI4 $2080
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2091-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2091
address $2083
address $2083
address $2083
address $2083
address $2083
address $2083
address $2083
address $2083
address $2080
address $2088
address $2080
address $2088
address $2080
address $2080
address $2080
address $2080
address $2080
address $2080
address $2080
address $2080
address $2080
address $2084
code
LABELV $2090
ADDRLP4 0
INDIRI4
CNSTI4 176
EQI4 $2083
ADDRGP4 $2080
JUMPV
line 3839
;3839:	{
LABELV $2083
line 3850
;3840:	case 1:
;3841:	case 2:
;3842:	case 3:
;3843:	case 4:
;3844:	case 5:
;3845:	case 6:
;3846:	case 7:
;3847:	case 8:
;3848:	case 176:
;3849:	case 40:
;3850:		W_ChangeWeapon(  );
ADDRGP4 W_ChangeWeapon
CALLV
pop
line 3851
;3851:		break;
ADDRGP4 $2081
JUMPV
LABELV $2084
line 3854
;3852:	case 22:
;3853:	case 39:
;3854:		if ( tf_data.allow_hook )
ADDRGP4 tf_data+64
INDIRI4
CNSTI4 0
EQI4 $2081
line 3855
;3855:			W_ChangeWeapon(  );
ADDRGP4 W_ChangeWeapon
CALLV
pop
line 3856
;3856:		break;
ADDRGP4 $2081
JUMPV
LABELV $2088
line 3859
;3857:	case 10:
;3858:	case 12:
;3859:		CycleWeaponCommand(  );
ADDRGP4 CycleWeaponCommand
CALLV
pop
line 3860
;3860:		break;
LABELV $2080
LABELV $2081
line 3862
;3861:	}
;3862:	switch ( ( int ) self->s.v.impulse )
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 24
CNSTI4 118
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $2101
ADDRLP4 16
INDIRI4
ADDRLP4 24
INDIRI4
GTI4 $2103
LABELV $2102
ADDRLP4 16
INDIRI4
CNSTI4 23
EQI4 $2098
ADDRGP4 $2093
JUMPV
LABELV $2103
ADDRLP4 32
CNSTI4 135
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $2096
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRI4
LTI4 $2093
LABELV $2104
ADDRLP4 16
INDIRI4
CNSTI4 185
EQI4 $2097
ADDRGP4 $2093
JUMPV
line 3863
;3863:	{
LABELV $2096
line 3865
;3864:	case 135:
;3865:		TeamFortress_Inventory(  );
ADDRGP4 TeamFortress_Inventory
CALLV
pop
line 3866
;3866:		break;
ADDRGP4 $2094
JUMPV
LABELV $2097
line 3868
;3867:	case 185:
;3868:		TeamFortress_ID(  );
ADDRGP4 TeamFortress_ID
CALLV
pop
line 3869
;3869:		break;
ADDRGP4 $2094
JUMPV
LABELV $2098
line 3871
;3870:	case 23:
;3871:		if ( CTF_Map == 1 )
ADDRGP4 CTF_Map
INDIRI4
CNSTI4 1
NEI4 $2099
line 3872
;3872:			TeamFortress_CTF_FlagInfo(  );
ADDRGP4 TeamFortress_CTF_FlagInfo
CALLV
pop
ADDRGP4 $2094
JUMPV
LABELV $2099
line 3874
;3873:		else
;3874:			TeamFortress_DisplayDetectionItems(  );
ADDRGP4 TeamFortress_DisplayDetectionItems
CALLV
pop
line 3875
;3875:		break;
ADDRGP4 $2094
JUMPV
LABELV $2101
line 3877
;3876:	case 118:
;3877:		display_location(  );
ADDRGP4 display_location
CALLV
pop
line 3878
;3878:		break;
LABELV $2093
LABELV $2094
line 3880
;3879:	}
;3880:}
LABELV $2079
endproc PreMatchImpulses 36 0
export DeadImpulses
proc DeadImpulses 44 12
line 3883
;3881:
;3882:void DeadImpulses(  )
;3883:{
line 3884
;3884:	switch ( ( int ) self->s.v.impulse )
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 8
CNSTI4 119
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $2119
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
GTI4 $2139
LABELV $2138
ADDRLP4 16
CNSTI4 23
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $2133
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
GTI4 $2141
LABELV $2140
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2136
ADDRGP4 $2105
JUMPV
LABELV $2141
ADDRLP4 0
INDIRI4
CNSTI4 71
LTI4 $2105
ADDRLP4 0
INDIRI4
CNSTI4 110
GTI4 $2105
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2142-284
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2142
address $2132
address $2132
address $2132
address $2132
address $2132
address $2132
address $2132
address $2132
address $2132
address $2132
address $2132
address $2105
address $2105
address $2105
address $2105
address $2105
address $2105
address $2105
address $2105
address $2105
address $2105
address $2105
address $2105
address $2105
address $2105
address $2105
address $2105
address $2105
address $2113
address $2112
address $2112
address $2112
address $2112
address $2112
address $2112
address $2112
address $2112
address $2112
address $2112
address $2112
code
LABELV $2139
ADDRLP4 28
CNSTI4 174
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $2110
ADDRLP4 0
INDIRI4
ADDRLP4 28
INDIRI4
GTI4 $2145
LABELV $2144
ADDRLP4 0
INDIRI4
CNSTI4 131
LTI4 $2105
ADDRLP4 0
INDIRI4
CNSTI4 145
GTI4 $2105
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2146-524
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2146
address $2118
address $2105
address $2105
address $2105
address $2105
address $2109
address $2111
address $2105
address $2105
address $2120
address $2121
address $2122
address $2123
address $2125
address $2124
code
LABELV $2145
ADDRLP4 0
INDIRI4
CNSTI4 182
EQI4 $2126
ADDRLP4 0
INDIRI4
CNSTI4 183
EQI4 $2130
ADDRGP4 $2105
JUMPV
line 3885
;3885:	{
LABELV $2109
line 3887
;3886:	case 136:
;3887:		TeamFortress_ShowTF(  );
ADDRGP4 TeamFortress_ShowTF
CALLV
pop
line 3888
;3888:		break;
ADDRGP4 $2107
JUMPV
LABELV $2110
line 3890
;3889:	case 174:
;3890:		TeamFortress_AutoZoomToggle(  );
ADDRGP4 TeamFortress_AutoZoomToggle
CALLV
pop
line 3891
;3891:		break;
ADDRGP4 $2107
JUMPV
LABELV $2111
line 3893
;3892:	case 137:
;3893:		TeamFortress_DisplayLegalClasses(  );
ADDRGP4 TeamFortress_DisplayLegalClasses
CALLV
pop
line 3894
;3894:		break;
ADDRGP4 $2107
JUMPV
LABELV $2112
line 3906
;3895:	case 100:
;3896:	case 101:
;3897:	case 102:
;3898:	case 103:
;3899:	case 104:
;3900:	case 105:
;3901:	case 106:
;3902:	case 107:
;3903:	case 108:
;3904:	case 109:
;3905:	case 110:
;3906:		TeamFortress_ChangeClass(  );
ADDRGP4 TeamFortress_ChangeClass
CALLV
pop
line 3907
;3907:		break;
ADDRGP4 $2107
JUMPV
LABELV $2113
line 3909
;3908:	case 99:
;3909:		if ( self->playerclass && deathmatch == 3 && ( tf_data.cb_prematch_time < g_globalvars.time ) )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2107
ADDRGP4 deathmatch
INDIRI4
CNSTI4 3
NEI4 $2107
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $2107
line 3910
;3910:		{
line 3911
;3911:			self->current_menu = MENU_CHANGECLASS;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 20
ASGNI4
line 3912
;3912:			self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 3913
;3913:		}
line 3914
;3914:		break;
ADDRGP4 $2107
JUMPV
LABELV $2118
line 3916
;3915:	case 131:
;3916:		TeamFortress_HelpMap(  );
ADDRGP4 TeamFortress_HelpMap
CALLV
pop
line 3917
;3917:		break;
ADDRGP4 $2107
JUMPV
LABELV $2119
line 3919
;3918:	case 119:
;3919:		TeamFortress_StatusQuery(  );
ADDRGP4 TeamFortress_StatusQuery
CALLV
pop
line 3920
;3920:		break;
ADDRGP4 $2107
JUMPV
LABELV $2120
line 3922
;3921:	case 140:
;3922:		TeamFortress_TeamSet( 1 );
CNSTI4 1
ARGI4
ADDRGP4 TeamFortress_TeamSet
CALLI4
pop
line 3923
;3923:		break;
ADDRGP4 $2107
JUMPV
LABELV $2121
line 3925
;3924:	case 141:
;3925:		TeamFortress_TeamSet( 2 );
CNSTI4 2
ARGI4
ADDRGP4 TeamFortress_TeamSet
CALLI4
pop
line 3926
;3926:		break;
ADDRGP4 $2107
JUMPV
LABELV $2122
line 3928
;3927:	case 142:
;3928:		TeamFortress_TeamSet( 3 );
CNSTI4 3
ARGI4
ADDRGP4 TeamFortress_TeamSet
CALLI4
pop
line 3929
;3929:		break;
ADDRGP4 $2107
JUMPV
LABELV $2123
line 3931
;3930:	case 143:
;3931:		TeamFortress_TeamSet( 4 );
CNSTI4 4
ARGI4
ADDRGP4 TeamFortress_TeamSet
CALLI4
pop
line 3932
;3932:		break;
ADDRGP4 $2107
JUMPV
LABELV $2124
line 3934
;3933:	case 145:
;3934:		TeamFortress_TeamShowScores( 0 );
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_TeamShowScores
CALLV
pop
line 3935
;3935:		break;
ADDRGP4 $2107
JUMPV
LABELV $2125
line 3937
;3936:	case 144:
;3937:		TeamFortress_TeamShowMemberClasses_New( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_TeamShowMemberClasses_New
CALLV
pop
line 3938
;3938:		break;
ADDRGP4 $2107
JUMPV
LABELV $2126
line 3940
;3939:	case 182:
;3940:		self->StatusRefreshTime = g_globalvars.time + 0.2;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 3941
;3941:		self->StatusBarSize = self->StatusBarSize + 1;
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 1488
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3942
;3942:		if ( self->StatusBarSize > 2 )
ADDRGP4 self
INDIRP4
CNSTI4 1488
ADDP4
INDIRI4
CNSTI4 2
LEI4 $2107
line 3943
;3943:			self->StatusBarSize = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1488
ADDP4
CNSTI4 1
ASGNI4
line 3944
;3944:		break;
ADDRGP4 $2107
JUMPV
LABELV $2130
line 3946
;3945:	case 183:
;3946:		self->StatusRefreshTime = g_globalvars.time + 60;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 3947
;3947:		self->StatusBarSize = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1488
ADDP4
CNSTI4 0
ASGNI4
line 3948
;3948:		break;
ADDRGP4 $2107
JUMPV
LABELV $2132
line 3960
;3949:	case 71:
;3950:	case 72:
;3951:	case 73:
;3952:	case 74:
;3953:	case 75:
;3954:	case 76:
;3955:	case 77:
;3956:	case 78:
;3957:	case 79:
;3958:	case 80:
;3959:	case 81:
;3960:		StatusRes( self->s.v.impulse - 71 );
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1116602368
SUBF4
CVFI4 4
ARGI4
ADDRGP4 StatusRes
CALLV
pop
line 3961
;3961:		break;
ADDRGP4 $2107
JUMPV
LABELV $2133
line 3963
;3962:	case 23:
;3963:		if ( CTF_Map == 1 )
ADDRGP4 CTF_Map
INDIRI4
CNSTI4 1
NEI4 $2134
line 3964
;3964:			TeamFortress_CTF_FlagInfo(  );
ADDRGP4 TeamFortress_CTF_FlagInfo
CALLV
pop
ADDRGP4 $2107
JUMPV
LABELV $2134
line 3966
;3965:		else
;3966:			TeamFortress_DisplayDetectionItems(  );
ADDRGP4 TeamFortress_DisplayDetectionItems
CALLV
pop
line 3967
;3967:		break;
ADDRGP4 $2107
JUMPV
LABELV $2136
line 3969
;3968:	case 13:
;3969:		G_sprint( self, 2, "Aliases checked.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $2137
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 3970
;3970:		self->got_aliases = 1;
ADDRGP4 self
INDIRP4
CNSTI4 856
ADDP4
CNSTI4 1
ASGNI4
line 3971
;3971:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3972
;3972:		break;
line 3974
;3973:	default:
;3974:	        return;
LABELV $2107
line 3976
;3975:	}
;3976:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3977
;3977:}
LABELV $2105
endproc DeadImpulses 44 12
export Angel_SaveImpulse
proc Angel_SaveImpulse 44 0
line 3989
;3978:#define SI_DETPIPE 1
;3979:#define SI_THROWGREN 2
;3980:#define SI_PRIMEONE 4
;3981:#define SI_PRIMETWO 8
;3982:#define SI_DISCARD 16		// fix me: do not save discard?
;3983:#define SI_INV 32
;3984:#define SI_ID 64
;3985:#define SI_SPECIAL 128
;3986:#define SI_RELOAD 256
;3987:
;3988:void Angel_SaveImpulse( int impulse )
;3989:{
line 3990
;3990:	if ( self->s.v.impulse <= 9 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1091567616
GTF4 $2149
line 3991
;3991:	{
line 3992
;3992:		if ( self->current_weapon == 8 )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 8
NEI4 $2151
line 3993
;3993:			return;
ADDRGP4 $2148
JUMPV
LABELV $2151
line 3994
;3994:		self->imp1 = self->s.v.impulse;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1548
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 3995
;3995:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 3996
;3996:		return;
ADDRGP4 $2148
JUMPV
LABELV $2149
line 3998
;3997:	}
;3998:	if ( self->s.v.impulse == 152 && ( self->tfstate & TFSTATE_GRENPRIMED ) )
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1125646336
NEF4 $2153
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2153
line 3999
;3999:		self->tf_impulse = self->tf_impulse | SI_THROWGREN;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
ADDRGP4 $2154
JUMPV
LABELV $2153
line 4000
;4000:	else if ( self->s.v.impulse == 170 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1126825984
NEF4 $2155
line 4001
;4001:		self->tf_impulse = self->tf_impulse | SI_DETPIPE;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
ADDRGP4 $2156
JUMPV
LABELV $2155
line 4002
;4002:	else if ( self->s.v.impulse == 171 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1126891520
NEF4 $2157
line 4003
;4003:		self->tf_impulse = self->tf_impulse | SI_SPECIAL;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
ADDRGP4 $2158
JUMPV
LABELV $2157
line 4004
;4004:	else if ( self->s.v.impulse == 173 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1127022592
NEF4 $2159
line 4005
;4005:		self->tf_impulse = self->tf_impulse | SI_RELOAD;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
ADDRGP4 $2160
JUMPV
LABELV $2159
line 4006
;4006:	else if ( self->s.v.impulse == 184 )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1127743488
NEF4 $2161
line 4007
;4007:		self->tf_impulse = self->tf_impulse | SI_DISCARD;
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
ADDRGP4 $2162
JUMPV
LABELV $2161
line 4008
;4008:	else if ( self->s.v.impulse == 150 && !( self->tfstate & TFSTATE_GRENPRIMED ) )
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1125515264
NEF4 $2163
ADDRLP4 24
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $2163
line 4009
;4009:	{
line 4010
;4010:		self->tf_impulse = self->tf_impulse - ( self->tf_impulse & SI_PRIMETWO );
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRI4
ADDRLP4 32
INDIRI4
CNSTI4 8
BANDI4
SUBI4
ASGNI4
line 4011
;4011:		self->tf_impulse = self->tf_impulse | SI_PRIMEONE;
ADDRLP4 36
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 4012
;4012:	} else if ( self->s.v.impulse == 151 && !( self->tfstate & TFSTATE_GRENPRIMED ) )
ADDRGP4 $2164
JUMPV
LABELV $2163
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1125580800
NEF4 $2148
ADDRLP4 28
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $2148
line 4013
;4013:	{
line 4014
;4014:		self->tf_impulse = self->tf_impulse - ( self->tf_impulse & SI_PRIMEONE );
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 4
BANDI4
SUBI4
ASGNI4
line 4015
;4015:		self->tf_impulse = self->tf_impulse | SI_PRIMETWO;
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 4016
;4016:	} else
line 4017
;4017:		return;		// do not save impulse
LABELV $2166
LABELV $2164
LABELV $2162
LABELV $2160
LABELV $2158
LABELV $2156
LABELV $2154
line 4019
;4018:
;4019:	self->s.v.impulse = 0;	// reset impulse, chto by ne bylo gemora
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 4020
;4020:}
LABELV $2148
endproc Angel_SaveImpulse 44 0
export Angel_GetSavedImpulse
proc Angel_GetSavedImpulse 12 0
line 4023
;4021:
;4022:int Angel_GetSavedImpulse(  )
;4023:{
line 4028
;4024:	int     saved;
;4025:
;4026:	// throwgren MUST be after priming;
;4027:	// special and reload MUST BE LAST!!!
;4028:	if ( self->tf_impulse & SI_PRIMEONE )
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2168
line 4029
;4029:	{
line 4030
;4030:		self->tf_impulse = self->tf_impulse - ( self->tf_impulse & SI_PRIMEONE );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 1544
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
CNSTI4 4
BANDI4
SUBI4
ASGNI4
line 4031
;4031:		return 150;
CNSTI4 150
RETI4
ADDRGP4 $2167
JUMPV
LABELV $2168
line 4032
;4032:	} else if ( self->tf_impulse & SI_PRIMETWO )
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $2170
line 4033
;4033:	{
line 4034
;4034:		self->tf_impulse = self->tf_impulse - ( self->tf_impulse & SI_PRIMETWO );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 1544
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
CNSTI4 8
BANDI4
SUBI4
ASGNI4
line 4035
;4035:		return 151;
CNSTI4 151
RETI4
ADDRGP4 $2167
JUMPV
LABELV $2170
line 4036
;4036:	} else if ( self->tf_impulse & SI_THROWGREN )
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2172
line 4037
;4037:	{
line 4038
;4038:		self->tf_impulse = self->tf_impulse - ( self->tf_impulse & SI_THROWGREN );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 1544
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
CNSTI4 2
BANDI4
SUBI4
ASGNI4
line 4039
;4039:		return 152;
CNSTI4 152
RETI4
ADDRGP4 $2167
JUMPV
LABELV $2172
line 4040
;4040:	} else if ( self->tf_impulse & SI_DETPIPE )
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2174
line 4041
;4041:	{
line 4042
;4042:		self->tf_impulse = self->tf_impulse - ( self->tf_impulse & SI_DETPIPE );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 1544
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
CNSTI4 1
BANDI4
SUBI4
ASGNI4
line 4043
;4043:		return 170;
CNSTI4 170
RETI4
ADDRGP4 $2167
JUMPV
LABELV $2174
line 4044
;4044:	} else if ( self->imp1 )
ADDRGP4 self
INDIRP4
CNSTI4 1548
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2176
line 4045
;4045:	{
line 4046
;4046:		saved = self->imp1;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1548
ADDP4
INDIRI4
ASGNI4
line 4047
;4047:		self->imp1 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1548
ADDP4
CNSTI4 0
ASGNI4
line 4048
;4048:		return saved;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $2167
JUMPV
LABELV $2176
line 4049
;4049:	} else if ( self->tf_impulse & SI_DISCARD )
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $2178
line 4050
;4050:	{
line 4051
;4051:		self->tf_impulse = self->tf_impulse - ( self->tf_impulse & SI_DISCARD );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 1544
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
CNSTI4 16
BANDI4
SUBI4
ASGNI4
line 4052
;4052:		return 184;
CNSTI4 184
RETI4
ADDRGP4 $2167
JUMPV
LABELV $2178
line 4053
;4053:	} else if ( self->tf_impulse & SI_SPECIAL )
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $2180
line 4054
;4054:	{
line 4055
;4055:		self->tf_impulse = self->tf_impulse - ( self->tf_impulse & SI_SPECIAL );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 1544
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
CNSTI4 128
BANDI4
SUBI4
ASGNI4
line 4056
;4056:		return 171;
CNSTI4 171
RETI4
ADDRGP4 $2167
JUMPV
LABELV $2180
line 4057
;4057:	} else if ( self->tf_impulse & SI_RELOAD )
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $2182
line 4058
;4058:	{
line 4059
;4059:		self->tf_impulse = self->tf_impulse - ( self->tf_impulse & SI_RELOAD );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 1544
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
CNSTI4 256
BANDI4
SUBI4
ASGNI4
line 4060
;4060:		return 173;
CNSTI4 173
RETI4
ADDRGP4 $2167
JUMPV
LABELV $2182
line 4069
;4061:	}
;4062:/* REMOVE!!!
;4063:if (self.imp1){
;4064:   saved = self.imp1;
;4065:   self.imp1 = 0;
;4066:   return saved;
;4067:  }*/
;4068:
;4069:	return 0;
CNSTI4 0
RETI4
LABELV $2167
endproc Angel_GetSavedImpulse 12 0
export W_WeaponFrame
proc W_WeaponFrame 68 4
line 4073
;4070:}
;4071:
;4072:void W_WeaponFrame(  )
;4073:{
line 4076
;4074:	vec3_t  tv;
;4075:
;4076:	if ( !( self->tfstate & TFSTATE_AIMING ) )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
NEI4 $2185
line 4077
;4077:	{
line 4078
;4078:		if ( self->height > 29 && self->height < 90 )
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 1105723392
LEF4 $2187
ADDRLP4 12
INDIRF4
CNSTF4 1119092736
GEF4 $2187
line 4079
;4079:		{
line 4080
;4080:			self->height = self->height + 8;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 4081
;4081:			if ( self->height > 90 )
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
CNSTF4 1119092736
LEF4 $2189
line 4082
;4082:				self->height = 90;
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
CNSTF4 1119092736
ASGNF4
LABELV $2189
line 4083
;4083:			TF_zoom( self->height );
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 TF_zoom
CALLV
pop
line 4084
;4084:		}
LABELV $2187
line 4085
;4085:	}
LABELV $2185
line 4086
;4086:	if ( self->current_menu > 0 )
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2191
line 4087
;4087:	{
line 4088
;4088:		Player_Menu(  );
ADDRGP4 Player_Menu
CALLV
pop
line 4089
;4089:		if ( self->s.v.impulse > 0
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 0
LEF4 $2193
ADDRLP4 16
ADDRLP4 12
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 23
EQI4 $2196
ADDRLP4 16
INDIRI4
CNSTI4 24
EQI4 $2196
ADDRLP4 16
INDIRI4
CNSTI4 25
NEI4 $2193
LABELV $2196
line 4091
;4090:		     && ( self->current_menu == 23 || self->current_menu == 24 || self->current_menu == 25 ) )
;4091:			Menu_Input( self->s.v.impulse );
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Menu_Input
CALLV
pop
ADDRGP4 $2194
JUMPV
LABELV $2193
line 4093
;4092:		else
;4093:		{
line 4094
;4094:			if ( self->s.v.impulse > 0 && self->s.v.impulse < 11 )
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 0
LEF4 $2197
ADDRLP4 20
INDIRF4
CNSTF4 1093664768
GEF4 $2197
line 4095
;4095:			{
line 4096
;4096:				Menu_Input( self->s.v.impulse );
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Menu_Input
CALLV
pop
line 4097
;4097:				if ( self->s.v.impulse )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2199
line 4098
;4098:				{
line 4099
;4099:					if ( !self->team_no && teamplay && self->lives )
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $2201
ADDRGP4 teamplay
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $2201
ADDRLP4 24
INDIRP4
CNSTI4 964
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $2201
line 4100
;4100:						Menu_Team_Input( self->s.v.impulse );
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Menu_Team_Input
CALLV
pop
ADDRGP4 $2202
JUMPV
LABELV $2201
line 4102
;4101:					else
;4102:					{
line 4103
;4103:						if ( !self->playerclass && self->lives )
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $2203
ADDRLP4 32
INDIRP4
CNSTI4 964
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $2203
line 4104
;4104:							Menu_Class_Input( self->s.v.impulse );
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Menu_Class_Input
CALLV
pop
LABELV $2203
line 4105
;4105:					}
LABELV $2202
line 4106
;4106:				}
LABELV $2199
line 4107
;4107:			}
LABELV $2197
line 4108
;4108:		}
LABELV $2194
line 4109
;4109:	}
LABELV $2191
line 4110
;4110:	if ( g_globalvars.time < self->attack_finished )
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
GEF4 $2205
line 4111
;4111:	{
line 4112
;4112:	        DeadImpulses();
ADDRGP4 DeadImpulses
CALLV
pop
line 4113
;4113:		if ( self->s.v.impulse )
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2184
line 4114
;4114:			Angel_SaveImpulse( self->s.v.impulse );
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Angel_SaveImpulse
CALLV
pop
line 4115
;4115:		return;
ADDRGP4 $2184
JUMPV
LABELV $2205
line 4117
;4116:	}
;4117:	if ( self->s.v.impulse && !self->has_disconnected )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2210
ADDRLP4 12
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2210
line 4118
;4118:		ImpulseCommands(  );
ADDRGP4 ImpulseCommands
CALLV
pop
LABELV $2210
line 4119
;4119:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $2213
JUMPV
LABELV $2212
line 4122
;4120:
;4121:	while ( ( self->s.v.impulse = Angel_GetSavedImpulse(  ) ) && !self->has_disconnected )
;4122:		ImpulseCommands(  );
ADDRGP4 ImpulseCommands
CALLV
pop
LABELV $2213
line 4121
ADDRLP4 16
ADDRGP4 Angel_GetSavedImpulse
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 0
EQF4 $2215
ADDRGP4 self
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2212
LABELV $2215
line 4124
;4123:
;4124:	if ( self->s.v.impulse && !self->has_disconnected )
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2216
ADDRLP4 24
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2216
line 4125
;4125:		ImpulseCommands(  );
ADDRGP4 ImpulseCommands
CALLV
pop
LABELV $2216
line 4126
;4126:	if ( tf_data.cease_fire )
ADDRGP4 tf_data+72
INDIRI4
CNSTI4 0
EQI4 $2218
line 4127
;4127:		return;
ADDRGP4 $2184
JUMPV
LABELV $2218
line 4128
;4128:	if ( self->is_building || self->is_detpacking || self->is_feigning )
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRP4
CNSTI4 872
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $2224
ADDRLP4 28
INDIRP4
CNSTI4 876
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $2224
ADDRLP4 28
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $2221
LABELV $2224
line 4129
;4129:		return;
ADDRGP4 $2184
JUMPV
LABELV $2221
line 4130
;4130:	if ( !self->s.v.button0 && self->fire_held_down && self->current_weapon == WEAP_ASSAULT_CANNON )
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
CNSTF4 0
NEF4 $2225
ADDRLP4 36
INDIRP4
CNSTI4 1448
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2225
ADDRLP4 36
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 32768
NEI4 $2225
line 4131
;4131:	{
line 4132
;4132:		self->fire_held_down = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1448
ADDP4
CNSTI4 0
ASGNI4
line 4133
;4133:		self->tfstate -= ( self->tfstate & TFSTATE_AIMING );
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 44
ADDRLP4 40
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRI4
ADDRLP4 44
INDIRI4
CNSTI4 2048
BANDI4
SUBI4
ASGNI4
line 4134
;4134:		TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 4135
;4135:		player_run(  );
ADDRGP4 player_run
CALLV
pop
line 4136
;4136:	}
LABELV $2225
line 4137
;4137:	if ( self->s.v.button0 && !self->fire_held_down )
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2227
ADDRLP4 40
INDIRP4
CNSTI4 1448
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2227
line 4138
;4138:	{
line 4139
;4139:		if ( self->current_menu == MENU_CLASSHELP || self->current_menu == MENU_CLASSHELP2 )
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 6
EQI4 $2231
ADDRLP4 44
INDIRI4
CNSTI4 7
NEI4 $2229
LABELV $2231
line 4140
;4140:		{
line 4141
;4141:			self->current_menu = MENU_REPEATHELP;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 8
ASGNI4
line 4142
;4142:			self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 4143
;4143:			Attack_Finished( 0.2 );
CNSTF4 1045220557
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 4144
;4144:		} else
ADDRGP4 $2228
JUMPV
LABELV $2229
line 4145
;4145:		{
line 4146
;4146:			switch ( self->current_weapon )
ADDRLP4 48
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
ADDRLP4 56
CNSTI4 32
ASGNI4
ADDRLP4 48
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $2235
ADDRLP4 48
INDIRI4
ADDRLP4 56
INDIRI4
LTI4 $2232
LABELV $2258
ADDRLP4 48
INDIRI4
CNSTI4 32768
EQI4 $2255
ADDRGP4 $2232
JUMPV
line 4147
;4147:			{
LABELV $2235
line 4149
;4148:			case WEAP_SNIPER_RIFLE:
;4149:				if ( self->tfstate & TFSTATE_AIMING )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $2236
line 4150
;4150:				{
line 4151
;4151:					if ( !tf_data.snip_fps && self->heat < 400 )
ADDRGP4 tf_data+128
INDIRI4
CNSTI4 0
NEI4 $2238
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 1137180672
GEF4 $2238
line 4152
;4152:						self->heat += 3;
ADDRLP4 60
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
LABELV $2238
line 4153
;4153:					if ( self->height > 30 )
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
CNSTF4 1106247680
LEF4 $2228
line 4154
;4154:					{
line 4155
;4155:						self->height -= 5;
ADDRLP4 64
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
CNSTF4 1084227584
SUBF4
ASGNF4
line 4156
;4156:						TF_zoom( self->height );
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 TF_zoom
CALLV
pop
line 4157
;4157:					}
line 4158
;4158:				} else
ADDRGP4 $2228
JUMPV
LABELV $2236
line 4159
;4159:				{
line 4160
;4160:				        if( g_globalvars.time > self->allow_snip_time)
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 1588
ADDP4
INDIRF4
LEF4 $2228
line 4161
;4161:				        {
line 4162
;4162:						VectorCopy( self->s.v.velocity, tv );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ASGNF4
line 4163
;4163:						tv[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4164
;4164:						if ( vlen( tv ) <= WEAP_SNIPER_RIFLE_MAX_MOVE )
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 1112014848
GTF4 $2228
line 4165
;4165:						{
line 4166
;4166:							SniperSight_Create(  );
ADDRGP4 SniperSight_Create
CALLV
pop
line 4167
;4167:							if ( tf_data.snip_fps )
ADDRGP4 tf_data+128
INDIRI4
CNSTI4 0
EQI4 $2251
line 4168
;4168:								self->heat = g_globalvars.time;
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
ADDRGP4 $2252
JUMPV
LABELV $2251
line 4170
;4169:							else
;4170:								self->heat = 50;
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 1112014848
ASGNF4
LABELV $2252
line 4172
;4171:        
;4172:							self->height = 90;
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
CNSTF4 1119092736
ASGNF4
line 4173
;4173:							self->tfstate = self->tfstate | TFSTATE_AIMING;
ADDRLP4 64
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 4174
;4174:							TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 4175
;4175:						}
line 4176
;4176:				        }
line 4177
;4177:				}
line 4179
;4178:
;4179:				break;
ADDRGP4 $2228
JUMPV
LABELV $2255
line 4181
;4180:			case WEAP_ASSAULT_CANNON:
;4181:				if ( ( int ) self->s.v.flags & FL_ONGROUND )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $2228
line 4182
;4182:				{
line 4183
;4183:					SuperDamageSound(  );
ADDRGP4 SuperDamageSound
CALLV
pop
line 4184
;4184:					W_Attack(  );
ADDRGP4 W_Attack
CALLV
pop
line 4185
;4185:				} else
line 4186
;4186:				{
line 4189
;4187:					//G_sprint( self, 1,
;4188:					//	  "You cannot fire the assault cannon without\nyour feet on the ground...\n" );
;4189:				}
line 4190
;4190:				break;
ADDRGP4 $2228
JUMPV
LABELV $2232
line 4192
;4191:			default:
;4192:				SuperDamageSound(  );
ADDRGP4 SuperDamageSound
CALLV
pop
line 4193
;4193:				W_Attack(  );
ADDRGP4 W_Attack
CALLV
pop
line 4194
;4194:				break;
line 4197
;4195:			}
;4196:
;4197:		}
line 4198
;4198:	} else
ADDRGP4 $2228
JUMPV
LABELV $2227
line 4199
;4199:	{
line 4200
;4200:		if ( !self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2259
line 4201
;4201:			self->weaponmode = 0;
ADDRGP4 self
INDIRP4
CNSTI4 940
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $2260
JUMPV
LABELV $2259
line 4203
;4202:		else
;4203:		{
line 4204
;4204:			if ( self->tfstate & TFSTATE_AIMING )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $2261
line 4205
;4205:			{
line 4206
;4206:				W_Attack(  );
ADDRGP4 W_Attack
CALLV
pop
line 4207
;4207:				self->tfstate = self->tfstate - TFSTATE_AIMING;
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 2048
SUBI4
ASGNI4
line 4208
;4208:				TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 4209
;4209:				self->heat = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 0
ASGNF4
line 4210
;4210:			}
LABELV $2261
line 4211
;4211:		}
LABELV $2260
line 4212
;4212:	}
LABELV $2228
line 4213
;4213:}
LABELV $2184
endproc W_WeaponFrame 68 4
export SuperDamageSound
proc SuperDamageSound 4 20
line 4223
;4214:
;4215:/*
;4216:========
;4217:SuperDamageSound
;4218:
;4219:Plays sound if needed
;4220:========
;4221:*/
;4222:void SuperDamageSound(  )
;4223:{
line 4224
;4224:	if ( self->super_damage_finished > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $2263
line 4225
;4225:	{
line 4226
;4226:		if ( self->super_sound < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 768
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $2263
line 4227
;4227:		{
line 4228
;4228:			self->super_sound = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 768
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4229
;4229:			sound( self, CHAN_BODY, "items/damage3.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $2271
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
line 4230
;4230:		}
line 4231
;4231:	}
line 4232
;4232:	return;
LABELV $2263
endproc SuperDamageSound 4 20
bss
align 4
LABELV num_team_pipebombs
skip 20
align 4
LABELV puff_count
skip 4
align 4
LABELV blood_count
skip 4
align 4
LABELV blood_org
skip 12
align 4
LABELV multi_damage
skip 4
align 4
LABELV multi_ent
skip 4
import Drop3
import M_Mine
import B_Mine
import S_Mine
import A_Mine
import C_Mine
import SuperLeap
import Prox
import MakeHolo
import SpyPack
import LavaPool
import W_FireBigAss
import Toaster
import button_fire
import button_touch
import item_megahealth_rot
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
import W_FireLaser
import W_FireTranq
import W_FireIncendiaryCannon
import W_FireFlame
export puff_org
align 4
LABELV puff_org
skip 12
import SpectatorThink
import SpectatorDisconnect
import SpectatorConnect
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
LABELV $2271
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2137
byte 1 65
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 101
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $2041
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $2036
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $2029
byte 1 118
byte 1 95
byte 1 99
byte 1 115
byte 1 104
byte 1 105
byte 1 102
byte 1 116
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $2028
byte 1 118
byte 1 95
byte 1 99
byte 1 115
byte 1 104
byte 1 105
byte 1 102
byte 1 116
byte 1 32
byte 1 48
byte 1 32
byte 1 49
byte 1 48
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 49
byte 1 48
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $2003
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 49
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 65
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1998
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
LABELV $1968
byte 1 76
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 79
byte 1 102
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $1967
byte 1 76
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 79
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $1948
byte 1 76
byte 1 97
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 44
byte 1 32
byte 1 40
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 32
byte 1 119
byte 1 97
byte 1 108
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 97
byte 1 121
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $1947
byte 1 83
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 44
byte 1 32
byte 1 40
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $1940
byte 1 85
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 32
byte 1 77
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 44
byte 1 10
byte 1 0
align 1
LABELV $1939
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 65
byte 1 105
byte 1 109
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 103
byte 1 111
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1938
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 85
byte 1 115
byte 1 101
byte 1 115
byte 1 32
byte 1 50
byte 1 53
byte 1 32
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 101
byte 1 114
byte 1 121
byte 1 32
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1937
byte 1 67
byte 1 109
byte 1 100
byte 1 58
byte 1 32
byte 1 39
byte 1 106
byte 1 101
byte 1 116
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 39
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 73
byte 1 109
byte 1 112
byte 1 117
byte 1 108
byte 1 115
byte 1 101
byte 1 32
byte 1 49
byte 1 53
byte 1 53
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1936
byte 1 68
byte 1 101
byte 1 102
byte 1 58
byte 1 32
byte 1 65
byte 1 32
byte 1 83
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 32
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 32
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 10
byte 1 0
align 1
LABELV $1935
byte 1 45
byte 1 45
byte 1 45
byte 1 32
byte 1 65
byte 1 105
byte 1 114
byte 1 115
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $1865
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $1862
byte 1 98
byte 1 105
byte 1 114
byte 1 116
byte 1 104
byte 1 100
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1861
byte 1 98
byte 1 100
byte 1 0
align 1
LABELV $1753
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
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
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
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1750
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
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1747
byte 1 110
byte 1 111
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1706
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
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1703
byte 1 65
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
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1559
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
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1557
byte 1 66
byte 1 105
byte 1 111
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1555
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
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1553
byte 1 114
byte 1 105
byte 1 102
byte 1 108
byte 1 101
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 121
byte 1 32
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $1551
byte 1 83
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
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $1549
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
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1546
byte 1 80
byte 1 105
byte 1 112
byte 1 101
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1543
byte 1 80
byte 1 105
byte 1 112
byte 1 101
byte 1 98
byte 1 111
byte 1 109
byte 1 98
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
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 80
byte 1 114
byte 1 101
byte 1 77
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 10
byte 1 0
align 1
LABELV $1538
byte 1 78
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
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1534
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
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1532
byte 1 65
byte 1 120
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1503
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 47
byte 1 101
byte 1 110
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1479
byte 1 73
byte 1 110
byte 1 115
byte 1 117
byte 1 102
byte 1 102
byte 1 105
byte 1 99
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 116
byte 1 104
byte 1 101
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
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1466
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 108
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1445
byte 1 78
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
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 32
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1433
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 97
byte 1 120
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1388
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
LABELV $1366
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $1365
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 107
byte 1 117
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1298
byte 1 0
align 1
LABELV $1297
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1290
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 98
byte 1 105
byte 1 111
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1288
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1280
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 97
byte 1 115
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1273
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 115
byte 1 114
byte 1 105
byte 1 102
byte 1 108
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1269
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1262
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1258
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1257
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1251
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1247
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1243
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1239
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1235
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 115
byte 1 112
byte 1 97
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1233
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1231
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 107
byte 1 110
byte 1 105
byte 1 102
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1199
byte 1 107
byte 1 110
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $1196
byte 1 119
byte 1 105
byte 1 122
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $1139
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1131
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1129
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $1126
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1125
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 51
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $1035
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $988
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 0
align 1
LABELV $951
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 108
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $882
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 108
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $880
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $799
byte 1 72
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 32
byte 1 45
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 116
byte 1 97
byte 1 32
byte 1 104
byte 1 117
byte 1 114
byte 1 116
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $798
byte 1 72
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 106
byte 1 117
byte 1 114
byte 1 121
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $794
byte 1 98
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $790
byte 1 76
byte 1 101
byte 1 103
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 32
byte 1 45
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 39
byte 1 108
byte 1 108
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $789
byte 1 76
byte 1 101
byte 1 103
byte 1 32
byte 1 105
byte 1 110
byte 1 106
byte 1 117
byte 1 114
byte 1 121
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $750
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
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 33
byte 1 33
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $524
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 122
byte 1 111
byte 1 109
byte 1 95
byte 1 103
byte 1 105
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $495
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
LABELV $418
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $411
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 39
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
byte 1 10
byte 1 0
align 1
LABELV $405
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
LABELV $397
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 105
byte 1 110
byte 1 100
byte 1 110
byte 1 101
byte 1 115
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $391
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
LABELV $384
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
LABELV $379
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
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
LABELV $367
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
LABELV $362
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
LABELV $358
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 104
byte 1 105
byte 1 115
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
LABELV $344
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 117
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
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
LABELV $343
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
LABELV $334
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $259
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
LABELV $256
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
LABELV $253
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
LABELV $240
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
LABELV $200
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 97
byte 1 120
byte 1 104
byte 1 105
byte 1 116
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $182
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 107
byte 1 110
byte 1 105
byte 1 102
byte 1 101
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $178
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $132
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 101
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $131
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 107
byte 1 110
byte 1 105
byte 1 102
byte 1 101
byte 1 100
byte 1 114
byte 1 119
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $130
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
LABELV $129
byte 1 122
byte 1 111
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 47
byte 1 122
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $128
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 117
byte 1 110
byte 1 105
byte 1 100
byte 1 108
byte 1 101
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $127
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $126
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
LABELV $125
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
LABELV $124
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 116
byte 1 105
byte 1 110
byte 1 107
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $123
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $122
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 50
byte 1 48
byte 1 109
byte 1 109
byte 1 99
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $121
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
LABELV $120
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
LABELV $119
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
LABELV $118
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
LABELV $117
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
LABELV $116
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
LABELV $115
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
LABELV $114
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
LABELV $113
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
LABELV $112
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 99
byte 1 109
byte 1 121
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
LABELV $111
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 104
byte 1 101
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $110
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $109
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
LABELV $108
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
LABELV $107
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
LABELV $106
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
LABELV $105
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 112
byte 1 101
byte 1 107
byte 1 97
byte 1 98
byte 1 111
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $104
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 112
byte 1 97
byte 1 110
byte 1 116
byte 1 115
byte 1 100
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $103
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 47
byte 1 49
byte 1 48
byte 1 48
byte 1 104
byte 1 122
byte 1 104
byte 1 117
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $102
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 114
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $101
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 95
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $100
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 110
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 118
byte 1 105
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $99
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 50
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $98
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 50
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $97
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 49
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $96
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 49
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 114
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $94
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
LABELV $93
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 117
byte 1 110
byte 1 114
byte 1 101
byte 1 101
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $92
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $91
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 100
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $90
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 114
byte 1 111
byte 1 112
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $89
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 99
byte 1 101
byte 1 110
byte 1 114
byte 1 107
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $88
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 97
byte 1 105
byte 1 114
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $87
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 110
byte 1 103
byte 1 110
byte 1 100
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $86
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $85
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 50
byte 1 48
byte 1 109
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $84
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 99
byte 1 49
byte 1 48
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $83
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 100
byte 1 114
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $82
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $81
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 108
byte 1 115
byte 1 114
byte 1 100
byte 1 114
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $80
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 112
byte 1 111
byte 1 111
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $79
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $78
byte 1 122
byte 1 111
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 47
byte 1 122
byte 1 95
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $77
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 111
byte 1 119
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $76
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $75
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 112
byte 1 111
byte 1 111
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $74
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 110
byte 1 103
byte 1 110
byte 1 117
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $73
byte 1 115
byte 1 104
byte 1 97
byte 1 109
byte 1 98
byte 1 108
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 98
byte 1 111
byte 1 111
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $72
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 97
byte 1 105
byte 1 114
byte 1 45
byte 1 109
byte 1 105
byte 1 114
byte 1 118
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $71
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $70
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 48
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $69
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $68
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
LABELV $67
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 97
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $66
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $65
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 111
byte 1 97
byte 1 105
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $64
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $63
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $62
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $61
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $60
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 101
byte 1 101
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $59
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
LABELV $58
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 117
byte 1 115
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $57
byte 1 115
byte 1 104
byte 1 97
byte 1 109
byte 1 98
byte 1 108
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 109
byte 1 97
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $56
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 97
byte 1 115
byte 1 95
byte 1 109
byte 1 97
byte 1 115
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $55
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 105
byte 1 109
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $54
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 105
byte 1 102
byte 1 108
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $53
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 99
byte 1 104
byte 1 47
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $52
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 109
byte 1 111
byte 1 114
byte 1 116
byte 1 97
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $51
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 106
byte 1 101
byte 1 116
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $50
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 121
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $49
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 98
byte 1 97
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $48
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 110
byte 1 99
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $47
byte 1 104
byte 1 107
byte 1 110
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 47
byte 1 115
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $46
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $45
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $44
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 100
byte 1 97
byte 1 114
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $43
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $42
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $41
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $40
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $39
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 118
byte 1 97
byte 1 112
byte 1 101
byte 1 117
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $38
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 109
byte 1 103
byte 1 114
byte 1 101
byte 1 120
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $37
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 109
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $36
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $35
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 116
byte 1 117
byte 1 114
byte 1 114
byte 1 105
byte 1 100
byte 1 108
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $34
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 116
byte 1 117
byte 1 114
byte 1 114
byte 1 115
byte 1 112
byte 1 111
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $33
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 116
byte 1 117
byte 1 114
byte 1 114
byte 1 115
byte 1 101
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $31
byte 1 104
byte 1 107
byte 1 110
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $30
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $29
byte 1 98
byte 1 108
byte 1 111
byte 1 98
byte 1 47
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $28
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $27
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $26
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
LABELV $25
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
LABELV $24
byte 1 119
byte 1 105
byte 1 122
byte 1 97
byte 1 114
byte 1 100
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $23
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 110
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $22
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $21
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $20
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 116
byte 1 105
byte 1 110
byte 1 107
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $19
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $18
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $17
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $16
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $15
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 117
byte 1 110
byte 1 99
byte 1 111
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $14
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 103
byte 1 117
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $13
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
byte 1 101
byte 1 116
byte 1 49
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $12
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 95
byte 1 101
byte 1 120
byte 1 112
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
