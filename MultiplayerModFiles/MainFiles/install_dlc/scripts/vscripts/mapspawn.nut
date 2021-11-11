//--------------------------------------------------------------------------------------------------------------------------------------//
//                                                             COPYRIGHT                                                                //
//                                                  © 2021 Portal 2: Multiplayer Mod                                                    //
//                                 https://github.com/kyleraykbs/Portal2-32PlayerMod/blob/main/LICENSE                                  //
// (in the case that file does not exist, or doenst exist in the repo this project will fall under a GNU LESSER GENERAL PUBLIC LICENSE) //
//--------------------------------------------------------------------------------------------------------------------------------------//

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
UsePlugin <- false // Set to true if you want to use the plugin (LINUX ONLY)
//-----------------------------------
DedicatedServer <- false // Set to true if you want to run the server as a dedicated server (INDEV)
//-----------------------------------
RandomTurretModels <- false // Set to true if you want to randomize the turret models (INDEV)
//-----------------------------------
TickSpeed <- 0.2 // Set to the tick speed of the server (UNSTABLE - ONLY DO 0.01 TO 0.5) (lower numbers can cause lag on slow computers/connections)
//-----------------------------------


//  ██████  ██████  ██████  ███████
// ██      ██    ██ ██   ██ ██
// ██      ██    ██ ██   ██ █████
// ██      ██    ██ ██   ██ ██
//  ██████  ██████  ██████  ███████

// █▀ █▀▀ ▀█▀ █░█ █▀█   █░█ ▄▀█ █▀█ █ █▄▄ █░░ █▀▀ █▀
// ▄█ ██▄ ░█░ █▄█ █▀▀   ▀▄▀ █▀█ █▀▄ █ █▄█ █▄▄ ██▄ ▄█

PreviousTimeDeath <- 0
HasRanGeneralOneTime <- true
tick <- 0
BundgeeHookID <- "none"
BundgeeHookMessage <- "none"
OrangeCacheFailed <- false
CanClearCache <- false
DoneCacheing <- false
CachedModels <- []
IsInSpawnZone <- []
HasSpawned <- false
PlayerColorCached <- []
CurrentlyDead <- []
PlayerID <- 0
GBIsMultiplayer <- 0
cacheoriginalplayerposition <- 0
DoneWaiting <- false
IsSingleplayerMap <- false
LoadPlugin <- false
RunPluginLoad <- false
PluginLoaded <- false
PreviousTime1Sec <- 0
if (UsePlugin==true) {
    LoadPlugin <- true
}

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

foreach (line in ConsoleAscii) {
    printl(line)
}

// Add names to credits
MPMCoopCreditNames <- [
"",
"",
"",
"",
"Portal 2 Multiplayer Mod: Credits",
"",
"--------------------------",
"Multiplayer Mod: Team",
"--------------------------",
"kyleraykbs | Scripting + Team Lead + Reverse Engineering",
"Vista | Reverse Engineering, Plugin Dev",
"Bumpy | Script Theory",
"Wolƒe Strider Shoσter | Scripting + Script Theory",
"Enator18 | Python"
"Nanoman2525 | Mapping + Entity and Command Help",
"--------------------------",
"Multiplayer Mod: Contributers",
"--------------------------",
"Darnias | Jumpstarter Code",
"Mellow | stole all of Python"
"The Pineapple | Hamachi support",
"actu | Remote File Downloads",
"Blub/Vecc | Code Cleanup + Commenting",
"AngelPuzzle | Translations",
"SuperSpeed | spedrun da test",
"--------------------------",
"Multiplayer Mod: Beta Testers",
"--------------------------",
"sear",
"Trico_Everfire",
"Brawler",
"iambread",
"hulkstar",
"neck",
"soulfur",
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
"--------------------------",
"Thank you all so so much!!!",
"--------------------------"
"",
"",
"--------------------------",
"Valve: Credits",
"--------------------------",
]

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// █ █▄░█ █ ▀█▀
// █ █░▀█ █ ░█░

