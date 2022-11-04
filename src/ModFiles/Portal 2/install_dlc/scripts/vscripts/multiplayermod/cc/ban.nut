CommandList.push(
    class {
        name = "ban"
        level = 6

        // !ban (player to kick here) (optional remove argument)
        function CC(p, args) {

            if (args.len() == 0) {
                SendChatMessage("[ERROR] Input a player name and a optional argument.", p)
                return
            }
            if (args.len() > 2) {
                SendChatMessage("[ERROR] Please put a player name and a optional argument.", p)
                return
            }

            // arg[0] -> player to ban
            args[0] = Strip(args[0])

            local plr = FindPlayerByName(args[0])

            if (plr == null) {
                SendChatMessage("[ERROR] Player not found.", p)
                return
            }

            if (args.len() == 1) {
                if (plr == p) {
                    SendChatMessage("[ERROR] You're trying to ban yourself.", p)
                    return
                }

                SendToConsoleP2MM("kick" + p)
            }
        }
    }
)