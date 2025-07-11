//  ██████╗  ██████╗            ██████╗ ██╗     ██╗   ██╗███████╗            █████╗ ███╗  ██╗██╗     ██╗   ██╗
// ██╔════╝ ██╔════╝            ██╔══██╗██║     ██║   ██║██╔════╝           ██╔══██╗████╗ ██║██║     ╚██╗ ██╔╝
// ██║  ██╗ ██║  ██╗            ██████╦╝██║     ██║   ██║█████╗             ██║  ██║██╔██╗██║██║      ╚████╔╝ 
// ██║  ╚██╗██║  ╚██╗           ██╔══██╗██║     ██║   ██║██╔══╝             ██║  ██║██║╚████║██║       ╚██╔╝  
// ╚██████╔╝╚██████╔╝██████████╗██████╦╝███████╗╚██████╔╝███████╗██████████╗╚█████╔╝██║ ╚███║███████╗   ██║   
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝╚═════════╝ ╚════╝ ╚═╝  ╚══╝╚══════╝   ╚═╝   

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(-912, -1408, 96.01), 32), "AddOutput", "OnTrigger song_2:PlaySound::0:1", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(-912, -1408, 96.01), 32), "AddOutput", "OnTrigger actor_relay_2:Trigger::0:1", 0, null, null)

        // Make doors/pathways not close
        Entities.FindByClassnameNearest("trigger_once", Vector(-864, -1408, 56), 32).Destroy()
        Entities.FindByName(null, "AutoInstance1-door_close").Destroy()
        Entities.FindByName(null, "AutoInstance2-door_close1").Destroy()
        Entities.FindByName(null, "AutoInstance3-door_close1").Destroy()
        Entities.FindByName(null, "AutoInstance4-door_close1").Destroy()
        Entities.FindByName(null, "AutoInstance5-door_close1").Destroy()
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(1520, -1536, 448.01), 32), "AddOutput", "OnStartTouch Recieve_tube_Sound_2:PlaySound::0:1", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(1520, -1536, 448.01), 32), "AddOutput", "OnStartTouch tube_particle:Start::0:1", 0, null, null)
        Entities.FindByClassnameNearest("trigger_once", Vector(1520, -1536, 448.01), 32).Destroy()
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(113, -1408, 64), 32), "AddOutput", "OnStartTouch area_2:open::2.01", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1521, -1536, 448), 32), "AddOutput", "OnTrigger area_3:open::2.01", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1792, -999.01, -1984), 32), "AddOutput", "OnTrigger area_4:open::2.01", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(2785.99, -844.8, -960), 32), "AddOutput", "OnTrigger area_5:open::2.01", 0, null, null)

        // Checkpoint
        EntFire("exit_bottom", "AddOutput", "OnStartTouch !self:RunScriptCode:Checkpoint()")

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")

        EntFire("@fizzler_gun_1_off", "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")

        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(1520, -1536, 448.01), 32), "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false false)", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(1520, -1536, 448.01), 32), "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false false)", 0, null, null)

        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(2800, -768, -959.99), 32), "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false false)", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(2800, -768, -959.99), 32), "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false false)", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_blue_only_2:2")
    }
}

function Checkpoint()
{
    Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(1797, -1529, -1995))
    Entities.FindByClassname(null, "info_player_start").SetAngles(0, 90, 0)
}
