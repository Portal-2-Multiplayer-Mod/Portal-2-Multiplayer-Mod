//  ██████╗  ██████╗            ██████╗ ██╗     ██╗   ██╗███████╗            █████╗ ███╗  ██╗██╗     ██╗   ██╗           ██████╗            ██████╗ ████████╗██████╗ 
// ██╔════╝ ██╔════╝            ██╔══██╗██║     ██║   ██║██╔════╝           ██╔══██╗████╗ ██║██║     ╚██╗ ██╔╝           ╚════██╗           ██╔══██╗╚══██╔══╝╚════██╗
// ██║  ██╗ ██║  ██╗            ██████╦╝██║     ██║   ██║█████╗             ██║  ██║██╔██╗██║██║      ╚████╔╝              ███╔═╝           ██████╔╝   ██║     ███╔═╝
// ██║  ╚██╗██║  ╚██╗           ██╔══██╗██║     ██║   ██║██╔══╝             ██║  ██║██║╚████║██║       ╚██╔╝             ██╔══╝             ██╔═══╝    ██║   ██╔══╝  
// ╚██████╔╝╚██████╔╝██████████╗██████╦╝███████╗╚██████╔╝███████╗██████████╗╚█████╔╝██║ ╚███║███████╗   ██║   ██████████╗███████╗██████████╗██║        ██║   ███████╗
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝╚═════════╝ ╚════╝ ╚═╝  ╚══╝╚══════╝   ╚═╝   ╚═════════╝╚══════╝╚═════════╝╚═╝        ╚═╝   ╚══════╝

// This is actually the 4th blue only map- i mean its blue only 2 episode 2

trackCoords <- Vector(0, 0, 0)
tubePlayer <- null

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Make doors/pathways not close
        Entities.FindByName(null, "AutoInstance3-door_close").Destroy()
        Entities.FindByName(null, "AutoInstance4-door_close").Destroy()
        Entities.FindByName(null, "AutoInstance5-door_close").Destroy()
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(2216, -2368, 224), 32), "AddOutput", "OnTrigger area_4:open::1.52", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(3603.99, -2656, 608), 32), "AddOutput", "OnTrigger area_5:open::2.02", 0, null, null)

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(3568, -2560, 576.01), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false)", 0, null, null)

        // Vac tube cutscene
        EntFire("exit_tube_1_exit_trigger", "AddOutput", "OnStartTouch !activator:RunScriptCode:vacTube(activator)")
        for (local track = null; track = Entities.FindByClassname(track, "path_track");) {
            if (track.GetName().find("tube_path") != null) {
                EntFireByHandle(track, "AddOutput", "OnPass !self:RunScriptCode:correctPosition()", 0, null, null)
            }
        }

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("tube_path29", "AddOutput", "OnPass final_fade:Fade::3")
        EntFire("tube_path29", "AddOutput", "OnPass p2mm_servercommand:Command:changelevel gg_a1_intro4:5")
    }
}

function vacTube(activator) {
    Entities.FindByName(null, "SendVent_Push").Destroy()
    Entities.FindByClassnameNearest("trigger_catapult", Vector(3840, -2560, 536), 32).Destroy()
    Entities.FindByName(null, "SendVent_PushSphere").Destroy()
    SetSpeed(activator, 0)
    EnableNoclip(true, activator)
    
    activator.SetVelocity(Vector(0, 0, 0))
    EntFireByHandle(activator, "SetParent", "podtrain_player", 0, null, null)
    EntFire("podtrain_player", "SetSpeed", "1")
    tubePlayer = activator
    correctPosition()
}

function correctPosition() {
    // The vactube ride is very buggy on client for some reason, so we need to correct it constantly

    trackCoords = Entities.FindByName(null, "podtrain_player").GetOrigin()
    if (!Entities.FindByClassnameNearest("player", trackCoords, 32)) {
        EntFireByHandle(tubePlayer, "SetParent", "", 0, null, null)
        EntFire("p2mm_servercommand", "Command", "script tubePlayer.SetOrigin(Vector(trackCoords.x, trackCoords.y, trackCoords.z))", 0.02)
        EntFireByHandle(tubePlayer, "SetParent", "podtrain_player", 0.05, null, null)
        tubePlayer.SetVelocity(Vector(0, 0, 0))
    }
}
