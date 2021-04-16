//********************************************************************************************
//MAPSPAWN.nut is called on newgame or transitions
//********************************************************************************************

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

Entities.First().ConnectOutput("OnUser1", "init");
DoEntFire("worldspawn", "FireUser1", "", 0.0, null, null);
printl(GetMapName())
if (GetMapName() == "mp_coop_lobby_3"){
	printl("Map is lobby 3")
} else {
	printl("map isnt lobby 3") //simple test to later remove entities from lobby_3 to allow for 33 players
}