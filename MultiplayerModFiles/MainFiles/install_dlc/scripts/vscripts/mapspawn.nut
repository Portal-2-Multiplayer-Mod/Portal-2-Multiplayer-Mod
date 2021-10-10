//===================================
//             COPYRIGHT
//2020 Portal 2: Multiplayer Mod Team 
//     under a GNU GPLv3 license
//===================================

///////////////
DevMode <- true
///////////////

IsInSpawnZone <- []
HasSpawned <- false
PlayerColorCached <- []
CheatsOff <- 0
ReadyCheatsOff <- 0
PlayerJoined <- 0
PlayerID <- 0
GBIsMultiplayer <- 0
DedicatedServerOneTimeRun <- 1
TryGelocity <- 1
TryGelocity2 <- 1
TryGelocity3 <- 1
copp <- 0
WFPDisplayDisabled <- 0
IsSingleplayerMap <- 0
LoadPlugin <- false
PluginLoaded <- true

// is dedicated server
DedicatedServer <- 0

// initialization code
function init() {

    // run singleplayer code
    if (GetMapName().slice(0, 7) != "mp_coop") {
        Singleplayer()
    }

    // enable fast download
    SendToConsole("sv_downloadurl https://github.com/kyleraykbs/gilbert/raw/main/portal2")
    SendToConsole("sv_allowdownload 1")
    SendToConsole("sv_allowupload 1")

    // create an on screen text message entity
    onscreendisplay <- Entities.CreateByClassname("game_text")
    onscreendisplay.__KeyValueFromString("targetname", "onscreendisplaympmod")
    onscreendisplay.__KeyValueFromString("message", "Waiting For Players...")
    onscreendisplay.__KeyValueFromString("holdtime", "0.2")
    onscreendisplay.__KeyValueFromString("fadeout", "0.2")
    onscreendisplay.__KeyValueFromString("fadein", "0.2")
    onscreendisplay.__KeyValueFromString("spawnflags", "1")
    onscreendisplay.__KeyValueFromString("color", "60 200 60")
    onscreendisplay.__KeyValueFromString("channel", "1")
    //onscreendisplay.__KeyValueFromString("x", "-1.1")
    //onscreendisplay.__KeyValueFromString("y", "-1.1")

    // create a join message entity
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

    // create entity to run loop() every 0.1 seconds
    timer <- Entities.CreateByClassname("logic_timer")
    timer.__KeyValueFromString("targetname", "timer")
    EntFireByHandle(timer, "AddOutput", "RefireTime 0.1", 0, null, null)
    EntFireByHandle(timer, "AddOutput", "classname move_rope", 0, null, null)
    EntFireByHandle(timer, "AddOutput", "OnTimer worldspawn:RunScriptCode:loop():0:-1", 0, null, null)
    EntFireByHandle(timer, "Enable", "", 0.1, null, null)

    // create an entity that sends a client command
    clientcommand <- Entities.CreateByClassname("point_clientcommand")

    // load plugin
    if("getPlayerName" in this) {
        printl("=================================")
        printl("Plugin Already Loaded Skipping...")
        printl("=================================")
    } else {
        printl("============================")
        printl("Plugin Not Loaded Loading...")
        printl("============================")
        pluginloadcommand <- Entities.CreateByClassname("point_servercommand")
        // SendToConsole("plugin_load pl")
        LoadPlugin <- true
        PluginLoaded <- false
    }

    /***********************
    * run map support code *
    ***********************/

    // run lobby code
    if (GetMapName() == "mp_coop_lobby_3") {
        LobbyOneTimeRun()
    }

    // run mp_coop_tripleaxis code
    if (GetMapName() == "mp_coop_tripleaxis") {
        mp_coop_tripleaxisFIX()
    }

    // run mp_coop_separation_1 code
    if (GetMapName() == "mp_coop_separation_1") {
        mp_coop_separation_1FIX()
    }

    // run mp_coop_paint_conversion code
    if (GetMapName() == "mp_coop_paint_conversion") {
        mp_coop_paint_conversionFIX()
    }

    // run gelocity code
    if (TryGelocity == 1) {
        try {
            if (GetMapName().slice(28, 50) == "mp_coop_gelocity_1_v02") {
                Gelocity()
            }
        } catch(exception) {
            TryGelocity <- 0
        }
    }

    // run gelocity 2 code
    if (TryGelocity2 == 1) {
        try {
            if (GetMapName().slice(28, 50) == "mp_coop_gelocity_2_v01") {
                Gelocity2()
            }
        } catch(exception) {
            TryGelocity2 <- 0
        }
    }

    // run gelocity 3 code
    if (TryGelocity3 == 1) {
        try {
            if (GetMapName().slice(28, 50) == "mp_coop_gelocity_3_v02") {
                Gelocity3()
            }
        } catch(exception) {
            TryGelocity3 <- 0
        }
    }
}
//END OF INIT CODE


