// ██████╗██████╗             █████╗ ██████╗            ████████╗██████╗ ██╗██████╗ ██╗     ███████╗           ██╗      █████╗  ██████╗███████╗██████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ╚══██╔══╝██╔══██╗██║██╔══██╗██║     ██╔════╝           ██║     ██╔══██╗██╔════╝██╔════╝██╔══██╗
//╚█████╗ ██████╔╝           ███████║  ███╔═╝              ██║   ██████╔╝██║██████╔╝██║     █████╗             ██║     ███████║╚█████╗ █████╗  ██████╔╝
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝                ██║   ██╔══██╗██║██╔═══╝ ██║     ██╔══╝             ██║     ██╔══██║ ╚═══██╗██╔══╝  ██╔══██╗
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗   ██║   ██║  ██║██║██║     ███████╗███████╗██████████╗███████╗██║  ██║██████╔╝███████╗██║  ██║
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝╚══════╝╚═════════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        // We should do something sussy in this map, probably something the observation room (Kinda Moja)
        Entities.FindByClassnameNearest("trigger_once", Vector(6984, -5376, 40), 1024).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(6912, -5376, 40), 1024).Destroy()
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(6494, -5376, -273), 50)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a2_bts1")
        }

        // Elevator env_projectedtexture
        try {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
        } catch(exception) {}
    }
}