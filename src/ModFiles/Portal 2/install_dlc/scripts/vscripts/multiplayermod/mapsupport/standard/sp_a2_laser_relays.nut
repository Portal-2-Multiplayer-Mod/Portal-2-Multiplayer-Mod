//  ██████╗██████╗             █████╗ ██████╗            ██╗      █████╗  ██████╗███████╗██████╗            ██████╗ ███████╗██╗      █████╗ ██╗   ██╗ ██████╗
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██║     ██╔══██╗██╔════╝██╔════╝██╔══██╗           ██╔══██╗██╔════╝██║     ██╔══██╗╚██╗ ██╔╝██╔════╝
// ╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██║     ███████║╚█████╗ █████╗  ██████╔╝           ██████╔╝█████╗  ██║     ███████║ ╚████╔╝ ╚█████╗
//  ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██║     ██╔══██║ ╚═══██╗██╔══╝  ██╔══██╗           ██╔══██╗██╔══╝  ██║     ██╔══██║  ╚██╔╝   ╚═══██╗
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗███████╗██║  ██║██████╔╝███████╗██║  ██║██████████╗██║  ██║███████╗███████╗██║  ██║   ██║   ██████╔╝
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═════╝

SingleplayerOneTimeTrigger1 <- true

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        // Kill the beginning door close trigger
        Entities.FindByClassnameNearest("trigger_once", Vector(1224, -704, 32), 1024).Destroy()
        // Kill the panels' relays
        Entities.FindByName(null, "animset01_kill_rl").Destroy()
        Entities.FindByName(null, "animset02_kill_rl").Destroy()
        Entities.FindByName(null, "animset03_kill_rl").Destroy()
        Entities.FindByName(null, "animset04_kill_rl").Destroy()
        Entities.FindByName(null, "animset05_kill_rl").Destroy()
        Entities.FindByName(null, "animset06_kill_rl").Destroy()
        Entities.FindByName(null, "animset07_kill_rl").Destroy()
        Entities.FindByName(null, "animset08_kill_rl").Destroy()
        Entities.FindByName(null, "lift_kill_rl").Destroy()
        // Kill the end door close trigger even though it probably isn't linked to the door relay
        Entities.FindByClassnameNearest("trigger_once", Vector(-320, -1376, 40), 1024).Destroy()
                    
        // Make changing levels work
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel sp_a2_turret_blocker:0.3", 0, null)
    }

    if (MSPostPlayerSpawn) {
        NewApertureStartElevatorFixes()
        // Fix Valve's stupid bug
        Entities.FindByClassnameNearest("trigger_once", Vector(-450.29, -703, 61.5), 24).__KeyValueFromString("targetname", "temptrigger")
        EntFire("temptrigger", "AddOutput", "OnStartTouch player_on_top_branch:SetValue:1:0.7", 2, null)
    }

    if (MSOnPlayerJoin) {
        // Find all players
        for (local p = null; p = Entities.FindByClassname(p, "player");) {
            EntFireByHandle(p2mm_clientcommand, "Command", "r_flashlightbrightness 1", 0, p, p)
            EntFireByHandle(p, "setfogcontroller", "@environment_mines_fog", 0, null, null)
        }
    }

    if (MSLoop) {
        if (SingleplayerOneTimeTrigger1) {
            if (!Entities.FindByClassnameNearest("trigger_once", Vector(-468, -704, -63), 10)) {
                SingleplayerOneTimeTrigger1 <- false
                // Find all players
                for (local p = null; p = Entities.FindByClassname(p, "player");) {
                    // Teleport them to the elevator
                    p.SetOrigin(Vector(-449, -704, -55))
                    p.SetAngles(0, 0, 0)
                    p.SetVelocity(Vector(0, 0, 0))
                }
                Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "TPUpLaserRelaysDIS")
                EntFire("TPUpLaserRelaysDIS", "AddOutput", "targetname TPUpLaserRelays", 12, null)
            }
        }

        if (Entities.FindByName(null, "TPUpLaserRelays")) {
            for (local p = null; p = Entities.FindByClassname(p, "player");) {
                SKIPLaserRelays <- false
                local p2 = null
                for (local ent = null; ent2 = Entities.FindByClassnameWithin(p2, "player", Vector(-319.15093994141, -1782.7447509766, -17.6354637146), 380.50416564941);) {
                    if (p2==p) {
                        SKIPLaserRelays <- true
                    }
                }
                if (!SKIPLaserRelays) {
                    // Rough area where all players can walk around under the chamber
                    // Teleport everyone up if they spawn below there
                    if (p.GetOrigin().z <= -50 && p.GetOrigin().z >= -200 && p.GetOrigin().y >= -767 && p.GetOrigin().y <= -625 && p.GetOrigin().x <= 1806.23 && p.GetOrigin().x >= -560.03) {
                        p.SetOrigin(Vector(-256, -189, 28))
                        p.SetAngles(0, -90, 0)
                        p.SetVelocity(Vector(0, 0, 0))
                    }
                }
            }
        }
    }
}
