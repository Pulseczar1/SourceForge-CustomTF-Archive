string weaponabbreviation[] = {	//the postfix for the weapon anims
	"shotgun",
	"sshotgun",
	"nailgun",
	"snailgun",
	"rlaunch",	//grenades actually.
	"srlaunch",
	"lightng"
};
#define numweaps 7

string pupabbr[] = {	//the postfix for the powerup anims
	"key1",
	"key2",
	"invis",
	"invul",
	"suit",
	"quad"
};
string pupabbr2[] = {	//the postfix for the powerup anims
	"key1",
	"key2",
	"invis",
	"invuln",
	"suit",
	"quad"
};

class huditem
{
	void(entity e) drawitem;
	float mode;
	float width;
	float height;
	huditem next;
	huditem sibling;
};

huditem huditems;
float hudfile;

void() loadhud =
{
};

float huddepth;
void(huditem blah) saveitem =
{
	if (!blah)
		return;

	fputindent(hudfile, "\t", depth);
	fputs(hudfile, "item\n");
	fputindent(hudfile, "\t", depth);
	fputs(hudfile, "{\n");
	depth++;
		fputindent(hudfile, "\t", depth);
		fputs(hudfile, ";");
	depth--;
	fputindent(hudfile, "\t", depth);
	fputs(hudfile, "}\n");
};
void() savehud =
{
};
