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
        Entities.CreateByClassname("prop_dynamic").__KeyValueFromString("targetname", "tick")
        OnlyOnceSp_A3_Jump_Intro <- true
    }

    if (MSPostPlayerSpawn==true) {
        EntFireByHandle(Entities.FindByName(null, "InstanceAuto12-entrance_lift_train"), "StartForward", "", 2, null, null)
        EntFire("tick", "kill", "", 2, null)
    }

    if (MSLoop==true) {
        if (!Entities.FindByName(null, "tick")) {
            OnlyOnceSp_A3_Jump_Intro <- false
        }

        // Goo Damage Code
        try {
        if (GooHurtTimerPred) { printl()}
        } catch (exception) {
            GooHurtTimerPred <- 0
        }

        if (GooHurtTimerPred<=Time()) {
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-667, 977, 1004), 6000)) {
                if (p.GetOrigin().z<=-300) {
                    EntFireByHandle(p, "sethealth", "-20", 0, null, null)
                }
            }
            GooHurtTimerPred = Time()+1
        }


        if (OnlyOnceSp_A3_Jump_Intro == true) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(-8880, 2096, -458))
            }
        }

        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-668, 2080, 2314), 100)) {
             
            SendToConsoleP232("changelevel sp_a3_bomb_flings")
        }
    }
}