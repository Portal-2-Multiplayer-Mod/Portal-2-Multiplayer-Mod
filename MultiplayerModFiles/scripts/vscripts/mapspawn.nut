//********************************************************************************************
//MAPSPAWN.nut is called on newgame or transitions
//********************************************************************************************
CheatsOff <- 0
ReadyCheatsOff <- 0
PlayerJoined <- 0
PlayerID <- 0
GBIsMultiplayer <- 0
DedicatedServerOneTimeRun <- 1
TryGelocity <- 1
TryGelocity2 <- 1
TryGelocity3 <- 1
copp <- 0
WFPDisplayDisabled <- 0

//Is Dedicated Server
DedicatedServer <- 0

function init(){
    //Enable Fast Download
    SendToConsole("sv_downloadurl https://github.com/kyleraykbs/gilbert/raw/main/portal2")    
    SendToConsole("sv_allowdownload 1") 
    SendToConsole("sv_allowupload 1")
    //Create A On Screen Text Message Entity
    onscreendisplay <- Entities.CreateByClassname("game_text")
    onscreendisplay.__KeyValueFromString("targetname", "onscreendisplaympmod");
    onscreendisplay.__KeyValueFromString("message", "Waiting For Players...");
    onscreendisplay.__KeyValueFromString("holdtime", "0.2");
    onscreendisplay.__KeyValueFromString("fadeout", "0.2");
    onscreendisplay.__KeyValueFromString("fadein", "0.2");
    onscreendisplay.__KeyValueFromString("spawnflags", "1");
    onscreendisplay.__KeyValueFromString("color", "60 200 60");
    onscreendisplay.__KeyValueFromString("channel", "1");
    // onscreendisplay.__KeyValueFromString("x", "-1.1");
    // onscreendisplay.__KeyValueFromString("y", "-1.1");
    //Create A Join Message Entity
    jmessage <- Entities.CreateByClassname("env_instructor_hint")
    jmessage.__KeyValueFromString("targetname", "jmessagetarget");
    jmessage.__KeyValueFromString("hint_icon_onscreen", "icon_caution");
    jmessage.__KeyValueFromString("hint_color", "255 200 0");
    jmessage.__KeyValueFromString("hint_timeout", "3");
    //Create Entity To Run loop() Every 0.1 Seconds
    timer <- Entities.CreateByClassname("logic_timer");
    timer.__KeyValueFromString("targetname", "timer");
    EntFireByHandle(timer, "AddOutput", "RefireTime 0.1", 0, null, null);
    EntFireByHandle(timer, "AddOutput", "classname move_rope", 0, null, null);
    EntFireByHandle(timer, "AddOutput", "OnTimer worldspawn:RunScriptCode:loop():0:-1", 0, null, null);
    EntFireByHandle(timer, "Enable", "", 0.1, null, null);
    //Create An Entity That Sends A Client Command
    clientcommand <- Entities.CreateByClassname("point_clientcommand");
    //-------------------------
    //  Run Map Support code
    //-------------------------
    //Run Lobby Code
    if (GetMapName()=="mp_coop_lobby_3") {
        LobbyOneTimeRun()
    }

    //Run mp_coop_separation_1 Code
    if (GetMapName()=="mp_coop_separation_1") {
            mp_coop_separation_1FIX()
    }

    //Run mp_coop_paint_conversion Code
    if (GetMapName()=="mp_coop_paint_conversion") {
        mp_coop_paint_conversionFIX()
    }

    //Run Gelocity Code 
    if (TryGelocity==1) {
        try {
            if (GetMapName().slice(28,50)=="mp_coop_gelocity_1_v02") {
                Gelocity()
            }
        } catch(exception) {
            print("")
            TryGelocity<-0
        }
    }
    //Run Gelocity 3 Code
        if (TryGelocity3==1) {
        try {
            if (GetMapName().slice(28,50)=="mp_coop_gelocity_3_v02") {
                Gelocity3()
            }
        } catch(exception) {
            print("")
            TryGelocity3<-0
        }
    }
    //Run Gelocity 2 Code
        if (TryGelocity2==1) {
        try {
            if (GetMapName().slice(28,50)=="mp_coop_gelocity_2_v01") {
                Gelocity2()
            }
        } catch(exception) {
            print("")
            TryGelocity2<-0
        }
    }
}

