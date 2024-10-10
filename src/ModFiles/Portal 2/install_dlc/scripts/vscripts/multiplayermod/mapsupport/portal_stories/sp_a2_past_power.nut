//  ██████╗██████╗             █████╗ ██████╗            ██████╗  █████╗  ██████╗████████╗           ██████╗  █████╗  ██╗       ██╗███████╗██████╗ 
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██╔══██╗██╔════╝╚══██╔══╝           ██╔══██╗██╔══██╗ ██║  ██╗  ██║██╔════╝██╔══██╗
// ╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██████╔╝███████║╚█████╗    ██║              ██████╔╝██║  ██║ ╚██╗████╗██╔╝█████╗  ██████╔╝
//  ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██╔═══╝ ██╔══██║ ╚═══██╗   ██║              ██╔═══╝ ██║  ██║  ████╔═████║ ██╔══╝  ██╔══██╗
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║     ██║  ██║██████╔╝   ██║   ██████████╗██║     ╚█████╔╝  ╚██╔╝ ╚██╔╝ ███████╗██║  ██║
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝     ╚═╝  ╚═╝╚═════╝    ╚═╝   ╚═════════╝╚═╝      ╚════╝    ╚═╝   ╚═╝  ╚══════╝╚═╝  ╚═╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        UTIL_Team.Spawn_PortalGun(true)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)

        // remove autostart elevator
        Entities.FindByClassnameNearest("logic_auto", Vector(1360, 272, -188), 64).Destroy()
        Entities.FindByName(null, "elevator-start_trigger").Destroy()

        // make doors not close
        Entities.FindByName(null, "room_1_door_0-proxy").Destroy()
        Entities.FindByName(null, "orange_pump_station_door_1-close").Destroy()
        Entities.FindByName(null, "orange_pump_station_door_3-close").Destroy()
        Entities.FindByName(null, "sd1_door").__KeyValueFromString("targetname", "sd1_door_p2mmoverride")
        Entities.FindByName(null, "bts_door_2").__KeyValueFromString("targetname", "bts_door_2_p2mmoverride")
        Entities.FindByName(null, "ap4").__KeyValueFromString("targetname", "ap4_p2mmoverride")
        Entities.FindByName(null, "model").__KeyValueFromString("targetname", "model_p2mmoverride")
        EntFire("cs_40", "AddOutput", "OnCompletion sd1_door_p2mmoverride:SetAnimation:open")
        EntFire("bts_door_2_button", "AddOutput", "OnPressed bts_door_2_p2mmoverride:SetAnimation:open")
        EntFire("Blue_gel_exit_button", "AddOutput", "OnPressed ap4_p2mmoverride:open")
        EntFire("door", "AddOutput", "OnPressed model_p2mmoverride:SetAnimation:open")

        // delete box spawn
        Entities.FindByClassnameNearest("info_player_start", Vector(4864, 1008, 2644), 64).Destroy()

        // Make changing levels work
        Entities.FindByName(null, "sphere_transfer").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(4864, 1008, 2644), 64).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-4064 5232 1524.53), 64).Destroy()

    }
    
    if (MSPostPlayerSpawn) {
        EntFire("elevator-entrance_lift_train", "StartForward", null, 1)
        EntFire("room_1_door_0-door_open", "Trigger", null, 6)
        Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(1360, 272, 224))

    }
}
