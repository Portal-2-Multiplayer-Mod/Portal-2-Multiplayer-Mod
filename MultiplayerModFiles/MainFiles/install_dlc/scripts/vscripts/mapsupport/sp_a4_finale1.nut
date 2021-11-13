// ██████╗██████╗             █████╗   ██╗██╗           ███████╗██╗███╗  ██╗ █████╗ ██╗     ███████╗  ███╗  
//██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ██╔════╝██║████╗ ██║██╔══██╗██║     ██╔════╝ ████║  
//╚█████╗ ██████╔╝           ███████║██╔╝ ██║           █████╗  ██║██╔██╗██║███████║██║     █████╗  ██╔██║  
// ╚═══██╗██╔═══╝            ██╔══██║███████║           ██╔══╝  ██║██║╚████║██╔══██║██║     ██╔══╝  ╚═╝██║  
//██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗██║     ██║██║ ╚███║██║  ██║███████╗███████╗███████╗
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝╚═╝     ╚═╝╚═╝  ╚══╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "StartForward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "entrance_door-close_door_rl").Destroy()
        Entities.FindByName(null, "fall_fade").Destroy()
        Entities.FindByName(null, "final_door-close_door_fast").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-10792, -2048.01, 144), 20).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-12832, -3040, -112), 20).Destroy()
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        // Make our own changelevel trigger
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-12832, -3040, -112), 100)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a4_finale2")
        }
    }
}