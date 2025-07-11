//  ██████╗  ██████╗             █████╗ ██╗     ██╗                ██╗███╗  ██╗████████╗██████╗  █████╗ 
// ██╔════╝ ██╔════╝            ██╔══██╗██║     ██║                ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
// ██║  ██╗ ██║  ██╗            ███████║██║     ██║                ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
// ██║  ╚██╗██║  ╚██╗           ██╔══██║██║     ██║                ██║██║╚████║   ██║   ██╔══██╗██║  ██║
// ╚██████╔╝╚██████╔╝██████████╗██║  ██║███████╗███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByName(null, "door_1").__KeyValueFromString("targetname", "door_1_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-224, 1216, 352), 32), "AddOutput", "OnTrigger door_1_Area:open::1.02", 0, null, null)
        Entities.FindByName(null, "door_2").__KeyValueFromString("targetname", "door_2_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-160, -192, 528), 32), "AddOutput", "OnTrigger door_2_area:open::1.02", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-448, -192, 496), 32), "AddOutput", "OnTrigger door_2_p2mmoverride:open::0.25", 0, null, null)

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")

        EntFire("@fizzler_gun_1_off", "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")

        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(-208, -192, 529.01), 32), "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(-208, -192, 529.01), 32), "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_all_rotating_wall:1.5")
    }

    if (MSPostPlayerSpawn) {
        EntFire("door_1_p2mmoverride", "Open", "")
    }
}
