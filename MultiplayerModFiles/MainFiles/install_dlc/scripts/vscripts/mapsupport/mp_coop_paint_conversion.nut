// ███╗   ███╗██████╗             █████╗  █████╗  █████╗ ██████╗            ██████╗  █████╗ ██╗███╗  ██╗████████╗            █████╗  █████╗ ███╗  ██╗██╗   ██╗███████╗██████╗  ██████╗██╗ █████╗ ███╗  ██╗
// ████╗ ████║██╔══██╗           ██╔══██╗██╔══██╗██╔══██╗██╔══██╗           ██╔══██╗██╔══██╗██║████╗ ██║╚══██╔══╝           ██╔══██╗██╔══██╗████╗ ██║██║   ██║██╔════╝██╔══██╗██╔════╝██║██╔══██╗████╗ ██║
// ██╔████╔██║██████╔╝           ██║  ╚═╝██║  ██║██║  ██║██████╔╝           ██████╔╝███████║██║██╔██╗██║   ██║              ██║  ╚═╝██║  ██║██╔██╗██║╚██╗ ██╔╝█████╗  ██████╔╝╚█████╗ ██║██║  ██║██╔██╗██║
// ██║╚██╔╝██║██╔═══╝            ██║  ██╗██║  ██║██║  ██║██╔═══╝            ██╔═══╝ ██╔══██║██║██║╚████║   ██║              ██║  ██╗██║  ██║██║╚████║ ╚████╔╝ ██╔══╝  ██╔══██╗ ╚═══██╗██║██║  ██║██║╚████║
// ██║ ╚═╝ ██║██║     ██████████╗╚█████╔╝╚█████╔╝╚█████╔╝██║     ██████████╗██║     ██║  ██║██║██║ ╚███║   ██║   ██████████╗╚█████╔╝╚█████╔╝██║ ╚███║  ╚██╔╝  ███████╗██║  ██║██████╔╝██║╚█████╔╝██║ ╚███║
// ╚═╝     ╚═╝╚═╝     ╚═════════╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝     ╚═════════╝╚═╝     ╚═╝  ╚═╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═════════╝ ╚════╝  ╚════╝ ╚═╝  ╚══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝ ╚════╝ ╚═╝  ╚══╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (GetMapName()=="mp_coop_paint_conversion") {
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
}