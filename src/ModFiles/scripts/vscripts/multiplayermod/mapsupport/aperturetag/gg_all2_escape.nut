//  ██████╗  ██████╗             █████╗ ██╗     ██╗     ██████╗            ███████╗ ██████╗ █████╗  █████╗ ██████╗ ███████╗
// ██╔════╝ ██╔════╝            ██╔══██╗██║     ██║     ╚════██╗           ██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝
// ██║  ██╗ ██║  ██╗            ███████║██║     ██║       ███╔═╝           █████╗  ╚█████╗ ██║  ╚═╝███████║██████╔╝█████╗  
// ██║  ╚██╗██║  ╚██╗           ██╔══██║██║     ██║     ██╔══╝             ██╔══╝   ╚═══██╗██║  ██╗██╔══██║██╔═══╝ ██╔══╝  
// ╚██████╔╝╚██████╔╝██████████╗██║  ██║███████╗███████╗███████╗██████████╗███████╗██████╔╝╚█████╔╝██║  ██║██║     ███████╗
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═════════╝╚══════╝╚═════╝  ╚════╝ ╚═╝  ╚═╝╚═╝     ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Stop pathways from closing
        Entities.FindByClassnameNearest("trigger_once", Vector(-2320, 1856, 64), 32).Destroy()
        Entities.FindByName(null, "vert_door_in").__KeyValueFromString("targetname", "vert_door_in_p2mmoverride")
        EntFire("open_vert_door_trigger", "AddOutput", "OnTrigger vert_door_in_p2mmoverride:SetAnimation:vert_door_opening")
        EntFire("open_vert_door_trigger", "AddOutput", "OnTrigger vert_door_in_p2mmoverride:SetAnimation:vert_door_open_idle:2")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-736, 1144, 64), 32), "AddOutput", "OnTrigger area_door_1:Open::2.01", 0, null, null)
        Entities.FindByName(null, "ele_door_top_brush").Destroy()
        Entities.FindByName(null, "nuke_hurt").Destroy()
        Entities.FindByName(null, "skip_button").Destroy()
        EntFire("start_escape_math", "AddOutput", "OnChangedFromMin pit_door:Open::0.01")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-640, 1316, -352), 32), "AddOutput", "OnStartTouch ele_door_top:Open::0.01", 0, null, null)
        Entities.FindByNameNearest("switch_1_button", Vector(-136, 1044, -712), 32).Destroy()
        EntFire("start_escape_relay", "AddOutput", "OnTrigger !self:RunScriptCode:StartRace()")
        EntFire("nuke_relay", "AddOutput", "OnTrigger p2mm_servercommand:Command:changelevel gg_all2_escape:3")
        EntFire("exit_gate", "Open", "")
        Entities.FindByClassnameNearest("trigger_once", Vector(2560, 5312, -1032), 32).Destroy()

        // Make fizzlers work
        EntFire("@fizzler_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator true true):0:-1")
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")
        EntFire("@fizzler_B_gun_1_on", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator true true):0:-1")
        EntFire("@fizzler_B_gun_1_on", "AddOutput", "targetname @fizzler_B_gun_1_on_p2mmoverride")
        EntFire("@fizzler_B_gun_1_off", "AddOutput", "OnTrigger !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_B_gun_1_off", "AddOutput", "targetname @fizzler_B_gun_1_off_p2mmoverride")
        EntFire("@All_fizzler_on", "AddOutput", "OnTrigger @fizzler_B_gun_1_on_p2mmoverride:Enable")
        EntFire("@All_fizzler_on", "AddOutput", "OnTrigger @fizzler_B_gun_1_off_p2mmoverride:Enable")
        EntFire("@All_fizzler_off", "AddOutput", "OnTrigger @fizzler_B_gun_1_on_p2mmoverride:Disable")
        EntFire("@All_fizzler_off", "AddOutput", "OnTrigger @fizzler_B_gun_1_off_p2mmoverride:Disable")

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        Entities.FindByName(null, "servercommand").Destroy()
        EntFire("escape_video", "AddOutput", "OnPlaybackFinished p2mm_servercommand:Command:changelevel gg_stage_reveal")
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_stage_reveal:1.5")

        // Move the platform & disable some animations so that multiple people can go through the race
        Entities.FindByName(null, "gap2_func_door").SetOrigin(Vector(3648, 2240, -1056))
        Entities.FindByClassnameNearest("trigger_once", Vector(3648, 400, -672), 32).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(3648, -3440, -768), 32).Destroy()
        Entities.FindByName(null, "beam_relay").Destroy()

        // We have to change the ending of the race a bit because the map logic will mysteriously spawn a platform which you use here, but is not present earlier in the race.
        // To combat (my) muscle memory killing players here, this is a little helper.
        local sprayer = Entities.CreateByClassname("info_paint_sprayer")
        InitializeEntity(sprayer)
        sprayer.__KeyValueFromString("blob_spread_radius", "1")
        sprayer.__KeyValueFromString("blob_streak_percentage", "15")
        sprayer.__KeyValueFromString("blobs_per_second", "35")
        sprayer.__KeyValueFromString("max_speed", "1250")
        sprayer.__KeyValueFromString("max_streak_speed_dampen", "10000")
        sprayer.__KeyValueFromString("min_streak_speed_dampen", "10")
        sprayer.__KeyValueFromString("max_streak_time", "0.2")
        sprayer.__KeyValueFromString("min_streak_time", "0.1")
        sprayer.__KeyValueFromString("min_speed", "1100")
        sprayer.__KeyValueFromString("RenderMode", "0")
        sprayer.SetOrigin(Vector(2976, 640, -384))
        sprayer.SetAngles(90, 0, 0)
        EntFireByHandle(sprayer, "Start", "", 1, null, null)

    }

    if (MSPostPlayerSpawn) {
        resetButton(1)
        resetButton(2)
    }

    if (MSLoop) {
        local button1 = Entities.FindByName(null, "p2mm_cubebutton1")
        local button2 = Entities.FindByName(null, "p2mm_cubebutton2")
        if (button1) {
            button1.SetOrigin(Vector(-960, -22, -722))
            button1.SetAngles(0, 0, 0)
        }
        if (button2) {
            button2.SetOrigin(Vector(-136, 1044, -712))
            button2.SetAngles(0, 0, 0)
        }
    }
}

