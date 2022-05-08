// ███╗   ███╗ █████╗ ██████╗ ███╗  ██╗ █████╗ ███╗   ███╗███████╗
// ████╗ ████║██╔══██╗██╔══██╗████╗ ██║██╔══██╗████╗ ████║██╔════╝
// ██╔████╔██║███████║██████╔╝██╔██╗██║███████║██╔████╔██║█████╗
// ██║╚██╔╝██║██╔══██║██╔═══╝ ██║╚████║██╔══██║██║╚██╔╝██║██╔══╝
// ██║ ╚═╝ ██║██║  ██║██║     ██║ ╚███║██║  ██║██║ ╚═╝ ██║███████╗
// ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚══╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        printl("MapSupport: Instantly running map support.");
        EntFire("@relay_explode_bots_transition", "addoutput", "OnTrigger p2mm_servercommand:command:changelevel mp_coop_lobby_3:4")
    }

    if (MSPostPlayerSpawn) {

    }

    if (MSLoop) {

    }
}