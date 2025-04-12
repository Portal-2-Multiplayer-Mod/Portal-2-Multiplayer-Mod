//  ██████╗  ██████╗             ██████╗████████╗ █████╗  ██████╗ ███████╗           ██████╗ ███████╗██████╗ ███████╗██╗██████╗  ██████╗████████╗
// ██╔════╝ ██╔════╝            ██╔════╝╚══██╔══╝██╔══██╗██╔════╝ ██╔════╝           ██╔══██╗██╔════╝██╔══██╗██╔════╝██║██╔══██╗██╔════╝╚══██╔══╝
// ██║  ██╗ ██║  ██╗            ╚█████╗    ██║   ███████║██║  ██╗ █████╗             ██████╔╝█████╗  ██║  ██║█████╗  ██║██████╔╝╚█████╗    ██║   
// ██║  ╚██╗██║  ╚██╗            ╚═══██╗   ██║   ██╔══██║██║  ╚██╗██╔══╝             ██╔══██╗██╔══╝  ██║  ██║██╔══╝  ██║██╔══██╗ ╚═══██╗   ██║   
// ╚██████╔╝╚██████╔╝██████████╗██████╔╝   ██║   ██║  ██║╚██████╔╝███████╗██████████╗██║  ██║███████╗██████╔╝██║     ██║██║  ██║██████╔╝   ██║   
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═════╝    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═════════╝╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═════╝    ╚═╝   

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByName(null, "door_entrance").__KeyValueFromString("targetname", "door_entrance_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-1280, 355.55, 2), 32), "AddOutput", "OnTrigger door_entrance_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-980, 384, 64), 32), "AddOutput", "OnStartTouch door_entry_area:open::1.51", 0, null, null)
        Entities.FindByClassnameNearest("trigger_once", Vector(704, -1024, 444), 32).Destroy()

        // Make fizzlers work
        EntFire("@fizzler_C_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator true false):0:-1")
        EntFire("@fizzler_C_gun_1_on", "AddOutput", "targetname @fizzler_C_gun_1_on_p2mmoverride")
        EntFire("@fizzler_C_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_C_gun_1_off", "AddOutput", "targetname @fizzler_C_gun_1_off_p2mmoverride")
        EntFire("@orange_fizzler_off", "AddOutput", "OnTrigger @fizzler_C_gun_1_on_p2mmoverride:Disable")
        EntFire("@orange_fizzler_off", "AddOutput", "OnTrigger @fizzler_C_gun_1_off_p2mmoverride:Disable")
        EntFire("@orange_fizzler_on", "AddOutput", "OnTrigger @fizzler_C_gun_1_on_p2mmoverride:Enable")
        EntFire("@orange_fizzler_on", "AddOutput", "OnTrigger @fizzler_C_gun_1_off_p2mmoverride:Enable")

        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")

        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(1216, 864, 448), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(784, -1024, 448), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(784, -1024, 448), 32), "AddOutput", "OnTrigger @suck_tube_effects:Trigger:::1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_stage_laserrelay:1.5")
    }
}
