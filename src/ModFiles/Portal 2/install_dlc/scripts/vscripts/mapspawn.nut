//------------------------------------------------------------------------------------------------------------------------------------------------//
//                                                                  COPYRIGHT                                                                     //
//                                                       © 2022 Portal 2: Multiplayer Mod                                                         //
//                                      https://github.com/kyleraykbs/Portal2-32PlayerMod/blob/main/LICENSE                                       //
// In the case that this file does not exist at all or in the GitHub repository, this project will fall under a GNU LESSER GENERAL PUBLIC LICENSE //
//------------------------------------------------------------------------------------------------------------------------------------------------//

// Here, you can customize several parameters in your server.
// You can change this mid-game as well, however, be sure to
// modify the the one that has been copied into a new
// You can change this mid-game as well, however, be sure
// to modify the one that has been copied into a new
// portal2_dlcX folder and switch levels after modifying!

//    ___              __  _        _ 
//   / __| ___  _ _   / _|(_) __ _ (_)
//  | (__ / _ \| ' \ |  _|| |/ _` | _ 
//   \___|\___/|_||_||_|  |_|\__, |(_)
//                           |___/    

//-----------------------------------
DevMode <- true // Set to true if you're a developer
//-----------------------------------
DevInfo <- false // Set to true if you want to see the developer info
//-----------------------------------
// UsePlugin <- true // Set to false if you want to use the plugin (LINUX ONLY)
//-----------------------------------
VisualDebug <- false // Set to true if you want to see the debug info
//-----------------------------------
DedicatedServer <- false // Set to true if you want to run the server as a dedicated server (INDEV)
//-----------------------------------
RandomTurrets <- false // Set to true if you want to randomize every Turret's models and colors (for fun lol)
//-----------------------------------
TickSpeed <- 0.00 // Set to the tick speed of the server [in seconds] (lower numbers are faster but may cause lag on slower clients)
//-----------------------------------
RandomPortalSize <- false // Set to true if you want to randomize the portal size
//-----------------------------------
Admins <- ["[420]kyleraykbs", "[69]vista", "[12]cabiste", "[12]Bumpy", "[12]Nanoman2525", "[12]Wolƒe Strider Shoσter", "[2]CHARITY", "[2]thewoodster75`", "[6]Dreadnox", "[1]!wol", "[6]sear", "[12]Ayden", "[3]SuperSpeed", "[2]Eggshell97", "[1]trixie6709"]
//-----------------------------------

// END OF CONFIG!
// Do not modify the below.

//    ___          _        ___       _                _ 
//   / __| ___  __| | ___  / __| ___ | |_  _  _  _ __ (_)
//  | (__ / _ \/ _` |/ -_) \__ \/ -_)|  _|| || || '_ \ _ 
//   \___|\___/\__,_|\___| |___/\___| \__| \_,_|| .__/(_)
//                                              |_|      

IncludeScript("multiplayermod/variables.nut")

// Now we declare some functions...

// init() will run on every map spawn or transition
// It does a few things:
// 1. Attempt to load our plugin if it has not been loaded,
//    and compensate if it doesn't exist.
// 2. Run our map-specific code and loop the loop() function
// 3. Create map-specific entities after a delay

