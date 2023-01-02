CommandList.push(
    class {
        name = "teleport"
        level = 4

        // !teleport (going to this username) (bring this player or "all")
        function CC(p, args) {

            if (args.len() == 0) {
                SendChatMessage("[ERROR] Input a player name.", p)
                return
            }
            if (args.len() > 2) {
                SendChatMessage("[ERROR] Too many arguments given.", p)
                return
            }

            // args[0] -> player to teleport to
            // args[1] if exist -> player to bring
            args[0] = Strip(args[0])

            local plr = FindPlayerByName(args[0])

            if (plr == null) {
                SendChatMessage("[ERROR] Player not found.", p)
                return
            }

            if (args.len() == 1){
                if (plr == p) {
                    SendChatMessage("[ERROR] You are already here.", p)
                    return
                }

                p.SetOrigin(plr.GetOrigin())
                p.SetAngles(plr.GetAngles().x, plr.GetAngles().y, plr.GetAngles().z)
                SendChatMessage("Teleported to player.", p)
                return
            }

            args[1] = Strip(args[1])
            local plr2 = FindPlayerByName(args[1])

            if (args[1] != "all" && plr2 == null){
                SendChatMessage("[ERROR] Third argument is invalid! Use \"all\" or a player's username.", p)
                return
            }

            // if second argument was "all"
            if (args[1] == "all") {
                local q = null
                while (q = Entities.FindByClassname(q, "player")) {
                    // Don't modify the player we are teleporting to
                    if (q != plr) {
                        q.SetOrigin(plr.GetOrigin())
                        q.SetAngles(plr.GetAngles().x, plr.GetAngles().y, plr.GetAngles().z)
                    }
                }
                if (plr == p) {
                    SendChatMessage("Brought all players.")
                } else {
                    SendChatMessage("Teleported all players.")
                }
                return
            }

            if (plr == p && plr == plr2) {
                SendChatMessage("[ERROR] Can't teleport player to the same player.", p)
                return
            }

            // if the second argument is a player
            plr2.SetOrigin(plr.GetOrigin())
            plr2.SetAngles(plr.GetAngles().x, plr.GetAngles().y, plr.GetAngles().z)
            if (plr2 == p) {
                SendChatMessage("Teleported to player.", p)
                return
            } else {
                // Special case for changing chat color to a mildly dark green
                SendToChat("\x05(P2:MM): Teleported player.", p.entindex())
                SendToChat("\x05(P2:MM): Teleported player.", plr2.entindex()) // Notify the other player who got teleported as well
                return
            }
        }
    }
)