function init() {

    // Run singleplayer code
    if (GetMapName().slice(0, 7) != "mp_coop") {
        IsSingleplayerMap <- true
        MapSupport(true, false, false, false, false, false, false)
    }

    // Create an entity to display player color at the bottom left of every clients' screen
    colordisplay <- Entities.CreateByClassname("game_text")
        // Set the entity's targetname to colordisplay + player's index
    colordisplay.__KeyValueFromString("targetname", "colordisplay" + PlayerID)
        // Set the entity's origin to the bottom left of the screen
    colordisplay.__KeyValueFromString("x", "0")
    colordisplay.__KeyValueFromString("y", "1")
        // Set the entity's holdtime to infinity
    colordisplay.__KeyValueFromString("holdtime", "100000")
        // Set the fade time to none
    colordisplay.__KeyValueFromString("fadeout", "0")
    colordisplay.__KeyValueFromString("fadein", "0")
        // Set the channel to top
    colordisplay.__KeyValueFromString("channel", "0")

    // Create an on screen text message entity
    onscreendisplay <- Entities.CreateByClassname("game_text")
    onscreendisplay.__KeyValueFromString("targetname", "onscreendisplaympmod")
    onscreendisplay.__KeyValueFromString("message", "Waiting for players...")
    onscreendisplay.__KeyValueFromString("holdtime", (TickSpeed * 2).tostring())
    onscreendisplay.__KeyValueFromString("fadeout", (TickSpeed * 2).tostring())
    onscreendisplay.__KeyValueFromString("fadein", (TickSpeed * 2).tostring())
    onscreendisplay.__KeyValueFromString("spawnflags", "1")
    onscreendisplay.__KeyValueFromString("color", "60 200 60")
    onscreendisplay.__KeyValueFromString("channel", "1")
    //onscreendisplay.__KeyValueFromString("x", "-1.1")
    //onscreendisplay.__KeyValueFromString("y", "-1.1")

    // Create a join message entity
    joinmessagedisplay <- Entities.CreateByClassname("game_text")
    joinmessagedisplay.__KeyValueFromString("targetname", "joinmessagedisplaympmod")
    joinmessagedisplay.__KeyValueFromString("holdtime", "3")
    joinmessagedisplay.__KeyValueFromString("fadeout", "0.2")
    joinmessagedisplay.__KeyValueFromString("fadein", "0.2")
    joinmessagedisplay.__KeyValueFromString("spawnflags", "1")
    joinmessagedisplay.__KeyValueFromString("color", "255 200 0")
    joinmessagedisplay.__KeyValueFromString("channel", "3")
    //joinmessagedisplay.__KeyValueFromString("x", "0.1")
    //joinmessagedisplay.__KeyValueFromString("y", "0.1")

    // Create entity to run loop() every 0.1 seconds
    timer <- Entities.CreateByClassname("logic_timer")
    timer.__KeyValueFromString("targetname", "timer")
    EntFireByHandle(timer, "AddOutput", "RefireTime " + TickSpeed, 0, null, null)
    EntFireByHandle(timer, "AddOutput", "classname move_rope", 0, null, null)
    EntFireByHandle(timer, "AddOutput", "OnTimer worldspawn:RunScriptCode:loop():0:-1", 0, null, null)
    EntFireByHandle(timer, "Enable", "", 0.1, null, null)

    // Create an entity that sends a client command
    clientcommand <- Entities.CreateByClassname("point_clientcommand")

    // Load plugin
    if (LoadPlugin==true) {
        if("GetPlayerName" in this) {
            printl("=================================")
            printl("Plugin already loaded skipping...")
            printl("=================================")
            PluginLoaded <- true
        } else {
            printl("============================")
            printl("Plugin not loaded loading...")
            printl("============================")
            pluginloadcommand <- Entities.CreateByClassname("point_servercommand")
            RunPluginLoad <- true
            // SendToConsole("plugin_load pl")
        }
    }

    // Run instant map code
    AllMapsCode(false, false, false, true)
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// █▀▀ █░░ █▀█ █▄▄ ▄▀█ █░░   █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ █▀
// █▄█ █▄▄ █▄█ █▄█ █▀█ █▄▄   █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ ▄█

function CreateTrigger(x1, y1, z1, x2, y2, z2){
	if(DevMode == true){
		DebugDrawBox(Vector(x1, y1, z1), Vector(0, 0, 0), Vector(x2-x1, y2-y1, z2-z1), 255, 100, 8, 20, TickSpeed*1.17);
	}

    local TransitionVarible = 0
    if (x1 >= x2) {
        TransitionVarible = x2
        x2 = x1
        x1 = TransitionVarible
    }

    local TransitionVarible = 0
    if (y1 >= y2) {
        TransitionVarible = y2
        y2 = y1
        y1 = TransitionVarible
    }

    local TransitionVarible = 0
    if (z1 >= z2) {
        TransitionVarible = z2
        z2 = z1
        z1 = TransitionVarible
    }

    local plist = []
    local p = null
    local outputp = null
    while (p = Entities.FindByClassname(p, "player")) {
        local pos = p.GetOrigin()
        if (pos.x >= x1 && pos.x <= x2){
            if (pos.y >= y1 && pos.y <= y2){
                if (pos.z >= z1 && pos.z <= z2){
                    plist.push(p)
                }
            }
        }
    }
    return plist
}

function FindAndReplace(inputstr, findstr, replacestr) {
    local startstrip = inputstr.find(findstr)
    if (startstrip==null) {
        return inputstr
    }
    local endstrip = startstrip + findstr.len()

    local newstr = inputstr.slice(0, startstrip) + replacestr + inputstr.slice(endstrip, inputstr.len())
    return newstr
}

function UnNegative(num) {
    if (num <= 0) {
        num = num * -1
    }
    return num

// Teleport players within a distance
function TeleportPlayerWithinDistance(SearchPos, SearchDis, TeleportDest) {
    local ent = null
    while(ent = Entities.FindByClassnameWithin(ent, "player", SearchPos, SearchDis)) {
        ent.SetOrigin(TeleportDest)
    }
}

function PlayerWithinDistance(SearchPos, SearchDis) {
    local ent = null
    while(ent = Entities.FindByClassnameWithin(ent, "player", SearchPos, SearchDis)) {
        return ent
    }
}

function TriggerOnceHook(TriggerName, FunctionName) {

}

function CacheModel(ModelName) {
    if (Entities.FindByModel(null, "models/"+ModelName)) {
            printl("Model: " + ModelName + " is already cached!")
        } else {
        try {
            if (servercommand) {
                printl("servercommand exists")
            }
        } catch(exception) {
            // Create an entity that sends a server command
            servercommand <- Entities.CreateByClassname("point_servercommand")
        }
        EntFireByHandle(servercommand, "command", "hud_saytext_time 0", 0, null, null)
        EntFireByHandle(servercommand, "command", "sv_cheats 1", 0, null, null)
        EntFireByHandle(servercommand, "command", "prop_dynamic_create " + ModelName, 0, null, null)
        EntFireByHandle(servercommand, "command", "sv_cheats 0", 0, null, null)
        CachedModels.push("models/"+ModelName)

        printl("Model: " + ModelName + " has been cached sucessfully!")
    }
}

// Find player by index

function FindByIndex(id)  {
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        if (ent.entindex()==id) {
            return ent
        }
    }
}

//-----------------------------------
// Multiplayer support code
//-----------------------------------

// Set GBIsMultiplayer if game is multiplayer
try {
    if (::IsMultiplayer()) {
        GBIsMultiplayer <- 1
    }
} catch(exception) {
    GBIsMultiplayer <- 0
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//------------------------------------------------------//
// ░█▀▄▀█ ─█▀▀█ ▀█▀ ░█▄─░█    ░█─── ░█▀▀▀█ ░█▀▀▀█ ░█▀▀█ //
// ░█░█░█ ░█▄▄█ ░█─ ░█░█░█    ░█─── ░█──░█ ░█──░█ ░█▄▄█ //
// ░█──░█ ░█─░█ ▄█▄ ░█──▀█    ░█▄▄█ ░█▄▄▄█ ░█▄▄▄█ ░█─── //
//------------------------------------------------------//

    function loop() {

        //Count Ticks
        tick <- tick + 1

        // Run player join code when a player joins
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            if (p.ValidateScriptScope()) {
                local script_scope = p.GetScriptScope()
                // If player hasn't joined yet / hasn't been spawned / colored yet
                if (!("Colored" in script_scope)) {
                    // Run player join code
                    OnPlayerJoin(p, script_scope)
                }
            }
        }

        AllMapsCode(true, false, false, false) // Run map loops

        CreatePropsForLevel(false, false, true) // Create the gmod generated props in the level

        // Cache original spawn position
        if (cacheoriginalplayerposition == 0 && Entities.FindByClassname(null, "player")) {
            // OldPlayerPos = the blues inital spawn position
            OldPlayerPos <- Entities.FindByName(null, "blue").GetOrigin()
            OldPlayerAngles <- Entities.FindByName(null, "blue").GetAngles()
            cacheoriginalplayerposition <- 1
        }

        // Detect death
        local progress = true
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            // If player is dead
            if (p.GetHealth() == 0) {
                // Put dead players in the dead players array
                foreach (player in CurrentlyDead) {
                    if (player == p) {
                        progress = false
                    }
                }
                if (progress == true) {
                    CurrentlyDead.push(p)
                    OnPlayerDeath(p)
                }
            }
        }

        // Display waiting for players until player exits spawn zone
        try {
            if (HasRanGeneralOneTime == true) {
                if (Entities.FindByName(null, "HasSpawnedMPMod")) {
                    GeneralOneTime()
                    HasRanGeneralOneTime <- false
                }
            }
            if (DoneWaiting == false) {
                // Check if client is in spawn zone
                if (Entities.FindByName(null, "blue").GetVelocity().z == 0) {
                    DoEntFire("onscreendisplaympmod", "display", "", 0.0, null, null)
                } else {
                    DoneWaiting <- true
                    Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "HasSpawnedPreMPMod")
                    EntFire("HasSpawnedPreMPMod", "addoutput", "targetname HasSpawnedMPMod", 1, null)
                }
            }
        } catch(exception) {}

        // Delete all cached models
        if (DoneCacheing==true) {
            // If model has cached successfully delete it from the level
            foreach (index, CustomGameModel in CachedModels)  {
                // Find all entities with the model name
                local ent = null
                while (ent = Entities.FindByModel(ent, CustomGameModel)) {
                    try {
                        // If it's a prop_dynamic_create entity delete it
                    if (ent.GetName().slice(0, 17)!="genericcustomprop") {
                        ent.Destroy()
                    }
                    } catch(exception) {
                        ent.Destroy()
                    }
                }
            }
        }
        if (CanClearCache==true) {
            foreach (index, CustomGameModel in CachedModels)  {
                CachedModels.remove(index)
            }
        }

        // Disconnect player if trying to play singleplayer
        if (GBIsMultiplayer==0) {
            SendToConsole("disconnect \"You cannot play singleplayer when Portal 2 is launched from the Multiplayer Mod Launcher. Please restart the game from Steam\"")
        }

        // Singleplayer loop
        if (GetMapName().slice(0, 7) != "mp_coop") {
            MapSupport(false, true, false, false, false, false, false)
        }

        if (DevMode==true) {}

        /////////////////////////
        // RUN ON EVERY SECOND //
        /////////////////////////

        if (Time() >= PreviousTime1Sec + 1) {
        PreviousTime1Sec <- Time()

        // Detect respawn
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            if (p.GetHealth() >= 1) {
                // Get the players from the dead players array
                foreach (index, player in CurrentlyDead) {
                    if (player == p) {
                        CurrentlyDead.remove(index)
                        OnPlayerRespawn(p)
                    }
                }
            }
        }

        // Remove Player Collision
        EntFire("player", "addoutput", "CollisionGroup 2")
        }

        // Change Dev Mode
        if (GetDeveloperLevel() == 0) {
            DevMode <- false
        } else {
            DevMode <- true
        }
    }

