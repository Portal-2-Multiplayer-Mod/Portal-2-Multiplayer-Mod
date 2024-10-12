//  ██████╗██████╗             █████╗ ██████╗            ███████╗ █████╗ ██╗████████╗██╗  ██╗           ██████╗ ██╗      █████╗ ████████╗███████╗
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔════╝██╔══██╗██║╚══██╔══╝██║  ██║           ██╔══██╗██║     ██╔══██╗╚══██╔══╝██╔════╝
// ╚█████╗ ██████╔╝           ███████║ █████╔╝           █████╗  ███████║██║   ██║   ███████║           ██████╔╝██║     ███████║   ██║   █████╗
//  ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██╔══╝  ██╔══██║██║   ██║   ██╔══██║           ██╔═══╝ ██║     ██╔══██║   ██║   ██╔══╝
// ██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗██║     ██║  ██║██║   ██║   ██║  ██║██████████╗██║     ███████╗██║  ██║   ██║   ███████╗
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝╚═╝     ╚═╝  ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════════╝╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        UTIL_Team.Spawn_PortalGun(true)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)

        // elevator stuff
        EntFire("InstanceAuto53-elevator_1", "MoveToPathNode", "@elevator_1_bottom_path_1", 0.1, null)
        EntFire("InstanceAuto53-light_elevator_fill", "TurnOn")
        EntFire("InstanceAuto53-signs_on", "Trigger")
        EntFire("InstanceAuto53-light_elevator_dynamic", "TurnOn")
        Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(0, 176, 80))
        Entities.FindByClassname(null, "info_player_start").SetAngles(0, 90, 0)

        // make doors/paths not close
        Entities.FindByName(null, "Entry_Door").__KeyValueFromString("targetname", "Entry_Door_p2mm_override")
        Entities.FindByName(null, "Entry_Door_Areaportal").__KeyValueFromString("targetname", "Entry_Door_Areaportal_p2mm_override")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(0, 764.01, 208), 16), "AddOutput", "OnStartTouch Entry_Door_p2mm_override:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(0, 764.01, 208), 16), "AddOutput", "OnStartTouch Entry_Door_Areaportal_p2mm_override:Open", 0, null, null)
        Entities.FindByClassnameNearest("trigger_once", Vector(736, 4296, 192), 32).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(1008, 4576, 208), 32).Destroy()
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1264, 4576, 192), 32), "AddOutput", "OnStartTouch Entry_Door_Areaportal_p2mm_override:Open", 0, null, null)
        Entities.FindByClassnameNearest("trigger_once", Vector(3200.5, 4960, 592), 32).Destroy()

        // Make changing levels work
        EntFire("@transition_from_map", "AddOutput", value, delay, activator)
        Entities.FindByName(null, "InstanceAuto56-command").Destroy()
        if (GetMapName().find("sp_") != null) {
            EntFire("@transition_from_map", "AddOutput", "OnTrigger p2mm_servercommand:Command:changelevel sp_a3_transition:2")
        } else EntFire("@transition_from_map", "AddOutput", "OnTrigger p2mm_servercommand:Command:changelevel st_a3_transition:2")

    }
    
    if (MSPostPlayerSpawn) {

        
    }
}
