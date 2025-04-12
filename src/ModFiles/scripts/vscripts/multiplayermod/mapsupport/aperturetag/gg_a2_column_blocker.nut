//  ██████╗  ██████╗             █████╗ ██████╗             █████╗  █████╗ ██╗     ██╗   ██╗███╗   ███╗███╗  ██╗           ██████╗ ██╗      █████╗  █████╗ ██╗  ██╗███████╗██████╗ 
// ██╔════╝ ██╔════╝            ██╔══██╗╚════██╗           ██╔══██╗██╔══██╗██║     ██║   ██║████╗ ████║████╗ ██║           ██╔══██╗██║     ██╔══██╗██╔══██╗██║ ██╔╝██╔════╝██╔══██╗
// ██║  ██╗ ██║  ██╗            ███████║  ███╔═╝           ██║  ╚═╝██║  ██║██║     ██║   ██║██╔████╔██║██╔██╗██║           ██████╦╝██║     ██║  ██║██║  ╚═╝█████═╝ █████╗  ██████╔╝
// ██║  ╚██╗██║  ╚██╗           ██╔══██║██╔══╝             ██║  ██╗██║  ██║██║     ██║   ██║██║╚██╔╝██║██║╚████║           ██╔══██╗██║     ██║  ██║██║  ██╗██╔═██╗ ██╔══╝  ██╔══██╗
// ╚██████╔╝╚██████╔╝██████████╗██║  ██║███████╗██████████╗╚█████╔╝╚█████╔╝███████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚███║██████████╗██████╦╝███████╗╚█████╔╝╚█████╔╝██║ ╚██╗███████╗██║  ██║
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝ ╚════╝  ╚════╝ ╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚══╝╚═════════╝╚═════╝ ╚══════╝ ╚════╝  ╚════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByClassnameNearest("trigger_once", Vector(-960, 256, 96), 32).Destroy()

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(-1024, -96, 64.01), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_all_puzzle2:1.5")
    }
}
