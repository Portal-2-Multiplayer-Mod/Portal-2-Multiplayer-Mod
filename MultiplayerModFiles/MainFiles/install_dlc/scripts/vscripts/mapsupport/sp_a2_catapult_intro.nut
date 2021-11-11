// ██████╗██████╗             █████╗ ██████╗             █████╗  █████╗ ████████╗ █████╗ ██████╗ ██╗   ██╗██╗     ████████╗           ██╗███╗  ██╗████████╗██████╗  █████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██║   ██║██║     ╚══██╔══╝           ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██║  ╚═╝███████║   ██║   ███████║██████╔╝██║   ██║██║        ██║              ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██║  ██╗██╔══██║   ██║   ██╔══██║██╔═══╝ ██║   ██║██║        ██║              ██║██║╚████║   ██║   ██╔══██╗██║  ██║
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗╚█████╔╝██║  ██║   ██║   ██║  ██║██║     ╚██████╔╝███████╗   ██║   ██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝ ╚════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝      ╚═════╝ ╚══════╝   ╚═╝   ╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (GetMapName()=="sp_a2_catapult_intro") {
        if (MSInstantRun==true) {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
            // Destroy objects
            Entities.FindByName(null, "door_1-close_door_rl").Destroy()
            Entities.FindByClassnameNearest("trigger_once", Vector(-56, -1576, -384), 1024).Destroy()
            Entities.FindByClassnameNearest("trigger_once", Vector(-64, -1696, -408), 1024).Destroy()
        }

        if (MSPostPlayerSpawn==true) {
            NewApertureStartElevatorFixes()
        }

        if (MSLoop==true) {
            // Elevator changelevel
            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(-80, -2106, -805), 50)) {
                SendToConsole("commentary 1")
                SendToConsole("changelevel sp_a2_trust_fling")
            }


        }
    }}