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

// Set true/false if you want to use a VScript Debugger. This also sets "developer" to 1. Only works for Windows systems!
// Highly recommended to use the "VScript Debugger" by LionDoge, a extension for Visual Studio Code. https://marketplace.visualstudio.com/items?itemName=LionDoge.vscript-debug
// How debugging was implemented for P2MM has been done according to LionDoge's extension instructions. 
// This means that Config_DevMode will be automatically set to true wether or not it's been set to false as developer is needed to be enabled.
// On every map change you will need to reattach the debugger, that's just unfortunately how Valve programmed it.
//! ONLY ENABLE THIS IF YOU KNOW WHAT YOU'RE DOING! Game will freeze and won't unfreeze until a debugger is attached!
Config_VScriptDebug <- false

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

// Set false if you want to disable the prompt that appears once at the start at every play session.
Config_FirstRunPrompt <- true

// Set true/false if you want to randomize every Turret 's models and colors and the Frankenturret's colors.
// The second one when true will make the models and colors constantly change instead of once.
//! Don't turn Config_RandomTurretLoop on while the map is running or the game will crash because the models
//! were not precached at PostMapSpawn. Change here then reload the map.
Config_RandomTurret <- false
Config_RandomTurretLoop <- false

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
// What each admin level gives you (0 means no admin, default player permissions)
// [0]: "help", "changeteam", "kill", "playercolor", replying to a "vote"
// [1]:
// [2]: "playercolor (for someone else)", "speed", "teleport"
// [3]: "kill (someone else)", "noclip", "restartlevel", calling a vote with "vote"
// [4]: "slap (optionally someone)", "rocket (optionally someone)", "hub", "mpcourse", "spcourse"
// [5]: "kick"
// [6]: "adminmodify" 
//
// Example on how to format the list:
// Admins <- [
//     "[AdminLevel]Steam3 ID (only the numbers bit)", // (Username to keep track)
//     "[3]123456789", // John Doe
// ]

Admins <- [
    // Add Admins Here
]

// * Custom Lobby Music Control * \\
// * Configs for the custom music controls in mp_coop_lobby_3 * \\

// Config_musicEnable: Whether to enable custom music control in the lobby.
Config_musicEnable <- true

// Config_musicDefault: Which music track in Config_musicTracks is called to start by default in the lobby. 
// Set this to -1 if you don't want any music to start in the lobby, but still want to adjust it.
// Only integers greater or equal to -1 are allowed.
Config_musicDefault <- 0

// Config_musicTracks: The music track list containing tracks to be played in mp_coop_lobby_3. For it to be heard by all players
// it must come with Portal 2, or it has to be in the same location on disk for both the host and clients for clients to hear it. 
// 
// Recommended to use .wav files, .mp3 files also work but, it's also recommended that your sound file has 
// build in looping, or you have to change to a different track then back again to start it again. The ambient_generic 
// used can not automatically rerun tracks unless they have build in looping. You can tell if your music track has 
// built in looping when you run the "snd_show 1" command in the console and you see "looped(1) to the left of the 
// music tracks file name. Built in looping can be done to .wav files but isn't possible with .mp3 files. 
// Those marked with "Doesn't loop", are some tracks that would be nice to be there by default, but they don't loop.
//
// Example track list setup: 
// Config_musicTracks <- [
//     "music/mp_coop_lobby_2_c1.wav"
// ]
Config_musicTracks <- [
    "music/mp_coop_lobby_2_c1.wav" //0 index, 1/16
    "music/mp_coop_lobby_2_c2.wav" //1 index, 2/16
    "music/mp_coop_lobby_2_c4.wav" //2 index, 3/16
    "music/mp_coop_lobby_2_c5.wav" //3 index, 4/16
    "music/mp_coop_lobby_2_c6.wav" //4 index, 5/16
    "music/mp_coop_lobby_2_c7.wav" //5 index, 6/16
    "music/mp_coop_hallway_c4.wav" //6 index, 7/16
    "music/sp_a1_wakeup_b1.wav" //7 index, 8/16
    "music/sp_a2_bts1_b1.wav" //8 index, 9/16
    "music/sp_a4_tb_catch_b1a.wav" //9 index, 10/16
    "music/sp_a4_finale1_b2p2.wav" //10 index, 11/16
    "music/portal2_want_you_gone.wav" //11 index, 12/16
    "music/portal2_robots_ftw.wav" //12 index, 13/16
    "ambient/music/looping_radio_mix.wav" //13 index, 14/16
    "music/sp_a2_dual_lasers_r1.wav" //14 index, 15/16 *Doesn't loop*
    "music/sp_a2_laser_vs_turret_r1.wav" //15 index, 16/16 *Doesn't loop*
]