// ██████╗██████╗             █████╗ ██████╗            ████████╗██╗   ██╗██████╗ ██████╗ ███████╗████████╗           ██╗███╗  ██╗████████╗██████╗  █████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔════╝╚══██╔══╝           ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║  ███╔═╝              ██║   ██║   ██║██████╔╝██████╔╝█████╗     ██║              ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║██╔══╝                ██║   ██║   ██║██╔══██╗██╔══██╗██╔══╝     ██║              ██║██║╚████║   ██║   ██╔══██╗██║  ██║
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗   ██║   ╚██████╔╝██║  ██║██║  ██║███████╗   ██║   ██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        GlobalSpawnClass.useautospawn <- true
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        // Kill the changelevel trigger
        Entities.FindByName(null, "transition_trigger").Destroy()
        // Set the door logic
        Entities.FindByName(null, "@exit_door-proxy").__KeyValueFromString("targetname", "MpModDoorProxyOverride")
        EntFire("exit_door_relay_open", "addoutput", "OnTrigger MpModDoorProxyOverride:OnProxyRelay2", 0, null)
        EntFire("exit_door_relay_close", "addoutput", "OnTrigger MpModDoorProxyOverride:OnProxyRelay1", 0, null)
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        // Make our own changelevel trigger
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-452, 196, -292), 200)) {
             
            SendToConsoleP232("changelevel sp_a2_laser_relays")
        }
    }
}