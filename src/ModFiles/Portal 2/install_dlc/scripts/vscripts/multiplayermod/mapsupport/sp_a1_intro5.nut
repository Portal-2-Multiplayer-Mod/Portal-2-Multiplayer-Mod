// ██████╗██████╗             █████╗   ███╗             ██╗███╗  ██╗████████╗██████╗  █████╗ ███████╗
//██╔════╝██╔══██╗           ██╔══██╗ ████║             ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗██╔════╝
//╚█████╗ ██████╔╝           ███████║██╔██║             ██║██╔██╗██║   ██║   ██████╔╝██║  ██║██████╗ 
// ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║██║╚████║   ██║   ██╔══██╗██║  ██║╚════██╗
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ ╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun == true) {
        GlobalSpawnClass.useautospawn <- true
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        Entities.FindByName(null, "room_1_portal_activate_rl").Destroy()
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        Entities.FindByClassnameNearest("trigger_multiple", Vector(-64, 824, 320), 1024).Destroy()
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        try {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
        } catch(exception) {}
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-67, 1319, -102), 60)) {
            SendToConsoleP232("changelevel sp_a1_intro6")
        }
    }
}