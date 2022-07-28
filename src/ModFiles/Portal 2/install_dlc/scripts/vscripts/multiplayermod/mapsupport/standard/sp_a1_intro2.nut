//  ██████╗██████╗             █████╗   ███╗             ██╗███╗  ██╗████████╗██████╗  █████╗ ██████╗
// ██╔════╝██╔══██╗           ██╔══██╗ ████║             ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗╚════██╗
// ╚█████╗ ██████╔╝           ███████║██╔██║             ██║██╔██╗██║   ██║   ██████╔╝██║  ██║  ███╔═╝
//  ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║██║╚████║   ██║   ██╔══██╗██║  ██║██╔══╝
// ██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝███████╗
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        GlobalSpawnClass.useautospawn <- true
        // Remove Portal Gun
        RemovePortalGunBlue <- Entities.CreateByClassname("info_target")
        RemovePortalGunBlue.__KeyValueFromString("targetname", "supress_blue_portalgun_spawn")

        RemovePortalGunOrange <- Entities.CreateByClassname("info_target")
        RemovePortalGunOrange.__KeyValueFromString("targetname", "supress_orange_portalgun_spawn")

        EntFireByHandle(Entities.FindByName(null, "arrival_elevator-elevator_1"), "startforward", "", 0, null, null)
        //Entities.FindByName(null, "@glados").__KeyValueFromString("targetname", "p2mmgladosoverride")
        Entities.FindByClassnameNearest("trigger_once", Vector(-320, 832, -24), 100).Destroy()
        Entities.FindByName(null, "Fizzle_Trigger").Destroy()
        Entities.FindByName(null, "@entry_door-door_close_relay").Destroy()
        //Sparky <- Entities.CreateByClassname("env_spark")
        //Sparky.__KeyValueFromString("targetname", "Sparky")
        //Sparky.SetOrigin(Vector(-872, -440, -32))
        //Sparky.SetAngles(0, 0, 0)
        //EntFire("Sparky", "startspark", 0, null)
    }

    if (MSPostPlayerSpawn) {
        NewApertureStartElevatorFixes()
        //Entities.FindByName(null, "p2mmgladosoverride").__KeyValueFromString("targetname", "@glados")
    }

    if (MSLoop) {
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-320, 1248, -656), 50)) {
            SendToConsoleP232("changelevel sp_a1_intro3")
        }

        try {
            Entities.FindByName(null, "block_boxes").Destroy()
        } catch(exception) {}
    }
}