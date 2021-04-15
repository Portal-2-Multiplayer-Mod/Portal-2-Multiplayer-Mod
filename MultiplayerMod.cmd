@echo off
echo copying [96mserver.dll[0m and [96mbackupserver.dll[0m to "[93m\portal2\bin[0m"
xcopy /y "%cd%\MultiplayerModFiles" "%cd%\portal2">nul
echo [42mDone![0m
cls
set ip_address_string="IPv4 Address"
set ipnumber=0
set windowed=
echo Portal 2 [36mMultiplayer[0m [33mMod[0m [[32mFixed!... Again[0m]
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
for /f "usebackq tokens=2 delims=:" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) do echo LAN[44mIP[0m:[35m%%f[0m & goto next
:next
echo The [4mpublic[0m server [35mip[0m is:
for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do echo [33mPUB[0m[44mIP[0m: [35m%%a[0m
echo. 
set /P c=Start in [93mwindowed[0m mode? [92my[0m/[31mn[0m:
if /I "%c%" EQU "Y" set windowed=-window -w 1280 -h 720 
if /I "%c%" EQU "N" echo Windowed mode [31mDisabled[0m & goto nowindowed
echo Windowed mode [92mEnabled[0m
:nowindowed
echo.
echo Press [[33mENTER[0m] To Start [36mPortal[0m [33m2 MP[0m!
pause >nul
echo [42mStarting Portal 2 Multiplayer Mod![0m

portal2.exe %Parameters% %windowed% -allowspectators +exec multiplayermod.cfg +sv_lan 0 +mp_wait_for_other_player_notconnecting_timeout 240 +mp_wait_for_other_player_timeout 240 +map mp_coop_lobby_3

goto Exit

:Exit