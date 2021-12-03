// ██████╗██████╗             █████╗   ██╗██╗           ██╗███╗  ██╗████████╗██████╗  █████╗
//██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║██╔╝ ██║           ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║███████║           ██║██║╚████║   ██║   ██╔══██╗██║  ██║
//██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        Entities.FindByName(null, "cube_bot_model").__KeyValueFromString("targetname", "moja1")
        Entities.FindByName(null, "@exit_door1-proxy").__KeyValueFromString("targetname", "moja2")
        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "StartForward", "", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(96, 768, 64), 20), "addoutput", "OnTrigger moja1:FadeAndKill", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "button_1_pressed"), "addoutput", "OnTrigger moja2:OnProxyRelay2:open", 1, null, null)
        EntFireByHandle(Entities.FindByName(null, "button_1_unpressed"), "addoutput", "OnTrigger moja2:OnProxyRelay1:close", 1, null, null)
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        Entities.FindByName(null, "@entrance_door1-close_door_rl").Destroy()
        Entities.FindByName(null, "room2_wall_close").Destroy()
        Entities.FindByName(null, "room2a_wall_close").Destroy()
        Entities.FindByName(null, "test2_end_trigger").Destroy()
        Entities.FindByName(null, "@exit_door-close_door_rl").Destroy()
        Entities.FindByName(null, "catwalk_gate1_door_right").Destroy()
        Entities.FindByName(null, "catwalk_gate1_door_left").Destroy()
        Entities.FindByName(null, "catwalk_gate2_door_right").Destroy()
        Entities.FindByName(null, "catwalk_gate2_door_left").Destroy()
        Entities.FindByName(null, "catwalk_lift_clip").Destroy()
        Entities.FindByName(null, "catwalk_lift_door").__KeyValueFromString("dmg", "100")
        Entities.FindByName(null, "test_chamber1_platform").__KeyValueFromString("dmg", "100")
        EntFire("catwalk_lift_door", "addoutput", "OnFullyOpen catwalk_lift_door:close::1.25", 0.25, null)
        EntFire("button_1_pressed", "addoutput", "OnTrigger moja3:BecomeShortcircuit::11.75", 0.25, null)
        OnlyOnceSpA4Intro <- true
        OnlyOnceSp_A4_Intro_1 <- true
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        if (!Entities.FindByClassnameNearest("trigger_once", Vector(1072, 384, 172.01), 20)) {
            if (OnlyOnceSp_A4_Intro_1==true) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(1053, 380, 185))
                    p.SetAngles(0, -180, 0)
                    p.SetVelocity(Vector(0, 0, 0))
                }
                OnlyOnceSp_A4_Intro_1 <- false
            }
        }

        // Change Spawn
        if (!Entities.FindByClassnameNearest("trigger_once", Vector(1072, 384, 172.01), 20)) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                if (p.GetOrigin().z <= 220) {
                    local canteleport = true
                    local p2 = null
                    while (p2 = Entities.FindByClassnameWithin(p2, "player", Vector(1045, 382, 210), 400)) {
                        if (p2==p) {
                            canteleport = false
                        }
                    }
                    if (canteleport==true) {
                        p.SetOrigin(Vector(1056, 384, 512))
                    }
                }
            }
        }

        // Goo Damage Code
        try {
        if (GooHurtTimerPred) { printl()}
        } catch (exception) {
            GooHurtTimerPred <- 0
        }

        if (GooHurtTimerPred<=Time()) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                if (p.GetOrigin().z<=-150) {
                    EntFireByHandle(p, "sethealth", "\"-100\"", 0, null, null)
                }
            }
            GooHurtTimerPred = Time()+1
        }
        // Change ClosedBetaTestingBox Names ;)
        local ent = null
        while (ent = Entities.FindByClassnameWithin(ent, "prop_monster_box", Vector(-58.406547546387, -59.558124542236, 187.5777130127), 400)) {
            ent.__KeyValueFromString("targetname", "moja3")
        }
        if (OnlyOnceSpA4Intro==true) {
            if (!Entities.FindByName(null, "room2_wall_open_trigger")) {
                printl("Elevator viewcontrol activated")
                // Elevator viewcontrol
                Entities.FindByName(null, "@exit_door2-close_door_rl").__KeyValueFromString("targetname", "moja4")

                EntFireByHandle(Entities.FindByName(null, "button_2_unpressed"), "addoutput", "OnTrigger moja4:Trigger", 0, null, null)

                OnlyOnceSpA4Intro <- false
            }
        }
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(3136, -128, 914), 50)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a4_tb_intro")
        }
    }
}