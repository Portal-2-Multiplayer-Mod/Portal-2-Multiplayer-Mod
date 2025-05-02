//  ██████╗██████╗             █████╗   ███╗             ██████╗ ██╗██╗   ██╗██╗███╗  ██╗██╗████████╗██╗   ██╗           ██████╗ ████████╗ ██████╗  ███╗  
// ██╔════╝██╔══██╗           ██╔══██╗ ████║             ██╔══██╗██║██║   ██║██║████╗ ██║██║╚══██╔══╝╚██╗ ██╔╝           ██╔══██╗╚══██╔══╝██╔════╝ ████║      
// ╚█████╗ ██████╔╝           ███████║██╔██║             ██║  ██║██║╚██╗ ██╔╝██║██╔██╗██║██║   ██║    ╚████╔╝            ██████╦╝   ██║   ╚█████╗ ██╔██║      
//  ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║  ██║██║ ╚████╔╝ ██║██║╚████║██║   ██║     ╚██╔╝             ██╔══██╗   ██║    ╚═══██╗╚═╝██║      
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██████╔╝██║  ╚██╔╝  ██║██║ ╚███║██║   ██║      ██║   ██████████╗██████╦╝   ██║   ██████╔╝███████╗      
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═════╝ ╚═╝   ╚═╝   ╚═╝╚═╝  ╚══╝╚═╝   ╚═╝      ╚═╝   ╚═════════╝╚═════╝    ╚═╝   ╚═════╝ ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        UTIL_Team.Spawn_PortalGun(false)
        
        // Stop pathways from closing
        Entities.FindByClassnameNearest("info_player_start", Vector(2176, -409, 195), 128).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(1264, -320, 192), 128).Destroy()
        EntFireByHandle(Entities.FindByClassname(null, "weapon_portalgun"), "AddOutput", "OnPlayerPickup !activator:RunScriptCode:pickupGun():1", 0, null, null)
        Entities.FindByClassname(null, "trigger_teleport").Destroy()
        Entities.FindByName(null, "InstanceAuto3-clip_wall").Destroy()


        // Make transitions work
        EntFire("InstanceAuto3-tram_2", "AddOutput", "OnPass Arrival_Departure_Trans-exit_fade:Fade")
        EntFire("InstanceAuto3-tram_2", "AddOutput", "OnPass p2mm_servercommand:Command:changelevel sp_a1_divinity_field_intro:1")
    }
}


function weaponEquip() {
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

function pickupGun() {
    // Weird bug that respawns the gun when its picked up, no clue why
    for (local gun = null; gun = Entities.FindByClassname(gun, "weapon_portalgun");) {
        gun.Destroy()
    }
    EntFire("p2mm_servercommand", "RunScriptCode", "weaponEquip()", 0.01)
}
