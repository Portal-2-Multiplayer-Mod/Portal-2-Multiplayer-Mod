// ██████╗██████╗             █████╗   ██╗██╗           ██╗███╗  ██╗████████╗██████╗  █████╗
//██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║██╔╝ ██║           ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║███████║           ██║██║╚████║   ██║   ██╔══██╗██║  ██║
//██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝

function MoveCubeDropper() {
    Entities.FindByName(null, "cube_dropper_prop").SetOrigin(Vector(1504, -640, 808))
    Entities.FindByName(null, "cube_dropper_prop").SetAngles(0, 270, 0)
    Entities.FindByName(null, "cube_dropper_box").SetOrigin(Vector(1504, -649, 1270))
    EntFireByHandle(Entities.FindByName(null, "cube_dropper_box"), "wake", "", 0, null, null)
}

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        GlobalSpawnClass.useautospawn <- true
        PermaPotato <- true
        Entities.FindByName(null, "catwalk_lift_door").__KeyValueFromString("dmg", "100")
        Entities.FindByName(null, "recapture_areaportal1").__KeyValueFromString("FadeStartDist", "1750")
        Entities.FindByName(null, "recapture_areaportal1").__KeyValueFromString("FadeDist", "1950")
        Entities.FindByName(null, "recapture_areaportal2").__KeyValueFromString("FadeStartDist", "1750")
        Entities.FindByName(null, "recapture_areaportal2").__KeyValueFromString("FadeDist", "1950")
        Entities.FindByName(null, "observation_areaportal").__KeyValueFromString("targetname", "moja1")
        Entities.FindByName(null, "cube_bot_model").__KeyValueFromString("targetname", "moja2")
        Entities.FindByName(null, "@exit_door1-proxy").__KeyValueFromString("targetname", "moja3")
        Entities.FindByName(null, "test_chamber1_platform").__KeyValueFromString("dmg", "100")
        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "StartForward", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "cube_dropper_droptrigger"), "setparent", "cube_dropper_prop", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "companion_cube_skin_trigger"), "setparent", "cube_dropper_prop", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "cube_dropper_blocker"), "setparent", "cube_dropper_prop", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "@entrance_door1-door_open_relay"), "addoutput", "OnTrigger wheatley_monitor1-relay_disable_screen:Kill::0.5", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(96, 768, 64), 20), "addoutput", "OnTrigger moja2:FadeAndKill", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_multiple", Vector(1504.01, -640, 696), 20), "setparent", "cube_dropper_prop", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "catwalk_lift_door"), "addoutput", "OnFullyClosed catwalk_lift_trigger:Enable::2", 0.25, null, null)
        EntFireByHandle(Entities.FindByName(null, "catwalk_lift_door"), "addoutput", "OnOpen catwalk_lift_trigger:Disable", 0.25, null, null)
        EntFireByHandle(Entities.FindByName(null, "catwalk_lift_door"), "addoutput", "OnFullyOpen catwalk_lift_trigger:Disable", 0.25, null, null)
        EntFireByHandle(Entities.FindByName(null, "catwalk_lift_door"), "addoutput", "OnFullyOpen catwalk_lift_door:Close::1.25", 0.25, null, null)
        EntFireByHandle(Entities.FindByName(null, "cube_test_button"), "addoutput", "OnPressed indicator_door_toggle:SetTextureIndex:1", 1, null, null)
        EntFireByHandle(Entities.FindByName(null, "cube_test_button"), "addoutput", "OnPressed moja3:OnProxyRelay2:open", 1, null, null)
        EntFireByHandle(Entities.FindByName(null, "cube_test_button"), "addoutput", "OnPressed button_1_solved:Trigger", 1, null, null)
        EntFireByHandle(Entities.FindByName(null, "button_1_unpressed"), "addoutput", "OnTrigger moja3:OnProxyRelay1:close", 1, null, null)
        // Setup function ent_fires
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1072, 384, 172.01), 20), "addoutput", "OnTrigger p232servercommand:command:script MoveCubeDropper()", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        Entities.FindByName(null, "catwalk_lift_reset_trigger").Destroy()
        Entities.FindByName(null, "@entrance_door1-close_door_rl").Destroy()
        Entities.FindByName(null, "button_1_pressed").Destroy()
        Entities.FindByName(null, "room2_wall_close").Destroy()
        Entities.FindByName(null, "room2a_wall_close").Destroy()
        Entities.FindByName(null, "test2_end_trigger").Destroy()
        Entities.FindByName(null, "@exit_door-close_door_rl").Destroy()
        Entities.FindByName(null, "catwalk_gate1_door_right").Destroy()
        Entities.FindByName(null, "catwalk_gate1_door_left").Destroy()
        Entities.FindByName(null, "catwalk_gate2_door_right").Destroy()
        Entities.FindByName(null, "catwalk_gate2_door_left").Destroy()
        Entities.FindByName(null, "catwalk_lift_clip").Destroy()
        OnlyOnceSpA4Intro <- true
        OnlyOnceSp_A4_Intro_1 <- true
        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "button_1_solved_TURRETNAMECHANGE")
        EntFire("button_1_solved", "addoutput", "OnTrigger button_1_solved_TURRETNAMECHANGE:kill::17", 0.25, null)
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
        Entities.FindByName(null, "cube_dropper_box").SetOrigin(Vector(1100, -666, 576))
        Entities.FindByName(null, "cube_dropper_prop").SetOrigin(Vector(-304.09375, -255.03125, 437.96875))
        Entities.FindByName(null, "cube_dropper_prop").SetAngles(3.4029681046377e-06, -21.125003814697, 29.531248092651)
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
        if (!Entities.FindByName(null, "button_1_solved_TURRETNAMECHANGE")) {
            local ent = null
            while (ent = Entities.FindByClassnameWithin(ent, "prop_monster_box", Vector(-58.406547546387, -59.558124542236, 187.5777130127), 800)) {
                ent.__KeyValueFromString("targetname", "button_1_solved_TURRETNAMECHANGE")
            }
        }
        if (OnlyOnceSpA4Intro==true) {
            if (!Entities.FindByName(null, "room2_wall_open_trigger")) {
                printl("Elevator viewcontrol activated")
                // Elevator viewcontrol
                Entities.FindByName(null, "@exit_door2-close_door_rl").__KeyValueFromString("targetname", "moja5")

                EntFireByHandle(Entities.FindByName(null, "button_2_unpressed"), "addoutput", "OnTrigger moja5:Trigger", 0, null, null)

                OnlyOnceSpA4Intro <- false
            }
        }
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(3136, -128, 914), 50)) {
             
            SendToConsole("changelevel sp_a4_tb_intro")
        }
    }
}