//Make Sure Game Is Running In Multiplayer
try {
    if ( ::IsMultiplayer() ){
        GBIsMultiplayer <- 1
    }
} catch(exception) {
    GBIsMultiplayer <- 0
}

if (GBIsMultiplayer==1) {
//Multiplayer Code

SetColor <- function(){
    local p = null;
    while (p = Entities.FindByClassname(p, "player")){
        if (p.ValidateScriptScope()){
            local script_scope = p.GetScriptScope();
            if (!("Colored" in script_scope)){
                //GetPlayersIndex And Store It
                PlayerID <- p.GetRootMoveParent()
                PlayerID <- PlayerID.entindex()
                //Enable Cvars On Client
                SendToConsole("gameinstructor_enable 1")
                EntFireByHandle(clientcommand, "Command", "bind tab +score", 0, p, p)
                EntFireByHandle(clientcommand, "Command", "stopvideos", 0, p, p)
                EntFireByHandle(clientcommand, "Command", "r_portal_fastpath 0", 0, p, p)
                EntFireByHandle(clientcommand, "Command", "gameinstructor_enable 1", 0, p, p)
                EntFireByHandle(clientcommand, "Command", "mat_motion_blur_enabled 1", 0, p, p)
                //Say Join Message
                local coj = "Player " + PlayerID + " Joined The Game"
                coj = coj.tostring()
                jmessage.__KeyValueFromString("hint_caption", coj);

                DoEntFire("jmessagetarget", "showhint", "", 0.0, null, p)
                printl("Player " + PlayerID + " Joined The Game")
                //Assign Player TargetName
                if (PlayerID >= 3) {
                p.__KeyValueFromString("targetname", "player" + PlayerID);
                }
                //Set Random Color If Over 16
                if (PlayerID != 1) {
                    R <- RandomInt(0, 255), G <- RandomInt(0, 255), B <- RandomInt(0, 255);
                    ReadyCheatsOff <- 1
                }
                //Set Preset Colors Up To 16
                if (PlayerID == 1) {
                    R <- 255, G <- 255,  B <- 255;
                }
                if (PlayerID == 2) {
                    R <- 180, G <- 255,  B <- 180;
                }
                if (PlayerID == 3) {
                    R <- 120, G <- 140,  B <- 255;
                }
                if (PlayerID == 4) {
                    R <- 255, G <- 170,  B <- 120;
                }
                if (PlayerID == 5) {
                    R <- 255, G <- 100,  B <- 100;
                }
                if (PlayerID == 6) {
                    R <- 255, G <- 180,  B <- 255;
                }
                if (PlayerID == 7) {
                    R <- 255, G <- 255,  B <- 180;
                }
                if (PlayerID == 8) {
                    R <- 0, G <- 255,  B <- 240;
                }
                if (PlayerID == 9) {
                    R <- 75, G <- 75,  B <- 75;
                }
                if (PlayerID == 10) {
                    R <- 120, G <- 155,  B <- 25;
                }
                if (PlayerID == 11) {
                    R <- 0, G <- 80,  B <- 100;
                }
                if (PlayerID == 12) {
                    R <- 100, G <- 80,  B <- 0;
                }
                if (PlayerID == 13) {
                    R <- 0, G <- 0,  B <- 100;
                }
                if (PlayerID == 14) {
                    R <- 80, G <- 0,  B <- 0;
                }
                if (PlayerID == 15) {
                    R <- 0, G <- 75,  B <- 0;
                }
                if (PlayerID == 16) {
                    R <- 0, G <- 75,  B <- 75;
                }
                script_scope.Colored <- true;
                EntFireByHandle(p, "Color", (R+" "+G+" "+B), 0, null, null);
                return
            }
        }
    }
}


function loop() {
//Set All Player Colors
    SetColor()
    //Cache Old Player Pos
    try {
    if (copp==0) {
        OldPlayerPos <- Entities.FindByName(null, "blue").GetOrigin()
        copp <- 1
    }
    } catch(exception) {
        print("")
    }
//Run General Code
    General()
//Display waiting for players & run nessacary code after spawn...
    if (WFPDisplayDisabled==0) {
        //General Map Code
        try {
        //See If Player In Spawn Zone
        if (Entities.FindByNameWithin(null, "blue", OldPlayerPos, 20)) {
                DoEntFire("onscreendisplaympmod", "display", "", 0.0, null, null)
        } else {
            WFPDisplayDisabled <- 1
            GeneralOneTime()
        }
        } catch(exception) {
            print("")
        }
    }
//Run All Required Loops
    if (GetMapName()=="mp_coop_lobby_3") {
        ArtTherapyLobby()
    }
    //Run Credits Code
    if (GetMapName()=="mp_coop_credits") {
        CreditsLoop()
    }
    //=========================
    //Run Dedicated Server Code
    if (DedicatedServer==1) {
        DedicatedServerFunc()
    }
//Disable Collision
    //local j = "solid ";
	local k = "CollisionGroup ";
	//EntFire("player", "addoutput", j+4);
	EntFire("player", "addoutput", k+2);
    
//sv_cheats 0
    //check if ready to turn cheats off
    if (ReadyCheatsOff==1) {
        if (CheatsOff==0) {
            if (GetMapName()=="mp_coop_lobby_3") {
            SendToConsole("sv_cheats 0")
            }
            CheatsOff <- 1
        }
    }
//TPG
    local PLent = null;
    while(PLent = Entities.FindByClassnameWithin(PLent, "player", Vector(2367, -8126, -54), 30)) {
        local APLent = null;
        while(APLent = Entities.FindByClassname(APLent, "player")) {
            APLent.SetOrigin(Vector(2495, -7451, 410))
        }
    }
}

//Lobby setup code
function LobbyOneTimeRun() {
//Remove Entities
    //Fix Edicts Error
    local ent = null;
    while(ent = Entities.FindByClassname(ent, "func_portal_bumper"))
    {
        ent.Destroy() // 165 entities removed
    }
    
//Fix Art Therapy Tube Glitches
    Entities.FindByName(null,"dlc_room_fall_push_right").Destroy()
    Entities.FindByName(null,"dlc_room_fall_push_left").Destroy()

//Fix Track 5
    //Entry Door Fix
    Entities.FindByName(null,"track5-door_paint-trigger_hurt_door").Destroy()
    Entities.FindByName(null,"track5-door_paint-collide_door").Destroy()
    //Light Fix
    Entities.FindByName(null,"@light_shadowed_paintroom").Destroy()
    //Door Remover
        //Orange Exit Door
    local ent = null;
    while(ent = Entities.FindByName(ent, "track5-orangeiris_door_elevator_pit"))
    {
        ent.Destroy()
    }
    Entities.FindByName(null,"track5-orangeescape_elevator_clip").Destroy()
        //Blue Exit Door
    local ent = null;
    while(ent = Entities.FindByName(ent, "track5-iris_door_elevator_pit"))
    {
        ent.Destroy()
    }
    Entities.FindByName(null,"track5-escape_elevator_clip").Destroy()

}

//======================================
//======================================
//           MAP SUPPORT CODE
//======================================
//======================================

//==================================
//    General Fixes For All Maps
//==================================
function General() {
//Remove Dropper Bottom
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        local ent = null;
        while (ent = Entities.FindByClassnameWithin(ent, "prop_dynamic", OldPlayerPos, 500)) {
            if (ent.GetModelName()=="models/props_underground/underground_boxdropper.mdl") {
                EntFireByHandle(ent, "SetAnimation", "open_idle", 0.0, null, null)
            }
            if (ent.GetModelName()=="models/props_backstage/item_dropper.mdl") {
                EntFireByHandle(ent, "SetAnimation", "item_dropper_idle", 0.0, null, null)
            }
        }
    }
}

