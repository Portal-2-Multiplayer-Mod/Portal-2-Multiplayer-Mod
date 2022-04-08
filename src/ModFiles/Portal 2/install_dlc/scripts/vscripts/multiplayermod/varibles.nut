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
TickSpeed <- 0.00 // now depricated just for legacy
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
CurrentPythonOutputID <- 0
CurrentPythonInputID <- 0

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

// Add names to credits
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
"Wolƒe Strider Shoσter | Scripting + Script Theory",
"Nanoman2525 | Mapping + Entity and Command Help",
"###--------------------------",
"###Multiplayer Mod: Contributers",
"###--------------------------",
"cabiste | Code Cleanup / Refactoring",
"Darnias | Jumpstarter Code",
"Mellow | stole all of Python"
"The Pineapple | (outdated) Hamachi support",
"actu | Remote File Downloads",
"Blub/Vecc | Code Cleanup + Commenting",
"AngelPuzzle | Translations",
"SuperSpeed | spedran da test",
"###--------------------------",
"###Multiplayer Mod: Beta Testers",
"###--------------------------",
"sear",
"Dreadnox",
"SuperSpeed",
"Trico_Everfire",
"Brawler",
"iambread",
"hulkstar",
"neck",
"brawler",
"Sheuron",
"portalboy",
"charity",
"Souper Marilogi",
"fluffys",
"JDWMGB",
"ALIEN GOD",
"mono",
"mp_emerald",
"Funky Kong",
"MicrosoftWindows",
"dactam",
"wol",
"kitsune",
"###--------------------------",
"###Thank you all so so much!!!",
"###--------------------------"
"### ",
"### ",
"###--------------------------",
"###Valve: Credits",
"###--------------------------",
]