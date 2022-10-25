CommandList.push(
    class {
        name = "kill"
        level = 0

        // !kill
        function CC(p, args) {
            local KillPlayer = function(player) {
                EntFireByHandle(player, "sethealth", "-100", 0, player, player)
            }
            local KillPlayerMessage = function(iTextIndex, player) {
                KillPlayerText <- [
                    "Killed yourself.",
                    "Killed player.",
                    "Killed all players."
                    "[ERROR] Player not found."
                ]
                SendChatMessage(KillPlayerText[iTextIndex], player)
            }

            if (GetAdminLevel(p) < 2) {
                KillPlayer(p)
                KillPlayerMessage(0, p)
            }
            else if (GetAdminLevel(p) >= 2) {
                try {
                    args[0] = Strip(args[0])

                    if (args[0] != "all") {
                        local q = FindPlayerByName(args[0])
                        if (q != null) {
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
                    KillPlayer(p)
                    KillPlayerMessage(0, p)
                }
            }
        }
    }
)