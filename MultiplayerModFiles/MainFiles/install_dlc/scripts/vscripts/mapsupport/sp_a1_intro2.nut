// ██████╗██████╗             █████╗   ███╗             ██╗███╗  ██╗████████╗██████╗  █████╗ ██████╗
//██╔════╝██╔══██╗           ██╔══██╗ ████║             ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗╚════██╗
//╚█████╗ ██████╔╝           ███████║██╔██║             ██║██╔██╗██║   ██║   ██████╔╝██║  ██║  ███╔═╝
// ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║██║╚████║   ██║   ██╔══██╗██║  ██║██╔══╝
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝███████╗
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun == true) {
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        Entities.FindByName(null, "@entry_door-door_close_relay").Destroy()
        Entities.FindByName(null, "@exit_door-door_close_relay").Destroy()
        Entities.FindByName(null, "Fizzle_Trigger").Destroy()
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        local portalgun = null
        while (portalgun = Entities.FindByClassname(portalgun, "weapon_portalgun")) {
            portalgun.Destroy()
        }

        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-320, 1248, -656), 50)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a1_intro3")
        }

        try {
            Entities.FindByName(null, "block_boxes").Destroy()
        } catch(exception) {}
    }
}