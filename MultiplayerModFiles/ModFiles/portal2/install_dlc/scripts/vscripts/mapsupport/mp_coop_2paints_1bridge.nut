// ███╗   ███╗██████╗             █████╗  █████╗  █████╗ ██████╗            ██████╗ ██████╗  █████╗ ██╗███╗  ██╗████████╗ ██████╗             ███╗  ██████╗ ██████╗ ██╗██████╗  ██████╗ ███████╗
// ████╗ ████║██╔══██╗           ██╔══██╗██╔══██╗██╔══██╗██╔══██╗           ╚════██╗██╔══██╗██╔══██╗██║████╗ ██║╚══██╔══╝██╔════╝            ████║  ██╔══██╗██╔══██╗██║██╔══██╗██╔════╝ ██╔════╝
// ██╔████╔██║██████╔╝           ██║  ╚═╝██║  ██║██║  ██║██████╔╝             ███╔═╝██████╔╝███████║██║██╔██╗██║   ██║   ╚█████╗            ██╔██║  ██████╦╝██████╔╝██║██║  ██║██║  ██╗ █████╗
// ██║╚██╔╝██║██╔═══╝            ██║  ██╗██║  ██║██║  ██║██╔═══╝            ██╔══╝  ██╔═══╝ ██╔══██║██║██║╚████║   ██║    ╚═══██╗           ╚═╝██║  ██╔══██╗██╔══██╗██║██║  ██║██║  ╚██╗██╔══╝
// ██║ ╚═╝ ██║██║     ██████████╗╚█████╔╝╚█████╔╝╚█████╔╝██║     ██████████╗███████╗██║     ██║  ██║██║██║ ╚███║   ██║   ██████╔╝██████████╗███████╗██████╦╝██║  ██║██║██████╔╝╚██████╔╝███████╗
// ╚═╝     ╚═╝╚═╝     ╚═════════╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝     ╚═════════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═════╝ ╚═════════╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝╚═════╝  ╚═════╝ ╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {

    }

    if (MSPostPlayerSpawn==true) {
        EntFireByHandle(Entities.FindByName(null, "bridge_2"), "enable", "", 0, null, null)
        EntFireByHandle(Entities.FindByName(null, "bridge_1"), "enable", "", 0, null, null)
        Entities.FindByName(null, "bridge_1").__KeyValueFromString("targetname", "moja")
        Entities.FindByName(null, "bridge_2").__KeyValueFromString("targetname", "moja2")
        EntFireByHandle(Entities.FindByName(null, "paint_sprayer_blue_1"), "start", "", 0, null, null)
        Entities.FindByName(null, "paint_sprayer_blue_1").__KeyValueFromString("targetname", "moja3")
    }

    if (MSLoop==true) {

    }
}