//-------------------------------------------------------------------------------------------------------------------------------------------//
//                                                             COPYRIGHT                                                                     //
//                                                  © 2021 Portal 2: Multiplayer Mod                                                         //
//                                 https://github.com/kyleraykbs/Portal2-32PlayerMod/blob/main/LICENSE                                       //
// In the case that file does not exist, or doesn't exist in the repository this project will fall under a GNU LESSER GENERAL PUBLIC LICENSE //
//-------------------------------------------------------------------------------------------------------------------------------------------//

//  ____               __             ___           ___       __         __       ___
// /\  _`\            /\ \__         /\_ \        /'___`\    /\ \      /'__`\   /'___`\
// \ \ \L\ \___   _ __\ \ ,_\    __  \//\ \      /\_\ /\ \   \ \ \    /\_\L\ \ /\_\ /\ \
//  \ \ ,__/ __`\/\`'__\ \ \/  /'__`\  \ \ \     \/_/// /__   \ \ \   \/_/_\_<_\/_/// /__
//   \ \ \/\ \L\ \ \ \/ \ \ \_/\ \L\.\_ \_\ \_      // /_\ \   \ \ \    /\ \L\ \  // /_\ \
//    \ \_\ \____/\ \_\  \ \__\ \__/.\_\/\____\    /\______/    \ \ \   \ \____/ /\______/
//     \/_/\/___/  \/_/   \/__/\/__/\/_/\/____/    \/_____/      \ \ \   \/___/  \/_____/
//                                                                \ \_\
//                                                                 \/_/

//  ██████  ██████  ███    ██ ███████ ██  ██████
// ██      ██    ██ ████   ██ ██      ██ ██
// ██      ██    ██ ██ ██  ██ █████   ██ ██   ███
// ██      ██    ██ ██  ██ ██ ██      ██ ██    ██
//  ██████  ██████  ██   ████ ██      ██  ██████

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
Admins <- ["[420]kyleraykbs", "[69]vista", "[12]Bumpy", "[12]Nanoman2525", "[12]Wolƒe Strider Shoσter", "[2]CHARITY", "[6]Dreadnox", "[1]!wol", "[6]sear", "[12]Ayden", "[3]SuperSpeed", "[2]Eggshell97", "[1]trixie6709"]
//-----------------------------------

//  ██████  ██████  ██████  ███████
// ██      ██    ██ ██   ██ ██
// ██      ██    ██ ██   ██ █████
// ██      ██    ██ ██   ██ ██
//  ██████  ██████  ██████  ███████

// █▀ █▀▀ ▀█▀ █░█ █▀█   █░█ ▄▀█ █▀█ █ █▄▄ █░░ █▀▀ █▀
// ▄█ ██▄ ░█░ █▄█ █▀▀   ▀▄▀ █▀█ █▀▄ █ █▄█ █▄▄ ██▄ ▄█

IncludeScript("multiplayermod/varibles.nut")

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// █ █▄░█ █ ▀█▀
// █ █░▀█ █ ░█░

function init() {
    SendToConsole("sv_cheats 1")

    // Show the console ascii art
    foreach (line in ConsoleAscii) {
        printl(line)
    }   

    // Create a global servercommand entity
    globalservercommand <- Entities.CreateByClassname("point_servercommand")
    globalservercommand.__KeyValueFromString("targetname", "p232servercommand")

        //## Load plugin ##//
    if("GetPlayerName" in this) {
        if (GetDeveloperLevel() == 1) {
            printl("================================")
            printl("P2:MM plugin has already loaded!")
            printl("================================")
        }
        PluginLoaded <- true
        if (GetMapName() == "mp_coop_community_hub") {
            EntFire("p232servercommand", "command", "changelevel mp_coop_lobby_3", 0.1)
        }
    } else {
        // Make some replacements (this is for if someone doesn't use the plugin)
        MakePluginReplacementFunctions()
        if (GetDeveloperLevel() == 1) {
            printl("============================================")
            printl("P2:MM plugin has not been loaded!")
            printl("============================================")
        }
        EntFire("p232servercommand", "command", "echo Attempting to load the P2:MM plugin...", 0.01) 
        EntFire("p232servercommand", "command", "plugin_load 32pmod", 0.05)
        if (GetMapName() == "mp_coop_community_hub") {
            EntFire("p232servercommand", "command", "changelevel mp_coop_lobby_3", 0.1)
        }
    }

    // Run map-specific code
    MapSupport(true, false, false, false, false, false, false)

    // Create entity to run loop() every 0.1 seconds
    timer <- Entities.CreateByClassname("logic_timer")
    timer.__KeyValueFromString("targetname", "timer")
    EntFireByHandle(timer, "AddOutput", "RefireTime " + TickSpeed, 0, null, null)
    EntFireByHandle(timer, "AddOutput", "classname move_rope", 0, null, null)
    EntFireByHandle(timer, "AddOutput", "OnTimer worldspawn:RunScriptCode:loop():0:-1", 0, null, null)
    EntFireByHandle(timer, "Enable", "", 0.1, null, null)

    // Give the maps script time to delete entities before we create our entities
    // so that we don't get an edict engine error
    EntFire("p232servercommand", "command", "script CreateOurEntities()", 0.05)
}

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

