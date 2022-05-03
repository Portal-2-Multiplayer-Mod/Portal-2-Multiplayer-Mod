// ██████╗██████╗             █████╗ ██████╗            ██████╗ ██████╗ ██╗██████╗  ██████╗ ███████╗           ████████╗██╗  ██╗███████╗            ██████╗  █████╗ ██████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██╔══██╗██║██╔══██╗██╔════╝ ██╔════╝           ╚══██╔══╝██║  ██║██╔════╝           ██╔════╝ ██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██████╦╝██████╔╝██║██║  ██║██║  ██╗ █████╗                ██║   ███████║█████╗             ██║  ██╗ ███████║██████╔╝
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██╔══██╗██╔══██╗██║██║  ██║██║  ╚██╗██╔══╝                ██║   ██╔══██║██╔══╝             ██║  ╚██╗██╔══██║██╔═══╝ 
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██████╦╝██║  ██║██║██████╔╝╚██████╔╝███████╗██████████╗   ██║   ██║  ██║███████╗██████████╗╚██████╔╝██║  ██║██║     
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═════╝ ╚═╝  ╚═╝╚═╝╚═════╝  ╚═════╝ ╚══════╝╚═════════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═════════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝     

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        GlobalSpawnClass.useautospawn <- true
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        // Destroy beginning door triggers
        Entities.FindByClassnameNearest("trigger_once", Vector(-1296, -640, 1280), 1024).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-496, -640, 1216), 1024).Destroy()
        // Destroy objects
        Entities.FindByClassnameNearest("trigger_once", Vector(320, 624, 960), 1024).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(320, 960, 936), 1024).Destroy()
        // Fix func_portal_detectors
        local ent = null
        while (ent = Entities.FindByClassname(ent, "func_portal_detector")) {
            ent.__KeyValueFromString("CheckAllIDs", "1")
        }
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        // Make Wheatley look at nearest player
        local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "@sphere_bottom_swivel_1").GetOrigin(), 10000)
        EntFireByHandle(Entities.FindByName(null, "@sphere_bottom_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)

        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(321, 1374, 561), 50)) {
             
            SendToConsoleP232("changelevel sp_a2_turret_intro")
        }
    }
}