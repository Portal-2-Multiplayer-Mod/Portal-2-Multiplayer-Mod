// ██████╗██████╗             █████╗   ███╗             ██╗███╗  ██╗████████╗██████╗  █████╗ ███████╗
//██╔════╝██╔══██╗           ██╔══██╗ ████║             ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗╚════██║
//╚█████╗ ██████╔╝           ███████║██╔██║             ██║██╔██╗██║   ██║   ██████╔╝██║  ██║    ██╔╝
// ╚═══██╗██╔═══╝            ██╔══██║╚═╝██║             ██║██║╚████║   ██║   ██╔══██╗██║  ██║   ██╔╝
//██████╔╝██║     ██████████╗██║  ██║███████╗██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝  ██╔╝
//╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚══════╝╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝   ╚═╝

amogos <- true
function PutStickInAss() {
    amogos = false
    EntFire("@sphere", "enablepickup", "", 1)
    printl("You put the stick in your ass.")
    Entities.FindByName(null, "sphere_filter").__KeyValueFromString("Negated", "1")
    EntFire("spherebot_1_top_swivel_1", "deactivate", "", 0.1)
}

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
    //         usesetspawn = false

    // // Set SpawnPoint
    // setspawn = class {
    //     // Set SpawnPoint
    //     position = Vector(0,0,0)
    //     // Set Radius
    //     radius = 0
    // }
        GlobalSpawnClass.useautospawn <- true

        EntFire("@sphere", "addoutput", "OnPlayerPickup @sphere:disablepickup", 0, null)
        EntFire("@sphere", "addoutput", "OnPlayerDrop @sphere:enablepickup", 0, null)
        //Entities.FindByName(null, "sphere_impact_trigger").__KeyValueFromString("filtername", "InstanceAuto9-filter_sphere")
        // Destroy objects
        Entities.FindByName(null, "door_0-close_door_rl").Destroy()
        Entities.FindByName(null, "relay_portab_spawn").Destroy()
        Entities.FindByName(null, "portal_blocker").Destroy()
        Entities.FindByName(null, "bts_panel_door-heavydoor_open_clip").Destroy()
        // bts_panel_door-LR_heavydoor_close
        Entities.FindByName(null, "bts_panel_door-LR_heavydoor_close").Destroy()
        // heavy_door_backtrack_clip
        Entities.FindByName(null, "heavy_door_backtrack_clip").Destroy()
        // transition_trigger
        Entities.FindByName(null, "transition_trigger").Destroy()

        // sphere_filter
        // // filtername -1334 -414 1291.87
        // Entities.FindByClassnameNearest("trigger_once", Vector(-1334, -414, 1291.87), 20).__KeyValueFromString("filtername", "")
        Entities.FindByClassnameNearest("trigger_once", Vector(-1334, -414, 1291.87), 20).__KeyValueFromString("spawnflags", "4105")
        Entities.FindByClassnameNearest("trigger_once", Vector(-1334, -414, 1291.87), 20).__KeyValueFromString("targetname", "TRIG1")
        // // filtername -2544 -416 1272
        // Entities.FindByClassnameNearest("trigger_once", Vector(-2544, -416, 1272), 20).__KeyValueFromString("filtername", "")
        Entities.FindByClassnameNearest("trigger_once", Vector(-2544, -416, 1272), 20).__KeyValueFromString("spawnflags", "4105")
        Entities.FindByClassnameNearest("trigger_once", Vector(-2544, -416, 1272), 20).__KeyValueFromString("targetname", "TRIG2")
        // // filtername -2688 -208 1272
        // Entities.FindByClassnameNearest("trigger_once", Vector(-2688, -208, 1272), 20).__KeyValueFromString("filtername", "")
        Entities.FindByClassnameNearest("trigger_once", Vector(-2688, -208, 1272), 20).__KeyValueFromString("spawnflags", "4105")
        Entities.FindByClassnameNearest("trigger_once", Vector(-2688, -208, 1272), 20).__KeyValueFromString("targetname", "TRIG3")

        //Entities.FindByName(null, "look_at_me_relay").Destroy()
        EntFire("InstanceAuto9-socket_powered_rl", "addoutput", "OnTrigger @sphere:setparentattachment:sphere_attach:0.1")

        EntFire("InstanceAuto9-socket_powered_rl", "addoutput", "OnTrigger @glados:RunScriptCode:sp_a1_intro7_TurnAroundNow():5")
        EntFire("InstanceAuto9-socket_powered_rl", "addoutput", "OnTrigger @sphere:disablepickup::0.11")


        EntFire("sphere_impact_trigger", "addoutput", "OnTrigger p232servercommand:command:script PutStickInAss():0")

        // EntFire("InstanceAuto9-socket_powered_rl", "addoutput", "OnTrigger bts_panel_door-proxy:OnProxyRelay1::5")
        // EntFire("InstanceAuto9-socket_powered_rl", "addoutput", "OnTrigger open_panel_music:PlaySound::5")
        // EntFire("InstanceAuto9-socket_powered_rl", "addoutput", "OnTrigger find_elevator_trigger:Enable::5")

        // EntFire("InstanceAuto9-socket_powered_rl", "addoutput", "OnTrigger @sphere:kill::0.5")
    }

    if (MSPostPlayerSpawn==true) {
        NewApertureStartElevatorFixes()
    }

    if (MSLoop==true) {
        if (amogos == true) {
            try {
                local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "spherebot_1_top_swivel_1").GetOrigin(), 10000)
                EntFireByHandle(Entities.FindByName(null, "spherebot_1_top_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
            } catch(exception) { }
            try {
                local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "spherebot_1_bottom_swivel_1").GetOrigin(), 10000)
                EntFireByHandle(Entities.FindByName(null, "spherebot_1_bottom_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
            } catch(exception) { }
        }
        // local ent = null
        // while (ent = Entities.FindByClassname(ent, "weapon_portalgun")) {
        //     ent.__KeyValueFromString("targetname", "@sphere")
        // }
        Entities.FindByName(null, "portal_in_wheatley_room_detector").__KeyValueFromString("CheckAllIDs", "1")
        Entities.FindByName(null, "portal_detector").__KeyValueFromString("CheckAllIDs", "1")

        //portal_detector
        // Elevator changelevel
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-2208.151855, 463.968750, 1281.025513), 150)) {
            SendToConsole("changelevel sp_a1_wakeup")
        }

        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(3015, -174, -125), 60)) {
            SendToConsole("changelevel sp_a1_intro7")
        }
    }
}