try {
    if (dismessage) {
        printl("Disconnect Message Entity Already Exists Handling");
    }
} catch(exception) {
    dismessage <- Entities.CreateByClassname("env_instructor_hint");
    printl("Created Disconnect Message Entity");
} // disconnect hud manager
dismessage.__KeyValueFromString("hint_icon_onscreen", "icon_alert_red");
dismessage.__KeyValueFromString("targetname", "dismessage");
dismessage.__KeyValueFromString("hint_caption", "Player Disconnected");
dismessage.__KeyValueFromString("hint_color", "255 70 70");
dismessage.__KeyValueFromString("hint_timeout", "3");
DoEntFire("dismessage", "showhint", "", 0.0, null, "");