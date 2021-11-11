// ██████╗██████╗             █████╗ ██████╗            ██████╗ ██╗   ██╗██╗     ██╗                ████████╗██╗  ██╗███████╗           ██████╗ ██╗   ██╗ ██████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██║   ██║██║     ██║                ╚══██╔══╝██║  ██║██╔════╝           ██╔══██╗██║   ██║██╔════╝ 
//╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██████╔╝██║   ██║██║     ██║                   ██║   ███████║█████╗             ██████╔╝██║   ██║██║  ██╗ 
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██╔═══╝ ██║   ██║██║     ██║                   ██║   ██╔══██║██╔══╝             ██╔══██╗██║   ██║██║  ╚██╗
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║     ╚██████╔╝███████╗███████╗██████████╗   ██║   ██║  ██║███████╗██████████╗██║  ██║╚██████╔╝╚██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝      ╚═════╝ ╚══════╝╚══════╝╚═════════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (GetMapName()=="sp_a2_pull_the_rug") {
        if (MSInstantRun==true) {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
            // Destroy objects
            Entities.FindByName(null, "door_0-close_door_rl").Destroy()
            Entities.FindByName(null, "prevent_ratman_backtrack").Destroy()
            Entities.FindByClassnameNearest("trigger_once", Vector(64, 896, 104), 1024).Destroy()
            Entities.FindByClassnameNearest("trigger_once", Vector(64, 888, 96), 1024).Destroy()
            Entities.FindByClassnameNearest("prop_dynamic", Vector(80, -755, 256), 1024).SetOrigin(Vector(72, -777, 192))
        }

        if (MSPostPlayerSpawn==true) {
            NewApertureStartElevatorFixes()
        }

        if (MSLoop==true) {
            // Elevator changelevel
            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(64, 1311, -200), 50)) {
                SendToConsole("commentary 1")
                SendToConsole("changelevel sp_a2_column_blocker")
            }
        }
    }
}