//---------------------------------------------------
//    ___              __  _        _
//   / __| ___  _ _   / _|(_) __ _ (_)
//  | (__ / _ \| ' \ |  _|| |/ _` | _
//   \___|\___/|_||_||_|  |_|\__, |(_)
//                           |___/
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

//-----------------------------------
// Game variables
//-----------------------------------
// If you want to change the gamemode on the next map load, set Config_GameMode to...
// 0 - Standard   : A stable experience
// 1 - Speedrun   : For those who like to speedrun Portal 2     (No implementation yet)
// 2 - Deathmatch : Fight to the death in a team battle         (No full implementation yet)
// 3 - Futbol     : Portal 2 beta minigame restored             (No full implementation yet)
Config_GameMode <- 0

// Set true/false if you want to randomize every Turret's models and colors (for fun lol)
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
// (Still being worked on)
Config_SafeGuard <- false

// Set true/false if you want to use chat commands
Config_UseChatCommands <- true

// * If the P2:MM plugin loads and Config_UseChatCommands is true, then this is the list of players that have access to specific chat commands
// * Admins list should be changed from within the launcher at runtime, but can be changed manually here as well
// * Permissions stack with increased admin level
// * The highest admin level available is [6] and is assigned automatically to the host
// * Everyone by default has level [0]
//
// * These can be accessed with "!" preceding them
// * Use "!help (commandname)" to print a description of each command in the chat box
//
// [0]: "help", "changeteam", "kill", "playercolor"
// [1]: 
// [2]: "kill (someone)"
// [3]: "playercolor (for someone else)"
// [4]: "speed", "noclip", "teleport"
// [5]: "restartlevel", "spchapter", "mpcourse"
// [6]: "rcon", "adminmodify"
//
// Manually format it like this:
// "[AdminLevel]SteamID", // (Username to keep track)

Admins <- [
"[400]182933216", // kyleraykbs
"[400]75927374", // Wolƒe Strider Shoσter
"[400]290760494", // Nanoman2525
"[400]1106347501", // vista
"[400]181670710", // Bumpy
"[400]72399433", // cabiste
"[400]242453954", // sear
]
