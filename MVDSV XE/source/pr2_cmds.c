/*
 *  QW262
 *  Copyright (C) 2004  [sd] angel
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *
 *  $Id: pr2_cmds.c,v 1.45 2007/03/15 00:24:14 qqshka Exp $
 */

#ifdef USE_PR2

#include "qwsvdef.h"

char	*pr2_ent_data_ptr;
vm_t	*sv_vm = NULL;


int PASSFLOAT(float x)
{
	int rc;
	memcpy(&rc, &x, sizeof(rc));

	return rc;
}

/*
============
PR2_RunError
 
Aborts the currently executing function
============
*/
void PR2_RunError(char *error, ...)
{
	va_list		argptr;
	char		string[1024];

	va_start(argptr, error);
	vsnprintf(string, sizeof(string), error, argptr);
	va_end(argptr);

	sv_error = true;
	if( sv_vm->type == VM_BYTECODE )
		QVM_StackTrace( sv_vm->hInst );

	Con_Printf("%s\n", string);

	SV_Error("Program error");
}

void PR2_CheckEmptyString(char *s)
{
	if (!s || s[0] <= ' ')
		PR2_RunError("Bad string");
}

void PF2_GetApiVersion(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_int = GAME_API_VERSION;
}

void PF2_GetEntityToken(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{

	pr2_ent_data_ptr = COM_Parse(pr2_ent_data_ptr);
	strlcpy(VM_POINTER(base,mask,stack[0].string), com_token,  stack[1]._int);

	retval->_int= pr2_ent_data_ptr != NULL;
}

void PF2_DPrint(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	Con_DPrintf("%s", VM_POINTER(base,mask,stack[0].string));
}

void PF2_conprint(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	Sys_Printf("%s", VM_POINTER(base, mask, stack[0].string));
}

void PF2_Error(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	PR2_RunError(VM_POINTER(base, mask, stack->string));
}

void PF2_Spawn(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_int = NUM_FOR_EDICT( ED2_Alloc() );
}

void PF2_Remove(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{

	ED2_Free(EDICT_NUM(stack[0]._int));
}

void PF2_precache_sound(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int i;
	char*s;
	if (sv.state != ss_loading)
		PR2_RunError("PF_Precache_*: Precache can only be done in spawn "
		             "functions");
	s = VM_POINTER(base,mask,stack[0].string);
	PR2_CheckEmptyString(s);

	for (i = 0; i < MAX_SOUNDS; i++)
	{
		if (!sv.sound_precache[i])
		{
			sv.sound_precache[i] = s;
			return;
		}
		if (!strcmp(sv.sound_precache[i], s))
			return;
	}

	PR2_RunError ("PF_precache_sound: overflow");
}

void PF2_precache_model(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int 	i;
	char 	*s;

	if (sv.state != ss_loading)
		PR2_RunError("PF_Precache_*: Precache can only be done in spawn "
		             "functions");

	s = VM_POINTER(base,mask,stack[0].string);
	PR2_CheckEmptyString(s);

	for (i = 0; i < MAX_MODELS; i++)
	{
		if (!sv.model_precache[i])
		{
			Con_Printf("%i. ehhh Precaching model: %s\n", i, s);
			sv.model_precache[i] = s;
			return;
		}
		if (!strcmp(sv.model_precache[i], s))
			return;
	}
	Con_Printf("No room to precache model: %s\n", s);
	//PR2_RunError ("PF_precache_model: overflow");
}

/*
=================
PF2_setorigin
 
This is the only valid way to move an object without using the physics of the world (setting velocity and waiting).  Directly changing origin will not set internal links correctly, so clipping would be messed up.  This should be called when an object is spawned, and then only if it is teleported.
 
setorigin (entity, origin)
=================
*/

void PF2_setorigin(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	vec3_t origin;
	edict_t	*e;

	e = EDICT_NUM(stack[0]._int);

	origin[0] = stack[1]._float;
	origin[1] = stack[2]._float;
	origin[2] = stack[3]._float;

	VectorCopy(origin, e->v.origin);
	SV_LinkEdict(e, false);
}

/*
=================
PF2_setsize
 
the size box is rotated by the current angle
 
setsize (entity, minvector, maxvector)
=================
*/
void PF2_setsize(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	//vec3_t min, max;
	edict_t	*e ;

	e = EDICT_NUM(stack[0]._int);

	e->v.mins[0] = stack[1]._float;
	e->v.mins[1] = stack[2]._float;
	e->v.mins[2] = stack[3]._float;

	e->v.maxs[0] = stack[4]._float;
	e->v.maxs[1] = stack[5]._float;
	e->v.maxs[2] = stack[6]._float;

	VectorSubtract(e->v.maxs, e->v.mins, e->v.size);

	SV_LinkEdict(e, false);
}

/*
=================
PF2_setmodel
 
setmodel(entity, model)
Also sets size, mins, and maxs for inline bmodels
=================
*/
void PF2_setmodel(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	edict_t		*e;
	char		*m;
	char		**check;
	int		i;
	cmodel_t	*mod;

	e = EDICT_NUM(stack[0]._int);
	m = VM_POINTER(base,mask,stack[1].string);
	if(!m)
		m = "";
	// check to see if model was properly precached
	for (i = 0, check = sv.model_precache; *check; i++, check++)
		if (!strcmp(*check, m))
			break;

	if (!*check)
		PR2_RunError("no precache: %s\n", m);

	e->v.model = PR2_SetString(m);
	e->v.modelindex = i;

	// if it is an inline model, get the size information for it
	if (m[0] == '*')
	{
		mod = CM_InlineModel (m);
		VectorCopy(mod->mins, e->v.mins);
		VectorCopy(mod->maxs, e->v.maxs);
		VectorSubtract(mod->maxs, mod->mins, e->v.size);
		SV_LinkEdict(e, false);
	}

}

/*
=================
PF2_bprint
 
broadcast print to everyone on server
 
bprint(value)
=================
*/
void PF2_bprint(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	SV_BroadcastPrintf(stack[0]._int, "%s", VM_POINTER(base,mask,stack[1].string));
}

/*
=================
PF2_sprint
 
single print to a specific client
 
sprint(clientent, value)
=================
*/
void PF2_sprint(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	client_t *client, *cl;
	int entnum = stack[0]._int;
	int level = stack[1]._int;
	char *s = VM_POINTER(base,mask,stack[2].string);
	int i;

	if (entnum < 1 || entnum > MAX_CLIENTS)
	{
		Con_Printf("tried to sprint to a non-client %d \n", entnum);
		return;
	}

	client = &svs.clients[entnum - 1];

	SV_ClientPrintf(client, level, "%s", s);

	//bliP: spectator print ->
	if ((int)sv_specprint.value & SPECPRINT_SPRINT)
	{
		for (i = 0, cl = svs.clients; i < MAX_CLIENTS; i++, cl++)
		{
			if (!cl->state || !cl->spectator)
				continue;

			if ((cl->spec_track == entnum) && (cl->spec_print & SPECPRINT_SPRINT))
				SV_ClientPrintf (cl, level, "%s", s);
		}
	}
	//<-
}

/*
=================
PF2_centerprint

single print to a specific client

centerprint(clientent, value)
=================
*/
void PF2_centerprint(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	client_t *cl, *spec;
	int entnum = stack[0]._int;
	char *s = VM_POINTER(base,mask,stack[1].string);
	int i;

	if (entnum < 1 || entnum > MAX_CLIENTS)
	{
		Con_Printf("tried to centerprint to a non-client %d \n", entnum);
		return;
	}

	cl = &svs.clients[entnum - 1];

	ClientReliableWrite_Begin(cl, svc_centerprint, 2 + strlen(s));
	ClientReliableWrite_String(cl, s);

	if (sv.mvdrecording)
	{
		MVDWrite_Begin(dem_single, entnum - 1, 2 + strlen(s));
		MSG_WriteByte((sizebuf_t *) demo.dbuf, svc_centerprint);
		MSG_WriteString((sizebuf_t *) demo.dbuf, s);
	}

	//bliP: spectator print ->
	if ((int)sv_specprint.value & SPECPRINT_CENTERPRINT)
	{
		for (i = 0, spec = svs.clients; i < MAX_CLIENTS; i++, spec++)
		{
			if (!cl->state || !spec->spectator)
				continue;

			if ((spec->spec_track == entnum) && (cl->spec_print & SPECPRINT_CENTERPRINT))
			{
				ClientReliableWrite_Begin (spec, svc_centerprint, 2 + strlen(s));
				ClientReliableWrite_String (spec, s);
			}
		}
	}
	//<-

}

/*
=================
PF2_ambientsound
 
=================
*/
void PF2_ambientsound(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	char	**check;
	int		i, soundnum;
	vec3_t 	pos;
	char 	*samp;
	float 	vol;
	float 	attenuation;

	pos[0] = stack[0]._float;
	pos[1] = stack[1]._float;
	pos[2] = stack[2]._float;

	samp 		= VM_POINTER(base,mask,stack[3].string);
	if( !samp )
		samp = "";
	vol 		= stack[4]._float;
	attenuation 	= stack[5]._float;

	// check to see if samp was properly precached
	for (soundnum = 0, check = sv.sound_precache; *check; check++, soundnum++)
		if (!strcmp(*check, samp))
			break;

	if (!*check)
	{
		Con_Printf("no precache: %s\n", samp);
		return;
	}

	// add an svc_spawnambient command to the level signon packet
	MSG_WriteByte(&sv.signon, svc_spawnstaticsound);
	for (i = 0; i < 3; i++)
		MSG_WriteCoord(&sv.signon, pos[i]);

	MSG_WriteByte(&sv.signon, soundnum);

	MSG_WriteByte(&sv.signon, vol * 255);
	MSG_WriteByte(&sv.signon, attenuation * 64);

}

/*
=================
PF2_sound
 
Each entity can have eight independant sound sources, like voice,
weapon, feet, etc.
 
Channel 0 is an auto-allocate channel, the others override anything
already running on that entity/channel pair.
 
An attenuation of 0 will play full volume everywhere in the level.
Larger attenuations will drop off.
 
=================
*/
void PF2_sound(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	edict_t         *entity         = EDICT_NUM(stack[0]._int);
	int             channel         = stack[1]._int;
	char            *sample         = VM_POINTER(base,mask,stack[2].string);
	int             volume          = stack[3]._float * 255;
	float           attenuation     = stack[4]._float;

	SV_StartSound(entity, channel, sample, volume, attenuation);
}

/*
=================
PF2_traceline
 
Used for use tracing and shot targeting
Traces are blocked by bbox and exact bsp entityes, and also slide box entities
if the tryents flag is set.
 
traceline (vector1, vector2, tryents)
=================
*/
void PF2_traceline(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	trace_t	trace;
	edict_t	*ent;
	vec3_t v1, v2;
	int nomonsters;//, entnum;

	v1[0] = stack[0]._float;
	v1[1] = stack[1]._float;
	v1[2] = stack[2]._float;

	v2[0] = stack[3]._float;
	v2[1] = stack[4]._float;
	v2[2] = stack[5]._float;

	nomonsters = stack[6]._int;

	ent = EDICT_NUM(stack[7]._int);

	trace = SV_Trace(v1, vec3_origin, vec3_origin, v2, nomonsters, ent);

	pr_global_struct->trace_allsolid = trace.allsolid;
	pr_global_struct->trace_startsolid = trace.startsolid;
	pr_global_struct->trace_fraction = trace.fraction;
	pr_global_struct->trace_inwater = trace.inwater;
	pr_global_struct->trace_inopen = trace.inopen;
	VectorCopy (trace.endpos, pr_global_struct->trace_endpos);
	VectorCopy (trace.plane.normal, pr_global_struct->trace_plane_normal);
	pr_global_struct->trace_plane_dist = trace.plane.dist;

	if (trace.e.ent)
		pr_global_struct->trace_ent = EDICT_TO_PROG(trace.e.ent);
	else
		pr_global_struct->trace_ent = EDICT_TO_PROG(sv.edicts);
}

/*
=================
PF2_TraceCapsule
 
Used for use tracing and shot targeting
Traces are blocked by bbox and exact bsp entityes, and also slide box entities
if the tryents flag is set.
 
void    trap_TraceCapsule( float v1_x, float v1_y, float v1_z, 
			float v2_x, float v2_y, float v2_z, 
			int nomonst, int edn ,
			float min_x, float min_y, float min_z, 
			float max_x, float max_y, float max_z);
 
=================
*/
void PF2_TraceCapsule(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	trace_t	trace;
	edict_t	*ent;
	vec3_t v1, v2, v3, v4;
	int nomonsters;//, entnum;

	v1[0] = stack[0]._float;
	v1[1] = stack[1]._float;
	v1[2] = stack[2]._float;

	v2[0] = stack[3]._float;
	v2[1] = stack[4]._float;
	v2[2] = stack[5]._float;

	nomonsters = stack[6]._int;

	ent = EDICT_NUM(stack[7]._int);

	v3[0] = stack[8]._float;
	v3[1] = stack[9]._float;
	v3[2] = stack[10]._float;

	v4[0] = stack[11]._float;
	v4[1] = stack[12]._float;
	v4[2] = stack[13]._float;

	trace = SV_Trace(v1, v3, v4, v2, nomonsters, ent);

	pr_global_struct->trace_allsolid = trace.allsolid;
	pr_global_struct->trace_startsolid = trace.startsolid;
	pr_global_struct->trace_fraction = trace.fraction;
	pr_global_struct->trace_inwater = trace.inwater;
	pr_global_struct->trace_inopen = trace.inopen;
	VectorCopy (trace.endpos, pr_global_struct->trace_endpos);
	VectorCopy (trace.plane.normal, pr_global_struct->trace_plane_normal);
	pr_global_struct->trace_plane_dist = trace.plane.dist;

	if (trace.e.ent)
		pr_global_struct->trace_ent = EDICT_TO_PROG(trace.e.ent);
	else
		pr_global_struct->trace_ent = EDICT_TO_PROG(sv.edicts);
}

/*
=================
PF2_checkclient
 
Returns a client (or object that has a client enemy) that would be a
valid target.
 
If there are more than one valid options, they are cycled each frame
 
If (self.origin + self.viewofs) is not in the PVS of the current target,
it is not returned at all.
 
name checkclient ()
=================
*/

static byte	*checkpvs;

int PF2_newcheckclient(int check)
{
	int		i;
	edict_t	*ent;
	vec3_t	org;

	// cycle to the next one
	if (check < 1)
		check = 1;
	if (check > MAX_CLIENTS)
		check = MAX_CLIENTS;

	if (check == MAX_CLIENTS)
		i = 1;
	else
		i = check + 1;

	for ( ; ; i++)
	{
		if (i == MAX_CLIENTS + 1)
			i = 1;

		ent = EDICT_NUM(i);

		if (i == check)
			break;	// didn't find anything else

		if (ent->free)
			continue;
		if (ent->v.health <= 0)
			continue;
		if ((int) ent->v.flags & FL_NOTARGET)
			continue;

		// anything that is a client, or has a client as an enemy
		break;
	}

	// get the PVS for the entity
	VectorAdd (ent->v.origin, ent->v.view_ofs, org);
	checkpvs = CM_LeafPVS (CM_PointInLeaf(org));

	return i;
}


#define	MAX_CHECK	16



void PF2_checkclient(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	edict_t	*ent, *self;
	int		l;
	vec3_t	view;

	// find a new check if on a new frame
	if (sv.time - sv.lastchecktime >= 0.1)
	{
		sv.lastcheck = PF2_newcheckclient(sv.lastcheck);
		sv.lastchecktime = sv.time;
	}

	// return check if it might be visible
	ent = EDICT_NUM(sv.lastcheck);
	if (ent->free || ent->v.health <= 0)
	{
		// RETURN_EDICT(sv.edicts);
		retval->_int = NUM_FOR_EDICT(sv.edicts);
		return;
	}

	// if current entity can't possibly see the check entity, return 0
	self = PROG_TO_EDICT(pr_global_struct->self);
	VectorAdd(self->v.origin, self->v.view_ofs, view);
	l = CM_Leafnum(CM_PointInLeaf(view)) - 1;
	if ((l < 0) || !(checkpvs[l >> 3] & (1 << (l & 7))))
	{
		retval->_int = NUM_FOR_EDICT(sv.edicts);
		return;

	}

	retval->_int = NUM_FOR_EDICT(ent);
	return;

}

//============================================================================
// modified by Tonik
/*
=================
PF2_stuffcmd

Sends text over to the client's execution buffer

stuffcmd (clientent, value)
=================
*/
void PF2_stuffcmd(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	char *str=NULL, *buf=NULL;
	client_t *cl, *spec;
	int entnum = stack[0]._int;
	int j;


	if (entnum < 1 || entnum > MAX_CLIENTS)
		PR2_RunError("Parm 0 not a client");

	str = VM_POINTER(base,mask,stack[1].string);
	if( !str )
		PR2_RunError("PF2_stuffcmd: NULL pointer");

	cl = &svs.clients[entnum - 1];
	if (!strncmp(str, "disconnect\n", MAX_STUFFTEXT))
	{
		// so long and thanks for all the fish
		cl->drop = true;
		return;
	}
	
	buf = cl->stufftext_buf;
	if (strlen(buf) + strlen(str) >= MAX_STUFFTEXT)
		PR2_RunError("stufftext buffer overflow");
	strlcat (buf, str, MAX_STUFFTEXT);

	if( strchr( buf, '\n' ) )
	{
		ClientReliableWrite_Begin(cl, svc_stufftext, 2 + strlen(buf));
		ClientReliableWrite_String(cl, buf);
		if (sv.mvdrecording)
		{
			MVDWrite_Begin(dem_single, cl - svs.clients, 2 + strlen(buf));
			MSG_WriteByte((sizebuf_t*)demo.dbuf, svc_stufftext);
			MSG_WriteString((sizebuf_t*)demo.dbuf, buf);
		}

		//bliP: spectator print ->
		if ((int)sv_specprint.value & SPECPRINT_STUFFCMD)
		{
			for (j = 0, spec = svs.clients; j < MAX_CLIENTS; j++, spec++)
			{
				if (!cl->state || !spec->spectator)
					continue;

				if ((spec->spec_track == entnum) && (cl->spec_print & SPECPRINT_STUFFCMD))
				{
					ClientReliableWrite_Begin (spec, svc_stufftext, 2+strlen(buf));
					ClientReliableWrite_String (spec, buf);
				}
			}
		}
		buf[0] = 0;
	}

}

/*
=================
PF2_localcmd
 
Sends text over to the server's execution buffer
 
localcmd (string)
=================
*/
void PF2_localcmd(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	Cbuf_AddText(VM_POINTER(base,mask,stack[0].string));
}

void PF2_executecmd(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int old_other, old_self; // mod_consolecmd will be executed, so we need to store this

	old_self = pr_global_struct->self;
	old_other = pr_global_struct->other;

	Cbuf_Execute();

	pr_global_struct->self = old_self;
	pr_global_struct->other = old_other;
}

/*
=================
PF2_readcmd
 
void readmcmd (string str,string buff, int sizeofbuff)
=================
*/

void PF2_readcmd (byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	char		*str;
	extern char outputbuf[];
	char		*buf;
	int 		sizebuff;
	extern 	redirect_t sv_redirected;
	redirect_t old;

	str = VM_POINTER(base,mask,stack[0].string);
	buf = VM_POINTER(base,mask,stack[1].string);
	sizebuff = stack[2]._int;

	Cbuf_Execute();
	Cbuf_AddText (str);

	old = sv_redirected;

	if (old != RD_NONE)
		SV_EndRedirect();

	SV_BeginRedirect(RD_MOD);
	Cbuf_Execute();

	strlcpy(buf, outputbuf, sizebuff);

	SV_EndRedirect();

	if (old != RD_NONE)
		SV_BeginRedirect(old);

}

/*
=================
PF2_redirectcmd
 
void redirectcmd (entity to, string str)
=================
*/

void PF2_redirectcmd (byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	char		*str;
	int 		entnum;
	//	redirect_t old;

	extern redirect_t sv_redirected;

	str = VM_POINTER(base,mask,stack[1].string);
	if ( sv_redirected )
	{
		Cbuf_AddText (str);
		Cbuf_Execute();
		return;
	}

	entnum = NUM_FOR_EDICT(VM_POINTER(base,mask,stack[0]._int));

	if (entnum < 1 || entnum > MAX_CLIENTS)
		PR2_RunError ("Parm 0 not a client");


	SV_BeginRedirect( RD_MOD + entnum );
	Cbuf_AddText (str);
	Cbuf_Execute();
	SV_EndRedirect();

}

/*
=================
PF2_cvar
 
float   trap_cvar( const char *var );
=================
*/
void PF2_cvar(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{

	retval->_float =  Cvar_Value(VM_POINTER(base,mask,stack[0].string));
}

/*
=================
PF2_cvar_string
 
void trap_cvar_string( const char *var, char *buffer, int bufsize )
=================
*/
void PF2_cvar_string(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int buff_off = stack[1]._int;
	int buffsize = stack[2]._int;

	if( ( buff_off )  &(~mask))
		return;

	if( ( buff_off + buffsize ) &(~mask))
		return;

	strlcpy(VM_POINTER(base,mask,buff_off),
	        Cvar_String(VM_POINTER(base,mask,stack[0].string)), buffsize);
}

/*
=================
PF2_cvar_set
 
void    trap_cvar_set( const char *var, const char *val );
=================
*/
void PF2_cvar_set(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	Cvar_SetByName(VM_POINTER(base,mask,stack[0].string),VM_POINTER(base,mask,stack[1].string));
}
/*
=================
PF2_cvar_set_float
 
void    trap_cvar_set_float( const char *var, float val );
=================
*/
void PF2_cvar_set_float(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	Cvar_SetValueByName( VM_POINTER(base,mask,stack[0].string), stack[1]._float);
}

/*
=================
PF2_FindRadius

Returns a chain of entities that have origins within a spherical area
gedict_t *findradius( gedict_t * start, vec3_t org, float rad );
=================
*/

void PF2_FindRadius( byte * base, unsigned int mask, pr2val_t * stack, pr2val_t * retval )
{
	int     e,j;

	edict_t *ed;
	float* org;
	vec3_t	eorg;
	float rad;

	e = NUM_FOR_EDICT( VM_POINTER( base, mask, stack[0]._int ) );
	org = VM_POINTER( base, mask, stack[1]._int );
	rad = stack[2]._float;

	for ( e++; e < sv.num_edicts; e++ )
	{
		ed = EDICT_NUM( e );

		if ( ed->free )
			continue;
		if (ed->v.solid == SOLID_NOT)
			continue;
		for (j=0 ; j<3 ; j++)
			eorg[j] = org[j] - (ed->v.origin[j] + (ed->v.mins[j] + ed->v.maxs[j])*0.5);			
		if (VectorLength(eorg) > rad)
			continue;
		retval->_int = POINTER_TO_VM( base, mask, ed );
		return;
	}
	retval->_int = 0;
	return;
}

/*
===============
PF2_walkmove
 
float(float yaw, float dist) walkmove
===============
*/
void PF2_walkmove(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
//(int entn, float yaw, float dist)
{
	edict_t		*ent;
	float		yaw, dist;
	vec3_t		move;
	//	dfunction_t	*oldf;
	int			oldself;
	//	int			ret;
	//

	/*if( sv_vm->type == VM_BYTECODE)///FIXME !!! not worked yet
	{
		retval->_int =  0; 
		return;
	}*/
	//	ent = PROG_TO_EDICT(pr_global_struct->self);
	//	yaw = G_FLOAT(OFS_PARM0);
	//	dist = G_FLOAT(OFS_PARM1);
	ent  = EDICT_NUM(stack[0]._int);
	yaw  = stack[1]._float;
	dist = stack[2]._float;

	if (!((int) ent->v.flags & (FL_ONGROUND | FL_FLY | FL_SWIM)))
	{
		retval->_int =  0;
		return;

	}

	yaw = yaw * M_PI * 2 / 360;

	move[0] = cos(yaw) * dist;
	move[1] = sin(yaw) * dist;
	move[2] = 0;

	// save program state, because SV_movestep may call other progs
	//	oldf = pr_xfunction;
	oldself = pr_global_struct->self;

	retval->_int = SV_movestep(ent, move, true);


	// restore program state
	//	pr_xfunction = oldf;
	pr_global_struct->self = oldself;
	return;
}

/*
===============
PF2_droptofloor
 
void(entnum) droptofloor
===============
*/
void PF2_droptofloor(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	edict_t		*ent;
	vec3_t		end;
	trace_t		trace;

	ent = EDICT_NUM(stack[0]._int);

	VectorCopy(ent->v.origin, end);
	end[2] -= 256;

	trace = SV_Trace(ent->v.origin, ent->v.mins, ent->v.maxs, end, false, ent);

	if (trace.fraction == 1 || trace.allsolid)
	{
		retval->_int =  0;
		return;
	}
	else
	{
		VectorCopy(trace.endpos, ent->v.origin);
		SV_LinkEdict(ent, false);
		ent->v.flags = (int) ent->v.flags | FL_ONGROUND;
		ent->v.groundentity = EDICT_TO_PROG(trace.e.ent);
		retval->_int =  1;
		return;
	}
}

/*
===============
PF2_lightstyle
 
void(int style, string value) lightstyle
===============
*/
void PF2_lightstyle(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	client_t	*client;
	int			j,style;
	char*	val;

	style 	= stack[0]._int;
	val	= VM_POINTER(base,mask,stack[1]._int);

	// change the string in sv
	sv.lightstyles[style] = val;

	// send message to all clients on this server
	if (sv.state != ss_active)
		return;

	for (j = 0, client = svs.clients; j < MAX_CLIENTS; j++, client++)
		if (client->state == cs_spawned)
		{
			ClientReliableWrite_Begin(client, svc_lightstyle, strlen(val) + 3);
			ClientReliableWrite_Char(client, style);
			ClientReliableWrite_String(client, val);
		}

	if (sv.mvdrecording)
	{
		MVDWrite_Begin(dem_all, 0, strlen(val) + 3);
		MSG_WriteByte((sizebuf_t *) demo.dbuf, svc_lightstyle);
		MSG_WriteChar((sizebuf_t *) demo.dbuf, style);
		MSG_WriteString((sizebuf_t *) demo.dbuf, val);
	}
}
/*
=============
PF2_checkbottom
=============
*/
void PF2_checkbottom(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_int = SV_CheckBottom(EDICT_NUM(stack[0]._int));
}

/*
=============
PF2_pointcontents
=============
*/
void PF2_pointcontents(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	vec3_t v;
	v[0] = stack[0]._float;
	v[1] = stack[1]._float;
	v[2] = stack[2]._float;

	retval->_int = SV_PointContents(v);
}

/*
=============
PF2_nextent
 
entity nextent(entity)
=============
*/
void PF2_nextent(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int		i;
	edict_t	*ent;

	i = stack[0]._int;
	while (1)
	{
		i++;
		if (i >= sv.num_edicts)
		{
			retval->_int = 0;
			return;
		}
		ent = EDICT_NUM(i);
		if (!ent->free)
		{
			retval->_int = i;
			return;
		}
	}
}

/*
=============
PF2_nextclient

fast walk over spawned clients
 
entity nextclient(entity)
=============
*/
void PF2_nextclient(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int		i;
	edict_t	*ent;

	i = NUM_FOR_EDICT((edict_t *) VM_POINTER(base,mask,stack[0]._int));;
	while (1)
	{
		i++;
		if (i < 1 || i > MAX_CLIENTS)
		{
			retval->_int = 0;
			return;
		}
		ent = EDICT_NUM(i);
		if (!ent->free) // actually that always true for clients edicts
		{
			if (svs.clients[i-1].state == cs_spawned) // client in game
			{
				retval->_int = POINTER_TO_VM(base,mask,ent);
				return;
			}
		}
	}
}

/*
=============
PF2_find

entity find(start,fieldoff,str)
=============
*/
void PF2_Find (byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int		e;
	int 		fofs;
	char*		str,*t;
	edict_t	*ed;

	e  = NUM_FOR_EDICT((edict_t *) VM_POINTER(base,mask,stack[0]._int));
	fofs = stack[1]._int;

	str = VM_POINTER(base,mask,stack[2].string);

	if(!str)
		PR2_RunError ("PF2_Find: bad search string");

	for (e++ ; e < sv.num_edicts ; e++)
	{
		ed = EDICT_NUM(e);
		if (ed->free)
			continue;
		t= VM_POINTER(base,mask,*(int*)((char *) ed + fofs));
		if (!t)
			continue;
		if (!strcmp(t,str))
		{
			retval->_int = POINTER_TO_VM(base,mask,ed);
			return;
		}

	}
	retval->_int = 0;
	return;
}

/*
=============
PF2_aim ??????
 
Pick a vector for the player to shoot along
vector aim(entity, missilespeed)
=============
*/
/*
==============
PF2_changeyaw ???
 
This was a major timewaster in progs, so it was converted to C
==============
*/

/*
===============================================================================
 
MESSAGE WRITING
 
===============================================================================
*/


#define	MSG_BROADCAST	0		// unreliable to all
#define	MSG_ONE			1		// reliable to one (msg_entity)
#define	MSG_ALL			2		// reliable to all
#define	MSG_INIT		3		// write to the init string
#define	MSG_MULTICAST	4		// for multicast()


sizebuf_t *WriteDest2(int dest)
{
	//	int		entnum;
	//	int		dest;
	//	edict_t	*ent;

	//dest = G_FLOAT(OFS_PARM0);
	switch (dest)
	{
	case MSG_BROADCAST:
		return &sv.datagram;

	case MSG_ONE:
		SV_Error("Shouldn't be at MSG_ONE");
#if 0
		ent = PROG_TO_EDICT(pr_global_struct->msg_entity);
		entnum = NUM_FOR_EDICT(ent);
		if (entnum < 1 || entnum > MAX_CLIENTS)
			PR2_RunError("WriteDest: not a client");
		return &svs.clients[entnum - 1].netchan.message;
#endif

	case MSG_ALL:
		return &sv.reliable_datagram;

	case MSG_INIT:
		if (sv.state != ss_loading)
			PR2_RunError("PF_Write_*: MSG_INIT can only be written in spawn "
			             "functions");
		return &sv.signon;

	case MSG_MULTICAST:
		return &sv.multicast;

	default:
		PR2_RunError ("WriteDest: bad destination");
		break;
	}

	return NULL;
}

static client_t *Write_GetClient(void)
{
	int		entnum;
	edict_t	*ent;

	ent = PROG_TO_EDICT(pr_global_struct->msg_entity);
	entnum = NUM_FOR_EDICT(ent);
	if (entnum < 1 || entnum > MAX_CLIENTS)
		PR2_RunError("WriteDest: not a client");
	return &svs.clients[entnum - 1];
}

void PF2_WriteByte(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int to   = stack[0]._int;
	int data = stack[1]._int;

	if (to == MSG_ONE)
	{
		client_t *cl = Write_GetClient();
		ClientReliableCheckBlock(cl, 1);
		ClientReliableWrite_Byte(cl, data);
		if (sv.mvdrecording)
		{
			MVDWrite_Begin(dem_single, cl - svs.clients, 1);
			MSG_WriteByte((sizebuf_t *) demo.dbuf, data);
		}
	}
	else
		MSG_WriteByte(WriteDest2(to), data);
}

void PF2_WriteChar(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int to   = stack[0]._int;
	int data = stack[1]._int;

	if (to == MSG_ONE)
	{
		client_t *cl = Write_GetClient();
		ClientReliableCheckBlock(cl, 1);
		ClientReliableWrite_Char(cl, data);
		if (sv.mvdrecording)
		{
			MVDWrite_Begin(dem_single, cl - svs.clients, 1);
			MSG_WriteByte((sizebuf_t *) demo.dbuf, data);
		}
	}
	else
		MSG_WriteChar(WriteDest2(to), data);
}

void PF2_WriteShort(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int to   = stack[0]._int;
	int data = stack[1]._int;

	if (to == MSG_ONE)
	{
		client_t *cl = Write_GetClient();
		ClientReliableCheckBlock(cl, 2);
		ClientReliableWrite_Short(cl, data);
		if (sv.mvdrecording)
		{
			MVDWrite_Begin(dem_single, cl - svs.clients, 2);
			MSG_WriteShort((sizebuf_t *) demo.dbuf, data);
		}
	}
	else
		MSG_WriteShort(WriteDest2(to), data);
}

void PF2_WriteLong(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int to   = stack[0]._int;
	int data = stack[1]._int;

	if (to == MSG_ONE)
	{
		client_t *cl = Write_GetClient();
		ClientReliableCheckBlock(cl, 4);
		ClientReliableWrite_Long(cl, data);
		if (sv.mvdrecording)
		{
			MVDWrite_Begin(dem_single, cl - svs.clients, 4);
			MSG_WriteLong((sizebuf_t *) demo.dbuf, data);
		}
	}
	else
		MSG_WriteLong(WriteDest2(to), data);
}

void PF2_WriteAngle(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int to     = stack[0]._int;
	float data = stack[1]._float;

	if (to == MSG_ONE)
	{
		client_t *cl = Write_GetClient();
		ClientReliableCheckBlock(cl, 1);
		ClientReliableWrite_Angle(cl, data);
		if (sv.mvdrecording)
		{
			MVDWrite_Begin(dem_single, cl - svs.clients, 1);
			MSG_WriteByte((sizebuf_t *) demo.dbuf, data);
		}
	}
	else
		MSG_WriteAngle(WriteDest2(to), data);
}

void PF2_WriteCoord(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int to     = stack[0]._int;
	float data = stack[1]._float;

	if (to == MSG_ONE)
	{
		client_t *cl = Write_GetClient();
		ClientReliableCheckBlock(cl, 2);
		ClientReliableWrite_Coord(cl, data);
		if (sv.mvdrecording)
		{
			MVDWrite_Begin(dem_single, cl - svs.clients, 2);
			MSG_WriteCoord((sizebuf_t *) demo.dbuf, data);
		}
	}
	else
		MSG_WriteCoord(WriteDest2(to), data);
}

void PF2_WriteString(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int to     = stack[0]._int;
	char* data = VM_POINTER(base,mask,stack[1].string);

	if (to == MSG_ONE)
	{
		client_t *cl = Write_GetClient();
		ClientReliableCheckBlock(cl, 1 + strlen(data));
		ClientReliableWrite_String(cl, data);
		if (sv.mvdrecording)
		{
			MVDWrite_Begin(dem_single, cl - svs.clients, 1 + strlen(data));
			MSG_WriteString((sizebuf_t *) demo.dbuf, data);
		}
	}
	else
		MSG_WriteString(WriteDest2(to), data);
}


void PF2_WriteEntity(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int to     = stack[0]._int;
	int data   = stack[1]._int;

	if (to == MSG_ONE)
	{
		client_t *cl = Write_GetClient();
		ClientReliableCheckBlock(cl, 2);
		ClientReliableWrite_Short(cl,data );//G_EDICTNUM(OFS_PARM1)
		if (sv.mvdrecording)
		{
			MVDWrite_Begin(dem_single, cl - svs.clients, 2);
			MSG_WriteShort((sizebuf_t *) demo.dbuf, data);
		}
	}
	else
		MSG_WriteShort(WriteDest2(to), data);
}

//=============================================================================

int SV_ModelIndex(char *name);

/*
==================
PF2_makestatic 
 
==================
*/
void PF2_makestatic(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	edict_t	*ent;
	int		i;

	ent = EDICT_NUM(stack[0]._int);

	MSG_WriteByte(&sv.signon, svc_spawnstatic);

	MSG_WriteByte(&sv.signon, SV_ModelIndex(VM_POINTER(base,mask,ent->v.model)));

	MSG_WriteByte(&sv.signon, ent->v.frame);
	MSG_WriteByte(&sv.signon, ent->v.colormap);
	MSG_WriteByte(&sv.signon, ent->v.skin);
	for (i = 0; i < 3; i++)
	{
		MSG_WriteCoord(&sv.signon, ent->v.origin[i]);
		MSG_WriteAngle(&sv.signon, ent->v.angles[i]);
	}

	// throw the entity away now
	ED_Free(ent);
}

//=============================================================================

/*
==============
PF2_setspawnparms
==============
*/
void PF2_setspawnparms(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int			i;
	//edict_t		*ent;
	int			entnum=stack[0]._int;
	client_t	*client;

	//ent = EDICT_NUM(entnum);

	if (entnum < 1 || entnum > MAX_CLIENTS)
		PR2_RunError("Entity is not a client");

	// copy spawn parms out of the client_t
	client = svs.clients + (entnum - 1);

	for (i = 0; i < NUM_SPAWN_PARMS; i++)
		(&pr_global_struct->parm1)[i] = client->spawn_parms[i];
}

/*
==============
PF2_changelevel
==============
*/
void PF2_changelevel(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	static int last_spawncount;
	char *s = VM_POINTER(base,mask,stack[0].string);
	char expanded[MAX_QPATH];
	FILE *f;

	// check to make sure the level exists.
	// this is work around for bellow check about two changelevels,
	// which lock server in one map if we trying switch to map which does't exist
	snprintf(expanded, MAX_QPATH, "maps/%s.bsp", s);
	COM_FOpenFile (expanded, &f);
	if (!f)
	{
		Sys_Printf ("Can't find %s\n", expanded);
		return;
	}
	fclose (f);

	// make sure we don't issue two changelevels
	// this check is evil and cause lock on one map, if /map command fail for some reason
	if (svs.spawncount == last_spawncount)
		return;
	last_spawncount = svs.spawncount;

	Cbuf_AddText(va("map %s\n", s));
}

/*
==============
PF2_logfrag
 
logfrag (killer, killee)
==============
*/
void PF2_logfrag(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	//	edict_t	*ent1, *ent2;
	int		e1, e2;
	char	*s;
	// -> scream
	time_t		t;
	struct tm	*tblock;
	// <-

	//ent1 = G_EDICT(OFS_PARM0);
	//ent2 = G_EDICT(OFS_PARM1);

	e1 = stack[0]._int;
	e2 = stack[1]._int;

	if (e1 < 1 || e1 > MAX_CLIENTS || e2 < 1 || e2 > MAX_CLIENTS)
		return;

	// -> scream
	t = time (NULL);
	tblock = localtime (&t);

	//bliP: date check ->
	if (!tblock)
		s = va("%s\n", "#bad date#");
	else
		if ((int)frag_log_type.value) // need for old-style frag log file
			s = va("\\frag\\%s\\%s\\%s\\%s\\%d-%d-%d %d:%d:%d\\\n",
			       svs.clients[e1-1].name, svs.clients[e2-1].name,
			       svs.clients[e1-1].team, svs.clients[e2-1].team,
			       tblock->tm_year + 1900, tblock->tm_mon + 1, tblock->tm_mday,
			       tblock->tm_hour, tblock->tm_min, tblock->tm_sec);
		else
			s = va("\\%s\\%s\\\n",svs.clients[e1-1].name, svs.clients[e2-1].name);
	// <-

	SZ_Print(&svs.log[svs.logsequence & 1], s);
	SV_Write_Log(FRAG_LOG, 1, s);
}
/*
==============
PF2_getinfokey
 
string(entity e, string key) infokey
==============
*/
void PF2_infokey(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
//(int e1, char *key, char *valbuff, int sizebuff)
{
	static char ov[256];

	//	edict_t	*e;
	int		e1 	= stack[0]._int;
	char		*key	= VM_POINTER(base,mask,stack[1].string);
	char		*valbuff= VM_POINTER(base,mask,stack[2].string);
	char		*value;
	int		sizebuff= stack[3]._int;

	//	e = G_EDICT(OFS_PARM0);
	//	e1 = NUM_FOR_EDICT(e);
	//	key = G_STRING(OFS_PARM1);

	value = ov;

	if (e1 == 0)
	{
		if (key && key[0] == '\\') { // so we can check is server support such "hacks" via infokey(world, "\\realip") f.e.
			key++;

			value = "no";

			if (   !strcmp(key, "date_str")
				|| !strcmp(key, "ip") || !strncmp(key, "realip", 7) || !strncmp(key, "download", 9)
				|| !strcmp(key, "ping") || !strcmp(key, "*userid") || !strncmp(key, "login", 6)
				|| !strcmp(key, "*VIP") || !strcmp(key, "*state")
			   )
				value = "yes";
		}
		else if (!strcmp(key, "date_str")) { // qqshka - qvm does't have any time builtin support, so add this
			date_t date;

			SV_TimeOfDay(&date);
			snprintf(ov, sizeof(ov), "%s", date.str);
		}
		else if ((value = Info_ValueForKey(svs.info, key)) == NULL || !*value)
			value = Info_ValueForKey(localinfo, key);
	}
	else if (e1 > 0 && e1 <= MAX_CLIENTS)
	{
		client_t *cl = &svs.clients[e1-1];

		if (!strcmp(key, "ip"))
			strlcpy(ov, NET_BaseAdrToString(cl->netchan.remote_address), sizeof(ov));
		else if (!strncmp(key, "realip", 7))
			strlcpy(ov, NET_BaseAdrToString (cl->realip), sizeof(ov));
		else if (!strncmp(key, "download", 9))
			snprintf(ov, sizeof(ov), "%d", cl->file_percent ? cl->file_percent : -1); //bliP: file percent
		else if (!strcmp(key, "ping"))
			snprintf(ov, sizeof(ov), "%d", (int)SV_CalcPing(cl));
		else if (!strcmp(key, "*userid"))
			snprintf(ov, sizeof(ov), "%d", cl->userid);
		else if (!strncmp(key, "login", 6))
			value = cl->login;
		else if (!strcmp(key, "*VIP")) // qqshka: also located in userinfo, but this is more safe/secure way, imo
			snprintf(ov, sizeof(ov), "%d", cl->vip);
		else if (!strcmp(key, "*state"))
		{
			switch (cl->state)
			{
				case cs_free:         value = "free"; break;
				case cs_zombie:       value = "zombie"; break;
				case cs_preconnected: value = "preconnected"; break;
				case cs_connected:    value = "connected"; break;
				case cs_spawned:      value = "spawned"; break;

				default: value = "unknown"; break;
			}
		}
		else
			value = Info_ValueForKey(cl->userinfo, key);
	}
	else
		value = "";

	if ((int) strlen(value) > sizebuff)
		Con_DPrintf("PR2_infokey: buffer size too small\n");

	strlcpy(valbuff, value, sizebuff);
	//	RETURN_STRING(value);
}

/*
==============
PF2_multicast
 
void(vector where, float set) multicast
==============
*/
void PF2_multicast(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
//(vec3_t o, int to)
{
	vec3_t o;
	int to;

	o[0] = stack[0]._float;
	o[1] = stack[1]._float;
	o[2] = stack[2]._float;
	to   = stack[3]._int;
	SV_Multicast(o, to, 0, 0);
}

/*
==============
PF2_disable_updates
 
void(entiny whom, float time) disable_updates
==============
*/
void PF2_disable_updates(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
//(int entnum, float time)
{
	client_t *client;
	int entnum = stack[0]._int;
	float time1   = stack[1]._float;

	//	entnum = G_EDICTNUM(OFS_PARM0);
	//	time1 = G_FLOAT(OFS_PARM1);

	if (entnum < 1 || entnum > MAX_CLIENTS)
	{
		Con_Printf("tried to disable_updates to a non-client\n");
		return;
	}

	client = &svs.clients[entnum - 1];

	client->disable_updates_stop = realtime + time1;
}

/*
==============
PR2_FlushSignon();
==============
*/
void PR2_FlushSignon(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	SV_FlushSignon();
}

/*
==============
PF2_cmdargc
==============
*/
void PF2_cmdargc(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_int = Cmd_Argc();
}

/*
==============
PF2_cmdargv
==============
*/
void PF2_cmdargv(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
//(int arg, char *valbuff, int sizebuff)
{
	strlcpy(VM_POINTER(base,mask,stack[1].string), Cmd_Argv(stack[0]._int), stack[2]._int);
}

/*
==============
PF2_cmdargs
==============
*/
void PF2_cmdargs(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
//(char *valbuff, int sizebuff)
{
	strlcpy(VM_POINTER(base,mask,stack[0].string), Cmd_Args(), stack[1]._int);
}

/*
==============
PF2_tokenize
==============
*/
void PF2_tokenize(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
//(char *str)
{
	Cmd_TokenizeString(VM_POINTER(base,mask,stack[0].string));
}

void PF2_fixme(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
}

void PF2_memset(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_int= PR2_SetString(memset(VM_POINTER(base,mask,stack[0].string),stack[1]._int,stack[2]._int));
}

void PF2_memcpy(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_int= PR2_SetString( memcpy( VM_POINTER(base,mask,stack[0].string),
	                                     VM_POINTER(base,mask,stack[1].string),
	                                     stack[2]._int));
}
void PF2_strncpy(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_int= PR2_SetString( strncpy( VM_POINTER(base,mask,stack[0].string),
	                                      VM_POINTER(base,mask,stack[1].string),
	                                      stack[2]._int));
}

void PF2_sin(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_float=sin(stack[0]._float);
}

void PF2_cos(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_float=cos(stack[0]._float);
}

void PF2_atan2(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_float=atan2(stack[0]._float,stack[1]._float);
}

void PF2_sqrt(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_float=sqrt(stack[0]._float);
}

void PF2_floor(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_float=floor(stack[0]._float);
}
void PF2_ceil(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_float=ceil(stack[0]._float);
}

void PF2_acos(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_float=acos(stack[0]._float);
}


#define MAX_PR2_FILES 8

typedef struct
{
	char name[256];
	FILE*handle;
	fsMode_t accessmode;
}
pr2_fopen_files_t;

pr2_fopen_files_t pr2_fopen_files[MAX_PR2_FILES];
int pr2_num_open_files = 0;

char* cmodes[]={"rb","r","wb","w","ab","a"};
/*
int	trap_FS_OpenFile(char*name, fileHandle_t* handle, fsMode_t fmode );
*/
//FIX ME read from paks
void PF2_FS_OpenFile(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	char *name=(char*)VM_POINTER(base,mask,stack[0].string);
	fileHandle_t* handle=(fileHandle_t*)VM_POINTER(base,mask,stack[1]._int);
	fsMode_t fmode = stack[2]._int;
	int i;
	char    fname[MAX_OSPATH];
	char   *gpath = NULL;
	char		*gamedir;

	if(pr2_num_open_files >= MAX_PR2_FILES)
	{
		retval->_int = -1;
		return ;
	}

	*handle = 0;
	for (i = 0; i < MAX_PR2_FILES; i++)
		if (!pr2_fopen_files[i].handle)
			break;
	if (i == MAX_PR2_FILES)	//too many already open
	{
		retval->_int = -1;
		return ;
	}

	if (name[1] == ':' ||	//dos filename absolute path specified - reject.
	        *name == '\\' || *name == '/' ||	//absolute path was given - reject
	        strstr(name, ".."))	//someone tried to be cleaver.
	{
		retval->_int = -1;
		return ;
	}
	strlcpy(pr2_fopen_files[i].name, name, sizeof(pr2_fopen_files[i].name));
	pr2_fopen_files[i].accessmode = fmode;
	switch(fmode)
	{
	case FS_READ_BIN:
	case FS_READ_TXT:

		while ( ( gpath = COM_NextPath( gpath ) ) )
		{
			snprintf( fname, sizeof( fname ), "%s/%s" , gpath, name );
			pr2_fopen_files[i].handle = fopen(fname, cmodes[fmode]);
			if ( pr2_fopen_files[i].handle )
			{

				Con_DPrintf( "PF2_FS_OpenFile %s\n", fname );
				break;
			}
		}

		if(!pr2_fopen_files[i].handle)
		{
			retval->_int = -1;
			return ;
		}
		fseek(pr2_fopen_files[i].handle,0,SEEK_END);
		retval->_int = ftell(pr2_fopen_files[i].handle);
		fseek(pr2_fopen_files[i].handle,0,0);

		break;
	case FS_WRITE_BIN:
	case FS_WRITE_TXT:
	case FS_APPEND_BIN:
	case FS_APPEND_TXT:

/*
		gamedir = Info_ValueForKey (svs.info, "*gamedir");
		if (!gamedir[0])
			gamedir = "qw";
*/
		gamedir = fs_gamedir;

		snprintf( fname, sizeof( fname ), "%s/%s" , gamedir, name );
		pr2_fopen_files[i].handle = fopen(fname, cmodes[fmode]);
		if ( !pr2_fopen_files[i].handle )
		{
			retval->_int = -1;
			return ;
		}
		Con_DPrintf( "PF2_FS_OpenFile %s\n", fname );
		retval->_int = ftell(pr2_fopen_files[i].handle);

		break;
	default:
		retval->_int = -1;
		return ;

	}

	*handle = i+1;
	pr2_num_open_files++;
}
/*
void	trap_FS_CloseFile( fileHandle_t handle );
*/
void PF2_FS_CloseFile(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	fileHandle_t fnum =  stack[0]._int;
	fnum--;
	if (fnum < 0 || fnum >= MAX_PR2_FILES)
		return;	//out of range
	if(!pr2_num_open_files)
		return;
	if(!(pr2_fopen_files[fnum].handle))
		return;
	fclose(pr2_fopen_files[fnum].handle);
	pr2_fopen_files[fnum].handle = NULL;
	pr2_num_open_files--;
}

int seek_origin[]={SEEK_CUR,SEEK_END,SEEK_SET};

/*
int	trap_FS_SeekFile( fileHandle_t handle, int offset, int type );
*/

void PF2_FS_SeekFile(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	fileHandle_t fnum =  stack[0]._int;
	int offset = stack[1]._int;
	fsOrigin_t type = stack[2]._int;
	fnum--;

	if (fnum < 0 || fnum >= MAX_PR2_FILES)
		return;	//out of range

	if(!pr2_num_open_files)
		return;

	if(!(pr2_fopen_files[fnum].handle))
		return;
	if(type <0 || type > 2)
		return;
	retval->_int = fseek(pr2_fopen_files[fnum].handle,offset,seek_origin[type]);
}

/*
int	trap_FS_TellFile( fileHandle_t handle );
*/

void PF2_FS_TellFile(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	fileHandle_t fnum =  stack[0]._int;
	fnum--;

	if (fnum < 0 || fnum >= MAX_PR2_FILES)
		return;	//out of range

	if(!pr2_num_open_files)
		return;

	if(!(pr2_fopen_files[fnum].handle))
		return;
	retval->_int = ftell(pr2_fopen_files[fnum].handle);
}

/*
int	trap_FS_WriteFile( char*src, int quantity, fileHandle_t handle );
*/
void PF2_FS_WriteFile(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	char*dest;
	int memoffset = stack[0]._int;
	int quantity = stack[1]._int;
	fileHandle_t fnum =  stack[2]._int;
	fnum--;
	if (fnum < 0 || fnum >= MAX_PR2_FILES)
		return;	//out of range

	if(!pr2_num_open_files)
		return;

	if(!(pr2_fopen_files[fnum].handle))
		return;
	if( (memoffset) &(~mask))
		return;

	if( (memoffset+quantity) &(~mask))
		return;

	dest = (char*)VM_POINTER(base,mask,memoffset);
	retval->_int = fwrite(dest,quantity,1,pr2_fopen_files[fnum].handle);

}
/*
int	trap_FS_ReadFile( char*dest, int quantity, fileHandle_t handle );
*/
void PF2_FS_ReadFile(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	char*dest;
	int memoffset = stack[0]._int;
	int quantity = stack[1]._int;
	fileHandle_t fnum =  stack[2]._int;
	fnum--;
	if (fnum < 0 || fnum >= MAX_PR2_FILES)
		return;	//out of range

	if(!pr2_num_open_files)
		return;

	if(!(pr2_fopen_files[fnum].handle))
		return;
	if( (memoffset) &(~mask))
		return;

	if( (memoffset+quantity) &(~mask))
		return;

	dest = (char*)VM_POINTER(base,mask,memoffset);
	retval->_int = fread(dest,quantity,1,pr2_fopen_files[fnum].handle);
}

void PR2_FS_Restart()
{
	int i;
	if(pr2_num_open_files)
	{
		for (i = 0; i <= MAX_PR2_FILES; i++)
		{
			if(pr2_fopen_files[i].handle)
			{
				fclose(pr2_fopen_files[i].handle);
				pr2_num_open_files--;
				pr2_fopen_files[i].handle = NULL;
			}
		}
	}
	if(pr2_num_open_files)
		Sys_Error("PR2_fcloseall: pr2_num_open_files != 0\n");
	pr2_num_open_files = 0;
	memset(pr2_fopen_files,0,sizeof(pr2_fopen_files));
}

/*
int 	trap_FS_GetFileList(  const char *path, const char *extension, char *listbuf, int bufsize );
*/
void PF2_FS_GetFileList(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	char    fname[MAX_OSPATH];
	char*path,*ext,*listbuff,*dirptr;
	char		*gamedir;
#ifdef _WIN32
	typedef void *HANDLE;
	HANDLE	h;
	WIN32_FIND_DATA fd;
#else
	DIR *d;
	struct dirent	*dstruct;
	struct stat		fileinfo;
#endif
	int pathoffset 		= stack[0]._int;
	int extoffset  		= stack[1]._int;
	int listbuffoffset  	= stack[2]._int;
	int buffsize		= stack[3]._int;
	int numfiles = 0;

	retval->_int = 0;

	if( ( listbuffoffset ) &(~mask))
		return;

	if( ( listbuffoffset + buffsize ) &(~mask))
		return;
	if( ( extoffset ) & (~mask))
		return;
	if( ( pathoffset ) & (~mask))
		return;

	path = (char*)VM_POINTER(base,mask,pathoffset);
	ext  = (char*)VM_POINTER(base,mask,extoffset);;

	listbuff = (char*)VM_POINTER(base,mask,listbuffoffset);
	dirptr = listbuff;
	*dirptr = 0;
/*
	gamedir = Info_ValueForKey (svs.info, "*gamedir");
	if (!gamedir[0])
		gamedir = "qw";
*/
	gamedir = fs_gamedir;

	snprintf( fname, sizeof( fname ), "%s/%s/*%s" , gamedir, path, ext );

#ifdef _WIN32
	h = FindFirstFile ( fname, &fd);
	if (h == INVALID_HANDLE_VALUE)
	{
#else
	if (!(d = opendir(fname)))
	{
#endif
		return;
	}
#ifndef _WIN32
	dstruct = readdir (d);
#endif
	do
	{
		int size;
		int namelen;
		char* filename;
		qbool	is_dir;
#ifdef _WIN32
		filename = fd.cFileName;
		is_dir = fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY;
		size = fd.nFileSizeLow;
#else
		filename = dstruct->d_name;
		snprintf( fname, sizeof( fname ), "%s/%s/%s" , gamedir, path, filename );
		stat (fname, &fileinfo);
		is_dir = S_ISDIR( fileinfo.st_mode );
		size = fileinfo.st_size;
#endif
		if (is_dir)
			continue;

		namelen = strlen(filename)+1;
		if(dirptr + namelen > listbuff + buffsize)
			break;
		strlcpy(dirptr,filename,namelen);
		dirptr+= namelen;
		numfiles++;
#ifdef _WIN32

	}
	while ( FindNextFile(h, &fd) );
	FindClose (h);
#else

	}
	while ((dstruct = readdir (d)));
	closedir (d);
#endif
	retval->_int = numfiles;
}

/*
  int trap_Map_Extension( const char* ext_name, int mapto)
  return:
    0 	success maping
   -1	not found
   -2	cannot map
*/
extern int pr2_numAPI;
void PF2_Map_Extension(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	int mapto	= stack[1]._int;

	if( mapto <  pr2_numAPI)
	{

		retval->_int = -2;
		return;
	}

	retval->_int = -1;
}
////////////////////
//
// timewaster functions
//
////////////////////
void PF2_strcmp(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_int=  strcmp( VM_POINTER(base,mask,stack[0].string),
	                       VM_POINTER(base,mask,stack[1].string));
}

void PF2_strncmp(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_int=  strncmp( VM_POINTER(base,mask,stack[0].string),
	                        VM_POINTER(base,mask,stack[1].string),stack[2]._int);
}

void PF2_stricmp(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_int=  strcasecmp( VM_POINTER(base,mask,stack[0].string),
	                           VM_POINTER(base,mask,stack[1].string));
}

void PF2_strnicmp(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	retval->_int=  strncasecmp( VM_POINTER(base,mask,stack[0].string),
	                            VM_POINTER(base,mask,stack[1].string),stack[2]._int);
}

void PF2_strlcpy(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{ // (char *dst, char *src, size_t siz)
	retval->_int = strlcpy( VM_POINTER(base,mask,stack[0].string), VM_POINTER(base,mask,stack[1].string), stack[2]._int );
}

void PF2_strlcat(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{ // (char *dst, char *src, size_t siz)
	retval->_int = strlcat( VM_POINTER(base,mask,stack[0].string), VM_POINTER(base,mask,stack[1].string), stack[2]._int );
}

/////////Bot Functions
extern cvar_t maxclients, maxspectators;
void PF2_Add_Bot( byte * base, unsigned int mask, pr2val_t * stack, pr2val_t * retval )
{
	client_t *cl, *newcl = NULL;
	char   *name = VM_POINTER( base, mask, stack[0].string );
	int     bottomcolor = stack[1]._int;
	int     topcolor = stack[2]._int;
	char   *skin = VM_POINTER( base, mask, stack[3].string );
	int     edictnum;
	int     clients, spectators, i;
	extern char *shortinfotbl[];
	char   *s;
	edict_t *ent;
	eval_t *val;
	string_t savenetname;
	int old_self;



	// count up the clients and spectators
	clients = 0;
	spectators = 0;
	for ( i = 0, cl = svs.clients; i < MAX_CLIENTS; i++, cl++ )
	{
		if ( cl->state == cs_free )
			continue;
		if ( cl->spectator )
			spectators++;
		else
			clients++;
	}

	// if at server limits, refuse connection
	if ((int)maxclients.value > MAX_CLIENTS )
		Cvar_SetValue( &maxclients, MAX_CLIENTS );
	if ((int)maxspectators.value > MAX_CLIENTS )
		Cvar_SetValue( &maxspectators, MAX_CLIENTS );
	if ((int)maxspectators.value + maxclients.value > MAX_CLIENTS )
		Cvar_SetValue( &maxspectators, MAX_CLIENTS - (int)maxclients.value );

	if ( clients >= ( int ) maxclients.value )
	{
		retval->_int = 0;
		return;
	}
	for ( i = 0, cl = svs.clients; i < MAX_CLIENTS; i++, cl++ )
	{
		if ( cl->state == cs_free )
		{
			newcl = cl;
			break;
		}
	}
	if ( !newcl )
	{
		retval->_int = 0;
		return;
	}
	snprintf( newcl->userinfo, sizeof( newcl->userinfo ),
	          "\\name\\%s\\topcolor\\%d\\bottomcolor\\%d\\emodel\\6967\\pmodel\\13845\\skin\\%s\\*bot\\1",
	          name, topcolor, bottomcolor, skin );

	newcl->state = cs_spawned;
	newcl->userid = SV_GenerateUserID();
	newcl->datagram.allowoverflow = true;
	newcl->datagram.data = newcl->datagram_buf;
	newcl->datagram.maxsize = sizeof( newcl->datagram_buf );
	newcl->spectator = 0;
	newcl->isBot = 1;


	edictnum = ( newcl - svs.clients ) + 1;
	ent = EDICT_NUM( edictnum );
	savenetname = ent->v.netname;

	memset( &ent->v, 0, pr_edict_size - sizeof( edict_t ) + sizeof( entvars_t ) );
	ent->v.netname = savenetname;
	newcl->entgravity = 1.0;
	val = PR2_GetEdictFieldValue( ent, "gravity" );
	if ( val )
		val->_float = 1.0;
	sv_client->maxspeed = sv_maxspeed.value;
	val = PR2_GetEdictFieldValue( ent, "maxspeed" );
	if ( val )
		val->_float = sv_maxspeed.value;


	newcl->edict = ent;
	ent->v.colormap = edictnum;
	val = PR2_GetEdictFieldValue( ent, "isBot" );
	if( val )
		val->_int = 1;

	newcl->name = PR2_GetString( ent->v.netname );
	memset( newcl->stats, 0, sizeof( sv_client->stats ) );
	SZ_Clear( &newcl->netchan.message );
	newcl->netchan.drop_count = 0;
	newcl->netchan.incoming_sequence = 1;

	SV_ExtractFromUserinfo( newcl, true );

	for ( i = 0; shortinfotbl[i] != NULL; i++ )
	{
		s = Info_ValueForKey( newcl->userinfo, shortinfotbl[i] );
		Info_SetValueForStarKey( newcl->userinfoshort, shortinfotbl[i], s, MAX_INFO_STRING );
	}
	// move star keys to infoshort
	Info_CopyStarKeys( newcl->userinfo, newcl->userinfoshort );

	newcl->disable_updates_stop = -1.0;	// Vladis


	SV_FullClientUpdate( newcl, &sv.reliable_datagram );
	retval->_int = edictnum;


	old_self = pr_global_struct->self;
	pr_global_struct->time = sv.time;
	pr_global_struct->self = EDICT_TO_PROG(newcl->edict);

	PR2_GameClientConnect(0);
	PR2_GamePutClientInServer(0);

	pr_global_struct->self = old_self;

}

void RemoveBot(client_t *cl)
{

	if( !cl->isBot )
		return;

	pr_global_struct->self = EDICT_TO_PROG(cl->edict);
	if ( sv_vm )
		PR2_GameClientDisconnect(0);

	cl->old_frags = 0;
	cl->edict->v.frags = 0.0;
	cl->name[0] = 0;
	cl->state = cs_free;
	memset( cl->userinfo, 0, sizeof( cl->userinfo ) );
	memset( cl->userinfoshort, 0, sizeof( cl->userinfoshort ) );
	SV_FullClientUpdate( cl, &sv.reliable_datagram );
	cl->isBot = 0;


}

void PF2_Remove_Bot( byte * base, unsigned int mask, pr2val_t * stack, pr2val_t * retval )
{
	client_t *cl;
	int old_self;

	int     entnum = stack[0]._int;

	if ( entnum < 1 || entnum > MAX_CLIENTS )
	{
		Con_Printf( "tried to remove a non-botclient %d \n", entnum );
		return;
	}
	cl = &svs.clients[entnum - 1];
	if ( !cl->isBot )
	{
		Con_Printf( "tried to remove a non-botclient %d \n", entnum );
		return;
	}
	old_self = pr_global_struct->self; //save self

	pr_global_struct->self = entnum;
	RemoveBot(cl);
	pr_global_struct->self = old_self;

}

void PF2_SetBotUserInfo( byte * base, unsigned int mask, pr2val_t * stack, pr2val_t * retval )
{
	client_t *cl;
	int     entnum = stack[0]._int;
	char   *key = VM_POINTER( base, mask, stack[1].string );
	char   *value = VM_POINTER( base, mask, stack[2].string );
	int     i;
	extern char *shortinfotbl[];

	if ( entnum < 1 || entnum > MAX_CLIENTS )
	{
		Con_Printf( "tried to change userinfo a non-botclient %d \n", entnum );
		return;
	}
	cl = &svs.clients[entnum - 1];
	if ( !cl->isBot )
	{
		Con_Printf( "tried to change userinfo a non-botclient %d \n", entnum );
		return;
	}
	Info_SetValueForKey( cl->userinfo, key, value, MAX_INFO_STRING );
	SV_ExtractFromUserinfo( cl, !strcmp( key, "name" ) );

	for ( i = 0; shortinfotbl[i] != NULL; i++ )
		if ( key[0] == '_' || !strcmp( key, shortinfotbl[i] ) )
		{
			char   *new = Info_ValueForKey( cl->userinfo, key );

			Info_SetValueForKey( cl->userinfoshort, key, new, MAX_INFO_STRING );

			i = cl - svs.clients;
			MSG_WriteByte( &sv.reliable_datagram, svc_setinfo );
			MSG_WriteByte( &sv.reliable_datagram, i );
			MSG_WriteString( &sv.reliable_datagram, key );
			MSG_WriteString( &sv.reliable_datagram, new );
			break;
		}


}

void PF2_SetBotCMD( byte * base, unsigned int mask, pr2val_t * stack, pr2val_t * retval )
{
	client_t *cl;
	int     entnum = stack[0]._int;

	if ( entnum < 1 || entnum > MAX_CLIENTS )
	{
		Con_Printf( "tried to set cmd a non-botclient %d \n", entnum );
		return;
	}
	cl = &svs.clients[entnum - 1];
	if ( !cl->isBot )
	{
		Con_Printf( "tried to set cmd a non-botclient %d \n", entnum );
		return;
	}
	cl->botcmd.msec = stack[1]._int;
	cl->botcmd.angles[0] = stack[2]._float;
	cl->botcmd.angles[1] = stack[3]._float;
	cl->botcmd.angles[2] = stack[4]._float;
	cl->botcmd.forwardmove = stack[5]._int;
	cl->botcmd.sidemove = stack[6]._int;
	cl->botcmd.upmove = stack[7]._int;
	cl->botcmd.buttons = stack[8]._int;
	cl->botcmd.impulse = stack[9]._int;
	if ( cl->edict->v.fixangle)
	{
		VectorCopy(cl->edict->v.angles, cl->botcmd.angles);
		cl->botcmd.angles[PITCH] *= -3;
		cl->edict->v.fixangle = 0;
	}
}

//=========================================
// some time support in QVM
//=========================================

/*
==============
PF2_QVMstrftime
==============
*/
void PF2_QVMstrftime(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
//(char *valbuff, int sizebuff, char *fmt, int offset)
{
	char	*valbuff = VM_POINTER(base,mask,stack[0].string);
	int		sizebuff = stack[1]._int;
	char	*fmt = VM_POINTER(base,mask,stack[2].string);
	int		offset = stack[3]._int;

	struct tm *newtime;
	time_t long_time;

	if (sizebuff <= 0 || !valbuff) {
		Con_DPrintf("PF2_QVMstrftime: wrong buffer\n");
		return;
	}

	time(&long_time);
	long_time += offset;
	newtime = localtime(&long_time);

	if (!newtime)
	{
		valbuff[0] = 0; // or may be better set to "#bad date#" ?
		return;
	}

	retval->_int = strftime(valbuff, sizebuff-1, fmt, newtime);

	if (!retval->_int) {
		valbuff[0] = 0; // or may be better set to "#bad date#" ?
		Con_DPrintf("PF2_QVMstrftime: buffer size too small\n");
		return;
	}
}

void PF2_makevectors(byte* base, unsigned int mask, pr2val_t* stack, pr2val_t*retval)
{
	AngleVectors (VM_POINTER(base,mask,stack[0].string), pr_global_struct->v_forward, pr_global_struct->v_right, pr_global_struct->v_up);
}

//===========================================================================
// SysCalls
//===========================================================================


#define GETVEC3_T(x, y)		{ y[0] = va_arg(x, double); \
							y[1] = va_arg(x, double); \
							y[2] = va_arg(x, double); }
pr2_trapcall_t pr2_API[]=
    {
        PF2_GetApiVersion, 	//G_GETAPIVERSION
        PF2_DPrint,        	//G_DPRINT
        PF2_Error,         	//G_ERROR
        PF2_GetEntityToken,	//G_GetEntityToken,
        PF2_Spawn,		//G_SPAWN_ENT,
        PF2_Remove,		//G_REMOVE_ENT,
        PF2_precache_sound,	//G_PRECACHE_SOUND,
        PF2_precache_model,	//G_PRECACHE_MODEL,
        PF2_lightstyle,		//G_LIGHTSTYLE,
        PF2_setorigin,		//G_SETORIGIN,
        PF2_setsize,		//G_SETSIZE,
        PF2_setmodel,		//G_SETMODEL,
        PF2_bprint,		//G_BPRINT,
        PF2_sprint,		//G_SPRINT,
        PF2_centerprint,	//G_CENTERPRINT,
        PF2_ambientsound,	//G_AMBIENTSOUND,
        PF2_sound,		//G_SOUND,
        PF2_traceline,		//G_TRACELINE,
        PF2_checkclient,	//G_CHECKCLIENT,
        PF2_stuffcmd,		//G_STUFFCMD,
        PF2_localcmd,		//G_LOCALCMD,
        PF2_cvar,		//G_CVAR,
        PF2_cvar_set,		//G_CVAR_SET,
        PF2_FindRadius,		//G_FINDRADIUS
        PF2_walkmove,
        PF2_droptofloor,	//G_DROPTOFLOOR,
        PF2_checkbottom,	//G_CHECKBOTTOM,
        PF2_pointcontents,	//G_POINTCONTENTS,
        PF2_nextent,		//G_NEXTENT,
        PF2_fixme,		//G_AIM,
        PF2_makestatic,		//G_MAKESTATIC,
        PF2_setspawnparms,	//G_SETSPAWNPARAMS,
        PF2_changelevel,	//G_CHANGELEVEL,
        PF2_logfrag,		//G_LOGFRAG,
        PF2_infokey,		//G_GETINFOKEY,
        PF2_multicast,		//G_MULTICAST,
        PF2_disable_updates,	//G_DISABLEUPDATES,
        PF2_WriteByte,		//G_WRITEBYTE,
        PF2_WriteChar,		//G_WRITECHAR,
        PF2_WriteShort,		//G_WRITESHORT,
        PF2_WriteLong,		//G_WRITELONG,
        PF2_WriteAngle,		//G_WRITEANGLE,
        PF2_WriteCoord,		//G_WRITECOORD,
        PF2_WriteString,	//G_WRITESTRING,
        PF2_WriteEntity,	//G_WRITEENTITY,
        PR2_FlushSignon,	//G_FLUSHSIGNON,
        PF2_memset,		//g_memset,
        PF2_memcpy,		//g_memcpy,
        PF2_strncpy,	//g_strncpy,
        PF2_sin,		//g_sin,
        PF2_cos,		//g_cos,
        PF2_atan2,		//g_atan2,
        PF2_sqrt,		//g_sqrt,
        PF2_floor,		//g_floor,
        PF2_ceil,		//g_ceil,
        PF2_acos,		//g_acos,
        PF2_cmdargc,		//G_CMD_ARGC,
        PF2_cmdargv,		//G_CMD_ARGV
        PF2_TraceCapsule,
        PF2_FS_OpenFile,
        PF2_FS_CloseFile,
        PF2_FS_ReadFile,
        PF2_FS_WriteFile,
        PF2_FS_SeekFile,
        PF2_FS_TellFile,
        PF2_FS_GetFileList,
        PF2_cvar_set_float,
        PF2_cvar_string,
        PF2_Map_Extension,
        PF2_strcmp,
        PF2_strncmp,
        PF2_stricmp,
        PF2_strnicmp,
        PF2_Find,
        PF2_executecmd,
        PF2_conprint,
        PF2_readcmd,
        PF2_redirectcmd,
        PF2_Add_Bot,
        PF2_Remove_Bot,
        PF2_SetBotUserInfo,
        PF2_SetBotCMD,
		PF2_QVMstrftime,	//G_QVMstrftime
		PF2_cmdargs,		//G_CMD_ARGS
		PF2_tokenize,		//G_CMD_TOKENIZE
		PF2_strlcpy,		//g_strlcpy
		PF2_strlcat,		//g_strlcat
		PF2_makevectors,	//G_MAKEVECTORS
		PF2_nextclient		//G_NEXTCLIENT
    };
int pr2_numAPI = sizeof(pr2_API)/sizeof(pr2_API[0]);

int sv_syscall(int arg, ...) //must passed ints
{
	va_list	ap;
	pr2val_t ret;

	if( arg >= pr2_numAPI )
		PR2_RunError ("sv_syscall: Bad API call number");

	va_start(ap,arg);

	pr2_API[arg] ( 0,~0, (pr2val_t*)ap, &ret);

	return ret._int;
}

int sv_sys_callex(byte *data, unsigned int mask, int fn, pr2val_t*arg)
{
	pr2val_t ret;

	if( fn >= pr2_numAPI )
		PR2_RunError ("sv_sys_callex: Bad API call number");

	pr2_API[fn](data, mask, arg,&ret);
	return ret._int;
}

extern gameData_t *gamedata;
extern field_t *fields;

#define GAME_API_VERSION_MIN 8

void PR2_InitProg()
{
	PR2_FS_Restart();

	gamedata = (gameData_t *) VM_Call(sv_vm, GAME_INIT, (int) (sv.time * 1000),
	                                  (int) (Sys_DoubleTime() * 100000), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

	if ( !gamedata )
		SV_Error("PR2_InitProg gamedata == NULL");

	gamedata = (gameData_t *)PR2_GetString((int)gamedata);
	if (gamedata->APIversion < GAME_API_VERSION_MIN || gamedata->APIversion > GAME_API_VERSION)
	{
		if (GAME_API_VERSION_MIN == GAME_API_VERSION)
			SV_Error("PR2_InitProg: Incorrect API version (%i should be %i)",
				gamedata->APIversion, GAME_API_VERSION);
		else
			SV_Error("PR2_InitProg: Incorrect API version (%i should be between %i and %i)",
				gamedata->APIversion, GAME_API_VERSION_MIN, GAME_API_VERSION);
	}

	sv.edicts = (edict_t *)PR2_GetString((int)gamedata->ents);
	pr_global_struct = (globalvars_t*)PR2_GetString((int)gamedata->global);
	pr_globals = (float *) pr_global_struct;
	fields = (field_t*)PR2_GetString((int)gamedata->fields);
	pr_edict_size = gamedata->sizeofent;
}
#endif /* USE_PR2 */
