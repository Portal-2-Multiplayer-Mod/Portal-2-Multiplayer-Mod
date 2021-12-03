// ██████╗██████╗             █████╗   ███╗             ██╗███╗  ██╗████████╗██████╗  █████╗ ███████╗
//██╔════╝██╔══██╗           ██╔══██╗ ████║             ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗╚════██║
//╚█████╗ ██████╔╝           ███████║██╔██║             ██║██╔██╗██║   ██║   ██████╔╝██║  ██║    ██╔╝
// ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║██║╚████║   ██║   ██╔══██╗██║  ██║   ██╔╝
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝  ██╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝   ╚═╝

if (MSInstantRun==true) {
    // Destroy objects
    Entities.FindByName(null, "door_0-close_door_rl").Destroy()
}

if (MSPostPlayerSpawn==true) {
    NewApertureStartElevatorFixes()
}

if (MSLoop==true) {
    // Elevator changelevel
    local p = null
    while(p = Entities.FindByClassnameWithin(p, "player", Vector(1, 2, 3), 50)) {
        SendToConsole("commentary 1")
        SendToConsole("changelevel sp_a1_wakeup")
    }
}