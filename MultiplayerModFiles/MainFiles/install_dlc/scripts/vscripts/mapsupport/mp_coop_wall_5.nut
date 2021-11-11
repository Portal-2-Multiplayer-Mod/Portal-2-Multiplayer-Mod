// ███╗   ███╗██████╗             █████╗  █████╗  █████╗ ██████╗             ██╗       ██╗ █████╗ ██╗     ██╗                ███████╗
// ████╗ ████║██╔══██╗           ██╔══██╗██╔══██╗██╔══██╗██╔══██╗            ██║  ██╗  ██║██╔══██╗██║     ██║                ██╔════╝
// ██╔████╔██║██████╔╝           ██║  ╚═╝██║  ██║██║  ██║██████╔╝            ╚██╗████╗██╔╝███████║██║     ██║                ██████╗
// ██║╚██╔╝██║██╔═══╝            ██║  ██╗██║  ██║██║  ██║██╔═══╝              ████╔═████║ ██╔══██║██║     ██║                ╚════██╗
// ██║ ╚═╝ ██║██║     ██████████╗╚█████╔╝╚█████╔╝╚█████╔╝██║     ██████████╗  ╚██╔╝ ╚██╔╝ ██║  ██║███████╗███████╗██████████╗██████╔╝
// ╚═╝     ╚═╝╚═╝     ╚═════════╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝     ╚═════════╝   ╚═╝   ╚═╝  ╚═╝  ╚═╝╚══════╝╚══════╝╚═════════╝╚═════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (GetMapName()=="mp_coop_wall_5") {
        if (MSInstantRun==true) {

        }

        if (MSPostPlayerSpawn==true) {

        }

        if (MSLoop==true) {
            TeleportPlayerWithinDistance(Vector(1224, -1984, 565), 100, Vector(1208, -1989, 315))
            // Open areaportal
            EntFire("portal_close_second_puzzle", "open", "", 0, null)
        }
    }
}