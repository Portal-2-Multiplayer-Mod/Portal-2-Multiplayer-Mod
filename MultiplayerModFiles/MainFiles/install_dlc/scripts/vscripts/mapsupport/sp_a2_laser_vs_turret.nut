// ██████╗██████╗             █████╗ ██████╗            ██╗      █████╗  ██████╗███████╗██████╗            ██╗   ██╗ ██████╗           ████████╗██╗   ██╗██████╗ ██████╗ ███████╗████████╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██║     ██╔══██╗██╔════╝██╔════╝██╔══██╗           ██║   ██║██╔════╝           ╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔════╝╚══██╔══╝
//╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██║     ███████║╚█████╗ █████╗  ██████╔╝           ╚██╗ ██╔╝╚█████╗               ██║   ██║   ██║██████╔╝██████╔╝█████╗     ██║   
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██║     ██╔══██║ ╚═══██╗██╔══╝  ██╔══██╗            ╚████╔╝  ╚═══██╗              ██║   ██║   ██║██╔══██╗██╔══██╗██╔══╝     ██║   
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗███████╗██║  ██║██████╔╝███████╗██║  ██║██████████╗  ╚██╔╝  ██████╔╝██████████╗   ██║   ╚██████╔╝██║  ██║██║  ██║███████╗   ██║   
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════════╝   ╚═╝   ╚═════╝ ╚═════════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (GetMapName()=="sp_a2_laser_vs_turret") {
        if (MSInstantRun==true) {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
            // Destroy objects
            Entities.FindByName(null, "door_0-close_door_rl").Destroy()
            Entities.FindByClassnameNearest("trigger_once", Vector(-631, 377, 322), 1024).Destroy()
            Entities.FindByClassnameNearest("trigger_once", Vector(-672, 384, 296), 1024).Destroy()
        }

        if (MSPostPlayerSpawn==true) {
            NewApertureStartElevatorFixes()
        }

        if (MSLoop==true) {
            // Elevator changelevel
            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(-1075, 382, -8), 50)) {
                SendToConsole("commentary 1")
                SendToConsole("changelevel sp_a2_pull_the_rug")
            }


        }
    }
}