//General One Time Run
function GeneralOneTime() {
    local DoorEntities = [
        "airlock_1-door1-airlock_entry_door_close_rl",
        "airlock_2-door1-airlock_entry_door_close_rl",
        "last_airlock-door1-airlock_entry_door_close_rl",
        "airlock_1-door1-door_close",
        "airlock1-door1-door_close",
        "camera_door_3-relay_doorclose",
        "entry_airlock-door1-airlock_entry_door_close_rl",
        "door1-airlock_entry_door_close_rl",
        "orange_door_1-ramp_close_start",
        "blue_door_1-ramp_close_start",
        "orange_door_1-airlock_player_block",
        "blue_door_1-airlock_player_block",
    ]
    foreach (DoorType in DoorEntities) {
        try {
        Entities.FindByName(null, DoorType).Destroy()
        } catch(exception) {
            printl("")
        }
    }
    //Map Support
    if (GetMapName()=="mp_coop_separation_1") {
        mp_coop_separation_1FIXONETIME()
    }
}

//==================================
//        Art Therapy Lobby
//==================================
function ArtTherapyLobby() {
//Art Therapy Left Chute Enabler
    local vectorEEL;
    vectorEEL = Vector(5727, 3336, -441);
    local EELent = null;
    while(EELent = Entities.FindByClassnameWithin(EELent, "player", vectorEEL, 12)) 
    {
        printl("Enabled Left Chute")
        local LCatEn = null;
        while(LCatEn = Entities.FindByName(LCatEn, "left-enable_cats")) {
            DoEntFire("!self", "enable", "", 0.0, null, LCatEn) 
            DoEntFire("!self", "trigger", "", 0.0, null, LCatEn) 
        }
    } 
//Art Therapy Left Chute Teleporter
    local vectorLCT;
    vectorLCT = Vector(5729, 3336, 1005);
    local LCTent = null;
    while(LCTent = Entities.FindByClassnameWithin(LCTent, "player", vectorLCT, 30)) {
        printl("Teleported Player To Art Therapy")
        LCTent.SetOrigin(Vector(3194, -1069, 1676))
        LCTent.SetAngles(0, 0, 0)
    }
//Art Therapy Right Chute Enabler
    local vectorEER;
    vectorEER = Vector(5727, 3192, -441);
    local EERent = null;
    while(EERent = Entities.FindByClassnameWithin(EERent, "player", vectorEER, 12)) 
    {
        printl("Enabled Left Chute")
        local RCatEn = null;
        while(RCatEn = Entities.FindByName(RCatEn, "right-enable_cats")) {
            DoEntFire("!self", "enable", "", 0.0, null, RCatEn) 
            DoEntFire("!self", "trigger", "", 0.0, null, RCatEn) 
        }
    } 
//Art Therapy Right Chute Teleporter
    local vectorRCT;
    vectorRCT = Vector(5727, 3180, 1005);
    local RCTent = null;
    while(RCTent = Entities.FindByClassnameWithin(RCTent, "player", vectorRCT, 30)) {
        printl("Teleported Player To Art Therapy")
        RCTent.SetOrigin(Vector(3191, -1228, 1682))
        RCTent.SetAngles(0, 0, 0)
    }
//Disable Art Therapy Chutes
    local vectorE;
    vectorE = Vector(3201, -1152, 1272);
    local Aent = null;
    while(Aent = Entities.FindByClassnameWithin(Aent, "player", vectorE, 150)) 
    {
        local LCatDis = null;
        while(LCatDis = Entities.FindByName(LCatDis, "left-disable_cats")) {
        printl("Disabled Right Chute")
            DoEntFire("!self", "enable", "", 0.0, null, LCatDis) 
            DoEntFire("!self", "trigger", "", 0.0, null, LCatDis)
        }
        local RCatDis = null;
        while(RCatDis = Entities.FindByName(RCatDis, "right-disable_cats")) {
            printl("Disabled Right Chute")
            DoEntFire("!self", "enable", "", 0.0, null, RCatDis) 
            DoEntFire("!self", "trigger", "", 0.0, null, RCatDis)
        }
    }   
//Teleport Exiting Player Out Of Art Therapy
    local vectorEx;
    vectorEx = Vector(3584, -1669, 466);
    local AEent = null;
    while(AEent = Entities.FindByClassnameWithin(AEent, "player", vectorEx, 30)) 
    {
        AEent.SetOrigin(Vector(3919, 3352, 158))
    } 
}

