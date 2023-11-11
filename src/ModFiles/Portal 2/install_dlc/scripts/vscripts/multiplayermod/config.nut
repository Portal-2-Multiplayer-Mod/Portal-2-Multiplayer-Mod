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
// * Configs for the custom music controls in mp_coop_lobby_3 * \\

// musicEnable: Whether to enable custom music control in the lobby.
musicEnable <- true

// musicDefault: What music track is called to start by default in the lobby. 
// Set this to zero if you don't want any music to start in the lobby.
musicDefault <- 1

// musicTracks: The music track list containing tracks to be played in the lobby. For it to be heard by all 
// players it must come with Portal 2, or it has to be in the same location on disk as the host and as listed here. 
// 
// Recommended to use .wav files, but .mp3 should also work but... It's also recommended that your sound file has 
// build in looping, the ambient_generic we use can not automatically rerun tracks unless they have build in looping. 
// You can tell if your music track has built in looping when you run the "snd_show 1" command in the console 
// and you see "looped(1) to the left of the music tracks file name. Built in looping can be done to .wav files but 
// isn't possible with .mp3 files. Those marked with "Doesn't loop", are some tracks we thought would be nice to be
// there by default, but they don't loop.
//
// There needs to at least one specified track for things properly to work, this can be a empty string but if you 
// don't want music just set musicDefault to zero.
musicTracks <- {
    musicTrack1 = "music/mp_coop_lobby_2_c1.wav"
    musicTrack2 = "music/mp_coop_lobby_2_c2.wav"
    musicTrack3 = "music/mp_coop_lobby_2_c4.wav"
    musicTrack4 = "music/mp_coop_lobby_2_c5.wav"
    musicTrack5 = "music/mp_coop_lobby_2_c6.wav"
    musicTrack6 = "music/mp_coop_lobby_2_c7.wav"
    musicTrack7 = "music/mp_coop_hallway_c4.wav"
    musicTrack8 = "music/sp_a1_wakeup_b1.wav"
    musicTrack9 = "music/sp_a2_bts1_b1.wav"
    musicTrack10 = "music/sp_a4_tb_catch_b1a.wav"
    musicTrack11 = "music/sp_a4_finale1_b2p2.wav"
    musicTrack12 = "music/portal2_want_you_gone.wav"
    musicTrack13 = "music/portal2_robots_ftw.wav"
    musicTrack14 = "ambient/music/looping_radio_mix.wav"
    musicTrack15 = "music/sp_a2_dual_lasers_r1.wav" // Doesn't loop
    musicTrack16 = "music/sp_a2_laser_vs_turret_r1.wav" // Doesn't loop
}