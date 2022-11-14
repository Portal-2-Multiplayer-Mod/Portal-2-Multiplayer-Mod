CommandList.push(
    class {
        name = "kick"
        level = 6

        // !kick (player to kick here)
        function CC(p, args) {
            if (args.len() == 0) {
                SendChatMessage("[ERROR] Input a player name.", p)
                return
            }

            args[0] = Strip(args[0])

            if (FindPlayerByName(args[0]) == null) {
                SendChatMessage("[ERROR] Player not found.", p)
                return
            } else {
                if (FindPlayerByName(args[0]) == p) {
                    SendChatMessage("[ERROR] Cannot ban yourself!", p)
                    return
                }
                SendToConsoleP2MM("kick " + p)
            }
        }
    }
)