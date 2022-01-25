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
DevMode <- false // Set to true if you're a developer
//-----------------------------------
DevInfo <- false // Set to true if you want to see the developer info
//-----------------------------------
UsePlugin <- true // Set to true if you want to use the plugin (LINUX ONLY)
//-----------------------------------
DedicatedServer <- false // Set to true if you want to run the server as a dedicated server (INDEV)
//-----------------------------------
RandomTurrets <- false // Set to true if you want to randomize every Turret's models and colors (for fun lol)
//-----------------------------------
TickSpeed <- 0.00 // Set to the tick speed of the server [in seconds] (lower numbers are faster but may cause lag on slower clients)
//-----------------------------------
RandomPortalSize <- false // Set to true if you want to randomize the portal size
//-----------------------------------
Admins <- ["vista", "Bumpy", "Nanoman2525", "Wolƒe Strider Shoσter", "CHARITY", "Dreadnox", "!wol"]
//-----------------------------------

//  ██████  ██████  ██████  ███████
// ██      ██    ██ ██   ██ ██
// ██      ██    ██ ██   ██ █████
// ██      ██    ██ ██   ██ ██
//  ██████  ██████  ██████  ███████

// █▀ █▀▀ ▀█▀ █░█ █▀█   █░█ ▄▀█ █▀█ █ █▄▄ █░░ █▀▀ █▀
// ▄█ ██▄ ░█░ █▄█ █▀▀   ▀▄▀ █▀█ █▀▄ █ █▄█ █▄▄ ██▄ ▄█

