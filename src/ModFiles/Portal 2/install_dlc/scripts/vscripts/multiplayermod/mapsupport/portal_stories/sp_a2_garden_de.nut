//  ██████╗██████╗             █████╗ ██████╗             ██████╗  █████╗ ██████╗ ██████╗ ███████╗███╗  ██╗           ██████╗ ███████╗
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝████╗ ██║           ██╔══██╗██╔════╝
// ╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██║  ██╗ ███████║██████╔╝██║  ██║█████╗  ██╔██╗██║           ██║  ██║█████╗
//  ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██║  ╚██╗██╔══██║██╔══██╗██║  ██║██╔══╝  ██║╚████║           ██║  ██║██╔══╝
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗╚██████╔╝██║  ██║██║  ██║██████╔╝███████╗██║ ╚███║██████████╗██████╔╝███████╗
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚══╝╚═════════╝╚═════╝ ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Remove Portal Gun
        UTIL_Team.Spawn_PortalGun(false)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)

        // delete box spawn
        Entities.FindByClassnameNearest("info_player_start", Vector(1648, 2552, 1828), 999).Destroy()
        
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
        Entities.FindByName(null, "end_command").Destroy()

        // prevent doors from closing        
        Entities.FindByName(null, "sleep_lab_real_door").__KeyValueFromString("targetname", "sleep_lab_real_dooroverride")
        Entities.FindByClassnameNearest("trigger_once", Vector(-2952, 5088, 144), 32).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-3520.16, 5104, 120), 32).Destroy()
        EntFire("AutoInstance1-office_door_button1", "AddOutput", "OnPressed sphere_ptex:TurnOn")
        Entities.FindByName(null, "ap_sleepy_room").__KeyValueFromString("targetname", "ap_sleepy_room_p2mmoverride")
        Entities.FindByName(null, "cs_virgil_1").__KeyValueFromString("targetname", "cs_virgil_1_p2mmoverride")

        // Make changing levels work
        if (GetMapName().find("sp_") != null) {
            EntFire("EndLevel_Trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel sp_a2_underbounce:2", 0, null)
        } else EntFire("EndLevel_Trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel st_a2_underbounce:2", 0, null)
    }
    
    if (MSPostPlayerSpawn) {
        EntFire("cs_virgil_1_p2mmoverride", "Start")
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
