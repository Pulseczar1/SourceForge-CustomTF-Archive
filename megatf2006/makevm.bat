@echo off



set CC=lcc

set Q3ASM=q3asm

set CFLAGS=-DQ3_VM -S -Wf-target=bytecode -Wf-g 
rem set CFLAGS=-DQ3_VM -S -Wf-target=bytecode -Wf-g -w

set INCFLAGS=-I..\include

set SRC=..\src



rem make sure we have a safe environement

set LIBRARY=

set INCLUDE=



mkdir VM
mkdir VM\bot
mkdir VM\megatf
copy lcc.exe VM
copy q3asm.exe VM
copy q3rcc.exe VM
copy q3cpp.exe VM
cd VM



%CC% %CFLAGS% %INCFLAGS% %SRC%\actions.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\admin.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\admin_cmd.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\bg_lib.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\buttons.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\clan.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\client.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\combat.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\coop.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\ctf.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\debug.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\demoman.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\doors.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\engineer.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\flare.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\g_cmd.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\g_main.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\g_mem.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\g_spawn.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\g_tf_utils.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\g_utils.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\hook.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\items.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\mathlib.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\menu.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\misc.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\plats.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\player.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\pyro.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\q_shared.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\scout.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\sentry.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\server.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\sniper.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\spectate.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\spy.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\status.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\subs.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\tfort.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\tforthlp.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\tfortmap.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\tforttm.c

@if errorlevel 1 goto quit


%CC% %CFLAGS% %INCFLAGS% %SRC%\triggers.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\tsoldier.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\weapons.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\world.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\tg.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\version.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\vote.c

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\bot\ai.c -o bot\ai.asm

@if errorlevel 1 goto quit


%CC% %CFLAGS% %INCFLAGS% %SRC%\bot\ai-misc.c -o bot\ai-misc.asm

@if errorlevel 1 goto quit


%CC% %CFLAGS% %INCFLAGS% %SRC%\bot\fighting.c -o bot\fighting.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\bot\move.c -o bot\move.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\bot\qw.c -o bot\qw.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\bot\ui.c -o bot\ui.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\bot\waypoint.c -o bot\waypoint.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\g_mod_command.c -o g_mod_command.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\qmalloc.c -o qmalloc.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\qmd5.c -o qmd5.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\crc32.c -o crc32.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\common.c -o megatf\common.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\drop1.c -o megatf\drop1.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\drop2.c -o megatf\drop2.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\drop3.c -o megatf\drop3.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\mtf_scout.c -o megatf\mtf_scout.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\mtf_sniper.c -o megatf\mtf_sniper.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\mtf_soldier.c -o megatf\mtf_soldier.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\mtf_demoman.c -o megatf\mtf_demoman.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\mtf_medic.c -o megatf\mtf_medic.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\mtf_hwguy.c -o megatf\mtf_hwguy.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\mtf_pyro.c -o megatf\mtf_pyro.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\mtf_spy.c -o megatf\mtf_spy.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\mtf_engineer.c -o megatf\mtf_engineer.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\map_ents.c -o megatf\map_ents.asm

@if errorlevel 1 goto quit

%CC% %CFLAGS% %INCFLAGS% %SRC%\megatf\obituary.c -o megatf\obituary.asm

@if errorlevel 1 goto quit

copy %SRC%\g_syscalls.asm .

@if errorlevel 1 goto quit



%Q3ASM% -f %SRC%\game



:quit



cd ..