if (RandomPortalSize==true) {
    randomportalsize <- 34
    randomportalsizeh <- 34
}
yes <- ""
DevModeConfig <- DevMode
StartDevModeCheck <- false
PreviousTimeDeath <- 0
HasRanGeneralOneTime <- true
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
playerclasses <- []
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

    MapSupport(true, false, false, false, false, false, false)

    colordisplay <- Entities.CreateByClassname("game_text")
    colordisplay.__KeyValueFromString("targetname", "colordisplay")
    colordisplay.__KeyValueFromString("x", "0")
    colordisplay.__KeyValueFromString("y", "1")
    colordisplay.__KeyValueFromString("holdtime", "100000")
    colordisplay.__KeyValueFromString("fadeout", "0")
    colordisplay.__KeyValueFromString("fadein", "0")
    colordisplay.__KeyValueFromString("channel", "0")

    // Create an on screen text message entity
    onscreendisplay <- Entities.CreateByClassname("game_text")
    onscreendisplay.__KeyValueFromString("targetname", "onscreendisplaympmod")
    onscreendisplay.__KeyValueFromString("message", "Waiting for players...")
    onscreendisplay.__KeyValueFromString("holdtime", (0.01 + TickSpeed * 2).tostring())
    onscreendisplay.__KeyValueFromString("fadeout", (0.01 + TickSpeed * 2).tostring())
    onscreendisplay.__KeyValueFromString("fadein", (0.01 + TickSpeed * 2).tostring())
    onscreendisplay.__KeyValueFromString("spawnflags", "1")
    onscreendisplay.__KeyValueFromString("color", "60 200 60")
    onscreendisplay.__KeyValueFromString("channel", "1")
    //onscreendisplay.__KeyValueFromString("x", "-1.1")
    //onscreendisplay.__KeyValueFromString("y", "-1.1")
    
    // dc message
    disconnectmessagedisplay <- Entities.CreateByClassname("game_text")
    disconnectmessagedisplay.__KeyValueFromString("targetname", "pdcm")
    disconnectmessagedisplay.__KeyValueFromString("holdtime", "3")
    disconnectmessagedisplay.__KeyValueFromString("fadeout", "0.2")
    disconnectmessagedisplay.__KeyValueFromString("fadein", "0.2")
    disconnectmessagedisplay.__KeyValueFromString("spawnflags", "1")
    disconnectmessagedisplay.__KeyValueFromString("color", "140 40 40")
    disconnectmessagedisplay.__KeyValueFromString("channel", "3")
    disconnectmessagedisplay.__KeyValueFromString("message", "Player disconnected")
    EntFireByHandle(disconnectmessagedisplay, "display", "", 0.0, null, null)

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
            if (GetDeveloperLevel() == 1) {
                printl("============================================")
                printl("P2:MM plugin has already loaded! Handling...")
                printl("============================================")
            }
            PluginLoaded <- true
        } else {
            if (GetDeveloperLevel() == 1) {
                printl("============================================")
                printl("P2:MM plugin has not been loaded! Loading...")
                printl("============================================")
            }
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

function RandomColor() {
    local rcr = RandomInt(0, 255)
    local rcg = RandomInt(0, 255)
    local rcb = RandomInt(0, 255)
    local ColorBal = RandomInt(0, 2)
    // Balance The Color
    if (ColorBal == 1) {
        if (rcr > rcg && rcr > rcb) {
            rcr = rcr * 2
            if (rcr > 255) {
                rcr = 255
            }

            rcg = rcg / 2
            rcb = rcb / 2
        } else {
            if (rcg > rcr && rcg > rcb) {
                rcg = rcg * 2
                if (rcg > 255) {
                    rcg = 255
                }

                rcr = rcr / 2
                rcg = rcg / 2
            } else {
                if (rcb > rcr && rcb > rcg) {
                    rcb = rcb * 2
                    if (rcb > 255) {
                        rcb = 255
                    }

                    rcr = rcr / 2
                    rcg = rcg / 2
                }
            }
        }
    }
    // Balance The Color
    if (ColorBal == 2) {
        if (rcr > rcg && rcr > rcb) {
            rcr = rcr * 2
            if (rcr > 255) {
                rcr = 255
            }

            rcg = rcg * 2
            if (rcg > 255) {
                rcg = 255
            }
            rcb = rcb / 3
        } else {
            if (rcg > rcr && rcg > rcb) {
                rcg = rcg * 2
                if (rcg > 255) {
                    rcg = 255
                }

                rcr = rcr * 2
                if (rcr > 255) {
                    rcr = 255
                }
                rcg = rcg / 2
            } else {
                if (rcb > rcr && rcb > rcg) {
                    rcb = rcb * 2
                    if (rcb > 255) {
                        rcb = 255
                    }

                    rcr = R / 2
                    rcg = rcg * 2
                    if (rcg > 255) {
                        rcg = 255
                    }
                }
            }
        }
    }
    if (RandomInt(1, 7)==3) {
        rcg = RandomInt(1, 30)
        rcb = RandomInt(1, 30)
        rcr = RandomInt(170, 255)
    }
    if (RandomInt(1, 9)==4) {
        rcg = RandomInt(150, 255)
        rcb = RandomInt(1, 30)
        rcr = RandomInt(170, 255)
    }

    class ColorBar {
        r = rcr
        g = rcg
        b = rcb
    }
    return ColorBar
}

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
    while (p = Entities.FindInSphere(p, Vector(0, 0, 0), 16384)) {
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

function FindPlayerClass(plyr) {
    foreach (curclass in playerclasses) {
        if (curclass.player == plyr) {
            return curclass
        }
    }
}

function FindPlayerByName(name) {
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        local plrname = GetPlayerName(p.entindex())
        plrname = plrname.slice(0, name.len())
        printl(plrname)
        printl(name)
        if (plrname==name) {
            return p
        }
    }
    return null
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
            if (GetDeveloperLevel() == 1) {
                printl("(P2:MM): Model " + ModelName + " is already cached!")
            }
        } else {
        try {
            if (servercommand) {
                if (GetDeveloperLevel() == 1) {
                    printl("(P2:MM): point_servercommand to cache props already exists!")
                }
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

        if (GetDeveloperLevel() == 1) {
            printl("(P2:MM): Model " + ModelName + " has been cached sucessfully!")
        }
    }
}

function GetAdminLevel(id) {
  foreach (playername in Admins) {
    if (playername==GetPlayerName(id)) {
        return 1
    }
  }
  if (id == 1) {
      return 1
  }
  return 0
}

// Find player by index
function FindByIndex(id)  {
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        if (p.entindex()==id) {
            return p
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//------------------------------------------------------//
// ░█▀▄▀█ ─█▀▀█ ▀█▀ ░█▄─░█    ░█─── ░█▀▀▀█ ░█▀▀▀█ ░█▀▀█ //
// ░█░█░█ ░█▄▄█ ░█─ ░█░█░█    ░█─── ░█──░█ ░█──░█ ░█▄▄█ //
// ░█──░█ ░█─░█ ▄█▄ ░█──▀█    ░█▄▄█ ░█▄▄▄█ ░█▄▄▄█ ░█─── //
//------------------------------------------------------//

function loop() {
    //## Run player join code when a player joins ##//
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

    //## Cache original spawn position ##//
    if (cacheoriginalplayerposition == 0 && Entities.FindByClassname(null, "player")) {
        // OldPlayerPos = the blues inital spawn position
        try {
            OldPlayerPos <- Entities.FindByName(null, "blue").GetOrigin()
            OldPlayerAngles <- Entities.FindByName(null, "blue").GetAngles()
        } catch (exception) {
            try {
                OldPlayerPos <- Entities.FindByName(null, "info_coop_spawn").GetOrigin()
                OldPlayerAngles <- Entities.FindByName(null, "info_coop_spawn").GetAngles()
            } catch (exception) {
                    try {
                        OldPlayerPos <- Entities.FindByName(null, "info_player_start").GetOrigin()
                        OldPlayerAngles <- Entities.FindByName(null, "info_player_start").GetAngles()
                    } catch(exception) {
                        OldPlayerPos <- Vector(0, 0, 0)
                        OldPlayerAngles <- Vector(0, 0, 0)
                        if (GetDeveloperLevel() == 1) {
                            printl("(P2:MM): Error: Could not cache player position. This is catastrophic!")
                        }
                        cacheoriginalplayerposition <- 1
                    }
                }
            }
        cacheoriginalplayerposition <- 1
    }

    //## Detect death ##//
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

    //## Make a hook for when all players join the game ##//
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

    //## Delete all cached models ##//
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


    //## MapSupport loop ##//
    MapSupport(false, true, false, false, false, false, false)


    //## Run all custom generated props / prop related Garry's Mod code ##//
    CreatePropsForLevel(false, false, true)


    //## Config developer mode loop ##//
    if (DevModeConfig==true) {
        // Change DevMode varible based on convar "developer"
        if (GetDeveloperLevel() == 0) {
            if (StartDevModeCheck == true) {
                DevMode <- false
            }
        } else {
            DevMode <- true
        }
    }

    // Random turret models
    if (RandomTurrets == true && HasSpawned == true) {
        local ent = null
        while (ent = Entities.FindByClassname(ent, "npc_portal_turret_floor")) {
            local script_scope = ent.GetScriptScope()
            if (ent.GetTeam() != 69420) {
                local modelnumber = RandomInt(0, 2)
                if (modelnumber == 2) {
                    modelnumber = 4
                }
                ent.__KeyValueFromInt("ModelIndex", modelnumber)
                local RTurretColor = RandomColor()

                b <- RTurretColor.b
                g <- RTurretColor.g
                r <- RTurretColor.r

                local model = RandomInt(0, 2)

                if (model == 1) {
                    ent.SetModel("models/npcs/turret/turret_skeleton.mdl")
                }
                if (model == 2) {
                    ent.SetModel("models/npcs/turret/turret_backwards.mdl")
                }
                // if (model == 3) {
                //     ent.SetModel("models/npcs/turret/turret_boxed.mdl")
                // }
                // // if (model == 4) { }
                // if (model == 4) {
                //     ent.SetModel("models/npcs/turret/turret_fx_laser_gib4.mdl")
                // }


                EntFireByHandle(ent, "Color", (R + " " + G + " " + R), 0, null, null)
                ent.SetTeam(69420)
            }
        }
    }

    //## "colored portals" ##//
    if (DevInfo == true) {
        if (DevMode == true) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                local c1 = Entities.FindByName(null, p.GetName() + "_portal-1")
                local c2 = Entities.FindByName(null, p.GetName() + "_portal-2")

                local pitch = c2.GetAngles().x
                local yaw = c2.GetAngles().y
                local roll = c2.GetAngles().z

                local x = pitch*cos(0) - yaw*sin(0)
                local y = pitch*sin(0) + yaw*cos(0)
                x = x * 10
                y = y * 10

                // printl(c1.GetName())
                // printl(x)
                // printl(y)
                // printl("========")

                local c2o = c2.GetOrigin()
                local c1o = c1.GetOrigin()

                // DebugDrawBox(origin, mins, max, r, g, b, alpha, duration)
                // Set preset colors for up to 16 clients
                switch (p.entindex()) {
                    case 1 : R <- 255; G <- 255; B <- 255; break;
                    case 2 : R <- 0,   G <- 255, B <- 0;   break;
                    case 3 : R <- 0,   G <- 0,   B <- 255; break;
                    case 4 : R <- 255, G <- 0,   B <- 0;   break;
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
                DebugDrawBox(c1o, Vector(-50, -50, -50), Vector(50, 50, 50), R, G, B, 10, 0);
                DebugDrawBox(c2o, Vector(-50, -50, -50), Vector(50, 50, 50), R, G, B, 10, 0);

                DebugDrawLine(c1o, p.GetOrigin(), R, G, B, true, 0)
                DebugDrawLine(c2o, p.GetOrigin(), R, G, B, true, 0)
            }
        }
    }

    ///////////////////////
    // RUNS EVERY SECOND //
    ///////////////////////

    if (Time() >= PreviousTime1Sec + 1) {
    PreviousTime1Sec <- Time()

    // Random Portal Sizes

    if (RandomPortalSize == true) {
        randomportalsize <- RandomInt(1, 100 ).tostring()
        randomportalsizeh <- RandomInt(1, 100 ).tostring()
    }

    if (RandomPortalSize == true) {
        try {
        local ent = null
        while (ent = Entities.FindByClassname(ent, "prop_portal")) {
            // printl(ent)
            // printl(ent.GetOrigin())
            // printl(ent.GetAngles())
            // printl("=================")
            ent.__KeyValueFromString("HalfWidth", randomportalsize)
            ent.__KeyValueFromString("HalfHeight", randomportalsizeh)
        }
        } catch(exception) {
            // printl("(P2:MM): Error: " + exception)
        }
        // printl("################################")
    }

    //## Detect respawn ##//
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

    //## Make players' collision elastic ##//
    EntFire("player", "addoutput", "CollisionGroup 2")
    }

    //## If not in multiplayer then disconnect ##//
    try {
        if (Entities.FindByClassname(null, "player").GetName() == "") {
            printl("(P2:MM): This is not a multiplayer session! Disconnecting client...")
            Entities.CreateByClassname("point_servercommand").__KeyValueFromString("targetname", "forcedisconnectclient")
            EntFire("forcedisconnectclient", "command", "disconnect \"You cannot play singleplayer games when Portal 2 is launched from the Multiplayer Mod launcher. Please close the game and start it from Steam.\"", 1, null)
        }
    } catch (exception) { }



    //## TESTING ##//
    local cube = null
    while (cube = Entities.FindByName(cube, "Gerald")) {
        local desired = Vector(-10, 31, 159)
        local current = cube.GetOrigin()
        local moveamo = desired - current
        moveamo.x = moveamo.x /3
        moveamo.y = moveamo.y /3
        moveamo.z = moveamo.z /3
        printl(moveamo)
        cube.SetVelocity(Vector(0, 0, 0))
        cube.SetOrigin(Vector(cube.GetOrigin().x + moveamo.x, cube.GetOrigin().y + moveamo.y, cube.GetOrigin().z + moveamo.z))
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

///////////////////
// CHAT COMMANDS //
///////////////////

function ChatCommands(ccuserid, ccmessage) {
    local p = FindByIndex(ccuserid)
    local pname = GetPlayerName(ccuserid)
    local isadmin = GetAdminLevel(ccuserid)

    //:## # OVERRIDE COMMAND ##://
    if (ccmessage.slice(0, 1) == "$") {
        printl("(P2:MM): " + pname + " has used the # override.")
        if (ccmessage.find("!")==null) {
            SendToConsole("say " + pname + " ERROR: No command provided!")
        } else {
            local inpmessage = ccmessage.slice(1, ccmessage.find("!")-1)
            p = FindPlayerByName(inpmessage)
            pname = inpmessage
            printl(inpmessage)
        }
    }

    printl("User: " + pname + " Sent: " + ccmessage)

    //## HELP COMMAND ##//
    if (ccmessage.find("!help") != null) {
        Entities.CreateByClassname("point_servercommand").__KeyValueFromString("targetname", "chatcommandhelp")
        EntFire("chatcommandhelp", "command", "say [User Commands]", 0, null)
        EntFire("chatcommandhelp", "command", "say help", 0, null)
        EntFire("chatcommandhelp", "command", "say kill", 0, null)
        EntFire("chatcommandhelp", "command", "say changeteam", 0, null)
        EntFire("chatcommandhelp", "command", "say [Admin Commands]", 1, null)
        EntFire("chatcommandhelp", "command", "say kill (ARGS)", 1, null)
        EntFire("chatcommandhelp", "command", "say goto", 1, null)
        EntFire("chatcommandhelp", "command", "say bring", 1, null)
        EntFire("chatcommandhelp", "command", "say noclip", 1, null)
        EntFire("chatcommandhelp", "command", "say rcon", 1, null)
        EntFire("chatcommandhelp", "command", "say changelevel", 1, null)
        EntFire("chatcommandhelp", "command", "say [General Help]", 2, null)
        EntFire("chatcommandhelp", "command", "say {COMMAND PREFIX: !}", 2, null)
        EntFire("chatcommandhelp", "kill", "", 3, null)
    }

    //## GET COLOR ##//
    local command="!getcolor"
    if (ccmessage.find("!getcolor") != null) {
        local args = null
        try { args = ccmessage.slice(command.len()+1, ccmessage.len()) } catch(e) { printl(e) }
        if (args != null) {}
    }

    //## CHANGELEVEL COMMAND ##//
    local command="!changelevel"
    if (ccmessage.find(command) != null) {
        if (isadmin>=1) {
            local args = null
            try { args = ccmessage.slice(command.len()+1, ccmessage.len()) } catch(e) { printl(e) }

            if (args!=null) {
                SendToConsole("changelevel " + args)
                SendToConsole("say " + pname + " INVALID MAP NAME: " + args)
            } else {
                SendToConsole("say " + pname + " ERROR: No arguments provided!")
            }
        } else {
            SendToConsole("say " + pname + " [you do not have access to this command]")
        }
    }

    //## RCON COMMAND ##//
    local command="!rcon"
    if (ccmessage.find(command) != null) {
        if (isadmin>=1) {
            local args = null
            try { args = ccmessage.slice(command.len()+1, ccmessage.len()) } catch(e) { printl(e) }

            if (args!=null) {
                SendToConsole(args)
                SendToConsole("say " + pname + " Executed: " + args)
            } else {
                SendToConsole("say " + pname + " ERROR: No arguments provided!")
            }
        } else {
            SendToConsole("say " + pname + " [you do not have access to this command]")
        }
    }

    //## BRING COMMAND ##//
    local command="!bring"
    if (ccmessage.find(command) != null) {
        if (isadmin>=1) {
            local args = null
            try { args = ccmessage.slice(command.len()+1, ccmessage.len()) } catch(e) { printl(e) }

            if (args!=null) {
                local teleporttarget = FindPlayerByName(args)
                if (teleporttarget != null) {
                    teleporttarget.SetOrigin(p.GetOrigin())
                    teleporttarget.SetAngles(p.GetAngles().x, p.GetAngles().y, p.GetAngles().z)
                } else {
                    SendToConsole("say " + pname + " ERROR: Player " + args + " does not exist!")
                }
            } else {
                SendToConsole("say " + pname + " ERROR: No arguments provided!")
            }
        } else {
            SendToConsole("say " + pname + " [you do not have access to this command]")
        }
    }

    //## GOTO COMMAND ##//
    local command="!goto"
    if (ccmessage.find(command) != null) {
        if (isadmin>=1) {
            local args = null
            try { args = ccmessage.slice(command.len()+1, ccmessage.len()) } catch(e) { printl(e) }

            if (args!=null) {
                local teleporttarget = FindPlayerByName(args)
                if (teleporttarget != null) {
                    p.SetOrigin(teleporttarget.GetOrigin())
                    p.SetAngles(teleporttarget.GetAngles().x, teleporttarget.GetAngles().y, teleporttarget.GetAngles().z)
                } else {
                    SendToConsole("say " + pname + " ERROR: Player " + args + " does not exist!")
                }
            } else {
                SendToConsole("say " + pname + " ERROR: No arguments provided!")
            }
        } else {
            SendToConsole("say " + pname + " [you do not have access to this command]")
        }
    }


    //## CHANGETEAM COMMAND ##//
    if (ccmessage.find("!changeteam") != null) {
        local args = null
        try { args = ccmessage.slice(12, ccmessage.len()) } catch(e) { printl(e) }

        local curteam = p.GetTeam()

        if (args==null) {
            if (p.GetTeam() >= 3) {
                p.SetTeam(2)
                SendToConsole("say Changed " + pname + "'s Team To Red!")
            } else {
                p.SetTeam(3)
                SendToConsole("say Changed " + pname + "'s Team To Blue!")
            }
        } else {
            if (args=="red") {
                p.SetTeam(2)
                SendToConsole("say Changed " + pname + "'s Team To Red!")
            } else {
                if (args=="blue") {
                    p.SetTeam(3)
                    SendToConsole("say Changed " + pname + "'s Team To Blue!")
                } else {
                    SendToConsole("say " + pname + " ERROR: Args were given but were not [red, blue]")
                }
            }
        }
    }


    //## NOCLIP COMMAND ##//
    local command="!noclip"
    if (ccmessage.find(command) != null) {
        local ourclass = FindPlayerClass(p)
        ourclass.noclip <- p.IsNoclipping()
        if (isadmin>=1) {
            local args = "DONTNOCLIP"
            try { args = ccmessage.slice(command.len()+ccmessage.find("!")+1, ccmessage.len()) } catch(e) { printl(e) }
            if (args=="on") {
                printl("noclipped: " + pname)
                EntFireByHandle(p, "addoutput", "MoveType 8", 0, null, null)
                ourclass.noclip <- true
            } else {
                if (args=="off") {
                    printl("noclipped: " + pname)
                    EntFireByHandle(p, "addoutput", "MoveType 2", 0, null, null)
                    ourclass.noclip <- false
                } else {
                    // SendToConsole("say " + pname + " ERROR: Invalid Option (please use \"on\" or \"off\")")
                    printl(ourclass.noclip)
                    if (ourclass.noclip == true) {
                        printl("noclipped: " + pname)
                        EntFireByHandle(p, "addoutput", "MoveType 2", 0, null, null)
                        ourclass.noclip <- false
                    } else {
                        printl("noclipped: " + pname)
                        EntFireByHandle(p, "addoutput", "MoveType 8", 0, null, null)
                        ourclass.noclip <- true
                    }
                }
            }
        } else {
            SendToConsole("say " + pname + " [you do not have access to this command]")
        }
    }

    //## GOD COMMAND ##//
    local command="!god"
    if (ccmessage.find(command) != null) {
        if (isadmin>=1) {
            local args = null
            try { args = ccmessage.slice(command.len()+1, ccmessage.len()) } catch(e) { printl(e) }
            if (args!=null) {
                if (args=="on") {
                    p.SetMaxHealth(999999)
                    p.SetHealth(999999)
                }
                if (args=="off") {
                    p.SetMaxHealth(100)
                    p.SetHealth(100)
                }
            } else {
                SendToConsole("say " + pname + " ERROR: No arguments provided!")
            }
        } else {
            SendToConsole("say " + pname + " [you do not have access to this command]")
        }
    }

    //## KILL COMMAND ##//
    if (ccmessage.find("!kill") != null) {
        local killargs = "DONTKILL"
        try { killargs = ccmessage.slice(6, ccmessage.len()) } catch(e) { printl(e) }

        if (killargs != "DONTKILL") {
            if (isadmin >= 1) {
                printl("Killed: " + killargs)
                local killplayerargs = null
                killplayerargs = FindPlayerByName(killargs)
                if (killplayerargs!=null) {
                    killplayerargs.SetHealth(1)
                    killplayerargs.SetMaxHealth(1)
                    EntFireByHandle(killplayerargs, "sethealth", "\"-999\"", 0.01, null, null)
                    EntFireByHandle(killplayerargs, "sethealth", "\"-999\"", 0.02, null, null)
                } else {
                    if (killargs == "all") {
                        local p2 = null
                        while (p2 = Entities.FindByClassname(p2, "player")) {
                            p2.SetHealth(1)
                            p2.SetMaxHealth(1)
                            EntFireByHandle(p2, "sethealth", "\"-999\"", 0.01, null, null)
                            EntFireByHandle(p2, "sethealth", "\"-999\"", 0.02, null, null)
                        }
                    } else {
                        SendToConsole("say" + pname + "ERROR: Player Not Found")
                    }
                }
            } else {
                SendToConsole("say " + pname + " [you must use !kill without any args as you do not have admin]")
            }
        } else {
            printl("killed: " + pname)
            p.SetHealth(1)
            p.SetMaxHealth(1)
            EntFireByHandle(p, "sethealth", "\"-999\"", 0.01, null, null)
            EntFireByHandle(p, "sethealth", "\"-999\"", 0.02, null, null)
        }
    }
}

//////////////////////////////
// Runs when a player joins //
//////////////////////////////

function OnPlayerJoin(p, script_scope) {

    //# Get player's index and store it #//
    PlayerID <- p.GetRootMoveParent()
    PlayerID <- PlayerID.entindex()

    //# Assign every new targetname to the player after blue and red are used #//
    if (PlayerID >= 3) {
        p.__KeyValueFromString("targetname", "player" + PlayerID)
    }

    //# Change player portal targetname #//
    local ent1 = null
    local ent2 = null
    local ent = null
    while (ent = Entities.FindByClassname(ent, "prop_portal")) {
        if (ent.GetName() == "") {
            if (ent1 == null) {
                ent1 = ent
            } else {
                ent2 = ent
            }
        }
    }

    try {
        if (ent1.entindex() > ent2.entindex()) {
            ent1.__KeyValueFromString("targetname", p.GetName() + "_portal-" + "2")
            ent2.__KeyValueFromString("targetname", p.GetName() + "_portal-" + "1")
        } else {
            ent1.__KeyValueFromString("targetname", p.GetName() + "_portal-" + "1")
            ent2.__KeyValueFromString("targetname", p.GetName() + "_portal-" + "2")
        }
    } catch (exception) {
        if (GetDeveloperLevel() == 1) {
            printl("(P2:MM): Failed to rename portals" + exception)
        }
    }

    //# Set viewmodel targetnames so we can tell them apart #//
    local ent = null
    while (ent=Entities.FindByClassname(ent, "predicted_viewmodel")) {
        EntFireByHandle(ent, "addoutput", "targetname viewmodel_player" + ent.GetRootMoveParent().entindex(), 0, null, null)
        // printl("(P2:MM): Renamed predicted_viewmodel to viewmodel_player" + ent.GetRootMoveParent().entindex())
        // printl("" + ent.GetRootMoveParent().entindex() + " rotation " + ent.GetAngles())
        // printl("" + ent.GetRootMoveParent().entindex() + "    origin " + ent.GetOrigin())
    }

    // If the player is the first player to join, Fix OrangeOldPlayerPos
    if (p.GetTeam() == 2) {
        if (OrangeCacheFailed==true) {
            OrangeOldPlayerPos <- p.GetOrigin()
            OrangeCacheFailed <- false
        }
    }

    // Run general map code after a player loads into the game
    if (PlayerID == 1) {
        PostMapLoad()
    }

    //# Set cvars on joining players' client #//
    SendToConsole("sv_timeout 3")
    EntFireByHandle(clientcommand, "Command", "stopvideos", 0, p, p)
    EntFireByHandle(clientcommand, "Command", "r_portal_fastpath 0", 0, p, p)
    EntFireByHandle(clientcommand, "Command", "r_portal_use_pvs_optimization 0", 0, p, p)
    MapSupport(false, false, false, false, true, false, false)

    //# Say join message on HUD #//
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
    }

    //# Set Player Color #//

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

    //# Setup Player Class #//
    local currentplayerclass = {}

    // player
    currentplayerclass.player <- p
    // player id
    currentplayerclass.id <- p.entindex()
    // player name
    if (PluginLoaded==true) {
        currentplayerclass.username <- GetPlayerName(p.entindex())
    }
    // player color
    local localcolorclass = {}
    localcolorclass.r <- R
    localcolorclass.g <- G
    localcolorclass.b <- B
    currentplayerclass.color <- localcolorclass
    // player noclip status
    currentplayerclass.noclip <- p.IsNoclipping()

    // Add player class to the player class array
    playerclasses.push(currentplayerclass)

    printl("===== Player Class =====")
    foreach (thing in FindPlayerClass(p)) {
        printl(thing)
    }
    printl("===================")
    printl("")
    printl(playerclasses[p.entindex()-1].color.r)
    printl(playerclasses[p.entindex()-1].color.g)
    printl(playerclasses[p.entindex()-1].color.b)

}

//////////////////////
// RUNS AFTER DEATH //
//////////////////////

function OnPlayerDeath(player) {
   if (GetDeveloperLevel() == 1) {
        printl("(P2:MM): Player died!")
        MapSupport(false, false, false, false, false, player, false)
   }
}

////////////////////////
// RUNS AFTER RESPAWN //
////////////////////////

function OnPlayerRespawn(player) {
    if (GetDeveloperLevel() == 1) {
        printl("(P2:MM): Player respawned!")
        MapSupport(false, false, false, false, false, false, player)
    }
}

///////////////////////////////////////
// RUNS AFTER BLUE INITALLY LOADS IN //
///////////////////////////////////////

function PostMapLoad() {
    // add a hook to the chat command function
    if (PluginLoaded==true) {
        printl("(P2:MM): Plugin Loaded")
        AddChatCallback("ChatCommands")
    }
    // Edit Cvars
    SendToConsole("mp_allowspectators 0")
    // Force spawn players in map
    AddBranchLevelName( 1, "" )
    MapSupport(false, false, false, true, false, false, false)
    CreatePropsForLevel(true, false, false)
    // Enable fast download
    SendToConsole("sv_downloadurl \"https://github.com/kyleraykbs/Portal2-32PlayerMod/raw/main/WebFiles/FastDL/portal2/\"")
    SendToConsole("sv_allowdownload 1")
    SendToConsole("sv_allowupload 1")
    if (DevMode==true) {
        SendToConsole("developer 1")
        StartDevModeCheck <- true
    }

    if (RandomTurrets==true) {
        CacheModel("npcs/turret/turret_skeleton.mdl")
        CacheModel("npcs/turret/turret_backwards.mdl")
        // CacheModel("npcs/turret/turret_boxed.mdl")
        // CacheModel("npcs/turret/turret_fx_laser_gib4.mdl")
        // CacheModel("npcs/turret/turret_fx_laser_gib4.mdl")
    }

	//gelocity alias, put gelocity1(2,or 3) into console to easier changelevel
	SendToConsole("alias gelocity1 changelevel workshop/596984281130013835/mp_coop_gelocity_1_v02")
	SendToConsole("alias gelocity2 changelevel workshop/594730048530814099/mp_coop_gelocity_2_v01")
	SendToConsole("alias gelocity3 changelevel workshop/613885499245125173/mp_coop_gelocity_3_v02")
}

//////////////////////////////////////
// RUNS AFTER EVERYONE FIRST SPAWNS //
//////////////////////////////////////

function GeneralOneTime() {
    // Single player maps with chapter titles
    local CHAPTER_TITLES =
    [
        { map = "sp_a1_intro1", title_text = "#portal2_Chapter1_Title", subtitle_text = "#portal2_Chapter1_Subtitle", displayOnSpawn = false,		displaydelay = 1.0 },
        { map = "sp_a2_laser_intro", title_text = "#portal2_Chapter2_Title", subtitle_text = "#portal2_Chapter2_Subtitle", displayOnSpawn = true,	displaydelay = 2.5 },
        { map = "sp_a2_sphere_peek", title_text = "#portal2_Chapter3_Title", subtitle_text = "#portal2_Chapter3_Subtitle", displayOnSpawn = true,	displaydelay = 2.5 },
        { map = "sp_a2_column_blocker", title_text = "#portal2_Chapter4_Title", subtitle_text = "#portal2_Chapter4_Subtitle", displayOnSpawn = true, displaydelay = 2.5 },
        { map = "sp_a2_bts3", title_text = "#portal2_Chapter5_Title", subtitle_text = "#portal2_Chapter5_Subtitle", displayOnSpawn = true,			displaydelay = 1.0 },
        { map = "sp_a3_00", title_text = "#portal2_Chapter6_Title", subtitle_text = "#portal2_Chapter6_Subtitle", displayOnSpawn = true,			displaydelay = 1.5 },
        { map = "sp_a3_speed_ramp", title_text = "#portal2_Chapter7_Title", subtitle_text = "#portal2_Chapter7_Subtitle", displayOnSpawn = true,	displaydelay = 1.0 },
        { map = "sp_a4_intro", title_text = "#portal2_Chapter8_Title", subtitle_text = "#portal2_Chapter8_Subtitle", displayOnSpawn = true,			displaydelay = 2.5 },
        { map = "sp_a4_finale1", title_text = "#portal2_Chapter9_Title", subtitle_text = "#portal2_Chapter9_Subtitle", displayOnSpawn = false,		displaydelay = 1.0 },
    ]

    // Attempt to display chapter title
    foreach (index, level in CHAPTER_TITLES)
	{
		if (level.map == GetMapName() && level.displayOnSpawn )
		{
            foreach (index, level in CHAPTER_TITLES)
            {
                if (level.map == GetMapName() )
                {
                    EntFire( "@chapter_title_text", "SetTextColor", "210 210 210 128", 0.0 )
                    EntFire( "@chapter_title_text", "SetTextColor2", "50 90 116 128", 0.0 )
                    EntFire( "@chapter_title_text", "SetPosY", "0.32", 0.0 )
                    EntFire( "@chapter_title_text", "SetText", level.title_text, 0.0 )
                    EntFire( "@chapter_title_text", "display", "", level.displaydelay )

                    EntFire( "@chapter_subtitle_text", "SetTextColor", "210 210 210 128", 0.0 )
                    EntFire( "@chapter_subtitle_text", "SetTextColor2", "50 90 116 128", 0.0 )
                    EntFire( "@chapter_subtitle_text", "SetPosY", "0.35", 0.0 )
                    EntFire( "@chapter_subtitle_text", "settext", level.subtitle_text, 0.0 )
                    EntFire( "@chapter_subtitle_text", "display", "", level.displaydelay )
                }
            }
		}
	}
    
    // Load the plugin if it's not already loaded
    if (RunPluginLoad==true) {
        printl("(P2:MM): Loading plugin... Restarting map")
        // Load plugin
        EntFireByHandle(pluginloadcommand, "Command", "plugin_load 32pmod", 0, null, null)
        // Wait for plugin to load and then restart map
        EntFireByHandle(pluginloadcommand, "Command", "changelevel mp_coop_lobby_3", 0, null, null)
        LoadPlugin <- false
    }

    // Clear all cached models from our temp cache as they are already cached
    CanClearCache <- true

    // Set a varible to tell the map loaded
    HasSpawned <- true

    // show the chat again
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
        if (GetDeveloperLevel() == 1) {
            printl("(P2:MM): OrangeOldPlayerPos not set (Blue probably moved before Orange could load in) Setting OrangeOldPlayerPos to BlueOldPlayerPos")
        }
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
        if (GetDeveloperLevel() == 1) {
            printl("(P2:MM): Blue dropper not found!")
        }
    }

    // Force open the red player droppers
    printl(OrangeOldPlayerPos)
    printl(OldPlayerPos)

    local radius = 150

    if (OrangeCacheFailed==true) {
        radius = 350
    }

    try {
        local ent = null
        while(ent = Entities.FindByClassnameWithin(ent, "prop_dynamic", Vector(OrangeOldPlayerPos.x, OrangeOldPlayerPos.y, OldPlayerPos.z-300), radius)) {
            if (ent.GetModelName() == "models/props_underground/underground_boxdropper.mdl" || ent.GetModelName() == "models/props_backstage/item_dropper.mdl") {
                EntFireByHandle(ent, "setanimation", "open", 0, null, null)
                if (ent.GetModelName() == "models/props_backstage/item_dropper.mdl") {
                    EntFireByHandle(ent, "setanimation", "item_dropper_open", 0, null, null)
                }
                ent.__KeyValueFromString("targetname", "RedDropperForcedOpenMPMOD")
            }
        }
    } catch(exeption) {
        if (GetDeveloperLevel() == 1) {
            printl("(P2:MM): Red dropper not found!")
        }
    }
    local radius = null

    //# Attempt to fix some general map issues #//
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

//## Import map support code ##//
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
