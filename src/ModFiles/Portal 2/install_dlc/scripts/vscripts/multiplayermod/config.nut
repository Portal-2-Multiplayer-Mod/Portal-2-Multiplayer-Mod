//---------------------------------------------------
// Purpose: Here, you can customize several parameters
// in your server. You can change this mid-game as
// well, however, be sure to modify the one that has
// been copied into a new portal2_dlcX folder and
//          switch levels after modifying!
//---------------------------------------------------

//-----------------------------------
// Dev variables
//-----------------------------------
// Set true/false if you want to see the P2:MM debug info in the console
Config_DevMode <- false

// Set true/false if you want to see the visual debug lines in-game for ray tracing
Config_VisualDebug <- false

// Set true/false if you are a developer and wish to load your custom player model in-game
// Currently does not work on dedicated servers
Config_UseCustomDevModels <- false

//-----------------------------------
// Game variables
//-----------------------------------
// If you want to change the gamemode on the next map load, set Config_GameMode to...
// 0 - Standard   : Most stable experience
// 1 - Speedrun   : For those who like to speedrun Portal 2     (No full implementation yet)
// 2 - Deathmatch : Fight to the death in a team battle         (No full implementation yet)
// 3 - Futbol     : Portal 2 beta minigame restored             (No full implementation yet)
Config_GameMode <- 0

// Set true/false if you want to randomize every Turret's models and colors (for fun lol) (BROKEN)
Config_RandomTurrets <- false

// Set true/false if you want to randomize the size of all portals every second
Config_RandomPortalSize <- false

// Set true/false if you want the indicator of player color to appear in the bottom left corner in-game (affects all players)
Config_UseColorIndicator <- true

// Set true/false if you want the player join messages to appear in the top left corner in-game (affects all players)
Config_UseJoinIndicator <- true

// Set true/false if you want to see the player's name when you aim at them (affects all players)
Config_UseNametags <- true

//-----------------------------------
// Server variables
//-----------------------------------
// Set true/false if you want to enable the Safeguard functionality against server vscript functions from people connecting to you.
// "true" is highly recommended if this is a public server
Config_SafeGuard <- true

// Set to any integer from 0 to 256 to determine how much separation force exists between players.
// NOTE: THIS WILL NOT DO ANYTHING ON DEDICATED SERVERS!
// P2:MM disables solid collision between players as seen in normal Portal 2, since it causes issues with players spawning inside of each other.
// 0 - Players will not push each other away with any force when colliding.
// 256 - Players will push each other away with a moderate amount of force when colliding.
Config_SetPlayerElasticity <- 0

// Set true/false if you want to enable chat command functionality
Config_UseChatCommands <- true

// * If the P2:MM plugin loads and Config_UseChatCommands is true, then this is the list of players that have access to specific chat commands
// * Admins list should be changed from within the launcher at runtime, but can be changed manually here as well as long as you reset the map after editing
// * Permissions stack with increased admin level
// * The highest admin level available is [6] and is assigned automatically to the server operator (unless it's a dedicated server)
// * Everyone by default has level [0]
//
// * These can be accessed with "!" preceding them
// * Use "!help (commandname)" to print a description of each command in the chat box
//
// [0]: "help", "changeteam", "kill", "playercolor", "vote"
// [1]:
// [2]: "kill (someone)"
// [3]: "playercolor (for someone else)", "rocket (optionally someone)"
// [4]: "speed", "noclip", "teleport", "slap (optionally someone)"
// [5]: "restartlevel", "spchapter", "mpcourse"
// [6]: "rcon", "adminmodify", "kick", "ban"
//
// Example on how to format the list:
// Admins <- [
//     "[AdminLevel]SteamID", // (Username to keep track)
//     "[3]123456789", // John Doe
// ]

Admins <- [
    // Add Admins Here
]

// * Custom Lobby Music Control * \\

// 14 music tracks total, this can be changed in the list of tracks but make sure to adjust musicMax
// Don't adjust musicMin as this will just determine where No Music will be in the track list and can mess up other things
// musicDefault is what is selected when music is called to start in MusicInit()
// musicSelected is the current music track number, this should start as the same as musicDefault
musicMax <- 14
musicMin <- 0
musicDefault <- 1
musicSelected <- musicDefault

// Music tracks to be played
musicTracks <- {
    musicTrack1 = "music/mp_coop_lobby_2_c1.wav"
    musicTrack2 = "music/mp_coop_lobby_2_c2.wav"
    musicTrack3 = "music/mp_coop_lobby_2_c4.wav"
    musicTrack4 = "music/mp_coop_lobby_2_c5.wav"
    musicTrack5 = "music/mp_coop_lobby_2_c6.wav"
    musicTrack6 = "music/mp_coop_lobby_2_c7.wav"
    musicTrack7 = "music/mp_coop_hallway_c4.wav"
    musicTrack8 = "music/portal2_robots_ftw.wav"
    musicTrack9 = "music/sp_a1_wakeup_b1.wav"
    musicTrack10 = "music/sp_a2_bts1_b1.wav"
    musicTrack11 = "music/sp_a4_tb_catch_b1a.wav"
    musicTrack12 = "music/sp_a4_finale1_b2p2.wav"
    musicTrack13 = "ambient/music/looping_radio_mix.wav"
    musicTrack14 = "music/portal2_want_you_gone.wav"
}