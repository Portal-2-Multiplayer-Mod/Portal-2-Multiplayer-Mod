@echo off
:start
set /P c=Command:
cls
echo %c%
echo %c% > MultiplayerModDedicatedServer\DedicatedServerFiles\cfg\DedicatedServerCommands.cfg
xcopy /y /S "%cd%\MultiplayerModDedicatedServer\DedicatedServerFiles\cfg\DedicatedServerCommands.cfg" "%cd%\portal2\cfg"
cls
timeout 1
echo. > MultiplayerModDedicatedServer\DedicatedServerFiles\cfg\DedicatedServerCommands.cfg
xcopy /y /S "%cd%\MultiplayerModDedicatedServer\DedicatedServerFiles\cfg\DedicatedServerCommands.cfg" "%cd%\portal2\cfg"
cls
goto start