//==================================
//     mp_coop_separation_1
//==================================
function mp_coop_separation_1FIX() {
    EntFireByHandle(Entities.FindByName(null, "left_1st_room_spawn-initial_blue_spawn"), "SetAsActiveSpawn", "", 0, null, null)
    EntFireByHandle(Entities.FindByName(null, "right_1st_room_spawn-initial_orange_spawn"), "SetAsActiveSpawn", "", 0, null, null)
    Entities.FindByName(null, "split_counter").Destroy()
}
function mp_coop_separation_1FIXONETIME() {
    EntFireByHandle(Entities.FindByName(null, "@glados"), "runscriptcode", "GladosCoopMapStart()", 0, null, null)
    EntFireByHandle(Entities.FindByName(null, "@glados"), "runscriptcode", "GladosCoopElevatorEntrance(1)", 0, null, null)
    EntFireByHandle(Entities.FindByName(null, "@glados"), "runscriptcode", "GladosCoopElevatorEntrance(2)", 0, null, null)

    local ent = null;
    while(ent = Entities.FindByName(ent, "split_exit_arms")) {
        EntFireByHandle(ent, "setanimation", "90up", 0, null, null)
    }
    local ent = null;
    while(ent = Entities.FindByName(ent, "split_entrance_arms")) {
        EntFireByHandle(ent, "setanimation", "90down", 0, null, null)
    }

    local ent = null;
    while (ent = Entities.FindByClassnameWithin(ent, "func_areaportalwindow", OldPlayerPos, 5000)) {
        EntFireByHandle(ent, "SetFadeEndDistance", "10000", 0, null, null)
    }

    local loopTimes = 0;
    while (loopTimes <= 0) {
        Entities.FindByName(null, "split_exit_fake_collision").Destroy()
    local loopTimes = loopTimes + 1
    }
}

