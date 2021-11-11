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
}

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
    printl("NOT PLAYING IN MULTIPLAYER!!! (disconnecting)")
    SendToConsole("disconnect You cannot play singleplayer with the multiplayer mod loaded please restart your game")
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
    CreatePropsForLevel(true, false, false)
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

    // attempt to fix some general map issues
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

    // Create props after cache
    CreatePropsForLevel(false, true, false)

    MapSupport(false, false, true, false, false, false, false)
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// █▀▄▀█ ▄▀█ █▀█   █▀ █░█ █▀█ █▀█ █▀█ █▀█ ▀█▀
// █░▀░█ █▀█ █▀▀   ▄█ █▄█ █▀▀ █▀▀ █▄█ █▀▄ ░█░

//## Import Map Support Code ##//
local MapName = FindAndReplace(GetMapName().tostring(), "maps/", "")
MapName = FindAndReplace(MapName.tostring(), ".bsp", "")

try {
    IncludeScript("mapsupport/#rootfunctions.nut")
    IncludeScript("mapsupport/#propcreation.nut")
    IncludeScript("mapsupport/" + MapName.tostring() + ".nut")
} catch (error) {
    print("No map support for " + MapName.tostring())
    function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) { }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// █▀ ▀█▀ ▄▀█ █▀█ ▀█▀   ▀█▀ █░█ █▀▀   █▀▄▀█ █▀█ █▀▄ █
// ▄█ ░█░ █▀█ █▀▄ ░█░   ░█░ █▀█ ██▄   █░▀░█ █▄█ █▄▀ ▄

// Run init
Entities.First().ConnectOutput("OnUser1", "init")
DoEntFire("worldspawn", "FireUser1", "", 0.0, null, null)