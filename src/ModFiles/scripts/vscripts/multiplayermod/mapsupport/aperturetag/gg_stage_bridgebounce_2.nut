//  ██████╗  ██████╗             ██████╗████████╗ █████╗  ██████╗ ███████╗           ██████╗ ██████╗ ██╗██████╗  ██████╗ ███████╗██████╗  █████╗ ██╗   ██╗███╗  ██╗ █████╗ ███████╗           ██████╗ 
// ██╔════╝ ██╔════╝            ██╔════╝╚══██╔══╝██╔══██╗██╔════╝ ██╔════╝           ██╔══██╗██╔══██╗██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗██╔══██╗██║   ██║████╗ ██║██╔══██╗██╔════╝           ╚════██╗
// ██║  ██╗ ██║  ██╗            ╚█████╗    ██║   ███████║██║  ██╗ █████╗             ██████╦╝██████╔╝██║██║  ██║██║  ██╗ █████╗  ██████╦╝██║  ██║██║   ██║██╔██╗██║██║  ╚═╝█████╗               ███╔═╝
// ██║  ╚██╗██║  ╚██╗            ╚═══██╗   ██║   ██╔══██║██║  ╚██╗██╔══╝             ██╔══██╗██╔══██╗██║██║  ██║██║  ╚██╗██╔══╝  ██╔══██╗██║  ██║██║   ██║██║╚████║██║  ██╗██╔══╝             ██╔══╝  
// ╚██████╔╝╚██████╔╝██████████╗██████╔╝   ██║   ██║  ██║╚██████╔╝███████╗██████████╗██████╦╝██║  ██║██║██████╔╝╚██████╔╝███████╗██████╦╝╚█████╔╝╚██████╔╝██║ ╚███║╚█████╔╝███████╗██████████╗███████╗
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═════╝    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═════════╝╚═════╝ ╚═╝  ╚═╝╚═╝╚═════╝  ╚═════╝ ╚══════╝╚═════╝  ╚════╝  ╚═════╝ ╚═╝  ╚══╝ ╚════╝ ╚══════╝╚═════════╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByName(null, "entry_door").__KeyValueFromString("targetname", "entry_door_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-64, 360, 64.5), 32), "AddOutput", "OnTrigger entry_area:open::1.51", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-64, 1024, 2), 32), "AddOutput", "OnStartTouch entry_door_p2mmoverride:Open", 0, null, null)
        Entities.FindByName(null, "exit_door").__KeyValueFromString("targetname", "exit_door_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(64, -1624, 64.5), 32), "AddOutput", "OnTrigger exit_area:open::1.51", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_laser_catcher", Vector(-123, -1424, 32), 32), "AddOutput", "OnPowered exit_door_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_laser_catcher", Vector(-123, -1424, 32), 32), "AddOutput", "OnUnpowered exit_door_p2mmoverride:Close", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_button", Vector(-192, -32, 911), 32), "AddOutput", "OnPressed @All_fizzler_on:Trigger::2", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_button", Vector(-192, -32, 911), 32), "AddOutput", "OnPressed switch_fizzler_1:Unlock::0.01", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_button", Vector(-192, -32, 911), 32), "AddOutput", "OnPressed switch_1_text_ent:SetTextureIndex:0:2", 0, null, null)
        EntFire("switch_fizzler_1", "AddOutput", "OnPressed switch_fizzler_1:Unlock::1")

        // Make fizzlers work
        EntFire("@fizzler_A_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false true):0:-1")
        EntFire("@fizzler_A_gun_1_on", "AddOutput", "targetname @fizzler_A_gun_1_on_p2mmoverride")
        EntFire("@fizzler_A_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1")
        EntFire("@fizzler_A_gun_1_off", "AddOutput", "targetname @fizzler_A_gun_1_off_p2mmoverride")
        EntFire("@blue_fizzler_off", "AddOutput", "OnTrigger @fizzler_A_gun_1_on_p2mmoverride:Disable")
        EntFire("@blue_fizzler_off", "AddOutput", "OnTrigger @fizzler_A_gun_1_off_p2mmoverride:Disable")
        EntFire("@blue_fizzler_on", "AddOutput", "OnTrigger @fizzler_A_gun_1_on_p2mmoverride:Enable")
        EntFire("@blue_fizzler_on", "AddOutput", "OnTrigger @fizzler_A_gun_1_off_p2mmoverride:Enable")

        EntFire("@fizzler_B_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator true true):0:-1")
        EntFire("@fizzler_B_gun_1_on", "AddOutput", "targetname @fizzler_B_gun_1_on_p2mmoverride")
        EntFire("@fizzler_B_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1")
        EntFire("@fizzler_B_gun_1_off", "AddOutput", "targetname @fizzler_B_gun_1_off_p2mmoverride")
        EntFire("@all_fizzler_off", "AddOutput", "OnTrigger @fizzler_B_gun_1_on_p2mmoverride:Disable")
        EntFire("@all_fizzler_off", "AddOutput", "OnTrigger @fizzler_B_gun_1_off_p2mmoverride:Disable")
        EntFire("@All_fizzler_on", "AddOutput", "OnTrigger @fizzler_B_gun_1_on_p2mmoverride:Enable")
        EntFire("@All_fizzler_on", "AddOutput", "OnTrigger @fizzler_B_gun_1_off_p2mmoverride:Enable")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(64, -1616, 65), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_stage_redfirst:1.5")
    }

    if (MSPostPlayerSpawn) {
        EntFire("door_1_p2mmoverride", "Open", "")
    }
}
