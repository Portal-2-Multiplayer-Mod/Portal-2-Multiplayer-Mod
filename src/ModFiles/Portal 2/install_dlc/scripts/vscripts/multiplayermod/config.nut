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
FutBolGamemode <- false

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
// The highest number declared is the highest admin level and different people can have the same admin level
// Format it like this: Admins <- ["[3]MyExactSteamUsername", "[2]MyFriendsUsername", "[1]MyOtherFriendsUsernameWithLessPower"]
Admins <- ["[420]kyleraykbs", "[69]vista", "[12]cabiste", "[12]Bumpy", "[12]Nanoman2525", "[12]Wolƒe Strider Shoσter", "[5]Mystical Λce", "[2]CHARITY", "[2]thewoodster75`", "[6]Dreadnox", "[1]!wol", "[6]sear", "[12]Ayden",  "[2]Eggshell97", "[1]trixie6709"]
