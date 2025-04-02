//  ██████╗  ██████╗             ██████╗████████╗ █████╗  ██████╗ ███████╗           ██████╗ ███████╗██╗   ██╗███████╗ █████╗ ██╗     
// ██╔════╝ ██╔════╝            ██╔════╝╚══██╔══╝██╔══██╗██╔════╝ ██╔════╝           ██╔══██╗██╔════╝██║   ██║██╔════╝██╔══██╗██║     
// ██║  ██╗ ██║  ██╗            ╚█████╗    ██║   ███████║██║  ██╗ █████╗             ██████╔╝█████╗  ╚██╗ ██╔╝█████╗  ███████║██║     
// ██║  ╚██╗██║  ╚██╗            ╚═══██╗   ██║   ██╔══██║██║  ╚██╗██╔══╝             ██╔══██╗██╔══╝   ╚████╔╝ ██╔══╝  ██╔══██║██║     
// ╚██████╔╝╚██████╔╝██████████╗██████╔╝   ██║   ██║  ██║╚██████╔╝███████╗██████████╗██║  ██║███████╗  ╚██╔╝  ███████╗██║  ██║███████╗
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═════╝    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═════════╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByClassnameNearest("trigger_once", Vector(-1888, 2368, 408), 32).Destroy()
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(544, 2240, 320), 32), "AddOutput", "OnStartTouch door_entry_area:Open::1.52", 0, null, null)
        Entities.FindByName(null, "door_test_entrance").__KeyValueFromString("targetname", "door_test_entrance_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(128, 2240, 264), 32), "AddOutput", "OnStartTouch door_test_entrance_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(704, 3224, 832), 32), "AddOutput", "OnStartTouch door_exit_area:Open::1.51", 0, null, null)
        Entities.FindByName(null, "door_test_exit").__KeyValueFromString("targetname", "door_test_exit_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("prop_laser_catcher", Vector(885, 2816, 608), 32), "AddOutput", "OnPowered door_test_exit_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_laser_catcher", Vector(885, 2816, 608), 32), "AddOutput", "OnUnpowered door_test_exit_p2mmoverride:Close", 0, null, null)

        // Make bridge to go over the water
        local bridge1 = Entities.CreateByClassname("prop_wall_projector")
        bridge1.SetOrigin(Vector(-2147, 2581, 203))
        bridge1.SetAngles(0, 180, 0)
        bridge1.__KeyValueFromString("targetname", "p2mm_bridge")

        local bridge2 = Entities.CreateByClassname("prop_wall_projector")
        bridge2.SetOrigin(Vector(-2137, 2675, 203))
        bridge2.SetAngles(0, 180, 0)
        bridge2.__KeyValueFromString("targetname", "p2mm_bridge")
        
        local bridge3 = Entities.CreateByClassname("prop_wall_projector")
        bridge3.SetOrigin(Vector(-2041, 2769, 201))
        bridge3.SetAngles(0, 180, 0)
        bridge3.__KeyValueFromString("targetname", "p2mm_bridge")

        InitializeEntity(bridge1)
        InitializeEntity(bridge2)
        InitializeEntity(bridge3)
        EntFire("p2mm_bridge", "Enable", "", 1)

        // Move starting position out of the water to avoid the drowning bug
        Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(-4896, 2080, 338))
        Entities.FindByName(null, "@gelgun").Destroy()

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")

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
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(704, 3216, 833), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_stage_bridgebounce_2:1.5")
    }

    if (MSPostPlayerSpawn) {
        for (local player = null; player = Entities.FindByClassname(player, "player");) {
            FindPlayerClass(player).BlueGelIsEnabled = true
            FindPlayerClass(player).OrangeGelIsEnabled = true
        }
    }
}
