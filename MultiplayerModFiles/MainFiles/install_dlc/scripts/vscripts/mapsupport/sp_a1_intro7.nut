// ██████╗██████╗             █████╗   ███╗             ██╗███╗  ██╗████████╗██████╗  █████╗ ███████╗
//██╔════╝██╔══██╗           ██╔══██╗ ████║             ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗╚════██║
//╚█████╗ ██████╔╝           ███████║██╔██║             ██║██╔██╗██║   ██║   ██████╔╝██║  ██║    ██╔╝
// ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║██║╚████║   ██║   ██╔══██╗██║  ██║   ██╔╝ 
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝  ██╔╝  
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝   ╚═╝   

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (GetMapName() == "sp_a1_intro7") {
        if (MSInstantRun == true) {
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
            Entities.FindByName(null, "door_0-close_door_rl").Destroy()
            Entities.FindByName(null, "room_1_portal_activate_rl").Destroy()
            Entities.FindByName(null, "InstanceAuto9-socket_trigger").Destroy()
            Entities.FindByName(null, "bts_panel_door-LR_heavydoor_close").Destroy()
            Entities.FindByName(null, "heavy_door_backtrack_clip").Destroy()
            Entities.FindByName(null, "bts_panel_door-heavydoor_open_clip").Destroy()
            Entities.FindByName(null, "transition_airlock_door_close_rl").Destroy()
            Entities.FindByName(null, "transition_trigger").Destroy()
            Entities.FindByName(null, "portal_detector").__KeyValueFromString("CheckAllIDs", "1")

            function wheatleyhitground() {
                EntFire("@sphere", "disablepickup", "", 1.05, null)
                EntFire("@sphere", "enablepickup", "", 8, null)
                EntFire("spherebot_1_top_swivel_1", "deactivate", "", 1.01, null)
            }

            function SPSkipPanel() {
                EntFire("InstanceAuto9-sphere_socket", "setanimation", "bindpose", 2.7, null)
                myexplode2 <- Entities.CreateByClassname("npc_personality_core")
                myexplode2.__KeyValueFromString("targetname", "myexplode2")
                myexplode2.SetOrigin(Vector(-822, -523, 1269))

                myexplode <- Entities.CreateByClassname("env_ar2explosion")
                myexplode.__KeyValueFromString("targetname", "myexplode")
                myexplode.__KeyValueFromString("material", "particle/particle_noisesphere")
                myexplode.SetOrigin(Vector(-822, -523, 1269))
                EntFire("myexplode", "explode", "", 2.5, null)
                EntFire("myexplode2", "explode", "", 2.5, null)
                EntFire("myexplode2", "explode", "", 3.0, null)

                Entities.FindByName(null, "@sphere").__KeyValueFromString("targetname", "@sphereDummy")
                local mysphere = Entities.FindByName(null, "@spheredummy")

                self.PrecacheSoundScript("sphere03.sp_a2_wheatley_ows01")
                self.PrecacheSoundScript("sphere03.sp_a2_wheatley_ows02")
                self.PrecacheSoundScript("sphere03.sphere_flashlight_tour67")
                self.PrecacheSoundScript("sphere03.sp_a1_wakeup_hacking09")
                self.PrecacheSoundScript("sphere03.sp_a1_wakeup_hacking12")
                self.PrecacheSoundScript("sphere03.sp_a1_wakeup_hacking10")
                self.PrecacheSoundScript("sphere03.bw_finale4_hackworked01")
                self.PrecacheSoundScript("Portal.elevator_chime")
                self.PrecacheSoundScript("sphere03.GloriousFreedom03")
                self.PrecacheSoundScript("sphere03.bw_fire_lift03")

                self.PrecacheSoundScript("sphere03.sp_a1_intro7_hoboturret01")
                self.PrecacheSoundScript("sphere03.sp_a1_intro7_hoboturret08")
                self.PrecacheSoundScript("sphere03.sp_a1_intro7_hoboturret07")
                self.PrecacheSoundScript("sphere03.sp_a1_intro7_hoboturret05")
                self.PrecacheSoundScript("sphere03.sp_a1_intro7_hoboturret06")

                EntFire("myexplode2", "addoutput", "targetname playline1", 2, null)
                EntFire("playline1", "addoutput", "targetname myexplode2", 2+ (TickSpeed * 2), null)

                EntFire("myexplode2", "addoutput", "targetname playline2", 6, null)
                EntFire("playline2", "addoutput", "targetname myexplode2", 6+ (TickSpeed * 2), null)

                EntFire("myexplode2", "addoutput", "targetname playline3", 12, null)
                EntFire("playline3", "addoutput", "targetname myexplode2", 12+ (TickSpeed * 2), null)

                EntFire("myexplode2", "addoutput", "targetname playline4", 16, null)
                EntFire("playline4", "addoutput", "targetname myexplode2", 16+ (TickSpeed * 2), null)

                EntFire("myexplode2", "addoutput", "targetname playline5", 18, null)
                EntFire("playline5", "addoutput", "targetname myexplode2", 18+ (TickSpeed * 2), null)

                EntFire("myexplode2", "addoutput", "targetname playline6", 24, null)
                EntFire("playline6", "addoutput", "targetname myexplode2", 24+ (TickSpeed * 2), null)

                EntFire("myexplode2", "addoutput", "targetname playline7", 25, null)
                EntFire("playline7", "addoutput", "targetname myexplode2", 25+ (TickSpeed * 2), null)

                EntFire("bts_panel_door-LR_heavydoor_open", "trigger", "", 25+ (TickSpeed * 2), null)

            }
        }

        if (MSPostPlayerSpawn==true) {
            NewApertureStartElevatorFixes()
        }

        if (MSLoop==true) {
            WheatleySeq1 <- false
            // Make Wheatley look at nearest player
            local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "spherebot_1_bottom_swivel_1").GetOrigin(), 10000)
            EntFireByHandle(Entities.FindByName(null, "spherebot_1_bottom_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
            EntFireByHandle(Entities.FindByName(null, "spherebot_1_top_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
            // Make Wheatley non stealable
            try {
            Entities.FindByName(null, "@sphere").ConnectOutput("OnPlayerPickup","disablewheatleyplayerpickup")
            Entities.FindByName(null, "@sphere").ConnectOutput("OnPlayerDrop","enablewheatleyplayerpickup")
            // Disable sentaint arm and disable pickup until spchill is over
            Entities.FindByName(null, "sphere_impact_trigger").ConnectOutput("OnStartTouch","wheatleyhitground")
            // Skip panel bit
            Entities.FindByName(null, "@plug_open_rl").ConnectOutput("OnTrigger","SPSkipPanel")
            } catch(exception) { }

            // Voice Lines
            if(Entities.FindByName(null, "playline1")) {
                Entities.FindByName(null, "@spheredummy").EmitSound("vo\\wheatley\\sp_a2_wheatley_ows01.wav")
                Entities.FindByName(null, "@spheredummy").EmitSound("vo\\wheatley\\sp_a2_wheatley_ows02.wav")
                printl("Played line 1")
            }

            if(Entities.FindByName(null, "playline2")) {
                Entities.FindByName(null, "@spheredummy").EmitSound("vo\\wheatley\\sphere_flashlight_tour67.wav")
                printl("Played line 2")
            }

            if(Entities.FindByName(null, "playline3")) {
                Entities.FindByName(null, "@spheredummy").EmitSound("vo\\wheatley\\sp_a1_wakeup_hacking09.wav")
                printl("Played line 3")
            }

            if(Entities.FindByName(null, "playline4")) {
                Entities.FindByName(null, "InstanceAuto9-sphere_socket").EmitSound("vo\\wheatley\\sp_a1_wakeup_hacking12.wav")
                printl("Played line 4")
            }

            if(Entities.FindByName(null, "playline5")) {
                Entities.FindByName(null, "@spheredummy").EmitSound("vo\\wheatley\\sp_a1_wakeup_hacking10.wav")
                printl("Played line 5")
            }

            if(Entities.FindByName(null, "playline6")) {
                Entities.FindByName(null, "InstanceAuto9-sphere_socket").EmitSound("ambient\\alarms\\portal_elevator_chime.wav")
                printl("Played line 6")
            }

            if(Entities.FindByName(null, "playline7")) {
                Entities.FindByName(null, "@spheredummy").EmitSound("vo\\wheatley\\bw_finale4_hackworked01.wav")
                printl("Played line 7")
            }

            if(Entities.FindByName(null, "playline8")) {
                Entities.FindByName(null, "@spheredummy").EmitSound("vo\\wheatley\\sp_a1_intro7_hoboturret01.wav")
                printl("Played line 8")
            }

            if(Entities.FindByName(null, "playline9")) {
                Entities.FindByName(null, "@spheredummy").EmitSound("vo\\wheatley\\sp_a1_intro7_hoboturret08.wav")
                printl("Played line 9")
            }

            if(Entities.FindByName(null, "playline10")) {
                Entities.FindByName(null, "@spheredummy").EmitSound("vo\\wheatley\\sp_a1_intro7_hoboturret07.wav")
                printl("Played line 10")
            }

            if(Entities.FindByName(null, "playline11")) {
                Entities.FindByName(null, "@spheredummy").EmitSound("vo\\wheatley\\sp_a1_intro7_hoboturret05.wav")
                printl("Played line 11")
            }

            if(Entities.FindByName(null, "playline12")) {
                Entities.FindByName(null, "@spheredummy").EmitSound("vo\\wheatley\\sp_a1_intro7_hoboturret06.wav")
                printl("Played line 12")
            }

            if (!Entities.FindByName(null, "seq1finished")) {
                local p = null
                while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1117, -416, 1280), 100)) {
                    Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "seq1finished")
                    printl("Sequence 1 done")
                    Entities.FindByName(null, "@spheredummy").EmitSound("vo\\wheatley\\gloriousfreedom03.wav")
                    EntFire("offrails_airlock_door_1_open_rl", "trigger", "", 0, null)
                }
            }

            if (!Entities.FindByName(null, "seq2finished")) {
                local p = null
                while (p = Entities.FindByClassnameWithin(p, "player", Vector(-2692, -404, 1280), 100)) {
                    Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "seq2finished")
                    printl("Sequence 2 done")

                    EntFire("@glados", "runscriptcode", "sp_a1_intro7_HoboTurretScene()", 0, null)

                    EntFire("myexplode2", "addoutput", "targetname playline8", 0, null)
                    EntFire("playline8", "addoutput", "targetname myexplode2", 0+ (TickSpeed * 2), null)

                    EntFire("myexplode2", "addoutput", "targetname playline9", 1.50, null)
                    EntFire("playline9", "addoutput", "targetname myexplode2", 1.50+ (TickSpeed * 2), null)

                    EntFire("myexplode2", "addoutput", "targetname playline10", 3, null)
                    EntFire("playline10", "addoutput", "targetname myexplode2", 3+ (TickSpeed * 2), null)

                    EntFire("myexplode2", "addoutput", "targetname playline11", 5, null)
                    EntFire("playline11", "addoutput", "targetname myexplode2", 5+ (TickSpeed * 2), null)

                    EntFire("myexplode2", "addoutput", "targetname playline12", 8, null)
                    EntFire("playline12", "addoutput", "targetname myexplode2", 8+ (TickSpeed * 2), null)
                }
            }

            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(-2207, 384, 1280), 100)) {
                SendToConsole("commentary 1")
                SendToConsole("changelevel sp_a1_wakeup")
            }
        }
    }
}