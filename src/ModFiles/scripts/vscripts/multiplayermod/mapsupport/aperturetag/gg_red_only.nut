//  ██████╗  ██████╗            ██████╗ ███████╗██████╗             █████╗ ███╗  ██╗██╗     ██╗   ██╗
// ██╔════╝ ██╔════╝            ██╔══██╗██╔════╝██╔══██╗           ██╔══██╗████╗ ██║██║     ╚██╗ ██╔╝
// ██║  ██╗ ██║  ██╗            ██████╔╝█████╗  ██║  ██║           ██║  ██║██╔██╗██║██║      ╚████╔╝ 
// ██║  ╚██╗██║  ╚██╗           ██╔══██╗██╔══╝  ██║  ██║           ██║  ██║██║╚████║██║       ╚██╔╝  
// ╚██████╔╝╚██████╔╝██████████╗██║  ██║███████╗██████╔╝██████████╗╚█████╔╝██║ ╚███║███████╗   ██║   
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════╝ ╚═════════╝ ╚════╝ ╚═╝  ╚══╝╚══════╝   ╚═╝   

tubePlayer <- null
trackCoords <- Vector(0, 0, 0)

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // This led to entity cramming for me once; delete it to be on the safe side
        Entities.FindByName(null, "@vac_items_timer").Destroy()

        // Make fizzlers work
        EntFire("@fizzler_C_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator true false):0:-1")
        EntFire("@fizzler_C_gun_1_on", "Disable", "")
        EntFire("@fizzler_C_gun_1_on", "AddOutput", "targetname @fizzler_C_gun_1_on_p2mmoverride")
        EntFire("@fizzler_C_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1")
        EntFire("@fizzler_C_gun_1_off", "Disable", "")
        EntFire("@fizzler_C_gun_1_off", "AddOutput", "targetname @fizzler_C_gun_1_off_p2mmoverride")
        EntFire("@orange_fizzler_on", "AddOutput", "OnTrigger @fizzler_C_gun_1_on_p2mmoverride:Enable")
        EntFire("@orange_fizzler_on", "AddOutput", "OnTrigger @fizzler_C_gun_1_off_p2mmoverride:Enable")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(-3216, -2688, -63.99), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1", 0, null, null)

        // Vac tube cutscene
        EntFire("exit_tube_1_exit_trigger", "AddOutput", "OnStartTouch !activator:RunScriptCode:vacTube(activator)")
        for (local track = null; track = Entities.FindByClassname(track, "path_track");) {
            if (track.GetName().find("tube_path") != null) {
                EntFireByHandle(track, "AddOutput", "OnPass !self:RunScriptCode:correctPosition()", 0, null, null)
            }
        }

        // Make transitioning levels work
        EntFire("tube_path110", "AddOutput", "OnPass InstanceAuto17-exit_fade:Fade")
        EntFire("tube_path110", "AddOutput", "OnPass p2mm_servercommand:Command:changelevel gg_red_surf:1.5")
        Entities.FindByName(null, "@transition_script").Destroy()
    }
}

function vacTube(activator) {
    Entities.FindByClassnameNearest("point_push", Vector(-3712, -2688, 16), 32).Destroy()
    Entities.FindByClassnameNearest("trigger_push", Vector(-3712, -2690, -67.77), 32).Destroy()
    Entities.FindByClassnameNearest("trigger_catapult", Vector(-3712, -2688, -104), 32).Destroy()
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
    if (!Entities.FindByClassnameNearest("player", trackCoords, 64)) {
        EntFireByHandle(tubePlayer, "SetParent", "", 0, null, null)
        EntFire("p2mm_servercommand", "Command", "script tubePlayer.SetOrigin(Vector(trackCoords.x, trackCoords.y, trackCoords.z - 16))", 0.02)
        EntFireByHandle(tubePlayer, "SetParent", "podtrain_player", 0.05, null, null)
        tubePlayer.SetVelocity(Vector(0, 0, 0))
    }
}