//==================================
//     mp_coop_paint_conversion
//==================================
function mp_coop_paint_conversionFIX() {
    Entities.FindByName(null,"disassembler_1_door_blocker").Destroy()
    Entities.FindByName(null,"disassembler_2_door_blocker").Destroy()

    Entities.FindByName(null,"disassembler_1_door_2").Destroy()
    Entities.FindByName(null,"disassembler_1_door_1").Destroy()

    Entities.FindByName(null,"disassembler_2_door_2").Destroy()
    Entities.FindByName(null,"disassembler_2_door_1").Destroy()
}

//==================================
//         Gelocity 1 Code
//==================================
function Gelocity() {
    DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null,"door2_player2"))
    DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null,"door2_player1"))
    DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null,"start_clip_1"))
    DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null,"start_clip_2"))
    local ent = null;
    //Remove Entities
    while(ent = Entities.FindByClassname(ent, "func_portal_bumper"))
    {
        ent.Destroy() // 20 entities removed
    }
    while(ent = Entities.FindByClassname(ent, "beam_spotlight"))
    {
        ent.Destroy() // 85 entities removed
    }
    printl("Portal 2 Multiplayer Mod: Removed 20 Portal Bumpers")
}

//==================================
//         Gelocity 2 Code
//==================================
function Gelocity2() {
    local ent = null;
    //Remove Entities
    while(ent = Entities.FindByClassname(ent, "func_portal_bumper"))
    {
        ent.Destroy() // 20 entities removed
    }
    while(ent = Entities.FindByClassname(ent, "beam_spotlight"))
    {
        ent.Destroy() // 85 entities removed
    }
    while(ent = Entities.FindByClassname(ent, "env_glow"))
    {
        ent.Destroy() // 85 entities removed
    }
    while(ent = Entities.FindByClassname(ent, "light_spot"))
    {
        ent.Destroy() // 85 entities removed
    }
    while(ent = Entities.FindByClassname(ent, "keyframe_rope"))
    {
        ent.Destroy() // 85 entities removed
    }
    while(ent = Entities.FindByClassname(ent, "move_rope"))
    {
        ent.Destroy() // 85 entities removed
    }
    while(ent = Entities.FindByClassname(ent, "info_overlay"))
    {
        ent.Destroy() // 85 entities removed
    }
    printl("Portal 2 Multiplayer Mod: Removed 20 Portal Bumpers")
}
//==================================
//         Gelocity 3 Code
//==================================
function Gelocity3() {
    DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null,"door_start_2_2"))
    DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null,"door_start_2_1"))
    DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null,"door_start_1_2"))
    DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null,"door_start_1_1"))
    DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null,"door_start"))
    DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null,"red_dropper-door_eixt"))
    DoEntFire("!self", "kill", "", 0.0, null, Entities.FindByName(null,"blue_dropper-item_door"))
    local ent = null;
        //Remove Entities
    while(ent = Entities.FindByClassname(ent, "func_portal_bumper"))
    {
        ent.Destroy() // 20 entities removed
    }
    while(ent = Entities.FindByClassname(ent, "beam_spotlight"))
    {
        ent.Destroy() // 85 entities removed
    }
    printl("Portal 2 Multiplayer Mod: Removed 20 Portal Bumpers")
}

