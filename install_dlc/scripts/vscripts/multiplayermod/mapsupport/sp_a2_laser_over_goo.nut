// ██████╗██████╗             █████╗ ██████╗            ██╗      █████╗  ██████╗███████╗██████╗             █████╗ ██╗   ██╗███████╗██████╗             ██████╗  █████╗  █████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██║     ██╔══██╗██╔════╝██╔════╝██╔══██╗           ██╔══██╗██║   ██║██╔════╝██╔══██╗           ██╔════╝ ██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██║     ███████║╚█████╗ █████╗  ██████╔╝           ██║  ██║╚██╗ ██╔╝█████╗  ██████╔╝           ██║  ██╗ ██║  ██║██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██║     ██╔══██║ ╚═══██╗██╔══╝  ██╔══██╗           ██║  ██║ ╚████╔╝ ██╔══╝  ██╔══██╗           ██║  ╚██╗██║  ██║██║  ██║
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗███████╗██║  ██║██████╔╝███████╗██║  ██║██████████╗╚█████╔╝  ╚██╔╝  ███████╗██║  ██║██████████╗╚██████╔╝╚█████╔╝╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════════╝ ╚════╝    ╚═╝   ╚══════╝╚═╝  ╚═╝╚═════════╝ ╚═════╝  ╚════╝  ╚════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        GlobalSpawnClass.useautospawn <- true
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        Entities.FindByName(null, "@repair_wall_kill_all").Destroy()
        Entities.FindByName(null, "door_1-close_door_rl").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(2552, -1056, 142.82), 1024).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(2432, -1056, 72), 1024).Destroy()
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(2008, -1055, -328), 50)) {
             
            SendToConsole("changelevel sp_a2_catapult_intro")
        }
    }
}