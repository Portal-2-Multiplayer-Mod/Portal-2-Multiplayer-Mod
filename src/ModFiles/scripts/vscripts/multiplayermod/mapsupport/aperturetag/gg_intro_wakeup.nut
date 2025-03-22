//  ██████╗  ██████╗            ██╗███╗  ██╗████████╗██████╗  █████╗             ██╗       ██╗ █████╗ ██╗  ██╗███████╗██╗   ██╗██████╗ 
// ██╔════╝ ██╔════╝            ██║████╗ ██║╚══██╔══╝██╔══██╗██╔══██╗            ██║  ██╗  ██║██╔══██╗██║ ██╔╝██╔════╝██║   ██║██╔══██╗
// ██║  ██╗ ██║  ██╗            ██║██╔██╗██║   ██║   ██████╔╝██║  ██║            ╚██╗████╗██╔╝███████║█████═╝ █████╗  ██║   ██║██████╔╝
// ██║  ╚██╗██║  ╚██╗           ██║██║╚████║   ██║   ██╔══██╗██║  ██║             ████╔═████║ ██╔══██║██╔═██╗ ██╔══╝  ██║   ██║██╔═══╝ 
// ╚██████╔╝╚██████╔╝██████████╗██║██║ ╚███║   ██║   ██║  ██║╚█████╔╝██████████╗  ╚██╔╝ ╚██╔╝ ██║  ██║██║ ╚██╗███████╗╚██████╔╝██║     
//  ╚═════╝  ╚═════╝ ╚═════════╝╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝  ╚═╝ ╚════╝ ╚═════════╝   ╚═╝   ╚═╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝     

bIntroDone <- false
respawnCooldown <- 0
cubesSpawned <- false
tubePlayer <- null
trackCoords <- Vector(0, 0, 0)

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

        // Prevent cube from exiting the test. We have to handle this ourselves because the brush keeping the cubes in also keeps incoming players out.
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1008, 784, 352), 32), "AddOutput", "OnStartTouch !self:RunScriptCode:respawnCooldown=Time()+6", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1008, 784, 352), 32), "AddOutput", "OnStartTouch !self:RunScriptCode:cubesSpawned=true", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1008, 784, 352), 32), "AddOutput", "OnStartTouch laserroom_reflective_1_temp:Kill::1", 0, null, null)
        EntFireByHandle(Entities.FindByClassnameNearest("trigger_once", Vector(1008, 784, 352), 32), "AddOutput", "OnStartTouch laserroom_reflective_2_temp:Kill::1", 0, null, null)
        Entities.FindByName(null, "cube_clipper_brush").Destroy()

        // Not sure why this breaks in MP, I just set the trigger to push everything and that made it push the cube again
        Entities.FindByClassnameNearest("trigger_push", Vector(1496, 128, -1592), 32).__KeyValueFromString("spawnflags", "64")

        for (local track = null; track = Entities.FindByClassname(track, "path_track");) {
            if (track.GetName().find("tube_path_") != null) {
                EntFireByHandle(track, "AddOutput", "OnPass !self:RunScriptCode:correctPosition()", 0, null, null)
            }
        }

        // Make transitions work
        Entities.FindByName(null, "@transition_script").Destroy()
        EntFire("tube_path_27", "AddOutput", "OnPass p2mm_servercommand:Command:changelevel gg_blue_only:1")

        // Make vactube ride work
        EntFire("@tube_ride_start_relay", "AddOutput", "OnTrigger !activator:RunScriptCode:vacTube(activator)")

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

    if (MSLoop) {
        if (respawnCooldown > Time() || !cubesSpawned) return
        
        local cubes = CreateTrigger("prop_weighted_cube", 1568, 896, 128, 800, 64, 320)
        local respawnCube1 = true
        local respawnCube2 = true
        try {
            switch (cubes[0].GetName()) {
                case "laserroom_reflective_1":
                    respawnCube1 = false
                    break
                case "laserroom_reflective_2":
                    respawnCube2 = false
                    break
            }
        }
        catch (exception) {} // Out of playable area, respawn the cube

        try {
            switch (cubes[1].GetName()) {
                case "laserroom_reflective_1":
                    respawnCube1 = false
                    break
                case "laserroom_reflective_2":
                    respawnCube2 = false
                    break
            }
        }
        catch (exception) {} // Out of playable area, respawn the cube

        if (respawnCube1) {
            respawnCooldown = Time() + 6
            EntFire("laserroom_reflective_1", "Dissolve", "")
            EntFire("p2mm_servercommand", "Command", "script respawnCube(1)", 1)
            // need a small delay so the entfire can process first and not dissolve our new cube
        }
        if (respawnCube2) {
            respawnCooldown = Time() + 6
            EntFire("laserroom_reflective_2", "Dissolve", "")
            EntFire("p2mm_servercommand", "Command", "script respawnCube(2)", 1)
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

function vacTube(activator) {
    Entities.FindByName(null, "pusher").Destroy()
    Entities.FindByName(null, "fling_tube").Destroy()
    Entities.FindByClassnameNearest("point_push", Vector(1184, 480, 256), 32).Destroy()
    
    SetSpeed(activator, 0)
    EnableNoclip(true, activator)
    
    activator.SetVelocity(Vector(0, 0, 0))
    EntFireByHandle(activator, "SetParent", "@podtrain_player", 0, null, null)
    EntFire("@podtrain_player", "SetSpeed", "1")
    tubePlayer = activator
}

function respawnCube(cubeNumber) {
    local cube = Entities.CreateByClassname("prop_weighted_cube")
    cube.__KeyValueFromString("CubeType", "2")
    cube.__KeyValueFromString("skin", "3")
    switch (cubeNumber) {
        case 1:
            cube.__KeyValueFromString("targetname", "laserroom_reflective_1")
            cube.SetOrigin(Vector(1744, -48, 304))
            break
        case 2:
            cube.__KeyValueFromString("targetname", "laserroom_reflective_2")
            cube.SetOrigin(Vector(1728, 384, 432))
            break
    }
    InitializeEntity(cube)
}

function correctPosition() {
    // The vactube ride is very buggy on client for some reason, so we need to correct it constantly

    trackCoords = Entities.FindByName(null, "@podtrain_player").GetOrigin()
    if (!Entities.FindByClassnameNearest("player", trackCoords, 64)) {
        EntFireByHandle(tubePlayer, "SetParent", "", 0, null, null)
        EntFire("p2mm_servercommand", "Command", "script tubePlayer.SetOrigin(Vector(trackCoords.x, trackCoords.y, trackCoords.z - 56))", 0.02)
        EntFireByHandle(tubePlayer, "SetParent", "@podtrain_player", 0.05, null, null)
        tubePlayer.SetVelocity(Vector(0, 0, 0))
    }
}
