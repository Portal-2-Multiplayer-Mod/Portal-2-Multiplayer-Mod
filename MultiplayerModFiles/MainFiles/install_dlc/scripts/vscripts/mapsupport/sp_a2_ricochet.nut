// ██████╗██████╗             █████╗ ██████╗            ██████╗ ██╗ █████╗  █████╗  █████╗ ██╗  ██╗███████╗████████╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██║██╔══██╗██╔══██╗██╔══██╗██║  ██║██╔════╝╚══██╔══╝
//╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██████╔╝██║██║  ╚═╝██║  ██║██║  ╚═╝███████║█████╗     ██║   
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██╔══██╗██║██║  ██╗██║  ██║██║  ██╗██╔══██║██╔══╝     ██║   
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║  ██║██║╚█████╔╝╚█████╔╝╚█████╔╝██║  ██║███████╗   ██║   
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝  ╚═╝╚═╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝  ╚═╝╚══════╝   ╚═╝   

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (GetMapName()=="sp_a2_ricochet") {
        if (MSInstantRun==true) {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
            // Destroy objects
            Entities.FindByName(null, "door_0-close_door_rl").Destroy()
            Entities.FindByClassnameNearest("trigger_once", Vector(4008, 1152, -456), 1024).Destroy()
            Entities.FindByClassnameNearest("trigger_once", Vector(4064, 1152, -472), 1024).Destroy()
        }

        if (MSPostPlayerSpawn==true) {
            NewApertureStartElevatorFixes()
        }

        if (MSLoop==true) {
            // Elevator changelevel
            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(4478, 1158, -774), 50)) {
                SendToConsole("commentary 1")
                SendToConsole("changelevel sp_a2_bridge_intro")
            }
        }
    }
}