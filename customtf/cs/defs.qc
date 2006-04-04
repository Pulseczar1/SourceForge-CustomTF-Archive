float chasecam;
entity player_local;

.entity headent;
.entity torsoent;
.entity legsent;
.entity weaponent;
.float modelnum;
.float animnum;
.float framechangetime;
.float lerptime;

.float sveffects;	//lower 4 is weapon, next is nopred, upper 3 is powerups
#define SVE_INVIS 128
#define SVE_GOD 64
#define SVE_QUAD 32
#define SVE_NOPRED 16
#define SVE_WEAPONSMASK 15



//DP_QC_FS_SEARCH
//idea: Black
//darkplaces implementation: Black
//builtin definitions:
float(string pattern, float caseinsensitive, float quiet) search_begin = #444;
void(float handle) search_end = #445;
float(float handle) search_getsize = #446;
string(float handle, float num) search_getfilename = #447;
//description:
//search_begin performs a filename search with the specified pattern (for example "maps/*.bsp") and stores the results in a search slot (minimum of 128 supported by any engine with this extension), the other functions take this returned search slot number, be sure to search_free when done (they are also freed on progs reload).
//search_end frees a search slot (also done at progs reload).
//search_getsize returns how many filenames were found.
//search_getfilename returns a filename from the search.

//DP_QC_CVAR_STRING
//idea: Paul Timofeyev
//DarkPlaces implementation: Paul Timofeyev, LordHavoc
//builtin definitions:
string(string s) cvar_string = #448;
//description:
//returns the value of a cvar, as a tempstring.