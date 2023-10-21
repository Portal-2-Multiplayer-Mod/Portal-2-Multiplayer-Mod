// ███╗   ███╗██████╗             █████╗  █████╗  █████╗ ██████╗            ██╗      █████╗ ██████╗ ██████╗ ██╗   ██╗           ██████╗
// ████╗ ████║██╔══██╗           ██╔══██╗██╔══██╗██╔══██╗██╔══██╗           ██║     ██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝           ╚════██╗
// ██╔████╔██║██████╔╝           ██║  ╚═╝██║  ██║██║  ██║██████╔╝           ██║     ██║  ██║██████╦╝██████╦╝ ╚████╔╝             █████╔╝
// ██║╚██╔╝██║██╔═══╝            ██║  ██╗██║  ██║██║  ██║██╔═══╝            ██║     ██║  ██║██╔══██╗██╔══██╗  ╚██╔╝              ╚═══██╗
// ██║ ╚═╝ ██║██║     ██████████╗╚█████╔╝╚█████╔╝╚█████╔╝██║     ██████████╗███████╗╚█████╔╝██████╦╝██████╦╝   ██║   ██████████╗██████╔╝
// ╚═╝     ╚═╝╚═╝     ╚═════════╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝     ╚═════════╝╚══════╝ ╚════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚═════════╝╚═════╝


// * Functions for Lobby Music Control * \\

//! FUNC_BUTTONS ARE MOVING, THEY SHOULDN'T NO CLUE WHY THEY ARE...
//! THIS IS CAUSING THE LEFT BUTTON TO NOT WORK AFTER THE FIRST PRESS...

// Play the track that is currently indicated by musicSelected
function PlaySelectedTrack() {
    EntFire("p2mm_lobbymusic_text", "SetText", "Music Track: " + musicSelected + "/" + musicMax, 0.6, null)
    EntFire("p2mm_lobbymusic_text", "Display", "", 0.65, null)
    Entities.FindByName(null, "p2mm_lobbymusic_music").__KeyValueFromString("message", musicTracks["musicTrack" + musicSelected])
    EntFire("p2mm_lobbymusic_music", "PlaySound", "", 0.7, null)
}

// Called to change the current track playing in the lobby
// A bool is given to tell whether its going to the next or previous track
function ChangeMusicTrack(nextTrack = true) {
    if (nextTrack) {
        if (musicSelected == musicMax) {
            return
        }

        musicSelected += 1

        if (musicSelected == musicMax) {
            EntFire("p2mm_lobbymusic_button1", "unlock", "", 0, null)
            EntFire("p2mm_lobbymusic_button2", "lock", "", 0, null)
            EntFire("prop_button_R", "Skin", "1", 0, null)
            PlaySelectedTrack()
            return
        }

        if (musicSelected < musicMax && musicSelected >= musicMin) {
            EntFire("p2mm_lobbymusic_button1", "unlock", "", 0, null)
            EntFire("p2mm_lobbymusic_button2", "unlock", "", 0, null)
            EntFire("prop_button_L", "Skin", "0", 0, null)
            PlaySelectedTrack()
            return
        }
    } else {
        if (musicSelected == musicMin) {
            return
        }

        musicSelected -= 1

        if (musicSelected == musicMin) {
            EntFire("p2mm_lobbymusic_text", "settext", "No Music", 0, null)
            EntFire("p2mm_lobbymusic_text", "display", "", 0.5, null)
            EntFire("p2mm_lobbymusic_button1", "lock", "", 1, null)
            EntFire("prop_button_L", "Skin", "1", 0, null)
            return
        }

        if (musicSelected > musicMin && musicSelected <= musicMax) {      
            EntFire("p2mm_lobbymusic_button1", "unlock", "", 0, null)
            EntFire("p2mm_lobbymusic_button2", "unlock", "", 0, null)
            EntFire("prop_button_R", "Skin", "0", 0, null)
            PlaySelectedTrack()
            return
        }
    }
}

