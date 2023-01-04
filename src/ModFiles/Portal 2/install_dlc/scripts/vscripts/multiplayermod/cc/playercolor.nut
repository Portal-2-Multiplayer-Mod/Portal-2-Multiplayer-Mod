CommandList.push(
    class {
        name = "playercolor"
        level = 0

        // !playercolor (r OR reset) (g) (b) (optional: someone's name)
        function CC(p, args) {
            local ErrorOut = function(p) {
                SendChatMessage("Type in three valid RGB integers from 0 to 255 separated by a space OR 'reset'.", p)
            }

            try {
                args[0] = Strip(args[0])
            } catch (exception) {
                return ErrorOut(p)
            }

            if (args[0] == "reset") {
                local pTargetPlayer = p
                local pTargetPlayerText = "your"
                try {
                    args[1] = Strip(args[1])
                    local plr = FindPlayerByName(args[1])
                    if (plr == null) {
                        return SendChatMessage("[ERROR] Player not found.", pTargetPlayer)
                    }
                    if (plr != p) {
                        pTargetPlayer = plr
                        pTargetPlayerText = FindPlayerClass(pTargetPlayer).username + "'s"
                    }

                } catch (exception) {}
                // Update the player class (RESET BACK TO DEFAULT WITH MULTIPLYING)
                FindPlayerClass(pTargetPlayer).color = GetPlayerColor(pTargetPlayer)

                // Color the player without multiplying the value
                local pColor = GetPlayerColor(pTargetPlayer, false)
                EntFireByHandle(pTargetPlayer, "color", pColor.r + " " + pColor.g + " " + pColor.b, 0, p, p)
                if (pTargetPlayer != p) {
                    // Send to other player as well
                    // Special case for changing chat color to a mildly dark green
                    SendToChat("\x05(P2:MM): Successfully reset " + pTargetPlayerText + " color.", p.entindex())
                    SendToChat("\x05(P2:MM): Successfully reset " + pTargetPlayerText + " color.", pTargetPlayer.entindex()) // Notify the other player who got colored as well
                } else {
                    // Only one person changed color
                    SendChatMessage("Successfully reset " + pTargetPlayerText + " color.", p)
                }
                return
            }

            try {
                args[1] = Strip(args[1])
                args[2] = Strip(args[2])
            } catch (exception) {
                return ErrorOut(p)
            }

            local IsCustomRGBIntegerValid = function(x) {
                try {
                    x = x.tointeger()
                } catch (err) {
                    return false
                }

                if (x >= 0 && x <= 255) {
                    return true
                }
                return false
            }

            // Make sure that all args are integers
            for (local i = 0; i < 3 ; i++) {
                if (!IsCustomRGBIntegerValid(args[i])) {
                    return ErrorOut(p)
                }
                args[i] = args[i].tointeger()
            }

            local pTargetPlayer = p
            local pTargetPlayerText = "your"

            // Is there a player name specified?
            try {
                args[3] = Strip(args[3])
                local plr = FindPlayerByName(args[3])

                if (plr == null) {
                    return SendChatMessage("[ERROR] Player not found.", p)
                }

                if (GetAdminLevel(p) < 2 && plr != p) {
                    return SendChatMessage("[ERROR] You need to have admin level 2 or higher to use on others.", p)
                }

                if (plr != p) {
                    pTargetPlayer = plr
                    pTargetPlayerText = FindPlayerClass(plr).username + "'s"
                }
            } catch (exception) {}

            // Doing this so that if someone picks a color that we actually
            // have a preset name for, it will switch the name to it
            local NewColorName = "Custom Color"
            for (local i = 1; i <= 16; i++) {
                local color = GetPlayerColor(i, false)
                if (color.r == args[0] && color.g == args[1] && color.b == args[2]) {
                    NewColorName = color.name
                    break
                }
            }

            // Update the player class
            // Note that the color member variable stores the MULTIPLIED versions
            FindPlayerClass(pTargetPlayer).color = class {
                r = MultiplyRGBValue(args[0])
                g = MultiplyRGBValue(args[1])
                b = MultiplyRGBValue(args[2])
                name = NewColorName
            }

            // Change the color
            EntFireByHandle(pTargetPlayer, "color", args[0].tostring() + " " + args[1].tostring() + " " + args[2].tostring(), 0, p, p)

            if (pTargetPlayer != p) {
                // Send to other player as well
                // Special case for changing chat color to a mildly dark green
                SendToChat("\x05(P2:MM): Successfully changed " + pTargetPlayerText + " color.", p.entindex())
                SendToChat("\x05(P2:MM): Successfully changed " + pTargetPlayerText + " color.", pTargetPlayer.entindex()) // Notify the other player who got colored as well
            } else {
                // Only one person changed color
                SendChatMessage("Successfully changed " + pTargetPlayerText + " color.", p)
            }
        }
    }
)