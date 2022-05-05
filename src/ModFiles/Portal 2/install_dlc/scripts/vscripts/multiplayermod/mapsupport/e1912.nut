// ███╗   ███╗ █████╗ ██████╗ ███╗  ██╗ █████╗ ███╗   ███╗███████╗
// ████╗ ████║██╔══██╗██╔══██╗████╗ ██║██╔══██╗████╗ ████║██╔════╝
// ██╔████╔██║███████║██████╔╝██╔██╗██║███████║██╔████╔██║█████╗
// ██║╚██╔╝██║██╔══██║██╔═══╝ ██║╚████║██╔══██║██║╚██╔╝██║██╔══╝
// ██║ ╚═╝ ██║██║  ██║██║     ██║ ╚███║██║  ██║██║ ╚═╝ ██║███████╗
// ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚══╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝

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

        HasStartedE1912 <- false
        EntFireByHandle(Entities.FindByName(null, "timescale"), "SetTimescaleBlendTime", "0.1", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "timescale"), "SetDesiredTimescale", "0.5", 0.5, null, null)
        Entities.FindByClassnameNearest("info_player_start", Vector(-722, -924, 26), 128).Destroy()
        Entities.FindByClassnameNearest("logic_auto", Vector(-900, 6110, 11), 16).Destroy()
        OnlyOnceE1912 <- true
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

        printl("Ran")
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
    }

    if (MSLoop) {
        if (!HasStartedE1912) {
            EntFireByHandle(Entities.FindByName(null, "fade_start"), "Fade", "", 0, null, null)
        }

        if (Entities.FindByName(null, "E1912ViewcontrolTele")) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(-1362 6818 -190))
                p.SetVelocity(Vector(0, 0, 0))
            }
        }

        if (OnlyOnceE1912) {
            if (Entities.FindByName(null, "E1912ViewcontrolDone")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(-868.607117, 6147.984375, 5))
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

        if (DisableJumpmsp) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                if (p.GetVelocity().z > 0) {
                    p.SetVelocity(Vector(p.GetVelocity().x, p.GetVelocity().y, -1))
                }
            }
        }

        // if (SecondToLastTP) {
        //     local p = null
        //     while (p = Entities.FindByClassnameWithin(p, "player", Vector(-8656, 1768, 104), 400)) {
        //         p.SetOrigin(Vector(-1649, 4376, 3167))
        //     }
        // }
    }
}