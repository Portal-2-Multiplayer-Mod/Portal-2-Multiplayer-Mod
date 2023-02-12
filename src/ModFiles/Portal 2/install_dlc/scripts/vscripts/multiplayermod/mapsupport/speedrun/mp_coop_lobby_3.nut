// ███╗   ███╗██████╗             █████╗  █████╗  █████╗ ██████╗            ██╗      █████╗ ██████╗ ██████╗ ██╗   ██╗           ██████╗
// ████╗ ████║██╔══██╗           ██╔══██╗██╔══██╗██╔══██╗██╔══██╗           ██║     ██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝           ╚════██╗
// ██╔████╔██║██████╔╝           ██║  ╚═╝██║  ██║██║  ██║██████╔╝           ██║     ██║  ██║██████╦╝██████╦╝ ╚████╔╝             █████╔╝
// ██║╚██╔╝██║██╔═══╝            ██║  ██╗██║  ██║██║  ██║██╔═══╝            ██║     ██║  ██║██╔══██╗██╔══██╗  ╚██╔╝              ╚═══██╗
// ██║ ╚═╝ ██║██║     ██████████╗╚█████╔╝╚█████╔╝╚█████╔╝██║     ██████████╗███████╗╚█████╔╝██████╦╝██████╦╝   ██║   ██████████╗██████╔╝
// ╚═╝     ╚═╝╚═╝     ╚═════════╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝     ╚═════════╝╚══════╝ ╚════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚═════════╝╚═════╝

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
        EntFire("trigger_run_script", "addoutput", "OnStartTouchBluePlayer coop_man_enter_hub:SetStateBTrue", 0, null)
        EntFire("trigger_quick_spawn", "addoutput", "OnStartTouchBluePlayer coop_man_quick_open:SetStateBTrue", 0, null)
        EntFire("trigger_set_course", "addoutput", "OnStartTouchBluePlayer coop_man_set_course:SetStateBTrue", 0, null)
        enablehub <- false
    }

    if (MSPostPlayerSpawn) {
        printlP2MM("Speedrun mode LOBBY3!!!")
        EntFireByHandle("track1-track_door_open_trigger", "kill", "", 1, null, null)

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

            // Enable music
            DoEntFire("!self", "invalue", "7", 0.0, null, Entities.FindByName(null, "@music_lobby_7"))
        }

        // Allow the players to drop from spawn tube
        Entities.FindByName(null, "brush_spawn_blocker_red").Destroy()
        Entities.FindByName(null, "brush_spawn_blocker_blue").Destroy()

        // Enable retrigger for all logic_relay entities except for those defined otherwise
        // in the bsp to prevent desync on clients and remove errors from the console
        local ent = null
        while (ent = Entities.FindByClassname(ent, "logic_relay")) {
            ent.__KeyValueFromString("spawnflags", "2")
        }
        DoEntFire("!self", "addoutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track1-rl_start_exit"))
        DoEntFire("!self", "addoutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track1-rl_start_exit_finished"))
        DoEntFire("!self", "addoutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track2-rl_start_exit_finished"))
        DoEntFire("!self", "addoutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track3-rl_start_exit"))
        DoEntFire("!self", "addoutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track3-rl_start_exit_finished"))
        DoEntFire("!self", "addoutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track4-rl_start_exit"))
        DoEntFire("!self", "addoutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track4-rl_start_exit_finished"))
        DoEntFire("!self", "addoutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track5-relay_open_doors"))
        DoEntFire("!self", "addoutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track5-rl_start_exit"))
        DoEntFire("!self", "addoutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track5-rl_start_exit_finished"))
        DoEntFire("!self", "addoutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track6-rl_start_exit"))
        DoEntFire("!self", "addoutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track6-rl_start_exit_finished"))

        // Remove useless entities so that the entity limit does not crash the game

        // Paint reveal cutscene cleanser doesn't properly turn off so we need to remove them (there's two of them)
        for (local ent; ent = Entities.FindByClassname(ent, "trigger_portal_cleanser");) {
            ent.Destroy()
        }

        // Remove a point_viewcontrol from the map, this is from the commentary mode so we don't need it
        EntFire("camera_bridge_door", "Kill", null, 0, null)

        // Remove point_viewcontrol_multiplayer's from the map, we aren't using any of them since they have been disabled
        for (local ent; ent = Entities.FindByClassname(ent, "point_viewcontrol_multiplayer");) {
            ent.Destroy() // 15 entities removed
        } 

        // Remove a func_clip_vphysics from the map, something for course 5 but its not needed
        EntFire("track5-door_paint-collide_door", "Kill", null, 0, null)

        // Remove move_rope's from the map
        for (local ent; ent = Entities.FindByClassname(ent, "move_rope");) {
            ent.Destroy() // 3 entities removed
        }

        // Remove a keyframe_rope from the map
        EntFire("rope_2", "Kill", null, 0, null)

        // Remove game_end's from the map
        for (local ent; ent = Entities.FindByClassname(ent, "game_end");) {
            ent.Destroy() // 6 entities removed
        }

        // Remove a logic_autosave from the map, this ain't single player so it won't work
        EntFire("@autosave", "Kill", null, 0, null)

        // Remove func_portal_bumper's from the map
        for (local ent; ent = Entities.FindByClassname(ent, "func_portal_bumper");) {
            ent.Destroy() // 165 entities removed
        }
        // Remove env_sprite's from the map
        for (local ent; ent = Entities.FindByClassname(ent, "env_sprite");) {
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
}

// try { IncludeScript("multiplayermod/mapsupport/standard/" + GetMapName()) } catch (exception) {}

// // Speed up course 1 map transition
// Entities.CreateByClassname("logic_coop_manager").__KeyValueFromString("targetname", "track1-coopman_exit_level")
// EntFire("track1-coopman_exit_level", "addoutput", "OnChangeToAllTrue track1-template_movie_level_transition:ForceSpawn::0.5")
// EntFire("track1-coopman_exit_level", "addoutput", "OnChangeToAllTrue track1-gladosendoflevelrelay:Trigger::1")
// EntFire("track1-rl_start_exit", "Disable")
