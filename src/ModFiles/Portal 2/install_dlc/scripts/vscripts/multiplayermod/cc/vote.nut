// TODO: We have no way of accounting for players
// who leave the game during an active vote. This
// can easily be fixed, but requires one of our hex
// edits to be modified slightly

// Modify these as needed...
VotingCooldownWaitPeriod <- 15 // Seconds before next voting can begin after one finished
VotingTime <- 30 // Seconds to actually submit a vote before it automatically ends

//-----------------------------------------------------------------------------------

VoteCounter <- Entities.CreateByClassname("game_text")
VoteCounter.__KeyValueFromString("targetname", "VoteCounter")
VoteCounter.__KeyValueFromString("x", "0.005")
VoteCounter.__KeyValueFromString("y", "0.9")
VoteCounter.__KeyValueFromString("message", "Vote #: 0/0")
VoteCounter.__KeyValueFromString("holdtime", "1")
VoteCounter.__KeyValueFromString("fadeout", "1.2")
VoteCounter.__KeyValueFromString("fadein", "1.2")
VoteCounter.__KeyValueFromString("channel", "0")
VoteCounter.__KeyValueFromString("spawnflags", "1")
VoteCounter.__KeyValueFromString("color", "255 255 255")

VoteTimer <- Entities.CreateByClassname("game_text")
VoteTimer.__KeyValueFromString("targetname", "VoteTimer")
VoteTimer.__KeyValueFromString("x", "0.005")
VoteTimer.__KeyValueFromString("y", "0.85")
VoteTimer.__KeyValueFromString("message", "Time: " + VotingTime.tostring() + "s")
VoteTimer.__KeyValueFromString("holdtime", "1")
VoteTimer.__KeyValueFromString("fadeout", "1.2")
VoteTimer.__KeyValueFromString("fadein", "1.2")
VoteTimer.__KeyValueFromString("channel", "1")
VoteTimer.__KeyValueFromString("spawnflags", "1")
VoteTimer.__KeyValueFromString("color", "255 255 255")

ShouldDisplayVoteText <- false // Should both game_text's display to everyone right now?
VoteInitTime <- null // When did this vote start?
LastVoteCooldownTime <- Time() // By default, there is no cooldown on map spawn
ReversedTimer <- false // Did we reverse the timer for the vote?

// Basically a global variable outside of the class scope for telling if a vote is active
bAllowVoteTimeCheck <- false // Can we check for the vote timer?

// We aren't going to modify this class directly, we are just going to clone it
// and read these default values, and store a SHARED instance in this array
VoteInstanceArray <- []

//-----------------------------------------------------------------------------------

class Vote {
    ActiveVote = null
    iVotedYes = 0
    iVotedNo = 0
    Arg2 = null

    bVoteInProgress = false
    pVoteInitiator = null
    iCurrentNumberOfPlayers = 0
}

// Starts a vote
function Vote::BeginVote(arg1, arg2, pPlayer) {
    switch (arg1) {
    case "kick":
        if (FindPlayerByName(arg2) == null) {
            return SendChatMessage("[ERROR] Player not found.", pPlayer)
        }
        if (FindPlayerByName(arg2) == UTIL_PlayerByIndex(1)) {
            return SendChatMessage("[ERROR] Cannot kick server operator.", pPlayer)
        }
    }
    ActiveVote = arg1
    Arg2 = arg2

    VoteInitTime = Time()
    bAllowVoteTimeCheck = true

    // Update the class info
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
    Entities.FindByName(null, "VoteTimer").__KeyValueFromString("color", rgb.r.tostring() + " " + rgb.g.tostring() + " " + rgb.b.tostring())
    Entities.FindByName(null, "VoteCounter").__KeyValueFromString("message", "Vote (Y/N/All): " + iVotedYes.tostring() + "/" + iVotedNo.tostring() + "/" + iCurrentNumberOfPlayers.tostring())

    ShouldDisplayVoteText = true
}

