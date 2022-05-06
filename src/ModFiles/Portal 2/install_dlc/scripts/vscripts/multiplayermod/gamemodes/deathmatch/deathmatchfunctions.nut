// Remove Portal Gun
if (!Entities.FindByName(null, "supress_blue_portalgun_spawn")) {
    RemovePortalGunBlue <- Entities.CreateByClassname("info_target")
    RemovePortalGunBlue.__KeyValueFromString("targetname", "supress_blue_portalgun_spawn")
}

if (!Entities.FindByName(null, "supress_orange_portalgun_spawn")) {
    RemovePortalGunOrange <- Entities.CreateByClassname("info_target")
    RemovePortalGunOrange.__KeyValueFromString("targetname", "supress_orange_portalgun_spawn")
}

// Set damage of our bullets
EntFire("p2mm_servercommand", "command", "sk_plr_dmg_smg1 6", 0.05)
EntFire("p2mm_servercommand", "command", "sk_plr_dmg_smg1_grenade 100", 0.05)

// Set max amount of bullets for each client
EntFire("p2mm_servercommand", "command", "sk_max_smg1 999999", 0.05)
EntFire("p2mm_servercommand", "command", "sk_max_smg1_grenade 0", 0.05)

// TODO: Actually implement gamemode
// Weapon name to give to players is "basehlcombatweapon"