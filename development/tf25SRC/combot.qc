/*==========================================
	ComBot.qc

This file contains the functions required
for the SoldierBot and the SniperBot

==========================================*/


/*===================
Entity declarations
===================*/

void() bot_soldier_settings =
{
	bprint (#PRINT_HIGH, "setting SoldierBot stats..\n");
	self.playerclass = #BOT_SOLDIER;
	self.health = 100;
	self.max_health = 100;
	self.armorvalue = 50;
	self.armortype = 0.6;
	self.skin = #PC_SOLDIER;	// until the bot skins are finished
	self.weapons_carried = #WEAP_SHOTGUN | #WEAP_ROCKET_LAUNCHER;
	self.weapon = #WEAP_ROCKET_LAUNCHER | #WEAP_SUPER_SHOTGUN;

	if (!self.team_no)
		self.team_no = 1;	
};

void() bot_soldier =
{
	self.dest = self.origin;
	set_default_bot();
	bot_soldier_settings();

	if (!(self.netname))
		self.netname = "SoldierBot";

};

void() bot_sniper =
{
	remove(self);
};