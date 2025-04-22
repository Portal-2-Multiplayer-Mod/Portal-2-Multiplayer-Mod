//  ██████╗  ██████╗             ██████╗████████╗ █████╗  ██████╗ ███████╗           ██╗      █████╗  ██████╗███████╗██████╗ ██████╗ ███████╗██╗      █████╗ ██╗   ██╗
// ██╔════╝ ██╔════╝            ██╔════╝╚══██╔══╝██╔══██╗██╔════╝ ██╔════╝           ██║     ██╔══██╗██╔════╝██╔════╝██╔══██╗██╔══██╗██╔════╝██║     ██╔══██╗╚██╗ ██╔╝
// ██║  ██╗ ██║  ██╗            ╚█████╗    ██║   ███████║██║  ██╗ █████╗             ██║     ███████║╚█████╗ █████╗  ██████╔╝██████╔╝█████╗  ██║     ███████║ ╚████╔╝ 
// ██║  ╚██╗██║  ╚██╗            ╚═══██╗   ██║   ██╔══██║██║  ╚██╗██╔══╝             ██║     ██╔══██║ ╚═══██╗██╔══╝  ██╔══██╗██╔══██╗██╔══╝  ██║     ██╔══██║  ╚██╔╝  
// ╚██████╔╝╚██████╔╝██████████╗██████╔╝   ██║   ██║  ██║╚██████╔╝███████╗██████████╗███████╗██║  ██║██████╔╝███████╗██║  ██║██║  ██║███████╗███████╗██║  ██║   ██║   
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═════╝    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═════════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByName(null, "door_entry").__KeyValueFromString("targetname", "door_entry_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-1664, 768, 290), 32), "AddOutput", "OnTrigger door_entry_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-976, 768, 352), 32), "AddOutput", "OnStartTouch door_entry_area:open::1.51", 0, null, null)
        Entities.FindByName(null, "door_Exit").__KeyValueFromString("targetname", "door_Exit_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1152, 2064, 640), 32), "AddOutput", "OnStartTouch door_entry_area:open::1.51", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_laser_catcher", Vector(1157, 1584, 32), 32), "AddOutput", "OnPowered door_Exit_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_laser_catcher", Vector(1157, 1584, 32), 32), "AddOutput", "OnUnpowered door_Exit_p2mmoverride:Close", 0, null, null)

        // Make fizzlers work
        EntFireByHandle(Entities.FindByNameNearest("@fizzler_gun_1_on", Vector(-1048, 768, 352), 32), "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false true):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByNameNearest("@fizzler_gun_1_on", Vector(-1048, 768, 352), 32), "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false true):0:-1", 0, null, null)

        EntFireByHandle(Entities.FindByNameNearest("@fizzler_gun_1_on", Vector(1212, -128, 576), 32), "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator true true):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByNameNearest("@fizzler_gun_1_on", Vector(1212, -128, 576), 32), "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator true true):0:-1", 0, null, null)

        EntFireByHandle(Entities.FindByNameNearest("@fizzler_gun_1_on", Vector(-4, -128, 576), 32), "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator true false):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByNameNearest("@fizzler_gun_1_on", Vector(-4, -128, 576), 32), "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator true false):0:-1", 0, null, null)
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")

        EntFire("@fizzler_gun_1_off", "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")

        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(1152, 2032, 640), 32), "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(1152, 2032, 640), 32), "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_stage_beamscotty:1.5")
    }
}
