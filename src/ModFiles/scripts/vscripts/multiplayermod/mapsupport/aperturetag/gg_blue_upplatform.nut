//  ██████╗  ██████╗            ██████╗ ██╗     ██╗   ██╗███████╗           ██╗   ██╗██████╗ ██████╗ ██╗      █████╗ ████████╗███████╗ █████╗ ██████╗ ███╗   ███╗
// ██╔════╝ ██╔════╝            ██╔══██╗██║     ██║   ██║██╔════╝           ██║   ██║██╔══██╗██╔══██╗██║     ██╔══██╗╚══██╔══╝██╔════╝██╔══██╗██╔══██╗████╗ ████║
// ██║  ██╗ ██║  ██╗            ██████╦╝██║     ██║   ██║█████╗             ██║   ██║██████╔╝██████╔╝██║     ███████║   ██║   █████╗  ██║  ██║██████╔╝██╔████╔██║
// ██║  ╚██╗██║  ╚██╗           ██╔══██╗██║     ██║   ██║██╔══╝             ██║   ██║██╔═══╝ ██╔═══╝ ██║     ██╔══██║   ██║   ██╔══╝  ██║  ██║██╔══██╗██║╚██╔╝██║
// ╚██████╔╝╚██████╔╝██████████╗██████╦╝███████╗╚██████╔╝███████╗██████████╗╚██████╔╝██║     ██║     ███████╗██║  ██║   ██║   ██║     ╚█████╔╝██║  ██║██║ ╚═╝ ██║
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝╚═════════╝ ╚═════╝ ╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝      ╚════╝ ╚═╝  ╚═╝╚═╝     ╚═╝

trackCoords <- Vector(0, 0, 0)
tubePlayer <- null

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Make doors/pathways not close
        Entities.FindByName(null, "AutoInstance2-door_close1").Destroy()
        Entities.FindByName(null, "AutoInstance1-door_close").Destroy()
        Entities.FindByName(null, "fade_quick_in").Destroy()
        Entities.FindByName(null, "fade_quick_out").Destroy()
        Entities.FindByName(null, "bts_door_1").__KeyValueFromString("targetname", "bts_door_1_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(152, -1848, 448), 32), "AddOutput", "OnTrigger !self:CancelPending::1", 0, null, null)

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")

        // Make transitioning levels work
        EntFire("@transition_script", "Kill", "")
        EntFire("tube_path_59", "AddOutput", "OnPass p2mm_servercommand:Command:changelevel gg_red_only")

        // Vactube ride
        for (local track = null; track = Entities.FindByClassname(track, "path_track");) {
            if (track.GetName().find("tube_path") != null) {
                EntFireByHandle(track, "AddOutput", "OnPass !self:RunScriptCode:correctPosition()", 0, null, null)
            }
        }
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-704, 1408, 1040), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:vacTube(activator)", 0, null, null)
    }

    if (MSLoop) {
        // for some cursed reason i cant just tack this onto the ending doors triggermultiple??
        for (local player = null; player = Entities.FindByClassnameWithin(player, "player", Entities.FindByClassnameNearest("trigger_multiple", Vector(-704, 1136, 192), 32).GetOrigin(), 64);) {
            UpdateGels(player, false, false, true)
        }
    }
}

function vacTube(activator) {
    Entities.FindByClassnameNearest("trigger_push", Vector(-704, 1406, 296), 32).Destroy()
    Entities.FindByClassnameNearest("point_push", Vector(-704, 1408, 272), 32).Destroy()
    Entities.FindByClassnameNearest("trigger_catapult", Vector(-704, 1408, 152), 32).Destroy()
    SetSpeed(activator, 0)
    EnableNoclip(true, activator)
    
    activator.SetVelocity(Vector(0, 0, 0))
    EntFire("AutoInstance1-@podtrain_player", "SetSpeed", "1")
    tubePlayer = activator
    correctPosition()
}

function correctPosition() {
    // The vactube ride is very buggy on client for some reason, so we need to correct it constantly

    trackCoords = Entities.FindByName(null, "AutoInstance1-@podtrain_player").GetOrigin()
    if (!Entities.FindByClassnameNearest("player", trackCoords, 32)) {
        EntFireByHandle(tubePlayer, "SetParent", "", 0, null, null)
        EntFire("p2mm_servercommand", "Command", "script tubePlayer.SetOrigin(Vector(trackCoords.x, trackCoords.y, trackCoords.z - 48))", 0.02)
        EntFireByHandle(tubePlayer, "SetParent", "AutoInstance1-@podtrain_player", 0.05, null, null)
        tubePlayer.SetVelocity(Vector(0, 0, 0))
    }
}
