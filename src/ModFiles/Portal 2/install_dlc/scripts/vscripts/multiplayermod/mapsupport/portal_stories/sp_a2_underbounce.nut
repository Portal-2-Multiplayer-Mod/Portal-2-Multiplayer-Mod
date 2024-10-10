//  ██████╗██████╗             █████╗ ██████╗            ██╗   ██╗███╗  ██╗██████╗ ███████╗██████╗ ██████╗  █████╗ ██╗   ██╗███╗  ██╗ █████╗ ███████╗
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██║   ██║████╗ ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔══██╗██║   ██║████╗ ██║██╔══██╗██╔════╝   
// ╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██║   ██║██╔██╗██║██║  ██║█████╗  ██████╔╝██████╦╝██║  ██║██║   ██║██╔██╗██║██║  ╚═╝█████╗     
//  ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██║   ██║██║╚████║██║  ██║██╔══╝  ██╔══██╗██╔══██╗██║  ██║██║   ██║██║╚████║██║  ██╗██╔══╝     
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗╚██████╔╝██║ ╚███║██████╔╝███████╗██║  ██║██████╦╝╚█████╔╝╚██████╔╝██║ ╚███║╚█████╔╝███████╗   
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝ ╚═════╝ ╚═╝  ╚══╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝  ╚════╝  ╚═════╝ ╚═╝  ╚══╝ ╚════╝ ╚══════╝

OnlyOnceSp_A3_Jump_Intro <- true
ElevatorFinishMoving <- null

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Offset coop repsawn nodes for elevators (left and right side)
        GlobalSpawnClass.m_bUseAutoSpawn <- false
        UTIL_Team.Spawn_PortalGun(true)

        // Enable pinging and taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(true)

        // delete box spawn
        Entities.FindByClassnameNearest("info_player_start", Vector(-2296, -336, 373), 999).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(1160, 784, 448), 999).Destroy()
        Entities.FindByClassnameNearest("logic_auto", Vector(-232, -5864, 137), 32).Destroy()
        Entities.FindByClassnameNearest("logic_auto", Vector(-552, -5824, -220), 32).Destroy()
        Entities.FindByName(null, "AutoInstance1-start_trigger").Destroy()
        Entities.FindByName(null, "end_command").Destroy()
        Entities.FindByName(null, "Door_1").__KeyValueFromString("targetname", "door1_p2mm_override")
        Entities.FindByClassnameNearest("prop_under_floor_button", Vector(1856, -256, 136), 32).__KeyValueFromString("targetname", "button_p2mm")
        EntFire("button_p2mm", "AddOutput", "OnPressed door1_p2mm_override:SetAnimation:open:0.3", 0, null)
        EntFire("button_p2mm", "AddOutput", "OnUnPressed door1_p2mm_override:SetAnimation:close:0.3", 0, null)

        // Make changing levels work
        if(GetMapName().find("sp_", 0) == 0) {EntFire("EndLevel_Trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel sp_a2_once_upon:2", 0, null)}
        else EntFire("EndLevel_Trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel st_a2_once_upon:2", 0, null)
        
        while (Entities.FindByName(null, "block_boxes")) {
            Entities.FindByName(null, "block_boxes").Destroy()
        }
    }
    
    if (MSPostPlayerSpawn) {
        EntFire("AutoInstance1-entrance_lift_train", "StartForward")
        EntFire("Power_On_Start_Relay", "Trigger")
        Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(-552, -192, 162))




    }
    
}
    