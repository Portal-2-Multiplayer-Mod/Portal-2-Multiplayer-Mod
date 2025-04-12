//  ██████╗  ██████╗             ██████╗████████╗ █████╗  ██████╗ ███████╗           ██████╗ ██╗ █████╗ ██╗  ██╗██████╗  █████╗ ██╗   ██╗███╗  ██╗ █████╗ ███████╗
// ██╔════╝ ██╔════╝            ██╔════╝╚══██╔══╝██╔══██╗██╔════╝ ██╔════╝           ██╔══██╗██║██╔══██╗██║ ██╔╝██╔══██╗██╔══██╗██║   ██║████╗ ██║██╔══██╗██╔════╝
// ██║  ██╗ ██║  ██╗            ╚█████╗    ██║   ███████║██║  ██╗ █████╗             ██████╔╝██║██║  ╚═╝█████═╝ ██████╦╝██║  ██║██║   ██║██╔██╗██║██║  ╚═╝█████╗  
// ██║  ╚██╗██║  ╚██╗            ╚═══██╗   ██║   ██╔══██║██║  ╚██╗██╔══╝             ██╔═══╝ ██║██║  ██╗██╔═██╗ ██╔══██╗██║  ██║██║   ██║██║╚████║██║  ██╗██╔══╝  
// ╚██████╔╝╚██████╔╝██████████╗██████╔╝   ██║   ██║  ██║╚██████╔╝███████╗██████████╗██║     ██║╚█████╔╝██║ ╚██╗██████╦╝╚█████╔╝╚██████╔╝██║ ╚███║╚█████╔╝███████╗
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═════╝    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═════════╝╚═╝     ╚═╝ ╚════╝ ╚═╝  ╚═╝╚═════╝  ╚════╝  ╚═════╝ ╚═╝  ╚══╝ ╚════╝ ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByName(null, "entry_door").__KeyValueFromString("targetname", "entry_door_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-1440, 0, 2), 32), "AddOutput", "OnTrigger entry_door_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-848, -8, 64), 32), "AddOutput", "OnStartTouch area_entry:open::1.01", 0, null, null)

        Entities.FindByName(null, "exit_door").__KeyValueFromString("targetname", "exit_door_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("prop_floor_button", Vector(-704, -96, 8), 32), "AddOutput", "OnPressed exit_door_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_floor_button", Vector(-704, -96, 8), 32), "AddOutput", "OnUnPressed exit_door_p2mmoverride:Close", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-704, -336, 64), 32), "AddOutput", "OnStartTouch area_exit:open::1.01", 0, null, null)
        EntFire("poison", "AddOutput", "targetname poison_p2mmoverride")
        EntFire("poison_p2mmoverride", "Start", "", 2)

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")

        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(352, 0, 640), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(-704, -336, 64), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_stage_theend:1.5")
    }
}
