//  ██████╗██████╗             █████╗   ███╗             ███╗   ███╗███████╗██╗                ██╗███╗  ██╗████████╗██████╗  █████╗ 
// ██╔════╝██╔══██╗           ██╔══██╗ ████║             ████╗ ████║██╔════╝██║                ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
// ╚█████╗ ██████╔╝           ███████║██╔██║             ██╔████╔██║█████╗  ██║                ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
//  ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║╚██╔╝██║██╔══╝  ██║                ██║██║╚████║   ██║   ██╔══██╗██║  ██║
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║ ╚═╝ ██║███████╗███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝     ╚═╝╚══════╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Remove Portal Gun
        UTIL_Team.Spawn_PortalGun(false)
        hCountdownEnableTrigger = Entities.FindByClassnameNearest("trigger_once", Vector(404, 4723.01, 12361.5), 32)
        EntFireByHandle(hCountdownEnableTrigger, "Disable", "", 0, null, null)

        // Enable pinging and disable taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(false)
        
        // Make changing levels work
        Entities.FindByName(null, "end_command").Destroy()
        if (GetMapName().find("sp_") != null) {
            EntFireByHandle(Entities.FindByClassname(null, "logic_branch_listener"), "AddOutput", "OnAllTrue p2mm_servercommand:Command:changelevel sp_a1_lift:4.6", 0, null, null)
        } else EntFireByHandle(Entities.FindByClassname(null, "logic_branch_listener"), "AddOutput", "OnAllTrue p2mm_servercommand:Command:changelevel st_a1_lift:4.6", 0, null, null)
    }

    if (MSLoop) {
        for (local p = null; p = Entities.FindByClassnameWithin(p, "player", Entities.FindByName(null, "lift_door").GetOrigin(), 128);)
            StartCountTransition(p)
    }
}
