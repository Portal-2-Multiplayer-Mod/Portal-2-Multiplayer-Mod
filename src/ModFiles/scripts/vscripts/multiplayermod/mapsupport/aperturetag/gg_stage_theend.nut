//  ██████╗  ██████╗             ██████╗████████╗ █████╗  ██████╗ ███████╗           ████████╗██╗  ██╗███████╗███████╗███╗  ██╗██████╗ 
// ██╔════╝ ██╔════╝            ██╔════╝╚══██╔══╝██╔══██╗██╔════╝ ██╔════╝           ╚══██╔══╝██║  ██║██╔════╝██╔════╝████╗ ██║██╔══██╗
// ██║  ██╗ ██║  ██╗            ╚█████╗    ██║   ███████║██║  ██╗ █████╗                ██║   ███████║█████╗  █████╗  ██╔██╗██║██║  ██║
// ██║  ╚██╗██║  ╚██╗            ╚═══██╗   ██║   ██╔══██║██║  ╚██╗██╔══╝                ██║   ██╔══██║██╔══╝  ██╔══╝  ██║╚████║██║  ██║
// ╚██████╔╝╚██████╔╝██████████╗██████╔╝   ██║   ██║  ██║╚██████╔╝███████╗██████████╗   ██║   ██║  ██║███████╗███████╗██║ ╚███║██████╔╝
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═════╝    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═════════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚══╝╚═════╝ 

endingTriggered <- false

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByName(null, "door_entry").__KeyValueFromString("targetname", "door_entry_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1664, 512, 514), 32), "AddOutput", "OnTrigger door_entry_p2mmoverride:Open", 0, null, null)
        EntFire("platform_check_player_on_top", "AddOutput", "OnTrigger !self:RunScriptCode:startEnding()")
        Entities.FindByName(null, "should_platform_stop").Destroy()
        EntFire("escape_ele_path_2", "AddOutput", "OnPass !self:RunScriptCode:elevatorTeleport()")
        EntFire("poison", "AddOutput", "targetname poison_p2mmoverride")
        EntFire("poison_p2mmoverride", "Start", "", 2)

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(412, -96, 704), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator true true):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(356, -96, 704), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false true):0:-1", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("@command", "Kill", "")
        Entities.FindByName(null, "credits_video").__KeyValueFromString("targetname", "credits_video_p2mmoverride")
        EntFire("die_ending_math_final", "AddOutput", "OnHitMax credits_video_p2mmoverride:PlayMovieForAllPlayers")
        EntFire("die_ending_math_final", "AddOutput", "OnHitMax p2mm_servercommand:Command:changelevel gg_intro_wakeup:85")
        EntFire("end_truman_relay", "AddOutput", "OnTrigger credits_video_p2mmoverride:PlayMovieForAllPlayers::4.5")
        EntFire("end_truman_relay", "AddOutput", "OnTrigger p2mm_servercommand:Command:changelevel gg_intro_wakeup:85")
    }

    if (MSOnRespawn && endingTriggered) {
        EntFireByHandle(MSOnRespawn, "RunScriptCode", "FindPlayerClass(self).OrangeGelIsEnabled=true", 0.5, null, null)
        EntFireByHandle(MSOnRespawn, "RunScriptCode", "FindPlayerClass(self).BlueGelIsEnabled=true", 0.5, null, null)
    }
}

function startEnding() {
    endingTriggered = true
    Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(-1280, -256, 560))
    Entities.FindByClassname(null, "info_player_start").SetAngles(0, 180, 0)
    EntFireByHandle(Entities.FindByClassname(null, "info_player_start"), "SetParent", "platform_tanktrain", 0, null, null)
    for (local p = null; p = Entities.FindByClassname(p, "player");) {
        local teleport = true
        for (local p2 = null; p2 = Entities.FindByClassnameWithin(p2, "player", Entities.FindByClassname(null, "info_player_start").GetOrigin(), 64);) {
            if (p == p2) {
                teleport = false
                break
            }
        }
        if (teleport) {
            p.SetOrigin(Vector(-1280, -256, 560))
            p.SetAngles(0, 180, 0)
        }
        FindPlayerClass(p).BlueGelIsEnabled = true
        FindPlayerClass(p).OrangeGelIsEnabled = true
    }
}

function elevatorTeleport() {
    for (local p = null; p = Entities.FindByClassname(p, "player");) {
        p.SetOrigin(Vector(64, 3062, 3843.5))
        p.SetAngles(0, -90, 0)
    }
}
