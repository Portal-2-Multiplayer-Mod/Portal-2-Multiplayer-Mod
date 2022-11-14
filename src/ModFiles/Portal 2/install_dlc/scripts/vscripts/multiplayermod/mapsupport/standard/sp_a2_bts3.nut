//  ██████╗██████╗             █████╗ ██████╗            ██████╗ ████████╗ ██████╗██████╗ 
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗╚══██╔══╝██╔════╝╚════██╗
// ╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██████╦╝   ██║   ╚█████╗  █████╔╝
//  ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██╔══██╗   ██║    ╚═══██╗ ╚═══██╗
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██████╦╝   ██║   ██████╔╝██████╔╝
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═════╝    ╚═╝   ╚═════╝ ╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn, MSOnSave, MSOnSaveCheck, MSOnSaveLoad) {
    if (MSInstantRun) {
        // Destroy objects
        Entities.FindByName(null, "death_fade").Destroy()
        Entities.FindByName(null, "death_fade").Destroy()
        Entities.FindByName(null, "death_fade").Destroy()
        Entities.FindByName(null, "blackout_teleport_player_to_wheatley").Destroy()
        Entities.FindByName(null, "laser_cutter_room_kill_relay").Destroy()
        Entities.FindByName(null, "fizzle_backtrack_trigger").Destroy()
        Entities.FindByName(null, "backtrack_portal_blocker").Destroy()
        Entities.FindByName(null, "backtrack_fun_preventer").Destroy()
        Entities.FindByName(null, "tube_scanner_room-shutdown_tube_objects").Destroy()
        Entities.FindByClassnameNearest("logic_auto", Vector(4231, 990, 194), 20).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(5952, 4624, -1736), 20).Destroy()
        // Set func_portal_detector to detect all portals
        Entities.FindByName(null, "blindness_detector").__KeyValueFromString("CheckAllIDs", "1")
    }

    if (MSPostPlayerSpawn) {
        EntFireByHandle(Entities.FindByName(null, "entry_canyon_global_impact_sound"), "PlaySound", "", 1.8, null, null)
        EntFireByHandle(Entities.FindByName(null, "entry_canyon_shake"), "StartShake", "", 1.8, null, null)
        EntFireByHandle(Entities.FindByName(null, "security_door_2_door_spark_1"), "StartSpark", "", 3, null, null)
        EntFireByHandle(Entities.FindByName(null, "entry_airlock_door-proxy"), "OnProxyRelay7", "", 3, null, null)
        EntFireByHandle(Entities.FindByName(null, "entry_container_impact_relay"), "Trigger", "", 5, null, null)
    }

    if (MSLoop) {
        // Make Wheatley look at nearest player (We need wheatley to light the way for the player but since he's looking at them on loop he can't) (Moja)
        try {
            local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "spherebot_1_bottom_swivel_1").GetOrigin(), 10000)
            EntFireByHandle(Entities.FindByName(null, "spherebot_1_bottom_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
        } catch(exception) {}

        // Make our own changelevel trigger
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(5952, 4624, -1736), 100)) {
             
            SendToConsoleP2MM("changelevel sp_a2_bts4")
        }
    }
}