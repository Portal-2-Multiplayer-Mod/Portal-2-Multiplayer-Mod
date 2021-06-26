//********************************************************************************************
//MAPSPAWN.nut is called on newgame or transitions
//********************************************************************************************
CheatsOff <- 0
ReadyCheatsOff <- 0
PlayerJoined <- 0
PlayerID <- 0
GBIsMultiplayer <- 0
ReadyForCustomTargets <- 0
DedicatedServerOneTimeRun <- 1

DedicatedServer <- 0
function DedicatedServer() {
    if (DedicatedServerOneTimeRun==1) {
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
        DedicatedServerOneTimeRun <- 0
    }
            //Enable Music
        DoEntFire("!self", "invalue", "7", 0.0, null, Entities.FindByName(null,"@music_lobby_7"))
    local p = null;
    local MainPlayer = null
    while(MainPlayer = Entities.FindByName(MainPlayer, "blue")) {
        MainPlayer.SetOrigin(Vector(4096,4096,4096))
    }
}

function init(){
    jmessage <- Entities.CreateByClassname("env_instructor_hint")
    timer <- Entities.CreateByClassname("logic_timer");
    timer.__KeyValueFromString("targetname", "timer");
    EntFireByHandle(timer, "AddOutput", "RefireTime 0.1", 0, null, null);
    EntFireByHandle(timer, "AddOutput", "classname move_rope", 0, null, null);
    EntFireByHandle(timer, "AddOutput", "OnTimer worldspawn:RunScriptCode:SetColor():0:-1", 0, null, null);
    EntFireByHandle(timer, "Enable", "", 0.1, null, null);
    //Add Teams Name To Credits
    AddCoopCreditsName("Portal 2 Multiplayer Mod: Credits")
    AddCoopCreditsName("--------------------------")
    AddCoopCreditsName("Multiplayer Mod: Team")
    AddCoopCreditsName("--------------------------")
    AddCoopCreditsName("kyleraykbs | Scripting + Team Lead")
    AddCoopCreditsName("Bumpy | Scripting + Script Theory")
    AddCoopCreditsName("Vista | Reverse Engineering")
    AddCoopCreditsName("Wolfe Strider Shooter | Scripting")
    AddCoopCreditsName("Nanoman2525 | Mapping + Entity Help")
    AddCoopCreditsName("--------------------------")
    AddCoopCreditsName("Multiplayer Mod: Contributers")
    AddCoopCreditsName("--------------------------")
    AddCoopCreditsName("Darnias | Jumpstarter Code")
    AddCoopCreditsName("The Pineapple | Hamachi support")
    AddCoopCreditsName("SlingEXE | Optimisations")
    AddCoopCreditsName("Blub/Vecc | Code Cleanup + Commenting")
    AddCoopCreditsName("AngelPuzzle | Translations")
    AddCoopCreditsName("--------------------------")
    AddCoopCreditsName("Multiplayer Mod: Special Thanks")
    AddCoopCreditsName("--------------------------")
    AddCoopCreditsName("MicrosoftWindows")
    AddCoopCreditsName("Thanks to : sear : for ____blank")
    AddCoopCreditsName("Trico_Everfire")
    AddCoopCreditsName("hulkstar")
    AddCoopCreditsName("neck")
    AddCoopCreditsName("Sheuron")
    //AddCoopCreditsName("SuperSpeed")
    AddCoopCreditsName("goldengamer")
    AddCoopCreditsName("JDWMGB")
    AddCoopCreditsName("Portalboy")
    AddCoopCreditsName("--------------------------")
    AddCoopCreditsName("And my supportive group of friends!")
    AddCoopCreditsName("--------------------------")
    AddCoopCreditsName("")
    AddCoopCreditsName("Nick/KingKong")
    AddCoopCreditsName("Latte/Luna")
    AddCoopCreditsName("Craig is love Craig is life | WOLF BATTLER ")
    AddCoopCreditsName("Bunger from Bugsnax | Ayden")
    AddCoopCreditsName("Bananabread | KaiserInfinitus")
    AddCoopCreditsName("Jazzy/jasmine")
    AddCoopCreditsName("David/Mr. E")
    AddCoopCreditsName("")
    AddCoopCreditsName("--------------------------")
    AddCoopCreditsName("Thank you all so so much!!!")
    AddCoopCreditsName("--------------------------")
    AddCoopCreditsName("")
    AddCoopCreditsName("")
    AddCoopCreditsName("--------------------------")
    AddCoopCreditsName("Valve: Credits")
    AddCoopCreditsName("--------------------------")
    //Create An Entity That Sends A Client Command
    clientcommand <- Entities.CreateByClassname("point_clientcommand");
}

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
        loop()
        if (p.ValidateScriptScope()){
            local script_scope = p.GetScriptScope();
            if (!("Colored" in script_scope)){
                PlayerID <- p.GetRootMoveParent()
                PlayerID <- PlayerID.entindex()
                PlayerJoined <- 1
                local coj = "Player " + PlayerID + " Joined The Game"
                coj = coj.tostring()
                PID <- "player" + PlayerID
                PID <- PID.tostring()
                //Say Join Message
                SendToConsole("gameinstructor_enable 1")
                EntFireByHandle(clientcommand, "Command", "gameinstructor_enable 1", 0, p, p)
                jmessage.__KeyValueFromString("hint_icon_onscreen", "icon_caution");
                jmessage.__KeyValueFromString("targetname", "jmessagetarget");
                jmessage.__KeyValueFromString("hint_caption", coj);
                jmessage.__KeyValueFromString("hint_color", "255 200 0");
                jmessage.__KeyValueFromString("hint_timeout", "3");
                DoEntFire("jmessagetarget", "showhint", "", 0.0, null, p)
                printl("Player " + PlayerID + " Joined The Game")
                //Assign Playerdata
                if (ReadyForCustomTargets == 1) {
                    p.__KeyValueFromString("targetname", PID);
                //VeiwControl Teleport
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
                    ReadyForCustomTargets <- 1
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
    if (DedicatedServer==1) {
        DedicatedServer()
    }
//Run All Required Loops
    ArtTherapyLobby()
    if (DedicatedServer==1) {
        DedicatedServer()
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
            SendToConsole("sv_cheats 0")
            CheatsOff <- 1
        }
    }

//r_portal_fastpath 0 Fix
    local p = null;
    while (PlayerJoined==1) {
        while (p = Entities.FindByClassname(p, "player")) {
            EntFireByHandle(clientcommand, "Command", "r_portal_fastpath 0", 0, p, p)
            PlayerJoined <- 0
        }
    } 
}



function ArtTherapyLobby() {
//Art Therapy Left Chute Enabler
    local vectorEEL;
    vectorEEL = Vector(5727, 3336, -441);
    local EELent = null;
    while(EELent = Entities.FindByClassnameWithin(EELent, "player", vectorEEL, 12)) 
    {
        print("Enabled Left Chute")
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
        print("Teleported Player To Art Therapy")
        LCTent.SetOrigin(Vector(3194, -1069, 1676))
        LCTent.SetAngles(0, 0, 0)
    }
//Art Therapy Right Chute Enabler
    local vectorEER;
    vectorEER = Vector(5727, 3192, -441);
    local EERent = null;
    while(EERent = Entities.FindByClassnameWithin(EERent, "player", vectorEER, 12)) 
    {
        print("Enabled Left Chute")
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
        print("Teleported Player To Art Therapy")
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
        print("Disabled Right Chute")
            DoEntFire("!self", "enable", "", 0.0, null, LCatDis) 
            DoEntFire("!self", "trigger", "", 0.0, null, LCatDis)
        }
        local RCatDis = null;
        while(RCatDis = Entities.FindByName(RCatDis, "right-disable_cats")) {
            print("Disabled Right Chute")
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

Entities.First().ConnectOutput("OnUser1", "init");
DoEntFire("worldspawn", "FireUser1", "", 0.0, null, null);
command <- Entities.CreateByClassname("point_servercommand")
DoEntFire("!self", "Command", "sv_cheats 1", 0.0, null, command)
//mp_coop_lobby_3 Specific Code
if (GetMapName() == "mp_coop_lobby_3") {
    //Remove Entities
	DoEntFire("!self", "Command", "ent_remove_all func_portal_bumper", 0.0, null, command) // 165 entities removed
    DoEntFire("!self", "Command", "ent_remove dlc_room_fall_push_right", 0.0, null, command) // 1 entities removed
    DoEntFire("!self", "Command", "ent_remove dlc_room_fall_push_left", 0.0, null, command) // 1 entities removed
} else {
	printl("map not lobby_3")
}
DoEntFire("!self", "Kill", "", 0.0, null, command)
} else {
//Singleplayer Code
printl("Playing Map In Single Player [Multiplayer Mod Disabled]")
GlobalRunSingleplayer <- 1

SetColor <- function(){
    local p = null;
    while (p = Entities.FindByClassname(p, "player")){
        if (p.ValidateScriptScope()){
            local script_scope = p.GetScriptScope();
            if (GlobalRunSingleplayer==1){
                SendToConsole("script_execute singleplayer")
                GlobalRunSingleplayer <- 0
                return
            }
        }
    }
}
}