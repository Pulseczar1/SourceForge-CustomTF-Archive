
void(entity targ, entity attacker, string what) LogPlayerDMDeath =
{
	// note embedded tabs in the next string
	dprint("LOG:	DEATH	");
	dprint(targ.netname);
	dprint("/");
	dprint(ftos(targ.frags));
	dprint("	");
	dprint(attacker.netname);
	dprint("/");
	dprint(ftos(attacker.frags));
	dprint("	");
	dprint(what);
	dprint("\n");
};

void (entity targ, string what) LogPlayerDeath =
{
	dprint("LOG:	DEATH	");
	dprint(targ.netname);
	dprint("/");
	dprint(ftos(targ.frags));
	dprint("	");
	dprint(what);
	dprint("\n");
};

void (entity who, string what) LogMsg =
{
	dprint("LOG:	");
	dprint(what);
	dprint("	");
	dprint(who.netname);
	dprint("\n");
};
