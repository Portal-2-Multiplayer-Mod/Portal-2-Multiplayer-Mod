// ██████╗██████╗             █████╗   ██╗██╗           ████████╗██████╗             ██╗       ██╗ █████╗ ██╗     ██╗                ██████╗ ██╗   ██╗████████╗████████╗ █████╗ ███╗  ██╗
//██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ╚══██╔══╝██╔══██╗            ██║  ██╗  ██║██╔══██╗██║     ██║                ██╔══██╗██║   ██║╚══██╔══╝╚══██╔══╝██╔══██╗████╗ ██║
//╚█████╗ ██████╔╝           ███████║██╔╝ ██║              ██║   ██████╦╝            ╚██╗████╗██╔╝███████║██║     ██║                ██████╦╝██║   ██║   ██║      ██║   ██║  ██║██╔██╗██║
// ╚═══██╗██╔═══╝            ██╔══██║███████║              ██║   ██╔══██╗             ████╔═████║ ██╔══██║██║     ██║                ██╔══██╗██║   ██║   ██║      ██║   ██║  ██║██║╚████║
//██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗   ██║   ██████╦╝██████████╗  ╚██╔╝ ╚██╔╝ ██║  ██║███████╗███████╗██████████╗██████╦╝╚██████╔╝   ██║      ██║   ╚█████╔╝██║ ╚███║
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝   ╚═╝   ╚═════╝ ╚═════════╝   ╚═╝   ╚═╝  ╚═╝  ╚═╝╚══════╝╚══════╝╚═════════╝╚═════╝  ╚═════╝    ╚═╝      ╚═╝    ╚════╝ ╚═╝  ╚══╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (GetMapName()=="sp_a4_tb_wall_button") {
        if (MSInstantRun==true) {
            // Make elevator start moving on level load
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "StartForward", "", 0, null, null)
            // Destroy objects
            Entities.FindByName(null, "door_0-close_door_rl").Destroy()
            Entities.FindByName(null, "fall_fade").Destroy()
            Entities.FindByClassnameNearest("trigger_multiple", Vector(736, 960, 160), 20).Destroy()
            Entities.FindByClassnameNearest("trigger_once", Vector(864, 960, 168), 20).Destroy()
        }

        if (MSPostPlayerSpawn==true) {
            NewApertureStartElevatorFixes()
        }

        if (MSLoop==true) {
            // Elevator changelevel
            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(1280, 960, 528), 50)) {
                SendToConsole("commentary 1")
                SendToConsole("changelevel sp_a4_tb_polarity")
            }
        }
    }
}