CommandList.push(
    class {
        name = "rcon"
        level = 6

        // !rcon (args)
        function CC(p, args) {
            try {
                args[0] = strip(args[0])
                local cmd = Join(args, "")
                EntFireByHandle(Entities.FindByName(null, "p2mm_servercommand"), "command", cmd, 0, p, p)
            } catch (exception) {
                SendChatMessage("[RCON] Input a command.", p)
                return
            }
            SendChatMessage("[RCON] Command sent.", p)
        }
    }
)