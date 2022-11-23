CommandList.push(
    class {
        name = "spectate"
        level = 0

        // !spectate
        function CC(p, args) {
            EntFireByHandle(p, "addoutput", "teamnumber 3", 0, p, p)
            EntFireByHandle(p2mm_clientcommand, "command", "spectate", 0, p, p)
            // EntFireByHandle(p, "addoutput", "teamnumber 3", 3.71, p, p)
            // EntFireByHandle(p2mm_clientcommand, "command", "spectate", 3.72, p, p)
            EntFireByHandle(p, "addoutput", "teamnumber 3", 5, p, p)
            EntFireByHandle(p2mm_clientcommand, "command", "spectate", 5.5, p, p)
        }
    }
)