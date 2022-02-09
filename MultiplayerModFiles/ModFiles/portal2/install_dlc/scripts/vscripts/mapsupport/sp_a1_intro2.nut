// ██████╗██████╗             █████╗   ███╗             ██╗███╗  ██╗████████╗██████╗  █████╗ ██████╗
//██╔════╝██╔══██╗           ██╔══██╗ ████║             ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗╚════██╗
//╚█████╗ ██████╔╝           ███████║██╔██║             ██║██╔██╗██║   ██║   ██████╔╝██║  ██║  ███╔═╝
// ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║██║╚████║   ██║   ██╔══██╗██║  ██║██╔══╝
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝███████╗
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun == true) {
        GlobalSpawnClass.useautospawn <- true
        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        //Entities.FindByName(null, "@glados").__KeyValueFromString("targetname", "p232gladosoverride")
        Entities.FindByClassnameNearest("trigger_once", Vector(-320, 832, -24), 100).Destroy()
        Entities.FindByName(null, "Fizzle_Trigger").Destroy()
        Entities.FindByName(null, "@entry_door-door_close_relay").Destroy()
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
        //Entities.FindByName(null, "p232gladosoverride").__KeyValueFromString("targetname", "@glados")
    }

    if (MSLoop==true) {
        // remove portalgun
        local ent = null
        while (ent = Entities.FindByClassname(ent, "weapon_portalgun")) {
            ent.Destroy()
        }
        local ent = null
        while (ent = Entities.FindByClassname(ent, "predicted_viewmodel")) {
            ent.Destroy()
        }


        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-320, 1248, -656), 50)) {
            SendToConsole("changelevel sp_a1_intro3")
        }

        try {
            Entities.FindByName(null, "block_boxes").Destroy()
        } catch(exception) {}
    }
}