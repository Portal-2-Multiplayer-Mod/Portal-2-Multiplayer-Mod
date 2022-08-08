//  ██████╗██████╗             █████╗ ██████╗            ████████╗██╗   ██╗██████╗ ██████╗ ███████╗████████╗           ██████╗ ██╗      █████╗  █████╗ ██╗  ██╗███████╗██████╗
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔════╝╚══██╔══╝           ██╔══██╗██║     ██╔══██╗██╔══██╗██║ ██╔╝██╔════╝██╔══██╗
// ╚█████╗ ██████╔╝           ███████║  ███╔═╝              ██║   ██║   ██║██████╔╝██████╔╝█████╗     ██║              ██████╦╝██║     ██║  ██║██║  ╚═╝█████═╝ █████╗  ██████╔╝
//  ╚═══██╗██╔═══╝            ██╔══██║██╔══╝                ██║   ██║   ██║██╔══██╗██╔══██╗██╔══╝     ██║              ██╔══██╗██║     ██║  ██║██║  ██╗██╔═██╗ ██╔══╝  ██╔══██╗
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗   ██║   ╚██████╔╝██║  ██║██║  ██║███████╗   ██║   ██████████╗██████╦╝███████╗╚█████╔╝╚█████╔╝██║ ╚██╗███████╗██║  ██║
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════════╝╚═════╝ ╚══════╝ ╚════╝  ╚════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        GlobalSpawnClass.useautospawn <- true
        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        Entities.FindByName(null, "blast_door").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(64, 1704, 64), 1024).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(64, 1776, 40), 1024).Destroy()
    }

    if (MSPostPlayerSpawn) {
        NewApertureStartElevatorFixes()
    }

        if (MSLoop) {
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(63, 2185, -265), 50)) {
             
            SendToConsoleP232("changelevel sp_a2_laser_vs_turret")
        }
    }
}