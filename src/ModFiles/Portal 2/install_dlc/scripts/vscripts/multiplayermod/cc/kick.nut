CommandList.push(
    class {
        name = "kick"
        level = 6

        // !kick (player to kick here)
        function CC(p, args) {
            local KickPlayer = function(player) {
                EntFireByHandle(p2mm_clientcommand, "Command", "kick")
            }

            if (args.len() == 0) {
                SendChatMessage("[ERROR] Input a player name and a optional argument.", p)
                return
            }
            if (args.len() > 2) {
                SendChatMessage("[ERROR] Please put a player name and a optional argument.", p)
                return
            }

            // arg[0] -> player to kick
            args[0] = Strip(args[0])

            local plr = FindPlayerByName(args[0])

            if (plr == null) {
                SendChatMessage("[ERROR] Player not found.", p)
                return
            }

            if (args.len() == 1) {
                if (plr == p) {
                    SendChatMessage("[ERROR] You're trying to kick yourself.", p)
                    return
                }

                SendToConsoleP2MM("kick" + p)
            }
        }
    }
)