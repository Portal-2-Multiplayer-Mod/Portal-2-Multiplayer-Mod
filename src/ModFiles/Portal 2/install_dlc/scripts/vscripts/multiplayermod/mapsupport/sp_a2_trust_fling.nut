// ██████╗██████╗             █████╗ ██████╗            ████████╗██████╗ ██╗   ██╗ ██████╗████████╗           ███████╗██╗     ██╗███╗  ██╗ ██████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ╚══██╔══╝██╔══██╗██║   ██║██╔════╝╚══██╔══╝           ██╔════╝██║     ██║████╗ ██║██╔════╝ 
//╚█████╗ ██████╔╝           ███████║  ███╔═╝              ██║   ██████╔╝██║   ██║╚█████╗    ██║              █████╗  ██║     ██║██╔██╗██║██║  ██╗ 
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝                ██║   ██╔══██╗██║   ██║ ╚═══██╗   ██║              ██╔══╝  ██║     ██║██║╚████║██║  ╚██╗
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗   ██║   ██║  ██║╚██████╔╝██████╔╝   ██║   ██████████╗██║     ███████╗██║██║ ╚███║╚██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝    ╚═╝   ╚═════════╝╚═╝     ╚══════╝╚═╝╚═╝  ╚══╝ ╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        GlobalSpawnClass.useautospawn <- true
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-1152, 1616, 120), 1024).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-1152, 1680, 40), 1024).Destroy()
    }

    if (MSPostPlayerSpawn) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop) {
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-1151, 2087, -319), 50)) {
             
            SendToConsoleP2MM("changelevel sp_a2_pit_flings")
        }
    }
}