function hostFadeSkipRace(activator) {
    if (GetAdminLevel(activator) < 3) {
        HudPrint(activator.entindex(), "Only Admins that are above level 3\ncan use this button!", Vector(0.3, -0.2, 1), 2, 0.1, Vector(0, 255, 255), 255, Vector(0, 0, 0), 0, Vector(0, 0.3, 3))
        resetButton(1)
        return
    }
    EntFire("skip_fade", "Fade", "")
    EntFire("p2mm_servercommand", "Command", "script hostSkipRace()", 2)
}

function hostSkipRace() {
    for (local player = null; player = Entities.FindByClassname(player, "player");) {
        player.SetOrigin(Vector(-1280, 64, -724))
    }
    EntFire("start_escape_relay", "CancelPending", "")
    EntFire("start_escape_relay_timer", "CancelPending", "")
    EntFire("escape_video", "PlayMovieForAllPlayers", "")
}

function StartRace() {
    for (local p = null; p = Entities.FindByClassname(p, "player");) {
        local teleport = true
        foreach (player in CreateTrigger("player", -128, 896, -768, -1125, 64, -448)) {
            if (p == player)
                teleport = false
        }
        if (teleport) {
            p.SetOrigin(Vector(-640, 768, -731))
            p.SetAngles(0, -90, 0)
        }
        FindPlayerClass(p).BlueGelIsEnabled = true
        FindPlayerClass(p).OrangeGelIsEnabled = true
    }
}

function resetButton(cube) {
    local skipbutton = Entities.CreateByClassname("prop_weighted_cube")
    InitializeEntity(skipbutton)
    if (cube == 1) {
        EntFireByHandle(skipbutton, "AddOutput", "OnPlayerPickup !activator:RunScriptCode:hostFadeSkipRace(activator)", 0, null, null)
        EntFireByHandle(skipbutton, "AddOutput", "OnPlayerPickup skip_1_model:SetAnimation:press", 0, null, null)
        EntFireByHandle(skipbutton, "AddOutput", "OnPlayerPickup skip_1_model:SetAnimation:idle:1", 0, null, null)
        EntFireByHandle(skipbutton, "AddOutput", "OnPlayerPickup !self:Kill", 0, null, null)
        EntFireByHandle(skipbutton, "AddOutput", "targetname p2mm_cubebutton1", 0, null, null)
        skipbutton.__KeyValueFromString("rendermode", "10")
        skipbutton.SetOrigin(Vector(-960, -22, -722))
        skipbutton.SetAngles(0, 0, 0)
    } else {
        EntFireByHandle(skipbutton, "AddOutput", "OnPlayerPickup switch_1_model:SetAnimation:press", 0, null, null)
        EntFireByHandle(skipbutton, "AddOutput", "OnPlayerPickup switch_1_model:SetAnimation:idle:4", 0, null, null)
        EntFireByHandle(skipbutton, "AddOutput", "OnPlayerPickup switch_sound_1:PlaySound", 0, null, null)
        EntFireByHandle(skipbutton, "AddOutput", "OnPlayerPickup @all_fizzler_off:Trigger", 0, null, null)
        EntFireByHandle(skipbutton, "AddOutput", "OnPlayerPickup @All_fizzler_on:Trigger::4", 0, null, null)
        EntFireByHandle(skipbutton, "AddOutput", "OnPlayerPickup p2mm_servercommand:RunScriptCode:resetButton(2):4", 0, null, null)
        EntFireByHandle(skipbutton, "AddOutput", "OnPlayerPickup !self:Kill", 0, null, null)
        EntFireByHandle(skipbutton, "AddOutput", "OnPlayerPickup pit_door:Open", 0, null, null)
        EntFireByHandle(skipbutton, "AddOutput", "targetname p2mm_cubebutton2", 0, null, null)
        skipbutton.__KeyValueFromString("rendermode", "10")
        skipbutton.SetOrigin(Vector(-136, 1044, -712))
        skipbutton.SetAngles(0, 0, 0)
    }
}
