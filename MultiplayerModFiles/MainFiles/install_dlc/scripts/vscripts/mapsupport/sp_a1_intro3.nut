// ██████╗██████╗             █████╗   ███╗             ██╗███╗  ██╗████████╗██████╗  █████╗ ██████╗ 
//██╔════╝██╔══██╗           ██╔══██╗ ████║             ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗╚════██╗
//╚█████╗ ██████╔╝           ███████║██╔██║             ██║██╔██╗██║   ██║   ██████╔╝██║  ██║ █████╔╝
// ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║██║╚████║   ██║   ██╔══██╗██║  ██║ ╚═══██╗
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ ╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun == true) {
        Entities.FindByName(null, "door_0-door_close_relay").Destroy()
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        Entities.FindByName(null, "player_clips").Destroy()
        // Destroy pusher x4
        Entities.FindByName(null, "podium_collapse_push_brush").Destroy()
        Entities.FindByName(null, "podium_collapse_push_brush").Destroy()
        Entities.FindByName(null, "podium_collapse_push_brush").Destroy()
        Entities.FindByName(null, "podium_collapse_push_brush").Destroy()
        Entities.FindByName(null, "door_3-door_close_relay").Destroy()
        Entities.FindByName(null, "portal_orange_2").Destroy()
        Entities.FindByName(null, "emitter_orange_2").Destroy()
        Entities.FindByName(null, "backtrack_brush").Destroy()
        Entities.FindByName(null, "portal_orange_mtg").Destroy()
        Entities.FindByName(null, "emitter_orange_mtg").Destroy()
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-1344, 4304, -784), 50)) {
        SendToConsole("commentary 1")
        SendToConsole("changelevel sp_a1_intro4")
        }

        try {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
        } catch(exception) {}

        // Remove Portal Gun
        if (hasgotportalgunSPMP == 0) {
            local portalgun = null
            while (portalgun = Entities.FindByClassname(portalgun, "weapon_portalgun")) {
                portalgun.Destroy()
            }
        }

        // Make Wheatley look at nearest player
        local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "spherebot_1_bottom_swivel_1").GetOrigin(), 10000)
        EntFireByHandle(Entities.FindByName(null, "spherebot_1_bottom_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)

        try {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
        } catch(exception) {}
    }
}