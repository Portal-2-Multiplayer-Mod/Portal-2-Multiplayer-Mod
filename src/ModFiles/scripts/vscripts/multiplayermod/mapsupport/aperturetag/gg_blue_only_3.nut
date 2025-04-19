//  ██████╗  ██████╗            ██████╗ ██╗     ██╗   ██╗███████╗            █████╗ ███╗  ██╗██╗     ██╗   ██╗           ██████╗ 
// ██╔════╝ ██╔════╝            ██╔══██╗██║     ██║   ██║██╔════╝           ██╔══██╗████╗ ██║██║     ╚██╗ ██╔╝           ╚════██╗
// ██║  ██╗ ██║  ██╗            ██████╦╝██║     ██║   ██║█████╗             ██║  ██║██╔██╗██║██║      ╚████╔╝             █████╔╝
// ██║  ╚██╗██║  ╚██╗           ██╔══██╗██║     ██║   ██║██╔══╝             ██║  ██║██║╚████║██║       ╚██╔╝              ╚═══██╗
// ╚██████╔╝╚██████╔╝██████████╗██████╦╝███████╗╚██████╔╝███████╗██████████╗╚█████╔╝██║ ╚███║███████╗   ██║   ██████████╗██████╔╝
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝╚═════════╝ ╚════╝ ╚═╝  ╚══╝╚══════╝   ╚═╝   ╚═════════╝╚═════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Make doors/pathways not close
        Entities.FindByName(null, "AutoInstance1-door_close").Destroy()
        Entities.FindByName(null, "AutoInstance2-door_close1").Destroy()
        Entities.FindByName(null, "AutoInstance4-door_close").Destroy()
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-919.97, 960, 64), 32), "AddOutput", "OnTrigger area_1:open::1.51", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-919.97, 960, 64), 32), "AddOutput", "OnTrigger portal_1_exit:open::1.51", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-320, 960, 96), 32), "AddOutput", "OnTrigger area_4:open::1.51", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1684, 288, 576), 32), "AddOutput", "OnTrigger area_2:open::2.01", 0, null, null)
        Entities.FindByClassnameNearest("trigger_once", Vector(1633, 384, 576), 32).Destroy()


        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(1632, 384, 576.01), 32), "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false false)", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_blue_only_2_pt2:2")
    }
}
