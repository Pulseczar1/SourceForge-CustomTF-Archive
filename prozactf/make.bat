@echo off
echo ------------------------------------------------
echo This will preprocess and compile Prozac CustomTF
echo ------------------------------------------------
cppreqcc
if errorlevel 1 goto end
echo ------------------------------------------------
cpqccx /O2 /w
if errorlevel 1 goto end
echo ------------------------------------------------
echo Prozac CustomTF has been compiled successfully!!
echo ------------------------------------------------
clean.bat
:end
pause