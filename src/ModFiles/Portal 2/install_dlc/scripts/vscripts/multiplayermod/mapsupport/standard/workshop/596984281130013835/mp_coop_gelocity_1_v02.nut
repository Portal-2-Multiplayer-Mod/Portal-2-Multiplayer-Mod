// ███╗   ███╗██████╗             █████╗  █████╗  █████╗ ██████╗             ██████╗ ███████╗██╗      █████╗  █████╗ ██╗████████╗██╗   ██╗             ███╗             ██╗   ██╗ █████╗   ███╗
// ████╗ ████║██╔══██╗           ██╔══██╗██╔══██╗██╔══██╗██╔══██╗           ██╔════╝ ██╔════╝██║     ██╔══██╗██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝            ████║             ██║   ██║██╔══██╗ ████║
// ██╔████╔██║██████╔╝           ██║  ╚═╝██║  ██║██║  ██║██████╔╝           ██║  ██╗ █████╗  ██║     ██║  ██║██║  ╚═╝██║   ██║    ╚████╔╝            ██╔██║             ╚██╗ ██╔╝██║  ██║██╔██║
// ██║╚██╔╝██║██╔═══╝            ██║  ██╗██║  ██║██║  ██║██╔═══╝            ██║  ╚██╗██╔══╝  ██║     ██║  ██║██║  ██╗██║   ██║     ╚██╔╝             ╚═╝██║              ╚████╔╝ ██║  ██║╚═╝██║
// ██║ ╚═╝ ██║██║     ██████████╗╚█████╔╝╚█████╔╝╚█████╔╝██║     ██████████╗╚██████╔╝███████╗███████╗╚█████╔╝╚█████╔╝██║   ██║      ██║   ██████████╗███████╗██████████╗  ╚██╔╝  ╚█████╔╝███████╗
// ╚═╝     ╚═╝╚═╝     ╚═════════╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝     ╚═════════╝ ╚═════╝ ╚══════╝╚══════╝ ╚════╝  ╚════╝ ╚═╝   ╚═╝      ╚═╝   ╚═════════╝╚══════╝╚═════════╝   ╚═╝    ╚════╝ ╚══════╝

LapCount <- 3
WonGame <- false

function StartGelocity() {
    for (local p; p = Entities.FindByClassname(p, "player");) {
        if (p.GetTeam() == TEAM_RED) {
            p.SetOrigin(Vector(2047, -3583, 64))
        } else {
            p.SetOrigin(Vector(2240, -3583, 64))
        }
    }
}

function AddLap() {
    LapCount = LapCount + 1
    printl("LapCount: " + LapCount)
    EntFire("p2mm_change_rounds_text", "settext", "Laps: " + LapCount)
    EntFire("p2mm_change_rounds_text", "display")
    if (LapCount >= 50) {
        LapCount = 50
        printl("Hit Max Laps")
        EntFire("rounds_button_2", "lock")
        EntFire("button_2", "skin", "1")
    }
}

function RemoveLap() {
    LapCount = LapCount - 1
    printl("LapCount: " + LapCount)
    EntFire("p2mm_change_rounds_text", "settext", "Laps: " + LapCount)
    EntFire("p2mm_change_rounds_text", "display")
    if (LapCount <= 2) {
        LapCount = 2
        printl("Hit Min Laps")
        EntFire("rounds_button_1", "lock")
        EntFire("button_1", "skin", "1")
    }
}

