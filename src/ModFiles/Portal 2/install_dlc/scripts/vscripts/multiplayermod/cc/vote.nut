// TODO: We have no way of accounting for players
// who leave the game during an active vote. This
// can easily be fixed, but requires one of our hex
// edits to be modified slightly

ShouldDisplayVoteCounter <- false // Should the game_text display to everyone right now?

VoteCounter <- Entities.CreateByClassname("game_text")
VoteCounter.__KeyValueFromString("targetname", "VoteCounter")
VoteCounter.__KeyValueFromString("x", "0.005")
VoteCounter.__KeyValueFromString("y", "0.9")
VoteCounter.__KeyValueFromString("message", "Vote #: 0/0")
VoteCounter.__KeyValueFromString("holdtime", "5")
VoteCounter.__KeyValueFromString("fadeout", "2")
VoteCounter.__KeyValueFromString("fadein", "2")
VoteCounter.__KeyValueFromString("channel", "0")
VoteCounter.__KeyValueFromString("spawnflags", "1")
VoteCounter.__KeyValueFromString("color", "255 255 255")

LastVoteCooldownTime <- Time() // By default, there is no cooldown on map spawn

// We aren't going to modify this class directly, we are just going to clone it
// and read these default values, and store a SHARED instance in this array
VoteInstanceArray <- []
class Vote {
    CurrentTime = null
    ActiveVote = null
    iVotedYes = 0
    iVotedNo = 0
    Arg2 = null

    bVoteInProgress = false
    pVoteInitiator = null
    iCurrentNumberOfPlayers = 0

    function SubmitVote(arg1, arg2) {
        FindPlayerClass(arg2).hasvoted = true
        if (arg1 == "yes") {
            iVotedYes++
        } else {
            iVotedNo++
        }
        Entities.FindByName(null, "VoteCounter").__KeyValueFromString("message", "Vote (Y/N/All): " + iVotedYes.tostring() + "/" + iVotedNo.tostring() + "/" + iCurrentNumberOfPlayers.tostring())
        SendChatMessage("[VOTE] Submitted vote for " + arg1 + ".", arg2)

        // Everyone voted, so let's decide now
        if (iVotedYes + iVotedNo >= iCurrentNumberOfPlayers) {
            DoVote()
        }
    }
    function DoVote(arg1 = null) {
        if (iVotedYes > iVotedNo && arg1 != "fail" || arg1 == "succeed") {
            SendChatMessage("[VOTE] The vote has succeeded.", pVoteInitiator)

            // Add stuff for actually changing in game stuffs
            switch (VoteInstanceArray[0].ActiveVote) { // This literally doesnt work ??
            case "changelevel":
                SendChatMessage("[VOTE] Changing map in 3 seconds.", pVoteInitiator)
                EntFire("p2mm_servercommand", "command", "changelevel " + VoteInstanceArray[0].Arg2, 3, null)
                break
            case "kick":
                SendChatMessage("[VOTE] Kicking player in 3 seconds.", pVoteInitiator)
                EntFire("p2mm_servercommand", "command", "kick " + FindPlayerClass(FindPlayerByName(VoteInstanceArray[0].Arg2)).username, 3, null)
                break
            case "hostgunonly":
                SendChatMessage("[VOTE] Stripping all player guns except host in 3 seconds.", pVoteInitiator)
                // do stuff
                break
            default:
                SendChatMessage("[VOTE] You should not see this. This is fatal.", pVoteInitiator)
                break
            }
        }
        else if (iVotedYes == iVotedNo) {
            SendChatMessage("[VOTE] The vote was a tie, each with " + iVotedYes.tostring() + " votes.", pVoteInitiator)
        }
        else if (iVotedYes < iVotedNo && arg1 != "succeed" || arg1 == "fail") {
            SendChatMessage("[VOTE] The vote has failed.", pVoteInitiator)
        }

        // Vote forcefully failed or didn't have enough votes
        // Clean everything up
        // Note: We don't need to manually redefine the variables
        // or use a destructor since we are cloning this class instance

        VoteInstanceArray.clear() // Remove all items from this array

        for (local player; player = Entities.FindByClassname(player, "player");) {
            FindPlayerClass(player).startedvote = false // Forget who initiated the vote
            FindPlayerClass(player).hasvoted = false // Forget all those that had voted
        }
        Entities.FindByName(null, "VoteCounter").__KeyValueFromString("message", "Vote (Y/N/All): " + iVotedYes.tostring() + "/" + iVotedNo.tostring() + "/" + iCurrentNumberOfPlayers.tostring())

        ShouldDisplayVoteCounter = false
        LastVoteCooldownTime = Time() + 20 // By default, this is the amount of time before the CC can be used again
    }
    function BeginVote(arg1, arg2, pPlayer) {
        switch (arg1) {
        case "kick":
            if (FindPlayerByName(arg2) == null) {
                return SendChatMessage("[ERROR] Player not found.", pPlayer)
            }
            if (FindPlayerByName(arg2) == UTIL_PlayerByIndex(1)) {
                return SendChatMessage("[ERROR] Cannot kick server operator.", pPlayer)
            }
        }
        // Update the class info
        ActiveVote = arg1
        Arg2 = arg2
        CurrentTime = Time()
        FindPlayerClass(pPlayer).startedvote = true
        FindPlayerClass(pPlayer).hasvoted = true

        local intermediateArg2 = ""
        if (ActiveVote == "kick") {
            intermediateArg2 =  " (" + FindPlayerClass(FindPlayerByName(VoteInstanceArray[0].Arg2)).username + ")"
        }
        if (ActiveVote == "changelevel") {
            intermediateArg2 = " (" + VoteInstanceArray[0].Arg2 + ")"
        }

        SendChatMessage("[VOTE] Started vote for " + arg1 + "." + intermediateArg2, pPlayer)
        Vote.SubmitVote("yes", pPlayer)

        // Update the text color and players
        local rgb = FindPlayerClass(pPlayer).color
        Entities.FindByName(null, "VoteCounter").__KeyValueFromString("color", rgb.r.tostring() + " " + rgb.g.tostring() + " " + rgb.b.tostring())
        Entities.FindByName(null, "VoteCounter").__KeyValueFromString("message", "Vote (Y/N/All): " + iVotedYes.tostring() + "/" + iVotedNo.tostring() + "/" + iCurrentNumberOfPlayers.tostring())

        ShouldDisplayVoteCounter = true
    }
}

