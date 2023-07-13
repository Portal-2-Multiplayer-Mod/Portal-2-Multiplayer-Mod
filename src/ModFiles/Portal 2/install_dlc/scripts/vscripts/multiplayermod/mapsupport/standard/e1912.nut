// ███████╗  ███╗   █████╗   ███╗  ██████╗ 
// ██╔════╝ ████║  ██╔══██╗ ████║  ╚════██╗
// █████╗  ██╔██║  ╚██████║██╔██║    ███╔═╝
// ██╔══╝  ╚═╝██║   ╚═══██║╚═╝██║  ██╔══╝  
// ███████╗███████╗ █████╔╝███████╗███████╗
// ╚══════╝╚══════╝ ╚════╝ ╚══════╝╚══════╝

function E1912CrashViewcontrol() {
    printl("Ran")
    E1912CrashViewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
    E1912CrashViewcontrol.__KeyValueFromString("targetname", "E1912CrashViewcontrol")
    E1912CrashViewcontrol.__KeyValueFromString("target_team", "-1")
    E1912CrashViewcontrol.SetOrigin(Entities.FindByName(null, "vehicle_crash").GetOrigin())
    E1912CrashViewcontrol.SetAngles(0, 0, 0)
    EntFire("E1912CrashViewcontrol", "setparent", "vehicle_crash", 0, null)
    EntFire("E1912CrashViewcontrol", "setparentattachment", "vehicle_driver_eyes", 0, null)
    EntFire("E1912CrashViewcontrol", "enable", "", 0, null)
    EntFire("E1912CrashViewcontrolTele", "disable", "", 4, null)
    EntFire("E1912CrashViewcontrol", "addoutput", "targetname E1912CrashViewcontrolTele", 0.1, null)
    EntFire("E1912CrashViewcontrolTele", "addoutput", "targetname E1912CrashViewcontrolDone", 4, null)
    EntFireByHandle(Entities.FindByName(null, "env_global01"), "turnon", "", 0, null, null)
    EntFireByHandle(Entities.FindByName(null, "env_global02"), "turnon", "", 0, null, null)
    EntFireByHandle(Entities.FindByName(null, "env_global03"), "turnon", "", 0, null, null)
    EntFireByHandle(Entities.FindByName(null, "env_global04"), "turnon", "", 0, null, null)
}

function E1912AfterCrashViewcontrol() {
    printl("Ran")
    E1912AfterCrashViewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
    E1912AfterCrashViewcontrol.__KeyValueFromString("targetname", "E1912AfterCrashViewcontrol")
    E1912AfterCrashViewcontrol.__KeyValueFromString("target_team", "-1")
    E1912AfterCrashViewcontrol.SetOrigin(Entities.FindByName(null, "crash-vehicle_intro").GetOrigin())
    E1912AfterCrashViewcontrol.SetAngles(0, 0, 0)
    EntFire("E1912AfterCrashViewcontrol", "setparent", "crash-vehicle_intro", 0, null)
    EntFire("E1912AfterCrashViewcontrol", "setparentattachment", "vehicle_driver_eyes", 0, null)
    EntFire("E1912AfterCrashViewcontrol", "enable", "", 0, null)
    EntFire("E1912AfterCrashViewcontrolTele", "disable", "", 17.5, null)
    EntFire("E1912AfterCrashViewcontrol", "addoutput", "targetname E1912AfterCrashViewcontrolTele", 0.25, null)
    EntFire("E1912AfterCrashViewcontrolTele", "addoutput", "targetname E1912AfterCrashViewcontrolDone", 17.5, null)

    local ent = null
    while (ent = Entities.FindByClassname(ent, "player")) {
        EntFireByHandle(Entities.FindByName(null, "crash-speedmod"), "ModifySpeed", "0.6", 0, ent, ent)
    }
}

function E1912ScareViewcontrol() {
    printl("Ran")
    E1912ScareViewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
    E1912ScareViewcontrol.__KeyValueFromString("targetname", "E1912ScareViewcontrol")
    E1912ScareViewcontrol.__KeyValueFromString("target_team", "-1")
    E1912ScareViewcontrol.SetOrigin(Entities.FindByName(null, "p2mmcrashvehicleoutrooverride").GetOrigin())
    E1912ScareViewcontrol.SetAngles(0, 0, 0)
    EntFire("E1912ScareViewcontrol", "setparent", "p2mmcrashvehicleoutrooverride", 0, null)
    EntFire("E1912ScareViewcontrol", "setparentattachment", "vehicle_driver_eyes", 0, null)
    EntFire("E1912ScareViewcontrol", "enable", "", 0, null)
    EntFire("E1912ScareViewcontrolTele", "disable", "", 10, null)
    EntFire("E1912ScareViewcontrol", "addoutput", "targetname E1912ScareViewcontrolTele", 0.1, null)
    EntFire("E1912ScareViewcontrolTele", "addoutput", "targetname E1912ScareViewcontrolDone", 10, null)
    EntFireByHandle(Entities.FindByName(null, "env_global01"), "turnon", "", 0, null, null)
    EntFireByHandle(Entities.FindByName(null, "env_global02"), "turnon", "", 0, null, null)
    EntFireByHandle(Entities.FindByName(null, "env_global03"), "turnon", "", 0, null, null)
    EntFireByHandle(Entities.FindByName(null, "env_global04"), "turnon", "", 0, null, null)
}

