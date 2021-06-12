@echo off

rem detect os version and store it in a variable called "version"
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
rem check if OS version is windows 10 if not goto "outdatedOS" if it is windows 10 continue as normal
if "%version%" == "10.0" (cls) else (goto outdatedOS)


echo [101;93mPLEASE READ ALL OF THE FOLLOWING[0m
echo.
echo [93mBefore you uninstall the mod[0m join the [36mdiscord.gg/kW3nG6GKpF[0m.
echo If you had an issue with our mod please tell us we're trying to make our mod the best
echo it can be and we would be happy to help. If you didn't have an issue please continue
echo.
set /P c=ARE YOU SURE YOU WANT TO [31mUNINSTALL[0m THE MOD? [31my[0m/[92mn[0m:
if /I "%c%" EQU "N" exit
cls
echo [93mAttempting To Close Portal 2...[0m
taskkill /F /IM portal2.exe
echo [93mReplacing MPMod Files With Originals...[0m
xcopy /y /S "%cd%\MultiplayerModFiles\MPML" "%cd%\portal2"
echo [93mDeleteing Leftover MPMod Files...[0m
if exist "%cd%\portal2\scripts\vscripts\mapspawn.nut" del /q /f "%cd%\portal2\scripts\vscripts\mapspawn.nut">nul
echo %cd%\portal2\scripts\vscripts\mapspawn.nut
if exist "%cd%\portal2\cfg\collisionfix.cfg" del /q /f "%cd%\portal2\cfg\collisionfix.cfg">nul
echo %cd%\portal2\cfg\collisionfix.cfg
if exist "%cd%\portal2\cfg\multiplayermod.cfg" del /q /f "%cd%\portal2\cfg\multiplayermod.cfg">nul
echo %cd%\portal2\cfg\multiplayermod.cfg
echo 3 File(s) deleted
echo [92mUninstalled Successfully![0m
timeout 1 >nul
cls
echo  [101;93mUnMounted The Mod[0m
echo (The game will run normally)
echo.
echo [93mTo fully uninstall the mod delete the following files:[0m
echo /MultiplayerModFiles
echo /MultiplayerMod.cmd
echo /MultiplayerModUpdater.cmd
echo /MultiplayerModUninstall.cmd
echo.
echo (Press Any Key To Exit)
pause>nul
exit


:outdatedOS
echo PLEASE READ ALL OF THE FOLLOWING
echo.
echo Before you uninstall the mod join the discord.gg/kW3nG6GKpF
echo If you had an issue with our mod please tell us we're trying to make our mod the best
echo it can be and we would be happy to help. If you didn't have an issue please continue
echo.
set /P c=ARE YOU SURE YOU WANT TO UNINSTALL THE MOD? y/n:
if /I "%c%" EQU "N" exit
cls
echo Attempting To Close Portal 2...
taskkill /F /IM portal2.exe
echo Replacing MPMod Files With Originals...
xcopy /y /S "%cd%\MultiplayerModFiles\MPML" "%cd%\portal2"
echo Deleteing Leftover MPMod Files...
if exist "%cd%\portal2\scripts\vscripts\mapspawn.nut" del /q /f "%cd%\portal2\scripts\vscripts\mapspawn.nut">nul
echo %cd%\portal2\scripts\vscripts\mapspawn.nut
if exist "%cd%\portal2\cfg\collisionfix.cfg" del /q /f "%cd%\portal2\cfg\collisionfix.cfg">nul
echo %cd%\portal2\cfg\collisionfix.cfg
if exist "%cd%\portal2\cfg\multiplayermod.cfg" del /q /f "%cd%\portal2\cfg\multiplayermod.cfg">nul
echo %cd%\portal2\cfg\multiplayermod.cfg
echo 3 File(s) deleted
echo Uninstalled Successfully!
timeout 1 >nul
cls
echo  UnMounted The Mod
echo.
echo To fully uninstall the mod delete the following files:
echo /MultiplayerModFiles
echo /MultiplayerMod.cmd
echo /MultiplayerModUpdater.cmd
echo /MultiplayerModUninstall.cmd
echo.
echo (Press Any Key To Exit)
pause>nul
exit