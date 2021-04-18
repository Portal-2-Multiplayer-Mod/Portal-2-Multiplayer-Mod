//********************************************************************************************
//MAPSPAWN.nut is called on newgame or transitions
//********************************************************************************************
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
        collisionfix()
        if (p.ValidateScriptScope()){
            local script_scope = p.GetScriptScope();
            if (!("Colored" in script_scope)){
                script_scope.Colored <- true;
                local R = RandomInt(0, 255), G = RandomInt(0, 255), B = RandomInt(0, 255);
                EntFireByHandle(p, "Color", (R+" "+G+" "+B), 0, null, null);
                return
            }
        }
    }
}

function collisionfix() {
	local entity = null;
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