/*******************
********************
* global functions *
********************
*******************/

//Teleport Players Within A Distance
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

function DeleteModels(ModelName) {
    local ent = null
    while (ent=Entities.FindByModel(ent, "models/"+ModelName)) {
        printl("Model " + ModelName + " deleted!")
    }
}

function CacheModel(ModelName) {
        if (Entities.FindByModel(null, "models/"+ModelName)) {
            printl("Model " + ModelName + " is already cached!")
        } else {
        SendToConsole("sv_cheats 1")
        SendToConsole("prop_dynamic_create " + ModelName)
        SendToConsole("sv_cheats 0")
        //Delete previously created entity
        printl("Model " + ModelName + " has been cached sucessfully!")
        DelModel(ModelName)
    }
}
/*******************
* multiplayer code *
*******************/

// set GBIsMultiplayer if game is multiplayer
try {
    if (::IsMultiplayer()) {
        GBIsMultiplayer <- 1
    }
} catch(exception) {
    GBIsMultiplayer <- 0
}

OnPlayerJoin <- function() {
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        if (p.ValidateScriptScope()) {
            local script_scope = p.GetScriptScope()
            if (!("Colored" in script_scope)) {

                // get player's index and store it
                PlayerID <- p.GetRootMoveParent()
                PlayerID <- PlayerID.entindex()

                //load plugin
                if (LoadPlugin==true) {
                    EntFireByHandle(pluginloadcommand, "Command", "plugin_load pl", 0, null, null)
                    EntFireByHandle(pluginloadcommand, "Command", "changelevel mp_coop_lobby_3", 0, null, null)
                    LoadPlugin <- false
                }

                // enable cvars on client
                SendToConsole("sv_timeout 3")
                SendToConsole("gameinstructor_enable 1")
                EntFireByHandle(clientcommand, "Command", "bind tab +score", 0, p, p)
                EntFireByHandle(clientcommand, "Command", "stopvideos", 0, p, p)
                EntFireByHandle(clientcommand, "Command", "r_portal_fastpath 0", 0, p, p)
                EntFireByHandle(clientcommand, "Command", "r_portal_use_pvs_optimization 0", 0, p, p)

                // say join message
                if (PluginLoaded==true) {
                    JoinMessage <- "Player " + getPlayerName(PlayerID-1) + " Joined The Game"
                    JoinMessage = JoinMessage.tostring()
                    joinmessagedisplay.__KeyValueFromString("message", JoinMessage)
                    EntFireByHandle(joinmessagedisplay, "display", "", 0.0, null, null)
                    if (PlayerID >= 2) {
                        onscreendisplay.__KeyValueFromString("y", "0.075")
                    }
                }
                // assign player targetname
                if (PlayerID >= 3) {
                    p.__KeyValueFromString("targetname", "player" + PlayerID)
                }

                // set random color if over 16
                if (PlayerID != 1) {
                    R <- RandomInt(0, 255), G <- RandomInt(0, 255), B <- RandomInt(0, 255)
                    ReadyCheatsOff <- 1
                }

                // create a nametag display entity
                colordisplay <- Entities.CreateByClassname("game_text")
                colordisplay.__KeyValueFromString("targetname", "colordisplay" + PlayerID)
                colordisplay.__KeyValueFromString("x", "0")
                colordisplay.__KeyValueFromString("holdtime", "100000")
                colordisplay.__KeyValueFromString("fadeout", "0")
                colordisplay.__KeyValueFromString("fadein", "0")
                colordisplay.__KeyValueFromString("channel", "0")
                colordisplay.__KeyValueFromString("y", "1")

                // set preset colors up to 16
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

                script_scope.Colored <- true
                EntFireByHandle(p, "Color", (R + " " + G + " " + B), 0, null, null)

                return
                }
            }
        }
    }   

////////////////////////////
    /*******************
    *     loop code    *
    *******************/
