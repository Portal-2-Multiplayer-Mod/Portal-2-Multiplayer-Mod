//  ██████╗  ██████╗             █████╗ ██╗     ██╗                ██╗███╗  ██╗████████╗██████╗  █████╗ 
// ██╔════╝ ██╔════╝            ██╔══██╗██║     ██║                ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
// ██║  ██╗ ██║  ██╗            ███████║██║     ██║                ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
// ██║  ╚██╗██║  ╚██╗           ██╔══██║██║     ██║                ██║██║╚████║   ██║   ██╔══██╗██║  ██║
// ╚██████╔╝╚██████╔╝██████████╗██║  ██║███████╗███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝

//! note: first areaportal just gets deleted for some reason in p2mm. no clue why :'D

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByName(null, "door_1").__KeyValueFromString("targetname", "door_1_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-224, 1216, 352), 32), "AddOutput", "OnTrigger door_1_Area:open::1.02", 0, null, null)

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(-208, -192, 529.01), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_all_rotating_wall:1.5")
    }

    if (MSPostPlayerSpawn) {
        EntFire("door_1_p2mmoverride", "Open", "")
    }
}
