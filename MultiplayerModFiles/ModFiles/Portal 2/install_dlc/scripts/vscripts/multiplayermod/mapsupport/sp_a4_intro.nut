// ██████╗██████╗             █████╗   ██╗██╗           ██╗███╗  ██╗████████╗██████╗  █████╗
//██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║██╔╝ ██║           ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║███████║           ██║██║╚████║   ██║   ██╔══██╗██║  ██║
//██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝

function MoveCubeDropper() {
    Entities.FindByName(null, "cube_dropper_prop").SetOrigin(Vector(1504, -640, 808))
    Entities.FindByName(null, "cube_dropper_prop").SetAngles(0, 270, 0)
    Entities.FindByName(null, "cube_dropper_box_spawner_override_p232").__KeyValueFromString("targetname", "cube_dropper_box_spawner")
    EntFire("cube_dropper_box_spawner", "forcespawn", "", 0, null)
    // Entities.FindByName(null, "cube_dropper_box").SetOrigin(Vector(1504, -649, 1270))
    // EntFireByHandle(Entities.FindByName(null, "cube_dropper_box"), "wake", "", 0, null, null)
}

TrackPoints <- [
    Vector(-381.308, -375.826, 1331.84),
    Vector(-417.382, -534.446, 1232.9),
    Vector(-501.305, -648.05, 1154.88),
    Vector(-608.646, -685.323, 1098.45),
    Vector(-694.184, -660.153, 1084.98),
    Vector(-782.788, -612.837, 1095.06),
    Vector(-806.732, -549.732, 1105.68),
    Vector(-822.986, -464.889, 1091.85),
    Vector(-841.823, -371.966, 1075.54),
    Vector(-812.164, -312.363, 1065.65),
    Vector(-757.235, -227.518, 1035.1),
    Vector(-699.566, -218.069, 996.71),
    Vector(-636.23, -213.889, 957.994),
    Vector(-579.131, -250.476, 927.499),
    Vector(-538.629, -275.657, 905.835),
    Vector(-486.422, -329.301, 869.821),
    Vector(-436.1, -361.276, 806.579),
    Vector(-383.913, -369.294, 727.755),
    Vector(-337.075, -345.387, 622.686),
    Vector(-322.715, -307.829, 549.954),
   // Vector(-304.093750, -255.031250, 437.968750),
]
TrackAngles <- [
    Vector(89, -90.7127, 6.46543e-08),
    Vector(2.54727, -91.9623, -1.24232e-08),
    Vector(31.0425, -152.074, 5.44953e-07),
    Vector(-19.7277, 7.48973, 7.34825e-08),
    Vector(-6.24633, 146.764, 2.7044e-07),
    Vector(22.1075, -37.9378, 3.35715e-10),
    Vector(9.88045, 105.587, -7.90368e-08),
    Vector(8.60967, 101.473, -9.32294e-08),
    Vector(10.8479, 101.715, 1.01872e-08),
    Vector(-5.2484, -114.508, -2.69307e-08),
    Vector(-12.3971, -123.191, 5.3376e-08),
    Vector(32.3099, 5.19019, 3.80792e-08),
    Vector(28.4373, -23.1238, 3.83061e-07),
    Vector(23.5955, -26.7535, 7.18479e-07),
    Vector(20.8723, -46.2948, 1.42752e-06),
    Vector(32.6688, -41.2125, 1.52364e-06),
    Vector(50.0302, -25.6635, 1.67334e-06),
    Vector(59.9504, 12.9356, -3.90897e-07),
    Vector(61.8847, 68.7162, -1.98866e-06),
    Vector(60.3109, 71.9827, -2.26286e-07),
    Vector(59.9476, 69.8045, -4.92808e-07),
]


