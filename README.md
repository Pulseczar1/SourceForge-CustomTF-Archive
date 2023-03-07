# SourceForge CustomTF Archive
This is a copy (import) of the old CustomTF archive, at SourceForge, located here: https://sourceforge.net/p/customtf/code/HEAD/tree/. Note that it also has code from other mods, like MegaTF, but, originally, it was for CustomTF. The last time anyone updated anything there was in 2010, as of March 7, 2023. Hopefully, no one will update anything there, and just let it be an archive. I've lost access to it, myself. I suppose if someone still has access, they can give me back access. I also intend to keep all of this code, here, unmodified, for archival purposes only.

The following is an explanation of what I know about each of the repositories/projects/submodules -- whatever is the correct term. I will update this as more is learned. Where I say "progs", below, I'm talking about the mod code that was originally done in QuakeC. (A few mods have been ported to other languages like C and C++, and those generally run natively on the processor, rather than on the server's QuakeC virtual machine.)

### CuTF_4TP
I created this project. It is the progs code for CustomTF For The People -- the first version of that project. It was branched from The Gizmo's Coop, but doesn't have a few of TheGizmo's later commits. Its purpose was to create a mod and server for CustomTF that was updated with various improvements and bug fixes, and one in which development and play would be driven by the players, rather than by a single person, to contrast with the available CustomTF servers of the time (2007 to 2010, somewhere in there). This project was also the starting point for the work on the CustomTF For The People server, that is online today, and which began in 2014. None of that server's code is open source at this time, but I do hope to get it to a point where I am pleased with it enough to release the source.

### MVDSV XE
This appears to be an old version of MVDSV (a modern Quake server engine) tailored to working with some form of MegaTF.

### Q4F
Quake 4 Fortress? I don't know.

### branches
Branches of CustomTF by Randomer and WhiteWolf

### cpqw
The Clan Prozac version of the QuakeWorld server engine and client. It was not based on MVDSV or FTE, but on the original QuakeWorld server and client, with some changes by someone named KKMay or something. Hence, it used the old file upload system that was limited to about 10 KBytes/sec, for sending files to clients. This server was used as the CustomTF server many years ago, from the first version of CustomTF all the way to CuTF 4TP that is running today. Some CustomTF servers have since used more-modern server programs as their basis for their QW server.

### cprozactf
Prozac CustomTF "Classic". The last commit here was in 2007, and this is what was played in the early to mid 2000s on the CustomTF server.

### customtf
This is the CustomTF Improvement Project's progs code. I was the person who originally started this project, in concept, and I believe I gave it that name, and started laying out what changes need to be made on the CustomTF forums, but I believe it was PhrostByte who created the SourceForge repository. RJLan82 later became the main person working on it. I think I am the one that actually started changes.txt, even though at the top of it, it says to blame RJLan for it.

### development
Branches of various code for development by various people

### megatf united
MegaTF United code, but empty for some reason. I guess that's why GitHub didn't import that directory.

### megatf2006
Appears to be a version of MegaTF that was forked from TF 2003, which was a port to C from QuakeC, by [sd] angel.

### openfortress-alpha
Something called "Open Fortress"? I don't know.

### oztf
Something called "Oz TF"

### phoenixtf
Maybe TF 2003 was also called "PhoenixTF"? I don't know. But this was at least based on TF2003, by [sd] angel.

### prozaccoop
TheGizmo's Coop (for playing singleplayer maps against monsters, in multiplayer), added to Prozac CustomTF "Classic". This is the basis for CuTF 4TP. Contains the gravity gun. Medikit can revive dead players who have not respawned. I don't think it works on gibbed players. ;)

### prozactf
Shaka's (the original author of CustomTF) 2009 version of Prozac CustomTF. He used Prozac CustomTF "Classic" as his baseline. He developed this version from 2007 to 2009. Originally, Shaka greatly limited bunny hopping, but Phrostbyte quickly removed the limit, in the SourceForge repository, and on his server, where he was running this mod. See here: https://github.com/Pulseczar1/SourceForge-CustomTF-Archive/commit/1b553e708a017cc66632631bddf70f98a73ee3b2 and here: https://github.com/Pulseczar1/SourceForge-CustomTF-Archive/commit/810fb171dd5c7f49243024ad2f6db21028829f54

### quakelife
From its readme: "Quake-Life is a QuakeC conversion of the core Half-Life 1 entities into a playable Quake mod. All half-life monsters and weapons are replaced with Quake 1 entities, and various button and trinkets are tweaked to be more "Quake-like". The goal of this mod if to allow modders to have maps that are multi-compatable for half-life 1 and quake, and also adds the ability for Quake 1 users to play through half-life levels."
