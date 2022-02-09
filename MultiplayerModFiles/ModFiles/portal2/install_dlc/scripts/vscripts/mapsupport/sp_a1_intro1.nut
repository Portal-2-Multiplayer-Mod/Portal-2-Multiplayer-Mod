// ███╗   ███╗ █████╗ ██████╗ ███╗  ██╗ █████╗ ███╗   ███╗███████╗
// ████╗ ████║██╔══██╗██╔══██╗████╗ ██║██╔══██╗████╗ ████║██╔════╝
// ██╔████╔██║███████║██████╔╝██╔██╗██║███████║██╔████╔██║█████╗
// ██║╚██╔╝██║██╔══██║██╔═══╝ ██║╚████║██╔══██║██║╚██╔╝██║██╔══╝
// ██║ ╚═╝ ██║██║  ██║██║     ██║ ╚███║██║  ██║██║ ╚═╝ ██║███████╗
// ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚══╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝

HasSleptInContainer1 <- false
function p232DestroyedSequence() {
    printl("p232DestroyedSequence")
    HasSleptInContainer1 = true
}

CurrentTeleportOffset <- 0
DisableJumpmsp <- false
function p232DropCollision() {
    DisableJumpmsp = true
    EntFire("p232servercommand", "command", "script DisableJumpmsp = false", 3)
    printl("dropping container collision!")
    local dropamount = 50
    local ceiltime = 2.6

    local CustomBrush1 = Entities.FindByName(null, "CustomBrush1")
    local CustomBrush2 = Entities.FindByName(null, "CustomBrush2")
    local CustomBrush3 = Entities.FindByName(null, "CustomBrush3")
    local CustomBrush4 = Entities.FindByName(null, "CustomBrush4")
    local CustomBrush5 = Entities.FindByName(null, "CustomBrush5")
    local CustomBrush6 = Entities.FindByName(null, "CustomBrush6")
    local CustomBrush7 = Entities.FindByName(null, "CustomBrush7")
    local CustomBrush8 = Entities.FindByName(null, "CustomBrush8")
    local CustomBrush9 = Entities.FindByName(null, "CustomBrush9")
    local CustomBrush10 = Entities.FindByName(null, "CustomBrush10")
    local CustomBrush11 = Entities.FindByName(null, "CustomBrush11")
    local CustomBrush12 = Entities.FindByName(null, "CustomBrush12")

    // CustomBrush1
    CustomBrush1.SetOrigin(Vector(CustomBrush1.GetOrigin().x, CustomBrush1.GetOrigin().y, CustomBrush1.GetOrigin().z - dropamount))
    // EntFire("CustomBrush1", "disable")
    // EntFire("CustomBrush1", "enable", "", ceiltime)
    // CustomBrush2
    CustomBrush2.SetOrigin(Vector(CustomBrush2.GetOrigin().x, CustomBrush2.GetOrigin().y, CustomBrush2.GetOrigin().z - dropamount))
    // EntFire("CustomBrush2", "disable")
    // EntFire("CustomBrush2", "enable", "", ceiltime)
    // CustomBrush3
    CustomBrush3.SetOrigin(Vector(CustomBrush3.GetOrigin().x, CustomBrush3.GetOrigin().y, CustomBrush3.GetOrigin().z - dropamount))
    // EntFire("CustomBrush3", "disable")
    // EntFire("CustomBrush3", "enable", "", ceiltime)
    // CustomBrush4
    CustomBrush4.SetOrigin(Vector(CustomBrush4.GetOrigin().x, CustomBrush4.GetOrigin().y, CustomBrush4.GetOrigin().z - dropamount))
    EntFire("CustomBrush4", "disable")
    EntFire("CustomBrush4", "enable", "", ceiltime)
    // CustomBrush5
    CustomBrush5.SetOrigin(Vector(CustomBrush5.GetOrigin().x, CustomBrush5.GetOrigin().y, CustomBrush5.GetOrigin().z - dropamount))
    // EntFire("CustomBrush5", "disable")
    // EntFire("CustomBrush5", "enable", "", ceiltime)
    // CustomBrush6
    CustomBrush6.SetOrigin(Vector(CustomBrush6.GetOrigin().x, CustomBrush6.GetOrigin().y, CustomBrush6.GetOrigin().z - dropamount))
    // EntFire("CustomBrush6", "disable")
    // EntFire("CustomBrush6", "enable", "", ceiltime)
    // CustomBrush7
    CustomBrush7.SetOrigin(Vector(CustomBrush7.GetOrigin().x, CustomBrush7.GetOrigin().y, CustomBrush7.GetOrigin().z - dropamount))
    // EntFire("CustomBrush7", "disable")
    // EntFire("CustomBrush7", "enable", "", ceiltime)
    // CustomBrush8
    CustomBrush8.SetOrigin(Vector(CustomBrush8.GetOrigin().x, CustomBrush8.GetOrigin().y, CustomBrush8.GetOrigin().z - dropamount))
    // EntFire("CustomBrush8", "disable")
    // EntFire("CustomBrush8", "enable", "", ceiltime)
    // CustomBrush9
    CustomBrush9.SetOrigin(Vector(CustomBrush9.GetOrigin().x, CustomBrush9.GetOrigin().y, CustomBrush9.GetOrigin().z - dropamount))
    // EntFire("CustomBrush9", "disable")
    // EntFire("CustomBrush9", "enable", "", ceiltime)
    // CustomBrush10
    CustomBrush10.SetOrigin(Vector(CustomBrush10.GetOrigin().x, CustomBrush10.GetOrigin().y, CustomBrush10.GetOrigin().z - dropamount))
    // EntFire("CustomBrush10", "disable")
    // EntFire("CustomBrush10", "enable", "", ceiltime)
    // CustomBrush11
    CustomBrush11.SetOrigin(Vector(CustomBrush11.GetOrigin().x, CustomBrush11.GetOrigin().y, CustomBrush11.GetOrigin().z - dropamount))
    // EntFire("CustomBrush11", "disable")
    // EntFire("CustomBrush11", "enable", "", ceiltime)
    // CustomBrush12
    CustomBrush12.SetOrigin(Vector(CustomBrush12.GetOrigin().x, CustomBrush12.GetOrigin().y, CustomBrush12.GetOrigin().z - dropamount))
    // EntFire("CustomBrush12", "disable")
    // EntFire("CustomBrush12", "enable", "", ceiltime)
    //DebugDrawBox(CustomBrush1.GetOrigin(), CustomBrush1.GetBoundingMins(), CustomBrush1.GetBoundingMaxs(), 255, 155, 0, 15, 9999999)
    //DebugDrawBox(CustomBrush2.GetOrigin(), CustomBrush2.GetBoundingMins(), CustomBrush2.GetBoundingMaxs(), 255, 155, 0, 15, 9999999)
    //DebugDrawBox(CustomBrush3.GetOrigin(), CustomBrush3.GetBoundingMins(), CustomBrush3.GetBoundingMaxs(), 255, 155, 0, 15, 9999999)
    //DebugDrawBox(CustomBrush4.GetOrigin(), CustomBrush4.GetBoundingMins(), CustomBrush4.GetBoundingMaxs(), 255, 155, 0, 15, 9999999)
    //DebugDrawBox(CustomBrush5.GetOrigin(), CustomBrush5.GetBoundingMins(), CustomBrush5.GetBoundingMaxs(), 255, 155, 0, 15, 9999999)
    //DebugDrawBox(CustomBrush6.GetOrigin(), CustomBrush6.GetBoundingMins(), CustomBrush6.GetBoundingMaxs(), 255, 155, 0, 15, 9999999)
    //DebugDrawBox(CustomBrush7.GetOrigin(), CustomBrush7.GetBoundingMins(), CustomBrush7.GetBoundingMaxs(), 255, 155, 0, 15, 9999999)
    //DebugDrawBox(CustomBrush8.GetOrigin(), CustomBrush8.GetBoundingMins(), CustomBrush8.GetBoundingMaxs(), 255, 155, 0, 15, 9999999)
    //DebugDrawBox(CustomBrush9.GetOrigin(), CustomBrush9.GetBoundingMins(), CustomBrush9.GetBoundingMaxs(), 255, 155, 0, 15, 9999999)
    //DebugDrawBox(CustomBrush10.GetOrigin(), CustomBrush10.GetBoundingMins(), CustomBrush10.GetBoundingMaxs(), 255, 155, 0, 15, 9999999)
    //DebugDrawBox(CustomBrush11.GetOrigin(), CustomBrush11.GetBoundingMins(), CustomBrush11.GetBoundingMaxs(), 255, 155, 0, 15, 9999999)
    //DebugDrawBox(CustomBrush12.GetOrigin(), CustomBrush12.GetBoundingMins(), CustomBrush12.GetBoundingMaxs(), 255, 155, 0, 15, 9999999)
}

