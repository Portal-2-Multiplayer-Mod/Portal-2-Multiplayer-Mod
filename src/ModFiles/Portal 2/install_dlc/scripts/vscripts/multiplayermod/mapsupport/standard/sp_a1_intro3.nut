//  ██████╗██████╗             █████╗   ███╗             ██╗███╗  ██╗████████╗██████╗  █████╗ ██████╗
// ██╔════╝██╔══██╗           ██╔══██╗ ████║             ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗╚════██╗
// ╚█████╗ ██████╔╝           ███████║██╔██║             ██║██╔██╗██║   ██║   ██████╔╝██║  ██║ █████╔╝
//  ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║██║╚████║   ██║   ██╔══██╗██║  ██║ ╚═══██╗
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝██████╔╝
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ ╚═════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Remove Portal Gun
        RemovePortalGunBlue <- Entities.CreateByClassname("info_target")
        RemovePortalGunBlue.__KeyValueFromString("targetname", "supress_blue_portalgun_spawn")

        RemovePortalGunOrange <- Entities.CreateByClassname("info_target")
        RemovePortalGunOrange.__KeyValueFromString("targetname", "supress_orange_portalgun_spawn")

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
        a1HasDestroyedTargetPortalGun <- false
        a1AlreadyGavePortalGun <- false
    }

    if (MSPostPlayerSpawn) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop) {
        // Someone picked up the portal gun
        if (!Entities.FindByName(null, "portalgun")) {
            if (!a1HasDestroyedTargetPortalGun) {
                // Allow respawn with dual gun
                Entities.FindByName(null, "supress_blue_portalgun_spawn").Destroy()
                Entities.FindByName(null, "supress_orange_portalgun_spawn").Destroy()
                a1HasDestroyedTargetPortalGun <- true
                a1HasPortalGun()
            }
        }

        // Ending "trigger"
        local p = null
        while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1344, 4304, -784), 50)) {
            SendToConsoleP232("changelevel sp_a1_intro4")
        }

        // Make Wheatley look at nearest player
        local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "spherebot_1_bottom_swivel_1").GetOrigin(), 10000)
        EntFireByHandle(Entities.FindByName(null, "spherebot_1_bottom_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)

        try {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
        } catch (exception) {}
    }
}

function a1HasPortalGun() {
    // Give portal gun to those who don't have it already
    if (!a1AlreadyGavePortalGun) {
        // Force all players to receive portal gun
        GamePlayerEquip <- Entities.CreateByClassname("game_player_equip")
        GamePlayerEquip.__KeyValueFromString("weapon_portalgun", "1")
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            EntFireByHandle(GamePlayerEquip, "use", "", 0, p, p)
        }
        GamePlayerEquip.Destroy()

        // Enable secondary fire for all guns
        EntFire("weapon_portalgun", "addoutput", "CanFirePortal2 1", 0, null)
        a1AlreadyGavePortalGun <- true
    }
}