//---------------------------------------------------------------//
// ░█▀▀▀ ░█▄─░█ ░█▀▀▄   ░█▀▀▀█ ░█▀▀▀   ░█─── ░█▀▀▀█ ░█▀▀▀█ ░█▀▀█ //
// ░█▀▀▀ ░█░█░█ ░█─░█   ░█──░█ ░█▀▀▀   ░█─── ░█──░█ ░█──░█ ░█▄▄█ //
// ░█▄▄▄ ░█──▀█ ░█▄▄▀   ░█▄▄▄█ ░█───   ░█▄▄█ ░█▄▄▄█ ░█▄▄▄█ ░█─── //
//---------------------------------------------------------------//

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// █░█ █▀█ █▀█ █▄▀   █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ █▀
// █▀█ █▄█ █▄█ █░█   █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ ▄█

//////////////////////////////
// Runs when a player joins //
//////////////////////////////

function OnPlayerJoin(p, script_scope) {
// Get player's index and store it
PlayerID <- p.GetRootMoveParent()
PlayerID <- PlayerID.entindex()

// // Set viewmodel targetnames so we can tell them apart
// local ent = null
// while (ent=Entities.FindByClassname(ent, "predicted_viewmodel")) {
//     EntFireByHandle(ent, "addoutput", "targetname viewmodel_player" + ent.GetRootMoveParent().entindex(), 0, null, null)
//     printl("Renamed predicted_viewmodel to viewmodel_player" + ent.GetRootMoveParent().entindex())
//     // printl("" + ent.GetRootMoveParent().entindex() + " rotation " + ent.GetAngles())
//     // printl("" + ent.GetRootMoveParent().entindex() + "    origin " + ent.GetOrigin())
// }

// Set cvars on joining players' client
SendToConsole("sv_timeout 3")
SendToConsole("gameinstructor_enable 1")
EntFireByHandle(clientcommand, "Command", "gameinstructor_enable 1", 0, p, p)
EntFireByHandle(clientcommand, "Command", "stopvideos", 0, p, p)
EntFireByHandle(clientcommand, "Command", "r_portal_fastpath 0", 0, p, p)
EntFireByHandle(clientcommand, "Command", "r_portal_use_pvs_optimization 0", 0, p, p)
MapSupport(false, false, false, false, true, false, false)

// Say join message on HUD
if (PluginLoaded==true) {
    JoinMessage <- GetPlayerName(PlayerID) + " joined the game"
} else {
    JoinMessage <- "Player " + PlayerID + " joined the game"
}
// Set join message to player name
JoinMessage = JoinMessage.tostring()
joinmessagedisplay.__KeyValueFromString("message", JoinMessage)
EntFireByHandle(joinmessagedisplay, "display", "", 0.0, null, null)
if (PlayerID >= 2) {
    onscreendisplay.__KeyValueFromString("y", "0.075")
    // EntFireByHandle(clientcommand, "Command", "disconnect #Valve_Reject_Server_Full", 0, p, p)
}
// Assign every new targetname to the player after blue and red are used
if (PlayerID >= 3) {
    p.__KeyValueFromString("targetname", "player" + PlayerID)
}

// Set a random color for clients that join after 16 have joined
if (PlayerID != 1) {
    R <- RandomInt(0, 255), G <- RandomInt(0, 255), B <- RandomInt(0, 255)
}

// Set preset colors for up to 16 clients
switch (PlayerID) {
    case 1 : R <- 255; G <- 255; B <- 255; break;
    case 2 : R <- 180, G <- 255, B <- 180; break;
    case 3 : R <- 120, G <- 140, B <- 255; break;
    case 4 : R <- 255, G <- 170, B <- 120; break;
    case 5 : R <- 255, G <- 100, B <- 100; break;
    case 6 : R <- 255, G <- 180, B <- 255; break;
    case 7 : R <- 255, G <- 255, B <- 180; break;
    case 8 : R <-   0, G <- 255, B <- 240; break;
    case 9 : R <-  75, G <-  75, B <-  75; break;
    case 10: R <- 100, G <-  80, B <-   0; break;
    case 11: R <-   0, G <-  80, B <- 100; break;
    case 12: R <- 120, G <- 155, B <-  25; break;
    case 13: R <-   0, G <-   0, B <- 100; break;
    case 14: R <-  80, G <-   0, B <-   0; break;
    case 15: R <-   0, G <-  75, B <-   0; break;
    case 16: R <-   0, G <-  75, B <-  75; break;
}

// Set color of player's in-game model
script_scope.Colored <- true
EntFireByHandle(p, "Color", (R + " " + G + " " + B), 0, null, null)

// Run general map code after a player loads into the game
if (PlayerID == 1) {
    PostMapLoad()
}

// If the player is the first player to join, Fix OrangeOldPlayerPos
if (p.GetTeam() == 2) {
    if (OrangeCacheFailed==true) {
        OrangeOldPlayerPos <- p.GetOrigin()
        OrangeCacheFailed <- false
    }
}

// Print the players' team
printl("Player: " + PlayerID + " is on team " + p.GetTeam())

return
}

//////////////////////
// RUNS AFTER DEATH //
//////////////////////

function OnPlayerDeath(player) {
    printl("Player Death")
    MapSupport(false, false, false, false, false, player, false)
}

////////////////////////
// RUNS AFTER RESPAWN //
////////////////////////

function OnPlayerRespawn(player) {
    printl("Player Respawn")
    MapSupport(false, false, false, false, false, false, player)
}

/////////////////////////////////////
// POST MAP LOADING FUNCTIONS HERE //
/////////////////////////////////////

function PostMapLoad() {
    MapSupport(false, false, false, true, false, false, false)
    AllMapsCode(false, false, true, false)
    // Enable fast download
    SendToConsole("sv_downloadurl \"https://github.com/kyleraykbs/Portal2-32PlayerMod/raw/main/WebFiles/FastDL/portal2/\"")
    SendToConsole("sv_allowdownload 1")
    SendToConsole("sv_allowupload 1")
    SendToConsole("max_filesize 0")
    if (DevMode==true) {
        SendToConsole("developer 1")
    }
}

/////////////////////////////////////
// Runs once on first global spawn //
/////////////////////////////////////