containerStick <- false
function p232ParentAndStartMath() {
    //DisableJumpmsp = true
    // TABLE
        // CustomBrush7.__KeyValueFromInt("Solid", 0)
        // CEILING
        // CustomBrush4.__KeyValueFromInt("Solid", 0)
        // FLOOR
        // CustomBrush2.__KeyValueFromInt("Solid", 0)
        // PLANT
        // CustomBrush9.__KeyValueFromInt("Solid", 0)
        // CHAIR
        // CustomBrush10.__KeyValueFromInt("Solid", 0)
        // BED
        // CustomBrush1.__KeyValueFromInt("Solid", 0)
        EntFire("CustomBrush1", "disable", "", 0)
        EntFire("CustomBrush2", "disable", "", 0)
        EntFire("CustomBrush4", "disable", "", 0)
        EntFire("CustomBrush7", "disable", "", 0)
        EntFire("CustomBrush9", "disable", "", 0)
        EntFire("CustomBrush10", "disable", "", 0)

        EntFire("CustomBrush1", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush1", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush2", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush2", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush3", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush3", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush4", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush4", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush5", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush5", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush6", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush6", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush7", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush7", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush8", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush8", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush9", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush9", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush10", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush10", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush11", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush11", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush12", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush12", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
    containerStick = true
}

SecondToLastTP <- false
function StopStickAndTeleport() {
    EntFire("CustomBrush1", "disable", "", 0)
    EntFire("CustomBrush2", "disable", "", 0)
    EntFire("CustomBrush3", "disable", "", 0)
    EntFire("CustomBrush4", "disable", "", 0)
    EntFire("CustomBrush5", "disable", "", 0)
    EntFire("CustomBrush6", "disable", "", 0)
    EntFire("CustomBrush7", "disable", "", 0)
    EntFire("CustomBrush8", "disable", "", 0)
    EntFire("CustomBrush9", "disable", "", 0)
    EntFire("CustomBrush10", "disable", "", 0)
    EntFire("CustomBrush11", "disable", "", 0)
    EntFire("CustomBrush12", "disable", "", 0)

    //EntFire("CustomBrush1", "kill", "", 0)
    EntFire("CustomBrush2", "kill", "", 0)
    EntFire("CustomBrush3", "kill", "", 0)
    EntFire("CustomBrush4", "kill", "", 0)
    EntFire("CustomBrush5", "kill", "", 0)
    EntFire("CustomBrush6", "kill", "", 0)
    EntFire("CustomBrush7", "kill", "", 0)
    EntFire("CustomBrush8", "kill", "", 0)
    EntFire("CustomBrush9", "kill", "", 0)
    EntFire("CustomBrush10", "kill", "", 0)
    EntFire("CustomBrush11", "kill", "", 0)
    EntFire("CustomBrush12", "kill", "", 0)

    EntFire("container_collision", "EnableCollision", "", 0)
    
    Entities.FindByName(null, "@container_stacks_1").__KeyValueFromString("targetname", "p232save1")
    Entities.FindByName(null, "p232containerstacks2").__KeyValueFromString("targetname", "p232save2")
    Entities.FindByName(null, "Actor_wall_destruction_01").__KeyValueFromString("targetname", "p232save3")
    Entities.FindByName(null, "kill_container_rl").Destroy()
    containerStick = false
    SecondToLastTP = true
    DisableJumpmsp = false
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        EntFireByHandle(p, "addoutput", "MoveType 2", 0, null, null)
        p.SetOrigin(Vector(-1649, 4376, 3112))
        p.SetVelocity(Vector(80, 0, 0))
    }
}

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        CustomBrush1 <- false
        CustomBrush1Cache <- false
        stoprenable <- false

        // Create Env Globals
        env_global01 <- Entities.CreateByClassname("env_global")
        env_global01.__KeyValueFromString("targetname", "env_global01")
        env_global01.__KeyValueFromString("globalstate", "no_pinging_blue")


        env_global02 <- Entities.CreateByClassname("env_global")
        env_global02.__KeyValueFromString("targetname", "env_global02")
        env_global02.__KeyValueFromString("globalstate", "no_pinging_orange")

        env_global03 <- Entities.CreateByClassname("env_global")
        env_global03.__KeyValueFromString("targetname", "env_global03")
        env_global03.__KeyValueFromString("globalstate", "no_taunting_blue")


        env_global04 <- Entities.CreateByClassname("env_global")
        env_global04.__KeyValueFromString("targetname", "env_global04")
        env_global04.__KeyValueFromString("globalstate", "no_taunting_orange")

        EntFireByHandle(env_global01, "turnon", "", 1, null, null)
        EntFireByHandle(env_global02, "turnon", "", 1, null, null)
        EntFireByHandle(env_global03, "turnon", "", 1, null, null)
        EntFireByHandle(env_global04, "turnon", "", 1, null, null)

        HasStartedSp_A1_Intro1 <- false

        Entities.FindByName(null, "@music_awake").__KeyValueFromString("targetname", "p232musicawake")
        Entities.FindByName(null, "open_portal_relay").__KeyValueFromString("targetname", "p232portalrelay")
        Entities.FindByName(null, "mmc_clock_flash_relay").__KeyValueFromString("targetname", "p232clockflashrelay")
        Entities.FindByName(null, "@container_stacks_2").__KeyValueFromString("targetname", "p232containerstacks2")
        Entities.FindByName(null, "portal_red_0_deactivate_rl").Destroy()
        Entities.FindByName(null, "portal_blue_0_deactivate_rl").Destroy()

        EntFire("container_collision", "DisableCollision", "", 0)

        EntFire("return_to_bed_button", "addoutput", "OnPressed p232servercommand:command:script p232DestroyedSequence():5")
        EntFire("@rl_container_ride", "addoutput", "OnTrigger p232servercommand:command:script p232DropCollision():0.5")
        EntFire("@rl_container_ride_second_section", "addoutput", "OnTrigger p232servercommand:command:script p232ParentAndStartMath()")
        EntFire("@rl_container_ride_second_section", "addoutput", "OnTrigger p232containerstacks2:SetAnimation:anim1")
        EntFire("@rl_container_ride_third_section", "addoutput", "OnTrigger p232servercommand:command:script StopStickAndTeleport()")
        EntFire("enter_chamber_trigger", "addoutput", "OnTrigger p232portalrelay:Trigger::34")
        //@rl_container_ride
        EntFire("relay_start_map", "addoutput", "OnTrigger p232clockflashrelay:Trigger")
        EntFire("p232clockflashrelay", "addoutput", "OnTrigger p232clockflashrelay:Trigger::1")
        Entities.FindByName(null, "@knockout_teleport_1").Destroy()
        bumpout <- true
        //door_hud_hint_trigger
        Entities.FindByName(null, "door_hud_hint_trigger").SetOrigin(Vector(Entities.FindByName(null, "door_hud_hint_trigger").GetOrigin().x, Entities.FindByName(null, "door_hud_hint_trigger").GetOrigin().y + 512, Entities.FindByName(null, "door_hud_hint_trigger").GetOrigin().z))
        Entities.FindByName(null, "door_open_trigger").SetOrigin(Vector(Entities.FindByName(null, "door_open_trigger").GetOrigin().x, Entities.FindByName(null, "door_open_trigger").GetOrigin().y + 512, Entities.FindByName(null, "door_open_trigger").GetOrigin().z))
        Entities.FindByName(null, "sphere_is_inside_room_trigger").SetOrigin(Vector(Entities.FindByName(null, "sphere_is_inside_room_trigger").GetOrigin().x, Entities.FindByName(null, "sphere_is_inside_room_trigger").GetOrigin().y + 512, Entities.FindByName(null, "sphere_is_inside_room_trigger").GetOrigin().z))
        //Entities.FindByName(null, "container_entry_door").SetOrigin(Vector(Entities.FindByName(null, "container_entry_door").GetOrigin().x, Entities.FindByName(null, "container_entry_door").GetOrigin().y + 512, Entities.FindByName(null, "container_entry_door").GetOrigin().z))
        //Entities.FindByName(null, "container_entry_door_push").SetOrigin(Vector(Entities.FindByName(null, "container_entry_door_push").GetOrigin().x, Entities.FindByName(null, "container_entry_door_push").GetOrigin().y + 512, Entities.FindByName(null, "container_entry_door_push").GetOrigin().z))
        Entities.FindByName(null, "door_1-door_close_relay").Destroy()
        Entities.FindByClassnameNearest("logic_auto", Vector(-5675, 1459, 305), 16).Destroy()
        OnlyOnceSp_A1_Intro1 <- true
    }

    if (MSPostPlayerSpawn==true) {
        HasStartedSp_A1_Intro1 <- true
        EntFire("relay_start_cryo_sequence", "Trigger", "", 0)
        EntFire("relay_intro_camera", "Trigger", "", 0)
        EntFire("p232musicawake", "PlaySound", "", 0.4)
        EntFire("announcer_ding_on_wav", "PlaySound", "", 1.5)
        EntFire("good_morning_vcd", "Start", "", 3)

        printl("Ran")
        Sp_A1_Intro1Viewcontrol <- Entities.CreateByClassname("point_viewcontrol_multiplayer")
        Sp_A1_Intro1Viewcontrol.__KeyValueFromString("targetname", "Sp_A1_Intro1Viewcontrol")
        Sp_A1_Intro1Viewcontrol.__KeyValueFromString("target_team", "-1")
        Sp_A1_Intro1Viewcontrol.SetOrigin(Entities.FindByName(null, "camera_intro").GetOrigin())
        Sp_A1_Intro1Viewcontrol.SetAngles(0, 0, 0)
        EntFire("Sp_A1_Intro1Viewcontrol", "setparent", "camera_intro", 0, null)
        EntFire("Sp_A1_Intro1Viewcontrol", "setparentattachment", "camera_intro", 0, null)
        EntFire("Sp_A1_Intro1Viewcontrol", "enable", "", 0, null)
        EntFire("Sp_A1_Intro1ViewcontrolTele", "disable", "", 12, null)
        EntFire("Sp_A1_Intro1Viewcontrol", "addoutput", "targetname Sp_A1_Intro1ViewcontrolTele", 0.25, null)
        EntFire("Sp_A1_Intro1ViewcontrolTele", "addoutput", "targetname Sp_A1_Intro1ViewcontrolDone", 12, null)

        // CustomBrush1
        CustomBrush1 <- Entities.CreateByClassname("func_brush")
        CustomBrush1.SetOrigin(Vector(-5738.623046875, 1778.7027587891, 194.95379638672))
        CustomBrush1.SetSize(Vector(0, 0 ,0), Vector(71.01123046875, 136.28967285156, 51.549301147461))
        CustomBrush1.__KeyValueFromInt("Solid", 3)
        CustomBrush1.__KeyValueFromString("targetname", "CustomBrush1")
        //DebugDrawBox(CustomBrush1.GetOrigin(), CustomBrush1.GetBoundingMins(), CustomBrush1.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush2
        CustomBrush2 <- Entities.CreateByClassname("func_brush")
        CustomBrush2.SetOrigin(Vector(-6042.2216796875, 1783.7899169922, 171.91059875488))
        CustomBrush2.SetSize(Vector(0, 0 ,0), Vector(550.02978515625, 266.28076171875, 48.8125))
        CustomBrush2.__KeyValueFromInt("Solid", 3)
        CustomBrush2.__KeyValueFromString("targetname", "CustomBrush2")
        //DebugDrawBox(CustomBrush2.GetOrigin(), CustomBrush2.GetBoundingMins(), CustomBrush2.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush3
        CustomBrush3 <- Entities.CreateByClassname("func_brush")
        CustomBrush3.SetOrigin(Vector(-5973.8920898438, 1764.6313476562, 203.77949523926))
        CustomBrush3.SetSize(Vector(0, 0 ,0), Vector(491.03125, 50.630981445312, 153.08879089355))
        CustomBrush3.__KeyValueFromInt("Solid", 3)
        CustomBrush3.__KeyValueFromString("targetname", "CustomBrush3")
        //DebugDrawBox(CustomBrush3.GetOrigin(), CustomBrush3.GetBoundingMins(), CustomBrush3.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush4
        CustomBrush4 <- Entities.CreateByClassname("func_brush")
        CustomBrush4.SetOrigin(Vector(-6003.9296875, 1777.9016113281, 346.05218505859))
        CustomBrush4.SetSize(Vector(0, 0 ,0), Vector(542.7041015625, 239.28088378906, 70.41552734375))
        CustomBrush4.__KeyValueFromInt("Solid", 3)
        CustomBrush4.__KeyValueFromString("targetname", "CustomBrush4")
        //DebugDrawBox(CustomBrush4.GetOrigin(), CustomBrush4.GetBoundingMins(), CustomBrush4.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush5
        CustomBrush5 <- Entities.CreateByClassname("func_brush")
        CustomBrush5.SetOrigin(Vector(-5973.0200195312, 1791.1186523438, 193.61361694336))
        CustomBrush5.SetSize(Vector(0, 0 ,0), Vector(126.4052734375, 141, 185.86248779297))
        CustomBrush5.__KeyValueFromInt("Solid", 3)
        CustomBrush5.__KeyValueFromString("targetname", "CustomBrush5")
        //DebugDrawBox(CustomBrush5.GetOrigin(), CustomBrush5.GetBoundingMins(), CustomBrush5.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush6
        CustomBrush6 <- Entities.CreateByClassname("func_brush")
        CustomBrush6.SetOrigin(Vector(-6007.9018554688, 2011.3055419922, 195.1164855957))
        CustomBrush6.SetSize(Vector(0, 0 ,0), Vector(546.029296875, 46.874267578125, 179.13430786133))
        CustomBrush6.__KeyValueFromInt("Solid", 3)
        CustomBrush6.__KeyValueFromString("targetname", "CustomBrush6")
        CustomBrush6 <- Entities.FindByName(null, "CustomBrush6")
        //DebugDrawBox(CustomBrush6.GetOrigin(), CustomBrush6.GetBoundingMins(), CustomBrush6.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush7
        CustomBrush7 <- Entities.CreateByClassname("func_brush")
        CustomBrush7.SetOrigin(Vector(-5790.7231445312, 1972.4986572266, 196.52439880371))
        CustomBrush7.SetSize(Vector(0, 0 ,0), Vector(108, 53.184814453125, 101.9672088623))
        CustomBrush7.__KeyValueFromInt("Solid", 3)
        CustomBrush7.__KeyValueFromString("targetname", "CustomBrush7")
        //DebugDrawBox(CustomBrush7.GetOrigin(), CustomBrush7.GetBoundingMins(), CustomBrush7.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush8
        CustomBrush8 <- Entities.CreateByClassname("func_brush")
        CustomBrush8.SetOrigin(Vector(-6030.4404296875, 1760.5928955078, 193.29339599609))
        CustomBrush8.SetSize(Vector(0, 0 ,0), Vector(49.1484375, 259.24450683594, 192.57360839844))
        CustomBrush8.__KeyValueFromInt("Solid", 3)
        CustomBrush8.__KeyValueFromString("targetname", "CustomBrush8")
        //DebugDrawBox(CustomBrush8.GetOrigin(), CustomBrush8.GetBoundingMins(), CustomBrush8.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush9
        CustomBrush9 <- Entities.CreateByClassname("func_brush")
        CustomBrush9.SetOrigin(Vector(-5580.380859375, 1943.3970947266, 186.30889892578))
        CustomBrush9.SetSize(Vector(0, 0 ,0), Vector(74.576171875, 91.832641601562, 55.819595336914))
        CustomBrush9.__KeyValueFromInt("Solid", 3)
        CustomBrush9.__KeyValueFromString("targetname", "CustomBrush9")
        //DebugDrawBox(CustomBrush9.GetOrigin(), CustomBrush9.GetBoundingMins(), CustomBrush9.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush10
        CustomBrush10 <- Entities.CreateByClassname("func_brush")
        CustomBrush10.SetOrigin(Vector(-5594.9174804688, 1773.0458984375, 162.32829284668))
        CustomBrush10.SetSize(Vector(0, 0 ,0), Vector(100.14599609375, 89.349365234375, 94.880722045898))
        CustomBrush10.__KeyValueFromInt("Solid", 3)
        CustomBrush10.__KeyValueFromString("targetname", "CustomBrush10")
        //DebugDrawBox(CustomBrush10.GetOrigin(), CustomBrush10.GetBoundingMins(), CustomBrush10.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush11
        CustomBrush11 <- Entities.CreateByClassname("func_brush")
        CustomBrush11.SetOrigin(Vector(-5525.6733398438, 1764.2416992188, 204.33180236816))
        CustomBrush11.SetSize(Vector(0, 0 ,0), Vector(64.3701171875, 257.22619628906, 168.0611114502))
        CustomBrush11.__KeyValueFromInt("Solid", 3)
        CustomBrush11.__KeyValueFromString("targetname", "CustomBrush11")
        //DebugDrawBox(CustomBrush11.GetOrigin(), CustomBrush11.GetBoundingMins(), CustomBrush11.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush12
        CustomBrush12 <- Entities.CreateByClassname("func_brush")
        CustomBrush12.SetOrigin(Vector(-5972.2534179688, 1785.1105957031, 181.52520751953))
        CustomBrush12.SetSize(Vector(0, 0 ,0), Vector(154.63916015625, 102.44201660156, 181.24530029297))
        CustomBrush12.__KeyValueFromInt("Solid", 3)
        CustomBrush12.__KeyValueFromString("targetname", "CustomBrush12")
        //DebugDrawBox(CustomBrush12.GetOrigin(), CustomBrush12.GetBoundingMins(), CustomBrush12.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)


        // TABLE
        // CustomBrush7.__KeyValueFromInt("Solid", 0)
        // CEILING
        // CustomBrush4.__KeyValueFromInt("Solid", 0)
        // FLOOR
        // CustomBrush2.__KeyValueFromInt("Solid", 0)
        // PLANT
        // CustomBrush9.__KeyValueFromInt("Solid", 0)
        // CHAIR
        // CustomBrush10.__KeyValueFromInt("Solid", 0)
        // BED
        // CustomBrush1.__KeyValueFromInt("Solid", 0)


        // EntFire("CustomBrush1", "SetParent", "Actor_container_master", 0)
        // EntFire("CustomBrush1", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        // EntFire("CustomBrush2", "SetParent", "Actor_container_master", 0)
        // EntFire("CustomBrush2", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        // EntFire("CustomBrush3", "SetParent", "Actor_container_master", 0)
        // EntFire("CustomBrush3", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        // EntFire("CustomBrush4", "SetParent", "Actor_container_master", 0)
        // EntFire("CustomBrush4", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        // EntFire("CustomBrush5", "SetParent", "Actor_container_master", 0)
        // EntFire("CustomBrush5", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        // EntFire("CustomBrush6", "SetParent", "Actor_container_master", 0)
        // EntFire("CustomBrush6", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        // EntFire("CustomBrush7", "SetParent", "Actor_container_master", 0)
        // EntFire("CustomBrush7", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        // EntFire("CustomBrush8", "SetParent", "Actor_container_master", 0)
        // EntFire("CustomBrush8", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        // EntFire("CustomBrush9", "SetParent", "Actor_container_master", 0)
        // EntFire("CustomBrush9", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        // EntFire("CustomBrush10", "SetParent", "Actor_container_master", 0)
        // EntFire("CustomBrush10", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        // EntFire("CustomBrush11", "SetParent", "Actor_container_master", 0)
        // EntFire("CustomBrush11", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        // EntFire("CustomBrush12", "SetParent", "Actor_container_master", 0)
        // EntFire("CustomBrush12", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
    }

    if (MSOnPlayerJoin != false) {
        if (stoprenable==true) {
            printl("Player Joined (Reseting Viewcontrols)")
            EntFire("Sp_A1_Intro1Viewcontrol", "disable", "", 0.5, null)
            EntFire("Sp_A1_Intro1Viewcontrol", "enable", "", 0.6, null)
        }
    }

    if (MSLoop==true) {
        local p = Entities.FindByClassnameWithin(null, "player", Vector(-672, -1872, 51), 16)
        try {
            if (p.GetOrigin().z >= 45) {
                p.SetOrigin(Vector(-8674, 1773, 36))
                p.SetAngles(0, 0, 0)
            }
        } catch(exception) {}

        if (HasStartedSp_A1_Intro1 == false) {
            EntFireByHandle(Entities.FindByName(null, "cryo_fade_in_from_white"), "fade", "", 0, null, null)
        }

        if (Entities.FindByName(null, "Sp_A1_Intro1ViewcontrolTele")) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                p.SetOrigin(Vector(-8864, 1688, 36))
                p.SetVelocity(Vector(0, 0, 0))
            }
        }

        if (OnlyOnceSp_A1_Intro1 == true) {
            if (Entities.FindByName(null, "Sp_A1_Intro1ViewcontrolDone")) {
                local p = null
                while (p = Entities.FindByClassname(p, "player")) {
                    p.SetOrigin(Vector(-8709.201172, 1690.068359, 36))
                    p.SetAngles(-4.158184, 64.797371, 0)
                }
                EntFireByHandle(env_global01, "turnoff", "", 1, null, null)
                EntFireByHandle(env_global02, "turnoff", "", 1, null, null)
                EntFireByHandle(env_global03, "turnoff", "", 1, null, null)
                EntFireByHandle(env_global04, "turnoff", "", 1, null, null)
                stoprenable <- true
                //Entities.FindByName(null, "knockout-viewcontroller-prop").Destroy()
                //Entities.FindByName(null, "knockout-portalgun").Destroy()
                OnlyOnceSp_A1_Intro1 <- false
            }
        }

        // remove portalgun
        local ent = null
        while (ent = Entities.FindByClassname(ent, "weapon_portalgun")) {
            ent.Destroy()
        }
        local ent = null
        while (ent = Entities.FindByClassname(ent, "predicted_viewmodel")) {
            ent.Destroy()
        }

        try {
            local ClosestPlayerMain = Entities.FindByClassnameNearest("player", Entities.FindByName(null, "bottom_swivel_1").GetOrigin(), 10000)
            EntFireByHandle(Entities.FindByName(null, "bottom_swivel_1"), "SetTargetEntity", ClosestPlayerMain.GetName(), 0, null, null)
        } catch(exception) { }

        if (DisableJumpmsp == true) {
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                if (p.GetVelocity().z > 0) {
                    p.SetVelocity(Vector(p.GetVelocity().x, p.GetVelocity().y, -1))
                }
            }
        }

        if (HasSleptInContainer1==true && containerStick == false && SecondToLastTP == false) {
            // find everyone within 400 units of the container ( -8656.179688 1768.031250 104.196503 )
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-8656, 1768, 104), 400)) {
                //p.SetOrigin(Vector(-5700, 1931, 284))
                // -8622 1768 92
                // -2956 -163 -180
                p.SetOrigin(Vector(p.GetOrigin().x+ 2925, p.GetOrigin().y + 166, (p.GetOrigin().z + 190) - CurrentTeleportOffset))
            }
            //  -5559.827637 1843.053467 282.763519;
            if (bumpout==true) {
                // bump plant
                local p = null
                while (p = Entities.FindByClassnameWithin(p, "player", Vector(-5556.693848, 1838.821411, 280.240265), 35)) {
                    p.SetOrigin(Vector(-5556.693848, 1838.821411, 270))
                    printl("Bumped out")
                }
                // // bump table
                // local p = null
                // while (p = Entities.FindByClassnameWithin(p, "player", Vector(-5811.007813 1989.968750 282.031250), 35)) {
                //     p.SetOrigin(Vector(-5825.083008, 1979.134399, 270))
                //     printl("Bumped out")
                // }

                //-5811.007813 1989.968750 282.031250;
                bumpout <- false
            }
        }

        if (SecondToLastTP == true) {
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-8656, 1768, 104), 400)) {
                //p.SetOrigin(Vector(-5700, 1931, 284))
                // -8622 1768 92
                // -2956 -163 -180
                p.SetOrigin(Vector(-1649, 4376, 3167))
            }
        }

        if (containerStick == true) {
            if (CustomBrush1Cache == false) {
                CustomBrush1Cache <- CustomBrush1.GetOrigin()
            }
            currentCartPos <- CustomBrush1.GetOrigin()
            currentCartRot <- CustomBrush1.GetAngles()

            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(-8656, 1768, 104), 400)) {
                //p.SetOrigin(Vector(-5700, 1931, 284))
                // -8622 1768 92
                // -2956 -163 -180
                p.SetOrigin(Vector(currentCartPos.x, currentCartPos.y + 200, currentCartPos.z + 75))
            }

            // if someone is outside the container, move them back in
            local playersinside = []
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(currentCartPos.x, currentCartPos.y + 150, currentCartPos.z + 75), 300)) {
                playersinside.push(p)
            }

            // if someone is stuck in the closet wakka wakka
            // script p.SetOrigin(Vector(currentCartPos.x - 180, currentCartPos.y + 80, currentCartPos.z + 30))
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(currentCartPos.x - 180, currentCartPos.y + 80, currentCartPos.z + 30), 82)) {
                p.SetOrigin(Vector(currentCartPos.x, currentCartPos.y + 200, currentCartPos.z + 75))
            }
            local p = null
            while (p = Entities.FindByClassnameWithin(p, "player", Vector(currentCartPos.x - 172, currentCartPos.y + 80, currentCartPos.z + 30), 90)) {
                p.SetOrigin(Vector(currentCartPos.x, currentCartPos.y + 200, currentCartPos.z + 75))
            }

            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                local isplayerinindex = false
                foreach (player in playersinside) {
                    if (p == player) {
                        isplayerinindex = true
                    }
                }
                if (isplayerinindex == false) {
                    p.SetOrigin(Vector(currentCartPos.x, currentCartPos.y + 200, currentCartPos.z + 75))
                }
            }


            offsettick <- CustomBrush1.GetOrigin() - CustomBrush1Cache 
            cartrotoffset <- 100
            rotval <- 2
            cartrotoffset1 <- 100
            rotval1 <- 2
            //printl(offsettick)
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                EntFireByHandle(p, "addoutput", "MoveType 4", 0, null, null)

                planepitch <- currentCartRot.x * rotval 
                planeroll <- currentCartRot.z * rotval1
                p.SetOrigin(p.GetOrigin() + Vector(offsettick.x, offsettick.y, offsettick.z))

                printl(planepitch)
                printl(planeroll)
                playermiddle <- p.GetOrigin() - CustomBrush1.GetOrigin()
                playermiddle <- Vector(((playermiddle.x / -1)/cartrotoffset)*planepitch, ((playermiddle.y)/cartrotoffset1)*planeroll, playermiddle.z)
                p.SetOrigin(Vector(p.GetOrigin().x, p.GetOrigin().y, CustomBrush1.GetOrigin().z + ((playermiddle.x + playermiddle.y) + 72)))
                p.SetVelocity(Vector(p.GetVelocity().x/1.1, p.GetVelocity().y/1.1, 0))
                printl(playermiddle)
            }
            CustomBrush1Cache <- CustomBrush1.GetOrigin()
        }
        // Make our own changelevel trigger
        local p = null
        while(p = Entities.FindByClassnameWithin(p, "player", Vector(-685, 3112, 2400), 100)) {
            SendToConsole("changelevel sp_a1_intro2")
        }
    }
}