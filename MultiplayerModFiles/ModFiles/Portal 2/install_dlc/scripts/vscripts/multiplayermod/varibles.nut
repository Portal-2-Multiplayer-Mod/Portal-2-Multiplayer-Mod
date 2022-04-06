if (RandomPortalSize==true) {
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

IsOnSingleplayer <- false
if (GetMapName().slice(0,7)=="mp_coop") {
    IsOnSingleplayer = false
} else {
    IsOnSingleplayer = true
}


OriginalAngle <- null
CanCheckAngle <- false

OriginalPosMain <- null

player1discordhookstr <- ""
CanHook <- false
Player2Joined <- false
hasbeenremoved <- false
PostMapLoadDone <- false
TickSpeed <- 0.00 // Now deprecated; Kept for legacy
EventList <- []
PermaPotato <- false
TotalRemovedEnts <- 0
MadeSpawnClass <- false
usefogcontroller <- false
DevModeConfig <- DevMode
StartDevModeCheck <- false
PreviousTimeDeath <- 0
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
PreviousTime5Sec <- 0
amtoffsetclr <- 0
GBIsMultiplayer <- 0
cacheoriginalplayerposition <- 0
DoneWaiting <- false
IsSingleplayerMap <- false
PluginLoaded <- false
PreviousTime1Sec <- 0
playerclasses <- []
entityclasses <- []
fogs <- false

ConsoleAscii <- [
""
"██████╗░░█████╗░██████╗░████████╗░█████╗░██╗░░░░░░░░░██████╗░"
"██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██║░░░░░░░░░╚════██╗"
"██████╔╝██║░░██║██████╔╝░░░██║░░░███████║██║░░░░░░░░░░░███╔═╝"
"██╔═══╝░██║░░██║██╔══██╗░░░██║░░░██╔══██║██║░░░░░░░░░██╔══╝░░"
"██║░░░░░╚█████╔╝██║░░██║░░░██║░░░██║░░██║███████╗░░░░███████╗"
"╚═╝░░░░░░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝░░░░╚══════╝"
""
"███╗░░░███╗██████╗░░░░░███╗░░░███╗░█████╗░██████╗░"
"████╗░████║██╔══██╗░░░░████╗░████║██╔══██╗██╔══██╗"
"██╔████╔██║██████╔╝░░░░██╔████╔██║██║░░██║██║░░██║"
"██║╚██╔╝██║██╔═══╝░░░░░██║╚██╔╝██║██║░░██║██║░░██║"
"██║░╚═╝░██║██║░░░░░░░░░██║░╚═╝░██║╚█████╔╝██████╔╝"
""
]

CheatsOn <- false

// Add names to coop ending credits
MPMCoopCreditNames <- [
"### ",
"### ",
"### ",
"### ",
"###Portal 2 Multiplayer Mod: Credits",
"### ",
"###--------------------------",
"###Multiplayer Mod: Team",
"###--------------------------",
"kyleraykbs | Scripting + Reverse Engineering",
"Vista | Reverse Engineering, Plugin Dev",
"Bumpy | Script Theory",
<<<<<<< HEAD:MultiplayerModFiles/ModFiles/Portal 2/install_dlc/scripts/vscripts/multiplayermod/variables.nut
"Wolƒe Strider Shoσter | Scripting + Singleplayer Support",
"Nanoman2525 | Mapping + Entity Work + Launcher",
"###--------------------------",
"###P2:MM Team Members",
"###--------------------------",
"cabiste | Scripting + Mod Launcher + Code Refactor",
"sear | Theorycrafting + Ideas",
"Jeffrey | Ideas",
=======
"Wolƒe Strider Shoσter | Scripting + Script Theory",
"Nanoman2525 | Mapping + Entity and Command Help",
>>>>>>> parent of a24f870 (corrected one word and fixed credits):MultiplayerModFiles/ModFiles/Portal 2/install_dlc/scripts/vscripts/multiplayermod/varibles.nut
"###--------------------------",
"###Multiplayer Mod: Contributers",
"###--------------------------",
"Darnias | Jumpstarter Code",
"actu | Remote File Downloads",
"Blub/Vecc | Code Cleanup + Commenting",
"AngelPuzzle | Translations for other langauges",
"SuperSpeed | Heavy playtesting",
"###--------------------------",
"###Special thanks to...",
"###--------------------------",
"Dreadnox",
"Slingexe",
"nintendude",
"Souper Marilogi",
"wol",
"###--------------------------",
"###Valve: Credits",
"###--------------------------",
]