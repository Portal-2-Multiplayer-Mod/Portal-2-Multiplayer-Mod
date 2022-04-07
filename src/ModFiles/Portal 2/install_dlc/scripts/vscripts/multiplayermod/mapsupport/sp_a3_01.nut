// ██████╗██████╗             █████╗ ██████╗             █████╗   ███╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗ ████║
//╚█████╗ ██████╔╝           ███████║ █████╔╝           ██║  ██║██╔██║
// ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██║  ██║╚═╝██║
//██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗╚█████╔╝███████╗
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝ ╚════╝ ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        stoprenable <- false

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

        HasStartedSp_A3_01 <- false

        Entities.FindByName(null, "AutoInstance1-circuit_breaker_lever").__KeyValueFromString("solid", "0")
        // Here if we need to ent_fire something
        //EntFireByHandle(Entities.FindByName(null, "NAME"), "ACTION", "VALUE", DELAYiny, ACTIVATOR, CALLER)
        // Destroy objects
        Entities.FindByName(null, "transition_trigger").Destroy()
        Entities.FindByName(null, "knockout-teleport").Destroy()
        Entities.FindByName(null, "knockout-teleport-destination").Destroy()
        Entities.FindByClassnameNearest("logic_auto", Vector(-10304, 2544, 112), 20).Destroy()
        Entities.FindByClassnameNearest("trigger_multiple", Vector(-640, -1520, 456), 20).Destroy()
        OnlyOnceSp_A3_01 <- true
    }

    if (MSPostPlayerSpawn==true) {
        HasStartedSp_A3_01 <- true
        EntFireByHandle(Entities.FindByName(null, "global_ents-proxy"), "OnProxyRelay8", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "knockout_start"), "Trigger", "", 1, null, null)

        printl("Ran")
        Sp_A3_01Viewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
        Sp_A3_01Viewcontrol.__KeyValueFromString("targetname", "Sp_A3_01Viewcontrol")
        Sp_A3_01Viewcontrol.__KeyValueFromString("target_team", "-1")
        Sp_A3_01Viewcontrol.SetOrigin(Entities.FindByName(null, "knockout-viewcontroller").GetOrigin())
        Sp_A3_01Viewcontrol.SetAngles(0, 270, 0)
        EntFire("Sp_A3_01Viewcontrol", "setparent", "knockout-viewcontroller", 0, null)
        EntFire("Sp_A3_01Viewcontrol", "setparentattachment", "knockout-viewcontroller", 0, null)
        EntFire("Sp_A3_01Viewcontrol", "enable", "", 0, null)
        EntFire("Sp_A3_01ViewcontrolTele", "disable", "", 13, null)
        EntFire("Sp_A3_01Viewcontrol", "addoutput", "targetname Sp_A3_01ViewcontrolTele", 0.25, null)
        EntFire("Sp_A3_01ViewcontrolTele", "addoutput", "targetname Sp_A3_01ViewcontrolDone", 13, null)
    }

    if (MSOnPlayerJoin != false) {
        if (stoprenable==true) {
            printl("Player Joined (Reseting Viewcontrols)")
            EntFire("Sp_A3_01Viewcontrol", "disable", "", 0.5, null)
            EntFire("Sp_A3_01Viewcontrol", "enable", "", 0.6, null)
        }
    }

    if (MSLoop==true) {
        local p = Entities.FindByClassnameWithin(null, "player", Vector(-10240, 3072, 36), 128)
        try {
            if (p.GetOrigin().z >= -128) {
                p.SetOrigin(Vector(-720, -1852, 14))
                p.SetAngles(0, 60, 0)
            }
        } catch(exception) {}

        if (HasStartedSp_A3_01 == false) {
            EntFireByHandle(Entities.FindByName(null, "knockout-fadeout"), "fade", "", 0, null, null)
        }

        if (Entities.FindByName(null, "Sp_A3_01ViewcontrolTele")) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(-162, -1966, 0))
                p.SetVelocity(Vector(0, 0, 0))
                p.SetAngles(-80, 90, 0)
            }
        }

        if (OnlyOnceSp_A3_01 == true) {
            if (Entities.FindByName(null, "Sp_A3_01ViewcontrolDone")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(-720, -1852, 14))
                    p.SetAngles(0, 60, 0)
                }
                EntFireByHandle(env_global01, "turnoff", "", 1, null, null)
                EntFireByHandle(env_global02, "turnoff", "", 1, null, null)
                EntFireByHandle(env_global03, "turnoff", "", 1, null, null)
                EntFireByHandle(env_global04, "turnoff", "", 1, null, null)
                stoprenable <- true
                Entities.FindByName(null, "knockout-viewcontroller-prop").Destroy()
                Entities.FindByName(null, "knockout-portalgun").Destroy()
                OnlyOnceSp_A3_01 <- false
            }
        }

        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(6016, 4496, -448), 100)) {
             
            SendToConsole("changelevel sp_a3_03")
        }
    }
}