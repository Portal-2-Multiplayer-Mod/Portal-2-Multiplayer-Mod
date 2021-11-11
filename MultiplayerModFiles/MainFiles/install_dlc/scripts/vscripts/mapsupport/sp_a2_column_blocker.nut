// ██████╗██████╗             █████╗ ██████╗             █████╗  █████╗ ██╗     ██╗   ██╗███╗   ███╗███╗  ██╗           ██████╗ ██╗      █████╗  █████╗ ██╗  ██╗███████╗██████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██╔══██╗██║     ██║   ██║████╗ ████║████╗ ██║           ██╔══██╗██║     ██╔══██╗██╔══██╗██║ ██╔╝██╔════╝██╔══██╗
//╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██║  ╚═╝██║  ██║██║     ██║   ██║██╔████╔██║██╔██╗██║           ██████╦╝██║     ██║  ██║██║  ╚═╝█████═╝ █████╗  ██████╔╝
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██║  ██╗██║  ██║██║     ██║   ██║██║╚██╔╝██║██║╚████║           ██╔══██╗██║     ██║  ██║██║  ██╗██╔═██╗ ██╔══╝  ██╔══██╗
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗╚█████╔╝╚█████╔╝███████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚███║██████████╗██████╦╝███████╗╚█████╔╝╚█████╔╝██║ ╚██╗███████╗██║  ██║
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝ ╚════╝  ╚════╝ ╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚══╝╚═════════╝╚═════╝ ╚══════╝ ╚════╝  ╚════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (GetMapName()=="sp_a2_column_blocker") {
        if (MSInstantRun==true) {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
            // Destroy objects
            Entities.FindByName(null, "door_0-close_door_rl").Destroy()
            // Kill the point_teleport so we aren't teleporting 33 players to the exact same place
            Entities.FindByName(null, "blackout_teleport_player_to_surprise").Destroy()
            Entities.FindByClassnameNearest("trigger_once", Vector(-976, 256, 32), 1024).Destroy()
            Entities.FindByClassnameNearest("trigger_once", Vector(-1056, 256, 40.25), 1024).Destroy()
            OnlyOnceSpA2ColumBlocker1 <- true
            OnlyOnceSpA2ColumBlocker2 <- true
            OnlyOnceSpA2ColumBlocker3 <- true
        }

        if (MSPostPlayerSpawn==true) {
            NewApertureStartElevatorFixes()
            Entities.FindByClassnameNearest("trigger_once", Vector(-1394, 108, -1906), 1024).__KeyValueFromString("spawnflags", "4161")
            Entities.FindByClassnameNearest("trigger_once", Vector(-1472, 256, -2591.75), 1024).__KeyValueFromString("spawnflags", "4161")
        }

        if (MSLoop==true) {
            if (OnlyOnceSpA2ColumBlocker3==true) {
                if (!Entities.FindByClassnameNearest("trigger_once", Vector(-1486, 256, -139.75), 10)) {
                    printl("Elevator viewcontrol activated")
                    // Elevator viewcontrol
                    SpA2ColumBlockerViewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
                    SpA2ColumBlockerViewcontrol.__KeyValueFromString("target_team", "-1")
                    SpA2ColumBlockerViewcontrol.__KeyValueFromString("fov", "100")
                    SpA2ColumBlockerViewcontrol.__KeyValueFromString("targetname", "SpA2ColumBlockerViewcontrol")
                    SpA2ColumBlockerViewcontrol.SetOrigin(Vector(-1475, 256, -90))
                    EntFire("SpA2ColumBlockerViewcontrol", "setparent", "departure_elevator-elevator_1", 0, null)
                    SpA2ColumBlockerViewcontrol.SetAngles(0, 0, 0)
                    EntFire("SpA2ColumBlockerViewcontrol", "enable", "", 0, null)

                    EntFireByHandle(Entities.FindByName(null, "departure_elevator-spherebot_1_bottom_swivel_1"), "SetTargetEntity", "SpA2ColumBlockerViewcontrol", 0, null, null)

                    EntFire("global_ents-proxy", "OnProxyRelay2", "", 6.2, null)
                    EntFire("departure_elevator-bts_shadowed_light_01", "TurnOn", "", 6.2, null)
                    EntFire("departure_elevator-elevator_1", "SetSpeedReal", "50", 6.2, null)

                    OnlyOnceSpA2ColumBlockerGlobalTime <- 9
                    Entities.CreateByClassname("point_servercommand").__KeyValueFromString("targetname", "SpA2ColumBlockerCommand")
                    EntFire("@sphere", "RunScriptCode", "ElevatorThereYouAre()", OnlyOnceSpA2ColumBlockerGlobalTime, null)
                    EntFire("departure_elevator-//spherebot_train_1_chassis_1", "MoveToPathNode", "spherebot_train_1_path_2", OnlyOnceSpA2ColumBlockerGlobalTime, null)
                    EntFire("ColumServerCommand", "command", "echo Changing level...", OnlyOnceSpA2ColumBlockerGlobalTime + 29, null)
                    EntFire("ColumServerCommand", "command", "changelevel sp_a2_laser_chaining", OnlyOnceSpA2ColumBlockerGlobalTime + 29, null)

                    local p = null
                    while (p = Entities.FindByClassname(p, "player")) {
                        p.SetOrigin(Vector(-1964, 331, -2479))
                    }

                    OnlyOnceSpA2ColumBlocker3 <- false
                }
            }

            // Delete office door after walking through it
            if (OnlyOnceSpA2ColumBlocker2==true) {
                local p = null
                while (p = Entities.FindByClassnameWithin(p, "player", Vector(-63, -780, 320), 40)) {
                    Entities.FindByName(null, "officedoor_1").Destroy()
                    OnlyOnceSpA2ColumBlocker2 <- false
                }
            }

            // Teleport players after blackout
            if (OnlyOnceSpA2ColumBlocker1==true) {
                if (!Entities.FindByClassnameNearest("trigger_once", Vector(-76, -1040, 311.5), 3)) {
                    // Find all players
                    local p = null
                    while (p = Entities.FindByClassname(p, "player")) {
                        p.SetOrigin(Vector(-64, -1088, 256))
                        p.SetAngles(0, 90, 0)
                    }
                    OnlyOnceSpA2ColumBlocker1 <- false
                }
            }

            // Elevator changelevel
            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(-1469, 265, -2870), 50)) {
                SendToConsole("commentary 1")
                SendToConsole("changelevel sp_a2_laser_chaining")
            }
        }
    }
}