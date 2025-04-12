//  ██████╗  ██████╗             █████╗ ██╗     ██╗                ██╗███╗  ██╗████████╗██████╗  █████╗            ██████╗ 
// ██╔════╝ ██╔════╝            ██╔══██╗██║     ██║                ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗           ╚════██╗
// ██║  ██╗ ██║  ██╗            ███████║██║     ██║                ██║██╔██╗██║   ██║   ██████╔╝██║  ██║             ███╔═╝
// ██║  ╚██╗██║  ╚██╗           ██╔══██║██║     ██║                ██║██║╚████║   ██║   ██╔══██╗██║  ██║           ██╔══╝
// ╚██████╔╝╚██████╔╝██████████╗██║  ██║███████╗███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝██████████╗███████╗
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ ╚═════════╝╚══════╝

//! note: first areaportal just gets deleted for some reason in p2mm. no clue why :'D

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByName(null, "door_1").__KeyValueFromString("targetname", "door_1_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-272, 768, 640), 32), "AddOutput", "OnTrigger door_1_area:open::1.02", 0, null, null)
        EntFire("ground_enable_use", "AddOutput", "OnTrigger door_1_p2mmoverride:Open::6.5")

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(896, 16, 896.01), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_a2_column_blocker:1.5")
    }
}
