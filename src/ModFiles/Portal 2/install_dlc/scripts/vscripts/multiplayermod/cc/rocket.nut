CommandList.push(
    class {
        name = "rocket"
        level = 3

        // !rocket (player or "all")
        function CC(p, args) {
            local RocketPlayer = function(player) {
                local currentplayerclass = FindPlayerClass(player)
                player.SetVelocity(Vector(player.GetVelocity().x, player.GetVelocity().y, 500))
                currentplayerclass.rocket <- true
            }

            if (args.len() == 0) {
                RocketPlayer(p)
                SendChatMessage("Rocketed yourself.", p)
                return
            }

            args[0] = strip(args[0])
            if (args[0] == "all") {
                for (local ent; ent = Entities.FindByClassname(ent, "player");) {
                    RocketPlayer(ent)
                }
                SendChatMessage("Rocketed all players.", p)
            } else {
                local q = FindPlayerByName(args[0])
                if (q == null) {
                    SendChatMessage("[ERROR] Player not found!", p)
                    return
                } else {
                    RocketPlayer(q)
                    SendChatMessage("Rocketed player.", p)
                }
            }
        }
    }
)