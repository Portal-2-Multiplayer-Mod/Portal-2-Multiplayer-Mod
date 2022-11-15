CommandList.push(
class {
    name = "slap"
    level = 4

    // !slap (player or "all")
    function CC(p, args) {
        if (args.len() == 0) {
            return SendChatMessage("[ERROR] Input a player name.", p)
        }

        args[0] = Strip(args[0])
        if (args[0] == "all") {
            for (local ent; ent = Entities.FindByClassname(ent, "player");) {
                EntFireByHandle(ent, "sethealth", "-30", 0, p, p)
                ent.SetVelocity(Vector(RandomInt(500, 600), RandomInt(500, 600), RandomInt(500, 600)))
            }
        } else {
            local q = FindPlayerByName(args[0])
            if (q == null) {
                return SendChatMessage("[ERROR] Player not found.", p)
            } else {
                EntFireByHandle(q, "sethealth", "-50", 0, p, p)
                q.SetVelocity(Vector(RandomInt(500, 600), RandomInt(500, 600), RandomInt(500, 600)))
            }
        }
    }
}
)