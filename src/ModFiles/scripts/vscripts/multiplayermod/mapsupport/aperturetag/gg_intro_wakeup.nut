//  ██████╗  ██████╗            ██╗███╗  ██╗████████╗██████╗  █████╗             ██╗       ██╗ █████╗ ██╗  ██╗███████╗██╗   ██╗██████╗ 
// ██╔════╝ ██╔════╝            ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗            ██║  ██╗  ██║██╔══██╗██║ ██╔╝██╔════╝██║   ██║██╔══██╗
// ██║  ██╗ ██║  ██╗            ██║██╔██╗██║   ██║   ██████╔╝██║  ██║            ╚██╗████╗██╔╝███████║█████═╝ █████╗  ██║   ██║██████╔╝
// ██║  ╚██╗██║  ╚██╗           ██║██║╚████║   ██║   ██╔══██╗██║  ██║             ████╔═████║ ██╔══██║██╔═██╗ ██╔══╝  ██║   ██║██╔═══╝ 
// ╚██████╔╝╚██████╔╝██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝██████████╗  ╚██╔╝ ╚██╔╝ ██║  ██║██║ ╚██╗███████╗╚██████╔╝██║     
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ ╚═════════╝   ╚═╝   ╚═╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝     

bIntroDone <- false

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun) {
        UTIL_Team.Spawn_PortalGun(false)

        Entities.FindByClassnameNearest("logic_auto", Vector(1680, -2784, 192), 32).Destroy()
        // Entities.FindByClassnameNearest("trigger_once", Vector(-780, -2456, 32), 32).Destroy()
        Entities.FindByName(null, "credits_cam").Destroy()

        // Replacement credit viewcontrol
        local cam = Entities.CreateByClassname("point_viewcontrol_multiplayer")
        cam.__KeyValueFromString("targetname", "credits_cam")
        cam.__KeyValueFromString("fov", "100")
        cam.__KeyValueFromString("fov_rate", "0")
        cam.SetOrigin(Vector(1682, -3200, 196))

        // Replacement hall viewcontrol
        local cam2 = Entities.CreateByClassname("point_viewcontrol_multiplayer")
        cam2.SetAngles(0, 90, 0)
        cam2.__KeyValueFromString("targetname", "walkhall_viewcontrol")
        cam2.__KeyValueFromString("fov", "100")
        cam2.__KeyValueFromString("fov_rate", "0")
        cam2.SetOrigin(Vector(1248, -2878, 196))
        EntFireByHandle(cam2, "SetParent", "walkhall_viewcontrol_tank", 0, null, null)

        for (local portal = null; portal = Entities.FindByClassname(portal, "func_areaportal");) {
            EntFireByHandle(portal, "open", "", 0, null, null)
        }

        // Prevent paths from closing
        Entities.FindByName(null, "wakeup_bedroom_door").__KeyValueFromString("targetname", "wakeup_bedroom_door_p2mmoverride")
        EntFire("motel_exit_door_relay", "AddOutput", "OnTrigger wakeup_bedroom_door_p2mmoverride:Open::3")
        EntFire("btsele_door", "AddOutput", "targetname btsele_door_p2mmoverride")
        EntFire("hotel_bts_linked_portal_bts", "AddOutput", "targetname hotel_bts_linked_portal_bts_p2mmoverride")
        EntFire("hotel_bts_linked_portal_hotel", "AddOutput", "targetname hotel_bts_linked_portal_hotel_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(54, -2658, -610), 32), "AddOutput", "OnStartTouch btsele_door_p2mmoverride:SetAnimation:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(54, -2658, -610), 32), "AddOutput", "OnStartTouch hotel_bts_linked_portal_bts_p2mmoverride:Open", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(54, -2658, -610), 32), "AddOutput", "OnStartTouch hotel_bts_linked_portal_hotel_p2mmoverride:Open", 0, null, null)
        Entities.FindByClassnameNearest("trigger_once", Vector(144, -2656, -324), 32).Destroy()
        Entities.FindByName(null, "catwalk_to_spawn").Destroy()
        Entities.FindByName(null, "hotel_bts_tractorbeam").__KeyValueFromString("targetname", "hotel_bts_tractorbeam_p2mmoverride")
        Entities.FindByName(null, "hotel_bts_tractorbeam_2").__KeyValueFromString("targetname", "hotel_bts_tractorbeam_2_p2mmoverride")
        Entities.FindByName(null, "catwalk_collision").__KeyValueFromString("targetname", "catwalk_collision_p2mmoverride")
        EntFire("catwalk_to_destroy", "AddOutput", "targetname catwalk_to_destroy_p2mmoverride")
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-320, 608, -800), 32), "AddOutput", "OnTrigger hotel_bts_tractorbeam_p2mmoverride:Enable", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(-320, 480, -112), 32), "AddOutput", "OnTrigger hotel_bts_tractorbeam_2_p2mmoverride:Enable", 0, null, null)

        // Not sure why this breaks in MP, I just set the trigger to push everything and that made it push the cube again
        Entities.FindByClassnameNearest("trigger_push", Vector(1496, 128, -1592), 32).__KeyValueFromString("spawnflags", "64")

        // Make the player that reached the vac tube see the cutscene
        // This is commented out instead of deleted incase i get the tube cutscene working later
        // local camera = Entities.CreateByClassname("point_viewcontrol")
        // camera.SetOrigin(Vector(1184, 480, 352))
        Entities.FindByName(null, "@tube_ride_start_relay").Destroy()
        // camera.__KeyValueFromString("target", "@podtrain_player")
        // camera.__KeyValueFromString("moveto", "@tube_path_inst_start")
        // camera.__KeyValueFromString("speed", "600")
        // camera.__KeyValueFromString("targetname", "@tube_ride_viewproxy")
        // camera.__KeyValueFromString("spawnflags", "24")
        // EntFireByHandle(camera, "SetParent", "@podtrain_player", 0, null, null)
        // EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1183.99, 480, 352), 32), "AddOutput", "OnTrigger !self:RunScriptCode:endScene=true", 0, null, null)

        // Make transitions work
        // This is commented out instead of deleted incase i get the tube cutscene working later
        // Entities.FindByName(null, "@transition_script").Destroy()
        // EntFire("tube_path_27", "AddOutput", "OnPass p2mm_servercommand:Command:changelevel gg_blue_only:0.3", 0, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1183.99 480 352), 32), "AddOutput", "OnTrigger fade_ending_tube:Fade", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1183.99 480 352), 32), "AddOutput", "OnTrigger p2mm_servercommand:Command:changelevel gg_blue_only:2", 0, null, null)

        EntFire("wakeup_relay", "AddOutput", "OnTrigger !self:RunScriptCode:endIntro():1.05")
    }

    if (MSPostPlayerSpawn) {
        // Start sequence
        EntFire("spawnroom_fade_intro", "Fade", "", 0)
        EntFire("@global_memorysoundloop", "PlaySound", "", 0)
        EntFire("fire_particle_entrance", "Start", "", 0)
        EntFire("@global_memorysong", "PlaySound", "", 0.1)
        EntFire("spawnroom_tele", "Enable", "", 1)
        // Make players invisible and not able to move
        for (local p; p = Entities.FindByClassname(p, "player");) {
            p.__KeyValueFromString("rendermode", "10")
            SetSpeed(p, 0)
        }
    }

    if (MSOnRespawn) {
        if (!bIntroDone) {
            MSOnRespawn.__KeyValueFromString("rendermode", "10")
            SetSpeed(MSOnRespawn, 0)
        }
    }
}

function endIntro() {
    bIntroDone = true
    for (local p; p = Entities.FindByClassname(p, "player");) {
        p.__KeyValueFromString("rendermode", "0")
        SetSpeed(p, 1)
    }
    Entities.FindByClassname(null, "info_player_start").SetOrigin(Vector(-723, -2481, 53))
    Entities.FindByClassname(null, "info_player_start").SetAngles(0, 30, 0)
}