function GeneralOneTime() {

    if (RunPluginLoad==true) {
        printl("Loading plugin... Restarting map")
        // Load plugin
        EntFireByHandle(pluginloadcommand, "Command", "plugin_load pl", 0, null, null)
        // Wait for plugin to load and then restart map
        EntFireByHandle(pluginloadcommand, "Command", "changelevel mp_coop_lobby_3", 0, null, null)
        LoadPlugin <- false
    }

    CanClearCache <- true

    HasSpawned <- true

    SendToConsole("hud_saytext_time 12")

    // Cache orange players original position
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        if (p.GetTeam()==2) {
            OrangeOldPlayerPos <- p.GetOrigin()
        }
    }
    try {
        if (OrangeOldPlayerPos) { }
    } catch(exeption) {
        printl("OrangeOldPlayerPos not set (Blue probably moved before Orange could load in) Setting OrangeOldPlayerPos to BlueOldPlayerPos")
        OrangeOldPlayerPos <- OldPlayerPos
        OrangeCacheFailed <- true
    }

    // Force open the blue player droppers
    try {
        local ent = null
        while(ent = Entities.FindByClassnameWithin(ent, "prop_dynamic", Vector(OldPlayerPos.x, OldPlayerPos.y, OldPlayerPos.z-300), 100)) {
            if (ent.GetModelName() == "models/props_underground/underground_boxdropper.mdl" || ent.GetModelName() == "models/props_backstage/item_dropper.mdl") {
                EntFireByHandle(ent, "setanimation", "open", 0, null, null)
                if (ent.GetModelName() == "models/props_backstage/item_dropper.mdl") {
                    EntFireByHandle(ent, "setanimation", "item_dropper_open", 0, null, null)
                }
                ent.__KeyValueFromString("targetname", "BlueDropperForcedOpenMPMOD")
            }
        }
    } catch(exeption) {
        printl("Blue dropper not found")
    }

    // Force open the orange player droppers
    try {
        radius <- 100

        if (OrangeCacheFailed==true) {
            radius <- 350
        }

        local ent = null
        while(ent = Entities.FindByClassnameWithin(ent, "prop_dynamic", Vector(OrangeOldPlayerPos.x, OrangeOldPlayerPos.y, OrangeOldPlayerPos.z-300), radius)) {
            if (ent.GetModelName() == "models/props_underground/underground_boxdropper.mdl" || ent.GetModelName() == "models/props_backstage/item_dropper.mdl") {
                EntFireByHandle(ent, "setanimation", "open", 0, null, null)
                if (ent.GetModelName() == "models/props_backstage/item_dropper.mdl") {
                    EntFireByHandle(ent, "setanimation", "item_dropper_open", 0, null, null)
                }
                EntFireByHandle(ent, "setanimation", "item_dropper_open", 0, null, null)
                ent.__KeyValueFromString("targetname", "OrangeDropperForcedOpenMPMOD")
            }
        }
    } catch(exeption) {
        printl("Orange dropper not found")
    }
    radius <- null

    // Create props after cache
    CreatePropsForLevel(false, true, false)

    AllMapsCode(false, true, false, false)

    MapSupport(false, false, true, false, false, false, false)
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// █▀▄▀█ ▄▀█ █▀█   █▀ █░█ █▀█ █▀█ █▀█ █▀█ ▀█▀
// █░▀░█ █▀█ █▀▀   ▄█ █▄█ █▀▀ █▀▀ █▄█ █▀▄ ░█░

