@echo off
cppreqcc
echo.
echo.
rem if errorlevel 0 billccx
if errorlevel 1 exit
qccx7
move *.bak rcs > devnull
del devnull
