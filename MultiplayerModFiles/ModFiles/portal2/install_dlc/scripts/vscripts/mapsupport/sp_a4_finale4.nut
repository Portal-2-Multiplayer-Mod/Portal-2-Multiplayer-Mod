//  ██████╗██████╗             █████╗   ██╗██╗           ███████╗██╗███╗  ██╗ █████╗ ██╗     ███████╗  ██╗██╗
// ██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ██╔════╝██║████╗ ██║██╔══██╗██║     ██╔════╝ ██╔╝██║
// ╚█████╗ ██████╔╝           ███████║██╔╝ ██║           █████╗  ██║██╔██╗██║███████║██║     █████╗  ██╔╝ ██║
//  ╚═══██╗██╔═══╝            ██╔══██║███████║           ██╔══╝  ██║██║╚████║██╔══██║██║     ██╔══╝  ███████║
// ██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗██║     ██║██║ ╚███║██║  ██║███████╗███████╗╚════██║
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝╚═╝     ╚═╝╚═╝  ╚══╝╚═╝  ╚═╝╚══════╝╚══════╝     ╚═╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        // Here if we need to ent_fire something
        //EntFireByHandle(Entities.FindByName(null, "NAME"), "ACTION", "VALUE", DELAYiny, ACTIVATOR, CALLER)
        // Destroy objects
        //Entities.FindByName(null, "NAME").Destroy()
        Entities.FindByName(null, "light_dynamic_moon").SetOrigin(Vector(-1129.962646, -674.902405, -457.062744))
        Entities.FindByName(null, "light_dynamic_moon").SetAngles(-4.563643, 65.281807, 0.000000)
        Entities.FindByName(null, "light_dynamic_moon").__KeyValueFromString("lightfov", "160")
        Entities.FindByName(null, "light_dynamic_moon").__KeyValueFromString("lightworld", "1")
        Entities.FindByName(null, "light_dynamic_moon").__KeyValueFromString("spawnflags", "2")

        Entities.FindByName(null, "@arrival_video_master").SetOrigin(Vector(574.587524, -30.347410, 235.043121))
        Entities.FindByName(null, "@arrival_video_master").__KeyValueFromString("moviefilename", "media/sp_30_a4_finale5.bik")
        Entities.FindByName(null, "@arrival_video_master").__KeyValueFromString("width", "256")
        Entities.FindByName(null, "@arrival_video_master").__KeyValueFromString("height", "128")
        Entities.FindByName(null, "@arrival_video_master").__KeyValueFromString("forcedslave", "0")
        Entities.FindByName(null, "@arrival_video_master").__KeyValueFromString("forceprecache", "0")
        Entities.FindByName(null, "@arrival_video_master").__KeyValueFromString("looping", "0")
        Entities.FindByName(null, "@arrival_video_master").__KeyValueFromString("stretch", "0")
        Entities.FindByName(null, "@arrival_video_master").__KeyValueFromString("targetname", "p2mppenis")






        Entities.FindByName(null, "transition_portal1").Destroy()
        Entities.FindByName(null, "transition_portal2").Destroy()
        //Entities.FindByName(null, "@clientcommand").Destroy()
        Entities.FindByName(null, "credits").Destroy()

        Entities.FindByName(null, "ending_playmovie").__KeyValueFromString("targetname", "ending_playmovie_p2mp_override")
        Entities.FindByName(null, "credits_music").__KeyValueFromString("targetname", "credits_music_meme")
        
        EntFire("container_path2", "addoutput", "OnPass ending_playmovie_p2mp_override:playmovieforallplayers::2")
        memeplaymovie <- Entities.CreateByClassname("logic_playmovie")
        memeplaymovie.__KeyValueFromString("targetname", "credits_playmovie_p2mp")
        memeplaymovie.__KeyValueFromString("MovieFilename", "sp_credits_bg")
        memeplaymovie.__KeyValueFromString("loopvideo", "1")
        memeplaymovie.__KeyValueFromString("fadeintime", "1")
        EntFire("container_path2", "addoutput", "OnPass credits_playmovie_p2mp:PlayLevelTransitionMovie::131")
        EntFire("container_path2", "addoutput", "OnPass credits_music_meme:playsound::131.2")
        memeplaymovie2 <- Entities.CreateByClassname("logic_playmovie")
        memeplaymovie2.__KeyValueFromString("targetname", "after_credits_playmovie_p2mp")
        memeplaymovie2.__KeyValueFromString("MovieFilename", "sp_ending_callback")
        EntFire("container_path2", "addoutput", "OnPass after_credits_playmovie_p2mp:playmovieforallplayers::272")
        
        memeplaymovie23 <- Entities.CreateByClassname("logic_playmovie")
        memeplaymovie23.__KeyValueFromString("targetname", "after_credits_playmovie_p2mp_loop")
        memeplaymovie23.__KeyValueFromString("MovieFilename", "menu_act05")

        EntFire("container_path2", "addoutput", "OnPass after_credits_playmovie_p2mp_loop:playmovieforallplayers::317")

        memecounter <- Entities.CreateByClassname("point_servercommand")
        memecounter.__KeyValueFromString("targetname", "point_servercommand_credits_counter")
        EntFire("container_path2", "addoutput", "OnPass point_servercommand_credits_counter:command:changelevel mp_coop_lobby_3:320")
        


        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "notinelevator")
        EntFire("breaker_socket_button", "addoutput", "OnPressed notinelevator:kill", 0, null)
        
        EntFire("@core01", "addoutput", "OnPlayerPickup @core01:disablepickup", 0, null)
        EntFire("@core01", "addoutput", "OnPlayerDrop @core01:enablepickup", 0, null)

        EntFire("@core02", "addoutput", "OnPlayerPickup @core02:disablepickup", 0, null)
        EntFire("@core02", "addoutput", "OnPlayerDrop @core02:enablepickup", 0, null)

        EntFire("@core03", "addoutput", "OnPlayerPickup @core03:disablepickup", 0, null)
        EntFire("@core03", "addoutput", "OnPlayerDrop @core03:enablepickup", 0, null)

        OneTimeRenableViewControl <- false

        local ent = null
        while (ent = Entities.FindByClassname(ent, "func_portal_detector")) {
            ent.__KeyValueFromString("CheckAllIDs", "1")
            //printl("Found func_portal_detector")
            EntFireByHandle(ent, "addoutput", "OnStartTouchPortal ReEnableViewControl:kill::3", 0, null, null)
        }

        Sp_A2_CoreViewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
        Sp_A2_CoreViewcontrol.__KeyValueFromString("target_team", "-1")
        Sp_A2_CoreViewcontrol.__KeyValueFromString("targetname", "Sp_A2_CoreViewcontrol")
        Sp_A2_CoreViewcontrol.__KeyValueFromString("fov", "75")
        EntFireByHandle(Sp_A2_CoreViewcontrol, "setparent", "ending_vehicle", 0.1, null, null)
        EntFireByHandle(Sp_A2_CoreViewcontrol, "setparentattachment", "eyes", 0.2, null, null)

        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "DummyObjectWheatlyLook")
        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "DummyObjectWheatlyLookOn")
        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "ReEnableViewControl")
        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "rollcameracontrol")


        WatchPlayerWheatley <- true
        DoDestroyDummy <- true
        socketnum <- 1
        EntFire("core_hit_trigger", "addoutput", "OnTrigger DummyObjectWheatlyLook:kill", 0, null)
        EntFire("wheatley_lookat_player_relay", "addoutput", "OnTrigger DummyObjectWheatlyLookOn:kill", 0, null)

        Entities.FindByClassnameNearest("trigger_once", Vector(0, -384, 96), 350).__KeyValueFromString("targetname", "topofelevator")
        Sp_A4_Finale4ElevatorTeleport <- true
        Sp_A4_Finale4ElevatorTopTeleport <- true
        parentthingerdinger <- true
        NewSpawnPoint <- false
        local ent = null
        while (ent = Entities.FindByName(ent, "breaker_hatch_door")) {
            ent.__KeyValueFromInt("forceclosed", 1)
        }
    }

    if (MSPostPlayerSpawn==true) {

    }

    if (MSOnPlayerJoin==true) {
        // Find all players
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            //EntFireByHandle(clientcommand, "Command", "r_flashlightbrightness 0.1", 0, p, p)
            //EntFireByHandle(p, "setfogcontroller", "@environment_mines_fog", 0, null, null)
            EntFire("Sp_A2_CoreViewcontrol", "disable")
        }
    }

    if (MSLoop==true) {
        
        // CUTSCENE
        if (Entities.FindByName(null, "ending_vehicle")) {

            if (!Entities.FindByName(null, "rollcameracontrol")) {
                if (Entities.FindByName(null, "ReEnableViewControl")) {
                    local player = null
                    while (player = Entities.FindByClassname(player, "player")) {
                        player.SetOrigin(Vector(529, 73, -1))
                        player.SetAngles(-83.8, 191.2, 0)
                    }
                }
            }

            if (!Entities.FindByName(null, "ReEnableViewControl")) {
                EntFireByHandle(Sp_A2_CoreViewcontrol, "enable", "", 0, null, null)
                if (OneTimeRenableViewControl == false) {
                    OneTimeRenableViewControl <- true
                    EntFireByHandle(Sp_A2_CoreViewcontrol, "setparent", "chell", 55.15, null, null)
                    EntFireByHandle(Sp_A2_CoreViewcontrol, "setparentattachment", "vehicle_driver_eyes", 55.25, null, null)
                    local p = null
                    while (p = Entities.FindByClassname(p, "player")) {
                        EntFireByHandle(clientcommand, "Command", "r_flashlightbrightness 0.1", 0, p, p)
                    }
                }
            }

            if (parentthingerdinger) {
            parentthingerdinger <- false
                // make players invisible
                local player = null
                while (player = Entities.FindByClassname(player, "player")) {
                    player.__KeyValueFromInt("renderamt", 0)
                    player.__KeyValueFromInt("renderfx", 0)
                    EntFireByHandle(player, "disabledraw", "", 0, null, null)
                }
                EntFire("rollcameracontrol", "kill", "", 16.1, null)
                EntFireByHandle(Sp_A2_CoreViewcontrol, "disable", "", 16, null, null)
                EntFireByHandle(Sp_A2_CoreViewcontrol, "enable", "", 0.3, null, null)
                EntFireByHandle(Sp_A2_CoreViewcontrol, "setparent", "ending_vehicle", 0.1, null, null)
                EntFireByHandle(Sp_A2_CoreViewcontrol, "setparentattachment", "vehicle_driver_eyes", 0.2, null, null)
            }
        }



        //

        EntFire("@core01", "addoutput", "OnPlayerPickup @core01:disablepickup", 0, null)
        EntFire("@core01", "addoutput", "OnPlayerDrop @core01:enablepickup", 0, null)

        EntFire("@core02", "addoutput", "OnPlayerPickup @core02:disablepickup", 0, null)
        EntFire("@core02", "addoutput", "OnPlayerDrop @core02:enablepickup", 0, null)

        EntFire("@core03", "addoutput", "OnPlayerPickup @core03:disablepickup", 0, null)
        EntFire("@core03", "addoutput", "OnPlayerDrop @core03:enablepickup", 0, null)

        // WHEATLEY LOOK
        try {
            FoundPlayerNextToPortalspa4finale4 <- false
            GlobalDistanceScorespa4finale4 <- 999999
            playerpointerfinale4 <- null
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                if (Entities.FindByClassnameNearest("prop_portal", p.GetOrigin(), 100)) {
                    FoundPlayerNextToPortalspa4finale4 <- true
                    local entcoords = Entities.FindByName(null, "wheatley_bottom_swivel").GetOrigin()
                    local playercoords = p.GetOrigin()

                    playercoords = Vector(UnNegative(playercoords.x), UnNegative(playercoords.y), UnNegative(playercoords.z))
                    entcoords = Vector(UnNegative(entcoords.x), UnNegative(entcoords.y), UnNegative(entcoords.z))
                    
                    distancedistancescore <- playercoords - entcoords
                    distancedistancescore <- distancedistancescore.x + distancedistancescore.y + distancedistancescore.z

                    if (distancedistancescore < GlobalDistanceScorespa4finale4) {
                        GlobalDistanceScorespa4finale4 <- distancedistancescore
                        playerpointerfinale4 <- p.GetName()
                    }      
                }
            }

            if (Entities.FindByName(null, "wheatley_shadow_brush")) {
                local p = null
                while (p = Entities.FindByClassnameWithin(p, "player", Vector(855, 256, 64), 150)) {
                    playerpointerfinale4 <- p.GetName()
                }
            }
            

            if (!Entities.FindByName(null, "DummyObjectWheatlyLook")) {
                printl("DummyObjectWheatlyLook not found running objective")
                Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "DummyObjectWheatlyLook")
                WatchPlayerWheatley <- false
                EntFireByHandle(Entities.FindByName(null, "wheatley_bottom_swivel"), "SetTargetEntity", "chassis_target", 0, null, null)
            }

            cursocket <- "socket" + socketnum + "_trigger"
            //printl(WatchPlayerWheatley)

            // if (WatchPlayerWheatley == false) {
            //     printl(cursocket)
            //     if (!Entities.FindByName(null, cursocket)) {
            //         if (DoDestroyDummy == true) {
            //             // Entities.FindByName(null, "DummyObjectWheatlyLookOn").Destroy()
            //             EntFire("DummyObjectWheatlyLookOn", "kill", "", 8, null)
            //             socketnum <- socketnum + 1
            //             DoDestroyDummy <- false
            //         }
            //     }
            // }

            if (!Entities.FindByName(null, "DummyObjectWheatlyLookOn")) {
                printl("DummyObjectWheatlyLookOn not found running objective")
                Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "DummyObjectWheatlyLookOn")
                WatchPlayerWheatley <- true
            }

            if (WatchPlayerWheatley == true) {
                if (playerpointerfinale4 == null) {
                    local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "wheatley_bottom_swivel").GetOrigin(), 10000)
                    EntFireByHandle(Entities.FindByName(null, "wheatley_bottom_swivel"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
                    EntFire("futbol_shooter", "SetTarget", ClosestPlayerMain.GetName(), 0, null)

                } else {
                    EntFireByHandle(Entities.FindByName(null, "wheatley_bottom_swivel"), "SetTargetEntity", playerpointerfinale4, 0, null, null)
                    EntFire("futbol_shooter", "SetTarget", playerpointerfinale4, 0, null)
                }
            }
        } catch (e) {}

        //
        

        if (!Entities.FindByName(null, "notinelevator")) {
            if (Sp_A4_Finale4ElevatorTeleport == true) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(1, -77, -1332))
                }
                Sp_A4_Finale4ElevatorTeleport <- false
            }
        }

        if (!Entities.FindByName(null, "topofelevator")) {
            //printl("topofelevator")
            if (Sp_A4_Finale4ElevatorTopTeleport == true) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(1, -77, 200))
                }
                Sp_A4_Finale4ElevatorTopTeleport <- false
                NewSpawnPoint <- true
            }
        }

        if (NewSpawnPoint == true) {
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-1691, -635, -2619), 500)) {
                p.SetOrigin(Vector(1, -77, 200))
            }
        }
    }
}