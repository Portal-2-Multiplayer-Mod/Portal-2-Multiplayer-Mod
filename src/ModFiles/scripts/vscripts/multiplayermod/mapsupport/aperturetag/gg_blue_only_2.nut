//  ██████╗  ██████╗            ██████╗ ██╗     ██╗   ██╗███████╗            █████╗ ███╗  ██╗██╗     ██╗   ██╗           ██████╗ 
// ██╔════╝ ██╔════╝            ██╔══██╗██║     ██║   ██║██╔════╝           ██╔══██╗████╗ ██║██║     ╚██╗ ██╔╝           ╚════██╗
// ██║  ██╗ ██║  ██╗            ██████╦╝██║     ██║   ██║█████╗             ██║  ██║██╔██╗██║██║      ╚████╔╝              ███╔═╝
// ██║  ╚██╗██║  ╚██╗           ██╔══██╗██║     ██║   ██║██╔══╝             ██║  ██║██║╚████║██║       ╚██╔╝             ██╔══╝  
// ╚██████╔╝╚██████╔╝██████████╗██████╦╝███████╗╚██████╔╝███████╗██████████╗╚█████╔╝██║ ╚███║███████╗   ██║   ██████████╗███████╗
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝╚═════════╝ ╚════╝ ╚═╝  ╚══╝╚══════╝   ╚═╝   ╚═════════╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        tubePlayer <- null
        trackCoords <- Vector(0, 0, 0)
        respawnCooldown <- 0

        // Make doors/pathways not close
        Entities.FindByClassnameNearest("trigger_once", Vector(-1616, -720.08, 64), 32).Destroy()
        Entities.FindByName(null, "AutoInstance2-door_close").Destroy()
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-1616, -720.08, 64), 32), "AddOutput", "OnTrigger area_1:Open::1.51", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-560, -1044.02, 192), 32), "AddOutput", "OnTrigger area_2:Open::1.51", 0, null, null)

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:updateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_portal_cleanser", Vector(-1345.22, -224, 704), 32), "AddOutput", "OnStartTouch activator.EmitSound(\"weapon_ambient/wpn_portal_fizzler_shimmy_01.wav\")", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_portal_cleanser", Vector(-448, -656, 192), 32), "AddOutput", "OnStartTouch activator.EmitSound(\"weapon_ambient/wpn_portal_fizzler_shimmy_01.wav\")", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_portal_cleanser", Vector(-448, -656, 192), 32), "AddOutput", "OnStartTouch !activator:RunScriptCode:updateGels(activator false false)", 0, null, null)

        for (local track = null; track = Entities.FindByClassname(track, "path_track");) {
            EntFireByHandle(track, "AddOutput", "OnPass !self:RunScriptCode:correctPosition()", 0, null, null)
        }

        // Make transitioning levels work
        Entities.FindByName(null, "fade_ending_tube").__KeyValueFromString("targetname", "fade_ending_tube_p2mmoverride")
        Entities.FindByName(null, "transition_trigger").Destroy()
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-448.01, -1280, 424), 32), "AddOutput", "OnTrigger !activator:RunScriptCode:vacTube(activator)", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_teleport", Vector(1184, -2368, 512), 32), "AddOutput", "OnStartTouch fade_ending_tube_p2mmoverride:Fade", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_teleport", Vector(1184, -2368, 512), 32), "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_blue_only_3:2", 0, null, null)
    }
}

function vacTube(activator) {
    Entities.FindByName(null, "SendVent_Push").Destroy()
    Entities.FindByName(null, "vacuume_push_catapult").Destroy()
    Entities.FindByName(null, "SendVent_PushSphere_mini").Destroy()
    SetSpeed(activator, 0)
    EnableNoclip(true, activator)
    
    activator.SetVelocity(Vector(0, 0, 0))
    EntFireByHandle(activator, "SetParent", "AutoInstance1-@podtrain_player", 0, null, null)
    EntFire("AutoInstance1-@podtrain_player", "SetSpeed", "1")
    tubePlayer = activator
}

function correctPosition() {
    // The vactube ride is very buggy on client for some reason, so we need to correct it constantly

    trackCoords = Entities.FindByName(null, "AutoInstance1-@podtrain_player").GetOrigin()
    if (!Entities.FindByClassnameNearest("player", trackCoords, 64)) {
        EntFireByHandle(tubePlayer, "SetParent", "", 0, null, null)
        EntFire("p2mm_servercommand", "Command", "script tubePlayer.SetOrigin(Vector(trackCoords.x, trackCoords.y, trackCoords.z - 56))", 0.02)
        EntFireByHandle(tubePlayer, "SetParent", "AutoInstance1-@podtrain_player", 0.05, null, null)
        tubePlayer.SetVelocity(Vector(0, 0, 0))
    }
}
