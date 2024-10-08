// Mel

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Offset coop repsawn nodes for elevators (left and right side)
        GlobalSpawnClass.m_bUseAutoSpawn <- false

        // Remove Portal Gun
        UTIL_Team.Spawn_PortalGun(false)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)
        
        Entities.FindByClassnameNearest("logic_auto", Vector(244, 1435, 9816), 16).Destroy()
        


        // Make changing levels work
        EntFire("lift_track_9", "AddOutput", "OnPass p2mm_servercommand:Command:changelevel sp_a1_garden:3.5", 0, null)

        while (Entities.FindByName(null, "block_boxes")) {
            Entities.FindByName(null, "block_boxes").Destroy()
        }
    }
    
    if (MSPostPlayerSpawn) {
        Entities.FindByClassnameNearest("info_player_start", Vector(192, 1168, 9884), 9999).__KeyValueFromString("targetname", "playerSpawn")
        EntFire("playerSpawn", "SetParent", "Lift_Mover", 0, null)
        EntFire("global_ents-proxy", "OnProxyRelay6", null, 0, null)
        EntFire("music", "PlaySound", null, 1.5, null)
        EntFire("Lift_Mover", "StartForward", null, 3.5, null)
    }
    // if (MSOnPlayerJoin) {
    //     printlP2MM(1, true, "player joined\n\n\n\n")
    // }
}
