// ██████╗██████╗             █████╗ ██████╗            ████████╗██╗   ██╗██████╗ ██████╗ ███████╗████████╗           ██╗███╗  ██╗████████╗██████╗  █████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔════╝╚══██╔══╝           ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║  ███╔═╝              ██║   ██║   ██║██████╔╝██████╔╝█████╗     ██║              ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝                ██║   ██║   ██║██╔══██╗██╔══██╗██╔══╝     ██║              ██║██║╚████║   ██║   ██╔══██╗██║  ██║
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗   ██║   ╚██████╔╝██║  ██║██║  ██║███████╗   ██║   ██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        // Kill the last door close trigger
        Entities.FindByClassnameNearest("trigger_multiple", Vector(-174.19, 392.03, -160), 1024).Destroy()
        // Kill the changelevel trigger
        Entities.FindByName(null, "transition_trigger").Destroy()
        // Set the door logic
        TurretIntroOpenDoor <- false
        TurretIntroDoorOpened <- false
        Entities.FindByName(null, "@exit_door-testchamber_door").__KeyValueFromString("targetname", "MpModDoorOverride")
        Entities.FindByName(null, "@exit_door-door_player_clip").__KeyValueFromString("targetname", "MpModDoorClipOverride")
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        // Find all prop_weighted_cube entities within 24 units of 704, -512 16
        TurretIntroOpenDoor <- false
        local ent = null
        while (ent = Entities.FindByClassnameWithin(ent, "prop_weighted_cube", Vector(704, -512, 8, 24), 28)) {
            TurretIntroOpenDoor <- true
        }

        local ent = null
        while (ent = Entities.FindByClassnameWithin(ent, "player", Vector(704, -512, 8, 24), 24)) {
            TurretIntroOpenDoor <- true
        }

        if (TurretIntroOpenDoor==true) {
            if (TurretIntroDoorOpened==false) {
                // Open the door
                EntFireByHandle(Entities.FindByName(null, "MpModDoorOverride"), "open", "", 0, null, null)
                EntFireByHandle(Entities.FindByName(null, "MpModDoorClipOverride"), "disable", "", 0, null, null)
                TurretIntroDoorOpened <- true
            }
        } else {
            if (TurretIntroDoorOpened==true) {
                EntFireByHandle(Entities.FindByName(null, "MpModDoorOverride"), "close", "", 0, null, null)
                EntFireByHandle(Entities.FindByName(null, "MpModDoorClipOverride"), "enable", "", 0, null, null)
                TurretIntroDoorOpened <- false
            }
        }

        // Make our own changelevel trigger
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-452, 196, -292), 200)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a2_laser_relays")
        }
    }
}