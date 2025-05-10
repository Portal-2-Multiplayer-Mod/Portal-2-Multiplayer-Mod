//  ██████╗  ██████╗             █████╗   ███╗             ██╗███╗  ██╗████████╗██████╗  █████╗   ██╗██╗
// ██╔════╝ ██╔════╝            ██╔══██╗ ████║             ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗ ██╔╝██║
// ██║  ██╗ ██║  ██╗            ███████║██╔██║             ██║██╔██╗██║   ██║   ██████╔╝██║  ██║██╔╝ ██║
// ██║  ╚██╗██║  ╚██╗           ██╔══██║╚═╝██║             ██║██║╚████║   ██║   ██╔══██╗██║  ██║███████║
// ╚██████╔╝╚██████╔╝██████████╗██║  ██║███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝╚════██║
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝      ╚═╝

trackCoords <- Vector(0, 0, 0)
tubePlayer <- null

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Make doors/pathways not close
        Entities.FindByClassnameNearest("trigger_once", Vector(240, 512, 320), 32).Destroy()
        Entities.FindByName(null, "door_exit_2").__KeyValueFromString("targetname", "door_exit_2_p2mmoverride")
        EntFire("exit_2_counter", "AddOutput", "OnHitMax door_exit_2_p2mmoverride:Open")
        EntFire("exit_2_counter", "AddOutput", "OnChangedFromMax door_exit_2_p2mmoverride:Close")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(928, -200, 448), 32), "AddOutput", "OnTrigger door_exit_2_area:Open::1.02", 0, null, null)
        Entities.FindByName(null, "look_ele_en_2_trigger").Destroy()
        Entities.FindByName(null, "@vac_items_timer").Destroy()
        Entities.FindByName(null, "door_exit_trigger").Destroy()
        Entities.FindByName(null, "door_entry_1").__KeyValueFromString("targetname", "door_entry_1_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-640, 1160, 704), 32), "AddOutput", "OnStartTouch door_entry_1_p2mmoverride:Open", 0, null, null)
        Entities.FindByName(null, "@vac_items_timer").Destroy()

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")

        EntFire("@fizzler_gun_1_off", "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")

        // Checkpoint
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(384, 112, 320), 32), "AddOutput", "OnStartTouch !self:RunScriptCode:Checkpoint()", 0, null, null)

        // Vac tube cutscene
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-4448.13, 8000, 2816), 32), "AddOutput", "OnStartTouch !activator:RunScriptCode:vacTube(activator)", 0, null, null)

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("tube_path23", "AddOutput", "OnPass InstanceAuto27-exit_fade:Fade::3")
        EntFire("tube_path23", "AddOutput", "OnPass p2mm_servercommand:Command:changelevel gg_blue_upplatform:4")
    }

    if (MSPostPlayerSpawn) {
        // WHY CAN I DO THIS???? - \n
        train <- Entities.CreateByClassname("func_tracktrain")
        train.SetOrigin(Vector(-4472, 8000, 2816))
        train.__KeyValueFromString("MoveSound", "Portal.tube_suck")
        train.__KeyValueFromString("MoveSoundMaxPitch", "100")
        train.__KeyValueFromString("MoveSoundMinPitch", "100")
        train.__KeyValueFromString("spawnflags", "27")
        train.__KeyValueFromString("startspeed", "600")
        train.__KeyValueFromString("target", "tube_path2")
        train.__KeyValueFromString("targetname", "podtrain_player")
        train.__KeyValueFromString("velocitytype", "1")
        train.__KeyValueFromString("height", "0")
        InitializeEntity(train)

        // vac tube cutscene
        for (local track = null; track = Entities.FindByClassname(track, "path_track");) {
            if (track.GetName().find("tube_path") != null) {
                EntFireByHandle(track, "AddOutput", "OnPass !self:RunScriptCode:correctPosition()", 0, null, null)
            }
        }
    }

    if (MSOnRespawn) {
        if (Entities.FindByClassnameNearest("info_player_start", Vector(303, -187, 293), 32))
            FindPlayerClass(MSOnRespawn).BlueGelIsEnabled = true
    }
}

function vacTube(activator) {
    SetSpeed(activator, 0)
    EnableNoclip(true, activator)
    
    activator.SetVelocity(Vector(0, 0, 0))
    EntFire("podtrain_player", "SetSpeed", "1")
    tubePlayer = activator
    correctPosition()
}

function correctPosition() {
    // The vactube ride is very buggy on client for some reason, so we need to correct it constantly

    trackCoords = Entities.FindByName(null, "podtrain_player").GetOrigin()
    if (!Entities.FindByClassnameNearest("player", trackCoords, 32)) {
        EntFireByHandle(tubePlayer, "SetParent", "", 0, null, null)
        EntFire("p2mm_servercommand", "Command", "script tubePlayer.SetOrigin(Vector(trackCoords.x, trackCoords.y, trackCoords.z - 64))", 0.02)
        EntFireByHandle(tubePlayer, "SetParent", "podtrain_player", 0.05, null, null)
        tubePlayer.SetVelocity(Vector(0, 0, 0))
    }
}

function Checkpoint()
{
    Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(303, -187, 293))
    Entities.FindByClassname(null, "info_player_start").SetAngles(0, 0, 0)
}
