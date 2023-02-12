CommandList.push(
    class {
        name = "kick"
        level = 6

        // !kick (player to kick here) (optional remove argument)
        function CC(p, args) {
            PlayerKickList <- {}

            // arg[0] -> player to kick
            args[0] = Strip(args[0])
            local plr = FindPlayerByName(args[0])
            // arg[1] -> optional remove argument
            args[1] = Strip(args[1])

            local KickPlayer = function(plr) {
                EntFireByHandle(p2mm_clientcommand, "Command", "disconnect \"You've been kicked from the server.\"", 0, plr, plr)
                PlayerKickList.push(FindPlayerClass(plr).steamid)
                dataSystemKick(null, plr)
            }

            if ((args.len() == 0) || (args.len() > 2)) {
                SendChatMessage("[ERROR] Please input a player name and/or a optional argument.", p)
                return
            }

            try {
                if (plr == null) {
                    SendChatMessage("[ERROR] Player not found.", p)
                    return
                }

                if (args.len() == 1) {
                    if (plr == p) {
                        SendChatMessage("[ERROR] You're trying to kick yourself.", p)
                        return
                    }
                    if (plr != p) {
                        KickPlayer(plr)
                        return
                    }
                }

                if (args.len() == 2) {
                    if (plr == p) {
                        SendChatMessage("[ERROR] You're trying to kick yourself.", p)
                        return
                    }
                    if (plr != p) {
                        if ((plr != null) && (args[1] = "remove")) {
                            PlayerKickList.remove(FindPlayerClass(plr).steamid)
                            SendChatMessage(FindPlayerClass(plr).username + " has been unkicked from the server...", p)
                            return
                        }
                    }
                }
            } catch (exception) {
                SendChatMessage("[ERROR] An error occured trying to run that command, check console...", p)
                return
            }

            // Send this message right before kicking in case the class gets destroyed
            SendChatMessage("[KICK] Kicked " + FindPlayerClass(FindPlayerByName(args[0])).username + " from the server.")

            // Players can still join the game again if you use this
            EntFire("p2mm_servercommand", "command", "kick " + FindPlayerClass(FindPlayerByName(args[0])).username)
        }
    }
)