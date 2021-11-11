// ██████╗██████╗             █████╗   ██╗██╗           ██╗      █████╗  ██████╗███████╗██████╗             █████╗  █████╗ ████████╗ █████╗ ██████╗ ██╗   ██╗██╗     ████████╗
//██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ██║     ██╔══██╗██╔════╝██╔════╝██╔══██╗           ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██║   ██║██║     ╚══██╔══╝
//╚█████╗ ██████╔╝           ███████║██╔╝ ██║           ██║     ███████║╚█████╗ █████╗  ██████╔╝           ██║  ╚═╝███████║   ██║   ███████║██████╔╝██║   ██║██║        ██║   
// ╚═══██╗██╔═══╝            ██╔══██║███████║           ██║     ██╔══██║ ╚═══██╗██╔══╝  ██╔══██╗           ██║  ██╗██╔══██║   ██║   ██╔══██║██╔═══╝ ██║   ██║██║        ██║   
//██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗███████╗██║  ██║██████╔╝███████╗██║  ██║██████████╗╚█████╔╝██║  ██║   ██║   ██║  ██║██║     ╚██████╔╝███████╗   ██║   
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════════╝ ╚════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝      ╚═════╝ ╚══════╝   ╚═╝   

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (GetMapName()=="sp_a4_laser_catapult") {
        if (MSInstantRun==true) {
            // Make elevator start moving on level load
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "StartForward", "", 0, null, null)
            // Destroy objects
            Entities.FindByName(null, "@entry_door-close_door_rl").Destroy()
            Entities.FindByName(null, "@exit_door-close_door_rl").Destroy()
            Entities.FindByClassnameNearest("trigger_once", Vector(624, -512, 576), 20).Destroy()
        }

        if (MSPostPlayerSpawn==true) {
            NewApertureStartElevatorFixes()
        }

        if (MSLoop==true) {
            // Elevator changelevel
            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(1248, -512, 912), 50)) {
                SendToConsole("commentary 1")
                SendToConsole("changelevel sp_a4_laser_platform")
            }
        }
    }
}