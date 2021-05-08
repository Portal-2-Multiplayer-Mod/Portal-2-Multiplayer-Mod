rem imagine not commenting this
@echo off
set /P c=ARE YOU SURE YOU WANT TO [31mUNINSTALL[0m THE MOD? [31my[0m/[92mn[0m:
cls
taskkill /F /IM portal2.exe
xcopy /y /S "%cd%\MultiplayerModFiles\MPML" "%cd%\portal2"
if exist "%cd%\portal2\scripts\vscripts\mapspawn.nut" del /q /f "%cd%\portal2\scripts\vscripts\mapspawn.nut">nul
ping 127.0.0.1 -n 1 -w 800> nul
echo %cd%\portal2\scripts\vscripts\mapspawn.nut
if exist "%cd%\portal2\cfg\collisionfix.cfg" del /q /f "%cd%\portal2\cfg\collisionfix.cfg">nul
ping 127.0.0.1 -n 1 -w 800> nul
echo %cd%\portal2\cfg\collisionfix.cfg
if exist "%cd%\portal2\cfg\multiplayermod.cfg" del /q /f "%cd%\portal2\cfg\multiplayermod.cfg">nul
ping 127.0.0.1 -n 1 -w 800> nul
echo %cd%\portal2\cfg\multiplayermod.cfg
ping 127.0.0.1 -n 1 -w 800> nul
echo 3 File(s) deleted
ping 127.0.0.1 -n 1 -w 350> nul
cls
echo [32mPLEASE READ ALL OF THE FOLLOWING TEXT[0m (Press Enter)
pause>nul
cls
echo [31mUninstalled mod[0m [96mif your uninstalling because of a bug please report it in the issues section on the github and freind   kyleraykbs#3230 on discord[0m
echo [93m(To reinstall open MultiplayerMod.cmd)[0m
pause>nul