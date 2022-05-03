// ██████╗██████╗             █████╗ ██████╗            ███████╗██╗███████╗███████╗██╗     ███████╗██████╗            ██╗███╗  ██╗████████╗██████╗  █████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔════╝██║╚════██║╚════██║██║     ██╔════╝██╔══██╗           ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║  ███╔═╝           █████╗  ██║  ███╔═╝  ███╔═╝██║     █████╗  ██████╔╝           ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██╔══╝  ██║██╔══╝  ██╔══╝  ██║     ██╔══╝  ██╔══██╗           ██║██║╚████║   ██║   ██╔══██╗██║  ██║
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║     ██║███████╗███████╗███████╗███████╗██║  ██║██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        GlobalSpawnClass.useautospawn <- true
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(872, -64, -8), 1024).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(928, -64, -24), 1024).Destroy()
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(1351, -71, -503), 50)) {
             
            SendToConsoleP232("changelevel sp_a2_sphere_peek")
        }
    }
}