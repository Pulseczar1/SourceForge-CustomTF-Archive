// Half-Life 1 multisource

//multisource: maybe complete
void () multisource_use =
{
	local entity te;
	local float i, args;
	
	
	te = find(world, target, self.targetname);
	while (te)
	{
		if (te.activated != #TRUE) {
			return;
		}
		te = find(te, monster_string, "on");
	}
	
	// look for multi_manager entities which may target this one
	te = find(world, classname, "multi_manager");
	while (te)
	{
		if (te.activated != #TRUE) {
			args = tokenize(te.netname);
			i = 1;
			while (argv(i) != string_null) {
				if (argv(i) == self.targetname) {
					bprint(2,"WHOA\n");
					return;
				}
				i++;
			}

		}
		te = find(te, classname, "multi_manager");
	}
	
	
	if (self.globalstate) {
		if (cvar(self.globalstate) < 1) {
			bprint(2,"global state not set\n");
			return;
		}
	}
		
	bprint(2,"I AM ACTIVATED TYPE 2\n");
	bprint(2,self.targetname);
	bprint(2," 222\n");
	SUB_UseTargets();
	self.activated = 1;
	dremove(self);	// look in subs.qc for why i do this
/*
	local entity t;

	bprint(2,"I AM USED!!!111111\n");
	bprint(2,self.targetname);
	bprint(2," 222\n");
	//SUB_UseTargets();
	

	
	t = world;
	do
	{
		t = find(t, target, self.targetname);
		if (!t)
		{
			if (self.globalstate) {
				if (cvar(self.globalstate) < 1) {
					bprint(2,"global state not set\n");
					return;
				}
			}
				
			//bprint(2, " USING11\n");
			bprint(2,"I AM ACTIVATED!!!111111\n");
			bprint(2,self.targetname);
			bprint(2," 222\n");
			SUB_UseTargets();
			dremove(self);	// look in subs.qc for why i do this
			return;
		}
		//bprint(2, " USING22\n");
		if (t.activated == #FALSE)
			return;	// not all entities targeting this one are active yet..
	} while (1);
	
	if (self.globalstate)
		if (cvar(self.globalstate) < 1) {
			bprint(2,"global state not set\n");
			return;
		}
	SUB_UseTargets();
	dremove(self);	// look in subs.qc for why i do this
	*/
};

void () multisource =
{
	self.use = multisource_use;
	if (mapname == "c1a2")
		if (self.targetname == "button_lock")
			dremove(self);
	
/*
	if (!self.target) {
		dremove(self);
		return;
	}
	trigger_multiple();
*/
};

// checks to see if the entity has a "master" (IE multisource)
float ( entity t_ent ) has_master =
{
	local entity t;
	
	if (!t_ent.master)
		return 0;
	
	t = find(world, targetname, t_ent.master);
	if (!t || t == world)
	{
		bprint(2,"NO MASTER\n");
		return 0;
	}
	if (t.classname == "multisource") {
		if (t.globalstate)
			if (cvar(t.globalstate) > 0) {
				dremove(t);
				bprint(2,"DE GLOBALIZED!\n");
				return 0;
			}
		return 1;
	}
	
	return 0;
	
	//bprint(2,"WTF?\n");
	//return 0;
	
	/*
	//GOLD CODE:
		local entity t;
	
	if (!t_ent.master)
		return 0;
	
	t = world;
	do
	{
		t = find(t, targetname, t_ent.master);
		if (!t)
		{
			bprint(2,"NO MASTER\n");
			return 0;
		}
		if (t.classname == "multisource")
			return 1;
	} while (1);
	
	bprint(2,"WTF?\n");
	return 0;
	*/
};