// Run all required map code
function AllMapsCode(AMCLoop, AMCPostPlayerSpawn, AMCPostInit, AMCInstantRun) {


    /////////////////
    // INSTANT RUN //
    /////////////////


    if (AMCInstantRun == true) {
        //## GELOCITY 1 INSTANT RUN ##//
        try {
            if (GetMapName().slice(28, 50) == "mp_coop_gelocity_1_v02") {
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "door_start_2_2"))
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "door_start_2_1"))
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "door_start_1_2"))
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "door_start_1_1"))
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "door_start"))
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "red_dropper-door_eixt"))
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "blue_dropper-item_door"))

                local ent = null
                while(ent = Entities.FindByClassname(ent, "func_portal_bumper")) {
                    ent.Destroy() // 20 entities removed
                }

                while(ent = Entities.FindByClassname(ent, "beam_spotlight")) {
                    ent.Destroy() // 85 entities removed
                }
            }
        } catch(exeption) { }

        //## GELOCITY 2 INSTANT RUN##//
        try {
            if (GetMapName().slice(28, 50) == "mp_coop_gelocity_2_v01") {
                // Set the Gelocity 2 map
                local ent = null
                while(ent = Entities.FindByClassname(ent, "func_portal_bumper")) {
                    ent.Destroy() // 20 entities removed
                }

                while(ent = Entities.FindByClassname(ent, "beam_spotlight")) {
                    ent.Destroy() // 85 entities removed
                }

                while(ent = Entities.FindByClassname(ent, "env_glow")) {
                    ent.Destroy() // 85 entities removed
                }

                while(ent = Entities.FindByClassname(ent, "light_spot")) {
                    ent.Destroy() // 85 entities removed
                }

                while(ent = Entities.FindByClassname(ent, "keyframe_rope")) {
                    ent.Destroy() // 85 entities removed
                }

                while(ent = Entities.FindByClassname(ent, "move_rope")) {
                    ent.Destroy() // 85 entities removed
                }

                while(ent = Entities.FindByClassname(ent, "info_overlay")) {
                    ent.Destroy() // 85 entities removed
                }
            }
        } catch(exeption) { }

        //## GELOCITY 3 INSTANT RUN ##//
        try {
            if (GetMapName().slice(28, 50) == "mp_coop_gelocity_3_v02") {
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "door_start_2_2"))
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "door_start_2_1"))
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "door_start_1_2"))
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "door_start_1_1"))
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "door_start"))
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "red_dropper-door_eixt"))
                DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "blue_dropper-item_door"))


                local ent = null
                while(ent = Entities.FindByClassname(ent, "func_portal_bumper")) {
                    ent.Destroy() // 20 entities removed
                }

                while(ent = Entities.FindByClassname(ent, "beam_spotlight")) {
                    ent.Destroy() // 85 entities removed
                }
            }
         } catch(exeption) { }

        //## MP_COOP_CREDITS INSTANT RUN ##//
        if (GetMapName() == "mp_coop_credits") {
            // Remove selected pods
            function CreditsRemovePod() {
                try {
                    local ent = null
                    while (ent = Entities.FindByNameNearest("chamber*", Vector(-64, 217, 72), 100)) {
                        ent.Destroy()
                    }
                } catch(exeption) { }

                try {
                    while (ent = Entities.FindByNameNearest("bubbles*", Vector(-64, 217, 72), 100)) {
                        ent.Destroy()
                    }
                } catch(exeption) { }
            }
        }

        // Fix void camera glitch
        function FixCreditsCameras() {
            // Disable useless cameras
            EntFireByHandle(Entities.FindByName(null, "camera_SP"), "disable", "", 0, null, null)
            EntFireByHandle(Entities.FindByName(null, "camera_O"), "disable", "", 0, null, null)

            // Reload main camera with new params
            Entities.FindByName(null, "camera").__KeyValueFromString("target_team", "-1")
            EntFireByHandle(Entities.FindByName(null, "camera"), "disable", "", 0, null, null)
            EntFireByHandle(Entities.FindByName(null, "camera"), "enable", "", 0, null, null)
        }

        // Replace females with P-bodys
        function CreditsSetModelPB(ent) {
            FixCreditsCameras()

            // Count how many credits come on screen to change to humans
            MPMCredits <- MPMCredits + 1

            // Preset animation
            local RandomAnimation = RandomInt(0, CRAnimationTypesPB)

            // Remove pod if needed
            HasRemovedPod <- 0
            foreach (anim in NOTubeAnimsPB) {
                if (AnimationsPB[RandomAnimation] == anim && HasRemovedPod == 0) {
                    HasRemovedPod <- 1
                    CreditsRemovePod()
                }
            }

            // Set model
            ent.SetModel("models/player/eggbot/eggbot.mdl")

            // Set color
            EntFireByHandle(ent, "Color", (RandomInt(0, 255) + " " + RandomInt(0, 255) + " " + RandomInt(0, 255)), 0, null, null)

            // Set position
            ent.SetOrigin(Vector(0, 0, 7.5))

            // Set animation
            EntFireByHandle(ent, "setanimation", AnimationsPB[RandomAnimation], 0, null, null)
        }

        // Replace males with Atlases
        function CreditsSetModelAL(ent) {
            FixCreditsCameras()

            // Count how many credits come on screen to change to humans
            MPMCredits <- MPMCredits + 1

            // Preset animation
            local RandomAnimation = RandomInt(0, CRAnimationTypesAL)

            // Set model
            ent.SetModel("models/player/ballbot/ballbot.mdl")

            // Set color
            EntFireByHandle(ent, "Color", (RandomInt(0, 255) + " " + RandomInt(0, 255) + " " + RandomInt(0, 255)), 0, null, null)

            // Set position
            ent.SetOrigin(Vector(-10, 0, 25.5))

            // Set animation
            EntFireByHandle(ent, "setanimation", AnimationsAL[RandomAnimation], 0, null, null)

            // Remove pod if needed
            HasRemovedPod <- 0
            foreach (anim in NOTubeAnimsAL) {
                if (AnimationsAL[RandomAnimation] == anim && HasRemovedPod == 0) {
                    HasRemovedPod <- 1
                    CreditsRemovePod()
                    ent.SetOrigin(Vector(0, 0, 7.5))
                }
            }
        }

        // Set credits animations
            // P-body animations
            AnimationsPB <- ["taunt_laugh", "taunt_teamhug_idle", "noGun_crouch_idle", "taunt_face_palm", "taunt_selfspin", "taunt_pretzelwave", "noGun_airwalk", "noGun_airwalk", "portalgun_drowning", "layer_taunt_noGun_small_wave", "taunt_highFive_idle"]

            // Atlas animations
            AnimationsAL <- ["taunt_laugh", "taunt_laugh", "taunt_teamhug_initiate", "taunt_teamhug_noShow", "ballbot_taunt_rps_shake", "taunt_basketball2", "taunt_headspin", "taunt_facepalm", "taunt_shrug", "layer_taunt_trickfire_handstand", "portalgun_jump_spring", "portalgun_thrash_fall", "noGun_crouch_idle", "noGun_airwalk", "noGun_airwalk"]

            // P-body animations out of tube
            NOTubeAnimsPB <- ["taunt_laugh", "taunt_teamhug_idle", "noGun_crouch_idle", "taunt_face_palm", "taunt_selfspin", "taunt_pretzelwave", "layer_taunt_noGun_small_wave", "taunt_highFive_idle"]

            // Atlas animations out of tube
            NOTubeAnimsAL <- ["taunt_laugh", "taunt_laugh", "taunt_teamhug_initiate", "taunt_teamhug_noShow", "ballbot_taunt_rps_shake", "taunt_basketball2", "taunt_headspin", "taunt_facepalm", "taunt_shrug", "layer_taunt_trickfire_handstand", "noGun_crouch_idle"]

            // Credit run counter
            MPMCredits <- 0

            // Set the amount of P-body animations
            CRAnimationTypesPB <- -1
            foreach (value in AnimationsPB) {
                CRAnimationTypesPB <- CRAnimationTypesPB + 1
            }

            // Set the amount of Atlas animations
            CRAnimationTypesAL <- -1
            foreach (value in AnimationsAL) {
                CRAnimationTypesAL <- CRAnimationTypesAL + 1
            }

            // Set the amount of credits
            MPModCreditNumber <- -1
            foreach (value in MPMCoopCreditNames) {
                MPModCreditNumber <- MPModCreditNumber + 1
            }

            // Mount list of credits to credits
            foreach (Name in MPMCoopCreditNames) {
                AddCoopCreditsName(Name)
            }

        //## MP_COOP_PAINT_CONVERSION INSTANT RUN ##//
        if (GetMapName() == "mp_coop_paint_conversion") {
            Entities.FindByName(null, "disassembler_1_door_blocker").Destroy()
            Entities.FindByName(null, "disassembler_2_door_blocker").Destroy()

            Entities.FindByName(null, "disassembler_1_door_2").Destroy()
            Entities.FindByName(null, "disassembler_1_door_1").Destroy()

            Entities.FindByName(null, "disassembler_2_door_2").Destroy()
            Entities.FindByName(null, "disassembler_2_door_1").Destroy()
        }

        //## MP_COOP_TRIPLEAXIS INSTANT RUN ##//
        if (GetMapName() == "mp_coop_tripleaxis") {
            Entities.FindByName(null, "outro_math_counter").Destroy()
        }

        //## MP_COOP_SEPARATION_1 INSTANT RUN ##//
        if (GetMapName() == "mp_coop_separation_1") {
            EntFireByHandle(Entities.FindByName(null, "left_1st_room_spawn-initial_blue_spawn"), "SetAsActiveSpawn", "", 0, null, null)
            EntFireByHandle(Entities.FindByName(null, "right_1st_room_spawn-initial_orange_spawn"), "SetAsActiveSpawn", "", 0, null, null)
            Entities.FindByName(null, "split_counter").Destroy()
        }
    }


    ///////////
    // LOOPS //
    ///////////


    if(AMCLoop == true) {
        if (GetMapName() == "mp_coop_lobby_3") {
            local PLent = null
            while(PLent = Entities.FindByClassnameWithin(PLent, "player", Vector(2367, -8126, -54), 30)) {
                local APLent = null
                while(APLent = Entities.FindByClassname(APLent, "player")) {
                    APLent.SetOrigin(Vector(2495, -7451, 410))
                }
            }

            // Art therapy left chute enabler
            local vectorEEL
            vectorEEL = Vector(5727, 3336, -441)
            local EELent = null
            while(EELent = Entities.FindByClassnameWithin(EELent, "player", vectorEEL, 12)) {
                local LCatEn = null
                while(LCatEn = Entities.FindByName(LCatEn, "left-enable_cats")) {
                    DoEntFire("!self", "enable", "", 0.0, null, LCatEn)
                    DoEntFire("!self", "trigger", "", 0.0, null, LCatEn)
                }
            }

            // Art therapy left chute teleporter
            TeleportPlayerWithinDistance(Vector(5729, 3336, 1005), 30, Vector(3194, -1069, 1676))

            // Art therapy right chute enabler
            local vectorEER
            vectorEER = Vector(5727, 3192, -441)
            local EERent = null
            while(EERent = Entities.FindByClassnameWithin(EERent, "player", vectorEER, 12)) {
                local RCatEn = null
                while(RCatEn = Entities.FindByName(RCatEn, "right-enable_cats")) {
                    DoEntFire("!self", "enable", "", 0.0, null, RCatEn)
                    DoEntFire("!self", "trigger", "", 0.0, null, RCatEn)
                }
            }

            // Art therapy right chute teleporter
            TeleportPlayerWithinDistance(Vector(5727, 3180, 1005), 30, Vector(3191, -1228, 1682))

            // Disable art therapy chutes
            local vectorE
            vectorE = Vector(3201, -1152, 1272)
            local Aent = null
            while(Aent = Entities.FindByClassnameWithin(Aent, "player", vectorE, 150)) {
                local LCatDis = null
                while(LCatDis = Entities.FindByName(LCatDis, "left-disable_cats")) {
                    DoEntFire("!self", "enable", "", 0.0, null, LCatDis)
                    DoEntFire("!self", "trigger", "", 0.0, null, LCatDis)
                }
                local RCatDis = null
                while(RCatDis = Entities.FindByName(RCatDis, "right-disable_cats")) {
                    DoEntFire("!self", "enable", "", 0.0, null, RCatDis)
                    DoEntFire("!self", "trigger", "", 0.0, null, RCatDis)
                }
            }

            // Teleport exiting player out of art therapy
            TeleportPlayerWithinDistance(Vector(3584, -1669, 466), 30, Vector(3919, 3352, 158))
        }

    //## MP_COOP_CREDITS LOOP ##//
        if (GetMapName() == "mp_coop_credits") {
            // If mod credits aren't finished change humans to robots
        if (MPMCredits <= MPModCreditNumber) {
            // Change males to Atlases
            local ent = null
            while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_male.mdl")) {
                CreditsSetModelAL(ent)
            }

            local ent = null
            while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_male01.mdl")) {
                CreditsSetModelAL(ent)
            }

            local ent = null
            while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_male_02.mdl")) {
                CreditsSetModelAL(ent)
            }

            // Change females to P-bodys
            local ent = null
            while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_female_01.mdl")) {
                CreditsSetModelPB(ent)
            }

            local ent = null
            while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_female_02.mdl")) {
                CreditsSetModelPB(ent)
            }

            local ent = null
            while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_female_03.mdl")) {
                CreditsSetModelPB(ent)
            }
        }
        }

        //## MP_COOP_WALL_5 ##//
        if (GetMapName() == "mp_coop_wall_5") {
            TeleportPlayerWithinDistance(Vector(1224, -1984, 565), 100, Vector(1208, -1989, 315))
            // Open areaportal
            EntFire("portal_close_second_puzzle", "open", "", 0, null)
        }

        //## MP_COOP_2PAINTS_1BRIDGE ##//
        if (GetMapName() == "mp_coop_2paints_1bridge") {
            EntFireByHandle(Entities.FindByName(null, "bridge_2"), "enable", "", 0, null, null)
            EntFireByHandle(Entities.FindByName(null, "bridge_1"), "enable", "", 0, null, null)
            EntFireByHandle(Entities.FindByName(null, "paint_sprayer_blue_1"), "start", "", 0, null, null)
        }
    }


    //////////////////
    // ONE TIME RUN //
    //////////////////


    if (AMCPostPlayerSpawn == true) {

        //## GENERAL ONE TIME RUN ##//
        local DoorEntities = [
            "airlock_1-door1-airlock_entry_door_close_rl",
            "airlock_2-door1-airlock_entry_door_close_rl",
            "last_airlock-door1-airlock_entry_door_close_rl",
            "airlock_1-door1-door_close",
            "airlock1-door1-door_close",
            "camera_door_3-relay_doorclose",
            "entry_airlock-door1-airlock_entry_door_close_rl",
            "door1-airlock_entry_door_close_rl",
            "airlock-door1-airlock_entry_door_close_rl",
            "orange_door_1-ramp_close_start",
            "blue_door_1-ramp_close_start",
            "orange_door_1-airlock_player_block",
            "blue_door_1-airlock_player_block",
            "airlock_3-door1-airlock_entry_door_close_rl",  //mp_coop_sx_bounce (Sixense map)
        ]

        foreach (DoorType in DoorEntities) {
            try {
                Entities.FindByName(null, DoorType).Destroy()
            } catch(exception) {
            }
        }

        //## MP_COOP_SEPARATION_1 ##//
        if (GetMapName() == "mp_coop_separation_1") {
            EntFireByHandle(Entities.FindByName(null, "@glados"), "runscriptcode", "GladosCoopMapStart()", 0, null, null)
            EntFireByHandle(Entities.FindByName(null, "@glados"), "runscriptcode", "GladosCoopElevatorEntrance(1)", 0, null, null)
            EntFireByHandle(Entities.FindByName(null, "@glados"), "runscriptcode", "GladosCoopElevatorEntrance(2)", 0, null, null)

            local ent = null
            while(ent = Entities.FindByName(ent, "split_exit_arms")) {
                EntFireByHandle(ent, "setanimation", "90up", 0, null, null)
            }

            local ent = null
            while(ent = Entities.FindByName(ent, "split_entrance_arms")) {
                EntFireByHandle(ent, "setanimation", "90down", 0, null, null)
            }

            local ent = null
            while (ent = Entities.FindByClassnameWithin(ent, "func_areaportalwindow", OldPlayerPos, 5000)) {
                EntFireByHandle(ent, "SetFadeEndDistance", "10000", 0, null, null)
            }

            local loopTimes = 0
            while (loopTimes <= 0) {
                Entities.FindByName(null, "split_exit_fake_collision").Destroy()
                local loopTimes = loopTimes + 1
            }
        }

        //## MP_COOP_LOBBY_3 ONE TIME RUN ##//
        if (GetMapName() == "mp_coop_lobby_3") {
            // Enable the hub entirely
            try {
                // Enable team building course
                DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null, "relay_reveal_teambuilding"))
                DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null, "relay_reveal_teambuilding"))

                // Enable tbeam course
                DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null, "relay_reveal_tbeam"))
                DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null, "relay_reveal_tbeam"))

                // Enable mass and velocity course
                DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null, "relay_reveal_bridge"))
                DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null, "relay_reveal_bridge"))

                // Enable paint course
                DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null, "relay_reveal_paint"))
                DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null, "relay_reveal_paint"))

                // Enable fling course
                DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null, "relay_reveal_fling"))
                DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null, "relay_reveal_fling"))

                // Enable extra course
                DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null, "relay_reveal_extra"))
                DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null, "relay_reveal_extra"))

                // Enable all finished course
                DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null, "relay_reveal_all_finished"))
                DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null, "relay_reveal_all_finished"))

                // Enable music
                DoEntFire("!self", "invalue", "7", 0.0, null, Entities.FindByName(null, "@music_lobby_7"))
                Entities.FindByName(null, "brush_spawn_blocker_red").Destroy()
                Entities.FindByName(null, "brush_spawn_blocker_blue").Destroy()
            } catch(exception) {}

            // Remove useless entities so that the entity limit does not crash the game

            // Remove func_portal_bumper's from the map
            local ent = null
            while(ent = Entities.FindByClassname(ent, "func_portal_bumper")) {
                ent.Destroy() // 165 entities removed
            }
            // Remove env_sprite's from the map
            local ent = null
            while(ent = Entities.FindByClassname(ent, "env_sprite")) {
                ent.Destroy() // 31 entities removed
            }

            // Fix art therapy tube glitches
            Entities.FindByName(null, "dlc_room_fall_push_right").Destroy()
            Entities.FindByName(null, "dlc_room_fall_push_left").Destroy()

            // Fix track 5
            // Entry door fix
            Entities.FindByName(null, "track5-door_paint-trigger_hurt_door").Destroy()
            Entities.FindByName(null, "track5-door_paint-collide_door").Destroy()

            // Light fix
            Entities.FindByName(null, "@light_shadowed_paintroom").Destroy()

            // Remove orange exit door
            local ent = null
            while(ent = Entities.FindByName(ent, "track5-orangeiris_door_elevator_pit")) {
                ent.Destroy()
            }

            Entities.FindByName(null, "track5-orangeescape_elevator_clip").Destroy()

            // Remove blue exit door
            local ent = null
            while(ent = Entities.FindByName(ent, "track5-iris_door_elevator_pit")) {
                ent.Destroy()
            }

            Entities.FindByName(null, "track5-escape_elevator_clip").Destroy()

            // Remove the bottom of droppers in Course 5
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                local ent = null
                while (ent = Entities.FindByClassnameWithin(ent, "prop_dynamic", OldPlayerPos, 500)) {
                    if (ent.GetModelName() == "models/props_underground/underground_boxdropper.mdl") {
                        EntFireByHandle(ent, "SetAnimation", "open_idle", 0.0, null, null)
                    }

                    if (ent.GetModelName() == "models/props_backstage/item_dropper.mdl") {
                        EntFireByHandle(ent, "SetAnimation", "item_dropper_idle", 0.0, null, null)
                    }
                }
            }
        }

        //## MP_COOP_SEPARATION_1 ONETIME ##//
        if (GetMapName() == "mp_coop_separation_1") {
            EntFireByHandle(Entities.FindByName(null, "@glados"), "runscriptcode", "GladosCoopMapStart()", 0, null, null)
            EntFireByHandle(Entities.FindByName(null, "@glados"), "runscriptcode", "GladosCoopElevatorEntrance(1)", 0, null, null)
            EntFireByHandle(Entities.FindByName(null, "@glados"), "runscriptcode", "GladosCoopElevatorEntrance(2)", 0, null, null)

            local ent = null
            while(ent = Entities.FindByName(ent, "split_exit_arms")) {
                EntFireByHandle(ent, "setanimation", "90up", 0, null, null)
            }

            local ent = null
            while(ent = Entities.FindByName(ent, "split_entrance_arms")) {
                EntFireByHandle(ent, "setanimation", "90down", 0, null, null)
            }

            local ent = null
            while (ent = Entities.FindByClassnameWithin(ent, "func_areaportalwindow", OldPlayerPos, 5000)) {
                EntFireByHandle(ent, "SetFadeEndDistance", "10000", 0, null, null)
            }

            local loopTimes = 0
            while (loopTimes <= 0) {
                Entities.FindByName(null, "split_exit_fake_collision").Destroy()
                local loopTimes = loopTimes + 1
            }
        }
    }

    ///////////////
    // Post init //
    ///////////////
    if (AMCPostInit==true) {
        // Cache props
        CreatePropsForLevel(true, false, false)
    }
}

