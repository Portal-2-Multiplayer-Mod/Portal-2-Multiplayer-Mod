// ████████╗███████╗███╗   ███╗██████╗ ██╗      █████╗ ████████╗███████╗
// ╚══██╔══╝██╔════╝████╗ ████║██╔══██╗██║     ██╔══██╗╚══██╔══╝██╔════╝
//    ██║   █████╗  ██╔████╔██║██████╔╝██║     ███████║   ██║   █████╗
//    ██║   ██╔══╝  ██║╚██╔╝██║██╔═══╝ ██║     ██╔══██║   ██║   ██╔══╝
//    ██║   ███████╗██║ ╚═╝ ██║██║     ███████╗██║  ██║   ██║   ███████╗
//    ╚═╝   ╚══════╝╚═╝     ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        UTIL_Team.Spawn_PortalGun(true)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)

        // elevator stuff
        EntFire("arrival_logic-elevator_1", "MoveToPathNode", "@elevator_1_bottom_path_1", 0.1, null)
        EntFire("arrival_logic-light_elevator_fill", "TurnOn")
        EntFire("arrival_logic-signs_on", "Trigger")
        EntFire("arrival_logic-light_elevator_dynamic", "TurnOn")

        Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(-112, -64, 336))
        Entities.FindByClassname(null, "info_player_start").SetAngles(0, 0, 0)

        // Make changing levels work
        Entities.FindByName(null, "end_command").Destroy()
        if (GetMapName().find("sp_") != null) {
            EntFire("end_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel sp_a4_factory:2", 0, null)
        } else EntFire("end_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel st_a4_factory:2", 0, null)
    }
    
    if (MSPostPlayerSpawn) {
        Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(256, 512, -50))

        
    }
}
