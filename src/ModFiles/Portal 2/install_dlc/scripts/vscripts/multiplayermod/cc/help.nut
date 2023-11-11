commandtable <- {}
commandtable["adminmodify"] <- "Prints the admin level of someone or assigns them a new level."
commandtable["changeteam"] <- "Changes your current team."
commandtable["help"] <- "List available commands or print a description of a specific one."
commandtable["kick"] <- "Kicks acts as a temp ban, kicks the player from the play session and won't let them back in until the next session."
commandtable["kill"] <- "Kill yourself, others, or \"all\"."
commandtable["mpcourse"] <- "Changes the level to the specified cooperative course."
commandtable["noclip"] <- "Toggles your noclip status."
commandtable["playercolor"] <- "Changes your player model's color through valid RGB values."
commandtable["rcon"] <- "Execute commands on the server console."
commandtable["restartlevel"] <- "Reset the current map."
commandtable["rocket"] <- "Send yourself, others, or \"all\" into the air for them to blow up."
commandtable["slap"] <- "Slap yourself, others, or \"all\" dealing a tiny amount of damage and jolting."
commandtable["spchapter"] <- "Changes the level to the specified singleplayer chapter."
commandtable["speed"] <- "Changes your player speed."
commandtable["teleport"] <- "Teleports a specific player or \"all\" to you or another player."
commandtable["vote"] <- "Invoke this to get a headcount on whether something should happen or not."

CommandList.push(
    class {
        name = "help"
        level = 0

        // !help (optional command name arg)
        function CC(p, args) {
            try {
                args[0] = strip(args[0])
                if (commandtable.rawin(args[0])) {
                    SendChatMessage("[HELP] " + args[0] + ": " + commandtable[args[0]], p)
                }
                else {
                    SendChatMessage("[HELP] Unknown chat command: " + args[0], p)
                }
            } catch (exception) {
                SendChatMessage("[HELP] Target group operations:")
                SendChatMessage("[HELP] \"@a\": Everyone")
                SendChatMessage("[HELP] \"@b\": Team Atlas")
                SendChatMessage("[HELP] \"@o\": Team P-Body")
                SendChatMessage("[HELP] Your available commands:", p)
                local availablecommands = ""
                foreach (command in CommandList) {
                    if (command.level <= GetAdminLevel(p)) {
                        // 100 characters max allowed in chat box per message
                        if ((availablecommands + command.name + ", ").len() >= 100) {
                            // Print it out
                            SendChatMessage("[HELP] " + availablecommands.slice(0, availablecommands.len() - 2), p) // Remove excess comma and space
                            availablecommands = ""
                        }
                        availablecommands = availablecommands + command.name + ", "
                    }
                }
                SendChatMessage("[HELP] " + availablecommands.slice(0, availablecommands.len() - 2), p) // Remove excess comma and space
                // SendChatMessage("[HELP] This command can also print a description for another if supplied with it.", p) // bloated the chat
            }
        }
    }
)