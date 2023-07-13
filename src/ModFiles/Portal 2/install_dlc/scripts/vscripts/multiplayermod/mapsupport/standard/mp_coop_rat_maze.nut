// ███╗   ███╗██████╗             █████╗  █████╗  █████╗ ██████╗            ██████╗  █████╗ ████████╗           ███╗   ███╗ █████╗ ███████╗███████╗
// ████╗ ████║██╔══██╗           ██╔══██╗██╔══██╗██╔══██╗██╔══██╗           ██╔══██╗██╔══██╗╚══██╔══╝           ████╗ ████║██╔══██╗╚════██║██╔════╝
// ██╔████╔██║██████╔╝           ██║  ╚═╝██║  ██║██║  ██║██████╔╝           ██████╔╝███████║   ██║              ██╔████╔██║███████║  ███╔═╝█████╗  
// ██║╚██╔╝██║██╔═══╝            ██║  ██╗██║  ██║██║  ██║██╔═══╝            ██╔══██╗██╔══██║   ██║              ██║╚██╔╝██║██╔══██║██╔══╝  ██╔══╝  
// ██║ ╚═╝ ██║██║     ██████████╗╚█████╔╝╚█████╔╝╚█████╔╝██║     ██████████╗██║  ██║██║  ██║   ██║   ██████████╗██║ ╚═╝ ██║██║  ██║███████╗███████╗
// ╚═╝     ╚═╝╚═╝     ╚═════════╝ ╚════╝  ╚════╝  ╚════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═════════╝╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        GameStarted <- false
        HasTauntedBlue <- false
        HasTauntedOrange <- false
    }
    
    if (MSPostPlayerSpawn) {
        GameStarted <- true
    }

    // This is to make up for the patched command to earn the taunt
    // All players will taunt in the spawn room if one person on a team triggers it
    if (MSLoop) {
        if (GameStarted) {
            if (!HasTauntedBlue) {
                local p = null
                while (p = Entities.FindByClassnameWithin(p, "player", Vector(-256, -832, -575.97), 128)) {
                    if (p.GetTeam() == 3) {
                        HasTauntedBlue <- true
                        local q = null
                        while (q = Entities.FindByClassnameWithin(q, "player", Vector(-160, -736, -575.97), 256)) {
                            if (q.GetTeam() == 3) {
                                EntFireByHandle(p2mm_clientcommand, "command", "taunt rps", 0.40, q, q)
                            }
                        }
                    }
                }
            }
            if (!HasTauntedOrange) {
                if (!HasTauntedOrange) {
                    local p = null
                    while (p = Entities.FindByClassnameWithin(p, "player", Vector(-256, -640, -575.97), 128)) {
                        if (p.GetTeam() == 2) {
                            HasTauntedOrange <- true
                            local q = null
                            while (q = Entities.FindByClassnameWithin(q, "player", Vector(-160, -736, -575.97), 256)) {
                                if (q.GetTeam() == 2) {
                                    EntFireByHandle(p2mm_clientcommand, "command", "taunt rps", 0.40, q, q)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
