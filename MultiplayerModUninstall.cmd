@echo off
set /P c=ARE YOU SURE YOU WANT TO [31mUNINSTALL[0m THE MOD? [31my[0m/[92mn[0m:
cls
taskkill /F /IM portal2.exe
move /y %cd%\portal2\bin\server.dll.bak %cd%\portal2\bin\server.dll
move /y %cd%\portal2\bin\coop_bluebot_load.bik.bak %cd%\portal2\media\coop_bluebot_load.bik
move /y %cd%\portal2\bin\coop_orangebot_load.bik.bak %cd%\portal2\media\coop_orangebot_load.bik
move /y %cd%\portal2\scripts\vscripts\mapspawn.nut.bak %cd%\portal2\scripts\vscripts\mapspawn.nut

if exist "%cd%\portal2\scripts\vscripts\mapspawn.nut" del /q /f "%cd%\portal2\scripts\vscripts\mapspawn.nut">nul
echo %cd%\portal2\scripts\vscripts\mapspawn.nut
if exist "%cd%\portal2\cfg\collisionfix.cfg" del /q /f "%cd%\portal2\cfg\collisionfix.cfg">nul
echo %cd%\portal2\cfg\collisionfix.cfg
if exist "%cd%\portal2\cfg\multiplayermod.cfg" del /q /f "%cd%\portal2\cfg\multiplayermod.cfg">nul
cls
echo [32mPLEASE READ ALL OF THE FOLLOWING TEXT[0m (Press Enter)
pause>nul
cls
echo [31mUninstalled mod[0m [96mif your uninstalling because of a bug please report it in the issues section on the github and freind   kyleraykbs#3230 on discord[0m
echo [93m(To reinstall open MultiplayerMod.cmd)[0m
goto end
rem if the user type "n" echo that windowed mode is disabled
if /I "%c%" EQU "N" echo [92mExiting![0m:
timeout 1
goto kill
:end
pause>nul
:kill
exit