//==================================
//      Dedicated Server Code
//==================================
function DedicatedServerFunc() {
    if (DedicatedServerOneTimeRun==1) {
        if (GetMapName() == "mp_coop_lobby_3") {
            Entities.FindByName(null,"brush_spawn_blocker_red").Destroy()
            Entities.FindByName(null,"brush_spawn_blocker_blue").Destroy()
            //Enable Team Building Course
            DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null,"relay_reveal_teambuilding"))
            DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null,"relay_reveal_teambuilding"))
            //Enable TBeam Course
            DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null,"relay_reveal_tbeam"))
            DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null,"relay_reveal_tbeam"))
            //Enable Paint Course
            DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null,"relay_reveal_paint"))
            DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null,"relay_reveal_paint"))
            //Enable Fling Course
            DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null,"relay_reveal_fling"))
            DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null,"relay_reveal_fling"))
            //Enable Extra Course
            DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null,"relay_reveal_extra"))
            DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null,"relay_reveal_extra"))
            //Enable All Finished Course
            DoEntFire("!self", "enable", "", 0.0, null, Entities.FindByName(null,"relay_reveal_all_finished"))
            DoEntFire("!self", "trigger", "", 0.0, null, Entities.FindByName(null,"relay_reveal_all_finished"))
            //Enable Music
            DoEntFire("!self", "invalue", "7", 0.0, null, Entities.FindByName(null,"@music_lobby_7"))
        }
        DedicatedServerOneTimeRun <- 0
    }

    local p = null;
    while (p = Entities.FindByClassname(p, "player")) {
        if (p.entindex()==1) {
            SendToConsole("exec DedicatedServerCommands")
            //Set Size To 0
            EntFireByHandle(p, "AddOutput", "ModelScale 0", 0, null, null);
        }
    }
}




//==================================
//             CREDITS
//==================================

//Remove Selected Pods
function CreditsRemovePod() {
    local ent = null;
    while (ent = Entities.FindByNameNearest("chamber*", Vector(-64, 217, 72), 100)) {
        ent.Destroy()
    }
    local ent2 = null;
    while (ent2 = Entities.FindByNameNearest("bubbles*", Vector(-64, 217, 72), 100)) {
        ent2.Destroy()
    }
}

//Fix Void Camera Glitch
function FixCreditsCameras() {
    //Disable Useless Cameras
    EntFireByHandle(Entities.FindByName(null, "camera_SP"), "disable", "", 0, null, null)
    EntFireByHandle(Entities.FindByName(null, "camera_O"), "disable", "", 0, null, null)
    //Reload Main Camera With New Params
    Entities.FindByName(null, "camera").__KeyValueFromString("target_team", "-1");
    EntFireByHandle(Entities.FindByName(null, "camera"), "disable", "", 0, null, null)
    EntFireByHandle(Entities.FindByName(null, "camera"), "enable", "", 0, null, null)
}

