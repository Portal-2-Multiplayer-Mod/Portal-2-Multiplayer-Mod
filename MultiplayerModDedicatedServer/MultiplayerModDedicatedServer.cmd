@echo off
Title Portal 2 Multiplayer Dedicated Server
cd..
xcopy /y /S "%cd%\MultiplayerModDedicatedServer\DedicatedServerFiles" "%cd%\portal2"
cls
call portal2.exe %windowed% -novid -allowspectators +exec multiplayermod.cfg +sv_lan 0 +mp_wait_for_other_player_notconnecting_timeout 240 +mp_wait_for_other_player_timeout 3 +map mp_coop_lobby_3 -nosixense -textmode -nosound -noipx -nopreload -nojoy -sw +script_execute DedicatedServer -voice_quality 3 +exec DedicatedServer.cfg
