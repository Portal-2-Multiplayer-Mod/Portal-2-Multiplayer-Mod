//  ██████╗  ██████╗             ██████╗████████╗ █████╗  ██████╗ ███████╗           ██████╗ ███████╗ █████╗ ███╗   ███╗ ██████╗ █████╗  █████╗ ████████╗████████╗██╗   ██╗
// ██╔════╝ ██╔════╝            ██╔════╝╚══██╔══╝██╔══██╗██╔════╝ ██╔════╝           ██╔══██╗██╔════╝██╔══██╗████╗ ████║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝╚══██╔══╝╚██╗ ██╔╝
// ██║  ██╗ ██║  ██╗            ╚█████╗    ██║   ███████║██║  ██╗ █████╗             ██████╦╝█████╗  ███████║██╔████╔██║╚█████╗ ██║  ╚═╝██║  ██║   ██║      ██║    ╚████╔╝ 
// ██║  ╚██╗██║  ╚██╗            ╚═══██╗   ██║   ██╔══██║██║  ╚██╗██╔══╝             ██╔══██╗██╔══╝  ██╔══██║██║╚██╔╝██║ ╚═══██╗██║  ██╗██║  ██║   ██║      ██║     ╚██╔╝  
// ╚██████╔╝╚██████╔╝██████████╗██████╔╝   ██║   ██║  ██║╚██████╔╝███████╗██████████╗██████╦╝███████╗██║  ██║██║ ╚═╝ ██║██████╔╝╚█████╔╝╚█████╔╝   ██║      ██║      ██║   
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═════╝    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═════════╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝  ╚════╝  ╚════╝    ╚═╝      ╚═╝      ╚═╝   

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {

        // Stop pathways from closing
        Entities.FindByName(null, "door_entrance").__KeyValueFromString("targetname", "door_entrance_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-448, 640, 64), 32), "AddOutput", "OnTrigger door_entrance_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(176, 640, 64), 32), "AddOutput", "OnStartTouch door_entrance_area:open::1.01", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(384, 2256, 64), 32), "AddOutput", "OnStartTouch exit_door_Area:open::1.51", 0, null, null)
        Entities.FindByName(null, "door_exit").__KeyValueFromString("targetname", "door_exit_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("prop_laser_catcher", Vector(117, 1952, 32), 32), "AddOutput", "OnPowered door_exit_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_laser_catcher", Vector(117, 1952, 32), 32), "AddOutput", "OnUnpowered door_exit_p2mmoverride:Close", 0, null, null)
        EntFire("poison", "AddOutput", "targetname poison_p2mmoverride")
        EntFire("poison_p2mmoverride", "Start", "", 2)

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")

        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(384, 2256, 64), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_stage_bridgebounce:1.5")
    }
}
