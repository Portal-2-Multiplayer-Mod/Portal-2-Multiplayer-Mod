LastCoordGetPlayer <- null
CoordsAlternate <- false
PreviousTime01Sec <- 0
MinecraftMode <- false
setspot <- Vector(0, 0, 250) //Vector(5107, 3566, -250)

function loop() {

    //## Event List ##//
    if (EventList.len() > 0) {
        SendToConsole("script " + EventList[0])
        EventList.remove(0)
    }

    //## Hook player join ##//
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        if (p.ValidateScriptScope()) {
            local script_scope = p.GetScriptScope()
            // If player hasn't joined yet / hasn't been spawned / colored yet
            if (!("Colored" in script_scope)) {
                // Run player join code
                OnPlayerJoin(p, script_scope)
            }
        }
    }

    //## PotatoIfy loop ##//
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        local currentplayerclass = FindPlayerClass(p)
        if (currentplayerclass.potatogun == true) {
            PotatoIfy(p)
        }
        if (currentplayerclass.potatogun == false) {
            UnPotatoIfy(p)
        }
    }
    // Also update everyones class if PermaPotato is on
    if (PermaPotato == true) {
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            local currentplayerclass = FindPlayerClass(p)
            currentplayerclass.potatogun <- true
        }
    }
    if (PermaPotato == false) {
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            local currentplayerclass = FindPlayerClass(p)
            currentplayerclass.potatogun <- false
        }
    }

    //## Update eye angles ##//
    if (CoordsAlternate == false) {
        // Alternate so our timings space out correctly
        if (LastCoordGetPlayer != null) {
            LastCoordGetPlayer <- Entities.FindByClassname(LastCoordGetPlayer, "player")
        } else {
            LastCoordGetPlayer <- Entities.FindByClassname(null, "player")
        }
        if (LastCoordGetPlayer != null) {
            EntFireByHandle(measuremovement, "SetMeasureTarget", LastCoordGetPlayer.GetName(), 0.0, null, null)
            // Alternate so our timings space out correctly
            CoordsAlternate <- true
        }
    } else {
        if (LastCoordGetPlayer != null && Entities.FindByName(null, "p232_logic_measure_movement")) {
            local currentplayerclass = FindPlayerClass(LastCoordGetPlayer)
            if (currentplayerclass != null) {
                if (OriginalAngle == null && CanCheckAngle == true) {
                    OriginalAngle <- measuremovement.GetAngles()
                    //OriginalAngle + Vector(6.969, 4.69420, 6.9420)
                    Entities.FindByClassname(null, "player").SetAngles(OriginalAngle.x + 6.969, OriginalAngle.y + 4.69420, OriginalAngle.z + 6.9420)
                }

                currentplayerclass.eyeangles <- measuremovement.GetAngles()
                currentplayerclass.eyeforwardvector <- measuremovement.GetForwardVector()
            }
        }
        // Alternate so our timings space out correctly
        CoordsAlternate <- false
    }
    // Print out the data
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        local currentplayerclass = FindPlayerClass(p)
        if (currentplayerclass != null) {
            //printl("player" + p.entindex() + "'s angles " + currentplayerclass.eyeangles)
            //printl("player" + p.entindex() + "'s vector " + currentplayerclass.eyeforwardvector)
        }
    }

    //## Update Portal Gun names ##//
    local ent = null
    while (ent = Entities.FindByClassname(ent, "weapon_portalgun")) {
        // if it doesnt have a name yet
        if (ent.GetName() == "") {
            // Set The Name Of The Portalgun
            ent.__KeyValueFromString("targetname", "weapon_portalgun_player" + ent.GetRootMoveParent().entindex())
        }
    }

    //## Nametags ##//
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        local currentplayerclass = FindPlayerClass(p)
        if (currentplayerclass != null) {

            // Get number of players in the game
            local playernums = 0
            foreach (plr in playerclasses) {
                playernums = playernums + 1
            }

            local checkcount = 1
            // Optimise search based on player count
            if (playernums <= 6) {
                checkcount = playernums
            } else {
                if (playernums <= 11) {
                    checkcount = 6
                } else {
                    if (playernums <= 14) {
                        checkcount = 4
                    } else {
                        if (playernums <= 17) {
                            checkcount = 3
                        } else {
                            if (playernums <= 21) {
                                checkcount = 2
                            } else {
                                if (playernums <= 33) {
                                    checkcount = 1
                                }
                            }
                        }
                    }
                }
            }

            local eyeplayer = ForwardVectorTraceLine(p.EyePosition(), currentplayerclass.eyeforwardvector, 0, 10000, checkcount, 1, 32, p, "player")
            if (eyeplayer != null) {
                local clr = GetPlayerColor(eyeplayer, true)
                EntFireByHandle(nametagdisplay, "settextcolor", clr.r + " " + clr.g + " " + clr.b, 0, p, p)
                if (PluginLoaded == true) {
                    EntFireByHandle(nametagdisplay, "settext", GetPlayerName(eyeplayer.entindex()), 0, p, p)
                } else {
                    EntFireByHandle(nametagdisplay, "settext", "Player " + eyeplayer.entindex(), 0, p, p)
                }
                EntFireByHandle(nametagdisplay, "display", "", 0, p, p)
            }
        }
    }

    //## Set PlayerModel ##//
    foreach (pmodel in AssignedPlayerModels) {
        local plr = pmodel.player
        local mdlmodel = pmodel.model
        try {
            if (plr.GetModelName() != mdlmodel) {
                EntFire("p232servercommand", "command", "script Entities.FindByName(null, \"" + plr.GetName() + "\").SetModel(\"" + mdlmodel + "\")", 1)
                //SendToConsole("script Entities.FindByName(null, \"" + plr.GetName() + "\").SetModel(\"" + mdlmodel + "\")")
            }
        } catch(e) { }
    }

    //## Cache original spawn position ##//
    if (cacheoriginalplayerposition == 0 && Entities.FindByClassname(null, "player")) {
        // OldPlayerPos = the blues inital spawn position
        try {
            OldPlayerPos <- Entities.FindByName(null, "blue").GetOrigin()
            OldPlayerAngles <- Entities.FindByName(null, "blue").GetAngles()
        } catch (exception) {
            try {
                OldPlayerPos <- Entities.FindByName(null, "info_coop_spawn").GetOrigin()
                OldPlayerAngles <- Entities.FindByName(null, "info_coop_spawn").GetAngles()
            } catch (exception) {
                    try {
                        OldPlayerPos <- Entities.FindByName(null, "info_player_start").GetOrigin()
                        OldPlayerAngles <- Entities.FindByName(null, "info_player_start").GetAngles()
                    } catch(exception) {
                        OldPlayerPos <- Vector(0, 0, 0)
                        OldPlayerAngles <- Vector(0, 0, 0)
                        if (GetDeveloperLevel() == 1) {
                            printl("(P2:MM): Error: Could not cache player position. This is catastrophic!")
                        }
                        cacheoriginalplayerposition <- 1
                    }
                }
            }
        cacheoriginalplayerposition <- 1
    }

    //## Detect death ##//
    local progress = true
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        // If player is dead
        if (p.GetHealth() == 0) {
            // Put dead players in the dead players array
            foreach (player in CurrentlyDead) {
                if (player == p) {
                    progress = false
                }
            }
            if (progress == true) {
                CurrentlyDead.push(p)
                OnPlayerDeath(p)
            }
        }
    }

    //## Hook first spawn ##//
    if (PostMapLoadDone == true) {
        if (DoneWaiting == false) {
            if (CanHook == true) {
                // if (OriginalPosMain != null && OriginalPosMain.x == Entities.FindByClassname(null, "player").GetOrigin().x && OriginalPosMain.y == Entities.FindByClassname(null, "player").GetOrigin().y) {
                //     DoneWaiting <- true
                //     GeneralOneTime()
                //     printl("==============================POSITION SPAWN")
                // }

                if (Entities.FindByClassname(null, "player").GetHealth() < 200003001 || Entities.FindByClassname(null, "player").GetHealth() > 230053963) {
                    DoneWaiting <- true
                    GeneralOneTime()
                    printl("=================================HEALTH SPAWN")
                }

                // if (UnNegative(Entities.FindByName(null, "blue").GetVelocity().x) > 3 || UnNegative(Entities.FindByName(null, "blue").GetVelocity().y) > 3 || UnNegative(Entities.FindByName(null, "blue").GetVelocity().z) > 10) {
                //     DoneWaiting <- true
                //     GeneralOneTime()
                //     printl("==============================VELOCITY SPAWN")
                // }

                // if (hasbeenremoved == true && Entities.FindByName(null, "weapon_portalgun_player1")) {
                //     DoneWaiting <- true
                //     GeneralOneTime()
                //     printl("==============================PORTALGUN SPAWN")
                // }

                // if (OriginalAngle != null && FindPlayerClass(Entities.FindByName(null, "blue")).eyeangles.x == OriginalAngle.x && FindPlayerClass(Entities.FindByName(null, "blue")).eyeangles.y == OriginalAngle.y && FindPlayerClass(Entities.FindByName(null, "blue")).eyeangles.z == OriginalAngle.z) {
                //     DoneWaiting <- true
                //     GeneralOneTime()
                //     printl("==============================ANGLE SPAWN")
                // }
            }
            DoEntFire("onscreendisplaympmod", "display", "", 0.0, null, null)
        }
    }

    //## GlobalSpawnClass SetSpawn ##//
    if (GlobalSpawnClass.usesetspawn == true) {
        local p = null
        while (p = Entities.FindByClassnameWithin(p, "player", GlobalSpawnClass.setspawn.position, GlobalSpawnClass.setspawn.radius)) {
            TeleportToSpawnPoint(p, null)
        }
    }

    //## MapSupport loop ##//
    MapSupport(false, true, false, false, false, false, false)


    //## Run all custom generated props / prop related Garry's Mod code ##//
    CreatePropsForLevel(false, false, true)


    //## Config developer mode loop ##//
    if (DevModeConfig==true) {
        // Change DevMode variable based on convar "developer"
        if (GetDeveloperLevel() == 0) {
            if (StartDevModeCheck == true) {
                DevMode <- false
            }
        } else {
            DevMode <- true
        }
    }

    ////#### FUN STUFF ####////

    //## Rocket ##//
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        local currentplayerclass = FindPlayerClass(p)
        if (currentplayerclass.rocket == true) {
            if (p.GetVelocity().z <= 1) {
                EntFireByHandle(p, "sethealth", "-9999999999999999999999999999999999999999999999999", 0, p, p)
                currentplayerclass.rocket <- false
            }
        }
    }

    // Random turret models
    if (RandomTurrets == true && HasSpawned == true) {
        local ent = null
        while (ent = Entities.FindByClassname(ent, "npc_portal_turret_floor")) {
            local script_scope = ent.GetScriptScope()
            if (ent.GetTeam() != 69420) {
                local modelnumber = RandomInt(0, 2)
                if (modelnumber == 2) {
                    modelnumber = 4
                }
                ent.__KeyValueFromInt("ModelIndex", modelnumber)
                local RTurretColor = RandomColor()

                b <- RTurretColor.b
                g <- RTurretColor.g
                r <- RTurretColor.r

                local model = RandomInt(0, 2)

                if (model == 1) {
                    ent.SetModel("models/npcs/turret/turret_skeleton.mdl")
                }
                if (model == 2) {
                    ent.SetModel("models/npcs/turret/turret_backwards.mdl")
                }
                // if (model == 3) {
                //     ent.SetModel("models/npcs/turret/turret_boxed.mdl")
                // }
                // // if (model == 4) { }
                // if (model == 4) {
                //     ent.SetModel("models/npcs/turret/turret_fx_laser_gib4.mdl")
                // }


                EntFireByHandle(ent, "Color", (R + " " + G + " " + R), 0, null, null)
                ent.SetTeam(69420)
            }
        }
    }

    //## "Colored portals" ##//
    if (DevInfo == true) {
        if (DevMode == true) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                local c1 = Entities.FindByName(null, p.GetName() + "_portal-1")
                local c2 = Entities.FindByName(null, p.GetName() + "_portal-2")

                local pitch = c2.GetAngles().x
                local yaw = c2.GetAngles().y
                local roll = c2.GetAngles().z

                local x = pitch*cos(0) - yaw*sin(0)
                local y = pitch*sin(0) + yaw*cos(0)
                x = x * 10
                y = y * 10

                // printl(c1.GetName())
                // printl(x)
                // printl(y)
                // printl("========")

                local c2o = c2.GetOrigin()
                local c1o = c1.GetOrigin()

                // DebugDrawBox(origin, mins, max, r, g, b, alpha, duration)
                // Set preset colors for up to 16 clients
                switch (p.entindex()) {
                    case 1 : R <- 255; G <- 255; B <- 255; break;
                    case 2 : R <- 0,   G <- 255, B <- 0;   break;
                    case 3 : R <- 0,   G <- 0,   B <- 255; break;
                    case 4 : R <- 255, G <- 0,   B <- 0;   break;
                    case 5 : R <- 255, G <- 100, B <- 100; break;
                    case 6 : R <- 255, G <- 180, B <- 255; break;
                    case 7 : R <- 255, G <- 255, B <- 180; break;
                    case 8 : R <-   0, G <- 255, B <- 240; break;
                    case 9 : R <-  75, G <-  75, B <-  75; break;
                    case 10: R <- 100, G <-  80, B <-   0; break;
                    case 11: R <-   0, G <-  80, B <- 100; break;
                    case 12: R <- 120, G <- 155, B <-  25; break;
                    case 13: R <-   0, G <-   0, B <- 100; break;
                    case 14: R <-  80, G <-   0, B <-   0; break;
                    case 15: R <-   0, G <-  75, B <-   0; break;
                    case 16: R <-   0, G <-  75, B <-  75; break;
                }
                DebugDrawBox(c1o, Vector(-50, -50, -50), Vector(50, 50, 50), R, G, B, 10, 0);
                DebugDrawBox(c2o, Vector(-50, -50, -50), Vector(50, 50, 50), R, G, B, 10, 0);

                DebugDrawLine(c1o, p.GetOrigin(), R, G, B, true, 0)
                DebugDrawLine(c2o, p.GetOrigin(), R, G, B, true, 0)
            }
        }
    }

    /////////////////////////
    // RUNS EVERY 5 SECONDS//
    /////////////////////////
    if (Time() >= PreviousTime5Sec + 5) {
        PreviousTime5Sec = Time()
        // Color display
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            DisplayPlayerColor(p)
        }
    }

    ///////////////////////
    // RUNS EVERY SECOND //
    ///////////////////////

    if (Time() >= PreviousTime1Sec + 1) {
    PreviousTime1Sec <- Time()

    // Random portal sizes

    if (RandomPortalSize == true) {
        randomportalsize <- RandomInt(1, 100 ).tostring()
        randomportalsizeh <- RandomInt(1, 100 ).tostring()
    }

    if (RandomPortalSize == true) {
        try {
        local ent = null
        while (ent = Entities.FindByClassname(ent, "prop_portal")) {
            // printl(ent)
            // printl(ent.GetOrigin())
            // printl(ent.GetAngles())
            // printl("=================")
            ent.__KeyValueFromString("HalfWidth", randomportalsize)
            ent.__KeyValueFromString("HalfHeight", randomportalsizeh)
        }
        } catch(exception) {
            // printl("(P2:MM): Error: " + exception)
        }
        // printl("################################")
    }

    //## Detect respawn ##//
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        if (p.GetHealth() >= 1) {
            // Get the players from the dead players array
            foreach (index, player in CurrentlyDead) {
                if (player == p) {
                    CurrentlyDead.remove(index)
                    OnPlayerRespawn(p)
                }
            }
        }
    }

    //## Make players' collision elastic ##//
    EntFire("player", "addoutput", "CollisionGroup 2")
    }

    //## If not in multiplayer then disconnect ##//
    try {
        if (Entities.FindByClassname(null, "player").GetName() == "") {
            printl("(P2:MM): This is not a multiplayer session! Disconnecting client...")
            Entities.CreateByClassname("point_servercommand").__KeyValueFromString("targetname", "forcedisconnectclient")
            EntFire("forcedisconnectclient", "command", "disconnect \"You cannot play singleplayer games when Portal 2 is launched from the Multiplayer Mod launcher. Please close the game and start it from Steam.\"", 1, null)
        }
    } catch (exception) { }

    // // Following box
    // local lenp = null
    // while (lenp = Entities.FindByName(lenp, "uwu")) {
    //     local torigin = Vector(0, 0, 0)
    //     local torigin2 = Vector(0, 0, 0)
    //     local tent2 = null
    //     if (Entities.FindByName(null, "blue")) {
    //         torigin = Entities.FindByName(null, "blue").GetOrigin()
    //     }

    //     torigin2 = lenp.GetOrigin()
    //     tent2 = lenp

    //     local uwu = GetDirectionalOffset(torigin, torigin2)

    //     if (tent2 != null) {
    //         tent2.SetOrigin(torigin2 + uwu)
    //     }

    //     // printl("(P2:MM)bo: " + bxorigin)
    //     // printl("(P2:MM)boff: " + (torigin - bxorigin))
    //     // printl("(P2:MM)bof: " + bxoffset)
    //     // printl("(P2:MM)h: " + highest)

    //     // draw the box
    //     //DebugDrawBox(bxorigin, Vector(-5, -5, -5), Vector(5, 5, 5), 255, 100, 175, 150, 25)
    // }

    if ("PythonHookIs" in this) { if (PythonHookIs == true) {
        try {
            try {
                OldPyInputNum <- PyInputNum
            } catch(e) { 
                PyInputNum <- 0
                OldPyInputNum <- PyInputNum
            }
            IncludeScript("PyInput")
        } catch(e) { }
    }}

    if (HasSpawned == true && MinecraftMode) {
        if (Time() >= PreviousTime01Sec + 0.2) {
            PreviousTime01Sec = Time()

            local amt = 0

            // local ent = null
            // while (ent = Entities.FindByModel(ent, "models/props/metal_box.mdl")) {
            //     ent.Destroy()
            // }

            IncludeScript("portalcraft.nut")
            foreach (thing in PortalBlocks) {
              //  printl("thing: " + thing.name)
                if (thing.name != "AIR") {
                    local spacing = 36
                    local x = ((thing.x - PortalCapture.x) * spacing)
                    local y = ((thing.y - PortalCapture.y) * spacing)
                    local z = ((thing.z - PortalCapture.z) * spacing)
                    local colorr = 100
                    local colorg = 100
                    local colorb = 100
                    local calpha = 1
                    if (thing.name == "WATER") {
                        colorr = 0
                        colorg = 0
                        colorb = 255
                    }
                    if (thing.name == "GRASS_BLOCK") {
                        colorr = 20
                        colorg = 255
                        colorb = 100
                    }
                    if (thing.name == "DIRT") {
                        colorr = 120
                        colorg = 90
                        colorb = 00
                    }
                    if (thing.name == "STONE") {
                        colorr = 30
                        colorg = 30
                        colorb = 30
                    }
                    if (thing.name == "SAND") {
                        colorr = 150
                        colorg = 255
                        colorb = 30
                    }
                    DebugDrawBox(Vector(x + setspot.x, y + setspot.y, z + setspot.z), Vector(-16, -16, -16), Vector(16, 16, 16), colorr, colorg, colorb, calpha, 0.218)

                    amt = amt + 1
                    if (amt < 500) {
                        local ourent = Entities.FindByName(null, "minecraftblock" + amt)
                        ourent.SetOrigin(Vector(x + setspot.x, y + setspot.y, z + setspot.z))
                        EntFireByHandle(ourent, "Color", colorr + " " + colorg + " " + colorb + " " + calpha, 0, null, null)
                    }
                }
            }
        }
    }
}
oldbx <- Vector(0, 0, 0)