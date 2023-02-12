//  ██████╗██████╗            █████╗ ██████╗             █████╗  █████╗ ██████╗ ███████╗
// ██╔════╝██╔══██╗          ██╔══██╗╚════██╗           ██╔══██╗██╔══██╗██╔══██╗██╔════╝
// ╚█████╗ ██████╔╝          ███████║  ███╔═╝           ██║  ╚═╝██║  ██║██████╔╝█████╗
//  ╚═══██╗██╔═══╝           ██╔══██║██╔══╝             ██║  ██╗██║  ██║██╔══██╗██╔══╝
// ██████╔╝██║    ██████████╗██║  ██║███████╗██████████╗╚█████╔╝╚█████╔╝██║  ██║███████╗
// ╚═════╝ ╚═╝    ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝ ╚════╝  ╚════╝ ╚═╝  ╚═╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // We need to control the viewmodel/real simulated grab controllers for inserting Wheatley
        GlobalOverridePluginGrabController <- false
        p2mm_startfade <- Entities.CreateByClassname("env_fade")
        p2mm_startfade.__KeyValueFromString("targetname", "p2mm_startfade")
        p2mm_startfade.__KeyValueFromString("duration", "0")
        p2mm_startfade.__KeyValueFromString("rendercolor", "0 0 0")
        p2mm_startfade.__KeyValueFromString("renderamt", "255")
        p2mm_startfade.__KeyValueFromString("spawnflags", "8")

        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "RedFogKillTriggerMPMOD")
        EntFireByHandle(Entities.FindByName(null, "red_light_pit_open_relay"), "addoutput", "OnTrigger RedFogKillTriggerMPMOD:kill", 1, null, null)

        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "WhiteFogKillTriggerMPMOD")
        EntFireByHandle(Entities.FindByName(null, "wheatly_takes_over_relay"), "addoutput", "OnTrigger WhiteFogKillTriggerMPMOD:kill", 1, null, null)

        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "EvilFogKillTriggerMPMOD")
        EntFireByHandle(Entities.FindByName(null, "wheatly_turns_evil_relay"), "addoutput", "OnTrigger EvilFogKillTriggerMPMOD:kill", 1, null, null)

        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "StaleMateButtonKillTrigger")
        EntFireByHandle(Entities.FindByName(null, "StaleMateButtonKillTriggetr"), "addoutput", "OnPressed StaleMateButtonKillTrigger:kill", 1, null, null)

        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "TPSp_A2_CoreForSure")

        Entities.FindByName(null, "music_sp_a2_core_b3_2").__KeyValueFromString("targetname", "MUSICOVERRIDEMPMOD")

        // Fix client-side animations
        // Front wall
        Entities.FindByName(null, "smallwall_front").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_pushdoor").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robopeek_01").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robopeek_02").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robopeek_03").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robopeek_04").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robopeek_05").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robopeek_06").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robopeek_07").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robopeek_09").__KeyValueFromString("HoldAnimation", "1")
        // Back wall
        Entities.FindByName(null, "smallwall").__KeyValueFromString("HoldAnimation", "1")
        // Right wall
        Entities.FindByName(null, "bigwallA_mover").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_peekyman_01").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_peekyman_02").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_peekyman_03").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_peekyman_04").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_walkout_01").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_walkout_02").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_walkout_03").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_walkout_04").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_walkout_05").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_walkout_06").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_walkout_07").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_walkout_08").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_walkout_09").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_walkout_10").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "roboA_walkout_11").__KeyValueFromString("HoldAnimation", "1")
        // Left wall
        Entities.FindByName(null, "bigwall_mover").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_peekyman_01").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_peekyman_02").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_peekyman_03").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_peekyman_04").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_walkout_01").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_walkout_02").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_walkout_03").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_walkout_04").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_walkout_05").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_walkout_06").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_walkout_07").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_walkout_08").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_walkout_09").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_walkout_10").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "robo_walkout_11").__KeyValueFromString("HoldAnimation", "1")
        // Core doors
        Entities.FindByName(null, "core_door_arm_01").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "core_door_arm_02").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "core_door_arm_03").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "core_door_arm_04").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "core_double_arms").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "core_double_arms_right").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "core_double_arms_left").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "chamber_arm_6").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "chamber_arm_7").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "chamber_arm_8").__KeyValueFromString("HoldAnimation", "1")
        // Core room
        Entities.FindByName(null, "globe_upper_ring").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "core_receptacle_model").__KeyValueFromString("HoldAnimation", "1")
        // Neurotoxin tube panels
        Entities.FindByName(null, "chamber_arm_19").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "chamber_arm_20").__KeyValueFromString("HoldAnimation", "1")
        // Stalemate room panels
        Entities.FindByName(null, "statemate_double_arm_01").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "statemate_double_arm_02").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "statemate_double_arm_03").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "chamber_arm_1").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "chamber_arm_2").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "chamber_arm_24").__KeyValueFromString("HoldAnimation", "1")

        Entities.FindByName(null, "maintenance_pit_model").__KeyValueFromString("HoldAnimation", "1")
        
        // Destroy objects
        Entities.FindByName(null, "death_fade").Destroy()
        Entities.FindByName(null, "rv_trap_portal_surf_cleanser").Destroy()
        Entities.FindByName(null, "swap_stalemate_panels_rl").Destroy()
        Entities.FindByName(null, "globe_panel_visibility_disable").Destroy()
        Entities.FindByName(null, "start_rv_scene_trigger").Destroy()
        Entities.FindByName(null, "stalemate_room_close").Destroy()
        Entities.FindByName(null, "close_stalemate_room_doors_relay").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(0, 304, -10438), 20).Destroy()

        OnlyOnceSp_A2_Core_2 <- true
        OnlyOnceSp_A2_Core <- true
        TPSp_A2_Core <- true
        EnableMeSp_A2_Core <- false
        OnlyOnceMoveTeleportSp_A2_Core_2 <- true
        TeleportOutInSp_A2_Core <- false
        ONETIMEFOGCHANGESp_A2_Core_2 <- false
        ONETIMEFOGCHANGESp_A2_Core_2_white <- false
        ONETIMEFOGCHANGESp_A2_Core_2_evil <- false
        StalemateRoomExitSp_A2_Core_2 <- false
        StalemateButtonSp_A2_Core_2 <- false
        RoomLookAtPlayerSp_A2_Core <- true
        TempGrabControllerToggled <- false
        StartFadeDone <- false

        UTIL_Team.Pinging(true, "all", 1)
        UTIL_Team.Taunting(true, "all", 1)
    }

    if (MSOnPlayerJoin) {
        // Find all players
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            EntFireByHandle(p2mm_clientcommand, "Command", "r_flashlightbrightness 1", 0, p, p)
            EntFireByHandle(p, "setfogcontroller", "@environment_darkness_fog", 0, null, null)
        }
        EntFire("Sp_A2_CoreViewcontrol", "disable", "", 0, null)
        EntFire("Sp_A2_CoreViewcontrol", "enable", "", 0.1, null)
    }

    if (MSPostPlayerSpawn) {
        StartFadeDone <- true
        EntFire("start_fade", "Fade", "", 0, null)
    }

    if (MSLoop) {
        if (!TempGrabControllerToggled) {
            if (PluginLoaded) {
                if (!GlobalOverridePluginGrabController && !Entities.FindByName(null, "rv_player_clip")) {
                    if (Entities.FindByName(null, "pit_clip")) {
                        if (Entities.FindByClassnameWithin(null, "player", Vector(320, 0, 0), 128)) {
                            SetPhysTypeConvar(-1)
                        } else {
                            SetPhysTypeConvar(0)
                        }
                    } else {
                        TempGrabControllerToggled <- true
                        GlobalOverridePluginGrabController <- true
                    }
                }
            }
        }

        if (!StartFadeDone) {
            EntFire("p2mm_startfade", "Fade", "", 0, null)
        }

        if (!TeleportOutInSp_A2_Core) {
            foreach (player in CreateTrigger("player", 293.857941, 313.969910, -126.097076, -610.639771, -467.855042, 133.613190)) {
                if (player.GetClassname() == "player") {
                    TeleportOutInSp_A2_Core <- true
                }
            }
        }

        if (TeleportOutInSp_A2_Core) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                local DisableTeleport = false
                foreach (player in CreateTrigger("player", -857.83013916016, -1769.8682861328, 1200.1546630859, 828.51452636719, 904.61602783203,  -11763)) {
                    if (p == player) {
                        DisableTeleport = true
                    }
                }
                if (!DisableTeleport) {
                    p.SetOrigin(Vector(-450, 0, 52))
                    p.SetAngles(0, 0, 0)
                    p.SetVelocity(Vector(0, 0, 0))
                }
            }
        }

        if (OnlyOnceSp_A2_Core_2) {
            if (!Entities.FindByName(null, "rv_start_moving_trigger")) {
                EntFireByHandle(Entities.FindByName(null, "start_rv_scene_rl"), "Trigger", "", 8, null, null)
                EntFireByHandle(Entities.FindByName(null, "MUSICOVERRIDEMPMOD"), "PlaySound", "", 8, null, null)
                Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "OnMoveStartOnlyOnceSp_A2_Core_2DIS")
                EntFire("OnMoveStartOnlyOnceSp_A2_Core_2DIS", "addoutput", "targetname OnMoveStartOnlyOnceSp_A2_Core_2", 8, null)
                OnlyOnceSp_A2_Core_2 <- false
            }
        }

        if (!ONETIMEFOGCHANGESp_A2_Core_2) {
            if (!Entities.FindByName(null, "RedFogKillTriggerMPMOD")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    EntFireByHandle(p, "setfogcontroller", "@environment_red_state", 0, null, null)
                }
                ONETIMEFOGCHANGESp_A2_Core_2 <- true
            }
        }

        if (!ONETIMEFOGCHANGESp_A2_Core_2_white) {
            if (!Entities.FindByName(null, "WhiteFogKillTriggerMPMOD")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    EntFireByHandle(p, "setfogcontroller", "@environment_wheatly_state_01", 0, null, null)
                }
                RoomLookAtPlayerSp_A2_Core <- true
                ONETIMEFOGCHANGESp_A2_Core_2_white <- true
            }
        }

        if (!ONETIMEFOGCHANGESp_A2_Core_2_evil) {
            if (!Entities.FindByName(null, "EvilFogKillTriggerMPMOD")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    EntFireByHandle(p, "setfogcontroller", "@environment_wheatly_state_02", 0, null, null)
                }
                ONETIMEFOGCHANGESp_A2_Core_2_evil <- true
            }
        }

        if (!StalemateButtonSp_A2_Core_2) {
            if (!Entities.FindByName(null, "StaleMateButtonKillTrigger")) {
                Entities.FindByName(null, "statemate_double_arm_01").__KeyValueFromString("targetname", "statemate_double_arm_01DIS")
                Entities.FindByName(null, "statemate_double_arm_02").__KeyValueFromString("targetname", "statemate_double_arm_02DIS")
                Entities.FindByName(null, "statemate_double_arm_03").__KeyValueFromString("targetname", "statemate_double_arm_03DIS")
                StalemateButtonSp_A2_Core_2 <- true
            }
        }

        if (!StalemateRoomExitSp_A2_Core_2) {
            if (!Entities.FindByName(null, "player_inside_stalemate_room_trigger")) {
                RoomLookAtPlayerSp_A2_Core <- false
                EntFire("core_receptacle_pointer_1", "SetTargetEntity", "lookat_glados_bullseye", 0, null)
                EntFire("glados_pointer", "SetTargetEntity", "lookat_receptacle_bullseye", 0, null)
                StalemateRoomExitSp_A2_Core_2 <- true
            }
        }

        if (OnlyOnceMoveTeleportSp_A2_Core_2) {
            if (Entities.FindByName(null, "OnMoveStartOnlyOnceSp_A2_Core_2")) {
                // Find all players
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    local InsideArea = false
                    local p2 = null
                    while (p2 = Entities.FindByClassnameWithin(p2, "player", Vector(-1836.2550048828, -0.81460344791412, -31.667282104492), 151.99999809265)) {
                        if (p2 == p) {
                            InsideArea = true
                        }
                    }

                    if (!InsideArea) {
                        p.SetOrigin(Vector(-1839, 0, 8))
                        p.SetAngles(0, 0, 0)
                        p.SetVelocity(Vector(0, 0, 0))
                    }
                    EntFireByHandle(p, "setfogcontroller", "@environment_glados", 10, null, null)
                }
                OnlyOnceMoveTeleportSp_A2_Core_2 <- false
            }
        }

        if (OnlyOnceSp_A2_Core) {
            if (!Entities.FindByName(null, "exit_elevator_departure_trigger")) {
                printl("(P2:MM): Elevator viewcontrol activated!")
                // Elevator viewcontrol
                Sp_A2_CoreViewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
                Sp_A2_CoreViewcontrol.__KeyValueFromString("target_team", "-1")
                Sp_A2_CoreViewcontrol.__KeyValueFromString("targetname", "Sp_A2_CoreViewcontrol")
                Sp_A2_CoreViewcontrol.SetOrigin(Vector(0, 324, 0))
                EntFire("Sp_A2_CoreViewcontrol", "setparent", "exit_elevator_train", 0, null)
                Sp_A2_CoreViewcontrol.SetAngles(0, 270, 0)
                EntFire("Sp_A2_CoreViewcontrol", "enable", "", 0, null)
                EntFire("Sp_A2_CoreViewcontrol", "disable", "", 144.8, null)
                EntFire("TPSp_A2_CoreForSure", "kill", "", 144.8, null)

                Entities.CreateByClassname("point_servercommand").__KeyValueFromString("targetname", "Sp_A2_CoreServerCommand")
                Entities.FindByName(null, "rv_trap_floor_down_door_1").Destroy()
                EntFire("Sp_A2_CoreServerCommand", "command", "echo Changing level...", 150.8, null)
                EntFire("Sp_A2_CoreServerCommand", "command", "changelevel sp_a3_00", 150.8, null)

                OnlyOnceSp_A2_Core <- false
                RoomLookAtPlayerSp_A2_Core <- false
                EnableMeSp_A2_Core <- true

                EntFire("glados_pointer", "SetTargetEntity", "lookat_exit_elevator_bullseye", 0, null)

                UTIL_Team.Pinging(true, "all", 0.1)
                UTIL_Team.Taunting(true, "all", 0.1)
            }
        }

        // Second teleport into the elevator
        if (TPSp_A2_Core) {
            if (!Entities.FindByName(null, "TPSp_A2_CoreForSure")) {
                EnableMeSp_A2_Core <- false
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(0, 290, -200))
                    p.SetVelocity(Vector(0, 0, 0))
                    p.SetAngles(80, 270, 0)
                }
                TPSp_A2_Core <- false
            }
        }

        if (EnableMeSp_A2_Core) {
            // First teleport behind the panels so players can't be seen from the elevator
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(0, 495, 37))
                p.SetVelocity(Vector(0, 0, 0))
            }
        }

        try {
        Entities.FindByName(null, "@sphere").ConnectOutput("OnPlayerPickup","disablewheatleyplayerpickup")
        Entities.FindByName(null, "@sphere").ConnectOutput("OnPlayerDrop","enablewheatleyplayerpickup")
        } catch(exception) { }

        if (RoomLookAtPlayerSp_A2_Core) {
            // Make central core point at nearest player (We need it to stop pointing at the player when core transfer begins) (Moja)
            try {
                local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "glados_pointer").GetOrigin(), 10000)
                EntFireByHandle(Entities.FindByName(null, "glados_pointer"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
            } catch(exception) {}

            // Make core receptacle point at nearest player (We need it to stop pointing at the player when core transfer begins) (Moja)
            try {
                local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "core_receptacle_pointer_1").GetOrigin(), 10000)
                EntFireByHandle(Entities.FindByName(null, "core_receptacle_pointer_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
            } catch(exception) {}

            // Make primary panel pointer target the nearest player
            try {
                local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "shield_1_pointer_1").GetOrigin(), 10000)
                EntFireByHandle(Entities.FindByName(null, "shield_1_pointer_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
            } catch(exception) {}

            // Make secondary panel pointer target the nearest player
            try {
                local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "shield_1_pointer_2").GetOrigin(), 10000)
                EntFireByHandle(Entities.FindByName(null, "shield_1_pointer_2"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
            } catch(exception) {}
        }
    }
}