// ███╗   ███╗██████╗             █████╗  █████╗  █████╗ ██████╗             ██████╗ ███████╗██╗      █████╗  █████╗ ██╗████████╗██╗   ██╗           ██████╗            ██╗   ██╗ █████╗ ██████╗
// ████╗ ████║██╔══██╗           ██╔══██╗██╔══██╗██╔══██╗██╔══██╗           ██╔════╝ ██╔════╝██║     ██╔══██╗██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝           ╚════██╗           ██║   ██║██╔══██╗╚════██╗
// ██╔████╔██║██████╔╝           ██║  ╚═╝██║  ██║██║  ██║██████╔╝           ██║  ██╗ █████╗  ██║     ██║  ██║██║  ╚═╝██║   ██║    ╚████╔╝             █████╔╝           ╚██╗ ██╔╝██║  ██║  ███╔═╝
// ██║╚██╔╝██║██╔═══╝            ██║  ██╗██║  ██║██║  ██║██╔═══╝            ██║  ╚██╗██╔══╝  ██║     ██║  ██║██║  ██╗██║   ██║     ╚██╔╝              ╚═══██╗            ╚████╔╝ ██║  ██║██╔══╝
// ██║ ╚═╝ ██║██║     ██████████╗╚█████╔╝╚█████╔╝╚█████╔╝██║     ██████████╗╚██████╔╝███████╗███████╗╚█████╔╝╚█████╔╝██║   ██║      ██║   ██████████╗██████╔╝██████████╗  ╚██╔╝  ╚█████╔╝███████╗
// ╚═╝     ╚═╝╚═╝     ╚═════════╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝     ╚═════════╝ ╚═════╝ ╚══════╝╚══════╝ ╚════╝  ╚════╝ ╚═╝   ╚═╝      ╚═╝   ╚═════════╝╚═════╝ ╚═════════╝   ╚═╝    ╚════╝ ╚══════╝

GelocityRounds <- 3
GameDoneGelocity <- false

function RoundsButtonAdd1() {
    GelocityRounds = GelocityRounds + 1
    printl(GelocityRounds)
}

function RoundsButtonRemove1() {
    GelocityRounds = GelocityRounds - 1
    printl(GelocityRounds)
}

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {

        // door_start_2_2
        // door_start_2_1
        // door_start_1_2
        // door_start_1_1

        Entities.FindByName(null, "door_start_2_2").__KeyValueFromString("targetname", "door_start_2_override")
        Entities.FindByName(null, "door_start_2_1").__KeyValueFromString("targetname", "door_start_1_override")
        Entities.FindByName(null, "door_start_1_2").__KeyValueFromString("targetname", "door_start_2_override")
        Entities.FindByName(null, "door_start_1_1").__KeyValueFromString("targetname", "door_start_1_override")

        EntFire("door_start_2_override", "Open", "", 0)
        EntFire("door_start_1_override", "Open", "", 0)
        EntFire("start_fizzler", "enable", "", 1)

        // Destroy door_start
        Entities.FindByName(null, "door_start").Destroy()


        printl("Yall Playing GELOCITY");
        local ent = null
        while (ent = Entities.FindByClassname(ent, "paint_sphere")) {
            EntFire(ent.GetName(), "paint", "", 0.8)
            EntFire(ent.GetName(), "kill", "", 1)
        }

        Entities.FindByName(null, "rounds_text_orange").__KeyValueFromString("targetname", "p2mm_rounds_text_override")

        EntFire("checkpoint_orange_1", "kill")
        EntFire("checkpoint_blue_1", "kill")
        RemoveAllClassname("beam_spotlight")
        RemoveAllClassname("logic_auto", 5)
        //keyframe_rope
        RemoveAllClassname("keyframe_rope")

        //RemoveAllClassname("info_target")
        RemoveAllClassnameDistance("info_target", Vector(-6797.413574, 3837.398682, -447.968750), 600)

        EntFire("rounds_button_2", "addoutput", "OnPressed p2mm_servercommand:command:script RoundsButtonAdd1()")
        EntFire("rounds_button_1", "addoutput", "OnPressed p2mm_servercommand:command:script RoundsButtonRemove1()")
    }

    if (MSPostPlayerSpawn) {
        printl("Removed: " + TotalRemovedEnts + " Entities")
    }

    if (MSLoop) {
        for (local p; p = Entities.FindByClassnameWithin(p, "player", Vector(-1150.777283, 792.685608, -191.968750), 500);) {
            local pname = p.GetName()
            if (PluginLoaded) {
                pname = GetPlayerName(p.entindex())
            }

            if (!GameDoneGelocity) {
                try {
                    local pclass = FindPlayerClass(p)
                    if (pclass.laps > GelocityRounds) {
                        GameDoneGelocity <- true
                        EntFire("orange_wins", "trigger")
                        SendToConsoleP2MM("say " + pname + " has won the game!")
                        EntFire("p2mm_rounds_text_override", "display")
                    }
                } catch(e) {
                    local pclass = FindPlayerClass(p)
                    printl("No Gelocity player class parts found! Creating...")
                    pclass.hitcheckpoint <- true
                    pclass.laps <- 0
                }
            }
        }

        if (!GameDoneGelocity) {
            // Finish Line
            for (local p; p = Entities.FindByClassnameWithin(p, "player", Vector(-1150.777283, 792.685608, -191.968750), 500);) {
                local pname = p.GetName()
                if (PluginLoaded) {
                    pname = GetPlayerName(p.entindex())
                }

                local pclass = FindPlayerClass(p)
                try {
                    if (pclass.hitcheckpoint) {
                        pclass.laps <- pclass.laps + 1
                        pclass.hitcheckpoint <- false

                        printl("Lap: " + pclass.laps)

                        // Set Message Text
                        local pcolor = GetPlayerColor(p, true)

                        if (!GameDoneGelocity) {
                            Entities.FindByName(null, "p2mm_rounds_text_override").__KeyValueFromString("message", pname +" is on lap " + pclass.laps)
                            Entities.FindByName(null, "p2mm_rounds_text_override").__KeyValueFromString("color", pcolor.r.tostring() + " " + pcolor.g.tostring() + " " + pcolor.b.tostring())
                        }
                        if (!PluginLoaded) {
                            if (p.GetName() == "blue") {
                                Entities.FindByName(null, "p2mm_rounds_text_override").__KeyValueFromString("message", "player1 is on lap " + pclass.laps)
                            }
                            if (p.GetName() == "red") {
                                Entities.FindByName(null, "p2mm_rounds_text_override").__KeyValueFromString("message", "player2 is on lap " + pclass.laps)
                            }
                        }
                        EntFire("p2mm_rounds_text_override", "display")
                    }
                } catch(e) {
                    printl("No Gelocity player class parts found! Creating...")
                    pclass.hitcheckpoint <- true
                    pclass.laps <- 0
                }
            }

            // Checkpoint
            for (local p; p = Entities.FindByClassnameWithin(p, "player", Vector(-2412.738770, -2896.909912, -299.889404), 750);) {
                local pclass = FindPlayerClass(p)
                try {
                    if (!pclass.hitcheckpoint) {
                        pclass.hitcheckpoint <- true
                        printl("HitCheckpoint: " + pclass.hitcheckpoint)
                    }
                } catch(e) {
                    printl("No Gelocity player class parts found! Creating...")
                    pclass.hitcheckpoint <- true
                }
            }
        }
    }
}