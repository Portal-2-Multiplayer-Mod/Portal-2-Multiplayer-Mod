// ██████╗██████╗             █████╗ ██████╗            ███████╗███╗  ██╗██████╗ 
//██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔════╝████╗ ██║██╔══██╗
//╚█████╗ ██████╔╝           ███████║ █████╔╝           █████╗  ██╔██╗██║██║  ██║
// ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██╔══╝  ██║╚████║██║  ██║
//██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗███████╗██║ ╚███║██████╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝╚══════╝╚═╝  ╚══╝╚═════╝ 

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        Entities.FindByName(null, "entrance_door_prop").__KeyValueFromString("targetname", "moja1")
        Entities.FindByName(null, "paint_trickle_blue_1").__KeyValueFromString("targetname", "moja2")
        Entities.FindByName(null, "paint_trickle_white_1").__KeyValueFromString("targetname", "moja3")
        Entities.FindByName(null, "paint_trickle_orange_1").__KeyValueFromString("targetname", "moja4")
        Entities.FindByName(null, "paint_trickle_blue_2").__KeyValueFromString("targetname", "moja5")
        Entities.FindByName(null, "paint_trickle_blue_2").__KeyValueFromString("targetname", "moja5")
        Entities.FindByName(null, "paint_trickle_white_2").__KeyValueFromString("targetname", "moja6")
        // Here if we need to ent_fire something
        EntFireByHandle(Entities.FindByName(null, "entrance_door_button"), "addoutput", "OnPressed moja1:SetAnimation:open", 1, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(192, 256, -3336), 20), "addoutput", "OnTrigger moja3:Start", 1, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(192, 256, -3336), 20), "addoutput", "OnTrigger moja4:Start", 1, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(192, 256, -3336), 20), "addoutput", "OnTrigger moja5:Start", 1, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-552, 256, -2200), 20), "addoutput", "OnTrigger moja6:Start", 1, null, null)
        // Fix func_portal_detectors
        local ent = null
        while (ent = Entities.FindByClassname(ent, "func_portal_detector")) {
            ent.__KeyValueFromString("CheckAllIDs", "1")
        }
        // Destroy objects
        Entities.FindByName(null, "fade_to_death").Destroy()
    }

    if (MSPostPlayerSpawn==true) {

    }

    if (MSOnPlayerJoin==true) {
        // Find all players
        local p = null
        while (p = Entities.FindByClassname(p, "player")) {
            EntFireByHandle(clientcommand, "Command", "r_flashlightbrightness 1", 0, p, p)
            EntFireByHandle(p, "setfogcontroller", "@environment_lake_fog", 0, null, null)
        }
    }

    if (MSLoop==true) {
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-1540, -830, 3840), 50)) {
            SendToConsole("commentary 1")
            SendToConsole("changelevel sp_a4_intro")
        }
    }
}