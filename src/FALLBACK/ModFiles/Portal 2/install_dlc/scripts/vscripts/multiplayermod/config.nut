//---------------------------------------------------
//    ___              __  _        _
//   / __| ___  _ _   / _|(_) __ _ (_)
//  | (__ / _ \| ' \ |  _|| |/ _` | _
//   \___|\___/|_||_||_|  |_|\__, |(_)
//                           |___/
//---------------------------------------------------
// Purpose: Here, you can customize several parameters
//          in your server. You can change this
//          mid-game as well, however, be sure to
//          modify the one that has been copied into
//          a new portal2_dlcX folder and switch levels
//          after modifying!
//---------------------------------------------------

//-----------------------------------
// Dev variables
//-----------------------------------
// Set to true if you want to see the P2:MM debug info in the console
DevMode <- false

// Set to true if you want to see the visual debug lines in-game for ray tracing
VisualDebug <- false

//-----------------------------------
// Game variables
//-----------------------------------
// Set to true if you are playing the futbol game mode on the next map load
// If true, make sure Deathmatch is false, or no gamemode will run!
FutBolGamemode <- false

// Set to true if you are playing the deathmatch game mode on the next map load
// If true, make sure FutBolGamemode is false, or no gamemode will run!
// Note: No implementation just yet
Deathmatch <- false

// Set to true if you want to randomize every Turret's models and colors (for fun lol)
RandomTurrets <- false

// Set to true if you want to randomize the portal size
RandomPortalSize <- false

//-----------------------------------
// Server variables
//-----------------------------------
// Set to true if you want to enable the SafeGuard against mallicious commands from clients
SafeGuard <- false

// (Highly recommended to keep at 0.00!) Sets the server tick speed that our code depends on, such as disconnect messages and our loop() function
TickSpeed <- 0.00

// If the P2:MM plugin loads, then this is the list of players that have access to admin commands, along with admin level
// the highest admin level is (6) and different people can have the same admin level
// Format it like this:
// "[AdminLevel]SteamID", // Username

Admins <- [
"[6]0", // New Player
"[420]182933216", // kyleraykbs
"[69]75927374", // Wolƒe Strider Shoσter
"[12]290760494", // Nanoman2525
"[12]1106347501", // vista
"[12]181670710", // Bumpy
"[12]72399433", // cabiste
"[6]386105876", // Dreadnox
"[6]242453954", // sear
"[3]150199065", // Mystical Λce
"[12]1053720146", // Ayden
]
