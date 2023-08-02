// ███╗   ███╗██████╗             █████╗  █████╗  █████╗ ██████╗            ██╗      █████╗ ██████╗ ██████╗ ██╗   ██╗           ██████╗
// ████╗ ████║██╔══██╗           ██╔══██╗██╔══██╗██╔══██╗██╔══██╗           ██║     ██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝           ╚════██╗
// ██╔████╔██║██████╔╝           ██║  ╚═╝██║  ██║██║  ██║██████╔╝           ██║     ██║  ██║██████╦╝██████╦╝ ╚████╔╝              ███╔═╝
// ██║╚██╔╝██║██╔═══╝            ██║  ██╗██║  ██║██║  ██║██╔═══╝            ██║     ██║  ██║██╔══██╗██╔══██╗  ╚██╔╝             ██╔══╝
// ██║ ╚═╝ ██║██║     ██████████╗╚█████╔╝╚█████╔╝╚█████╔╝██║     ██████████╗███████╗╚█████╔╝██████╦╝██████╦╝   ██║   ██████████╗███████╗
// ╚═╝     ╚═╝╚═╝     ╚═════════╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝     ╚═════════╝╚══════╝ ╚════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚═════════╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        Entities.FindByName(null, "robo_rampa_01b").__KeyValueFromString("mincpulevel", "0")
        Entities.FindByName(null, "robo_rampa_01b").__KeyValueFromString("mingpulevel", "0")
        Entities.FindByName(null, "robo_rampa_02b").__KeyValueFromString("mincpulevel", "0")
        Entities.FindByName(null, "robo_rampa_02b").__KeyValueFromString("mingpulevel", "0")
        Entities.FindByName(null, "robo_rampa_03b").__KeyValueFromString("mincpulevel", "0")
        Entities.FindByName(null, "robo_rampa_03b").__KeyValueFromString("mingpulevel", "0")
        Entities.FindByName(null, "robo_rampa_04b").__KeyValueFromString("mincpulevel", "0")
        Entities.FindByName(null, "robo_rampa_04b").__KeyValueFromString("mingpulevel", "0")
        EntFire("trigger_run_script", "AddOutput", "OnStartTouchBluePlayer coop_man_enter_hub:SetStateBTrue", 0, null)
        EntFire("trigger_quick_spawn", "AddOutput", "OnStartTouchBluePlayer coop_man_quick_open:SetStateBTrue", 0, null)
        EntFire("trigger_set_course", "AddOutput", "OnStartTouchBluePlayer coop_man_set_course:SetStateBTrue", 0, null)
        enablehub <- false
    }

    if (MSPostPlayerSpawn) {
        for (local course = 1; course <= 6; course++) {
            // 9 levels is the highest that a course has
            for (local level = 1; level <= 9; level++) {
                if (IsLevelComplete(course - 1, level - 1)) {
                    enablehub <- true
                }
            }
        }

        if (enablehub) {
            // If any level was completed outside of calibration, enable the hub entirely
            EntFire("case_open_course", "invalue", "7", 0, null)
        }

        // Allow the players to drop from spawn tube
        Entities.FindByName(null, "brush_spawn_blocker_red").Destroy()
        Entities.FindByName(null, "brush_spawn_blocker_blue").Destroy()

        // Enable retrigger for all logic_relay entities except for those defined otherwise
        // in the bsp to prevent desync on clients and remove errors from the console
        local ent = null
        while (ent = Entities.FindByClassname(ent, "logic_relay")) {
            ent.__KeyValueFromString("spawnflags", "2")
        }
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track1-rl_start_exit"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track1-rl_start_exit_finished"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track2-rl_start_exit_finished"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track3-rl_start_exit"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track3-rl_start_exit_finished"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track4-rl_start_exit"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track4-rl_start_exit_finished"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track5-relay_open_doors"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track5-rl_start_exit"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track5-rl_start_exit_finished"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track6-rl_start_exit"))
        DoEntFire("!self", "AddOutput", "spawnflags 3", 0.0, null, Entities.FindByName(null, "track6-rl_start_exit_finished"))

        // Remove useless entities so that the entity limit does not crash the game

        // Remove func_portal_bumper's from the map
        for (local ent = null; ent = Entities.FindByClassname(ent, "func_portal_bumper");) {
            ent.Destroy() // 165 entities removed
        }
        // Remove env_sprite's from the map
        for (local ent = null; ent = Entities.FindByClassname(ent, "env_sprite");) {
            ent.Destroy() // 31 entities removed
        }

        // Fix track 5
        // Entry door fix
        Entities.FindByName(null, "track5-door_paint-trigger_hurt_door").Destroy()
        Entities.FindByName(null, "track5-door_paint-collide_door").Destroy()

        // Light fix
        Entities.FindByName(null, "@light_shadowed_paintroom").Destroy()
        Entities.FindByName(null, "@snd_light_inside").Destroy()
        Entities.FindByName(null, "@snd_light_outside").Destroy()

        // Remove orange exit door
        local ent = null
        while(ent = Entities.FindByName(ent, "track5-orangeiris_door_elevator_pit")) {
            ent.Destroy()
        }

        Entities.FindByName(null, "track5-orangeescape_elevator_clip").Destroy()

        // Remove blue exit door
        local ent = null
        while(ent = Entities.FindByName(ent, "track5-iris_door_elevator_pit")) {
            ent.Destroy()
        }

        Entities.FindByName(null, "track5-escape_elevator_clip").Destroy()

        // Remove the bottom of droppers in Course 5
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            local ent = null
            while (ent = Entities.FindByClassnameWithin(ent, "prop_dynamic", OldPlayerPos, 500)) {
                if (ent.GetModelName() == "models/props_underground/underground_boxdropper.mdl") {
                    EntFireByHandle(ent, "SetAnimation", "open_idle", 0.0, null, null)
                }

                if (ent.GetModelName() == "models/props_backstage/item_dropper.mdl") {
                    EntFireByHandle(ent, "SetAnimation", "item_dropper_idle", 0.0, null, null)
                }
            }
        }
    }

    if (MSLoop) {
        local PLent = null
        while(PLent = Entities.FindByClassnameWithin(PLent, "player", Vector(2367, -8126, -54), 30)) {
            local APLent = null
            while(APLent = Entities.FindByClassname(APLent, "player")) {
                APLent.SetOrigin(Vector(2495, -7451, 410))
            }
        }
    }
}