////////////////////////////
    
    function loop() {

        OnPlayerJoin() // run player join code 

        General() // run general code

        AllMapsLoopCode() // run map loops

        //detect death
        if (HasSpawned==true) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                if (!Entities.FindByNameWithin(null, p.GetName(), OldPlayerPos, 45) && !Entities.FindByNameWithin(null, p.GetName(), OrangeOldPlayerPos, 45))  {
                    foreach (index, item in IsInSpawnZone)  {
                        if (item == p.GetRootMoveParent().entindex().tostring())  {
                            IsInSpawnZone.remove(index)
                        }
                    }
                }

            ContinueDeathCode <- true
            foreach (Name in IsInSpawnZone) {
                if (Name==p.GetRootMoveParent().entindex().tostring()) {
                    ContinueDeathCode <- false
                }
            }

            if (ContinueDeathCode==true) {
                if (Entities.FindByNameWithin(null, p.GetName(), OldPlayerPos, 45) || Entities.FindByNameWithin(null, p.GetName(), OrangeOldPlayerPos, 45)) {
                    //ON DEATH
                    printl("Player " + p.GetRootMoveParent().entindex().tostring() + " Has Respawned")
                    //show player color again
                    foreach (index, item in PlayerColorCached)  {
                        if (item == p.GetRootMoveParent().entindex().tostring())  {
                            PlayerColorCached.remove(index)
                        }
                    }
                    //END OF ON DEATH
                    IsInSpawnZone.push(p.GetRootMoveParent().entindex().tostring())
                    }
                }
            }
        }

        //display the current player color in the bottom right of their screen
        if (HasSpawned==true) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                CanTag <- true
                foreach (Name in PlayerColorCached) {
                    if (Name==p.GetRootMoveParent().entindex().tostring()) {
                        CanTag <- false
                    }
                }
                currentnametag <- p.GetRootMoveParent().entindex().tostring()
                if (CanTag==true) {
                        RGB <- "255 255 255"; COLORMESSAGE <- "Random Color";
                        switch (p.GetRootMoveParent().entindex()) {
                            case 1 : RGB <- "255 255 255"; COLORMESSAGE <- "White"     ; break;
                            case 2 : RGB <- "120 255 120"; COLORMESSAGE <- "Green"     ; break;
                            case 3 : RGB <- "120 140 255"; COLORMESSAGE <- "Blue"      ; break;
                            case 4 : RGB <- "255 170 120"; COLORMESSAGE <- "Orange"    ; break;
                            case 5 : RGB <- "255 100 100"; COLORMESSAGE <- "Red"       ; break;
                            case 6 : RGB <- "255 110 255"; COLORMESSAGE <- "Pink"      ; break;
                            case 7 : RGB <- "255 255 180"; COLORMESSAGE <- "Yellow"    ; break;
                            case 8 : RGB <- "0 255 240"  ; COLORMESSAGE <- "Aqua"      ; break;
                            case 9 : RGB <- "75 75 75"   ; COLORMESSAGE <- "Black"     ; break;
                            case 10: RGB <- "100 80 0"   ; COLORMESSAGE <- "Brown"     ; break;
                            case 11: RGB <- "0 80 100"   ; COLORMESSAGE <- "Dark Cyan" ; break;
                            case 12: RGB <- "120 155 25" ; COLORMESSAGE <- "Dark Lime" ; break;
                            case 13: RGB <- "0 0 100"    ; COLORMESSAGE <- "Dark Blue" ; break;
                            case 14: RGB <- "80 0 0"     ; COLORMESSAGE <- "Dark Red"  ; break;
                            case 15: RGB <- "0 75 0"     ; COLORMESSAGE <- "Dark Green"; break;
                            case 16: RGB <- "0 75 75"    ; COLORMESSAGE <- "Dark Aqua" ; break;
                        }
                        Entities.FindByName(null, "colordisplay" + currentnametag).__KeyValueFromString("message", "Player Color: " + COLORMESSAGE)
                        Entities.FindByName(null, "colordisplay" + currentnametag).__KeyValueFromString("color", RGB)
                        EntFireByHandle(Entities.FindByName(null, "colordisplay" + currentnametag), "display", "", 0.0, p, p)
                        PlayerColorCached.push(currentnametag);
                }
            }
        }

        //disconnect player if trying to play singleplayer
        if (GBIsMultiplayer==0) {
            SendToConsole("disconnect \"You cannot play singleplayer when Portal 2 is launched from the Multiplayer Mod Launcher. Please restart the game from Steam\"")
        }

        // singleplayer loop
        if (GetMapName().slice(0, 7) != "mp_coop") {
            SingleplayerLoop()
        }

        // run dedicated server code
        if (DedicatedServer == 1) {
            DedicatedServerFunc()
        }

        // disable collision
        //local j = "solid "
        local k = "CollisionGroup "

        //EntFire("player", "addoutput", j + 4)
        EntFire("player", "addoutput", k + 2)

        // turn cheats off if ready (sv_cheats 0)
        if (ReadyCheatsOff == 1) {
            if (CheatsOff == 0) {
                if (GetMapName() == "mp_coop_lobby_3") {
                    //SendToConsole("sv_cheats 0")
                }
                CheatsOff <- 1
            }
        }

        if (DevMode==true) {
            DevHacks()
        }
    }
