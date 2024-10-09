//  ██████╗██████╗             █████╗ ██████╗             ██████╗  █████╗ ██████╗ ██████╗ ███████╗███╗  ██╗           ██████╗ ███████╗
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝████╗ ██║           ██╔══██╗██╔════╝
// ╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██║  ██╗ ███████║██████╔╝██║  ██║█████╗  ██╔██╗██║           ██║  ██║█████╗
//  ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██║  ╚██╗██╔══██║██╔══██╗██║  ██║██╔══╝  ██║╚████║           ██║  ██║██╔══╝
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗╚██████╔╝██║  ██║██║  ██║██████╔╝███████╗██║ ╚███║██████████╗██████╔╝███████╗
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚══╝╚═════════╝╚═════╝ ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Offset coop repsawn nodes for elevators (left and right side)
        GlobalSpawnClass.m_bUseAutoSpawn <- false

        // Remove Portal Gun
        UTIL_Team.Spawn_PortalGun(false)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)

        // delete box spawn
        Entities.FindByClassnameNearest("info_player_start", Vector(1648, 2552, 1828), 999).Destroy()
        // prevent doors from closing        

        // Melgun Cutscene
        melgunC <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
        melgunC.__KeyValueFromString("target_team", "-1")
        melgunC.__KeyValueFromString("targetname", "melgunC")
        melgunC.SetOrigin(Vector(2881, 1667, 101))
        EntFire("melgunC", "SetParentAttachment", "camera_attach", 0, null)
        melgunC.SetAngles(0, 210, 0)
        EntFire("relay_melgun", "AddOutput", "OnTrigger melgunC:Enable")
        EntFire("relay_melgun", "AddOutput", "OnTrigger melgunC:TeleportToView::13.3")
        EntFire("relay_melgun", "AddOutput", "OnTrigger melgunC:Disable::13.33")
        EntFire("relay_melgun", "AddOutput", "OnTrigger melgunC:ReturnToEyes::13.33")
        EntFire("relay_melgun", "AddOutput", "OnTrigger !self:RunScriptCode:equipPortalGun()::13.33")

        Entities.FindByName(null, "sleep_lab_real_door").__KeyValueFromString("targetname", "sleep_lab_real_dooroverride")
        Entities.FindByClassnameNearest("trigger_once", Vector(-2952, 5088, 144), 32).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-3520.16, 5104, 120), 32).Destroy()
        EntFire("AutoInstance1-office_door_button1", "AddOutput", "OnPressed sphere_ptex:TurnOn")
        // Make changing levels work
        // EntFire("logic_playmovie", "AddOutput", "OnPlaybackFinished p2mm_servercommand:Command:changelevel sp_a2_garden_de:0", 0, null)

        while (Entities.FindByName(null, "block_boxes")) {
            Entities.FindByName(null, "block_boxes").Destroy()
        }
    }
    
    if (MSPostPlayerSpawn) {
    }
}

function equipPortalGun() {
    UTIL_Team.Spawn_PortalGun(true)

    // Force all players to receive portal gun
    GamePlayerEquip <- Entities.CreateByClassname("game_player_equip")
    GamePlayerEquip.__KeyValueFromString("weapon_portalgun", "1")
    for (local p = null; p = Entities.FindByClassname(p, "player");) {
        EntFireByHandle(GamePlayerEquip, "use", "", 0, p, p)
    }
    GamePlayerEquip.Destroy()

    // Enable secondary fire for all guns
    EntFire("weapon_portalgun", "AddOutput", "CanFirePortal2 1", 0, null)
}