////////////////////////////
// SINGLEPLAYER FUNCTIONS //
////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// █▀▄▀█ ▄▀█ █▀█   █▀ █░█ █▀█ █▀█ █▀█ █▀█ ▀█▀
// █░▀░█ █▀█ █▀▀   ▄█ █▄█ █▀▀ █▀▀ █▄█ █▀▄ ░█░

//## Import Map Support Code ##//
local MapName = FindAndReplace(GetMapName().tostring(), "maps/", "")
MapName = FindAndReplace(MapName.tostring(), ".bsp", "")

try {
    IncludeScript("mapsupport/rootfunctions.nut")
    IncludeScript("mapsupport/" + MapName.tostring() + ".nut")
} catch (error) {
    print("No map support for " + MapName.tostring())
    function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) { }
}

//////////////////////
// Boilerplate code //
//////////////////////

/*

    // Use with new Aperture maps //

    //## MAPNAME ##//
    if (GetMapName()=="LEVELNAME") {
        if (MSInstantRun==true) {
            // Make elevator start moving on level load
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "StartForward", "", 0, null, null)
            // Destroy objects
            Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        }

        if (MSPostPlayerSpawn==true) {
            NewApertureStartElevatorFixes()
        }

        if (MSLoop==true) {
            // Elevator changelevel
            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(1, 2, 3), 50)) {
                SendToConsole("commentary 1")
                SendToConsole("changelevel LEVELNAME")
            }
        }
    }

    // Use with maps without entrance or exit elevators //

    //## MAPNAME ##//
    if (GetMapName()=="LEVELNAME") {
        if (MSInstantRun==true) {
            // Here if we need to ent_fire something
            EntFireByHandle(Entities.FindByName(null, "NAME"), "ACTION", "VALUE", DELAYiny, ACTIVATOR, CALLER)
            // Destroy objects
            Entities.FindByName(null, "NAME").Destroy()
        }

        if (MSPostPlayerSpawn==true) {

        }

        if (MSLoop==true) {
            // Make our own changelevel trigger
            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(1, 2, 3), 50)) {
                SendToConsole("commentary 1")
                SendToConsole("changelevel LEVELNAME")
            }
        }
    }

    // Use with old Aperture maps //

    //## MAPNAME ##//
    if (GetMapName()=="LEVELNAME") {
        if (MSInstantRun==true) {
            // Make elevator start moving on level load
            EntFireByHandle(Entities.FindByName(null, "InstanceAuto8-entrance_lift_train"), "StartForward", "", 0, null, null)
            // Destroy objects
            Entities.FindByName(null, "fade_to_death-proxy").Destroy()
        }

        if (MSPostPlayerSpawn==true) {

        }

        if (MSLoop==true) {
            // Elevator changelevel
            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(1, 2, 3), 100)) {
                SendToConsole("commentary 1")
                SendToConsole("changelevel LEVELNAME")
            }
        }
    }


// Destroy object using FindByName
Entities.FindByName(null, "NAME").Destroy()

// Find and destroy object using FindByClassnameNearest within 1 unit of given vector
Entities.FindByClassnameNearest("CLASS", Vector(1, 2, 3), 1).Destroy()

// Changelevel trigger
local p = null
while(p = Entities.FindByClassnameWithin(p, "player", Vector(1, 2, 3), 50)) {
    SendToConsole("commentary 1")
    SendToConsole("changelevel LEVELNAME")
}

local ent = null
while (ent = Entities.FindByClassname(ent, "CLASSNAME")) {
    ent.Destroy()
}

// Make Wheatley look at nearest player
local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "spherebot_1_bottom_swivel_1").GetOrigin(), 10000)
EntFireByHandle(Entities.FindByName(null, "spherebot_1_bottom_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)

if (GetMapName() == "MAPNAME") {
    SendToConsole("commentary 0")
}




            EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-32, -1032, 32), 20), "addoutput", "OnTrigger moja2:SetAnimation:vert_door_opening", 0, null, null)
            EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-32, -1032, 32), 20), "addoutput", "OnTrigger moja3:Disable", 0, null, null)




// ent_fire an object
EntFireByHandle(Entities.FindByName(null, "NAME"), "ACTION", "VALUE", DELAYiny, ACTIVATOR, CALLER)

// Pretty sure this is unified in the NewAperture function use find to delete unused entrys (Moja)
try {
    EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
} catch(exception) {}
*/