//Replace Females With Pbodys
function CreditsSetModelPB(ent) {
    FixCreditsCameras()
    //Count How Many Times A Credit Comes On Screen So We Can Change To Humans
    MPMCredits <- MPMCredits + 1
    //Preset Animation
    local RandomAnimation = RandomInt(0, CRAnimationTypesPB)
    //Remove Pod If Needed
    HasRemovedPod <- 0
    foreach (anim in NOTubeAnimsPB) {
        if (AnimationsPB[RandomAnimation] == anim && HasRemovedPod==0) {
            HasRemovedPod <- 1
            CreditsRemovePod()
        }
    }
    //Set Model
    ent.SetModel("models/player/eggbot/eggbot.mdl")
    //Set Color
    EntFireByHandle(ent, "Color", (RandomInt(0, 255)+" "+RandomInt(0, 255)+" "+RandomInt(0, 255)), 0, null, null);
    //Set Position
    ent.SetOrigin(Vector(0, 0, 7.5))
    //Set Animation
    EntFireByHandle(ent, "setanimation", AnimationsPB[RandomAnimation], 0, null, null)
}

//Replace Males With Atlases
function CreditsSetModelAL(ent) {
    FixCreditsCameras()
    //Count How Many Times A Credit Comes On Screen So We Can Change To Humans
    MPMCredits <- MPMCredits + 1
    //Preset Animation
    local RandomAnimation = RandomInt(0, CRAnimationTypesAL)
    //Set Model
    ent.SetModel("models/player/ballbot/ballbot.mdl")
    //Set Color
    EntFireByHandle(ent, "Color", (RandomInt(0, 255)+" "+RandomInt(0, 255)+" "+RandomInt(0, 255)), 0, null, null);
    //Set Position
    ent.SetOrigin(Vector(-10, 0, 25.5))
    //Set Animation
    EntFireByHandle(ent, "setanimation", AnimationsAL[RandomAnimation], 0, null, null)
    //Remove Pod If Needed
    HasRemovedPod <- 0
    foreach (anim in NOTubeAnimsAL) {
        if (AnimationsAL[RandomAnimation] == anim && HasRemovedPod==0) {
            HasRemovedPod <- 1
            CreditsRemovePod()
            ent.SetOrigin(Vector(0, 0, 7.5))
        }
    }
}

function CreditsLoop() {
//If 51 Credits Haven't Passed Change Humans To Robots
if (MPMCredits<=MPModCreditNumber) {
    //Change Males To Atlases
    local ent = null;
    while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_male.mdl")) {
        CreditsSetModelAL(ent)
    }
    local ent = null;
    while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_male01.mdl")) {
        CreditsSetModelAL(ent)
    }
    local ent = null;
    while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_male_02.mdl")) {
        CreditsSetModelAL(ent)
    }
    //Change Females To Pbodys
    local ent = null;
    while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_female_01.mdl")) {
        CreditsSetModelPB(ent)
    }
    local ent = null;
    while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_female_02.mdl")) {
        CreditsSetModelPB(ent)
    }
    local ent = null;
    while (ent = Entities.FindByModel(ent, "models/props_underground/stasis_chamber_female_03.mdl")) {
        CreditsSetModelPB(ent)
    }
    }
}

