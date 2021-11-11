// ██████╗██████╗             █████╗ ██████╗            ██████╗ ██╗████████╗           ███████╗██╗     ██╗███╗  ██╗ ██████╗  ██████╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██║╚══██╔══╝           ██╔════╝██║     ██║████╗ ██║██╔════╝ ██╔════╝
//╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██████╔╝██║   ██║              █████╗  ██║     ██║██╔██╗██║██║  ██╗ ╚█████╗ 
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██╔═══╝ ██║   ██║              ██╔══╝  ██║     ██║██║╚████║██║  ╚██╗ ╚═══██╗
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║     ██║   ██║   ██████████╗██║     ███████╗██║██║ ╚███║╚██████╔╝██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝     ╚═╝   ╚═╝   ╚═════════╝╚═╝     ╚══════╝╚═╝╚═╝  ╚══╝ ╚═════╝ ╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (GetMapName()=="sp_a2_pit_flings") {
        if (MSInstantRun==true) {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
            // Destroy objects
            Entities.FindByName(null, "door_0-close_door_rl").Destroy()
            Entities.FindByName(null, "walltunnel_1_Cover_clip").Destroy()
            Entities.FindByName(null, "exit_door_lock_counter").Destroy()
        }

        if (MSPostPlayerSpawn==true) {
            NewApertureStartElevatorFixes()
        }

        if (MSLoop==true) {
            // Cube ramp disabler
            local ent = null
            while (ent = Entities.FindByClassnameWithin(ent, "prop_weighted_cube", Vector(-448, -416, -104), 32)) {
                try {
                    Entities.FindByName(null, "ramp_90deg_02-ramp_close").Destroy()
                    Entities.FindByName(null, "ramp_90deg_04-ramp_close").Destroy()
                } catch(exception) { }
            }

            // Elevator changelevel
            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(-893, 1223, -362), 50)) {
                SendToConsole("commentary 1")
                SendToConsole("changelevel sp_a2_fizzler_intro")
            }


        }
    }
}