// Run mapspawn.nut
try {
Entities.First().ConnectOutput("OnUser1", "init")
} catch(exception) {}
try {
DoEntFire("worldspawn", "FireUser1", "", 0.0, null, null)
} catch(exception) {}


// ╔═╗╦═╗╔═╗╔═╗  ╔═╗╦═╗╔═╗╔═╗╔╦╗╦╔═╗╔╗╔  ╔═╗╔═╗╔╦╗╔═╗
// ╠═╝╠╦╝║ ║╠═╝  ║  ╠╦╝║╣ ╠═╣ ║ ║║ ║║║║  ║  ║ ║ ║║║╣
// ╩  ╩╚═╚═╝╩    ╚═╝╩╚═╚═╝╩ ╩ ╩ ╩╚═╝╝╚╝  ╚═╝╚═╝═╩╝╚═╝
// ╦╔╦╗╔═╗╔═╗╦═╗╔╦╗╔═╗╔╦╗  ╔═╗╦═╗╔═╗╔╦╗  ╔═╗╔╦╗╔═╗╔╦╗
// ║║║║╠═╝║ ║╠╦╝ ║ ║╣  ║║  ╠╣ ╠╦╝║ ║║║║  ║ ╦║║║║ ║ ║║
// ╩╩ ╩╩  ╚═╝╩╚═ ╩ ╚═╝═╩╝  ╚  ╩╚═╚═╝╩ ╩  ╚═╝╩ ╩╚═╝═╩╝