CommandList.push(
class {
    name = "vote"
    level = 0

    // !vote
    function CC(p, args) {
        // variables.nut
        // WE ONLY WANT TO SHARE ONE INSTANCE OF THE CLASS FOR VOTING
        // OTHERWISE WE GET SOME VARIABLES MIXED UP, SUCH AS WHO STARTED
        // A VOTE AND WHO ALREADY VOTED

        local bCurrentCCPlayerInitiatedVote = false
        local Vote = Vote(p)
        VoteInstanceArray.push(Vote)
        Vote = VoteInstanceArray[0]

        try {
            // Always attempt to remove the first array if it exists
            if (typeof VoteInstanceArray[1] == "instance") {
                VoteInstanceArray[1].remove()
            }
        } catch (exception) {}

        // End result: We always end up using a shared class instance
        //---------------------------------------------------------------

        // This isn't in the constructor since we need to refresh
        // this info every time CC is activated here
        local iNumPlayersRightNow = 0
        for (local player; player = Entities.FindByClassname(player, "player");) {
            iNumPlayersRightNow++
            if (FindPlayerClass(player).startedvote) {
                Vote.bVoteInProgress = true
                if (p == player) {
                    // This player initiated the vote and
                    // is invoking the command again
                    bCurrentCCPlayerInitiatedVote = true
                    Vote.pVoteInitiator = p
                }
            }
        }
        // We don't want to set Vote.iCurrentNumberOfPlayers to 0
        // then back to the real number since it can mess up the player count
        Vote.iCurrentNumberOfPlayers = iNumPlayersRightNow

        // Obey the cooldown to initiate a vote
        if (Time().tointeger() < LastVoteCooldownTime.tointeger() && !Vote.bVoteInProgress) {
            return SendChatMessage("[ERROR] Vote command is on cooldown for 20 seconds.", p)
        }

        // Obey the required number of players needed to initiate a vote
        if (Vote.iCurrentNumberOfPlayers < 3 && !Vote.bVoteInProgress) {
            return SendChatMessage("[ERROR] Cannot vote if there are less than 3 players.", p)
        }

        // Depending on who invokes the command, prompt them with different messages
        if (args.len() == 0) {
            if (Vote.bVoteInProgress) {
                if (bCurrentCCPlayerInitiatedVote) {
                    SendChatMessage("[VOTE] End a vote with: cancel", p)
                } else {
                    if (!FindPlayerClass(p).hasvoted) {
                        SendChatMessage("[VOTE] Vote with: yes, no", p)
                    } else {
                        SendChatMessage("[VOTE] You have already voted.", p)
                    }
                }
            } else {
                SendChatMessage("[VOTE] Start a vote with: changelevel, kick, or hostgunonly", p)
                VoteInstanceArray.clear()
            }
            return
        }

        args[0] = Strip(args[0])

        //----------------------------
        // There is a vote in progress
        //----------------------------

        if (Vote.bVoteInProgress) {
            // Standard voter
            if (!bCurrentCCPlayerInitiatedVote && FindPlayerClass(p).hasvoted && !IsAdminLevelEnough(p)) {
                return SendChatMessage("[VOTE] You have already voted.", p)
            }

            // Vote initiator didn't try to cancel
            if (bCurrentCCPlayerInitiatedVote && args[0] != "cancel" && args[0] != "succeed" && args[0] != "fail") {
                return SendChatMessage("[ERROR] You initiated a vote and voted already.", p)
            }

            local IsAdminLevelEnough = function(player) {
                if (GetAdminLevel(player) >= 6) {
                    return true
                }
                return false
            }

            switch (args[0]) {
            // Only cancel if it's an admin or the vote initiator
            case "cancel":
                if (bCurrentCCPlayerInitiatedVote || IsAdminLevelEnough(p)) {
                    Vote.DoVote("fail")
                    return SendChatMessage("[VOTE] The vote has been cancelled.", p)
                }
                return SendChatMessage("[ERROR] Cannot cancel the vote if you did not start it.", p)
                break

            // Don't start new votes
            case "changelevel": SendChatMessage("[ERROR] Cannot start another vote if one is in progress.", p); break
            case "kick":        SendChatMessage("[ERROR] Cannot start another vote if one is in progress.", p); break
            case "hostgunonly": SendChatMessage("[ERROR] Cannot start another vote if one is in progress.", p); break

            // Submit a vote
            case "yes":         Vote.SubmitVote(args[0], p);    break
            case "no":          Vote.SubmitVote(args[0], p);    break

            // Admin control
            case "succeed":
                if (IsAdminLevelEnough(p)) {
                    SendChatMessage("Overruled the vote.", p)
                    Vote.DoVote(args[0])
                }
                break
            case "fail":
                if (IsAdminLevelEnough(p)) {
                    SendChatMessage("Overruled the vote.", p)
                    Vote.DoVote(args[0])
                }
                break

            // Randomness was entered
            default:
                SendChatMessage("[ERROR] Voting options are: yes, and no", p)
                break
            }
            return
        }

        //--------------------------------
        // There was no vote in progress
        //--------------------------------

        if (args[0] == "cancel") {
            SendChatMessage("[ERROR] Cannot cancel. No vote active.", p)
            VoteInstanceArray.clear()
        }
        else if (args[0] == "changelevel" || args[0] == "kick") {
            // Start a new vote
            try {
                args[1] = Strip(args[1])
            } catch (exception) {
                SendChatMessage("[ERROR] Enter a second argument.", p)
                VoteInstanceArray.clear()
                return
            }
            Vote.BeginVote(args[0], args[1], p)
        }
        else if (args[0] == "hostgunonly") {
            // Start a new vote
            Vote.BeginVote(args[0], null, p)
        }
        else if (args[0] == "yes" || args[0] == "no" || args[0] == "succeed" || args[0] == "fail") {
            // Cannot vote for something yet
            SendChatMessage("[ERROR] No vote is active.", p)
            VoteInstanceArray.clear()
        } else {
            // No valid option chosen
            SendChatMessage("[ERROR] Voting options are: changelevel, kick, and hostgunonly.", p)
            VoteInstanceArray.clear()
        }
    }
}
)