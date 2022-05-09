// Remove Portal Gun
function ShouldRespawnWithoutPortalGunToggle() {
    if (!Entities.FindByName(null, "supress_blue_portalgun_spawn")) {
        RemovePortalGunBlue <- Entities.CreateByClassname("info_target")
        RemovePortalGunBlue.__KeyValueFromString("targetname", "supress_blue_portalgun_spawn")
    }
    if (!Entities.FindByName(null, "supress_orange_portalgun_spawn")) {
        RemovePortalGunOrange <- Entities.CreateByClassname("info_target")
        RemovePortalGunOrange.__KeyValueFromString("targetname", "supress_orange_portalgun_spawn")
    }
}

// Just like how the Portal Gun is given on player spawn normally, we give our weapon instead
// Use this function to toggle whether players will spawn with or without the weapon from any point midgame
function ShouldRespawnWithBaseHLToggle() {
    // Ensure some vital convars are set
    EntFire("p2mm_servercommand", "command", "deathmatch 1", 0.05) // I think this takes care of some stuff internally
    EntFire("p2mm_servercommand", "command", "sk_plr_dmg_smg1 6", 0.05) // How much damage the primary attack does
    EntFire("p2mm_servercommand", "command", "sk_plr_dmg_smg1_grenade 100", 0.05) // How much damage the alt-fire does
    EntFire("p2mm_servercommand", "command", "sk_max_smg1 100", 0.05) // Max amount of bullets people can hold for the primary attack
    EntFire("p2mm_servercommand", "command", "sk_max_smg1_grenade 0", 0.05) // ALT-FIRE NONFUNCTIONAL

    if (!Entities.FindByClassname(null, "game_player_equip") && !Entities.FindByName(null, "p2mm_game_player_equip")) {
        GamePlayerEquip <- Entities.CreateByClassname("game_player_equip")
        GamePlayerEquip.__KeyValueFromString("targetname", "p2mm_game_player_equip")
        GamePlayerEquip.__KeyValueFromString("basehlcombatweapon", "0")
    } else if (Entities.FindByClassname(null, "game_player_equip") && Entities.FindByName(null, "p2mm_game_player_equip")) {
        Entities.FindByName(null, "p2mm_game_player_equip").Destroy()
    }
}

//-------------------------------------------------------------

function EndDeathmatchGame() {
    // Set up game ending system
    if (!Entities.FindByName(null, "p2mm_game_end") && !Entities.FindByClassname(null, "game_end")) {
        GameEndEntity <- Entities.CreateByClassname("game_end")
        GameEndEntity.__KeyValueFromString("targetname", "p2mm_game_end")
    }
    EntFire("p2mm_game_end", "EndGame", null, 0)
}

function ResetDeathmatchGame() {
    EntFire("p2mm_servercommand", "command", "say Game restarts in 5 seconds", 3)
    EntFire("p2mm_servercommand", "command", "say Game restarts in 4", 4)
    EntFire("p2mm_servercommand", "command", "say Game restarts in 3", 5)
    EntFire("p2mm_servercommand", "command", "say Game restarts in 2", 6)
    EntFire("p2mm_servercommand", "command", "say Game restarts in 1", 7)
    EntFire("p2mm_servercommand", "command", "changelevel " + GetMapName(), 8)
}

//-------------------------------------------------------------

// TODO: Actually implement gamemode. This stuff can probably go inside of the mapsupport files instead of here

// GameStarted <- false
// TeamWon <- false
// DesiredScore <- 10 // What score are we playing until?

// if (GameStarted) {
//     if (MSOnRespawn) {
//         EnableSpectator(true, p)
//     }

//     BluePoints <- Entities.CreateByClassname("game_text")
//     BluePoints.__KeyValueFromString("targetname", "BluePoints")
//     BluePoints.__KeyValueFromString("x", "0")
//     BluePoints.__KeyValueFromString("y", "0.9")
//     BluePoints.__KeyValueFromString("message", "Red: 0/" + DesiredScore)
//     BluePoints.__KeyValueFromString("holdtime", "500")
//     BluePoints.__KeyValueFromString("fadeout", "2")
//     BluePoints.__KeyValueFromString("fadein", "2")
//     BluePoints.__KeyValueFromString("channel", "0")
//     BluePoints.__KeyValueFromString("spawnflags", "1")
//     BluePoints.__KeyValueFromString("color", "0 80 255")

//     RedPoints <- Entities.CreateByClassname("game_text")
//     RedPoints.__KeyValueFromString("targetname", "RedPoints")
//     RedPoints.__KeyValueFromString("x", "0")
//     RedPoints.__KeyValueFromString("y", "0.88")
//     RedPoints.__KeyValueFromString("message", " Blue: 0/" + DesiredScore)
//     RedPoints.__KeyValueFromString("holdtime", "500")
//     RedPoints.__KeyValueFromString("fadeout", "2")
//     RedPoints.__KeyValueFromString("fadein", "2")
//     RedPoints.__KeyValueFromString("channel", "2")
//     RedPoints.__KeyValueFromString("spawnflags", "1")
//     RedPoints.__KeyValueFromString("color", "255 100 0")
// }

// if (MSLoop) {
//     if (TeamWon) {
//         EntFire("p2mm_game_end", "EndGame", null, 0)
//     }
// }