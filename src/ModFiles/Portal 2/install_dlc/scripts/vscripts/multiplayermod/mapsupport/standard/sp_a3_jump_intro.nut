//  ██████╗██████╗             █████╗ ██████╗                 ██╗██╗   ██╗███╗   ███╗██████╗            ██╗███╗  ██╗████████╗██████╗  █████╗
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗                ██║██║   ██║████╗ ████║██╔══██╗           ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗
// ╚█████╗ ██████╔╝           ███████║ █████╔╝                ██║██║   ██║██╔████╔██║██████╔╝           ██║██╔██╗██║   ██║   ██████╔╝██║  ██║
//  ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██╗  ██║██║   ██║██║╚██╔╝██║██╔═══╝            ██║██║╚████║   ██║   ██╔══██╗██║  ██║
// ██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗╚█████╔╝╚██████╔╝██║ ╚═╝ ██║██║     ██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝ ╚════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn, MSOnSave, MSOnSaveCheck, MSOnSaveLoad) {
    if (MSInstantRun) {
        // Here if we need to ent_fire something
        //EntFireByHandle(Entities.FindByName(null, "NAME"), "ACTION", "VALUE", DELAYiny, ACTIVATOR, CALLER)
        // Destroy objects
        Entities.FindByName(null, "fade_to_death-proxy").Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-8880, 2096, -412), 20).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(-676, 896, 448), 20).Destroy()
        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "tick")
        OnlyOnceSp_A3_Jump_Intro <- true
        ElevatorFinishMoving <- null
        GooHurtTimerPred <- 0
    }

    if (MSPostPlayerSpawn) {
        EntFireByHandle(Entities.FindByName(null, "InstanceAuto12-entrance_lift_train"), "StartForward", "", 2, null, null)
        EntFire("tick", "kill", "", 2, null)
        ElevatorFinishMoving <- Time() + 5
    }

    if (MSLoop) {
        if (!Entities.FindByName(null, "tick")) {
            OnlyOnceSp_A3_Jump_Intro <- false
        }

        // Box check
        if (ElevatorFinishMoving <= Time()) {
            local boxp = null
            while (boxp = Entities.FindByClassnameWithin(boxp, "player", Vector(-704, -9152, -335.97), 64)) {
                boxp.SetOrigin(Vector(-8880, 2096, -57.97))
            }
        }

        // Goo Damage Code
        if (GooHurtTimerPred + 0.8 <= Time()) {
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-667, 977, 1100), 6000)) {
                if (p.GetOrigin().z <= -350) {
                    EntFireByHandle(p, "sethealth", "-100", 0, null, null)
                }
            }
            GooHurtTimerPred = Time()
        }


        if (OnlyOnceSp_A3_Jump_Intro) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(-8880, 2096, -458))
            }
        }

        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-668, 2080, 2314), 100)) {
            SendToConsoleP2MM("changelevel sp_a3_bomb_flings")
        }
    }
}
