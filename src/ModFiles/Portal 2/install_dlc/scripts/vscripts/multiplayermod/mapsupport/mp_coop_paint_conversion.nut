// ███╗   ███╗██████╗             █████╗  █████╗  █████╗ ██████╗            ██████╗  █████╗ ██╗███╗  ██╗████████╗            █████╗  █████╗ ███╗  ██╗██╗   ██╗███████╗██████╗  ██████╗██╗ █████╗ ███╗  ██╗
// ████╗ ████║██╔══██╗           ██╔══██╗██╔══██╗██╔══██╗██╔══██╗           ██╔══██╗██╔══██╗██║████╗ ██║╚══██╔══╝           ██╔══██╗██╔══██╗████╗ ██║██║   ██║██╔════╝██╔══██╗██╔════╝██║██╔══██╗████╗ ██║
// ██╔████╔██║██████╔╝           ██║  ╚═╝██║  ██║██║  ██║██████╔╝           ██████╔╝███████║██║██╔██╗██║   ██║              ██║  ╚═╝██║  ██║██╔██╗██║╚██╗ ██╔╝█████╗  ██████╔╝╚█████╗ ██║██║  ██║██╔██╗██║
// ██║╚██╔╝██║██╔═══╝            ██║  ██╗██║  ██║██║  ██║██╔═══╝            ██╔═══╝ ██╔══██║██║██║╚████║   ██║              ██║  ██╗██║  ██║██║╚████║ ╚████╔╝ ██╔══╝  ██╔══██╗ ╚═══██╗██║██║  ██║██║╚████║
// ██║ ╚═╝ ██║██║     ██████████╗╚█████╔╝╚█████╔╝╚█████╔╝██║     ██████████╗██║     ██║  ██║██║██║ ╚███║   ██║   ██████████╗╚█████╔╝╚█████╔╝██║ ╚███║  ╚██╔╝  ███████╗██║  ██║██████╔╝██║╚█████╔╝██║ ╚███║
// ╚═╝     ╚═╝╚═╝     ╚═════════╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝     ╚═════════╝╚═╝     ╚═╝  ╚═╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═════════╝ ╚════╝  ╚════╝ ╚═╝  ╚══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝ ╚════╝ ╚═╝  ╚══╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        Entities.FindByName(null, "disassembler_1_door_blocker").Destroy()
        Entities.FindByName(null, "disassembler_2_door_blocker").Destroy()

        Entities.FindByName(null, "disassembler_1_door_2").Destroy()
        Entities.FindByName(null, "disassembler_1_door_1").Destroy()

        Entities.FindByName(null, "disassembler_2_door_2").Destroy()
        Entities.FindByName(null, "disassembler_2_door_1").Destroy()
    }

    if (MSPostPlayerSpawn==true) {

    }

    if (MSLoop==true) {

    }
}