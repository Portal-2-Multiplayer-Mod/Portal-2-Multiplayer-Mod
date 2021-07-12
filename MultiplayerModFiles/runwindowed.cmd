@echo off
cd.
cls
rem I'm sorry I didn't want to do it this way but CSHIT aka C# has forced my hand 
rem copy everything from "MultiplayerModFiles" to "portal2"
xcopy /y /S "%cd%\MultiplayerModFiles\install" "%cd%\portal2"
rem start portal 2 with the parameters to allow for 33 players 
portal2.exe -window -w 1280 -h 720 -novid -allowspectators +exec multiplayermod.cfg +sv_lan 0 +mp_wait_for_other_player_notconnecting_timeout 240 +mp_wait_for_other_player_timeout 3 +map mp_coop_lobby_3 -nosixense
rem unmount the mod
xcopy /y /S "%cd%\MultiplayerModFiles\uninstall" "%cd%\portal2"