function Lap(player) {
    if (!WonGame) {
        local playerclass = FindPlayerClass(player)
        try { playerclass.laps } catch(e) { playerclass.laps <- -1 }
        playerclass.laps <- playerclass.laps + 1

        local WinCondition = false
        if (playerclass.laps >= LapCount) {
            WinCondition = true
        }

        if (playerclass.laps == LapCount - 1) {
            EntFire("last_lap_text", "display")
            EntFire("music_0_relay", "trigger")
            EntFire("last_lap", "playsound")
        }

        local pcolor = GetPlayerColor(player, true)
        local PlayerUsername = playerclass.username
        Entities.FindByName(null, "p2mm_laps_text").__KeyValueFromString("color", pcolor.r.tostring() + " " + pcolor.g.tostring() + " " + pcolor.b.tostring())
        if (!WinCondition) {
            EntFire("p2mm_laps_text", "SetText", PlayerUsername + " Completed Lap " + playerclass.laps, 0.1)
        } else {
            WonGame = true
            Entities.FindByName(null, "p2mm_laps_text").__KeyValueFromString("holdtime", "8")
            EntFire("p2mm_laps_text", "SetText", PlayerUsername + " Won The Game!", 0.1)
            EntFire("p2mm_laps_text", "display", "", 0.2)
            SendToConsoleP2MM("say " + PlayerUsername + " Won The Game!")
            if (player.GetTeam() == TEAM_RED) {
                EntFire("orange_wins", "trigger")
                EntFire("win_door_2_orange", "color", pcolor.r.tostring() + " " + pcolor.g.tostring() + " " + pcolor.b.tostring())
                Entities.FindByName(null, "win_door_2_blue").Destroy()
            } else {
                EntFire("blue_wins", "trigger")
                EntFire("win_door_1_blue", "color", pcolor.r.tostring() + " " + pcolor.g.tostring() + " " + pcolor.b.tostring())
                Entities.FindByName(null, "win_door_2_orange").Destroy()
            }
        }
        EntFire("p2mm_laps_text", "display", "", 0.2)
    }
}

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        local ent = null
        while (ent = Entities.FindByClassname(ent, "info_coop_spawn")) {
            if (ent.GetName() != "blue_dropper-initial_spawn" && ent.GetName() != "red_dropper-initial_spawn" && ent.GetName() != "blue_spawner1" && ent.GetName() != "red_spawner1") {
                ent.Destroy()
            }
        }

        Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(2165, -2195, 368))
        Entities.FindByName(null, "rounds_text_blue").__KeyValueFromString("targetname", "p2mm_laps_text")
            Entities.FindByName(null, "p2mm_laps_text").__KeyValueFromString("holdtime", "2.2")
        Entities.FindByName(null, "change_rounds_text").__KeyValueFromString("targetname", "p2mm_change_rounds_text")

        EntFire(Entities.FindByName(null, "start_relay"), "addoutput", "OnTrigger p2mm_servercommand:command:script StartGelocity():0.1")
        Entities.FindByName(null, "checkpoint_orange_1").Destroy()
        Entities.FindByName(null, "checkpoint_blue_1").Destroy()

        EntFire("rounds_button_2", "addoutput", "OnPressed p2mm_servercommand:command:script AddLap()", 0.1)
        EntFire("rounds_button_1", "addoutput", "OnPressed p2mm_servercommand:command:script RemoveLap()", 0.1)

        Entities.FindByName(null, "win_door_1_orange").__KeyValueFromString("targetname", "win_door_1_orange_override")
        Entities.FindByName(null, "win_door_1_blue").__KeyValueFromString("targetname", "win_door_1_blue_override")

        Entities.FindByName(null, "rounds").Destroy()

    }

    if (MSPostPlayerSpawn) {

    }

    if (MSOnPlayerJoin) {

    }

    if (MSLoop) {

        for (local p; p = Entities.FindByClassnameWithin(p, "player", Vector(2165, -2195, 368), 128);) {

            local playerclass = FindPlayerClass(p)

            try { playerclass.GelocityCheckPoint } catch(e) {
                playerclass.GelocityCheckPoint <- 2
                p.SetOrigin(Vector(2164, -1866, -191))
                p.SetAngles(0, 90, 0)
            }

            if (playerclass.GelocityCheckPoint == 0) {
                p.SetOrigin(Vector(2164, -1866, -191))
                p.SetAngles(0, 90, 0)
            }

            if (playerclass.GelocityCheckPoint == 1) {
                p.SetOrigin(Vector(-3329, 1250, 386))
                p.SetAngles(0, -180, 0)
            }

            if (playerclass.GelocityCheckPoint == 2) {
                p.SetOrigin(Vector(-5363, -3072, 64))
                p.SetAngles(0, 0, 0)
            }
        }

        local FinishLinePlayer = CreateTrigger("player", 1892.304077, -1919.934570, -294.686737, 2472.500732, -1682.512573, 163.864502)
        foreach (player in FinishLinePlayer) {
            for (local p; p = Entities.FindByClassname(p, "player");) {
                local playerclass = FindPlayerClass(p)
                try { playerclass.GelocityCheckPoint } catch(e) { playerclass.GelocityCheckPoint <- 2 }
            }
            local playerclass = FindPlayerClass(player)
            if (playerclass.GelocityCheckPoint == 2) {
                playerclass.GelocityCheckPoint <- 0
                printl("Player " + player.GetName() + " reached the finish line!")
                Lap(player)
            }
        }
        local Checkpoint1 = CreateTrigger("player", -3131.35, 1598.79, -423.305, -3868.24, 814.012, 801.228)
        foreach (player in Checkpoint1) {
            local playerclass = FindPlayerClass(player)
            if (playerclass.GelocityCheckPoint == 0) {
                playerclass.GelocityCheckPoint <- 1
                printl("Player " + player.GetName() + " reached checkpoint 1!")
            }
        }
        local Checkpoint2 = CreateTrigger("player", -4878.03, -3548.62, 602.766, -5098.68, -2747.39, -235.222)
        foreach (player in Checkpoint2) {
            local playerclass = FindPlayerClass(player)
            if (playerclass.GelocityCheckPoint == 1) {
                playerclass.GelocityCheckPoint <- 2
                printl("Player " + player.GetName() + " reached checkpoint 2!")
            }
        }
    }
}