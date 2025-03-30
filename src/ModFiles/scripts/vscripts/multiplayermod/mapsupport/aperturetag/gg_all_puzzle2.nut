//  ██████╗  ██████╗             █████╗ ██╗     ██╗                ██████╗ ██╗   ██╗███████╗███████╗██╗     ███████╗██████╗ 
// ██╔════╝ ██╔════╝            ██╔══██╗██║     ██║                ██╔══██╗██║   ██║╚════██║╚════██║██║     ██╔════╝╚════██╗
// ██║  ██╗ ██║  ██╗            ███████║██║     ██║                ██████╔╝██║   ██║  ███╔═╝  ███╔═╝██║     █████╗    ███╔═╝
// ██║  ╚██╗██║  ╚██╗           ██╔══██║██║     ██║                ██╔═══╝ ██║   ██║██╔══╝  ██╔══╝  ██║     ██╔══╝  ██╔══╝
// ╚██████╔╝╚██████╔╝██████████╗██║  ██║███████╗███████╗██████████╗██║     ╚██████╔╝███████╗███████╗███████╗███████╗███████╗
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═════════╝╚═╝      ╚═════╝ ╚══════╝╚══════╝╚══════╝╚══════╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByName(null, "door_exit").__KeyValueFromString("targetname", "door_exit_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("prop_floor_button", Vector(128, 1536, 265), 32), "AddOutput", "OnPressed door_exit_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_floor_button", Vector(128, 1536, 265), 32), "AddOutput", "OnUnPressed door_exit_p2mmoverride:Close", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(384.01, 1952, 320), 32), "AddOutput", "OnTrigger door_exit_area:Open::1.01", 0, null, null)
        Entities.FindByName(null, "door_en").__KeyValueFromString("targetname", "door_en_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(384.01, 1952, 320), 32), "AddOutput", "OnTrigger door_en_area:Open::1.01", 0, null, null)
        EntFire("ground_enable_use", "AddOutput", "OnStartTouch door_en_p2mmoverride:Open")

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(384, 1904, 320.01), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_all2_puzzle1:1.5")
    }
}
