/*
=== MAIN SCRIPT ===

This script is "hooked" into the main game by custom sp_transition_list script file.

It's basically a core of a mode, since most of changes are made through scripts.

This system is heavily aided by SMSM plugin, so it's REQUIRED for it to work.
*/

//Including the original script, preserving its original form.
local originalScriptPath = "..\\..\\..\\update\\scripts\\vscripts\\transitions\\sp_transition_list.nut";
IncludeScript(originalScriptPath);

/* some utility functions */

//Basically Entity.ConnectOutput, but adds this script to its execution scope
//...is it even used?
function AddOutput(entityname,event,func){
  local entity = GetEntity(entityname)
  if(entity){
    EntFire(entity.GetName(),"RunScriptFile","transitions/sp_transition_list.nut",0.0)
    entity.ConnectOutput(event,func)
  }else{
    //modlog("Failed to add output \""+event+":"+func+"\" for entity \""+entityname+"\"")
  }
}

//Easier way of obtaining entity handle.
//finding entity by name, then by class
//if old is vector, find by coordinates
function GetEntity(name, old=null){
  local entity = Entities.FindByName(old,name);
  if(!entity){
    if((typeof old) == "Vector")entity = Entities.FindByClassnameNearest(name,old,32);
    else entity = Entities.FindByClassname(old,name);
  }
  return entity;
}

//modlog
function modlog(msg){
  printl("### SPEEDRUN MOD ###: "+msg);
}

//self-explanatory
function IsSMSMActive(){
  return ("smsm" in this);
}



//dialogue mute stuff
DialogueMute_Previous <- -1
DialogueMute_Forced <- false

function DialogueMute_Update(){
    local newState = smsm.IsDialogueEnabled();
    if(DialogueMute_Forced)newState = true;
    if(DialogueMute_Previous != newState){
        local mixers = ["gladosVO", "potatosVO", "announcerVO", "wheatleyVO", "coreVO", "caveVO"];
        local defaults = [0.7, 0.4, 0.7, 0.7, 0.75, 0.88];
        local command = "";
        foreach (id, mixer in mixers){
          command += "snd_setmixer "+mixer+" vol "+(newState ? defaults[id] : 0.001)+";";
        }
        //modlog(command);
        SendToConsole(command);
        DialogueMute_Previous = newState;
    }
}

function DialogueMute_SetForceState(state){
  DialogueMute_Forced = state;
}

function DialogueMute_ForceFor(time){
  DialogueMute_SetForceState(true);
  EntFire(self.GetName(), "RunScriptCode", "DialogueMute_SetForceState(false)", time);
}



//actual script function loader
POST_SPAWN_FUNCTIONS <- {}
MAP_SPAWN_FUNCTIONS <- {}
UPDATE_FUNCTIONS <- {}
PRECACHE_FUNCTIONS <- {}

function AddModeFunctions(modeName, postSpawnFunc, mapSpawnFunc, updateFunc, precacheFunc){
  POST_SPAWN_FUNCTIONS[modeName] <- postSpawnFunc
  MAP_SPAWN_FUNCTIONS[modeName] <- mapSpawnFunc
  UPDATE_FUNCTIONS[modeName] <- updateFunc
  PRECACHE_FUNCTIONS[modeName] <- precacheFunc
}

//all different modes
SPEEDRUN_MODES <- {};
SPEEDRUN_MODES[0] <- ["default"];
SPEEDRUN_MODES[1] <- ["default", "fog_percent"];
SPEEDRUN_MODES[2] <- ["default", "celeste"];
//SPEEDRUN_MODES[3] <- ["default", "cubecore"];

//import proper scripts
if(IsSMSMActive()){
  IncludeScript("multiplayermod/speedrunmod_src/modes/default");
  switch(smsm.GetMode()){
    case 1: IncludeScript("multiplayermod/speedrunmod_src/modes/fog"); break;
    case 2: IncludeScript("multiplayermod/speedrunmod_src/modes/celeste"); break;
    //case 3: IncludeScript("multiplayermod/speedrunmod_src/modes/cubecore"); break;
  }
}



//backup system - a simple script retrieving plugin values from a save file.
IncludeScript("multiplayermod/speedrunmod_src/backup");

function Precache(){
  SLBS_Check();
  DialogueMute_Previous <- -1;
  local mode = SPEEDRUN_MODES[smsm.GetMode()]
  foreach (id, modename in mode){
    modlog("Loading Precache function for "+modename+".")
    local func = PRECACHE_FUNCTIONS[modename]
    func()
  }
}

function OnPostSpawn(){
  if(!IsSMSMActive()){
    modlog("SMSM PLUGIN VERIFICATION FAILED!!!!!!")
    EntFire("@command", "Command", "disconnect", 1)
  }else{
    //debug mode info
    local mode = smsm.GetMode()
    printl("### SPEEDRUN MOD ###: Preparing the mod in mode "+mode)

    local sc = GetEntity("point_servercommand")
    if(!sc){
      modlog("No point_servercommand loaded yet. Speedrun Mod initialisation failed.")
      return false
    }
    //necessary to use OnMapSpawn event, since OnPostSpawn can be executed before some entities are even spawned
    EntFireByHandle(sc, "Command", "p2mm_script OnMapSpawn()", 0, null, null)

    foreach (id, modename in SPEEDRUN_MODES[mode]){
      modlog("Loading PostSpawn function for "+modename+".")
      local func = POST_SPAWN_FUNCTIONS[modename]
      func()
    }

    //override transition script Think function
    TransitionThink <- Think
    Think = SpeedrunModThink
  }
}


function OnMapSpawn(){
  local mode = SPEEDRUN_MODES[smsm.GetMode()]
  foreach (id, modename in mode){
    modlog("Loading OnMapSpawn function for "+modename+".")
    local func = MAP_SPAWN_FUNCTIONS[modename]
    func()
  }
}


OLD_TIME <- 0
NEW_TIME <- 0

function SpeedrunModThink(){
  if ( initialized ){
    SLBS_Check();
    DialogueMute_Update();

    OLD_TIME = OLD_TIME==0 ? Time() : NEW_TIME;
    NEW_TIME = Time();  //TICKING AWAY THE MOMENTS THAT MAKE UP A DULL DAY
    //also idk if it's needed. it seems to be a constant rate of 0.0333s but idc i'll just leave it here

    local mode = SPEEDRUN_MODES[smsm.GetMode()]
    foreach (id, modename in mode){
      local func = UPDATE_FUNCTIONS[modename]
      func()
    }

    return 0.001;
  }else{
    //apparently, when not in maploop, Think function is used only once, so that's pretty convenient for me
    TransitionThink()
  }
}

function DeltaTime(){
  return NEW_TIME-OLD_TIME
}