function init() {
    
    SendPythonReset()

    // Show the console ascii art
    foreach (line in ConsoleAscii) {
        printl(line)
    }

    // Create a global point_servercommand entity for us to pass through commands
    globalservercommand <- Entities.CreateByClassname("point_servercommand")
    globalservercommand.__KeyValueFromString("targetname", "p232servercommand")

    // Load plugin if it exists and compensate if it doesn't
    // Also change the level once it has succeeded this
    if("GetPlayerName" in this) {
        if (GetDeveloperLevel() == 1) {
            printl("================================")
            printl("P2:MM plugin has already loaded!")
            printl("================================")
        }
        PluginLoaded <- true
    } else {
        MakePluginReplacementFunctions()
        if (GetDeveloperLevel() == 1) {
            printl("============================================")
            printl("P2:MM plugin has not been loaded!")
            printl("============================================")
        }
        EntFire("p232servercommand", "command", "echo Attempting to load the P2:MM plugin...", 0.01)
        EntFire("p232servercommand", "command", "plugin_load 32pmod", 0.05)
        if (GetDeveloperLevel() == 918612) {
            EntFire("p232servercommand", "command", "developer 1", 0.01)
            EntFire("p232servercommand", "command", "changelevel mp_coop_lobby_3", 0.2)
        }
    }

    // Run map-specific code
    MapSupport(true, false, false, false, false, false, false)

    // Create an entity to run the loop() function every 0.1 second
    timer <- Entities.CreateByClassname("logic_timer")
    timer.__KeyValueFromString("targetname", "timer")
    EntFireByHandle(timer, "AddOutput", "RefireTime " + TickSpeed, 0, null, null)
    EntFireByHandle(timer, "AddOutput", "classname move_rope", 0, null, null)
    EntFireByHandle(timer, "AddOutput", "OnTimer worldspawn:RunScriptCode:loop():0:-1", 0, null, null)
    EntFireByHandle(timer, "Enable", "", 0.1, null, null)

    // Delay the creation of our entities before so that we don't get an engine error from the entity limit
    EntFire("p232servercommand", "command", "script CreateOurEntities()", 0.05)
}

// DoesPluginExist() is a developer function
// and just helps us with finding our plugin
function DoesPluginExist() {
    if ("GetPlayerName" in this) {
        if (GetDeveloperLevel() == 1) {
            printl("(P2:MM): Plugin exists!===================")
        }
    } else {
        if (GetDeveloperLevel() == 1) {
            printl("(P2:MM): Plugin nonexistent!==============")
        }
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Import the rest of our external Squirrel "libraries" 
IncludeScript("multiplayermod/functions.nut")
IncludeScript("multiplayermod/loop.nut")
IncludeScript("multiplayermod/hooks.nut")

//   ___           _  _  _  _          _        
//  | __|__ _  __ (_)| |(_)| |_  __ _ | |_  ___ 
//  | _|/ _` |/ _|| || || ||  _|/ _` ||  _|/ -_)
//  |_| \__,_|\__||_||_||_|_\__|\__,_| \__|\___|
//  |  \/  | __ _  _ __   / __| ___  __| | ___  
//  | |\/| |/ _` || '_ \ | (__ / _ \/ _` |/ -_) 
//  |_|  |_|\__,_|| .__/  \___|\___/\__,_|\___| 
//                |_|   ___              _      
//   __ _  _ _   __| | | _ \ _  _  _ _  | |     
//  / _` || ' \ / _` | |   /| || || ' \ |_|     
//  \__,_||_||_|\__,_| |_|_\ \_,_||_||_|(_)     

// Import map support code
local MapName = FindAndReplace(GetMapName().tostring(), "maps/", "")
MapName = FindAndReplace(MapName.tostring(), ".bsp", "")

try {
    function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) { }
    IncludeScript("multiplayermod/mapsupport/#rootfunctions.nut") // Import some generally used map functions to call upon in the map code for ease
    IncludeScript("multiplayermod/mapsupport/#propcreation.nut") // Import a giant function to create props server-side based on map name
    IncludeScript("multiplayermod/mapsupport/" + MapName.tostring() + ".nut") // Import the  map support code
} catch (error) {
    if (GetDeveloperLevel() == 1) {
        print("(P2:MM): No map support for " + MapName.tostring())
    }
    function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) { }
}

// Now that we set up everything, all we do is run it
try {
DoEntFire("worldspawn", "FireUser1", "", 0.02, null, null)
Entities.First().ConnectOutput("OnUser1", "init")
} catch(e) {
    print("(P2:MM): Initializing our custom support!")
}
