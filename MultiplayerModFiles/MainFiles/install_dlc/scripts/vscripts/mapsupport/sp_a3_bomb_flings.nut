// ██████╗██████╗             █████╗ ██████╗            ██████╗  █████╗ ███╗   ███╗██████╗            ███████╗██╗     ██╗███╗  ██╗ ██████╗  ██████╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██╔══██╗████╗ ████║██╔══██╗           ██╔════╝██║     ██║████╗ ██║██╔════╝ ██╔════╝
//╚█████╗ ██████╔╝           ███████║ █████╔╝           ██████╦╝██║  ██║██╔████╔██║██████╦╝           █████╗  ██║     ██║██╔██╗██║██║  ██╗ ╚█████╗ 
// ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██╔══██╗██║  ██║██║╚██╔╝██║██╔══██╗           ██╔══╝  ██║     ██║██║╚████║██║  ╚██╗ ╚═══██╗
//██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗██████╦╝╚█████╔╝██║ ╚═╝ ██║██████╦╝██████████╗██║     ███████╗██║██║ ╚███║╚██████╔╝██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝╚═════╝  ╚════╝ ╚═╝     ╚═╝╚═════╝ ╚═════════╝╚═╝     ╚══════╝╚═╝╚═╝  ╚══╝ ╚═════╝ ╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (GetMapName()=="sp_a3_bomb_flings") {
        if (MSInstantRun==true) {
            // Make elevator start moving on level load
            EntFireByHandle(Entities.FindByName(null, "InstanceAuto8-entrance_lift_train"), "StartForward", "", 0, null, null)
            // Destroy objects
            Entities.FindByName(null, "fade_to_death-proxy").Destroy()
        }

        if (MSPostPlayerSpawn==true) {

        }

        if (MSLoop==true) {
            // Elevator changelevel
            local p = null
            while(p = Entities.FindByClassnameWithin(p, "player", Vector(-256, 1570, 1288), 100)) {
                SendToConsole("commentary 1")
                SendToConsole("changelevel sp_a3_crazy_box")
            }
        }
    }
}