function CreatePropsForLevel(CacheTime, CreateTime, LoopTime) {

//=============================//
//CREATE OBJECTS FOR sp_a2_bts2//
//=============================//

if (GetMapName() == "sp_a2_bts2") {
    if (CacheTime==true) {
        // Cache Objects

        CacheModel("props_bts/hanging_walkway_128a.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local sp_a2_bts2_custom_prop_144 = CreateProp("prop_dynamic", Vector(1210.9047851562, -3591.4580078125, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_144.SetAngles(-89.999946594238, -179.99993896484, 180)
        sp_a2_bts2_custom_prop_144.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_144.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_144, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_145 = CreateProp("prop_dynamic", Vector(1210.9046630859, -3463.4580078125, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_145.SetAngles(-89.999946594238, -179.99992370605, 180)
        sp_a2_bts2_custom_prop_145.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_145.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_145, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_146 = CreateProp("prop_dynamic", Vector(1407.3646240234, -3066.5859375, 10.300641059875), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_146.SetAngles(-89.979080200195, 90.006011962891, 180)
        sp_a2_bts2_custom_prop_146.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_146.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_146, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_147 = CreateProp("prop_dynamic", Vector(1733.7668457031, -3890.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_147.SetAngles(-89.999946594238, 9.5622635853942e-05, 180)
        sp_a2_bts2_custom_prop_147.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_147.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_147, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_148 = CreateProp("prop_dynamic", Vector(1732.4794921875, -3133.6625976562, 10.172374725342), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_148.SetAngles(-89.999984741211, 8.720429832465e-06, 180)
        sp_a2_bts2_custom_prop_148.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_148.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_148, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_149 = CreateProp("prop_dynamic", Vector(1210.9049072266, -3719.4580078125, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_149.SetAngles(-89.999946594238, -179.99995422363, 180)
        sp_a2_bts2_custom_prop_149.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_149.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_149, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_150 = CreateProp("prop_dynamic", Vector(1210.9050292969, -3847.4582519531, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_150.SetAngles(-89.999946594238, -179.99996948242, 180)
        sp_a2_bts2_custom_prop_150.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_150.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_150, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_151 = CreateProp("prop_dynamic", Vector(1210.9045410156, -3335.4580078125, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_151.SetAngles(-89.999946594238, -179.99990844727, 180)
        sp_a2_bts2_custom_prop_151.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_151.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_151, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_152 = CreateProp("prop_dynamic", Vector(1210.904296875, -3207.4577636719, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_152.SetAngles(-89.999946594238, -179.99989318848, 180)
        sp_a2_bts2_custom_prop_152.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_152.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_152, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_153 = CreateProp("prop_dynamic", Vector(1210.9040527344, -3079.4577636719, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_153.SetAngles(-89.999946594238, -179.99989318848, 180)
        sp_a2_bts2_custom_prop_153.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_153.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_153, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_154 = CreateProp("prop_dynamic", Vector(1279.3647460938, -3066.5993652344, 10.300641059875), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_154.SetAngles(-89.979103088379, 90.006004333496, 180)
        sp_a2_bts2_custom_prop_154.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_154.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_154, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_155 = CreateProp("prop_dynamic", Vector(2119.7722167969, -3195.4938964844, 12.396705627441), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_155.SetAngles(-89.999946594238, 89.999984741211, 180)
        sp_a2_bts2_custom_prop_155.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_155.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_155, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_156 = CreateProp("prop_dynamic", Vector(2244.1625976562, -3520.9521484375, 13.540298461914), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_156.SetAngles(-89.911918640137, -0.34657052159309, -179.76554870605)
        sp_a2_bts2_custom_prop_156.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_156.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_156, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_157 = CreateProp("prop_dynamic", Vector(1733.7669677734, -4018.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_157.SetAngles(-89.999954223633, 5.4641506721964e-05, 180)
        sp_a2_bts2_custom_prop_157.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_157.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_157, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_158 = CreateProp("prop_dynamic", Vector(1733.7672119141, -4146.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_158.SetAngles(-89.999946594238, 9.5622635853942e-05, 180)
        sp_a2_bts2_custom_prop_158.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_158.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_158, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_159 = CreateProp("prop_dynamic", Vector(2176.3408203125, -3588.1184082031, 10.380084037781), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_159.SetAngles(-89.999984741211, -89.999992370605, 180)
        sp_a2_bts2_custom_prop_159.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_159.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_159, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_160 = CreateProp("prop_dynamic", Vector(1733.7663574219, -3634.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_160.SetAngles(-89.999946594238, 0.00010928301344393, 180)
        sp_a2_bts2_custom_prop_160.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_160.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_160, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_161 = CreateProp("prop_dynamic", Vector(2244.4130859375, -3392.9523925781, 13.541104316711), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_161.SetAngles(-89.911918640137, -0.34657019376755, -179.76554870605)
        sp_a2_bts2_custom_prop_161.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_161.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_161, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_162 = CreateProp("prop_dynamic", Vector(2247.7722167969, -3195.4938964844, 12.396705627441), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_162.SetAngles(-89.999946594238, 89.999984741211, 180)
        sp_a2_bts2_custom_prop_162.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_162.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_162, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_163 = CreateProp("prop_dynamic", Vector(1663.3646240234, -3066.5588378906, 10.300641059875), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_163.SetAngles(-89.979080200195, 90.006042480469, 180)
        sp_a2_bts2_custom_prop_163.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_163.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_163, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_164 = CreateProp("prop_dynamic", Vector(1535.3646240234, -3066.572265625, 10.300641059875), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_164.SetAngles(-89.979080200195, 90.00602722168, 180)
        sp_a2_bts2_custom_prop_164.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_164.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_164, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_165 = CreateProp("prop_dynamic", Vector(1210.9050292969, -4103.4584960938, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_165.SetAngles(-89.999984741211, 180, 180)
        sp_a2_bts2_custom_prop_165.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_165.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_165, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_166 = CreateProp("prop_dynamic", Vector(1733.7666015625, -3762.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_166.SetAngles(-89.999946594238, 0.00010928301344393, 180)
        sp_a2_bts2_custom_prop_166.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_166.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_166, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_167 = CreateProp("prop_dynamic", Vector(1863.7722167969, -3195.4938964844, 12.396701812744), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_167.SetAngles(-89.999984741211, 89.999984741211, 180)
        sp_a2_bts2_custom_prop_167.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_167.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_167, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_168 = CreateProp("prop_dynamic", Vector(1210.9050292969, -3975.4584960938, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_168.SetAngles(-89.999954223633, -179.99998474121, 180)
        sp_a2_bts2_custom_prop_168.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_168.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_168, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_169 = CreateProp("prop_dynamic", Vector(1991.7722167969, -3195.4938964844, 12.396705627441), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_169.SetAngles(-89.999954223633, 89.999984741211, 180)
        sp_a2_bts2_custom_prop_169.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_169.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_169, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_170 = CreateProp("prop_dynamic", Vector(2244.6635742188, -3264.9526367188, 13.541909217834), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_170.SetAngles(-89.91194152832, -0.34656989574432, -179.76559448242)
        sp_a2_bts2_custom_prop_170.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_170.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_170, "disabledraw", "", 0, null, null)

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}
}

