// ██████╗██████╗             █████╗   ██╗██╗            ██████╗██████╗ ███████╗███████╗██████╗            ████████╗██████╗             █████╗  █████╗ ████████╗ █████╗ ██╗  ██╗
//██╔════╝██╔══██╗           ██╔══██╗ ██╔╝██║           ██╔════╝██╔══██╗██╔════╝██╔════╝██╔══██╗           ╚══██╔══╝██╔══██╗           ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██║  ██║
//╚█████╗ ██████╔╝           ███████║██╔╝ ██║           ╚█████╗ ██████╔╝█████╗  █████╗  ██║  ██║              ██║   ██████╦╝           ██║  ╚═╝███████║   ██║   ██║  ╚═╝███████║
// ╚═══██╗██╔═══╝            ██╔══██║███████║            ╚═══██╗██╔═══╝ ██╔══╝  ██╔══╝  ██║  ██║              ██║   ██╔══██╗           ██║  ██╗██╔══██║   ██║   ██║  ██╗██╔══██║
//██████╔╝██║     ██████████╗██║  ██║╚════██║██████████╗██████╔╝██║     ███████╗███████╗██████╔╝██████████╗   ██║   ██████╦╝██████████╗╚█████╔╝██║  ██║   ██║   ╚█████╔╝██║  ██║
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝     ╚═╝╚═════════╝╚═════╝ ╚═╝     ╚══════╝╚══════╝╚═════╝ ╚═════════╝   ╚═╝   ╚═════╝ ╚═════════╝ ╚════╝ ╚═╝  ╚═╝   ╚═╝    ╚════╝ ╚═╝  ╚═╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    // Music doesn't play at the end (Moja)
    if (MSInstantRun==true) {
        // Here if we need to ent_fire something
        //EntFireByHandle(Entities.FindByName(null, "NAME"), "ACTION", "VALUE", DELAYiny, ACTIVATOR, CALLER)
        // Destroy objects
        Entities.FindByName(null, "fall_fade").Destroy()
        Entities.FindByName(null, "exit_door-close_door_rl").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-736, 1572, -128), 20).Destroy()
        local ent = null
        while (ent = Entities.FindByClassname(ent, "func_portal_detector")) {
            ent.__KeyValueFromString("CheckAllIDs", "1")
        }
    }

    if (MSPostPlayerSpawn==true) {

    }

    if (MSLoop==true) {
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-2240, -208, 400), 50)) {
             
            SendToConsole("changelevel sp_a4_jump_polarity")
        }
    }
}