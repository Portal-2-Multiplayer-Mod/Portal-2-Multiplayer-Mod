// ██████╗██████╗             █████╗   ███╗             ██╗███╗  ██╗████████╗██████╗  █████╗  █████╗ 
//██╔════╝██╔══██╗           ██╔══██╗ ████║             ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗██╔═══╝ 
//╚█████╗ ██████╔╝           ███████║██╔██║             ██║██╔██╗██║   ██║   ██████╔╝██║  ██║██████╗ 
// ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║██║╚████║   ██║   ██╔══██╗██║  ██║██╔══██╗
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝  ╚════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        GlobalSpawnClass.useautospawn <- true
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        Entities.FindByName(null, "room_1_entry_door-close_door_rl").Destroy()
        Entities.FindByName(null, "room_1_fling_portal_activate_rl").Destroy()
        Entities.FindByName(null, "fling_safety_catapult").Destroy()
        Entities.FindByName(null, "room_1_fling_portal_emitter").Destroy()
        Entities.FindByName(null, "room_2_fling_portal_activate_rl").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(648, 0, 176), 1024).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(1200, -136, 188), 1024).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(2504, -160, 448), 1024).Destroy()
        local fallenautoportal = CreateProp("prop_dynamic", Vector(-325, 24, 0), "models/props/portal_emitter.mdl", 0)
        fallenautoportal.SetAngles(-90, 69, 0)
    }

    if (MSPostPlayerSpawn) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop) {
        try {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
        } catch(exception) {}
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(3015, -174, -125), 60)) {
            SendToConsoleP2MM("changelevel sp_a1_intro7")
        }
    }
}