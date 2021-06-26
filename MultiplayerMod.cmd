:start
@echo off

set /p mpmodver=<mpmodver.data

del /s update.bat

set lemongod=0

title Portal 2 32 Player Mod Lite %mpmodver% - BumpyAHK Kyleraykbs KonradCzerw/Vista

rem detect os version and store it in a variable called "version"
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j

rem stop portal 2
taskkill /F /IM portal2.exe

rem clear screen
cls

rem tell the user copying core files.
echo copying [96mcore files[0m to "[93m\portal2[0m"

rem copy everything from "MultiplayerModFiles" to "portal2"
xcopy /y /S "%cd%\MultiplayerModFiles" "%cd%\portal2"

rem tell the user Done.
echo [42mDone![0m

rem clear screen
cls

rem set variable to default
set ip_address_string="IPv4 Address"
set windowed=

rem check hamatchi adapter
set hamatchi_adaptor="Ethernet adapter Hamachi:"

rem check if OS version is windows 10 if not goto "outdatedOS" if it is windows 10 continue as normal
if "%version%" == "10.0" (cls) else (goto outdatedOS)

if exist mpmod.cfg (
    goto win10norm
)

rem user configuation code
if exist "mpmod.cfg" del /q /f "mpmod.cfg">nul
rem tell the user first time setup
echo                [101;93mFirst Time Setup[0m
echo [93m==============================================[0m
echo Please read all of the following so you 
echo can configure the mod to your liking!
rem wait 5 seconds and then let the user continue
timeout /T 5 /NOBREAK > nul
echo [92mPress Any Key[0m
pause >nul
:win10cfge
if exist "mpmod.cfg" del /q /f "mpmod.cfg">nul
cls
set lemongod=1
echo [96m(Type Y if you speedrun, play challange mode, want to get achivments or play singleplayer as keeping the files installed will break some singleplayer features like save loading)[0m
echo [96m(If you play singleplayer I recommend you type Y)[0m
set /P c=Only [93menable[0m the mod when launched through this file? [92my[0m/[31mn[0m:
if /I "%c%" EQU "Y" set option1=0
if /I "%c%" EQU "N" set option1=1
echo %option1% > mpmod.cfg
cls

:win10norm
rem tell the user how to use
echo  Portal 2 [36mMultiplayer[0m [33mMod[0m [[32mFixed!... Again[0m]
echo                   [91mHow To Use[0m
echo [93m==============================================[0m
echo make sure you and your friends have the same
echo version of the mod installed 
echo [91mHow To Host[0m :
echo [92mCase 1.[0m : your playing with friends online
echo then send them the public ip
echo (also make sure you have 27015 or 27016 port forwarded)
echo [92mCase 2.[0m : your playing with friends on your
echo local network/in your home then send them the local ip
echo [91mHow To Join (tell your friends this)[0m :
echo [92mStep 1.[0m : Open the console in game
echo (if you dont know how to open the console google it)
echo [92mStep 2.[0m : Type "connect theipthehostgaveyou"
echo replace "theipthehostgaveyou" with the ip the host gave you
echo [92mStep 3.[0m : Press [[33mENTER[0m] and have fun!
echo [93m==============================================[0m

rem check for hamatchi adapter
for /f "usebackq tokens=1,2,3" %%h in (`ipconfig ^| findstr /c:%hamatchi_adaptor%`) do goto hamatchi

rem if no hamatchi adapter this runs
for /f "usebackq tokens=1,2,3" %%h in (`ipconfig ^| findstr /c:%ip_address_string%`) do goto default

:hamatchi
echo The [1mHamatchi[0m server [35mip[0m is:
for /f "usebackq tokens=2 delims=:" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) do echo Hamatchi[44mIP[0m:[35m%%f[0m & goto default_w_h

:default_w_h
echo The [1mlocal/lan[0m server [35mip[0m is:
for /f "usebackq tokens=2 delims=: skip=1" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) do echo LAN[44mIP[0m:[35m%%f[0m & goto next

rem find the local ip and print it
:default
echo The [1mlocal/lan[0m server [35mip[0m is:
for /f "usebackq tokens=2 delims=:" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) do echo LAN[44mIP[0m:[35m%%f[0m & goto next

rem goto next as to not print the ip forever
:next

rem tell the user the public server ip
echo The [4mpublic[0m server [35mip[0m is:

rem get the public ip of the user and print it
for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do echo [33mPUB[0m[44mIP[0m: [35m%%a[0m
echo.

rem ask the user if they want to update
set /P c=Would you like to check for [94mupdates[0m? [94my[0m/[92mn[0m:
rem if the user types "y" open the updater
if /I "%c%" EQU "Y" call "%cd%\MultiplayerModUpdater.cmd" & set rsscfu=1
rem if the user type "n", skip
if /I "%c%" EQU "N" echo.

rem if the user edited the config skip the option to edit the config again
if %lemongod%==1 (
    goto skipcfgw10
)
rem ask the user if they want to change config
set /P c=Would you like to [93medit[0m the [94mconfig[0m? [94my[0m/[92mn[0m:
rem if the user types "y" jump to edit config
if /I "%c%" EQU "Y" goto win10cfge
rem if the user type "n", skip
if /I "%c%" EQU "N" echo.


:skipcfgw10
rem ask the user if they want windowed mode
set /P c=Start in [93mwindowed[0m mode? [92my[0m/[31mn[0m:
rem if the user types "y" set the varible %windowed% to be the parameters for windowed mode
if /I "%c%" EQU "Y" set windowed=-window -w 1280 -h 720 & echo Windowed mode [92mEnabled[0m
rem if the user type "n" echo that windowed mode is disabled
if /I "%c%" EQU "N" echo Windowed mode [31mDisabled[0m

rem tell the user they can start the game.
echo.
echo Press [[33mENTER[0m] To Start [36mPortal[0m [33m2 MP[0m!

rem Wait Until a key Is Pressed
pause >nul

rem tell the user portal 2 is starting.
echo [42mStarting Portal 2 Multiplayer Mod![0m

rem start portal 2 with the parameters to allow for 33 players 
portal2.exe %windowed% -novid -allowspectators +exec multiplayermod.cfg +sv_lan 0 +mp_wait_for_other_player_notconnecting_timeout 240 +mp_wait_for_other_player_timeout 3 +map mp_coop_lobby_3 -nosixense

goto endw10






rem run in compatibility mode
:outdatedOS
if exist mpmod.cfg (
    goto win7norm
)

if exist "mpmod.cfg" del /q /f "mpmod.cfg">nul
echo                First Time Setup
echo ==============================================
echo Please read all of the following so you 
echo can configure the mod to your liking!
timeout /T 5 /NOBREAK > nul
echo Press Any Key
pause >nul
:win7cfge
cls
set lemongod=1
echo (Type Y if you speedrun, play challange mode, want to get achivments or play singleplayer as keeping the files installed will break some singleplayer features like loading)
echo (If you play singleplayer I recommend you type Y)
set /P c=Only enable the mod when launched through this file? y/n:
if /I "%c%" EQU "Y" set option1=0
if /I "%c%" EQU "N" set option1=1
echo %option1% > mpmod.cfg
cls

:win7norm

rem nag user about outdated os
echo  Running On Outdated Version Of Windows [Compatibility Mode Enabled]
echo.
rem tell the user how to use (outdated os)
echo  Portal 2 Multiplayer Mod [Fixed!... Again]
echo.
echo                   How To Use
echo ==============================================
echo make sure you and your friends have the same
echo version of the mod installed 
echo How To Host :
echo Case 1. : your playing with friends online
echo send them the public ip
echo (also make sure you have 27015 or 27016 port forwarded)
echo Case 2. : your playing with freinds on your
echo local network/in your home 
echo send them the local ip
echo How To Join (tell your friends this) :
echo Step 1. : Open the console in game
echo (if you dont know how to open the console google it)
echo Step 2. : Type "connect theipthehostgaveyou"
echo replace "theipthehostgaveyou" with the ip the host gave you
echo Step 3. : Press [ENTER] and have fun!
echo ==============================================
rem check for hamachi adapter
for /f "usebackq tokens=1,2,3" %%h in (`ipconfig ^| findstr /c:%hamachi_adaptor%`) do goto hamachi

rem if no hamachi adapter this runs
for /f "usebackq tokens=1,2,3" %%h in (`ipconfig ^| findstr /c:%ip_address_string%`) do goto default

:hamachi
echo The Hamachi server is:
for /f "usebackq tokens=2 delims=:" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) do echo Hamachi IP:%%f & goto default_w_h

:default_w_h
echo The local/lan server is:
for /f "usebackq tokens=2 delims=: skip=1" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) do echo LAN IP:%%f & goto next

:default
echo The local/lan server is:
rem find the local ip and print it
for /f "usebackq tokens=2 delims=:" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) do echo LANIP:%%f & goto next

rem goto next as to not print the ip forever
:next

rem tell the user the public ip (outdated os)
echo The public server ip is:

rem nag the user about using an outdated OS and show them how to get their public ip
echo It looks like your running an outdated version of windows 
echo For this reason we cannot find your public ip in console
echo To find your public ip please visit http://api.ipify.org/
echo.

rem ask the user if they want to update
set /P c=Would you like to check for updates? y/n:
rem if the user types "y" to open the updater
if /I "%c%" EQU "Y" call "%cd%\MultiplayerModUpdater.cmd" & set rsscfu=1
rem if the user type "n", skip
if /I "%c%" EQU "N" echo.

rem if the user edited the config skip the option to edit the config again
if %lemongod%==1 (
    goto skipcfgw7
)
rem ask the user if they want to change config
set /P c=Would you like to edit the config? y/n:
rem if the user types "y" jump to edit the config
if /I "%c%" EQU "Y" goto win7cfge
rem if the user type "n", skip.
if /I "%c%" EQU "N" echo.

:skipcfgw7
rem ask the user if they want windowed mode
set /P c=Start in windowed mode? y/n:
rem if the user types "y" set the varible %windowed% to be the parameters for windowed mode
if /I "%c%" EQU "Y" set windowed=-window -w 1280 -h 720 & echo Windowed mode Enabled
rem if the user type "n" echo that windowed mode is disabled
if /I "%c%" EQU "N" echo Windowed mode Disabled

rem tell the user to press enter to start portal 2.
echo.
echo Press [ENTER] To Start Portal 2 MP!

rem Wait Until a key Is Pressed
pause >nul

rem tell the user portal 2 is starting
echo Starting Portal 2 Multiplayer Mod!

rem start portal 2 with the parameters to allow for 33 players 
portal2.exe %windowed% -novid -allowspectators +exec multiplayermod.cfg +sv_lan 0 +mp_wait_for_other_player_notconnecting_timeout 240 +mp_wait_for_other_player_timeout 240 +map mp_coop_lobby_3 -nosixense

rem show end screen for old os versions
goto endw7



:endw10
cls
echo [36mPortal[0m [33m2[0m Was Closed [91mExiting[0m...
timeout 1 >nul
echo Exiting
goto killscriptfinal

rem display end screen message for outdates os versions
:endw7
echo Portal 2 Was Closed Exiting...
timeout 1 >nul
echo Exiting
goto killscriptfinal

:killscriptfinal
@echo off
setlocal enabledelayedexpansion
for /f "tokens=*" %%a in (mpmod.cfg) do (
  set line=%%a
  set chars=!line:~0,1!
  if !chars! == 1 (
      goto eoc
  )
)
 xcopy /y /S "%cd%\MultiplayerModFiles\MPML" "%cd%\portal2"
 if exist "%cd%\portal2\scripts\vscripts\mapspawn.nut" del /q /f "%cd%\portal2\scripts\vscripts\mapspawn.nut">nul
 echo %cd%\portal2\scripts\vscripts\mapspawn.nut
 if exist "%cd%\portal2\cfg\collisionfix.cfg" del /q /f "%cd%\portal2\cfg\collisionfix.cfg">nul
 echo %cd%\portal2\cfg\collisionfix.cfg
 if exist "%cd%\portal2\cfg\multiplayermod.cfg" del /q /f "%cd%\portal2\cfg\multiplayermod.cfg">nul
:eoc