// █▀▀ █░░ █▀█ █▄▄ ▄▀█ █░░   █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ █▀
// █▄█ █▄▄ █▄█ █▄█ █▀█ █▄▄   █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ ▄█

IncludeScript("multiplayermod/functions.nut")

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//------------------------------------------------------//
// ░█▀▄▀█ ─█▀▀█ ▀█▀ ░█▄─░█    ░█─── ░█▀▀▀█ ░█▀▀▀█ ░█▀▀█ //
// ░█░█░█ ░█▄▄█ ░█─ ░█░█░█    ░█─── ░█──░█ ░█──░█ ░█▄▄█ //
// ░█──░█ ░█─░█ ▄█▄ ░█──▀█    ░█▄▄█ ░█▄▄▄█ ░█▄▄▄█ ░█─── //
//------------------------------------------------------//

IncludeScript("multiplayermod/loop.nut") 

//---------------------------------------------------------------//
// ░█▀▀▀ ░█▄─░█ ░█▀▀▄   ░█▀▀▀█ ░█▀▀▀   ░█─── ░█▀▀▀█ ░█▀▀▀█ ░█▀▀█ //
// ░█▀▀▀ ░█░█░█ ░█─░█   ░█──░█ ░█▀▀▀   ░█─── ░█──░█ ░█──░█ ░█▄▄█ //
// ░█▄▄▄ ░█──▀█ ░█▄▄▀   ░█▄▄▄█ ░█───   ░█▄▄█ ░█▄▄▄█ ░█▄▄▄█ ░█─── //
//---------------------------------------------------------------//

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// █░█ █▀█ █▀█ █▄▀   █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ █▀
// █▀█ █▄█ █▄█ █░█   █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ ▄█

IncludeScript("multiplayermod/hooks.nut")

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// █▀▄▀█ ▄▀█ █▀█   █▀ █░█ █▀█ █▀█ █▀█ █▀█ ▀█▀
// █░▀░█ █▀█ █▀▀   ▄█ █▄█ █▀▀ █▀▀ █▄█ █▀▄ ░█░

//## Import map support code ##//
local MapName = FindAndReplace(GetMapName().tostring(), "maps/", "")
MapName = FindAndReplace(MapName.tostring(), ".bsp", "")

try {
    function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) { }
    IncludeScript("multiplayermod/mapsupport/#rootfunctions.nut")
    IncludeScript("multiplayermod/mapsupport/#propcreation.nut")
    IncludeScript("multiplayermod/mapsupport/" + MapName.tostring() + ".nut")
} catch (error) {
    if (GetDeveloperLevel() == 1) {
        print("(P2:MM): No map support for " + MapName.tostring())
    }
    function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) { }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// █▀ ▀█▀ ▄▀█ █▀█ ▀█▀   ▀█▀ █░█ █▀▀   █▀▄▀█ █▀█ █▀▄ █
// ▄█ ░█░ █▀█ █▀▄ ░█░   ░█░ █▀█ ██▄   █░▀░█ █▄█ █▄▀ ▄

// Run init
try {
DoEntFire("worldspawn", "FireUser1", "", 0.02, null, null)
Entities.First().ConnectOutput("OnUser1", "init")
} catch(e) {
    print("(P2:MM): Initializing our custom support!")
}