CanSpawnCubeInit <- false
SpawnCube <- false
CubeBeingSpawned <- null
movespeed <- 5

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        GlobalSpawnClass.useautospawn <- true
        PermaPotato <- true
        rollang <- 0
        Entities.FindByName(null, "catwalk_lift_door").__KeyValueFromString("dmg", "100")
        Entities.FindByName(null, "recapture_areaportal1").__KeyValueFromString("FadeStartDist", "1750")
        Entities.FindByName(null, "recapture_areaportal1").__KeyValueFromString("FadeDist", "1950")
        Entities.FindByName(null, "recapture_areaportal2").__KeyValueFromString("FadeStartDist", "1750")
        Entities.FindByName(null, "recapture_areaportal2").__KeyValueFromString("FadeDist", "1950")
        Entities.FindByName(null, "cube_dropper_prop").__KeyValueFromString("HoldAnimation", "1")
        Entities.FindByName(null, "observation_areaportal").__KeyValueFromString("targetname", "moja1")
        Entities.FindByName(null, "cube_bot_model").__KeyValueFromString("targetname", "moja2")
        Entities.FindByName(null, "@exit_door1-proxy").__KeyValueFromString("targetname", "moja3")
        Entities.FindByName(null, "cube_dropper_box_spawner").__KeyValueFromString("targetname", "cube_dropper_box_spawner_override_p232")
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
        Entities.FindByName(null, "cube_dropper_prop").SetOrigin(Vector(-304.09375, -255.03125, 437.96875))
        Entities.FindByName(null, "cube_dropper_prop").SetAngles(3.4029681046377e-06, -21.125003814697, 29.531248092651)
        //Entities.FindByName(null, "cube_dropper_box").Destroy()//SetOrigin(Vector(-304.09375, -255.03125, 437.96875))
    //     EntFireByHandle(Entities.FindByName(null, "cube_dropper_box"), "setparent", "cube_dropper_prop", 0, null, null)
    //     EntFireByHandle(Entities.FindByName(null, "cube_dropper_box"), "clearparent", "", 4, null, null)
    //     EntFireByHandle(Entities.FindByName(null, "cube_dropper_box"), "kill", "", 5, null, null)
        SpawnCube = false
    }

    if (MSLoop==true) {
        if (Entities.FindByName(null, "turret_bot4_monster")) {
            CanSpawnCubeInit = true
        }

        if (SpawnCube == true) {    
            if (CubeBeingSpawned != null) {
                local output = 0
                try {
                    output = MoveEntityOnTrack(CubeBeingSpawned, TrackPoints, movespeed)
                } catch (e) {
                    SpawnCube = false
                    CanSpawnCubeInit = false
                    EntFire("cube_dropper_box_spawner_override_p232", "forcespawn", "", 0, null)
                    EntFire("p232servercommand", "command", "script SpawnCube = true", 0.2, null)
                    EntFire("p232servercommand", "command", "script CanSpawnCubeInit = true", 0.2, null)
                    EntFire("p232servercommand", "command", "script CubeBeingSpawned = Entities.FindByName(null, \"cube_dropper_box\")", 0.1, null)
                    EntFire("p232servercommand", "command", "script CubeBeingSpawned.SetOrigin(Vector(-438, -200, 1424))", 0.1, null)
                    EntFire("p232servercommand", "command", "script printl(CubeBeingSpawned)", 0.13, null)
                }
                // if (rollang >= 160) {
                //     rollang <- -160
                // } else {
                //     if (rollang <= -160) {
                //         rollang <- 160
                //     } else {
                //         rollang <- CubeBeingSpawned.GetAngles().y + 25
                //     }
                // }

                CubeBeingSpawned.SetAngles(0, CubeBeingSpawned.GetAngles().y+RandomInt(3, 8), CubeBeingSpawned.GetAngles().z+RandomInt(3, 8))

                if (output == true) {
                    SpawnCube = false
                    EntFireByHandle(CubeBeingSpawned, "wake", "", 0, null, null)
                    CubeBeingSpawned.SetOrigin(Vector(-304.093750, -255.031250, 437.968750))
                    CubeBeingSpawned.SetAngles(0, 0, 0)
                    CubeBeingSpawned.SetVelocity(Vector(0, 0, 0))
                    CubeBeingSpawned = null
                    EntFire("cube_dropper_drop", "trigger")
                }
            } else {
                SpawnCube = false
                CanSpawnCubeInit = false
                EntFire("cube_dropper_box_spawner_override_p232", "forcespawn", "", 0, null)
                EntFire("p232servercommand", "command", "script SpawnCube = true", 0.2, null)
                EntFire("p232servercommand", "command", "script CanSpawnCubeInit = true", 0.2, null)
                EntFire("p232servercommand", "command", "script CubeBeingSpawned = Entities.FindByName(null, \"cube_dropper_box\")", 0.1, null)
                EntFire("p232servercommand", "command", "script CubeBeingSpawned.SetOrigin(Vector(-438, -200, 1424))", 0.1, null)
                EntFire("p232servercommand", "command", "script printl(CubeBeingSpawned)", 0.13, null)
            }
        }

        if (Entities.FindByClassnameNearest("prop_monster_box", Vector(-58.406547546387, -59.558124542236, 187.5777130127), 800)) {
        } else {
            if (CanSpawnCubeInit == true) {
                if (SpawnCube == false) {
                    CanSpawnCubeInit = false
                    EntFire("cube_dropper_box_spawner_override_p232", "forcespawn", "", 0, null)
                    EntFire("p232servercommand", "command", "script SpawnCube = true", 0.2, null)
                    EntFire("p232servercommand", "command", "script CanSpawnCubeInit = true", 0.2, null)
                    EntFire("p232servercommand", "command", "script CubeBeingSpawned = Entities.FindByName(null, \"cube_dropper_box\")", 0.1, null)
                    EntFire("p232servercommand", "command", "script CubeBeingSpawned.SetOrigin(Vector(-438, -200, 1424))", 0.1, null)
                    EntFire("p232servercommand", "command", "script printl(CubeBeingSpawned)", 0.13, null)
                }
            }
        }

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