/**********************************/
        ////////////////////
        //END OF LOOP CODE//
        ////////////////////
/**********************************/

    // lobby setup code
    function LobbyOneTimeRun() {
        //activate whole lobby
        try {
            // enable team building course
            DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null, "relay_reveal_teambuilding"))
            DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null, "relay_reveal_teambuilding"))

            // enable tbeam course
            DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null, "relay_reveal_tbeam"))
            DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null, "relay_reveal_tbeam"))

            // enable paint course
            DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null, "relay_reveal_paint"))
            DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null, "relay_reveal_paint"))

            // enable fling course
            DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null, "relay_reveal_fling"))
            DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null, "relay_reveal_fling"))

            // enable extra course
            DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null, "relay_reveal_extra"))
            DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null, "relay_reveal_extra"))

            // enable all finished course
            DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null, "relay_reveal_all_finished"))
            DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null, "relay_reveal_all_finished"))

            // enable music
            DoEntFire("!self", "invalue", "7", 0.0, null, Entities.FindByName(null, "@music_lobby_7"))
            // Entities.FindByName(null, "brush_spawn_blocker_red").Destroy()
            // Entities.FindByName(null, "brush_spawn_blocker_blue").Destroy()
        } catch(exception) {}
        // remove entities
        // fix edicts error
        local ent = null
        while(ent = Entities.FindByClassname(ent, "func_portal_bumper")) {
            ent.Destroy() // 165 entities removed
        }

        // fix art therapy tube glitches
        Entities.FindByName(null, "dlc_room_fall_push_right").Destroy()
        Entities.FindByName(null, "dlc_room_fall_push_left").Destroy()

        // fix track 5
        // entry door fix
        Entities.FindByName(null, "track5-door_paint-trigger_hurt_door").Destroy()
        Entities.FindByName(null, "track5-door_paint-collide_door").Destroy()

        // light fix
        Entities.FindByName(null, "@light_shadowed_paintroom").Destroy()

        // remove orange exit door
        local ent = null
        while(ent = Entities.FindByName(ent, "track5-orangeiris_door_elevator_pit")) {
            ent.Destroy()
        }

        Entities.FindByName(null, "track5-orangeescape_elevator_clip").Destroy()

        // remove blue exit door
        local ent = null
        while(ent = Entities.FindByName(ent, "track5-iris_door_elevator_pit")) {
            ent.Destroy()
        }

        Entities.FindByName(null, "track5-escape_elevator_clip").Destroy()
    }

    /*******************
    * map support code *
    *******************/

    // general fixes for all maps
    function General() {
            // display waiting for players and run nessacary code after spawn
            if (WFPDisplayDisabled == 0) { 
                        try {
                if (copp == 0) {
                    OldPlayerPos <- Entities.FindByName(null, "blue").GetOrigin()
                    copp <- 1
                }
            } catch(exception) {}

            try {
                // see if player is in spawn zone
                if (Entities.FindByNameWithin(null, "blue", OldPlayerPos, 35)) {
                    DoEntFire("onscreendisplaympmod", "display", "", 0.0, null, null)
                } else {
                    WFPDisplayDisabled <- 1
                    GeneralOneTime()
                }
            } catch(exception) {}
        }

        // remove dropper bottom
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

    // general one time run
    function GeneralOneTime() {

        HasSpawned <- true

        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            if (p.GetTeam()==2) {
                OrangeOldPlayerPos <- p.GetOrigin()
            }
        }

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

        local ent = null
        while (ent = Entities.FindByClassname(ent, "trigger_playerteam")) {
            DoEntFire("!self", "starttouch", "", 0.0, null, ent)
        }

        // map support
        if (GetMapName() == "mp_coop_separation_1") {
            mp_coop_separation_1FIXONETIME()
        }
        
    }

    //run all required map loops every tick
    function AllMapsLoopCode() {
        // run all required loops
        if (GetMapName() == "mp_coop_lobby_3") {
            ArtTherapyLobby()
            }

        // run credits code
        if (GetMapName() == "mp_coop_credits") {
            CreditsLoop()
        }

                if (GetMapName() == "mp_coop_wall_5") {
            mp_coop_wall_5FIX()
        }

        if (GetMapName() == "mp_coop_2paints_1bridge") {
            mp_coop_2paints_1bridgeFIX()
        }
    }

    // art therapy lobby
    function ArtTherapyLobby() {
        // TPG
        local PLent = null
        while(PLent = Entities.FindByClassnameWithin(PLent, "player", Vector(2367, -8126, -54), 30)) {
            local APLent = null
            while(APLent = Entities.FindByClassname(APLent, "player")) {
                APLent.SetOrigin(Vector(2495, -7451, 410))
            }
        }

        // art therapy left chute enabler
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

        // art therapy left chute teleporter
        TeleportPlayerWithinDistance(Vector(5729, 3336, 1005), 30, Vector(3194, -1069, 1676))

        // art therapy right chute enabler
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

        // art therapy right chute teleporter
        TeleportPlayerWithinDistance(Vector(5727, 3180, 1005), 30, Vector(3191, -1228, 1682))

        // disable art therapy chutes
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

        // teleport exiting player out of art therapy
        TeleportPlayerWithinDistance(Vector(3584, -1669, 466), 30, Vector(3919, 3352, 158))
    }

    // fix mp_coop_2paints_1bridge
    function mp_coop_2paints_1bridgeFIX() {
        EntFireByHandle(Entities.FindByName(null, "bridge_2"), "enable", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "bridge_1"), "enable", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "paint_sprayer_blue_1"), "start", "", 0, null, null)
    }

    // mp_coop_tripleaxis fix
    function mp_coop_tripleaxisFIX() {
        Entities.FindByName(null, "outro_math_counter").Destroy()
    }

    //mp_coop_wall_5
    function mp_coop_wall_5FIX() {
        TeleportPlayerWithinDistance(Vector(1224, -1984, 565), 100, Vector(1208, -1989, 315))
    }

    // mp_coop_separation_1 fix
    function mp_coop_separation_1FIX() {
        EntFireByHandle(Entities.FindByName(null, "left_1st_room_spawn-initial_blue_spawn"), "SetAsActiveSpawn", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "right_1st_room_spawn-initial_orange_spawn"), "SetAsActiveSpawn", "", 0, null, null)
        Entities.FindByName(null, "split_counter").Destroy()
    }

    // mp_coop_separation_1 fix onetime
    function mp_coop_separation_1FIXONETIME() {
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

    // mp_coop_paint_conversion fix
    function mp_coop_paint_conversionFIX() {
        Entities.FindByName(null, "disassembler_1_door_blocker").Destroy()
        Entities.FindByName(null, "disassembler_2_door_blocker").Destroy()

        Entities.FindByName(null, "disassembler_1_door_2").Destroy()
        Entities.FindByName(null, "disassembler_1_door_1").Destroy()

        Entities.FindByName(null, "disassembler_2_door_2").Destroy()
        Entities.FindByName(null, "disassembler_2_door_1").Destroy()
    }

    // gelocity 1 code
    function Gelocity() {
        DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "door2_player2"))
        DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "door2_player1"))
        DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "start_clip_1"))
        DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null, "start_clip_2"))

        local ent = null
        while(ent = Entities.FindByClassname(ent, "func_portal_bumper")) {
            ent.Destroy() // 20 entities removed
        }

        while(ent = Entities.FindByClassname(ent, "beam_spotlight")) {
            ent.Destroy() // 85 entities removed
        }
    }

    // gelocity 2 code
    function Gelocity2() {
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

    // gelocity 3 code
    function Gelocity3() {
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

    // dedicated server code
    function DedicatedServerFunc() {
        if (DedicatedServerOneTimeRun == 1) {print()}

        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            if (p.entindex() == 1) {
                EntFireByHandle(clientcommand, "Command", "exec DedicatedServerCommands", 0, p, p)
                // set size to 0
                EntFireByHandle(p, "AddOutput", "ModelScale 0", 0, null, null)
            }
        }
    }

    /**********
    * credits *
    **********/

    // remove selected pods
    function CreditsRemovePod() {
        local ent = null
        while (ent = Entities.FindByNameNearest("chamber*", Vector(-64, 217, 72), 100)) {
            ent.Destroy()
        }

        while (ent = Entities.FindByNameNearest("bubbles*", Vector(-64, 217, 72), 100)) {
            ent.Destroy()
        }
    }

    // fix void camera glitch
    function FixCreditsCameras() {
        // disable useless cameras
        EntFireByHandle(Entities.FindByName(null, "camera_SP"), "disable", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "camera_O"), "disable", "", 0, null, null)

        // reload main camera with new params
        Entities.FindByName(null, "camera").__KeyValueFromString("target_team", "-1")
        EntFireByHandle(Entities.FindByName(null, "camera"), "disable", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "camera"), "enable", "", 0, null, null)
    }

    // replace females with pbodys
    function CreditsSetModelPB(ent) {
        FixCreditsCameras()

        // count how many credits come on screen to change to humans
        MPMCredits <- MPMCredits + 1

        // preset animation
        local RandomAnimation = RandomInt(0, CRAnimationTypesPB)

        // remove pod if needed
        HasRemovedPod <- 0
        foreach (anim in NOTubeAnimsPB) {
            if (AnimationsPB[RandomAnimation] == anim && HasRemovedPod == 0) {
                HasRemovedPod <- 1
                CreditsRemovePod()
            }
        }

        // set model
        ent.SetModel("models/player/eggbot/eggbot.mdl")

        // set color
        EntFireByHandle(ent, "Color", (RandomInt(0, 255) + " " + RandomInt(0, 255) + " " + RandomInt(0, 255)), 0, null, null)

        // set position
        ent.SetOrigin(Vector(0, 0, 7.5))

        // set animation
        EntFireByHandle(ent, "setanimation", AnimationsPB[RandomAnimation], 0, null, null)
    }

    // replace males with atlases
    function CreditsSetModelAL(ent) {
        FixCreditsCameras()

        // count how many credits come on screen to change to humans
        MPMCredits <- MPMCredits + 1

        // preset animation
        local RandomAnimation = RandomInt(0, CRAnimationTypesAL)

        // set model
        ent.SetModel("models/player/ballbot/ballbot.mdl")

        // set color
        EntFireByHandle(ent, "Color", (RandomInt(0, 255) + " " + RandomInt(0, 255) + " " + RandomInt(0, 255)), 0, null, null)

        // set position
        ent.SetOrigin(Vector(-10, 0, 25.5))

        // set animation
        EntFireByHandle(ent, "setanimation", AnimationsAL[RandomAnimation], 0, null, null)

        // remove pod if needed
        HasRemovedPod <- 0
        foreach (anim in NOTubeAnimsAL) {
            if (AnimationsAL[RandomAnimation] == anim && HasRemovedPod == 0) {
                HasRemovedPod <- 1
                CreditsRemovePod()
                ent.SetOrigin(Vector(0, 0, 7.5))
            }
        }
    }

    function CreditsLoop() {
        // if mod credits aren't finished change humans to robots
        if (MPMCredits <= MPModCreditNumber) {
            // change males to atlases
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

            // change females to pbodys
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

    // credits one time run code
    if (GetMapName() == "mp_coop_credits") {
        // set credits animations
        // pbody animations
        AnimationsPB <- ["taunt_laugh", "taunt_teamhug_idle", "noGun_crouch_idle", "taunt_face_palm", "taunt_selfspin", "taunt_pretzelwave", "noGun_airwalk", "noGun_airwalk", "portalgun_drowning", "layer_taunt_noGun_small_wave", "taunt_highFive_idle"]

        // atlas animations
        AnimationsAL <- ["taunt_laugh", "taunt_laugh", "taunt_teamhug_initiate", "taunt_teamhug_noShow", "ballbot_taunt_rps_shake", "taunt_basketball2", "taunt_headspin", "taunt_facepalm", "taunt_shrug", "layer_taunt_trickfire_handstand", "portalgun_jump_spring", "portalgun_thrash_fall", "noGun_crouch_idle", "noGun_airwalk", "noGun_airwalk"]

        // pbody animations out of tube
        NOTubeAnimsPB <- ["taunt_laugh", "taunt_teamhug_idle", "noGun_crouch_idle", "taunt_face_palm", "taunt_selfspin", "taunt_pretzelwave", "layer_taunt_noGun_small_wave", "taunt_highFive_idle"]

        // atlas animations out of tube
        NOTubeAnimsAL <- ["taunt_laugh", "taunt_laugh", "taunt_teamhug_initiate", "taunt_teamhug_noShow", "ballbot_taunt_rps_shake", "taunt_basketball2", "taunt_headspin", "taunt_facepalm", "taunt_shrug", "layer_taunt_trickfire_handstand", "noGun_crouch_idle"]

        // credit run counter
        MPMCredits <- 0

        // set the amount of pbody animations
        CRAnimationTypesPB <- -1
        foreach (value in AnimationsPB) {
            CRAnimationTypesPB <- CRAnimationTypesPB + 1
        }

        // set the amount of atlas animations
        CRAnimationTypesAL <- -1
        foreach (value in AnimationsAL) {
            CRAnimationTypesAL <- CRAnimationTypesAL + 1
        }

        // add team names to credits
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
        "kyleraykbs | Scripting + Team Lead",
        "Bumpy | Scripting + Script Theory",
        "Vista | Reverse Engineering",
        "Wolfe Strider Shooter | Scripting",
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
        "charzar",
        "Enator",
        "NintenDude 👎",
        "SlingEXE 👎",
        "--------------------------",
        "Thank you all so so much!!!",
        "--------------------------"
        "",
        "",
        "--------------------------",
        "Valve: Credits",
        "--------------------------",
        ]

        // set the amount of credits
        MPModCreditNumber <- -1
        foreach (value in MPMCoopCreditNames) {
            MPModCreditNumber <- MPModCreditNumber + 1
        }

        // mount list of credits to credits
        foreach (Name in MPMCoopCreditNames) {
            AddCoopCreditsName(Name)
        }
    }

    // run init code
    Entities.First().ConnectOutput("OnUser1", "init")
    DoEntFire("worldspawn", "FireUser1", "", 0.0, null, null)

/*************************
* singleplayer functions *
*************************/

function Singleplayer() {
    // sp_a1_intro2
    if (GetMapName() == "sp_a1_intro2") {
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        SendToConsole("commentary 0")
        Entities.FindByName(null, "@entry_door-door_close_relay").Destroy()
        Entities.FindByName(null, "@exit_door-door_close_relay").Destroy()
        Entities.FindByName(null, "Fizzle_Trigger").Destroy()
    }

    // sp_a1_intro3
    if (GetMapName() == "sp_a1_intro3") {
        Entities.FindByName(null, "door_0-door_close_relay").Destroy()
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        Entities.FindByName(null, "player_clips").Destroy()
        // destroy pusher x4
        Entities.FindByName(null, "podium_collapse_push_brush").Destroy()
        Entities.FindByName(null, "podium_collapse_push_brush").Destroy()
        Entities.FindByName(null, "podium_collapse_push_brush").Destroy()
        Entities.FindByName(null, "podium_collapse_push_brush").Destroy()
        Entities.FindByName(null, "door_3-door_close_relay").Destroy()
        Entities.FindByName(null, "portal_orange_2").Destroy()
        Entities.FindByName(null, "emitter_orange_2").Destroy()
        Entities.FindByName(null, "backtrack_brush").Destroy()
        Entities.FindByName(null, "portal_orange_mtg").Destroy()
        Entities.FindByName(null, "emitter_orange_mtg").Destroy()
        hasgotportalgunSPMP <- 0
        timeout <- 1
    }

    // sp_a1_intro4
    if (GetMapName() == "sp_a1_intro4") {
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        Entities.FindByName(null, "door_0-door_close_relay").Destroy()
        Entities.FindByName(null, "just_enough_door_for_the_job-door_close_relay").Destroy()
        EntFireByHandle(Entities.FindByName(null, "glass_pane_intact_model"), "kill", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "glass_pane_fractured_model"), "enable", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "glass_pane_1_door_1"), "open", "", 0, null, null)
        Entities.FindByName(null, "glass_pane_1_door_1_blocker").Destroy()
    }
}

