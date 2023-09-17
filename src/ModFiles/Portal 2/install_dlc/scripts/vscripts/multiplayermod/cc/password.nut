CommandList.push(
    class {
        name = "password"
        level = 6

        // !password (password)
        function CC(p, args) {
            args[0] = Strip(args[0])
            local password = args[0]
            if (args.len() == 0) {
                EntFire("p2mm_servercommand", "command", "sv_password \" \"")
                return
            }
            
            // Players can still join the game again if you use this
            EntFire("p2mm_servercommand", "command", "sv_password " + password)

            // Send this message right before kicking in case the class gets destroyed
            SendChatMessage("[PASSWORD] Set server password to: " + password)
        }
    }
)