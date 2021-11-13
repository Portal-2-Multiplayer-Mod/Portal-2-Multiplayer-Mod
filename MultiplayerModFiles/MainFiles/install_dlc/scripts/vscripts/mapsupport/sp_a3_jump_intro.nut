// ██████╗██████╗             █████╗ ██████╗                 ██╗██╗   ██╗███╗   ███╗██████╗            ██╗███╗  ██╗████████╗██████╗  █████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗                ██║██║   ██║████╗ ████║██╔══██╗           ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║ █████╔╝                ██║██║   ██║██╔████╔██║██████╔╝           ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██╗  ██║██║   ██║██║╚██╔╝██║██╔═══╝            ██║██║╚████║   ██║   ██╔══██╗██║  ██║
//██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗╚█████╔╝╚██████╔╝██║ ╚═╝ ██║██║     ██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝ ╚════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        // Here if we need to ent_fire something
        //EntFireByHandle(Entities.FindByName(null, "NAME"), "ACTION", "VALUE", DELAYiny, ACTIVATOR, CALLER)
        // Destroy objects
        Entities.FindByName(null, "fade_to_death-proxy").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-8880, 2096, -412), 20).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-676, 896, 448), 20).Destroy()
        OnlyOnceSp_A3_Jump_Intro <- true
    }

    if (MSPostPlayerSpawn==true) {
        EntFireByHandle(Entities.FindByName(null, "InstanceAuto12-entrance_lift_train"), "StartForward", "", 2, null, null)
        OnlyOnceSp_A3_Jump_Intro <- false
    }

    if (MSLoop==true) {
        if (OnlyOnceSp_A3_Jump_Intro == true) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(-8880, 2096, -458))
            }
        }

        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-668, 2080, 2314), 100)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a3_bomb_flings")
        }
    }
}