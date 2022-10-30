teams <- [
    "Singleplayer",
    "Spectator", // This is not used at all since respawning is broken
    "Red",
    "Blue"
]

CommandList.push(
    class {
        name = "changeteam"
        level = 0

        // !changeteam (optionally with args)
        function CC(p, args) {
            try {
                args[0] = Strip(args[0])
                if (args[0] == "0" || args[0] == "2" || args[0] == "3" ) {
                    if (p.GetTeam() == args[0].tointeger()) {
                        return EntFireByHandle(p2mm_clientcommand, "Command", "say [ERROR] You are already on this team.", 0, p, p)
                    } else {
                        p.SetTeam(args[0].tointeger())
                        return EntFireByHandle(p2mm_clientcommand, "Command", "say Team is now set to " + teams[args[0].tointeger()] + ".", 0, p, p)
                    }
                }
                EntFireByHandle(p2mm_clientcommand, "Command", "say [ERROR] Enter a valid team number: 0, 2, or 3.", 0, p, p)
            } catch (exception) {
                // No argument, so just cycle through the teams
                if (args.len() == 0) {
                    local iNewTeam = null
                    switch (p.GetTeam()) {
                        case 0: iNewTeam = 2;   break;
                        // case 1: iNewTeam = 2;   break;
                        case 2: iNewTeam = 3;   break;
                        case 3: iNewTeam = 0;   break;
                    }
                    p.SetTeam(iNewTeam)
                    EntFireByHandle(p2mm_clientcommand, "Command", "say Toggled to " + teams[iNewTeam] + " team.", 0, p, p)
                }
            }
        }
    }
)