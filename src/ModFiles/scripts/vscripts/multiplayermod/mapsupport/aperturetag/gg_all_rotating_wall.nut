//  ██████╗  ██████╗             █████╗ ██╗     ██╗                ██████╗  █████╗ ████████╗ █████╗ ████████╗██╗███╗  ██╗ ██████╗             ██╗       ██╗ █████╗ ██╗     ██╗     
// ██╔════╝ ██╔════╝            ██╔══██╗██║     ██║                ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗╚══██╔══╝██║████╗ ██║██╔════╝             ██║  ██╗  ██║██╔══██╗██║     ██║     
// ██║  ██╗ ██║  ██╗            ███████║██║     ██║                ██████╔╝██║  ██║   ██║   ███████║   ██║   ██║██╔██╗██║██║  ██╗             ╚██╗████╗██╔╝███████║██║     ██║     
// ██║  ╚██╗██║  ╚██╗           ██╔══██║██║     ██║                ██╔══██╗██║  ██║   ██║   ██╔══██║   ██║   ██║██║╚████║██║  ╚██╗             ████╔═████║ ██╔══██║██║     ██║     
// ╚██████╔╝╚██████╔╝██████████╗██║  ██║███████╗███████╗██████████╗██║  ██║╚█████╔╝   ██║   ██║  ██║   ██║   ██║██║ ╚███║╚██████╔╝██████████╗  ╚██╔╝ ╚██╔╝ ██║  ██║███████╗███████╗
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═════════╝╚═╝  ╚═╝ ╚════╝    ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚═╝╚═╝  ╚══╝ ╚═════╝ ╚═════════╝   ╚═╝   ╚═╝  ╚═╝  ╚═╝╚══════╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // causes cubes to get stuck in vactube eventually crashing server
        Entities.FindByName(null, "InstanceAuto1-vac_items_case").Destroy()

        // Checkpoint
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-640, 1472, 176), 32), "AddOutput", "OnStartTouch !self:RunScriptCode:Checkpoint()", 0, null, null)


        // Stop pathways from closing
        Entities.FindByClassnameNearest("trigger_once", Vector(152, -1848, 448), 32).Destroy()
        EntFire("bts_door_2", "AddOutput", "OnAnimationBegun bts_door_2:AddOutput:targetname bts_door_2_p2mmoverride")
        EntFire("door_1", "AddOutput", "OnOpen door_1:AddOutput:targetname door_1_p2mmoverride")
        EntFire("exit_door", "AddOutput", "OnOpen exit_door:AddOutput:targetname exit_door_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(128, -256, 448), 32), "AddOutput", "OnStartTouch bts_door_2_area:Open::2.01", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1600, 2720, 192), 32), "AddOutput", "OnStartTouch exit_door_area:Open::1.01", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-104, 1472, 224), 32), "AddOutput", "OnStartTouch door_1_Area:Open::1.01", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(128, -256, 448), 32), "AddOutput", "OnStartTouch !self:CancelPending::1", 0, null, null)

        // Make fizzlers work
        EntFireByHandle(Entities.FindByNameNearest("@fizzler_gun_1_on", Vector(128, -296, 480), 32), "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false true):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByNameNearest("@fizzler_gun_1_on", Vector(128, -296, 480), 32), "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false true):0:-1", 0, null, null)

        EntFireByHandle(Entities.FindByNameNearest("@fizzler_gun_1_on", Vector(-800, 2392, -191.99), 32), "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false true):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByNameNearest("@fizzler_gun_1_on", Vector(-800, 2392, -191.99), 32), "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false true):0:-1", 0, null, null)

        EntFireByHandle(Entities.FindByNameNearest("@fizzler_gun_1_on", Vector(-212, 1472, 225.01), 32), "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator true true):0:-1", 0, null, null)
        EntFireByHandle(Entities.FindByNameNearest("@fizzler_gun_1_on", Vector(1600, 2628, 192.01), 32), "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator true true):0:-1", 0, null, null)
        EntFire("@fizzler_gun_1_on", "AddOutput", "targetname @fizzler_gun_1_on_p2mmoverride")

        EntFire("@fizzler_gun_1_off", "AddOutput", "OnStartTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "OnEndTouch !activator:RunScriptCode:UpdateGels(activator false false):0:-1")
        EntFire("@fizzler_gun_1_off", "AddOutput", "targetname @fizzler_gun_1_off_p2mmoverride")

        // Make transitioning levels work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("transition_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel gg_all_fizzler:1.5")
    }
}

function Checkpoint()
{
    Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(-704, 1472, 176))
    Entities.FindByClassname(null, "info_player_start").SetAngles(0, 0, 0)
}
