//  ██████╗██████╗             █████╗ ██████╗            ████████╗██████╗ ██╗   ██╗ ██████╗████████╗           ███████╗██╗     ██╗███╗  ██╗ ██████╗ 
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ╚══██╔══╝██╔══██╗██║   ██║██╔════╝╚══██╔══╝           ██╔════╝██║     ██║████╗ ██║██╔════╝ 
// ╚█████╗ ██████╔╝           ███████║  ███╔═╝              ██║   ██████╔╝██║   ██║╚█████╗    ██║              █████╗  ██║     ██║██╔██╗██║██║  ██╗ 
//  ╚═══██╗██╔═══╝            ██╔══██║██╔══╝                ██║   ██╔══██╗██║   ██║ ╚═══██╗   ██║              ██╔══╝  ██║     ██║██║╚████║██║  ╚██╗
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗   ██║   ██║  ██║╚██████╔╝██████╔╝   ██║   ██████████╗██║     ███████╗██║██║ ╚███║╚██████╔╝
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝    ╚═╝   ╚═════════╝╚═╝     ╚══════╝╚═╝╚═╝  ╚══╝ ╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn, MSOnSave, MSOnSaveCheck, MSOnSaveLoad) {
    if (MSInstantRun) {
        GlobalSpawnClass.useautospawn <- true
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-1152, 1616, 120), 1024).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-1152, 1680, 40), 1024).Destroy()

        // Make changing levels work
        EntFire("transition_trigger", "addoutput", "OnStartTouch p2mm_servercommand:Command:changelevel sp_a2_pit_flings:0.3", 0, null)
    }

    if (MSPostPlayerSpawn) {
        NewApertureStartElevatorFixes()
    }
}