function E1912PostScare() {
    EntFireByHandle(env_global01, "turnoff", "", 1, null, null)
    EntFireByHandle(env_global02, "turnoff", "", 1, null, null)
    EntFireByHandle(env_global03, "turnoff", "", 1, null, null)
    EntFireByHandle(env_global04, "turnoff", "", 1, null, null)
}

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Remove Portal Gun
        RemovePortalGunBlue <- Entities.CreateByClassname("info_target")
        RemovePortalGunBlue.__KeyValueFromString("targetname", "supress_blue_portalgun_spawn")

        RemovePortalGunOrange <- Entities.CreateByClassname("info_target")
        RemovePortalGunOrange.__KeyValueFromString("targetname", "supress_orange_portalgun_spawn")

        // Create env_globals
        env_global01 <- Entities.CreateByClassname("env_global")
        env_global01.__KeyValueFromString("targetname", "env_global01")
        env_global01.__KeyValueFromString("globalstate", "no_pinging_blue")

        env_global02 <- Entities.CreateByClassname("env_global")
        env_global02.__KeyValueFromString("targetname", "env_global02")
        env_global02.__KeyValueFromString("globalstate", "no_pinging_orange")

        env_global03 <- Entities.CreateByClassname("env_global")
        env_global03.__KeyValueFromString("targetname", "env_global03")
        env_global03.__KeyValueFromString("globalstate", "no_taunting_blue")

        env_global04 <- Entities.CreateByClassname("env_global")
        env_global04.__KeyValueFromString("targetname", "env_global04")
        env_global04.__KeyValueFromString("globalstate", "no_taunting_orange")

        EntFireByHandle(env_global01, "turnon", "", 1, null, null)
        EntFireByHandle(env_global02, "turnon", "", 1, null, null)
        EntFireByHandle(env_global03, "turnon", "", 1, null, null)
        EntFireByHandle(env_global04, "turnon", "", 1, null, null)

        Entities.FindByName(null, "crash-vehicle_outro").__KeyValueFromString("targetname", "p2mmcrashvehicleoutrooverride")
        Entities.FindByName(null, "crash-movie_logo").__KeyValueFromString("targetname", "p2mmcrashmovielogooverride")
        EntFireByHandle(Entities.FindByName(null, "timescale"), "SetTimescaleBlendTime", "0.1", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "timescale"), "SetDesiredTimescale", "0.5", 0.5, null, null)
        EntFireByHandle(Entities.FindByName(null, "crash-trigger_scare"), "addoutput", "OnStartTouch crash-relay_cannisters_monster_expolode:Trigger::0.1", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "crash-relay_break_out"), "addoutput", "OnTrigger p2mmcrashmovielogooverride:playmovieforallplayers::15.70", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "crash-trigger_scare"), "addoutput", "OnTrigger p2mm_servercommand:command:changelevel mp_coop_lobby_3:26", 0, null, null)
        Entities.FindByClassnameNearest("info_player_start", Vector(-722, -924, 26), 128).Destroy()
        Entities.FindByClassnameNearest("logic_auto", Vector(-900, 6110, 11), 16).Destroy()
        Entities.FindByName(null, "crash-aisc_monster_car_push").Destroy()

        // Set up function fires
        EntFire("relay_view_crash", "addoutput", "OnTrigger p2mm_servercommand:command:script E1912CrashViewcontrol():0.1")
        EntFire("@relay_Intro_setup_view2", "addoutput", "OnTrigger p2mm_servercommand:command:script E1912AfterCrashViewcontrol()")
        EntFire("crash-trigger_scare", "addoutput", "OnTrigger p2mm_servercommand:command:script E1912ScareViewcontrol():1.9")
        EntFire("crash-trigger_scare", "addoutput", "OnTrigger p2mm_servercommand:command:script E1912PostScare():23")

        HasStartedE1912 <- false
        OnlyOnceE1912 <- true
        OnlyOnce2E1912 <- true
        OnlyOnce3E1912 <- true
        NewSpawnPoint <- false
        DisableJumpmsp <- true
    }

    if (MSPostPlayerSpawn) {
        HasStartedE1912 <- true
        EntFire("fade_start", "Fade", "", 0)
        EntFire("speed_mod", "ModifySpeed", "0.65", 0)
        EntFire("relay_Intro_setup_view", "Trigger", "", 0)
        EntFire("timescale", "SetTimescaleBlendTime", "2", 0.3)
        EntFire("timescale", "SetDesiredTimescale", "1", 0.5)
        EntFire("spr_gunlight", "SetParentAttachment", "lightAttach", 0.5)
        EntFire("@script_br_trainride", "RunScriptCode", "StartExploreTimer()", 1.5)

        E1912Viewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
        E1912Viewcontrol.__KeyValueFromString("targetname", "E1912Viewcontrol")
        E1912Viewcontrol.__KeyValueFromString("target_team", "-1")
        E1912Viewcontrol.SetOrigin(Entities.FindByName(null, "vehicle_intro").GetOrigin())
        E1912Viewcontrol.SetAngles(0, 0, 0)
        EntFire("E1912Viewcontrol", "setparent", "vehicle_intro", 0, null)
        EntFire("E1912Viewcontrol", "setparentattachment", "vehicle_driver_eyes", 0, null)
        EntFire("E1912Viewcontrol", "enable", "", 0, null)
        EntFire("E1912ViewcontrolTele", "disable", "", 9, null)
        EntFire("E1912Viewcontrol", "addoutput", "targetname E1912ViewcontrolTele", 0.25, null)
        EntFire("E1912ViewcontrolTele", "addoutput", "targetname E1912ViewcontrolDone", 9, null)

        local ent = null
        while (ent = Entities.FindByClassname(ent, "player")) {
            EntFireByHandle(Entities.FindByName(null, "speed_mod"), "ModifySpeed", "0.65", 0, ent, ent)
        }
    }

    if (MSLoop) {
        if (!HasStartedE1912) {
            EntFireByHandle(Entities.FindByName(null, "fade_start"), "Fade", "", 0, null, null)
        }

        if (Entities.FindByName(null, "E1912ViewcontrolTele")) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(-882 6104 166))
                p.SetVelocity(Vector(0, 0, 0))
            }
        }

        if (OnlyOnceE1912) {
            if (Entities.FindByName(null, "E1912ViewcontrolDone")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(-868.607117, 6147.984375, 0.031250))
                    p.SetAngles(0.033103, -11.502685, 0)
                }
                EntFireByHandle(env_global01, "turnoff", "", 1, null, null)
                EntFireByHandle(env_global02, "turnoff", "", 1, null, null)
                EntFireByHandle(env_global03, "turnoff", "", 1, null, null)
                EntFireByHandle(env_global04, "turnoff", "", 1, null, null)
                stoprenable <- true
                OnlyOnceE1912 <- false
            }
        }

        if (OnlyOnce2E1912) {
            if (Entities.FindByName(null, "E1912CrashViewcontrolTele")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(-882 6104 154))
                }
                stoprenable <- true
                OnlyOnce2E1912 <- false
            }
        }

        if (Entities.FindByName(null, "E1912AfterCrashViewcontrolTele")) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(-655, -994, -2))
                p.SetAngles(-1, 108, 0)
            }
        }

        if (OnlyOnce3E1912) {
            if (Entities.FindByName(null, "E1912AfterCrashViewcontrolDone")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(-655.748779, -918.373535, 2))
                    p.SetAngles(2.279724, 108.544930, 0)
                }
                EntFireByHandle(env_global01, "turnoff", "", 1, null, null)
                EntFireByHandle(env_global02, "turnoff", "", 1, null, null)
                EntFireByHandle(env_global03, "turnoff", "", 1, null, null)
                EntFireByHandle(env_global04, "turnoff", "", 1, null, null)
                stoprenable <- true
                NewSpawnPoint <- true
                OnlyOnce3E1912 <- false
            }
        }

        if (NewSpawnPoint) {
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-526, 6108, 64), 1000)) {
                p.SetOrigin(Vector(-655.748779, -918.373535, 2))
                p.SetAngles(2.279724, 108.544930, 0)
            }
        }

        if (Entities.FindByName(null, "E1912ScareViewcontrolTele")) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(-324, -200, 34))
                p.SetVelocity(Vector(0, 0, 0))
                p.SetAngles(-2, -65, 0)
            }
        }
    }
}