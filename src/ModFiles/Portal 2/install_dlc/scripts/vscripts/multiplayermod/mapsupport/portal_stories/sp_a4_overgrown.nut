//  ██████╗██████╗             █████╗   ██╗██╗            █████╗ ██╗   ██╗███████╗██████╗  ██████╗ ██████╗  █████╗  ██╗       ██╗███╗  ██╗
// ██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ██╔══██╗██║   ██║██╔════╝██╔══██╗██╔════╝ ██╔══██╗██╔══██╗ ██║  ██╗  ██║████╗ ██║
// ╚█████╗ ██████╔╝           ███████║██╔╝ ██║           ██║  ██║╚██╗ ██╔╝█████╗  ██████╔╝██║  ██╗ ██████╔╝██║  ██║ ╚██╗████╗██╔╝██╔██╗██║
//  ╚═══██╗██╔═══╝            ██╔══██║███████║           ██║  ██║ ╚████╔╝ ██╔══╝  ██╔══██╗██║  ╚██╗██╔══██╗██║  ██║  ████╔═████║ ██║╚████║
// ██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗╚█████╔╝  ╚██╔╝  ███████╗██║  ██║╚██████╔╝██║  ██║╚█████╔╝  ╚██╔╝ ╚██╔╝ ██║ ╚███║
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝ ╚════╝    ╚═╝   ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚════╝    ╚═╝   ╚═╝  ╚═╝  ╚══╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Offset coop repsawn nodes for elevators (left and right side)
        GlobalSpawnClass.m_bUseAutoSpawn <- false
        UTIL_Team.Spawn_PortalGun(true)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)



        // delete elevator spawn
        Entities.FindByClassnameNearest("info_player_start", Vector(-1983.74, -3288.72, -498), 128).Destroy()
        Entities.FindByName(null, "intro_elevator_1_interior_start_trigger").Destroy()

        // stop the intro sequence and prepare for cutscene
        Entities.FindByClassnameNearest("logic_auto", Vector(-1936, -3144, -295), 32).Destroy()
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-1200 -3200 -96), 32), "AddOutput", "OnTrigger intro_elevator_train:StartForward::0", 0, null, null)
        EntFire("cs_virgil_154", "AddOutput", "OnCompletion !self:RunScriptCode:EndScene():1")
        Entities.FindByName(null, "fall_fade-proxy").Destroy()
        Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(-2312, -3201, -181)) 


        // make doors not close
        Entities.FindByClassnameNearest("trigger_once", Vector(-570, -2636, -48.01), 32).Destroy()
        Entities.FindByName(null, "intro_ug_door").__KeyValueFromString("targetname", "intro_ug_door_p2mmoverride")
        Entities.FindByName(null, "office_ap").__KeyValueFromString("targetname", "office_ap_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("func_button", Vector(-350, -2228, 56.5), 32), "AddOutput", "OnPressed intro_ug_door_p2mmoverride:SetAnimation:open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("func_button", Vector(-350, -2228, 56.5), 32), "AddOutput", "OnPressed office_ap_p2mmoverride:Open", 0, null, null)
        Entities.FindByClassnameNearest("trigger_once", Vector(144, -1424, 63.99), 32).Destroy()
        Entities.FindByName(null, "intro_lift_entrance").__KeyValueFromString("targetname", "intro_lift_entrance_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(336, -1424, 63.99), 32), "AddOutput", "OnTrigger intro_lift_entrance_p2mmoverride:SetAnimation:vert_door_slow_opening:1", 0, null, null)
        Entities.FindByName(null, "@entry_door1").__KeyValueFromString("targetname", "entry_door1_p2mmoverride")
        EntFire("AutoInstance1-leaving_elevator_trigger", "AddOutput", "OnTrigger entry_door1_p2mmoverride:Open::0.5")
        Entities.FindByClassnameNearest("trigger_once", Vector(704, -48, 64), 32).Destroy()
        Entities.FindByName(null, "door_3").__KeyValueFromString("targetname", "door_3_p2mmoverride")
        EntFire("door_3_manager", "AddOutput", "OnChangeToAnyFalse door_3_p2mmoverride:Close")
        EntFire("door_3_manager", "AddOutput", "OnChangeToAllTrue door_3_p2mmoverride:Open")
        Entities.FindByName(null, "door_4").__KeyValueFromString("targetname", "door_4_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1744, 32, 64), 32), "AddOutput", "OnStartTouch door_4_p2mmoverride:Open", 0, null, null)
        Entities.FindByName(null, "@exit_door").__KeyValueFromString("targetname", "exit_door_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("prop_floor_button", Vector(2464, 1184, 299), 32), "AddOutput", "OnPressed exit_door_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("prop_floor_button", Vector(2464, 1184, 299), 32), "AddOutput", "OnUnPressed exit_door_p2mmoverride:Close", 0, null, null)


        // Make changing levels work
        Entities.FindByName(null, "end_command").Destroy()
        if (GetMapName().find("sp_") != null) {
            EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(2336, 1920, 1016), 32), "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel sp_a4_tb_over_goo:1.5", 0, null, null)
        } else EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(2336, 1920, 1016), 32), "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel st_a4_tb_over_goo:1.5", 0, null, null)

    }
    
    if (MSPostPlayerSpawn) {
        EntFire("p2mm_servercommand", "Command", "script StartScene()", 0.1)
        
    }
}
function StartScene() {
    EntFire("elevator_viewcontrol", "Enable")
    elevator_viewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
    elevator_viewcontrol.__KeyValueFromString("targetname", "elevator_viewcontrol")
    elevator_viewcontrol.__KeyValueFromString("fov", "120")
    elevator_viewcontrol.SetOrigin(Vector(-1983.74, -3288.72, -462))
    EntFire("elevator_viewcontrol", "setparent", "intro_elevator_train", 0, null)
    elevator_viewcontrol.SetAngles(0, 90, 0)
    EntFire("cs_virgil_151", "Start", null, 1)
	EntFire("intro_elevator_train", "StartForward", null, 1.2)
	EntFire("lift_shake", "StartShake")
    EntFire("intro_elevator_train", "MoveToPathNode", "AutoInstance1-@elevator_1_bottom_path_1", 0.1)
    EntFire("intro_light_elevator_dynamic", "TurnOn")
}
function EndScene() {
    EntFire("elevator_viewcontrol", "Disable")
    for (local p; p = Entities.FindByClassname(p, "player");) {
        p.SetOrigin(Vector(-1211, -3296, -40))
        p.SetAngles(0, 90, 0)
    }
    Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(-1198, -3202, -40)) 

}
