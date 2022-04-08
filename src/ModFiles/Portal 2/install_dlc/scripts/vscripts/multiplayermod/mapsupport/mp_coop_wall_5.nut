// ███╗   ███╗██████╗             █████╗  █████╗  █████╗ ██████╗             ██╗       ██╗ █████╗ ██╗     ██╗                ███████╗
// ████╗ ████║██╔══██╗           ██╔══██╗██╔══██╗██╔══██╗██╔══██╗            ██║  ██╗  ██║██╔══██╗██║     ██║                ██╔════╝
// ██╔████╔██║██████╔╝           ██║  ╚═╝██║  ██║██║  ██║██████╔╝            ╚██╗████╗██╔╝███████║██║     ██║                ██████╗
// ██║╚██╔╝██║██╔═══╝            ██║  ██╗██║  ██║██║  ██║██╔═══╝              ████╔═████║ ██╔══██║██║     ██║                ╚════██╗
// ██║ ╚═╝ ██║██║     ██████████╗╚█████╔╝╚█████╔╝╚█████╔╝██║     ██████████╗  ╚██╔╝ ╚██╔╝ ██║  ██║███████╗███████╗██████████╗██████╔╝
// ╚═╝     ╚═╝╚═╝     ╚═════════╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝     ╚═════════╝   ╚═╝   ╚═╝  ╚═╝  ╚═╝╚══════╝╚══════╝╚═════════╝╚═════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        // Keep areaportal open by not allowing it to be adressed by map logic
        Entities.FindByName(null, "portal_close_second_puzzle").__KeyValueFromString("targetname", "moja")
    }

    if (MSPostPlayerSpawn==true) {

    }

    if (MSLoop==true) {
        TeleportPlayerWithinDistance(Vector(1224, -1984, 565), 100, Vector(1208, -1989, 315))
    }
}