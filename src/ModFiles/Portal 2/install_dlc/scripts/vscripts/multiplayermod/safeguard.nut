/////////////////////// VScript COMMAND REPLACEMENTS

if (SafeGuard) {
    try {
        if ( ::SendToConsole.getinfos().native ) { // Replace SendToConsole with SendToConsoleP232
            ::SendToConsoleP232 <- ::SendToConsole;;

            SendToConsole <- function(str) {
                printl("=======================================")
                printl("=======================================")
                printl("PATCHED COMMAND WAS ATTEMPTED TO BE RAN")
                printl("")
                printl("COMMAND: " + str)
                printl("")
                printl("this is probably game logic running in")
                printl("the background. But it could ba a")
                printl("player that is attempting to exploit")
                printl("the game. So we're going to stop it.")
                printl("")
                printl("(once again its probably just the game)")
                printl("=======================================")
                printl("=======================================")
            }
        }
    } catch (e) {}
} else {
    SendToConsoleP232 <- function(str) { SendToConsole(str) }
}

////////////////////////////////////////////