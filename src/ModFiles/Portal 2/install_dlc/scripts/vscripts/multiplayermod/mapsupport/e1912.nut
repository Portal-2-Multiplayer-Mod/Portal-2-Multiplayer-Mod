// ███╗   ███╗ █████╗ ██████╗ ███╗  ██╗ █████╗ ███╗   ███╗███████╗
// ████╗ ████║██╔══██╗██╔══██╗████╗ ██║██╔══██╗████╗ ████║██╔════╝
// ██╔████╔██║███████║██████╔╝██╔██╗██║███████║██╔████╔██║█████╗
// ██║╚██╔╝██║██╔══██║██╔═══╝ ██║╚████║██╔══██║██║╚██╔╝██║██╔══╝
// ██║ ╚═╝ ██║██║  ██║██║     ██║ ╚███║██║  ██║██║ ╚═╝ ██║███████╗
// ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚══╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun == true) {
        // Remove Portal Gun
        RemovePortalGunBlue <- Entities.CreateByClassname("info_target")
        RemovePortalGunBlue.__KeyValueFromString("targetname", "supress_blue_portalgun_spawn")

        RemovePortalGunOrange <- Entities.CreateByClassname("info_target")
        RemovePortalGunOrange.__KeyValueFromString("targetname", "supress_orange_portalgun_spawn")

        // Create env_global's to disable pinging and taunting
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

        EntFire("vehicle_intro", "Unlock", "", 18, null)
        EntFire("vehicle_intro", "ExitVehicle", "", 18.03, null)

        InIntroVehicle <- true

        //------------------------------------------------------------------------

        EntFire("relay_Intro_setup_view", "Addoutput", "spawnflags 0", 0, null)

        // local ent = null
        // while (ent = Entities.FindByName(ent, "vehicle_intro")) {
        //     ent.__KeyValueFromString("DefaultAnim", "")
        // }
    }

    // p.SetOrigin(Vector(-722, -924, 26))
    // p.SetVelocity(Vector(0, 0, 0))
    // p.SetAngles(0, 30, 0)

    if (MSPostPlayerSpawn==true) {
        // EntFire("fade_start", "Fade", "", 0, null)
        // EntFire("prop_arms_view", "SetAnimation", "wake_up_start", 0, null)
        EntFire("speedmod", "ModifySpeed", "0.65", 0, null)
        EntFire("relay_Intro_setup_view", "Trigger", "", 0.10, null)
        EntFire("timescale", "SetTimescaleBlendTime", "0.1", 0, null)
        EntFire("timescale", "SetDesiredTimescale", "0.5", 0.10, null)
        EntFire("timescale", "SetTimescaleBlendTime", "2", 0.30, null)
        EntFire("timescale", "SetDesiredTimescale", "1", 0.50, null)
    }

    if (MSLoop==true) {
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            if (p.GetVelocity().z > 0) {
                p.SetVelocity(Vector(p.GetVelocity().x, p.GetVelocity().y, -1))
            }
        }

        if (Time() >= 18 && InIntroVehicle == true) {
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(8548, 1204, 106))
                p.SetVelocity(Vector(0, 0, 0))
                InIntroVehicle <- false
            }
        }
    }
}