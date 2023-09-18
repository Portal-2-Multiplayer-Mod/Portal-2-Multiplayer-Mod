CommandList.push(
    class {
        name = "password"
        level = 6

        // !password (password)
        function CC(p, args) {
            // If there is no specified password, remove the password off the server
            if (args.len() == 0) {
                EntFire("p2mm_servercommand", "command", "sv_password \"\"")
                SendChatMessage("[PASSWORD] Removed password off server!")
                return
            }

            if (args.len() > 1) {
                SendChatMessage("[ERROR] Too many arguments given.", p)
                return
            }

            if (args.len() == 1) {
                local password = args[0]
                password = Strip(password)

                // Set the server password for the server
                EntFire("p2mm_servercommand", "command", "sv_password " + password)
                SendChatMessage("[PASSWORD] Set server password to: " + password)
            }
        }
    }
)