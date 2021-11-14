// ██████╗██████╗             █████╗ ██████╗             █████╗  █████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██╔══██╗
//╚█████╗ ██████╔╝           ███████║ █████╔╝           ██║  ██║██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██║  ██║██║  ██║
//██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗╚█████╔╝╚█████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝ ╚════╝  ╚════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        Entities.CreateByClassname("point_servercommand").__KeyValueFromString("targetname", "Sp_A3_00ServerCommand")
        printl(Entities.FindByName(null, "@environment_mines_fog").__KeyValueFromString("fogmaxdensity", "1"))
        Entities.FindByName(null, "@environment_mines_fog").__KeyValueFromString("fogend", "1")
        Entities.FindByName(null, "@environment_bottomless_pit_falling_fog").__KeyValueFromString("farz", "0")
        Entities.FindByName(null, "potatos_prop").__KeyValueFromString("solid", "0")
        // Destroy objects
        Entities.FindByClassnameNearest("logic_auto", Vector(144, -4048, 64), 20).Destroy()
        local ent = null
        while (ent = Entities.FindByClassname(ent, "trigger_push")) {
            ent.Destroy()
        }
    }

    if (MSPostPlayerSpawn==true) {
        EntFireByHandle(Entities.FindByName(null, "player_looktarget"), "SetParent", "!player", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "potatos_tank"), "SetTargetEntity", "player_looktarget", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "shaft_section_0"), "StartForward", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "shaft_section_1"), "StartForward", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "lift_mover"), "Open", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "ambient_sp_a3_01_b1"), "PlaySound", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "potatos_relay"), "Trigger", "", 3, null, null)
        EntFireByHandle(Entities.FindByName(null, "potatos_train"), "StartForward", "", 4, null, null)

        EntFire("Sp_A3_00ServerCommand", "command", "echo Changing level...", 76, null)
        EntFire("Sp_A3_00ServerCommand", "command", "changelevel sp_a3_01", 76, null)
    }

    if (MSLoop==true) {
        // Make POTATOS tank point at nearest player
        try {
            local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "potatos_tank").GetOrigin(), 10000)
            EntFireByHandle(Entities.FindByName(null, "potatos_tank"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
        } catch(exception) {}
    }
}