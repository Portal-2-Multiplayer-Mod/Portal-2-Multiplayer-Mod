// ██████╗██████╗             █████╗ ██████╗             █████╗ ██████╗  █████╗ ███████╗██╗   ██╗           ██████╗  █████╗ ██╗  ██╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██╔══██╗██╔══██╗╚════██║╚██╗ ██╔╝           ██╔══██╗██╔══██╗╚██╗██╔╝
//╚█████╗ ██████╔╝           ███████║ █████╔╝           ██║  ╚═╝██████╔╝███████║  ███╔═╝ ╚████╔╝            ██████╦╝██║  ██║ ╚███╔╝ 
// ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██║  ██╗██╔══██╗██╔══██║██╔══╝    ╚██╔╝             ██╔══██╗██║  ██║ ██╔██╗ 
//██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗╚█████╔╝██║  ██║██║  ██║███████╗   ██║   ██████████╗██████╦╝╚█████╔╝██╔╝╚██╗
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝ ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════════╝╚═════╝  ╚════╝ ╚═╝  ╚═╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    // What do we do if the players vaporize the box?
    if (MSInstantRun==true) {
        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "InstanceAuto17-entrance_lift_train"), "StartForward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "fade_to_death").Destroy()
        Entities.FindByName(null, "AutoInstance1-door_close").Destroy()
        Entities.FindByName(null, "AutoInstance1-door_pushers").Destroy()
        Entities.FindByName(null, "AutoInstance1-door_pushers").Destroy()
        // We need to add a trigger to the crazy box test that plays ambient_sp_a3_crazy_box_b2 (Moja)
        Entities.FindByClassnameNearest("trigger_once", Vector(144, -1280, 1600), 20).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(200, -1272, 1600), 20).Destroy()
    }

    if (MSPostPlayerSpawn==true) {

    }

    if (MSLoop==true) {
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(640, 174, 2740), 100)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a3_transition01")
        }
    }
}