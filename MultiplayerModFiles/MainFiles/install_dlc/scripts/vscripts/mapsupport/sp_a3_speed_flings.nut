// ██████╗██████╗             █████╗ ██████╗             ██████╗██████╗ ███████╗███████╗██████╗            ███████╗██╗     ██╗███╗  ██╗ ██████╗  ██████╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔════╝██╔══██╗██╔════╝██╔════╝██╔══██╗           ██╔════╝██║     ██║████╗ ██║██╔════╝ ██╔════╝
//╚█████╗ ██████╔╝           ███████║ █████╔╝           ╚█████╗ ██████╔╝█████╗  █████╗  ██║  ██║           █████╗  ██║     ██║██╔██╗██║██║  ██╗ ╚█████╗ 
// ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗            ╚═══██╗██╔═══╝ ██╔══╝  ██╔══╝  ██║  ██║           ██╔══╝  ██║     ██║██║╚████║██║  ╚██╗ ╚═══██╗
//██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗██████╔╝██║     ███████╗███████╗██████╔╝██████████╗██║     ███████╗██║██║ ╚███║╚██████╔╝██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝╚═════╝ ╚═╝     ╚══════╝╚══════╝╚═════╝ ╚═════════╝╚═╝     ╚══════╝╚═╝╚═╝  ╚══╝ ╚═════╝ ╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "InstanceAuto6-entrance_lift_train"), "StartForward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "fade_to_death-proxy").Destroy()
        Entities.FindByName(null, "fade_to_death-fade_to_death").Destroy()
    }

    if (MSPostPlayerSpawn==true) {

    }

    if (MSLoop==true) {
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(396, 1152, 656), 100)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a3_portal_intro")
        }
    }
}