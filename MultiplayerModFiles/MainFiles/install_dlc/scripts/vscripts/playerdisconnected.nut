try {
    if (dismessage) {
        if (GetDeveloperLevel() == 1) {
            printl("Disconnect message entity already exists! Handling...");
        }
    }
}   catch(exception) {
        disconnectmessagedisplay <- Entities.CreateByClassname("game_text")
        if (GetDeveloperLevel() == 1) {
            printl("Created disconnect message entity!");
        }
    dismessage <- true
}
// Create a join message entity
    disconnectmessagedisplay.__KeyValueFromString("targetname", "disconnectmessagedisplaympmod")
    disconnectmessagedisplay.__KeyValueFromString("holdtime", "3")
    disconnectmessagedisplay.__KeyValueFromString("fadeout", "0.2")
    disconnectmessagedisplay.__KeyValueFromString("fadein", "0.2")
    disconnectmessagedisplay.__KeyValueFromString("spawnflags", "1")
    disconnectmessagedisplay.__KeyValueFromString("color", "140 40 40")
    disconnectmessagedisplay.__KeyValueFromString("channel", "3")
    disconnectmessagedisplay.__KeyValueFromString("message", "Player disconnected")
    EntFireByHandle(disconnectmessagedisplay, "display", "", 0.0, null, null)
    //disconnectmessagedisplay.__KeyValueFromString("x", "0.1")
    //disconnectmessagedisplay.__KeyValueFromString("y", "0.1")