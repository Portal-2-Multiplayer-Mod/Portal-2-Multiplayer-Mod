CommandList.push(
    class {
        name = "adminmodify"
        level = 6

        // !adminmodify (player name) (new admin level)
        function CC(p, args) {
            try {
                args[0] = Strip(args[0])
                local plr = FindPlayerByName(args[0])
                try {
                    args[1] = Strip(args[1])
                    args[1] = args[1].tointeger()
                    try {
                        if (typeof args[1] == "integer") {
                            if (args[1] >= 0 && args[1] <= 6) {
                                SetAdminLevel(args[1].tostring(), plr.entindex())
                            }
                        }
                    } catch (exception) {
                        SendChatMessage("[ERROR] Input a number after the player name to set a new admin level.", p)
                        return
                    }
                } catch (exception) {
                    if (plr != null) {
                        SendChatMessage(GetPlayerName(plr.entindex()) + "'s admin level: " + GetAdminLevel(plr), p)
                    } else {
                        SendChatMessage("[ERROR] Player not found.", p)
                    }
                }
            } catch (exception) {
                EntFireByHandle(p2mm_clientcommand, "Command", "say [ERROR] Input a player name.", 0, p, p)
            }
        }
    }
)