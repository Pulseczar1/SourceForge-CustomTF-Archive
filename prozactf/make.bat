@echo off
echo ------------------------------------------------
echo This will compile Prozac CustomTF
echo ------------------------------------------------
fteqcc -O2 -Fhashonly
if errorlevel 1 exit /b
echo ------------------------------------------------
echo Prozac CustomTF has been compiled successfully!!
echo ------------------------------------------------
