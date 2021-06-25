dismessage <- Entities.CreateByClassname("env_instructor_hint")
dismessage.__KeyValueFromString("hint_icon_onscreen", "icon_caution");
dismessage.__KeyValueFromString("targetname", "dismessage");
dismessage.__KeyValueFromString("hint_caption", "Player Disconnected");
dismessage.__KeyValueFromString("hint_color", "255 200 0");
dismessage.__KeyValueFromString("hint_timeout", "3");
DoEntFire("dismessage", "showhint", "", 0.0, null, "")