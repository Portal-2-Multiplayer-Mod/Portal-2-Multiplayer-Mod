// ███╗   ███╗██████╗             █████╗  █████╗  █████╗ ██████╗            ██████╗  █████╗ ██╗███╗  ██╗████████╗            █████╗  █████╗ ███╗  ██╗██╗   ██╗███████╗██████╗  ██████╗██╗ █████╗ ███╗  ██╗
// ████╗ ████║██╔══██╗           ██╔══██╗██╔══██╗██╔══██╗██╔══██╗           ██╔══██╗██╔══██╗██║████╗ ██║╚══██╔══╝           ██╔══██╗██╔══██╗████╗ ██║██║   ██║██╔════╝██╔══██╗██╔════╝██║██╔══██╗████╗ ██║
// ██╔████╔██║██████╔╝           ██║  ╚═╝██║  ██║██║  ██║██████╔╝           ██████╔╝███████║██║██╔██╗██║   ██║              ██║  ╚═╝██║  ██║██╔██╗██║╚██╗ ██╔╝█████╗  ██████╔╝╚█████╗ ██║██║  ██║██╔██╗██║
// ██║╚██╔╝██║██╔═══╝            ██║  ██╗██║  ██║██║  ██║██╔═══╝            ██╔═══╝ ██╔══██║██║██║╚████║   ██║              ██║  ██╗██║  ██║██║╚████║ ╚████╔╝ ██╔══╝  ██╔══██╗ ╚═══██╗██║██║  ██║██║╚████║
// ██║ ╚═╝ ██║██║     ██████████╗╚█████╔╝╚█████╔╝╚█████╔╝██║     ██████████╗██║     ██║  ██║██║██║ ╚███║   ██║   ██████████╗╚█████╔╝╚█████╔╝██║ ╚███║  ╚██╔╝  ███████╗██║  ██║██████╔╝██║╚█████╔╝██║ ╚███║
// ╚═╝     ╚═╝╚═╝     ╚═════════╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝     ╚═════════╝╚═╝     ╚═╝  ╚═╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═════════╝ ╚════╝  ╚════╝ ╚═╝  ╚══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝ ╚════╝ ╚═╝  ╚══╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn, MSOnSave, MSOnSaveCheck, MSOnSaveLoad) {
    if (MSInstantRun) {
        Entities.FindByName(null, "disassembler_1_door_blocker").Destroy()
        Entities.FindByName(null, "disassembler_2_door_blocker").Destroy()

        Entities.FindByName(null, "disassembler_1_door_2").Destroy()
        Entities.FindByName(null, "disassembler_1_door_1").Destroy()

        Entities.FindByName(null, "disassembler_2_door_2").Destroy()
        Entities.FindByName(null, "disassembler_2_door_1").Destroy()
    }
}