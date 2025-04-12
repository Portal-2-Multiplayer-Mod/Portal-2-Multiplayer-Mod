//  ██████╗  ██████╗             ██████╗████████╗ █████╗  ██████╗ ███████╗           ██████╗  █████╗  █████╗ ███████╗██████╗  █████╗ ██╗   ██╗███╗  ██╗ █████╗ ███████╗
// ██╔════╝ ██╔════╝            ██╔════╝╚══██╔══╝██╔══██╗██╔════╝ ██╔════╝           ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██║   ██║████╗ ██║██╔══██╗██╔════╝
// ██║  ██╗ ██║  ██╗            ╚█████╗    ██║   ███████║██║  ██╗ █████╗             ██████╔╝██║  ██║██║  ██║█████╗  ██████╦╝██║  ██║██║   ██║██╔██╗██║██║  ╚═╝█████╗  
// ██║  ╚██╗██║  ╚██╗            ╚═══██╗   ██║   ██╔══██║██║  ╚██╗██╔══╝             ██╔══██╗██║  ██║██║  ██║██╔══╝  ██╔══██╗██║  ██║██║   ██║██║╚████║██║  ██╗██╔══╝  
// ╚██████╔╝╚██████╔╝██████████╗██████╔╝   ██║   ██║  ██║╚██████╔╝███████╗██████████╗██║  ██║╚█████╔╝╚█████╔╝██║     ██████╦╝╚█████╔╝╚██████╔╝██║ ╚███║╚█████╔╝███████╗
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═════╝    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═════════╝╚═╝  ╚═╝ ╚════╝  ╚════╝ ╚═╝     ╚═════╝  ╚════╝  ╚═════╝ ╚═╝  ╚══╝ ╚════╝ ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByName(null, "entry_door").__KeyValueFromString("targetname", "entry_door_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-1536, 512, 2), 32), "AddOutput", "OnTrigger entry_door_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-848, 512, 64), 32), "AddOutput", "OnStartTouch area_entry:open::1.01", 0, null, null)
        Entities.FindByClassnameNearest("trigger_once", Vector(-256, -687, 448), 32).Destroy()

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")

        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(-256, -592, 448), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(-256, -592, 448), 32), "AddOutput", "OnTrigger @suck_tube_effects:Trigger:::1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_stage_pickbounce:1.5")
    }
}
