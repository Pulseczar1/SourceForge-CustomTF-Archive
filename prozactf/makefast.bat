@echo off
echo ------------------------------------------------
echo This will preprocess and compile Prozac CustomTF
echo ------------------------------------------------
cppreqcc -fast
if errorlevel 1 exit
cpqccx /O2 /fast
if errorlevel 1 exit
echo ------------------------------------------------
echo Prozac CustomTF has been compiled successfully!!
echo ------------------------------------------------
