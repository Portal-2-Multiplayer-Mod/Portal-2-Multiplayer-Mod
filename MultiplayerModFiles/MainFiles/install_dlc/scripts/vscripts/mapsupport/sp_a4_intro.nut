// ██████╗██████╗             █████╗   ██╗██╗           ██╗███╗  ██╗████████╗██████╗  █████╗ 
//██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║██╔╝ ██║           ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║███████║           ██║██║╚████║   ██║   ██╔══██╗██║  ██║
//██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    // Make prop_dy dizove (Moja)
    if (GetMapName()=="sp_a4_intro") {
        if (MSInstantRun==true) {
            Entities.FindByName(null, "@exit_door1-proxy").__KeyValueFromString("targetname", "moja1")
            // Make elevator start moving on level load
            EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "StartForward", "", 0, null, null)
            EntFireByHandle(Entities.FindByName(null, "button_1_pressed"), "addoutput", "OnTrigger moja1:OnProxyRelay2:open", 1, null, null)
            EntFireByHandle(Entities.FindByName(null, "button_1_unpressed"), "addoutput", "OnTrigger moja1:OnProxyRelay1:close", 1, null, null)
            // Destroy objects
            Entities.FindByName(null, "door_0-close_door_rl").Destroy()
            Entities.FindByName(null, "@entrance_door1-close_door_rl").Destroy()
            Entities.FindByName(null, "room2_wall_close").Destroy()
            Entities.FindByName(null, "room2a_wall_close").Destroy()
            Entities.FindByName(null, "test2_end_trigger").Destroy()
            Entities.FindByName(null, "@exit_door-close_door_rl").Destroy()
            OnlyOnceSpA4Intro <- true
        }

        if (MSPostPlayerSpawn==true) {
            NewApertureStartElevatorFixes()
        }

        if (MSLoop==true) {
            // Change ClosedBetaTestingBox Names ;)
            local ent = null
            while (ent = Entities.FindByClassnameWithin(ent, "prop_monster_box", Vector(-58.406547546387, -59.558124542236, 187.5777130127), 400)) {
                ent.__KeyValueFromString("targetname", "moja2")
            }
            if (OnlyOnceSpA4Intro==true) {
                if (!Entities.FindByName(null, "room2_wall_open_trigger")) {
                    printl("Elevator viewcontrol activated")
                    // Elevator viewcontrol
                    Entities.FindByName(null, "@exit_door2-close_door_rl").__KeyValueFromString("targetname", "moja3")

                    EntFireByHandle(Entities.FindByName(null, "button_2_unpressed"), "addoutput", "OnTrigger moja3:Trigger", 0, null, null)

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
}