// Music Control In The Lobby!
// Initalize the music
function MusicInit() {
    // Remove all the old music entities and unneeded entities
    Entities.FindByName(null, "case_music").Destroy()
    Entities.FindByName(null, "counter_music").Destroy()

    for (local i = 2; i < 8;) {
        Entities.FindByName(null, "@music_lobby_" + i).Destroy()
        i += 1
    }

    local armProp = "models/anim_wp/framework/hanging_arm_02.mdl"
    for (local prop = null; prop = Entities.FindByModel(prop, armProp);) {
        if (prop.entindex() == 131) {
            prop.Destroy()
            break
        }
    }

    for (local button = null; button = Entities.FindByClassname(button, "func_button");) {
        if (button.entindex() == 135) {
            button.Destroy()
            break
        }
    }

    // Remove entities that the func_button buttons we are reusing are referencing, we don't need them
    Entities.FindByName(null, "transition_script").Destroy()
    Entities.FindByName(null, "track6-DLCElevatorRoomEntranceTrigger").Destroy()
    Entities.FindByName(null, "track6-track_door_open_trigger").Destroy()
    Entities.FindByName(null, "coopman_screen").Destroy()

    // Setup the P2MM music entities
    //`script Entities.FindByName(null, "p2mm_lobbymusic_button1").__KeyValueFromString(spawnflags, "1025")
    // First the buttons, button1 goes back a track, button2 goes forward
    p2mm_lobbymusic_button1 <- Entities.FindByName(null, "screen_button_L")
    p2mm_lobbymusic_button1.__KeyValueFromString("targetname", "p2mm_lobbymusic_button1")
    //p2mm_lobbymusic_button1.__KeyValueFromString("wait", "0.5")
    //p2mm_lobbymusic_button1.__KeyValueFromString("spawnflags", "1025")
    //p2mm_lobbymusic_button1.__KeyValueFromString("speed", "10")
    //p2mm_lobbymusic_button1.__KeyValueFromString("movedir", "0 0 0")
    //p2mm_lobbymusic_button1.SetAngles(0, 0, 0)
    EntFireByHandle(p2mm_lobbymusic_button1, "AddOutput", "OnPressed !self:RunScriptCode:ChangeMusicTrack(false):0:-1", 0, null, null)
    EntFireByHandle(p2mm_lobbymusic_button1, "AddOutput", "OnPressed p2mm_lobbymusic_music:StopSound::0:-1", 0, null, null)
    p2mm_lobbymusic_button2 <- Entities.FindByName(null, "screen_button_R")
    p2mm_lobbymusic_button2.__KeyValueFromString("targetname", "p2mm_lobbymusic_button2")
    //p2mm_lobbymusic_button2.__KeyValueFromString("wait", "0.5")
    //p2mm_lobbymusic_button2.__KeyValueFromString("spawnflags", "1025")
    //p2mm_lobbymusic_button2.__KeyValueFromString("speed", "10")
    //p2mm_lobbymusic_button2.__KeyValueFromString("movedir", "0 0 0")
    //p2mm_lobbymusic_button2.SetAngles(0, 0, 0)
    EntFireByHandle(p2mm_lobbymusic_button2, "AddOutput", "OnPressed !self:RunScriptCode:ChangeMusicTrack(true):0:-1", 0, null, null)
    EntFireByHandle(p2mm_lobbymusic_button2, "AddOutput", "OnPressed p2mm_lobbymusic_music:StopSound::0:-1", 0, null, null)
    
    EntFireByHandle(p2mm_lobbymusic_button1, "Enable", "", 0, null, null)
    EntFireByHandle(p2mm_lobbymusic_button2, "Enable", "", 0, null, null)
    EntFireByHandle(p2mm_lobbymusic_button1, "unlock", "", 0, null, null)
    EntFireByHandle(p2mm_lobbymusic_button2, "unlock", "", 0, null, null)
    Entities.FindByName(null, "prop_button_L").__KeyValueFromString("skin", "0")
    Entities.FindByName(null, "prop_button_R").__KeyValueFromString("skin", "0")
    
    // Create the game_text entity to see what track was selected
    p2mm_lobbymusic_text <- Entities.CreateByClassname("game_text")
    p2mm_lobbymusic_text.__KeyValueFromString("targetname", "p2mm_lobbymusic_text")
    p2mm_lobbymusic_text.__KeyValueFromString("message", "Music Track " + musicDefault + "/" + musicMax)
    p2mm_lobbymusic_text.__KeyValueFromString("spawnflags", "1")
    p2mm_lobbymusic_text.__KeyValueFromString("fadein", "0.5")
    p2mm_lobbymusic_text.__KeyValueFromString("fadeout", "0.5")
    p2mm_lobbymusic_text.__KeyValueFromString("x", "-1")
    p2mm_lobbymusic_text.__KeyValueFromString("y", "0.25")
    p2mm_lobbymusic_text.__KeyValueFromString("channel", "2")
    p2mm_lobbymusic_text.__KeyValueFromString("holdtime", "1.2")
    p2mm_lobbymusic_text.__KeyValueFromString("color", "255 255 255")
    
    // Create the ambient generic which will play our music tracks, then move it to the lobby area
    p2mm_lobbymusic_music <- Entities.FindByName(null, "@music_lobby_1")
    p2mm_lobbymusic_music.__KeyValueFromString("targetname", "p2mm_lobbymusic_music")
    p2mm_lobbymusic_music.__KeyValueFromString("message", musicTracks["musicTrack" + musicDefault])
    p2mm_lobbymusic_music.__KeyValueFromString("spawnflags", "17")
    p2mm_lobbymusic_music.SetOrigin(Vector(4930, 3705, -478))

    // Precache the music
    foreach (musicTrack in musicTracks) {
        self.PrecacheSoundScript(musicTrack)
    }

    // Position everything in the map
    Entities.FindByName(null, "snd_screen_button").SetOrigin(Vector(4928, 3713, -496))
    DoEntFire("rot_screen_buttons", "open", "", 0.0, null, null)
    DoEntFire("move_b_screen_buttons", "clearparent", "", 0.0, null, null)
    Entities.FindByName(null, "move_b_screen_buttons").SetAngles(0, 90, 0)
    DoEntFire("p2mm_servercommand", "command", "script Entities.FindByName(null, \"move_b_screen_buttons\").SetOrigin(Vector(4928, 3713, -496))", 0.2, null, null)

    DoEntFire("prop_button_l", "clearparent", "", 0.3, null, null)
    DoEntFire("prop_button_r", "clearparent", "", 0.3, null, null)
    DoEntFire("p2mm_lobbymusic_button1", "clearparent", "", 0.3, null, null)
    DoEntFire("p2mm_lobbymusic_button2", "clearparent", "", 0.3, null, null)
    DoEntFire("rot_screen_buttons", "kill", "", 0.4, null, null)

    DoEntFire("p2mm_lobbymusic_button1", "setparent", "prop_button_l", 0.4, null, null)
    DoEntFire("p2mm_lobbymusic_button2", "setparent", "prop_button_r", 0.4, null, null)
    DoEntFire("!self", "command", "script Entities.FindByName(null, \"prop_button_l\").SetOrigin(Vector(4889, 3709, -476))", 0.5, null, Entities.FindByName(null, "p2mm_servercommand"))
    DoEntFire("!self", "command", "script Entities.FindByName(null, \"prop_button_r\").SetOrigin(Vector(4936.5, 3709, -476))", 0.5, null, Entities.FindByName(null, "p2mm_servercommand"))

    // START THE MUSIC
    DoEntFire("!self", "PlaySound", "", 0.0, null, Entities.FindByName(null, "p2mm_lobbymusic_music"))
}

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        Entities.FindByName(null, "robo_rampa_01b").__KeyValueFromString("mincpulevel", "0")
        Entities.FindByName(null, "robo_rampa_01b").__KeyValueFromString("mingpulevel", "0")
        Entities.FindByName(null, "robo_rampa_02b").__KeyValueFromString("mincpulevel", "0")
        Entities.FindByName(null, "robo_rampa_02b").__KeyValueFromString("mingpulevel", "0")
        Entities.FindByName(null, "robo_rampa_03b").__KeyValueFromString("mincpulevel", "0")
        Entities.FindByName(null, "robo_rampa_03b").__KeyValueFromString("mingpulevel", "0")
        Entities.FindByName(null, "robo_rampa_04b").__KeyValueFromString("mincpulevel", "0")
        Entities.FindByName(null, "robo_rampa_04b").__KeyValueFromString("mingpulevel", "0")
        EntFire("trigger_run_script", "AddOutput", "OnStartTouchBluePlayer coop_man_enter_hub:SetStateBTrue", 0, null)
        EntFire("trigger_quick_spawn", "AddOutput", "OnStartTouchBluePlayer coop_man_quick_open:SetStateBTrue", 0, null)
        EntFire("trigger_set_course", "AddOutput", "OnStartTouchBluePlayer coop_man_set_course:SetStateBTrue", 0, null)
        EntFire("track6-prop_door_hall", "Open", "", 0, null)
        enablehub <- false
    }

    if (MSPostPlayerSpawn) {
        for (local course = 1; course <= 6; course++) {
            // 9 levels is the highest that a course has
            for (local level = 1; level <= 9; level++) {
                if (IsLevelComplete(course - 1, level - 1)) {
                    enablehub <- true
                }
            }
        }

        if (enablehub) {
            // If any level was completed outside of calibration, enable the hub entirely
            EntFire("case_open_course", "invalue", "7", 0, null)
        }

        // INITALIZE AND START THE MUSIC
        MusicInit()

        // Allow the players to drop from spawn tube
        Entities.FindByName(null, "brush_spawn_blocker_red").Destroy()
        Entities.FindByName(null, "brush_spawn_blocker_blue").Destroy()

        // Enable retrigger for all logic_relay entities except for those defined otherwise
        // in the bsp to prevent desync on clients and remove errors from the console
        local ent = null
        while (ent = Entities.FindByClassname(ent, "logic_relay")) {
            ent.__KeyValueFromString("spawnflags", "2")
        }
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track1-rl_start_exit"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track1-rl_start_exit_finished"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track2-rl_start_exit_finished"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track3-rl_start_exit"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track3-rl_start_exit_finished"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track4-rl_start_exit"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track4-rl_start_exit_finished"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track5-relay_open_doors"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track5-rl_start_exit"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track5-rl_start_exit_finished"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track6-rl_start_exit"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track6-rl_start_exit_finished"))

        // Remove useless entities so that the entity limit does not crash the game

        // Remove func_portal_bumper's from the map
        for (local ent = null; ent = Entities.FindByClassname(ent, "func_portal_bumper");) {
            ent.Destroy() // 165 entities removed
        }

        // Remove env_sprite's from the map
        for (local ent = null; ent = Entities.FindByClassname(ent, "env_sprite");) {
            ent.Destroy() // 31 entities removed
        }

        // Remove trigger_portal_cleaner's from map, two of these are bugged anyway and need to be removed
        for (local ent = null; ent = Entities.FindByClassname(ent, "trigger_portal_cleanser");) {
            ent.Destroy() // 5 entities removed
        }

        // Remove unused point_viewcontrol and point_viewcontrol_multiplayer's from map, the one point_viewcontrol is for commentary mode
        Entities.FindByClassname(null, "point_viewcontrol").Destroy()
        for (local ent = null; ent = Entities.FindByClassname(ent, "point_viewcontrol_multiplayer");) {
            if (ent.GetName().find("cam_botview") != null) {
                continue
            }
            ent.Destroy() // 20 entities removed
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
        Entities.FindByName(null, "@snd_light_inside").Destroy()
        Entities.FindByName(null, "@snd_light_outside").Destroy()

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

    if (MSLoop) {
        local PLent = null
        while(PLent = Entities.FindByClassnameWithin(PLent, "player", Vector(2367, -8126, -54), 30)) {
            local APLent = null
            while(APLent = Entities.FindByClassname(APLent, "player")) {
                APLent.SetOrigin(Vector(2495, -7451, 410))
            }
        }

        // Art therapy left chute enabler
        local vectorEEL = Vector(5727, 3336, -441)
        local EELent = null
        while(EELent = Entities.FindByClassnameWithin(EELent, "player", vectorEEL, 12)) {
            local LCatEn = null
            while(LCatEn = Entities.FindByName(LCatEn, "left-enable_cats")) {
                DoEntFire("!self", "Enable", "", 0.0, null, LCatEn)
                DoEntFire("!self", "Trigger", "", 0.0, null, LCatEn)
            }
        }

        // Art therapy left chute teleporter
        TeleportPlayerWithinDistance(Vector(5729, 3336, 1005), 30, Vector(3194, -1069, 1676))

        // Art therapy right chute enabler
        local vectorEER = Vector(5727, 3192, -441)
        local EERent = null
        while(EERent = Entities.FindByClassnameWithin(EERent, "player", vectorEER, 12)) {
            local RCatEn = null
            while(RCatEn = Entities.FindByName(RCatEn, "right-enable_cats")) {
                DoEntFire("!self", "Enable", "", 0.0, null, RCatEn)
                DoEntFire("!self", "Trigger", "", 0.0, null, RCatEn)
            }
        }

        // Art therapy right chute teleporter
        TeleportPlayerWithinDistance(Vector(5727, 3180, 1005), 30, Vector(3191, -1228, 1682))

        // Disable art therapy chutes
        local vectorE = Vector(3201, -1152, 1272)
        local Aent = null
        while(Aent = Entities.FindByClassnameWithin(Aent, "player", vectorE, 150)) {
            local LCatDis = null
            while(LCatDis = Entities.FindByName(LCatDis, "left-disable_cats")) {
                DoEntFire("!self", "Enable", "", 0.0, null, LCatDis)
                DoEntFire("!self", "Trigger", "", 0.0, null, LCatDis)
            }
            local RCatDis = null
            while(RCatDis = Entities.FindByName(RCatDis, "right-disable_cats")) {
                DoEntFire("!self", "Enable", "", 0.0, null, RCatDis)
                DoEntFire("!self", "Trigger", "", 0.0, null, RCatDis)
            }
        }

        // Teleport exiting player out of art therapy
        TeleportPlayerWithinDistance(Vector(3584, -1669, 466), 30, Vector(3919, 3352, 158))
    }
}