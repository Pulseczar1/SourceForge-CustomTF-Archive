#ifndef _CLASSES_QC_
	#define _CLASSES_QC_


#define eclasses	eclass(CLASS_ROCKET, ParseRocketClass)  eclass(CLASS_PLAYER, ParsePlayer)  eclass(CLASS_DEADBODY, ParseBody)  eclass(CLASS_GIB, ParseGibbing)	eclass(CLASS_EXPLOSION, ParseExplosion) eclass(CLASS_NAIL, ParseNailClass)


#define eclass(eid,func) void(float isnew) func;
		eclasses
#undef eclass


	enum {
#define eclass(eid,func) eid,
		eclasses CLASS_MAX
#undef eclass
		};

	enum {
		GIB_PLAYER,
		GIB_SOLDIER,
		GIB_ZOMBIE,
		GIB_DEMON,
		GIB_OGRE,
		GIB_DOG,
		GIB_WIZARD,
		GIB_SHAMBLER,
		GIB_KNIGHT,
		GIB_HELLKNIGHT,
		GIB_FISH,
		GIB_ENFORCER,
		GIB_SHALRATH,
		GIB_MAX
	};
#else
	#ifdef CSQC
		var void(float isnew) ParseEntityClass[ ] = {
#define eclass(eid,func) func ,
		eclasses
#undef eclass
__NULL__
		};
	#endif
#endif
