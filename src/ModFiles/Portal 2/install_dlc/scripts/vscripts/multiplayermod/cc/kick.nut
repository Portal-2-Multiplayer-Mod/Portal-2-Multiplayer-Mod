CommandList.push(
    class {
        name = "kick"
        level = 6

        // !kick (player to kick here) (optional argument)
        function CC(p, args) {
            local PlayerKickList <- []
            local KickPlayer = function(player) {
                EntFireByHandle(p2mm_clientcommand, "Command", "disconnect You've been kicked from the server...")
                PlayerKickList.insert(player)
                SendChatMessage(player + "has been kicked from the server...", p)
            }

            if ((args.len() == 0) or (args.len() > 2)) {
                SendChatMessage("[ERROR] Please input a player name and/or a optional argument.", p)
                return
            }

            // arg[0] -> player to kick
            args[0] = Strip(args[0])
            local plr = FindPlayerByName(args[0])
            // arg[1] -> optional argument
            args[1] = Strip(args[1])

            try {
                if (plr = null) {
                    SendChatMessage("[ERROR] Player not found.", p)
                    return
                }

                if (args.len() = 1) {
                    if (plr = p) {
                        return SendChatMessage("[ERROR] You're trying to kick yourself.", p)
                    }
                    if (plr != p) {
                        KickPlayer(plr)
                    }
                }

                if (args.len() = 2) {
                    if (plr = p) {
                        return SendChatMessage("[ERROR] You're trying to kick yourself.", p)
                    }
                    if (plr != p) {
                        if (args[1] = "remove") {
                            KickPlayer(plr)
                        }
                    }
                }
            }
            
        }
    }
)