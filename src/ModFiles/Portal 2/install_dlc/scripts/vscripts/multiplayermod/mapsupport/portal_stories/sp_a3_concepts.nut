//  ██████╗██████╗             █████╗ ██████╗             █████╗  █████╗ ███╗  ██╗ █████╗ ███████╗██████╗ ████████╗ ██████╗
// ██╔════╝██╔══██╗           ██╔══██╗╚════██╗           ██╔══██╗██╔══██╗████╗ ██║██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██╔════╝
// ╚█████╗ ██████╔╝           ███████║ █████╔╝           ██║  ╚═╝██║  ██║██╔██╗██║██║  ╚═╝█████╗  ██████╔╝   ██║   ╚█████╗
//  ╚═══██╗██╔═══╝            ██╔══██║ ╚═══██╗           ██║  ██╗██║  ██║██║╚████║██║  ██╗██╔══╝  ██╔═══╝    ██║    ╚═══██╗
// ██████╔╝██║     ██████████╗██║  ██║██████╔╝██████████╗╚█████╔╝╚█████╔╝██║ ╚███║╚█████╔╝███████╗██║        ██║   ██████╔╝
// ╚═════╝ ╚═╝     ╚═════════╝╚═╝  ╚═╝╚═════╝ ╚═════════╝ ╚════╝  ╚════╝ ╚═╝  ╚══╝ ╚════╝ ╚══════╝╚═╝        ╚═╝   ╚═════╝



function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        // Start without Portal Gun for starting elevator cut scene
        UTIL_Team.Spawn_PortalGun(false)

        // Enable pinging and disable taunting
        UTIL_Team.Pinging(true)
        UTIL_Team.Taunting(false)

        // delete box spawn and teleport the elevator spawn to its location (jank asf method because setting the angles on players doesn't work???)
        Entities.FindByClassnameNearest("info_player_start", Vector(472, 2712, -348), 64).Destroy()
        Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(472, 2712, -348))

        // taking control of the elevator
        Entities.FindByName(null, "InstanceAuto6-elevator_1").Destroy()
        Entities.FindByName(null, "InstanceAuto6-elevator_1").__KeyValueFromString("spawnflags", "27")
        Entities.FindByName(null, "AutoInstance1-elevator_1_interior_start_trigger").Destroy()
        elevator_viewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
        elevator_viewcontrol.__KeyValueFromString("targetname", "elevator_viewcontrol")
        elevator_viewcontrol.__KeyValueFromString("fov", "120")
        elevator_viewcontrol.SetOrigin(Vector(-192, 359, -1566))
        EntFire("elevator_viewcontrol", "setparent", "AutoInstance1-elevator_1", 0, null)
        elevator_viewcontrol.SetAngles(0, 90, 0)

        // remove death fade
        Entities.FindByName(null, "death_fade-fade_to_death").Destroy()

        // checkpoint
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1632, 1104, 64), 128), "AddOutput", "OnStartTouch !self:RunScriptCode:Checkpoint()", 0, null, null)

        // making doors not close
        Entities.FindByName(null, "@entry_door").__KeyValueFromString("targetname", "entry_door_p2mmoverride")
        Entities.FindByName(null, "exit_door").__KeyValueFromString("targetname", "exit_door_p2mmoverride")
        Entities.FindByClassnameNearest("trigger_once", Vector(1632, 896, 80), 16).Destroy()
        Entities.FindByClassnameNearest("trigger_once", Vector(1632, 64, 40), 16).Destroy()
        EntFire("AutoInstance1-leaving_elevator_trigger", "AddOutput", "OnTrigger entry_door_p2mmoverride:open")
        EntFire("r1_exit_trigger", "AddOutput", "OnStartTouch exit_door_p2mmoverride:open")

        // Make changing levels work
        Entities.FindByName(null, "end_command").Destroy()
        if (GetMapName().find("sp_") != null) {
            EntFire("exit_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel sp_a3_paint_fling", 2, null)
        } else EntFire("exit_trigger", "AddOutput", "OnStartTouch p2mm_servercommand:Command:changelevel st_a3_paint_fling", 2, null)

    }

    if (MSPostPlayerSpawn) {
        for (local p; p = Entities.FindByClassname(p, "player");) {
            p.SetOrigin(Vector(-192, 352, -1600))
            p.__KeyValueFromString("rendermode", "10")
        }
        EntFire("AutoInstance1-light_elevator_dynamic", "TurnOn")
        EntFire("AutoInstance1-elevator_1", "MoveToPathNode", "AutoInstance1-@elevator_1_bottom_path_1")
        EntFire("AutoInstance1-elevator_1", "StartForward")
        EntFire("AutoInstance1-signs_on", "Trigger")
        EntFire("elevator_viewcontrol", "Enable")
        EntFire("AutoInstance1-source_elevator_door_open_trigger", "AddOutput", "OnTrigger !self:RunScriptCode:EndScene()")
    }
}
function EndScene() {
    // stop the viewcontrol and give the players their gun
    UTIL_Team.Spawn_PortalGun(true)
    EntFire("elevator_viewcontrol", "Disable", null, 0)
    GamePlayerEquip <- Entities.CreateByClassname("game_player_equip")
    GamePlayerEquip.__KeyValueFromString("weapon_portalgun", "1")
    for (local p; p = Entities.FindByClassname(p, "player");) {
        p.__KeyValueFromString("rendermode", "0")
        EntFireByHandle(GamePlayerEquip, "use", "", 0, p, p)
        p.SetOrigin(Vector(576, 495, 0))
    }
    // Enable secondary fire for all guns
    EntFire("weapon_portalgun", "AddOutput", "CanFirePortal2 1", 0, null)
    GamePlayerEquip.Destroy()
    EntFire("elevator_viewcontrol", "Disable", "", 1)
    Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(576, 495, 0)) 

}
function Checkpoint() {
    Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(1632, 891, 48))
    Entities.FindByClassname(null, "info_player_start").SetAngles(0, -90, 0)
}