/////////////
//DEV HACKS//
/////////////
function DevHacks() {
    if (GetMapName()=="mp_coop_paint_longjump_intro") {
        //airlockexit teleport
        local ent = null
        while(ent = Entities.FindByNameWithin(ent, "blue", Vector(80, -7567, 960), 200)) {
            ent.SetOrigin(Vector(243, -7037, 960))
        }

        //teleportfromexit to gel
        local ent = null
        while(ent = Entities.FindByNameWithin(ent, "blue", Vector( 80, -7087, 960), 90)) {
            ent.SetOrigin(Vector(198, -6553, 960))
        }

        //yeet to brig
        local ent = null
        while(ent = Entities.FindByNameWithin(ent, "blue", Vector( 220, -5829, 807), 350)) {
            ent.SetOrigin(Vector(257, -5352, 960))
        }


        //orang brig
        local ent = null
        while(ent = Entities.FindByNameWithin(ent, "blue", Vector( -437, -1541, 448), 80)) {
            ent.SetOrigin(Vector(-453, -1541, 942))
        }

        //speee juhmp
        local ent = null
        while(ent = Entities.FindByNameWithin(ent, "blue", Vector( -1, 406, 104), 80)) {
            ent.SetOrigin(Vector(-136, 58, 1027))
        }

        //speee juhmp minr
        local ent = null
        while(ent = Entities.FindByNameWithin(ent, "blue", Vector( 431, -2127, 448), 80)) {
            ent.SetOrigin(Vector(-136, 58, 1027))
        }

        //speee oragneuntp
        local ent = null
        while(ent = Entities.FindByNameWithin(ent, "blue", Vector( -448, -1543, 758), 80)) {
            ent.SetOrigin(Vector(-471, -1722, 975))
        }

        //tp tu vaulht
        local ent = null
        while(ent = Entities.FindByNameWithin(ent, "blue", Vector( 390, -4977, 960), 80)) {
            ent.SetOrigin(Vector(-171, -1663, 960))
        }

        //tp tu vaulht
        local ent = null
        while(ent = Entities.FindByNameWithin(ent, "blue", Vector( 751, -6575, 960), 100)) {
            ent.SetOrigin(Vector(7, 841, 1216))
        }
    }
}