//Credits One Time Run Code
if (GetMapName() == "mp_coop_credits") {

    //Set Credits Animations
    //Pbody Animations
    AnimationsPB <- ["taunt_laugh", "taunt_teamhug_idle", "noGun_crouch_idle", "taunt_face_palm", "taunt_selfspin", "taunt_pretzelwave", "noGun_airwalk", "noGun_airwalk", "portalgun_drowning", "layer_taunt_noGun_small_wave", "taunt_highFive_idle"]
    //Atlas Animations
    AnimationsAL <- ["taunt_laugh", "taunt_laugh", "taunt_teamhug_initiate", "taunt_teamhug_noShow", "ballbot_taunt_rps_shake", "taunt_basketball2", "taunt_headspin", "taunt_facepalm", "taunt_shrug", "layer_taunt_trickfire_handstand", "portalgun_jump_spring", "portalgun_thrash_fall", "noGun_crouch_idle", "noGun_airwalk", "noGun_airwalk"]
    //Pbody Animations Out Of Tube
    NOTubeAnimsPB <- ["taunt_laugh", "taunt_teamhug_idle", "noGun_crouch_idle", "taunt_face_palm", "taunt_selfspin", "taunt_pretzelwave", "layer_taunt_noGun_small_wave", "taunt_highFive_idle"]
    //Atlas Animations Out Of Tube
    NOTubeAnimsAL <- ["taunt_laugh", "taunt_laugh", "taunt_teamhug_initiate", "taunt_teamhug_noShow", "ballbot_taunt_rps_shake", "taunt_basketball2", "taunt_headspin", "taunt_facepalm", "taunt_shrug", "layer_taunt_trickfire_handstand", "noGun_crouch_idle"]
    //Credit Run counter
    MPMCredits <- 0
    //Set The Amount Of PBody Animations
    CRAnimationTypesPB <- -1
    foreach (value in AnimationsPB) {
        CRAnimationTypesPB <- CRAnimationTypesPB + 1
    }
    //Set The Amount Of Atlas Animations
    CRAnimationTypesAL <- -1
    foreach (value in AnimationsAL) {
        CRAnimationTypesAL <- CRAnimationTypesAL + 1
    }
    //Add Teams Name To Credits
    MPMCoopCreditNames <- [
    "",
    "",
    "",
    "",
    "Portal 2 Multiplayer Mod: Credits", 
    "",
    "--------------------------",
    "Multiplayer Mod: Team",
    "--------------------------",
    "kyleraykbs | Scripting + Team Lead",
    "Bumpy | Scripting + Script Theory",
    "Vista | Reverse Engineering",
    "Wolfe Strider Shooter | Scripting",
    "Nanoman2525 | Mapping + Entity Help",
    "--------------------------",
    "Multiplayer Mod: Contributers",
    "--------------------------",
    "Darnias | Jumpstarter Code",
    "The Pineapple | Hamachi support",
    "SlingEXE | Optimisations",
    "actu | Remote File Downloads",
    "Blub/Vecc | Code Cleanup + Commenting",
    "AngelPuzzle | Translations",
    "--------------------------",
    "Multiplayer Mod: Beta Testers",
    "--------------------------",
    "sear",
    "Trico_Everfire",
    "Brawler",
    "iambread",
    "hulkstar",
    "neck",
    "soulfur",
    "brawler",
    "Sheuron",
    "NintenDude",
    "SuperSpeed",
    "portalboy",
    "charity",
    "Souper Marilogi",
    "fluffys",
    "JDWMGB",
    "ALIEN GOD",
    "mono",
    "Funky Kong",
    "MicrosoftWindows",
    "dactam",
    "wol",
    "--------------------------",
    "And my supportive group of friends!",
    "--------------------------",
    "Nick/KingKong",
    "Latte/Luna",
    "Craig is love Craig is life | WOLF BATTLER ",
    "Bunger from Bugsnax | Ayden",
    "Bananabread | KaiserInfinitus",
    "Jazzy/jasmine",
    "David/Mr. E"
    "--------------------------",
    "Thank you all so so much!!!",
    "--------------------------"
    "",
    "",
    "--------------------------",
    "Valve: Credits",
    "--------------------------",
    ];
    //Set The Amount Of Credits
    MPModCreditNumber <- -1
    foreach (value in MPMCoopCreditNames) {
        MPModCreditNumber <- MPModCreditNumber + 1
    }
    //Mount List Of Credits To Credits
    foreach (Name in MPMCoopCreditNames) {
        AddCoopCreditsName(Name)
    }
}

//Run init Code
Entities.First().ConnectOutput("OnUser1", "init");
DoEntFire("worldspawn", "FireUser1", "", 0.0, null, null);

//Singleplayer Code
} else {
GlobalRunSingleplayer <- 1

SetColor <- function(){
    local p = null;
    while (p = Entities.FindByClassname(p, "player")){
        if (p.ValidateScriptScope()){
            local script_scope = p.GetScriptScope();
            if (GlobalRunSingleplayer==1){
                SendToConsole("script_execute singleplayer")
                printl("Playing Map In Single Player [Multiplayer Mod Disabled]")
                GlobalRunSingleplayer <- 0
                return
            }
        }
    }
}
}