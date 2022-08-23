//  ██████╗██████╗             █████╗ ██████╗            ████████╗██╗   ██╗██████╗ ██████╗ ███████╗████████╗           ██╗███╗  ██╗████████╗██████╗  █████╗ 
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔════╝╚══██╔══╝           ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
// ╚█████╗ ██████╔╝           ███████║  ███╔═╝              ██║   ██║   ██║██████╔╝██████╔╝█████╗     ██║              ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
//  ╚═══██╗██╔═══╝            ██╔══██║██╔══╝                ██║   ██║   ██║██╔══██╗██╔══██╗██╔══╝     ██║              ██║██║╚████║   ██║   ██╔══██╗██║  ██║
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗   ██║   ╚██████╔╝██║  ██║██║  ██║███████╗   ██║   ██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        GlobalSpawnClass.useautospawn <- true
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        // Set the door logic
        Entities.FindByName(null, "@exit_door-proxy").__KeyValueFromString("targetname", "MpModDoorProxyOverride")
        EntFire("exit_door_relay_open", "addoutput", "OnTrigger MpModDoorProxyOverride:OnProxyRelay2", 0, null)
        EntFire("exit_door_relay_close", "addoutput", "OnTrigger MpModDoorProxyOverride:OnProxyRelay1", 0, null)
                    
        // Make changing levels work
        EntFire("transition_trigger", "addoutput", "OnStartTouch p2mm_servercommand:Command:changelevel sp_a2_laser_relays:0.45", 0, null)
    }

    if (MSPostPlayerSpawn) {
        NewApertureStartElevatorFixes()
    }
}