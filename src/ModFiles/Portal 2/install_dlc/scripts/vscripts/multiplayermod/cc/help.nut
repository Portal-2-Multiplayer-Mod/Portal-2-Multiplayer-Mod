commandtable <- {}
commandtable["adminmodify"] <- "Prints the admin level of someone or assigns them a new level."
// commandtable["ban"] <- "Bans a player from the play session and will prevent them from joinning again for future play sessions."
commandtable["changeteam"] <- "Changes your current team."
commandtable["help"] <- "List available commands or print a description of a specific one."
// commandtable["kick"] <- "Kicks acts as a temp ban, kicks the player from the play session and won't let them back in until the next session."
commandtable["kill"] <- "Kill yourself, others, or \"all\"."
commandtable["mpcourse"] <- "Changes the level to the specified cooperative course."
commandtable["noclip"] <- "Toggles your noclip status."
commandtable["playercolor"] <- "Changes your player model's color through valid RGB values."
commandtable["rcon"] <- "Execute commands on the server console."
commandtable["restartlevel"] <- "Reset the current map."
commandtable["rocket"] <- "Send yourself, others, or \"all\" into the air for them to blow up."
commandtable["slap"] <- "Slap yourself, others, or \"all\" dealing a tiny amount of damage and jolting."
commandtable["spchapter"] <- "Changes the level to the specified singleplayer chapter."
// commandtable["spectate"] <- "Allows you to spectate players and roam around the map."
commandtable["speed"] <- "Changes your player speed."
commandtable["teleport"] <- "Teleports a specific player or \"all\" to you or another player."
// commandtable["vote"] <- "Invoke this to get a headcount on whether something should happen or not."

CommandList.push(
    class {
        name = "help"
        level = 0

        // !help (optionally with command name arg)
        function CC(p, args) {
            try {
                args[0] = Strip(args[0])
                if (commandtable.rawin(args[0])) {
                    EntFireByHandle(p2mm_clientcommand, "Command", "say [HELP] " + args[0] + ": " + commandtable[args[0]], 0, p, p)
                }
                else {
                    EntFireByHandle(p2mm_clientcommand, "Command", "say [HELP] Unknown chat command: " + args[0], 0, p, p)
                }
            } catch (exception) {
                SendChatMessage("[HELP] Your available commands:", p)
                foreach (command in CommandList) {
                    if (command.level <= GetAdminLevel(p)) {
                        SendChatMessage("[HELP] " + command.name, p)
                    }
                }
                SendChatMessage("[HELP] This command can also print a description for another if supplied with it.", p)
            }
        }
    }
)