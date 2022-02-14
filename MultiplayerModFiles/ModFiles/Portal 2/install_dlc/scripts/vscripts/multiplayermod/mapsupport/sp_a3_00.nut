// ██████╗██████╗             █████╗ ██████╗             █████╗  █████╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║ █████╔╝           ██║  ██║██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██║  ██║██║  ██║
//██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗╚█████╔╝╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝ ╚════╝  ╚════╝

// should fix fog sometime

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        // Shake the camera when you fall through the wood
        Entities.FindByName(null, "crash_landing_shake").__KeyValueFromString("spawnflags", "29")

        // Create Env Globals
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

        // Create tube cap brush
        // TubeCapBrush
        TubeCapBrush <- Entities.CreateByClassname("func_brush")
        TubeCapBrush.SetOrigin(Vector(0, -4096, 92))
        TubeCapBrush.SetSize(Vector(0, 0 ,0), Vector(128, 128, 24))
        TubeCapBrush.__KeyValueFromInt("Solid", 3)
        TubeCapBrush.__KeyValueFromString("targetname", "TubeCapBrush")
        DebugDrawBox(TubeCapBrush.GetOrigin(), TubeCapBrush.GetBoundingMins(), TubeCapBrush.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        Entities.CreateByClassname("point_servercommand").__KeyValueFromString("targetname", "Sp_A3_00ServerCommand")
        printl(Entities.FindByName(null, "@environment_mines_fog").__KeyValueFromString("fogmaxdensity", "1"))
        Entities.FindByName(null, "@environment_mines_fog").__KeyValueFromString("fogend", "1")
        Entities.FindByName(null, "@environment_bottomless_pit_falling_fog").__KeyValueFromString("farz", "0")
        Entities.FindByName(null, "potatos_prop").__KeyValueFromString("solid", "0")
        // Destroy objects
        Entities.FindByClassnameNearest("logic_auto", Vector(144, -4048, 64), 20).Destroy()
        local ent = null
        while (ent = Entities.FindByClassname(ent, "trigger_push")) {
            ent.Destroy()
        }
    }

    if (MSPostPlayerSpawn==true) {
        EntFireByHandle(Entities.FindByName(null, "player_looktarget"), "SetParent", "!player", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "potatos_tank"), "SetTargetEntity", "player_looktarget", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "shaft_section_0"), "StartForward", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "shaft_section_1"), "StartForward", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "lift_mover"), "Open", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "ambient_sp_a3_01_b1"), "PlaySound", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "falling_whoosh"), "stopsound", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "falling_whoosh"), "PlaySound", "", 0.1, null, null)
        EntFireByHandle(Entities.FindByName(null, "potatos_relay"), "Trigger", "", 3, null, null)
        EntFireByHandle(Entities.FindByName(null, "potatos_train"), "StartForward", "", 4, null, null)

        EntFireByHandle(env_global01, "turnoff", "", 70, null, null)
        EntFireByHandle(env_global02, "turnoff", "", 70, null, null)
        EntFireByHandle(env_global03, "turnoff", "", 70, null, null)
        EntFireByHandle(env_global04, "turnoff", "", 70, null, null)

        EntFire("Sp_A3_00ServerCommand", "command", "echo Changing level...", 76, null)
        EntFire("Sp_A3_00ServerCommand", "command", "changelevel sp_a3_01", 76, null)
    }

    if (MSLoop==true) {
        // Get all players
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            p.SetOrigin(Vector(p.GetOrigin().x, p.GetOrigin().y, 10))
            p.SetVelocity(Vector(0, 0, 0))
            EntFireByHandle(p, "addoutput", "movetype 5", 0, null, null)
        }
        // Make POTATOS tank point at nearest player
        try {
            local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "potatos_tank").GetOrigin(), 10000)
            EntFireByHandle(Entities.FindByName(null, "potatos_tank"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
        } catch(exception) {}
    }
}