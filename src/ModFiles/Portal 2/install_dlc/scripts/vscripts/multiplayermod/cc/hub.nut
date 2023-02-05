CommandList.push(
    class {
        name = "hub"
        level = 5

        // !hub
        function CC(p, args) {
            for (local ent; ent = Entities.FindByClassname(ent, "player");) {
                EntFireByHandle(p2mm_clientcommand, "Command", "playvideo_end_level_transition coop_bots_load 1", 0, ent, ent)
            }
            local lobby_type = "3"
            if (!IsMapValid("mp_coop_lobby_3")) {
                // printlP2MM("Server does not have mp_coop_lobby_3! Reverting to mp_coop_lobby_2.")
                lobby_type = "2"
            }
            EntFire("p2mm_servercommand", "command", "changelevel mp_coop_lobby_" + lobby_type, 1, p)
        }
    }
)