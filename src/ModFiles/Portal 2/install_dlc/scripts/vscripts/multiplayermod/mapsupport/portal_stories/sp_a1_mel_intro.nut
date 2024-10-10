//  ██████╗██████╗             █████╗   ███╗             ███╗   ███╗███████╗██╗                ██╗███╗  ██╗████████╗██████╗  █████╗ 
// ██╔════╝██╔══██╗           ██╔══██╗ ████║             ████╗ ████║██╔════╝██║                ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
// ╚█████╗ ██████╔╝           ███████║██╔██║             ██╔████╔██║█████╗  ██║                ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
//  ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║╚██╔╝██║██╔══╝  ██║                ██║██║╚████║   ██║   ██╔══██╗██║  ██║
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║ ╚═╝ ██║███████╗███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝     ╚═╝╚══════╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Offset coop repsawn nodes for elevators (left and right side)
        GlobalSpawnClass.m_bUseAutoSpawn <- false

        // Remove Portal Gun
        UTIL_Team.Spawn_PortalGun(false)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)
        
        // Make changing levels work
        if(GetMapName().find("sp_", 0) == 0) {EntFire("logic_branch_listener", "AddOutput", "OnAllTrue p2mm_servercommand:Command:changelevel sp_a1_lift:0.3", 0, null)}
        else EntFire("logic_branch_listener", "AddOutput", "OnAllTrue p2mm_servercommand:Command:changelevel st_a1_lift:0.3", 0, null)
        

        while (Entities.FindByName(null, "block_boxes")) {
            Entities.FindByName(null, "block_boxes").Destroy()
        }
    }
}
