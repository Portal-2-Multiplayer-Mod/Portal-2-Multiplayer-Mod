//  ██████╗██████╗            █████╗ ██████╗             █████╗  █████╗ ██████╗ ███████╗
// ██╔════╝██╔══██╗          ██╔══██╗╚════██╗           ██╔══██╗██╔══██╗██╔══██╗██╔════╝
// ╚█████╗ ██████╔╝          ███████║  ███╔═╝           ██║  ╚═╝██║  ██║██████╔╝█████╗
//  ╚═══██╗██╔═══╝           ██╔══██║██╔══╝             ██║  ██╗██║  ██║██╔══██╗██╔══╝
// ██████╔╝██║    ██████████╗██║  ██║███████╗██████████╗╚█████╔╝╚█████╔╝██║  ██║███████╗
// ╚═════╝ ╚═╝    ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝ ╚════╝  ╚════╝ ╚═╝  ╚═╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        // Here if we need to ent_fire something
        //EntFireByHandle(Entities.FindByName(null, "NAME"), "ACTION", "VALUE", DELAYiny, ACTIVATOR, CALLER)
        // Destroy objects
        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "RedFogKillTriggerMPMOD")
        EntFireByHandle(Entities.FindByName(null, "red_light_pit_open_relay"), "addoutput", "OnTrigger RedFogKillTriggerMPMOD:kill", 1, null, null)

        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "WhiteFogKillTriggerMPMOD")
        EntFireByHandle(Entities.FindByName(null, "wheatly_takes_over_relay"), "addoutput", "OnTrigger WhiteFogKillTriggerMPMOD:kill", 1, null, null)

        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "EvilFogKillTriggerMPMOD")
        EntFireByHandle(Entities.FindByName(null, "wheatly_turns_evil_relay"), "addoutput", "OnTrigger EvilFogKillTriggerMPMOD:kill", 1, null, null)

        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "StaleMateButtonKillTrigger")
        EntFireByHandle(Entities.FindByName(null, "StaleMateButtonKillTriggetr"), "addoutput", "OnPressed StaleMateButtonKillTrigger:kill", 1, null, null)

        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "TPSp_A2_CoreForSure")

        Entities.FindByName(null, "death_fade").Destroy()
        Entities.FindByName(null, "rv_trap_portal_surf_cleanser").Destroy()
        Entities.FindByName(null, "swap_stalemate_panels_rl").Destroy()
        Entities.FindByName(null, "globe_panel_visibility_disable").Destroy()
        Entities.FindByName(null, "start_rv_scene_trigger").Destroy()
        Entities.FindByName(null, "stalemate_room_close").Destroy()
        Entities.FindByName(null, "close_stalemate_room_doors_relay").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(0, 304, -10438), 20).Destroy()
        Entities.FindByName(null, "music_sp_a2_core_b3_2").__KeyValueFromString("targetname", "MUSICOVERRIDEMPMOD")

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


        // Create Env Globals
        env_global01 <- Entities.CreateByClassname("env_global")
        env_global01.__KeyValueFromString("targetname", "env_global01")
        env_global01.__KeyValueFromString("globalstate", "no_pinging_blue")


        env_global02 <- Entities.CreateByClassname("env_global")
        env_global02.__KeyValueFromString("targetname", "env_global02")
        env_global02.__KeyValueFromString("globalstate", "no_pinging_orange")

        env_global03 <- Entities.CreateByClassname("env_global")
        env_global03.__KeyValueFromString("targetname", "env_global03")
        env_global03.__KeyValueFromString("globalstate", "no_taunting_blue")


        env_global04 <- Entities.CreateByClassname("env_global")
        env_global04.__KeyValueFromString("targetname", "env_global04")
        env_global04.__KeyValueFromString("globalstate", "no_taunting_orange")

        EntFireByHandle(env_global01, "turnoff", "", 1, null, null)
        EntFireByHandle(env_global02, "turnoff", "", 1, null, null)
        EntFireByHandle(env_global03, "turnoff", "", 1, null, null)
        EntFireByHandle(env_global04, "turnoff", "", 1, null, null)
    }=

    if (MSOnPlayerJoin==true) {
        // Find all players
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            EntFireByHandle(clientcommand, "Command", "r_flashlightbrightness 1", 0, p, p)
            EntFireByHandle(p, "setfogcontroller", "@environment_darkness_fog", 0, null, null)
        }
    }

    if (MSLoop==true) {
        if (TeleportOutInSp_A2_Core==false) {
            foreach (player in CreateTrigger(293.857941, 313.969910, -126.097076, -610.639771, -467.855042, 133.613190)) {
                if (player.GetClassname() == "player") {
                    TeleportOutInSp_A2_Core <- true
                }
            }
        }

        if (TeleportOutInSp_A2_Core==true) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                local DisableTeleport = false
                foreach (player in CreateTrigger(-857.83013916016, -1769.8682861328, 1200.1546630859, 828.51452636719, 904.61602783203,  -11763)) {
                    if (p == player) {
                        DisableTeleport = true
                    }
                }
                if (DisableTeleport==false) {
                    p.SetOrigin(Vector(-482, 0, 52))
                    p.SetAngles(0, 0, 0)
                    p.SetVelocity(Vector(0, 0, 0))
                }
            }
        }

        if (OnlyOnceSp_A2_Core_2==true) {
            if (!Entities.FindByName(null, "rv_start_moving_trigger")) {
                EntFireByHandle(Entities.FindByName(null, "start_rv_scene_rl"), "Trigger", "", 8, null, null)
                EntFireByHandle(Entities.FindByName(null, "MUSICOVERRIDEMPMOD"), "PlaySound", "", 8, null, null)
                Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "OnMoveStartOnlyOnceSp_A2_Core_2DIS")
                EntFire("OnMoveStartOnlyOnceSp_A2_Core_2DIS", "addoutput", "targetname OnMoveStartOnlyOnceSp_A2_Core_2", 8, null)
                OnlyOnceSp_A2_Core_2 <- false
            }
        }

        if (ONETIMEFOGCHANGESp_A2_Core_2==false) {
            if (!Entities.FindByName(null, "RedFogKillTriggerMPMOD")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    EntFireByHandle(p, "setfogcontroller", "@environment_red_state", 0, null, null)
                }
                ONETIMEFOGCHANGESp_A2_Core_2 <- true
            }
        }

        if (ONETIMEFOGCHANGESp_A2_Core_2_white==false) {
            if (!Entities.FindByName(null, "WhiteFogKillTriggerMPMOD")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    EntFireByHandle(p, "setfogcontroller", "@environment_wheatly_state_01", 0, null, null)
                }
                RoomLookAtPlayerSp_A2_Core <- true
                ONETIMEFOGCHANGESp_A2_Core_2_white <- true
            }
        }

        if (ONETIMEFOGCHANGESp_A2_Core_2_evil==false) {
            if (!Entities.FindByName(null, "EvilFogKillTriggerMPMOD")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    EntFireByHandle(p, "setfogcontroller", "@environment_wheatly_state_02", 0, null, null)
                }
                ONETIMEFOGCHANGESp_A2_Core_2_evil <- true
            }
        }

        if (StalemateButtonSp_A2_Core_2==false) {
            if (!Entities.FindByName(null, "StaleMateButtonKillTrigger")) {
                Entities.FindByName(null, "statemate_double_arm_01").__KeyValueFromString("targetname", "statemate_double_arm_01DIS")
                Entities.FindByName(null, "statemate_double_arm_02").__KeyValueFromString("targetname", "statemate_double_arm_02DIS")
                Entities.FindByName(null, "statemate_double_arm_03").__KeyValueFromString("targetname", "statemate_double_arm_03DIS")
                StalemateButtonSp_A2_Core_2 <- true
            }
        }

        if (StalemateRoomExitSp_A2_Core_2==false) {
            if (!Entities.FindByName(null, "player_inside_stalemate_room_trigger")) {
                RoomLookAtPlayerSp_A2_Core <- false
                EntFire("core_receptacle_pointer_1", "SetTargetEntity", "lookat_glados_bullseye", 0, null)
                EntFire("glados_pointer", "SetTargetEntity", "lookat_receptacle_bullseye", 0, null)
                StalemateRoomExitSp_A2_Core_2 <- true
            }
        }

        if (OnlyOnceMoveTeleportSp_A2_Core_2 == true) {
            if (Entities.FindByName(null, "OnMoveStartOnlyOnceSp_A2_Core_2")) {
                //Find all players
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    local InsideArea = false
                    local p2 = null
                    while (p2 = Entities.FindByClassnameWithin(p2, "player", Vector(-1836.2550048828, -0.81460344791412, -31.667282104492), 151.99999809265)) {
                        if (p2 == p) {
                            InsideArea = true
                        }
                    }

                    if (InsideArea==false) {
                        p.SetOrigin(Vector(-1839, 0, 8))
                        p.SetAngles(0, 0, 0)
                        p.SetVelocity(Vector(0, 0, 0))
                    }
                    EntFireByHandle(p, "setfogcontroller", "@environment_glados", 10, null, null)
                }
                OnlyOnceMoveTeleportSp_A2_Core_2 <- false
            }
        }

        if (OnlyOnceSp_A2_Core==true) {
            if (!Entities.FindByName(null, "exit_elevator_departure_trigger")) {
                printl("Elevator viewcontrol activated")
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

                EntFireByHandle(env_global01, "turnon", "", 0.1, null, null)
                EntFireByHandle(env_global02, "turnon", "", 0.1, null, null)
                EntFireByHandle(env_global03, "turnon", "", 0.1, null, null)
                EntFireByHandle(env_global04, "turnon", "", 0.1, null, null)
            }
        }

        // Second teleport into the elevator
        if (TPSp_A2_Core==true) {
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

        if (EnableMeSp_A2_Core==true) {
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

        if (RoomLookAtPlayerSp_A2_Core==true) {
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