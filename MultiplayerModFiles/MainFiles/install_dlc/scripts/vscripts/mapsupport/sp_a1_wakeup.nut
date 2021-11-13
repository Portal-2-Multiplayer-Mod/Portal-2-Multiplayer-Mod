// ██████╗██████╗             █████╗   ███╗              ██╗       ██╗ █████╗ ██╗  ██╗███████╗██╗   ██╗██████╗ 
//██╔════╝██╔══██╗           ██╔══██╗ ████║              ██║  ██╗  ██║██╔══██╗██║ ██╔╝██╔════╝██║   ██║██╔══██╗
//╚█████╗ ██████╔╝           ███████║██╔██║              ╚██╗████╗██╔╝███████║█████═╝ █████╗  ██║   ██║██████╔╝
// ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║               ████╔═████║ ██╔══██║██╔═██╗ ██╔══╝  ██║   ██║██╔═══╝ 
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗  ╚██╔╝ ╚██╔╝ ██║  ██║██║ ╚██╗███████╗╚██████╔╝██║     
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝   ╚═╝   ╚═╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝     

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        Entities.FindByName(null, "basement_breakers_entrance_door").Destroy()
        Entities.FindByName(null, "basement_breakers_entrance_blocker").Destroy()
        Entities.FindByName(null, "basement_breakers_entrance_blocker_trigger").Destroy()

        function elevatorrecreationsp_a1_wakeup() {
            printl("Elevator recreationsp_a1_wakeup")
            EntFire("@sphere", "DisableMotion", "", 0, null)
            Entities.FindByName(null, "@sphere").SetOrigin(Vector(11357, -819, 161))
            // Sphere attach bs
            EntFire("@sphere", "EnableMotion", "", 0.7, null)
            EntFire("@sphere", "setparent", "core_receptacle_socket", 1.1, null)
            EntFire("@sphere", "setparentattachment", "sphere_attach", 1.5, null)
            EntFire("spark_glados_fuse_place", "SparkOnce", "", 1.5, null)
            EntFire("@sphere", "PlayAttach", "", 2, null)
            EntFire("@sphere", "AddContext", "socket_name:$socket_context", 1.5, null)
            EntFire("core_receptacle_socket", "setanimation", "attach", 2, null)

            // SpA1Wakeup viewcontrols
            SpA1WakeupViewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
            SpA1WakeupViewcontrol.__KeyValueFromString("targetname", "SpA1WakeupViewcontrol")
            SpA1WakeupViewcontrol.__KeyValueFromString("target_team", "-1")
            SpA1WakeupViewcontrol.SetOrigin(Vector(8976, 1119, -412))
            SpA1WakeupViewcontrol.SetAngles(27, -90, 0)
            EntFire("SpA1WakeupViewcontrol", "setparent", "core_receptacle_socket", 0, null)
            EntFire("SpA1WakeupViewcontrol", "enable", "", 0.8, null)
            EntFire("SpA1WakeupViewcontrol", "disable", "", 28, null)
            EntFire("TPPLAYERS1", "addoutput", "targetname TPPLAYERS2", 27.8, null)

            SpA1WakeupViewcontrol2 <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
            SpA1WakeupViewcontrol2.__KeyValueFromString("targetname", "SpA1WakeupViewcontrol2")
            SpA1WakeupViewcontrol2.__KeyValueFromString("target_team", "-1")
            SpA1WakeupViewcontrol2.SetOrigin(Entities.FindByName(null, "camera_ghostAnim_2").GetOrigin())
            EntFire("SpA1WakeupViewcontrol2", "setparent", "camera_ghostAnim_2", 0.50, null)
            EntFire("SpA1WakeupViewcontrol2", "enable", "", 74, null)
            EntFire("SpA1WakeupViewcontrol2", "disable", "", 108, null)
            EntFire("TPPLAYERS2", "addoutput", "targetname TPPLAYERS3", 74, null)
            EntFire("TPPLAYERS3", "addoutput", "targetname TPPLAYERS4", 108, null)
            // Ent_fire PIT OF PAIN AND AGONY !!!!!!!

            EntFire("glados_postwake_soundscape", "Enable", "", 2, null)
            EntFire("glados_prewake_soundscape", "Disable", "", 2, null)
            EntFire("basement_breakers_platform_clipping", "Enable", "", 2, null)

            EntFire("basement_breakers_upper_blocker", "Enable", "", 2, null)
            EntFire("@sphere", "SetIdleSequence", "sphere_plug_idle_neutral", 2, null)
            EntFire("breaker_blocker_brush", "Disable", "", 2, null)
            EntFire("@sphere", "SpeakResponseConcept", "TLK_SOCKET_POWERED", 2.1, null)
            EntFire("@sphere", "PlayLock", "", 3.50, null)
            EntFire("aud_World.LightPowerOnLg", "PlaySound", "", 3.60, null)
            EntFire("breaker_elevator_spotlight_2", "TurnOn", "", 3.60, null)
            EntFire("basement_breakers_clack", "PlaySound", "", 3.60, null)
            EntFire("music_breakers_start", "PlaySound", "", 4, null)
            EntFire("basement_breakers_start", "Trigger", "", 4, null)

            Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "TPPLAYERS1DIS")
            EntFire("TPPLAYERS1DIS", "addoutput", "targetname TPPLAYERS1", 1, null)
        }

        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)

        Entities.FindByClassnameNearest("trigger_once", Vector(8032, 1216, 487), 100).Destroy()

        Entities.FindByClassnameNearest("trigger_once", Vector(6144, 3456, 904), 100).Destroy()

        Entities.FindByName(null, "do_not_touch_anything_trigger").Destroy()

        Entities.FindByName(null, "basement_breaker_room_entry_trigger").Destroy()

        Entities.FindByName(null, "basement_breakers_socket_trigger").Destroy()

        SpA1WakeupONCE1 <- true
        SpA1WakeupONCE2 <- true
        SpA1WakeupONCE3 <- true
        NOLLFIX <- true
        TPP1 <- true
        TPP2 <- true
        TPP3 <- true
        TPP4 <- true

        SpA1WakeupPostPlayerSpawn <- true

        Entities.FindByName(null, "@basement_entry_portal_black").Destroy()
        Entities.FindByClassnameNearest("func_areaportalwindow", Vector(10364, 1080, -216), 100).__KeyValueFromString("FadeStartDist", "1750")
        Entities.FindByClassnameNearest("func_areaportalwindow", Vector(10364, 1080, -216), 100).__KeyValueFromString("FadeDist", "1950")
        Entities.FindByClassnameNearest("func_areaportalwindow", Vector(10364, 1080, -216), 100).__KeyValueFromString("targetname", "incinerator_portal_custom")
    }

    if (MSPostMapSpawn==true) {

    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
        SpA1WakeupPostPlayerSpawn <- false
    }

        if (MSLoop==true) {
            if (TPP1==true) {
                if (Entities.FindByName(null, "TPPLAYERS1")) {
                    local p = null
                    while (p = Entities.FindByClassname(p, "player")) {
                        p.SetOrigin(Vector(8548, 1204, 106))
                        p.SetVelocity(Vector(0, 0, 0))
                    }
                    TPP1 <- false
            }
        }

        if (TPP2==true) {
            if (Entities.FindByName(null, "TPPLAYERS2")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(8947, 1062, 451))
                    p.SetVelocity(Vector(0, 0, 0))
                    p.SetAngles(20, 40, 0)
                }
                TPP2 <- false
            }
        }

        if (TPP3==true) {
            if (Entities.FindByName(null, "TPPLAYERS3")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(8548, 1204, 106))
                    p.SetVelocity(Vector(0, 0, 0))
                    p.SetAngles(20, 40, 0)
                }
                TPP3 <- false
            }
        }

        if (TPP4==true) {
            if (Entities.FindByName(null, "TPPLAYERS4")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(10366, 1215, 486))
                    p.SetVelocity(Vector(0, 0, 0))
                    p.SetAngles(90, 0, 0)
                }
                TPP4 <- false
            }
        }

            if (NOLLFIX==true) {
                if (Entities.FindByName(null, "Startelevatorrecreationsp_a1_wakeup")) {
                    elevatorrecreationsp_a1_wakeup()
                    NOLLFIX <- false
                }
            }

            if (SpA1WakeupONCE3 == true) {
                local p = null
                while (p = Entities.FindByClassnameWithin(p, "player", Vector(8976.9541015625, 1085.8822021484, -435.20544433594), 33.199999332428)) {
                    EntFire("@glados", "RunScriptCode", "sp_a1_wakeup_Do_Not_Touch()", 0, null)
                    EntFire("basement_breakers_entrance_door", "Close", "", 0, null)
                    EntFire("basement_breakers_entrance_blocker_trigger", "Enable", "", 0, null)
                    EntFire("basement_breakers_clack", "PlaySound", "", 1.60, null)

                    Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "NOLLENTITY")
                    EntFire("NOLLENTITY", "addoutput", "targetname Startelevatorrecreationsp_a1_wakeup", 25, null)
                    SpA1WakeupONCE3 <- false
                }
            }

            if (SpA1WakeupONCE2 == true) {
                local p = null
                while (p = Entities.FindByClassnameWithin(p, "player", Vector(9377, 1344, -415), 33.199999332428)) {
                    EntFire("basement_breakers_prop_0", "SetAnimation", "breaker_shaft_open_hatch", 0, null)
                    EntFire("light_orange_glados", "TurnOn", "", 0, null)
                    EntFire("basement_breakers_open_wav", "PlaySound", "", 0, null)
                    EntFire("@glados", "RunScriptCode", "sp_a1_wakeup_This_Is_Breaker_Room()", 0, null)
                    EntFire("breaker_bottom_light", "TurnOn", "", 0.10, null)
                    SpA1WakeupONCE2 <- false
                }
            }

        if (SpA1WakeupPostPlayerSpawn == true) {
            try {
            Entities.FindByName(null, "@sphere").ConnectOutput("OnPlayerPickup","disablewheatleyplayerpickup")
            Entities.FindByName(null, "@sphere").ConnectOutput("OnPlayerDrop","enablewheatleyplayerpickup")
            } catch(exception) { }

            Entities.FindByName(null, "@sphere").SetOrigin(Vector(6975, 561, 412))
        }

        // Find all players within 100 units of 8032 1216 487
        local p = null
        while (p = Entities.FindByClassnameWithin(p, "player", Vector(8032, 1216, 487), 100)) {
            if (SpA1WakeupONCE1 == true) {
                printl("Wakeup sequence started")
                EntFire("@glados", "runscriptcode", "sp_a1_wakeup_gantry_door_open()", 0, null)
                EntFire("training_door", "open", "", 0, null)
                SpA1WakeupONCE1 <- false
            }
        }

        // Find all players within 100 units of 6977, 493, 572
        local p = null
        while (p = Entities.FindByClassnameWithin(p, "player", Vector(6976, 568, 521), 225)) {
            if (p.GetOrigin().z >= 450) {
                printl("Player is in the elevator")
                if (p.GetTeam()==2) {
                    p.SetOrigin(Vector(6926, 398, 410))
                } else {
                    p.SetOrigin(Vector(7026, 398, 410))
                }
                p.SetAngles(5, 90, 0)
            }
        }

        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(6144, 3456, 904), 120)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a2_intro")
        }
    }
}