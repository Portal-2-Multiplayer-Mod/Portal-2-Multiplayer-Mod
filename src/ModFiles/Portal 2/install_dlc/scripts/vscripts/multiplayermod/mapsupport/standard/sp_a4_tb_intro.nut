//  ██████╗██████╗             █████╗   ██╗██╗           ████████╗██████╗            ██╗███╗  ██╗████████╗██████╗  █████╗ 
// ██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ╚══██╔══╝██╔══██╗           ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
// ╚█████╗ ██████╔╝           ███████║██╔╝ ██║              ██║   ██████╦╝           ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
//  ╚═══██╗██╔═══╝            ██╔══██║███████║              ██║   ██╔══██╗           ██║██║╚████║   ██║   ██╔══██╗██║  ██║
// ██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗   ██║   ██████╦╝██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝   ╚═╝   ╚═════╝ ╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        GlobalSpawnClass.useautospawn <- true
        PermaPotato <- true
        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "StartForward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(2368, 736, 72), 20).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(2368, 736, 64), 20).Destroy()
    }

    if (MSPostPlayerSpawn) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop) {
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(2784, 736, 432), 50)) {
             
            SendToConsoleP232("changelevel sp_a4_tb_trust_drop")
        }
    }
}