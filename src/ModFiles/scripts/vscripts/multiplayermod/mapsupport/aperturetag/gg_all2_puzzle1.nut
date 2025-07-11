//  ██████╗  ██████╗             █████╗ ██╗     ██╗     ██████╗            ██████╗ ██╗   ██╗███████╗███████╗██╗     ███████╗  ███╗  
// ██╔════╝ ██╔════╝            ██╔══██╗██║     ██║     ╚════██╗           ██╔══██╗██║   ██║╚════██║╚════██║██║     ██╔════╝ ████║  
// ██║  ██╗ ██║  ██╗            ███████║██║     ██║       ███╔═╝           ██████╔╝██║   ██║  ███╔═╝  ███╔═╝██║     █████╗  ██╔██║  
// ██║  ╚██╗██║  ╚██╗           ██╔══██║██║     ██║     ██╔══╝             ██╔═══╝ ██║   ██║██╔══╝  ██╔══╝  ██║     ██╔══╝  ╚═╝██║  
// ╚██████╔╝╚██████╔╝██████████╗██║  ██║███████╗███████╗███████╗██████████╗██║     ╚██████╔╝███████╗███████╗███████╗███████╗███████╗
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═════════╝╚═╝      ╚═════╝ ╚══════╝╚══════╝╚══════╝╚══════╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByName(null, "door_exit").__KeyValueFromString("targetname", "door_exit_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("prop_laser_catcher", Vector(917, -32, 32), 32), "AddOutput", "OnPowered door_exit_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_laser_catcher", Vector(917, -32, 32), 32), "AddOutput", "OnUnpowered door_exit_p2mmoverride:Close", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(384, -1072, 64), 32), "AddOutput", "OnTrigger door_exit_area:Open::1.01", 0, null, null)
        Entities.FindByName(null, "door_1").__KeyValueFromString("targetname", "door_1_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-592, 512, 64), 32), "AddOutput", "OnTrigger door_1_area:Open::1.01", 0, null, null)
        EntFire("ground_enable_use", "AddOutput", "OnStartTouch door_1_p2mmoverride:Open")

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(384, -992, 64.01), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_all2_escape:1.5")
    }
}
