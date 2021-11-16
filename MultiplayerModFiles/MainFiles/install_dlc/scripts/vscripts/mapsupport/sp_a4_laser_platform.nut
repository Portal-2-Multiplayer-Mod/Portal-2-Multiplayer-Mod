// ██████╗██████╗             █████╗   ██╗██╗           ██╗      █████╗  ██████╗███████╗██████╗            ██████╗ ██╗      █████╗ ████████╗███████╗ █████╗ ██████╗ ███╗   ███╗
//██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ██║     ██╔══██╗██╔════╝██╔════╝██╔══██╗           ██╔══██╗██║     ██╔══██╗╚══██╔══╝██╔════╝██╔══██╗██╔══██╗████╗ ████║
//╚█████╗ ██████╔╝           ███████║██╔╝ ██║           ██║     ███████║╚█████╗ █████╗  ██████╔╝           ██████╔╝██║     ███████║   ██║   █████╗  ██║  ██║██████╔╝██╔████╔██║
// ╚═══██╗██╔═══╝            ██╔══██║███████║           ██║     ██╔══██║ ╚═══██╗██╔══╝  ██╔══██╗           ██╔═══╝ ██║     ██╔══██║   ██║   ██╔══╝  ██║  ██║██╔══██╗██║╚██╔╝██║
//██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗███████╗██║  ██║██████╔╝███████╗██║  ██║██████████╗██║     ███████╗██║  ██║   ██║   ██║     ╚█████╔╝██║  ██║██║ ╚═╝ ██║
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════════╝╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝      ╚════╝ ╚═╝  ╚═╝╚═╝     ╚═╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "StartForward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "entrance_door-close_door_rl").Destroy()
        Entities.FindByName(null, "fall_fade").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(4088, -528, -2080), 20).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(2267, -603, -142), 200).__KeyValueFromString("targetname", "mpmoddrop")
        Sp_A4_Laser_Platform_1 <- false
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        if (!Entities.FindByName(null, "mpmoddrop")) {
            if (Sp_A4_Laser_Platform_1==false) {
                local p = null
                while (p = Entities.FindByClassname(null, "player")) {
                    p.SetOrigin(Vector(2318, -600, -142))
                    Sp_A4_Laser_Platform_1 <- true
                }
            }
        }
        local ent = null
        while (ent = Entities.FindByClassname(ent, "trigger_once")) {
            printl(ent.GetName())
        }
        printl("=============================")
        // Make our own changelevel trigger
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(3456, -1056, -2648), 200)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a4_speed_tb_catch")
        }
    }
}