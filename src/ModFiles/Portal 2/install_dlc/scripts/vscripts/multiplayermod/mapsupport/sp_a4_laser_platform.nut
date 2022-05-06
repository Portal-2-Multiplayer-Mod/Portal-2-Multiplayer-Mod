// ██████╗██████╗             █████╗   ██╗██╗           ██╗      █████╗  ██████╗███████╗██████╗            ██████╗ ██╗      █████╗ ████████╗███████╗ █████╗ ██████╗ ███╗   ███╗
//██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ██║     ██╔══██╗██╔════╝██╔════╝██╔══██╗           ██╔══██╗██║     ██╔══██╗╚══██╔══╝██╔════╝██╔══██╗██╔══██╗████╗ ████║
//╚█████╗ ██████╔╝           ███████║██╔╝ ██║           ██║     ███████║╚█████╗ █████╗  ██████╔╝           ██████╔╝██║     ███████║   ██║   █████╗  ██║  ██║██████╔╝██╔████╔██║
// ╚═══██╗██╔═══╝            ██╔══██║███████║           ██║     ██╔══██║ ╚═══██╗██╔══╝  ██╔══██╗           ██╔═══╝ ██║     ██╔══██║   ██║   ██╔══╝  ██║  ██║██╔══██╗██║╚██╔╝██║
//██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗███████╗██║  ██║██████╔╝███████╗██║  ██║██████████╗██║     ███████╗██║  ██║   ██║   ██║     ╚█████╔╝██║  ██║██║ ╚═╝ ██║
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════════╝╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝      ╚════╝ ╚═╝  ╚═╝╚═╝     ╚═╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        GlobalSpawnClass.useautospawn <- true
        PermaPotato <- true
        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "StartForward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "entrance_door-close_door_rl").Destroy()
        Entities.FindByName(null, "fall_fade").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(4088, -528, -2080), 20).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(2949, -1210, -2266.13), 20).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(2267, -603, -142), 200).__KeyValueFromString("targetname", "mpmoddrop")
        Entities.FindByClassnameNearest("trigger_multiple", Vector(2656, -696, -1984), 200).__KeyValueFromString("targetname", "doortriggeroverride")
        EntFire("doortriggeroverride", "addoutput", "OnStartTouch doortriggeroverride:kill::0.01", 1, null)
        Sp_A4_Laser_Platform_1 <- false
    }

    if (MSPostPlayerSpawn) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop) {

        if (!Entities.FindByName(null, "mpmoddrop")) {
            if (!Sp_A4_Laser_Platform_1) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(2318, -600, -142))
                    Sp_A4_Laser_Platform_1 <- true
                }
            }

            // Set new spawnpoint
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1175, -1248, -78), 600)) {
                p.SetOrigin(Vector(2385, -600, -88))
                p.SetAngles(0 0 0)
            }

        }

        // Make our own changelevel trigger
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(3456, -1056, -2648), 200)) {
             
            SendToConsoleP2MM("changelevel sp_a4_speed_tb_catch")
        }
    }
}