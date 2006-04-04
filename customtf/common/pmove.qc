vector pmove_org;
vector pmove_vel;
float pmove_time;

float pmove_type;

vector pmove_keys;
vector pmove_angles;

float pmove_friction;
float pmove_gravity;

float pmove_stepheight = 22;

vector pmove_mins;// = HULL1_SIZE;
vector pmove_maxs;

void PMove_Move(vector dest)	//move forwards (preferably on the level) (does step ups)
{
	vector src;
	float stepped;
	tracebox(pmove_org, pmove_mins, pmove_maxs, dest, false, self);	//try going straight there

	if (trace_fraction < 1)
	{	//step up
		src = trace_endpos;
		trace_endpos_z += pmove_stepheight;
		tracebox(src, pmove_mins, pmove_maxs, dest, false, self);
		stepped = trace_endpos_z - src_z;
		dest_z += stepped;

		//move forwards
		tracebox(trace_endpos, pmove_mins, pmove_maxs, dest, false, self);

		//move down
		dest_z -= stepped;
		tracebox(trace_endpos, pmove_mins, pmove_maxs, dest, false, self);
	}
	pmove_org = trace_endpos;
}

void PMove(void)
{
	makevectors(pmove_angles);


	pmove_vel *= pmove_friction*pmove_time;
	pmove_vel += pmove_time*(
			v_forward * pmove_keys_x +
			v_right * pmove_keys_y +
			v_up * pmove_keys_z);

	switch(pmove_type)
	{
	case MOVETYPE_WALK:
		pmove_vel_z += pmove_gravity*pmove_time;
		PMove_Move(pmove_org + pmove_vel*pmove_time);
		break;
	case MOVETYPE_NOCLIP:
		pmove_org += pmove_vel*pmove_time;
		break;
	case MOVETYPE_NONE:
		break;
	}
}
