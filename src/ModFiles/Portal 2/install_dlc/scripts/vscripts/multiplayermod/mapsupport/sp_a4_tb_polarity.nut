// ██████╗██████╗             █████╗   ██╗██╗           ████████╗██████╗            ██████╗  █████╗ ██╗      █████╗ ██████╗ ██╗████████╗██╗   ██╗
//██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ╚══██╔══╝██╔══██╗           ██╔══██╗██╔══██╗██║     ██╔══██╗██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝
//╚█████╗ ██████╔╝           ███████║██╔╝ ██║              ██║   ██████╦╝           ██████╔╝██║  ██║██║     ███████║██████╔╝██║   ██║    ╚████╔╝ 
// ╚═══██╗██╔═══╝            ██╔══██║███████║              ██║   ██╔══██╗           ██╔═══╝ ██║  ██║██║     ██╔══██║██╔══██╗██║   ██║     ╚██╔╝  
//██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗   ██║   ██████╦╝██████████╗██║     ╚█████╔╝███████╗██║  ██║██║  ██║██║   ██║      ██║   
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝   ╚═╝   ╚═════╝ ╚═════════╝╚═╝      ╚════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        GlobalSpawnClass.useautospawn <- true
        PermaPotato <- true
        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "StartForward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        Entities.FindByName(null, "fall_fade").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-128, -208, 288), 20).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-128, -288, 296), 20).Destroy()
    }

    if (MSPostPlayerSpawn) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop) {
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-128, -704, 656), 50)) {
             
            SendToConsoleP2MM("changelevel sp_a4_tb_catch")
        }
    }
}