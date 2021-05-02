@echo off

title [Beta 1.1.2] Portal 2 32 Player Mod Lite - BumpyAHK and Kyleraykbs

rem detect os version and store it in a varible called "version"
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j

rem stop portal 2
taskkill /F /IM portal2.exe

rem clear screen
cls

rem print text
echo copying [96mcore files[0m to "[93m\portal2[0m"

rem copy everything from "MultiplayerModFiles" to "portal2"
xcopy /y /S "%cd%\MultiplayerModFiles" "%cd%\portal2"

rem print text
echo [42mDone![0m

rem clear screen
cls

rem set varibles to default
set ip_address_string="IPv4 Address"
set windowed=

rem check if OS version is windows 10 if not goto "outdatedOS" if it is windows 10 continue as normal
if "%version%" == "10.0" (echo.) else (goto outdatedOS)

rem print text
echo  Portal 2 [36mMultiplayer[0m [33mMod[0m [[32mFixed!... Again[0m]
echo.
echo                   [91mHow To Use[0m
echo [93m==============================================[0m
echo make sure you and your friends have the same
echo version of the mod installed 
echo [91mHow To Host[0m :
echo [92mCase 1.[0m : your playing with friends online
echo then send them the public ip
echo (also make sure you have 27015 or 27016 port forwarded)
echo [92mCase 2.[0m : your playing with freinds on your
echo local network/in your home then send them the local ip
echo [91mHow To Join (tell your friends this)[0m :
echo [92mStep 1.[0m : Open the console in game
echo (if you dont know how to open the console google it)
echo [92mStep 2.[0m : Type "connect theipthehostgaveyou"
echo replace "theipthehostgaveyou" with the ip the host gave you
echo [92mStep 3.[0m : Press [[33mENTER[0m] and have fun!
echo [93m==============================================[0m
echo The [1mlocal/lan[0m server [35mip[0m is:

rem find the local ip and print it
for /f "usebackq tokens=2 delims=:" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) do echo LAN[44mIP[0m:[35m%%f[0m & goto next

rem goto next as to not print the ip forever
:next

rem print text
echo The [4mpublic[0m server [35mip[0m is:

rem get the public ip of the user and print it
for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do echo [33mPUB[0m[44mIP[0m: [35m%%a[0m
echo. 

rem ask the user if they want windowed mode
set /P c=Start in [93mwindowed[0m mode? [92my[0m/[31mn[0m:
rem if the user types "y" set the varible %windowed% to be the parameters for windowed mode
if /I "%c%" EQU "Y" set windowed=-window -w 1280 -h 720 & echo Windowed mode [92mEnabled[0m
rem if the user type "n" echo that windowed mode is disabled
if /I "%c%" EQU "N" echo Windowed mode [31mDisabled[0m

rem print text
echo.
echo Press [[33mENTER[0m] To Start [36mPortal[0m [33m2 MP[0m!

rem Wait Until a key Is Pressed
pause >nul

rem print text
echo [42mStarting Portal 2 Multiplayer Mod![0m

rem start portal 2 with the parameters to allow for 33 players 
portal2.exe %Parameters% %windowed% -allowspectators +exec multiplayermod.cfg +sv_lan 0 +mp_wait_for_other_player_notconnecting_timeout 240 +mp_wait_for_other_player_timeout 240 +map mp_coop_lobby_3

goto endw10






rem run in compatibility mode
:outdatedOS

rem nag user about outdated os
echo  Running On Outdated Version Of Windows [Compatibility Mode Enabled]
echo.
rem print text
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
echo The local/lan server ip is:

rem find the local ip and print it
for /f "usebackq tokens=2 delims=:" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) do echo LANIP:%%f & goto next

rem goto next as to not print the ip forever
:next

rem print text
echo The public server ip is:

rem nag the user about using an outdated OS and show them how to get their public ip
echo It looks like your running an outdated version of windows 
echo For this reason we cannot find your public ip in console
echo To find your public ip please visit http://api.ipify.org/
echo.

rem ask the user if they want windowed mode
set /P c=Start in windowed mode? y/n:
rem if the user types "y" set the varible %windowed% to be the parameters for windowed mode
if /I "%c%" EQU "Y" set windowed=-window -w 1280 -h 720 & echo Windowed mode Enabled
rem if the user type "n" echo that windowed mode is disabled
if /I "%c%" EQU "N" echo Windowed mode Disabled

rem print text
echo.
echo Press [ENTER] To Start Portal 2 MP!

rem Wait Until a key Is Pressed
pause >nul

rem print text
echo Starting Portal 2 Multiplayer Mod!

rem start portal 2 with the parameters to allow for 33 players 
portal2.exe %Parameters% %windowed% -allowspectators +exec multiplayermod.cfg +sv_lan 0 +mp_wait_for_other_player_notconnecting_timeout 240 +mp_wait_for_other_player_timeout 240 +map mp_coop_lobby_3

rem show end screen for old os versions
goto endw7



:endw10
cls
echo [36mPortal[0m [33m2[0m Was Closed [91mExiting[0m In 5...
timeout 1 >nul
cls
echo [36mPortal[0m [33m2[0m Was Closed [91mExiting[0m In 4...
timeout 1 >nul
cls
echo [36mPortal[0m [33m2[0m Was Closed [91mExiting[0m In 3...
timeout 1 >nul
cls
echo [36mPortal[0m [33m2[0m Was Closed [91mExiting[0m In 2...
timeout 1 >nul
cls
echo [36mPortal[0m [33m2[0m Was Closed [91mExiting[0m In 1...
timeout 1 >nul
echo Exiting
goto killscriptfinal

rem display end screen message for outdates os versions
:endw7
cls
echo Portal 2 Was Closed Exiting In 5...
timeout 1 >nul
cls
echo Portal 2 Was Closed Exiting In 4...
timeout 1 >nul
cls
echo Portal 2 Was Closed Exiting In 3...
timeout 1 >nul
cls
echo Portal 2 Was Closed Exiting In 2...
timeout 1 >nul
cls
echo Portal 2 Was Closed Exiting In 1...
timeout 1 >nul
echo Exiting
goto killscriptfinal

:killscriptfinal