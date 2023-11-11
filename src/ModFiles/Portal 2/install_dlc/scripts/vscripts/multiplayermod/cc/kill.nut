CommandList.push(
    class {
        name = "kill"
        level = 0

        // !kill (optional player)
        function CC(p, args) {
            local KillPlayer = function(player) {
                if (player.GetHealth() == 0) { return }
                EntFireByHandle(player, "sethealth", "-100", 0, player, player)
            }
            local KillPlayerMessage = function(iTextIndex, player) {
                KillPlayerText <- [
                    "Killed yourself.",
                    "Killed player.",
                    "Killed all players."
                    "[ERROR] Player not found!"
                    "You are already dead!"
                    "Player is already dead!"
                ]
                SendChatMessage(KillPlayerText[iTextIndex], player)
            }

            if (GetAdminLevel(p) < 2) {
                KillPlayer(p)
                KillPlayerMessage(0, p)
            }
            else if (GetAdminLevel(p) >= 2) {
                try {
                    args[0] = strip(args[0])

                    if (args[0] != "all") {
                        local q = FindPlayerByName(args[0])
                        if (q != null) {
                            if (q.GetHealth() == 0) {
                                KillPlayerMessage(5, p)
                                return
                            }
                            KillPlayer(q)
                            KillPlayerMessage(1, p)
                        } else {
                            KillPlayerMessage(3, p)
                        }
                    } else {
                        local p2 = null
                        while (p2 = Entities.FindByClassname(p2, "player")) {
                            KillPlayer(p2)
                        }
                        KillPlayerMessage(2, p)
                    }
                } catch (exception) {
                    if (p.GetHealth() == 0) {
                        KillPlayerMessage(4, p)
                        return
                    }
                    KillPlayer(p)
                    KillPlayerMessage(0, p)
                }
            }
        }
    }
)