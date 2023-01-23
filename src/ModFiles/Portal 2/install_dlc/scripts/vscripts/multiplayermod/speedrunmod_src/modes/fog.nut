//*****************************************************
//====FOG%====
//you cant see shit
//*****************************************************

function FogPrecentPrecache(){

}

function FogPercentPostSpawn(){
    FogControl = NewFogControl
}

function FogPercentLoad(){
    //vgui screens appears through the fog, but we don't have to see them so I just remove them lmfao
    //killing crashes the game, disabling them does nothing, so I just teleport them where noone can get
    EntFire("vgui_movie_display", "SetLocalOrigin", "-42069 0 0", 0.1)

    //old event call loop, replaced with script think function
    //EntFire(self.GetName(), "AddOutput", "OnUser1 "+self.GetName()+":FireUser1::0.1:-1")
    //EntFire(self.GetName(), "AddOutput", "OnUser1 "+self.GetName()+":RunScriptCode:UpdateFogToVelocity():0:-1")
    //EntFire(self.GetName(), "FireUser1")
}

function NewFogControl(){
    EntFire("env_fog_controller", "SetColorSecondary", "70 75 80")
    EntFire("env_fog_controller", "SetColor", "70 75 80")
    EntFire("env_fog_controller", "SetStartDist", "-64")
    EntFire("env_fog_controller", "SetEndDist", "128")
    EntFire("env_fog_controller", "SetMaxDensity", 1)
}

FOG_FADEAWAY_VALUE <- 0;
FOG_FADEAWAY_END <- false;
FOG_PREVIOUS_DENSITY <- 1;

//TODO: find the sweet spot so it's still difficult but so people not have pain in the ass
FOG_WAIT_TIME <- 4;
FOG_FADE_TIME <- 5;

function UpdateFogToVelocity(){
    local i = (FOG_WAIT_TIME+FOG_FADE_TIME)*30;
    local j = (FOG_WAIT_TIME)*30;
    local vel = GetPlayer().GetVelocity();
    local totalVel = vel.x + vel.y + vel.z;
    if(totalVel == 0 && !FOG_FADEAWAY_END){
        if(FOG_FADEAWAY_VALUE<i)FOG_FADEAWAY_VALUE++;
    }else{
        FOG_FADEAWAY_END=true;
        FOG_FADEAWAY_VALUE-=4;
        if(FOG_FADEAWAY_VALUE<0){
            FOG_FADEAWAY_VALUE=0;
            FOG_FADEAWAY_END = false;
        }
    }
    local f = FOG_FADEAWAY_VALUE-j;
    local value = 1-(f<0 ? 0 : f)*0.0008
    //do not update fog if not necessary
    if(value!=FOG_PREVIOUS_DENSITY)EntFire("env_fog_controller", "SetMaxDensity", value)
    FOG_PREVIOUS_DENSITY=value
}

function FogPercentUpdate(){
    UpdateFogToVelocity()
}

//r_paintblob_material 4

AddModeFunctions("fog_percent", FogPercentPostSpawn, FogPercentLoad, FogPercentUpdate, FogPrecentPrecache)