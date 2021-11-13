// ██████╗██████╗             █████╗ ██████╗            ██╗      █████╗  ██████╗███████╗██████╗            ██████╗ ███████╗██╗      █████╗ ██╗   ██╗ ██████╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██║     ██╔══██╗██╔════╝██╔════╝██╔══██╗           ██╔══██╗██╔════╝██║     ██╔══██╗╚██╗ ██╔╝██╔════╝
//╚█████╗ ██████╔╝           ███████║  ███╔═╝           ██║     ███████║╚█████╗ █████╗  ██████╔╝           ██████╔╝█████╗  ██║     ███████║ ╚████╔╝ ╚█████╗ 
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝             ██║     ██╔══██║ ╚═══██╗██╔══╝  ██╔══██╗           ██╔══██╗██╔══╝  ██║     ██╔══██║  ╚██╔╝   ╚═══██╗
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗███████╗██║  ██║██████╔╝███████╗██║  ██║██████████╗██║  ██║███████╗███████╗██║  ██║   ██║   ██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
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
        SingleplayerOneTimeTrigger1 <- true
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSOnPlayerJoin==true) {
        // Find all players
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            EntFireByHandle(clientcommand, "Command", "r_flashlightbrightness 1", 0, p, p)
            EntFireByHandle(p, "setfogcontroller", "@environment_mines_fog", 0, null, null)
        }
    }

    if (MSLoop==true) {
        if (SingleplayerOneTimeTrigger1 == true) {
            if (!Entities.FindByClassnameNearest("trigger_once", Vector(-468, -704, -63), 10)) {
                // Find all players
                local p = null
                while(p = Entities.FindByClassname(p, "player")) {
                    // Teleport them to the elevator
                    p.SetOrigin(Vector(-449, -704, -55))
                    p.SetAngles(0, 0, 0)
                    p.SetVelocity(Vector(0, 0, 0))
                }
                Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "TPUpLaserRelaysDIS")
                EntFire("TPUpLaserRelaysDIS", "addoutput", "targetname TPUpLaserRelays", 12, null)
                SingleplayerOneTimeTrigger1 <- false
            }
        }

        if (Entities.FindByName(null, "TPUpLaserRelays")) {
            local p = null
            while(p = Entities.FindByClassname(p, "player")) {
                SKIPLaserRelays <- false
                local p2 = null
                while (p2 = Entities.FindByClassnameWithin(p2, "player", Vector(-319.15093994141, -1782.7447509766, -17.6354637146), 380.50416564941)) {
                    if (p2==p) {
                        SKIPLaserRelays <- true
                    }
                }
                if (SKIPLaserRelays == false) {
                    if (p.GetOrigin().z <= -50) {
                        p.SetOrigin(Vector(-256, -189, 28))
                        p.SetAngles(0, -90, 0)
                        p.SetVelocity(Vector(0, 0, 0))
                    }
                }
            }
        }

        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-318, -1790, -267), 50)) {
            // Reset r_flashlightbrightness
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                EntFireByHandle(clientcommand, "Command", "r_flashlightbrightness 0.25", 0, p, p)
            }
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a2_turret_blocker")
        }
    }
}