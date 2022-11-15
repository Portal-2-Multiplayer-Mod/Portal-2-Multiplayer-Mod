CommandList.push(
    class {
        name = "rcon"
        level = 6

        // !rcon (args)
        function CC(p, args) {
            try {
                args[0] = Strip(args[0])
                local cmd = Join(args, "")
                SendToConsoleP2MM(cmd)
            } catch (exception) {
                EntFireByHandle(p2mm_clientcommand, "Command", "say [ERROR] Input a command.", 0, p, p)
            }
        }
    }
)