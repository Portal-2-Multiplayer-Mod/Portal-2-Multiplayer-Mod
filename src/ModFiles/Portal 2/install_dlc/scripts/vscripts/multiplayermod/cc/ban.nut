CommandList.push(
    class {
        name = "ban"
        level = 6

        // !ban (player to ban here) (optional remove argument)
        function CC(p, args) {
            PlayerBanList <- {}

            // arg[0] -> player to ban
            args[0] = Strip(args[0])
            local plr = FindPlayerByName(args[0])
            // arg[1] -> optional remove argument
            args[1] = Strip(args[1])

            PlayerBanList <- []
            local BanPlayer = function(plr) {
                EntFireByHandle(p2mm_clientcommand, "Command", "disconnect \"You've been banned from the server.\"", 0, plr, plr)
                PlayerBanList.push(FindPlayerClass(plr).steamid)
                dataSystemBan(null, plr)
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
                        SendChatMessage("[ERROR] You're trying to ban yourself.", p)
                        return
                    }
                    if (plr != p) {
                        BanPlayer(plr)
                    }
                }

                if (args.len() == 2) {
                    if (plr == p) {
                        SendChatMessage("[ERROR] You're trying to ban yourself.", p)
                        return
                    }
                    if (plr != p) {
                        if ((plr != null) && (args[1] = "remove")) {
                            PlayerBanList.remove(FindPlayerClass(plr).steamid)
                            SendChatMessage(FindPlayerClass(plr).username + " has been unbanned from the server...", p)
                            return
                        }
                    }
                }
            } catch (exception) {
                SendChatMessage("[ERROR] An error occured trying to run that command, check console...", p)
                return
            }
        }
    }
)