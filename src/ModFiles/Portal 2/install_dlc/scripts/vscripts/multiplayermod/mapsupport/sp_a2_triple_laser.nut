// ██████╗██████╗             █████╗ ██████╗            ████████╗██████╗ ██╗██████╗ ██╗     ███████╗           ██╗      █████╗  ██████╗███████╗██████╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ╚══██╔══╝██╔══██╗██║██╔══██╗██║     ██╔════╝           ██║     ██╔══██╗██╔════╝██╔════╝██╔══██╗
//╚█████╗ ██████╔╝           ███████║  ███╔═╝              ██║   ██████╔╝██║██████╔╝██║     █████╗             ██║     ███████║╚█████╗ █████╗  ██████╔╝
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝                ██║   ██╔══██╗██║██╔═══╝ ██║     ██╔══╝             ██║     ██╔══██║ ╚═══██╗██╔══╝  ██╔══██╗
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗   ██║   ██║  ██║██║██║     ███████╗███████╗██████████╗███████╗██║  ██║██████╔╝███████╗██║  ██║
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝╚══════╝╚═════════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝


if (!FutBolGamemode) {
    function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
        if (MSInstantRun) {
            GlobalSpawnClass.useautospawn <- true
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
            // Destroy objects
            Entities.FindByName(null, "door_0-close_door_rl").Destroy()
            // We should do something sussy in this map, probably something the observation room (Kinda Moja)
            Entities.FindByClassnameNearest("trigger_once", Vector(6984, -5376, 40), 1024).Destroy()
            Entities.FindByClassnameNearest("trigger_once", Vector(6912, -5376, 40), 1024).Destroy()
        }

        if (MSPostPlayerSpawn) {
            NewApertureStartElevatorFixes()
        }

        if (MSLoop) {
            // Elevator changelevel
            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(6494, -5376, -273), 50)) {

                SendToConsoleP232("changelevel sp_a2_bts1")
            }

            // Elevator env_projectedtexture
            try {
                EntFireByHandle(Entities.FindByName(null, "arrival_elevator-light_elevator_fill"), "TurnOn", "", 0, null, null)
            } catch(exception) {}
        }
    }
} else {
    futent <- null
    disp1 <- null
    disp2 <- null

    desiredscore <- 10

    CurrentlySpawningFutBol <- false
    CanSpawnFutBol <- true
    GameRunning <- false

    FutBolTeams <- [
        class {
            name = "blue"
            score = 0
        }
        class {
            name = "red"
            score = 0
        }
    ]

    function FinishingSpawnFutbolInMap() {
            EntFire("p2mm_servercommand", "command", "script CurrentlySpawningFutBol = false", 0.1)
            if (CanSpawnFutBol) {
                SpawnFutBol("futbol_in_map", Vector(7777, -5668, 225))
                SendToConsoleP232("script DecEntFireByHandle(Entities.FindByClassname(null, \"prop_glass_futbol\"), \"break\", \"\",30)")
            }
    }

    function SpawnFutbolInMap() {
        if (CanSpawnFutBol && !CurrentlySpawningFutBol) {
            CurrentlySpawningFutBol = true
            EntFire("p2mm_servercommand", "command", "script FinishingSpawnFutbolInMap()", 3)
        }
    }

        function StartGame() {
            GameRunning <- true
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                printl("Player " + p  + " has joined the game.")
                if (p.GetTeam() == 3) {
                    p.SetOrigin(Vector(8169, -5664, 64))
                    p.SetAngles(0, -180, 0)
                } else {
                    p.SetOrigin(Vector(7587, -5726,64))
                    p.SetAngles(0, 0, 0)
                }
            }
        }

    function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
        if (MSInstantRun) {
            local laser1 = Entities.FindByClassname(null, "env_portal_laser")
            local laser2 = Entities.FindByClassname(Entities.FindByClassname(null, "env_portal_laser"), "env_portal_laser")
            local laser3 = Entities.FindByClassname(Entities.FindByClassname(Entities.FindByClassname(null, "env_portal_laser"), "env_portal_laser"), "env_portal_laser")
            laser1.Destroy()
            laser3.Destroy()

            FutBolGoalText  <- Entities.CreateByClassname("game_text")
            FutBolGoalText.__KeyValueFromString("targetname", "FutBolGoalText")
            FutBolGoalText.__KeyValueFromString("x", "-1")
            FutBolGoalText.__KeyValueFromString("y", "-1")
            FutBolGoalText.__KeyValueFromString("message", "If you see this something went wrong...")
            FutBolGoalText.__KeyValueFromString("holdtime", "1")
            FutBolGoalText.__KeyValueFromString("fadeout", "1")
            FutBolGoalText.__KeyValueFromString("fadein", "1")
            FutBolGoalText.__KeyValueFromString("channel", "1")
            FutBolGoalText.__KeyValueFromString("spawnflags", "1")

            BlueGoalCounter <- Entities.CreateByClassname("game_text")
            BlueGoalCounter.__KeyValueFromString("targetname", "BlueGoalCounter")
            BlueGoalCounter.__KeyValueFromString("x", "0")
            BlueGoalCounter.__KeyValueFromString("y", "0.9")
            BlueGoalCounter.__KeyValueFromString("message", "Red: 0/" + desiredscore)
            BlueGoalCounter.__KeyValueFromString("holdtime", "500")
            BlueGoalCounter.__KeyValueFromString("fadeout", "2")
            BlueGoalCounter.__KeyValueFromString("fadein", "2")
            BlueGoalCounter.__KeyValueFromString("channel", "0")
            BlueGoalCounter.__KeyValueFromString("spawnflags", "1")
            BlueGoalCounter.__KeyValueFromString("color", "0 80 255")

            RedGoalCounter <- Entities.CreateByClassname("game_text")
            RedGoalCounter.__KeyValueFromString("targetname", "RedGoalCounter")
            RedGoalCounter.__KeyValueFromString("x", "0")
            RedGoalCounter.__KeyValueFromString("y", "0.88")
            RedGoalCounter.__KeyValueFromString("message", " Blue: 0/" + desiredscore)
            RedGoalCounter.__KeyValueFromString("holdtime", "500")
            RedGoalCounter.__KeyValueFromString("fadeout", "2")
            RedGoalCounter.__KeyValueFromString("fadein", "2")
            RedGoalCounter.__KeyValueFromString("channel", "2")
            RedGoalCounter.__KeyValueFromString("spawnflags", "1")
            RedGoalCounter.__KeyValueFromString("color", "255 100 0")

            CounterRefreshTimer <- 0

        }

        if (MSPostPlayerSpawn) {
            EntFire("p2mm_servercommand", "command", "say Game starts in 30 seconds", 0)
            EntFire("p2mm_servercommand", "command", "say Game starts in 20 seconds", 10)
            EntFire("p2mm_servercommand", "command", "say Game starts in 10 seconds", 20)
            EntFire("p2mm_servercommand", "command", "say Game starts in 5 seconds", 25)
            EntFire("p2mm_servercommand", "command", "say Game starts in 4 seconds", 26)
            EntFire("p2mm_servercommand", "command", "say Game starts in 3 seconds", 27)
            EntFire("p2mm_servercommand", "command", "say Game starts in 2 seconds", 28)
            EntFire("p2mm_servercommand", "command", "say Game starts in 1 second", 29)
            EntFire("p2mm_servercommand", "command", "say Game starting!", 30)
            EntFire("p2mm_servercommand", "command", "script StartGame()", 30)
                        DecEntFireByHandle(BlueGoalCounter, "Display", "", 0.1)
                        DecEntFireByHandle(RedGoalCounter, "Display", "",0.1)
        }

        if (MSLoop) {
            local spawnpos = Vector(7840, -5824, 64)
            local spawnangle = Vector(0, 90, 0)
            local spawnbox = Vector(11056, -4954, 134)

            if (GameRunning) {
                local p = null
                while (p = Entities.FindByClassnameNearest("player", spawnbox, 248)) {
                    p.SetOrigin(Vector(7813, -5385, 64))
                    p.SetAngles(spawnangle.x, spawnangle.y, spawnangle.z)
                }
            } else {
                 local p = null
                while (p = Entities.FindByClassnameNearest("player", spawnbox, 248)) {
                    p.SetOrigin(spawnpos)
                    p.SetAngles(0, -90, 0)
                }
            }

            if (HasSpawned) {


                if (GameRunning) {
                    if (FutBolTeams[0].score  >= desiredscore) {
                        GameRunning = false
                        CanSpawnFutBol = false
                        SendToConsoleP232("say BLUE WON THE GAME!")
                        DecEntFireByHandle(BlueGoalCounter, "SetText", "BLUE WON THE GAME!", 0.1)
                        DecEntFireByHandle(RedGoalCounter, "SetText", "BLUE WON THE GAME!", 0.1)
                        DecEntFireByHandle(BlueGoalCounter, "Display", "", 0.1)
                        DecEntFireByHandle(RedGoalCounter, "Display", "",0.1)
                    } else if (FutBolTeams[1].score  >= desiredscore) {
                        GameRunning = false
                        CanSpawnFutBol = false
                        SendToConsoleP232("say RED WON THE GAME!")
                        DecEntFireByHandle(BlueGoalCounter, "SetText", "RED WON THE GAME!", 0.1)
                        DecEntFireByHandle(RedGoalCounter, "SetText", "RED WON THE GAME!", 0.1)
                        DecEntFireByHandle(BlueGoalCounter, "Display", "", 0.1)
                        DecEntFireByHandle(RedGoalCounter, "Display", "",0.1)
                        EntFire("p2mm_servercommand", "command", "say Game Restarts In 5 Seconds", 0)
                        EntFire("p2mm_servercommand", "command", "say Game Restarts In 4  Seconds", 1)
                        EntFire("p2mm_servercommand", "command", "say Game Restarts In 3  Seconds", 2)
                        EntFire("p2mm_servercommand", "command", "say Game Restarts In 2  Seconds", 3)
                        EntFire("p2mm_servercommand", "command", "say Game Restarts In 1  Second", 4)
                        EntFire("p2mm_servercommand", "command", "portal2mpSa8t", 5)
                    }
                }

                if (GameRunning) {

                    if (CounterRefreshTimer < Time() - 2) {
                        CounterRefreshTimer = Time()
                        DecEntFireByHandle(BlueGoalCounter, "SetText", "Blue: " + FutBolTeams[0].score + "/" + desiredscore)
                        DecEntFireByHandle(RedGoalCounter, "SetText", "Red: " + FutBolTeams[1].score + "/" + desiredscore)
                        DecEntFireByHandle(BlueGoalCounter, "Display", "", 0.1)
                        DecEntFireByHandle(RedGoalCounter, "Display", "",0.1)
                    }

                    futent = Entities.FindByClassname(null, "prop_glass_futbol")
                    if (!futent) {
                        SpawnFutbolInMap()
                    }
                    disp1  = Entities.FindByName(null, "dispenser1")
                    disp2  = Entities.FindByName(null, "dispenser2")
                    // printl(futent.GetName())

                    if (disp1&& disp2&&futent&&strip(futent.GetName()) == "futbol_in_map") {
                        if (CheckFutBolGoal(0, disp1, futent)) {
                            futent.__KeyValueFromString("targetname", "futbol_in_map_done")
                            DecEntFireByHandle(futent, "disablemotion", "", 0.05)
                            EntFire("p2mm_servercommand", "command", "script futent.SetOrigin(GetGoalPoint(disp1))", 0.1)
                            EntFire("p2mm_servercommand", "command", "script CoreExplosion(futent.GetOrigin())", 0.9)
                            DecEntFireByHandle(futent, "break", "", 1)
                            DecEntFireByHandle(FutBolGoalText, "SetText", "Blue Scored!", 0)
                            DecEntFireByHandle(FutBolGoalText, "SetTextColor", "0 80 255", 0.1)
                            DecEntFireByHandle(FutBolGoalText, "Display", "", 0.2)
                            FutBolTeams[0].score <- FutBolTeams[0].score + 1

                        } else {
                        if (CheckFutBolGoal(1, disp2, futent)) {
                                futent.__KeyValueFromString("targetname", "futbol_in_map_done")
                                DecEntFireByHandle(futent, "disablemotion", "", 0.05)
                                EntFire("p2mm_servercommand", "command", "script futent.SetOrigin(GetGoalPoint(disp2))", 0.1)
                            EntFire("p2mm_servercommand", "command", "script CoreExplosion(futent.GetOrigin())", 0.9)
                                DecEntFireByHandle(futent, "break", "", 1)
                                DecEntFireByHandle(FutBolGoalText, "SetText", "Red Scored!", 0)
                                DecEntFireByHandle(FutBolGoalText, "SetTextColor", "255 100 0", 0.1)
                                DecEntFireByHandle(FutBolGoalText, "Display", "", 0.2)


                                FutBolTeams[1].score <- FutBolTeams[1].score + 1

                            }
                        }
                    }
                }
            }
        }
    }
}