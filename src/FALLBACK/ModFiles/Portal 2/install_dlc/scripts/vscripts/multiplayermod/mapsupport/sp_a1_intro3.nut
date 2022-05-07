// ██████╗██████╗             █████╗   ███╗             ██╗███╗  ██╗████████╗██████╗  █████╗ ██████╗
//██╔════╝██╔══██╗           ██╔══██╗ ████║             ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗╚════██╗
//╚█████╗ ██████╔╝           ███████║██╔██║             ██║██╔██╗██║   ██║   ██████╔╝██║  ██║ █████╔╝
// ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║██║╚████║   ██║   ██╔══██╗██║  ██║ ╚═══██╗
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ ╚═════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        GlobalSpawnClass.useautospawn <- true
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
        a1HasPortalGun <- false
    }

    if (MSPostPlayerSpawn) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop) {
        if (!a1HasPortalGun) {
            // Remove Portal Gun
            local ent = null
            while (ent = Entities.FindByClassname(ent, "weapon_portalgun")) {
                ent.__KeyValueFromString("CanFirePortal1", "0")
                ent.__KeyValueFromString("CanFirePortal2", "0")
                EntFireByHandle(ent, "disabledraw", "", 0, null, null)
            }
            local ent = null
            while (ent = Entities.FindByClassname(ent, "predicted_viewmodel")) {
                EntFireByHandle(ent, "disabledraw", "", 0, null, null)
            }
        } else {
            // give portalgun
            local ent = null
            while (ent = Entities.FindByClassname(ent, "weapon_portalgun")) {
                ent.__KeyValueFromString("CanFirePortal1", "1")
                ent.__KeyValueFromString("CanFirePortal2", "1")
                EntFireByHandle(ent, "enabledraw", "", 0, null, null)
            }
            local ent = null
            while (ent = Entities.FindByClassname(ent, "predicted_viewmodel")) {
                EntFireByHandle(ent, "enabledraw", "", 0, null, null)
            }
        }

        if (!Entities.FindByName(null, "portalgun")) {
            a1HasPortalGun = true
        }

        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-1344, 4304, -784), 50)) {
        SendToConsole("changelevel sp_a1_intro4")
        }

        try {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
        } catch(exception) {}

        // Make Wheatley look at nearest player
        local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "spherebot_1_bottom_swivel_1").GetOrigin(), 10000)
        EntFireByHandle(Entities.FindByName(null, "spherebot_1_bottom_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)

        try {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
        } catch(exception) {}
    }
}