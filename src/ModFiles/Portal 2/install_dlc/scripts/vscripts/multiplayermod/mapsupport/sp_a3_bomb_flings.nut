// ██████╗██████╗             █████╗ ██████╗            ██████╗  █████╗ ███╗   ███╗██████╗            ███████╗██╗     ██╗███╗  ██╗ ██████╗  ██████╗
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██╔══██╗████╗ ████║██╔══██╗           ██╔════╝██║     ██║████╗ ██║██╔════╝ ██╔════╝
//╚█████╗ ██████╔╝           ███████║ █████╔╝           ██████╦╝██║  ██║██╔████╔██║██████╦╝           █████╗  ██║     ██║██╔██╗██║██║  ██╗ ╚█████╗
// ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██╔══██╗██║  ██║██║╚██╔╝██║██╔══██╗           ██╔══╝  ██║     ██║██║╚████║██║  ╚██╗ ╚═══██╗
//██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗██████╦╝╚█████╔╝██║ ╚═╝ ██║██████╦╝██████████╗██║     ███████╗██║██║ ╚███║╚██████╔╝██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝╚═════╝  ╚════╝ ╚═╝     ╚═╝╚═════╝ ╚═════════╝╚═╝     ╚══════╝╚═╝╚═╝  ╚══╝ ╚═════╝ ╚═════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        GlobalSpawnClass.useautospawn <- true
        // Make elevator start moving on level load
        EntFireByHandle(Entities.FindByName(null, "InstanceAuto8-entrance_lift_train"), "StartForward", "", 0, null, null)
        // Destroy objects
        Entities.FindByName(null, "fade_to_death-proxy").Destroy()
    }

    if (MSPostPlayerSpawn) {

    }

    if (MSLoop) {
        // Goo Damage Code
        try {
        if (GooHurtTimerPred) { printl()}
        } catch (exception) {
            GooHurtTimerPred <- 0
        }

        if (GooHurtTimerPred<=Time()) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                if (p.GetOrigin().z<=-1481) {
                    EntFireByHandle(p, "sethealth", "-20", 0, null, null)
                }
            }
            GooHurtTimerPred = Time()+1
        }
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-256, 1570, 1288), 100)) {
             
            SendToConsoleP2MM("changelevel sp_a3_crazy_box")
        }
    }
}