// function SingleplayerLoop() {
//     // sp_a1_intro2
//     if (GetMapName() == "sp_a1_intro2") {
//         try {
//             EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
//         } catch(exception) {}

//         local portalgun = null
//         while ( portalgun = Entities.FindByClassname(portalgun, "weapon_portalgun")) {
//             portalgun.Destroy()
//         }

//         local p = null
//         while(p = Entities.FindByClassnameWithin(p, "player", Vector(-320, 1248, -656), 45)) {
//             SendToConsole("commentary 1")
//             SendToConsole("changelevel sp_a1_intro3")
//         }

//         try {
//             Entities.FindByName(null, "block_boxes").Destroy()
//         } catch(exception) {}
//     }

//     // sp_a1_intro3
//     if (GetMapName() == "sp_a1_intro3") {
//         local p = null
//         while(p = Entities.FindByClassnameWithin(p, "player", Vector(-1344, 4304, -784), 45)) {
//            SendToConsole("commentary 1")
//            SendToConsole("changelevel sp_a1_intro4")
//         }

//         try {
//             EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
//         } catch(exception) {}

//         // remove portalgun
//         if (hasgotportalgunSPMP == 0) {
//             local portalgun = null
//             while (portalgun = Entities.FindByClassname(portalgun, "weapon_portalgun")) {
//                 portalgun.Destroy()
//             }
//         }

