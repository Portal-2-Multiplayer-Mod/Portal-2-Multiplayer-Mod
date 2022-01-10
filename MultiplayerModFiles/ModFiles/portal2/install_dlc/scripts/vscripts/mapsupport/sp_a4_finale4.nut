// ██████╗██████╗             █████╗   ██╗██╗           ███████╗██╗███╗  ██╗ █████╗ ██╗     ███████╗██████╗ 
//██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ██╔════╝██║████╗ ██║██╔══██╗██║     ██╔════╝╚════██╗    44444
//╚█████╗ ██████╔╝           ███████║██╔╝ ██║           █████╗  ██║██╔██╗██║███████║██║     █████╗ ██████████    444
// ╚═══██╗██╔═══╝            ██╔══██║███████║           ██╔══╝  ██║██║╚████║██╔══██║██║     ██╔══╝ ██████████    444
//██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗██║     ██║██║ ╚███║██║  ██║███████╗███████╗██████╔╝    44444
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝╚═╝     ╚═╝╚═╝  ╚══╝╚═╝  ╚═╝╚══════╝╚══════╝╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        // Here if we need to ent_fire something
        //EntFireByHandle(Entities.FindByName(null, "NAME"), "ACTION", "VALUE", DELAYiny, ACTIVATOR, CALLER)
        // Destroy objects
        //Entities.FindByName(null, "NAME").Destroy()
        Entities.FindByName(null, "transition_portal1").Destroy()
        Entities.FindByName(null, "transition_portal2").Destroy()
        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "notinelevator")
        EntFire("breaker_socket_button", "addoutput", "OnPressed notinelevator:kill", 0, null)
        EntFire("@core01", "addoutput", "OnPlayerPickup @core01:disablepickup", 0, null)
        EntFire("@core01", "addoutput", "OnPlayerDrop @core01:enablepickup", 0, null)

        EntFire("@core02", "addoutput", "OnPlayerPickup @core02:disablepickup", 0, null)
        EntFire("@core02", "addoutput", "OnPlayerDrop @core02:enablepickup", 0, null)

        EntFire("@core03", "addoutput", "OnPlayerPickup @core03:disablepickup", 0, null)
        EntFire("@core03", "addoutput", "OnPlayerDrop @core03:enablepickup", 0, null)

        local ent = null
        while (ent = Entities.FindByClassname(ent, "func_portal_detector")) {
            ent.__KeyValueFromString("CheckAllIDs", "1")
        }

        Sp_A2_CoreViewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
        Sp_A2_CoreViewcontrol.__KeyValueFromString("target_team", "-1")
        Sp_A2_CoreViewcontrol.__KeyValueFromString("targetname", "Sp_A2_CoreViewcontrol")
        Sp_A2_CoreViewcontrol.__KeyValueFromString("fov", "75")
        EntFireByHandle(Sp_A2_CoreViewcontrol, "setparent", "ending_vehicle", 0.1, null, null)
        EntFireByHandle(Sp_A2_CoreViewcontrol, "setparentattachment", "eyes", 0.2, null, null)

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

    if (MSLoop==true) {

        if (Entities.FindByName(null, "ending_vehicle")) {
            if (parentthingerdinger) {
            parentthingerdinger <- false
                EntFireByHandle(Sp_A2_CoreViewcontrol, "enable", "", 0.3, null, null)
                EntFireByHandle(Sp_A2_CoreViewcontrol, "setparent", "ending_vehicle", 0.1, null, null)
                EntFireByHandle(Sp_A2_CoreViewcontrol, "setparentattachment", "vehicle_driver_eyes", 0.2, null, null)
            }
        }

        EntFire("@core01", "addoutput", "OnPlayerPickup @core01:disablepickup", 0, null)
        EntFire("@core01", "addoutput", "OnPlayerDrop @core01:enablepickup", 0, null)

        EntFire("@core02", "addoutput", "OnPlayerPickup @core02:disablepickup", 0, null)
        EntFire("@core02", "addoutput", "OnPlayerDrop @core02:enablepickup", 0, null)

        EntFire("@core03", "addoutput", "OnPlayerPickup @core03:disablepickup", 0, null)
        EntFire("@core03", "addoutput", "OnPlayerDrop @core03:enablepickup", 0, null)

        // WHEATLEY LOOK
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
        if (playerpointerfinale4 == null) {
            local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "wheatley_bottom_swivel").GetOrigin(), 10000)
            EntFireByHandle(Entities.FindByName(null, "wheatley_bottom_swivel"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
            EntFire("futbol_shooter", "SetTarget", ClosestPlayerMain.GetName(), 0, null)

        } else {
            EntFireByHandle(Entities.FindByName(null, "wheatley_bottom_swivel"), "SetTargetEntity", playerpointerfinale4, 0, null, null)
            EntFire("futbol_shooter", "SetTarget", playerpointerfinale4, 0, null)
        }
        

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