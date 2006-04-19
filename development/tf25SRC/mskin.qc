/*
	TeamFortress 2.1	-	22/1/97

	TeamFortress Software
	Functions specific to the Multiskin section of TeamFortress.
*/

// Prototypes
void() Multiskin_NextSkin;
void() Multiskin_PrevSkin;
void() Multiskin_DisplayName;

//=========================================================================
// Increment the skin of the self entity
void() Multiskin_NextSkin =
{
	// If Classkin is on, prevent skin changes
	if (!(toggleflags & #TFLAG_SKIN))
		return;

	self.skin = self.skin + 1;

	if (self.skin > #MS_MAX_SKIN)
		self.skin = 0;

	Multiskin_DisplayName();
};	

//=========================================================================
// Decrement the skin of the self entity
void() Multiskin_PrevSkin =
{
	// If Classkin is on, prevent skin changes
	if (!(toggleflags & #TFLAG_SKIN))
		return;

	self.skin = self.skin - 1;

	if (self.skin < 0)
		self.skin = #MS_MAX_SKIN;

	Multiskin_DisplayName();
};

//=========================================================================
// Write a description of the self entity's current skin to the self entity
void() Multiskin_DisplayName =
{
	local string sn;

	if (self.classname != "player")
		return;

	// Display skin name
	sn = ftos(self.skin);

	sprint(self, #PRINT_HIGH, "Skin no ");
	sprint(self, #PRINT_HIGH, sn);
	sprint(self, #PRINT_HIGH, ".\n");
};	
