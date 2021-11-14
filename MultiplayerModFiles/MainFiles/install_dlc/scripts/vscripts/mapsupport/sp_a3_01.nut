// ██████╗██████╗             █████╗ ██████╗             █████╗   ███╗  
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗ ████║  
//╚█████╗ ██████╔╝           ███████║ █████╔╝           ██║  ██║██╔██║  
// ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██║  ██║╚═╝██║  
//██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗╚█████╔╝███████╗
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝ ╚════╝ ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        // Here if we need to ent_fire something
        //EntFireByHandle(Entities.FindByName(null, "NAME"), "ACTION", "VALUE", DELAYiny, ACTIVATOR, CALLER)
        // Destroy objects
        Entities.FindByName(null, "transition_trigger").Destroy()
        Entities.FindByClassnameNearest("logic_auto", Vector(-10304, 2544, 112), 20).Destroy()
        OnlyOnceSp_A3_01 <- true
    }

    if (MSPostPlayerSpawn==true) {
        EntFireByHandle(Entities.FindByName(null, "global_ents-proxy"), "OnProxyRelay8", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "knockout_start"), "Trigger", "", 1, null, null)

        printl("Ran")
        Sp_A3_01Viewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
        Sp_A3_01Viewcontrol.__KeyValueFromString("targetname", "Sp_A3_01Viewcontrol")
        Sp_A3_01Viewcontrol.__KeyValueFromString("target_team", "-1")
        Sp_A3_01Viewcontrol.SetOrigin(Entities.FindByName(null, "knockout-viewcontroller").GetOrigin())
        Sp_A3_01Viewcontrol.SetAngles(0, 270, 0)
        EntFire("Sp_A3_01Viewcontrol", "setparent", "knockout-viewcontroller", 0, null)
        EntFire("Sp_A3_01Viewcontrol", "setparentattachment", "knockout-viewcontroller", 0, null)
        EntFire("Sp_A3_01Viewcontrol", "enable", "", 0, null)
        EntFire("Sp_A3_01ViewcontrolTele", "disable", "", 13, null)
        EntFire("Sp_A3_01Viewcontrol", "addoutput", "targetname Sp_A3_01ViewcontrolTele", 0.25, null)
        EntFire("Sp_A3_01ViewcontrolTele", "addoutput", "targetname Sp_A3_01ViewcontrolDone", 13.30, null)
    }

    if (MSLoop==true) {

        if (Entities.FindByName(null, "Sp_A3_01ViewcontrolTele")) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(-162, -1966, 20))
            }
        }

        if (OnlyOnceSp_A3_01 == true) {
            if (Entities.FindByName(null, "Sp_A3_01ViewcontrolDone")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(-720, -1852, 10))
                    p.SetAngles(0, 90, 0)
                    Entities.FindByName(null, "knockout-viewcontroller-prop").Destroy()
                    Entities.FindByName(null, "knockout-portalgun").Destroy()
                }
                OnlyOnceSp_A3_01 <- false
            }
        }

        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(6016, 4496, -448), 100)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a3_03")
        }
    }
}