//         if (!Entities.FindByName(null, "portalgun")) {
//             local p = null
//             if (timeout != 25) {
//                 timeout <- timeout + 1
//                 hasgotportalgunSPMP <- 1

//                 while (p = Entities.FindByClassname(p, "player")) {
//                     EntFireByHandle(clientcommand, "Command", "hud_saytext_time 0", 0, p, p)
//                     EntFireByHandle(clientcommand, "Command", "give weapon_portalgun", 0, p, p)
//                     EntFireByHandle(clientcommand, "Command", "upgrade_portalgun", 0, p, p)
//                     EntFireByHandle(clientcommand, "Command", "sv_cheats 1", 0, p, p)
//                 }
//             } else {
//                 while (p = Entities.FindByClassname(p, "player")) {
//                     EntFireByHandle(clientcommand, "Command", "sv_cheats 0", 0, p, p)
//                     EntFireByHandle(clientcommand, "Command", "hud_saytext_time 12", 0, p, p)
//                 }
//             }
//         }

//         // make wheatly look at player
//         local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "spherebot_1_bottom_swivel_1").GetOrigin(), 10000)
//         EntFireByHandle(Entities.FindByName(null, "spherebot_1_bottom_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
//     }

//     // sp_a1_intro4
//     if (GetMapName() == "sp_a1_intro4") {
//         try {
//             EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
//         } catch(exception) {}
//     }
// }

// function SingleplayerOnFirstSpawn(player) {
//     // sp_a1_intro2
//     if (GetMapName() == "sp_a1_intro2") {}
// }













/********** *******
* cut paste code *
*****************/

/*
Entities.FindByName(null, "NAME").Destroy()

Entities.FindByClassnameNearest("CLASS", Vector(1, 2, 3), 1).Destroy()

local p = null
while(p = Entities.FindByClassna-meWithin(p, "player", Vector(1, 2, 3), 45)) {
    SendToConsole("commentary 1")
    SendToConsole("changelevel LEVELNAME")
}

local ent = null
while ( ent = Entities.FindByClassname(ent, "CLASSNAME")) {
    ent.Destroy()
}


if (GetMapName() == "MAPNAME") {
    SendToConsole("commentary 0")
}

EntFireByHandle(Entities.FindByName(null, "NAME"), "ACTION", "VALUE", DELAYiny, ACTIVATOR, CALLER)

try {
    EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
} catch(exception) {}
*/
