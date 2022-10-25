CommandList.push(
    class {
        name = "rocket"
        level = 3

        // !rocket (player or "all")
        function CC(p, args) {
            if (args.len() == 0) {
                RocketPlayer(p)
                return
            }

            local RocketPlayer = function(player) {
                local currentplayerclass = FindPlayerClass(player)
                player.SetVelocity(Vector(player.GetVelocity().x, player.GetVelocity().y, 500))
                currentplayerclass.rocket <- true
            }

            args[0] = Strip(args[0])
            if (args[0] == "all") {
                for (local ent; ent = Entities.FindByClassname(ent, "player");) {
                    RocketPlayer(ent)
                }
            } else {
                local q = FindPlayerByName(args[0])
                if (q == null) {
                    return SendChatMessage("[ERROR] Player not found.", p)
                } else {
                    RocketPlayer(q)
                }
            }
        }
    }
)