// Vote is in progress; People can submit a vote
function Vote::SubmitVote(arg1, arg2) {
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

// Vote has succeeded or failed
// Do the actions accordingly
function Vote::DoVote(arg1 = null) {
    if (arg1 != "cancel") {
        if (iVotedYes > iVotedNo && arg1 != "fail" || arg1 == "succeed") {
            SendChatMessage("[VOTE] The vote has succeeded.", pVoteInitiator)

            // Add stuff for actually changing in game stuffs
            switch (VoteInstanceArray[0].ActiveVote) {
            case "changelevel":
                SendChatMessage("[VOTE] Changing map in 5 seconds.", pVoteInitiator)
                EntFire("p2mm_servercommand", "command", "changelevel " + VoteInstanceArray[0].Arg2, 5)
                break
            case "kick":
                SendChatMessage("[VOTE] Kicking player in 5 seconds.", pVoteInitiator)
                EntFire("p2mm_servercommand", "command", "kick " + FindPlayerClass(FindPlayerByName(VoteInstanceArray[0].Arg2)).username, 5)
                break
            case "hostgunonly":
                // TODO: This doesn't account for gamemodes apart from "standard"
                // How do we deal with other weapon classes?
                if (!IsDedicatedServer) {
                    SendChatMessage("[VOTE] Stripping all player guns except host in 5 seconds.", pVoteInitiator)

                    UTIL_Team.Spawn_PortalGun(false, "all")
                    // Remove Portal Gun
                    local ent = null
                    while (ent = Entities.FindByClassname(ent, "weapon_portalgun")) {
                        if (FindPlayerClass(ent.GetRootMoveParent()).id != 1) {
                            EntFireByHandle(ent, "addoutput", "CanFirePortal1 0", 5, null, null)
                            EntFireByHandle(ent, "addoutput", "CanFirePortal2 0", 5, null, null)
                            EntFireByHandle(ent, "disabledraw", "", 5, null, null)
                        }
                    }
                    local ent = null
                    while (ent = Entities.FindByClassname(ent, "predicted_viewmodel")) {
                        if (FindPlayerClass(ent.GetRootMoveParent()).id != 1) {
                            EntFireByHandle(ent, "disabledraw", "", 5, null, null)
                        }
                    }
                    break
                }
            default:
                SendChatMessage("[VOTE] You should not see this. This is fatal.", pVoteInitiator)
                break
            }
        }
        else if (iVotedYes == iVotedNo) {
            local charPluralVotes = ""
            if (iVotedYes > 1) {
                charPluralVotes = "s"
            }
            SendChatMessage("[VOTE] The vote was a tie, each with " + iVotedYes.tostring() + " vote" + charPluralVotes + ".", pVoteInitiator)
        }
        else if (iVotedYes < iVotedNo && arg1 != "succeed" || arg1 == "fail") {
            SendChatMessage("[VOTE] The vote has failed.", pVoteInitiator)
        }
    }

    CleanUpVote()
}

// Restart everything as if no one has used the CC yet
// (Basically the destructor)
function Vote::CleanUpVote() {
    // Vote forcefully failed or didn't have enough votes
    bAllowVoteTimeCheck = false // Disable this first thing to possibly prevent more DoVotes
    VoteInstanceArray.clear() // Remove all items from this array

    for (local player; player = Entities.FindByClassname(player, "player");) {
        FindPlayerClass(player).startedvote = false // Forget who initiated the vote
        FindPlayerClass(player).hasvoted = false // Forget all those that had voted
    }
    Entities.FindByName(null, "VoteCounter").__KeyValueFromString("message", "Vote (Y/N/All): " + iVotedYes.tostring() + "/" + iVotedNo.tostring() + "/" + iCurrentNumberOfPlayers.tostring())

    ReversedTimer = false
    ShouldDisplayVoteText = false
    VoteTimer.__KeyValueFromString("message", "Time: " + VotingTime.tostring() + "s")
    LastVoteCooldownTime = Time() + VotingCooldownWaitPeriod
}

//-----------------------------------------------------------------------------------

CommandList.push(
    class {
        name = "vote"
        level = 0

        // !vote (arg1) (arg2)
        function CC(p, args) {
            // WE ONLY WANT TO SHARE ONE INSTANCE OF THE CLASS FOR VOTING
            // OTHERWISE WE GET SOME VARIABLES MIXED UP, SUCH AS WHO STARTED
            // A VOTE AND WHO ALREADY VOTED

            local bCurrentCCPlayerInitiatedVote = false
            local Vote = Vote(p)
            VoteInstanceArray.push(Vote)
            Vote = VoteInstanceArray[0]

            try {
                // Always attempt to remove the second array if it exists
                VoteInstanceArray[1].remove()
            } catch (exception) {}

            // End result: We always end up using a shared class instance
            //---------------------------------------------------------------

            // This isn't in the constructor since we need to refresh
            // this info every time CC is activated here by anyone
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
                return SendChatMessage("[VOTE] Vote command is on cooldown for " + VotingCooldownWaitPeriod.tostring() + " seconds.", p)
            }

            // Obey the required number of players needed to initiate a vote
            // if (Vote.iCurrentNumberOfPlayers < 3 && !Vote.bVoteInProgress) {
            //     return SendChatMessage("[VOTE] Cannot vote if there are less than 3 players.", p)
            // }

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
                    if (IsDedicatedServer) {
                        SendChatMessage("[VOTE] Start a vote with: changelevel, kick", p)
                    } else {
                        SendChatMessage("[VOTE] Start a vote with: changelevel, kick, hostgunonly", p)
                    }
                    VoteInstanceArray.clear()
                }
                return
            }

            args[0] = Strip(args[0]).tolower()

            //----------------------------
            // There is a vote in progress
            //----------------------------

            if (Vote.bVoteInProgress) {
                local IsAdminLevelEnough = function(player) {
                    if (GetAdminLevel(player) >= 6) {
                        return true
                    }
                    return false
                }

                // Standard voter
                if (!bCurrentCCPlayerInitiatedVote && FindPlayerClass(p).hasvoted && !IsAdminLevelEnough(p)) {
                    return SendChatMessage("[VOTE] You have already voted.", p)
                }

                // Vote initiator didn't try to cancel
                if (bCurrentCCPlayerInitiatedVote && args[0] != "cancel" && args[0] != "succeed" && args[0] != "fail") {
                    return SendChatMessage("[ERROR] You initiated a vote and voted already.", p)
                }

                //----------------------------

                if (args[0] == "cancel") {
                    // Only cancel if it's an admin or the vote initiator
                    if (bCurrentCCPlayerInitiatedVote || IsAdminLevelEnough(p)) {
                        Vote.DoVote("cancel")
                        return SendChatMessage("[VOTE] The vote has been cancelled.", p)
                    }
                    return SendChatMessage("[ERROR] Cannot cancel the vote if you did not start it.", p)
                }
                else if (args[0] == "changelevel" || args[0] == "kick" || args[0] == "hostgunonly" && !IsDedicatedServer) {
                    // Don't start new votes
                    SendChatMessage("[ERROR] Cannot start another vote if one is in progress.", p)
                }
                else if (args[0] == "yes" || args[0] == "no") {
                    // Submit a vote
                    Vote.SubmitVote(args[0], p)
                } else if (args[0] == "succeed" || args[0] == "fail") {
                    // Admin control
                    if (IsAdminLevelEnough(p)) {
                        SendChatMessage("[VOTE] Overruled the vote.", p)
                        Vote.DoVote(args[0])
                    } else {
                        SendChatMessage("[VOTE] You need at least admin level 6 to overrule votes.")
                    }
                } else {
                    // Randomness was entered
                    SendChatMessage("[ERROR] Voting options are: yes, and no", p)
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
            else if (args[0] == "hostgunonly" && !IsDedicatedServer) {
                // Start a new vote
                Vote.BeginVote(args[0], null, p)
            }
            else if (args[0] == "yes" || args[0] == "no" || args[0] == "succeed" || args[0] == "fail") {
                // Cannot vote for something yet
                SendChatMessage("[ERROR] No vote is active.", p)
                VoteInstanceArray.clear()
            } else {
                // No valid option chosen
                if (IsDedicatedServer) {
                    SendChatMessage("[ERROR] Voting options are: changelevel, kick.", p)
                } else {
                    SendChatMessage("[ERROR] Voting options are: changelevel, kick, hostgunonly.", p)
                }
                VoteInstanceArray.clear()
            }
        }
    }
)