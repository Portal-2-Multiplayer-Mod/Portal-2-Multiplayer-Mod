//********************************************************************************************
//MAPSPAWN.nut is called on newgame or transitions
//********************************************************************************************


CurrentPlayerCount <- 0
GBIsMultiplayer <- 0
try {
    if ( ::IsMultiplayer() ){
        GBIsMultiplayer <- 1
    }
} catch(exception) {
    GBIsMultiplayer <- 0
}


if (GBIsMultiplayer==1) {
printl("==== calling mapspawn.nut")
function init(){
    timer <- Entities.CreateByClassname("logic_timer");
    timer.__KeyValueFromString("targetname", "timer");
    EntFireByHandle(timer, "AddOutput", "RefireTime 0.1", 0, null, null);
    EntFireByHandle(timer, "AddOutput", "classname move_rope", 0, null, null);
    EntFireByHandle(timer, "AddOutput", "OnTimer worldspawn:RunScriptCode:SetColor():0:-1", 0, null, null);
    EntFireByHandle(timer, "Enable", "", 0.1, null, null);
}

SetColor <- function(){
    local p = null;
    while (p = Entities.FindByClassname(p, "player")){
        loop()
        if (p.ValidateScriptScope()){
            local script_scope = p.GetScriptScope();
            if (!("Colored" in script_scope)){
                CurrentPlayerCount <- CurrentPlayerCount + 1
                local coj = "say Player " + CurrentPlayerCount + " Joined The Game"
                coj = coj.tostring()
                printl("Player " + CurrentPlayerCount + " Joined The Game")
                SendToConsole(coj)
                if (CurrentPlayerCount == 16) {
                    R <- 0, G <- 75,  B <- 0;
                } else {
                        R <- RandomInt(0, 255), G <- RandomInt(0, 255), B <- RandomInt(0, 255);
                }
                if (CurrentPlayerCount == 1) {
                    R <- 255, G <- 255,  B <- 255;
                }
                if (CurrentPlayerCount == 2) {
                    R <- 255, G <- 255,  B <- 255;
                }
                if (CurrentPlayerCount == 3) {
                    R <- 180, G <- 255,  B <- 180;
                }
                if (CurrentPlayerCount == 4) {
                    R <- 120, G <- 140,  B <- 255;
                }
                if (CurrentPlayerCount == 5) {
                    R <- 255, G <- 170,  B <- 120;
                }
                if (CurrentPlayerCount == 6) {
                    R <- 255, G <- 100,  B <- 100;
                }
                if (CurrentPlayerCount == 7) {
                    R <- 255, G <- 180,  B <- 255;
                }
                if (CurrentPlayerCount == 8) {
                    R <- 255, G <- 255,  B <- 180;
                }
                if (CurrentPlayerCount == 9) {
                    R <- 0, G <- 255,  B <- 240;
                }
                if (CurrentPlayerCount == 10) {
                    R <- 75, G <- 75,  B <- 75;
                }
                if (CurrentPlayerCount == 11) {
                    R <- 120, G <- 155,  B <- 25;
                }
                if (CurrentPlayerCount == 12) {
                    R <- 0, G <- 80,  B <- 100;
                }
                if (CurrentPlayerCount == 13) {
                    R <- 100, G <- 80,  B <- 0;
                }
                if (CurrentPlayerCount == 14) {
                    R <- 0, G <- 0,  B <- 100;
                }
                if (CurrentPlayerCount == 15) {
                    R <- 80, G <- 0,  B <- 0;
                }
                script_scope.Colored <- true;
                EntFireByHandle(p, "Color", (R+" "+G+" "+B), 0, null, null);
                return
            }
        }
    }
}

function loop() {
	local entity = null;
	SendToConsole("sv_cheats 1") 
	SendToConsole("exec collisionfix")
}

Entities.First().ConnectOutput("OnUser1", "init");
DoEntFire("worldspawn", "FireUser1", "", 0.0, null, null);
command <- Entities.CreateByClassname("point_servercommand")
if (GetMapName() == "mp_coop_lobby_3") {
	DoEntFire("!self", "Command", "sv_cheats 1", 0.0, null, command)
//Delete 38 Entitys
    DoEntFire("!self", "Command", "ent_remove_all track6-blue-cradle_arm", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all track4-blue-cradle_arm", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all track3-blue-cradle_arm", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all track2-blue-cradle_arm", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all track1-blue-cradle_arm", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all track6-orange-cradle_arm", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all track4-orange-cradle_arm", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all track3-orange-cradle_arm", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all track2-orange-cradle_arm", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all track1-orange-cradle_arm", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all track6-blue-armH", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all src_cover_panel", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all src_cover_panel2", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover3", 0.0, null, command) //1	
    DoEntFire("!self", "Command", "ent_remove_all screen_cover4", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover5", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover6", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover7", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover8", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover9", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover10", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover11", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover12", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover13", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover14", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover15", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover16", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover17", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover18", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover19", 0.0, null, command) //1
    DoEntFire("!self", "Command", "ent_remove_all screen_cover20", 0.0, null, command) //1
	DoEntFire("!self", "Command", "ent_remove_all env_sprite", 0.0, null, command) //31
	DoEntFire("!self", "Command", "ent_remove_all env_spark", 0.0, null, command) //3
	DoEntFire("!self", "Command", "ent_remove_all func_portal_bumper", 0.0, null, command) //3
//	DoEntFire("!self", "Command", "sv_cheats 0", 0.0, null, command)
} else {
	printl("map not lobby_3")
}
DoEntFire("!self", "Kill", "", 0.0, null, command)
} else {
    printl("Playing Map In Single Player [Multiplayer Mod Disabled]")
}