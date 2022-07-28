//---------------------------------------------------
//         *****!Do not edit this file!*****
//---------------------------------------------------
//   ___  ___  _  __  __  __  __                   
//  | _ \|_  )(_)|  \/  ||  \/  |                  
//  |  _/ / /  _ | |\/| || |\/| |                  
//  |_|__/___|(_)|_|  |_||_|  |_|                  
//   / __| ___  __| | ___                          
//  | (__ / _ \/ _` |/ -_)                         
//  _\___|\___/\__,_|\___|     _     _           _ 
//  \ \ / /__ _  _ _ (_) __ _ | |__ | | ___  ___(_)
//   \ V // _` || '_|| |/ _` || '_ \| |/ -_)(_-< _ 
//    \_/ \__,_||_|  |_|\__,_||_.__/|_|\___|/__/(_)
//---------------------------------------------------
// Purpose: Here, we declare and set up almost
//          every variable used throughout the
//                  P2:MM codebase
//---------------------------------------------------

if (RandomPortalSize) {
    randomportalsize <- 34
    randomportalsizeh <- 34
}

// Setup A Global SpawnClass
GlobalSpawnClass <- class {
    // Try To Make All Spawns Global
    useautospawn = false
    // Use Set Spawnpoint
    usesetspawn = false

    // Set SpawnPoint
    setspawn = class {
        // Set SpawnPoint
        position = Vector(0,0,0)
        // Set Radius
        radius = 0
    }

    // Reds Spawn Parameters
    red = class {
        spawnpoint = Vector(0,0,0)
        rotation = Vector(0,0,0)
        velocity = Vector(0,0,0)
    }
    // Blues Spawn Parameters
    blue = class {
        spawnpoint = Vector(0,0,0)
        rotation = Vector(0,0,0)
        velocity = Vector(0,0,0)
    }
}

IsOnSingleplayerMaps <- false
if (GetMapName().len() >= 7 && GetMapName().slice(0,7)=="mp_coop") {
    IsOnSingleplayerMaps = false
} else {
    IsOnSingleplayerMaps = true
}


OriginalAngle <- null
CanCheckAngle <- false

OriginalPosMain <- null

TickSpeed <- 0.00

player1discordhookstr <- ""
CanHook <- false
Player2Joined <- false
hasbeenremoved <- false
PostMapLoadDone <- false
TickSpeed <- 0.00 // now depricated just for legacy
EventList <- []
PermaPotato <- false
TotalRemovedEnts <- 0
MadeSpawnClass <- false
usefogcontroller <- false
DevModeConfig <- DevMode
StartDevModeCheck <- false
HasRanGeneralOneTime <- false
BundgeeHookID <- "none"
BundgeeHookMessage <- "none"
OrangeCacheFailed <- false
CanClearCache <- false
DoneCacheing <- false
IsInSpawnZone <- []
HasSpawned <- false
PlayerColorCached <- []
CurrentlyDead <- []
PlayerID <- 0
PreviousTimeDeath <- 0
PreviousTime1Sec <- 0
PreviousTime5Sec <- 0
amtoffsetclr <- 0
GBIsMultiplayer <- 0
cacheoriginalplayerposition <- 0
DoneWaiting <- false
IsSingleplayerMap <- false
PluginLoaded <- false
playerclasses <- []
entityclasses <- []
PreviousNametagItter <- 0
fogs <- false
GlobalOverridePluginGrabController <- true // By default unless specified in mapsupport

FailsafeEntityCap <- 2010
EntityCap <- 2000
EntityCapLeeway <- 20
ExpendableEntities <- [
    "logic_auto",
    "logic_autosave",
    "env_viewpunch",
    "env_shake",
    "info_particle_system",
    "env_fog_controller",
    "env_fade",
    "func_areaportal",
    "env_soundscape",
    "ambient_generic",
    "prop_physics_paintable",
    "prop_physics",
    "prop_physics_override",
    "prop_physics_multiplayer",
    "prop_detail",
    "prop_dynamic_ornament",
    "prop_dynamic_override",
    "func_illusionary",
    "func_brush",
    "prop_weighted_cube",
    "func_detail",
]
InvalidRootMoveParents <- [
    "player",
    "prop_portal",
    "worldspawn",
    ""
]

ConsoleAscii <- [
""
"██████╗░░█████╗░██████╗░████████╗░█████╗░██╗░░░░░░░░░░██████╗░"
"██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██║░░░░░░░░░░╚════██╗"
"██████╔╝██║░░██║██████╔╝░░░██║░░░███████║██║░░░░░░░░░░░░███╔═╝"
"██╔═══╝░██║░░██║██╔══██╗░░░██║░░░██╔══██║██║░░░░░░░░░░██╔══╝░░"
"██║░░░░░╚█████╔╝██║░░██║░░░██║░░░██║░░██║███████╗░░░░░███████╗"
"╚═╝░░░░░░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝░░░░░╚══════╝"
""
"░░░░░░███╗░░░███╗██████╗░░░░░███╗░░░███╗░█████╗░██████╗░░░░░░░"
"░░░░░░████╗░████║██╔══██╗░░░░████╗░████║██╔══██╗██╔══██╗░░░░░░"
"░░░░░░██╔████╔██║██████╔╝░░░░██╔████╔██║██║░░██║██║░░██║░░░░░░"
"░░░░░░██║╚██╔╝██║██╔═══╝░░░░░██║╚██╔╝██║██║░░██║██║░░██║░░░░░░"
"░░░░░░██║░╚═╝░██║██║░░░░░░░░░██║░╚═╝░██║╚█████╔╝██████╔╝░░░░░░"
"░░░░░░╚═╝░░░░░╚═╝╚═╝░░░░░░░░░╚═╝░░░░░╚═╝░╚════╝░╚═════╝░░░░░░░"
""
]

CheatsOn <- false

// Add names to credits
MPMCoopCreditNames <- [
"### ",
"### ",
"### ",
"### ",
"###Portal 2: Multiplayer Mod ~ Credits",
"### ",
"###--------------------------",
"###P2:MM Head Creators",
"###--------------------------",
"kyleraykbs | Team Lead + Script + Launcher",
"Vista | Reverse Engineering, Plugin Developer",
"Bumpy | Script Theory",
"Wolƒe Strider Shoσter | Singleplayer Support",
"Nanoman2525 | Mapping + Entity Work + Launcher",
"###--------------------------",
"###P2:MM Team Members",
"###--------------------------",
"cabiste | Scripting + Mod Launcher + Code Refactor",
"###--------------------------",
"###P2:MM Contributers",
"###--------------------------",
"sear | Speedrun Mode Ideas",
"Dreadnox | Speedrun Mode Ideas",
"Jeffrey | Previous Code Cleanup",
"Enator18 | Python Dev"
"Blub/Vecc | Previous Code Commenting",
"Darnias | Jumpstarter Code",
"PieCreeper | Promotion",
"###--------------------------",
"###Special Thanks To:",
"###--------------------------",
"SuperSpeed",
"Mystical Ace",
"ANotSoSpookySkeleton",
"Panter",
"tnp|\\n|thewoodster75",
"ThePineapple",
"Areng",
"SuperSpeed",
"Brawler",
"X man",
"###--------------------------",
"###Valve: Credits",
"###--------------------------",
]