//  ██████╗██████╗             █████╗ ██████╗                 ██╗██╗   ██╗███╗  ██╗██╗  ██╗██╗   ██╗ █████╗ ██████╗ ██████╗ 
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗                ██║██║   ██║████╗ ██║██║ ██╔╝╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗
// ╚█████╗ ██████╔╝           ███████║ █████╔╝                ██║██║   ██║██╔██╗██║█████═╝  ╚████╔╝ ███████║██████╔╝██║  ██║
//  ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██╗  ██║██║   ██║██║╚████║██╔═██╗   ╚██╔╝  ██╔══██║██╔══██╗██║  ██║
// ██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗╚█████╔╝╚██████╔╝██║ ╚███║██║ ╚██╗   ██║   ██║  ██║██║  ██║██████╔╝
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝ ╚════╝  ╚═════╝ ╚═╝  ╚══╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        UTIL_Team.Spawn_PortalGun(true)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)

        // Prevent doors from closing
        Entities.FindByName(null, "Junkyard_Entrance_Door").__KeyValueFromString("targetname", "Junkyard_Entrance_Door_p2mmoverride")
        Entities.FindByClassnameNearest("func_button", Vector(1380, -3624, -263.5), 32).__KeyValueFromString("targetname", "func_button_p2mmoverride1")
        Entities.FindByName(null, "junkyard_entrance_prop").__KeyValueFromString("targetname", "junkyard_entrance_prop_p2mmoverride")
        Entities.FindByName(null, "junkyard_entrance_ap").__KeyValueFromString("targetname", "junkyard_entrance_ap_p2mmoverride")
        Entities.FindByClassnameNearest("trigger_once", Vector(432, -352, 112), 32).__KeyValueFromString("targetname", "triggeronce_p2mmoverride")
        Entities.FindByClassnameNearest("trigger_once", Vector(-264, 544, 80), 32).Destroy()

        EntFire("triggeronce_p2mmoverride", "AddOutput", "OnStartTouch junkyard_entrance_ap_p2mmoverride:Open")
        EntFire("triggeronce_p2mmoverride", "AddOutput", "OnStartTouch junkyard_entrance_prop_p2mmoverride:SetAnimation:vert_door_opening")
        EntFire("func_button_p2mmoverride1", "AddOutput", "OnPressed Junkyard_Entrance_Door_p2mmoverride:SetAnimation:open")

        // Make changing levels work
        Entities.FindByName(null, "end_command").Destroy()
        if (GetMapName().find("sp_") != null) {
            EntFire("lift_track_3", "AddOutput", "OnPass p2mm_servercommand:Command:changelevel sp_a3_concepts:1", 0, null)
        } else EntFire("lift_track_3", "AddOutput", "OnPass p2mm_servercommand:Command:changelevel st_a3_concepts:1", 0, null)

    }
    
    if (MSPostPlayerSpawn) {

        
    }
}
