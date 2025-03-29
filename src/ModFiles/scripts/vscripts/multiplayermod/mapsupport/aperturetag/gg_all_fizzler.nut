//  ██████╗  ██████╗             █████╗ ██╗     ██╗                ███████╗██╗███████╗███████╗██╗     ███████╗██████╗ 
// ██╔════╝ ██╔════╝            ██╔══██╗██║     ██║                ██╔════╝██║╚════██║╚════██║██║     ██╔════╝██╔══██╗
// ██║  ██╗ ██║  ██╗            ███████║██║     ██║                █████╗  ██║  ███╔═╝  ███╔═╝██║     █████╗  ██████╔╝
// ██║  ╚██╗██║  ╚██╗           ██╔══██║██║     ██║                ██╔══╝  ██║██╔══╝  ██╔══╝  ██║     ██╔══╝  ██╔══██╗
// ╚██████╔╝╚██████╔╝██████████╗██║  ██║███████╗███████╗██████████╗██║     ██║███████╗███████╗███████╗███████╗██║  ██║
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═════════╝╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-352, 448, 348), 32), "AddOutput", "OnStartTouch area_door_1:Open::1.02", 0, null, null)
        EntFire("ground_enable_use", "AddOutput", "OnTrigger door_1:AddOutput:targetname door_1_p2mmoverride:3.02")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(768, -480, 356), 32), "AddOutput", "OnTrigger area_door_Exit:Open::1.02", 0, null, null)
        Entities.FindByName(null, "exit_door").__KeyValueFromString("targetname", "exit_door_p2mmoverride")
        EntFire("prop_floor_button", "AddOutput", "OnPressed exit_door_p2mmoverride:Close")
        EntFire("prop_floor_button", "AddOutput", "OnUnPressed exit_door_p2mmoverride:Open")

        // Make fizzlers work
        EntFireByHandle(Entities.FindByName(null, "@fizzler_A_gun_1_on"), "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false true):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "@fizzler_gun_1_on"), "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator true false):0:-1", 0, null, null)
        EntFire("@fizzler_A_gun_1_on", "AddOutput", "targetname @fizzler_A_gun_1_on_p2mmoverride")
        EntFire("@fizzler_A_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1")
        EntFire("@fizzler_A_gun_1_off", "AddOutput", "targetname @fizzler_A_gun_1_off_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")
        EntFire("@fizzler_gun_1_off_p2mmoverride", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1")
        EntFire("@blue_fizzler_on", "AddOutput", "OnTrigger @fizzler_A_gun_1_on_p2mmoverride:Enable")
        EntFire("@blue_fizzler_on", "AddOutput", "OnTrigger @fizzler_A_gun_1_off_p2mmoverride:Enable")
        EntFire("@blue_fizzler_on", "AddOutput", "OnTrigger @fizzler_A_gun_1_on_p2mmoverride:Enable")
        EntFire("@blue_fizzler_off", "AddOutput", "OnTrigger @fizzler_A_gun_1_on_p2mmoverride:Disable")
        EntFire("@blue_fizzler_off", "AddOutput", "OnTrigger @fizzler_A_gun_1_off_p2mmoverride:Disable")
        EntFire("@blue_fizzler_off", "AddOutput", "OnTrigger @fizzler_A_gun_1_on_p2mmoverride:Disable")
        EntFire("@fizzler_A_gun_1_on_p2mmoverride", "Disable", "")
        EntFire("@fizzler_A_gun_1_off_p2mmoverride", "Disable", "")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(768, -432, 320), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_all_intro_2:1.5")
    }
}
