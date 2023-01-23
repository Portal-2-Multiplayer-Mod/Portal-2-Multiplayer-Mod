THANKS_ZPOS <- 0;

function Precache(){
    if(("smsm" in this) && smsm.GetMode() == 2){
        smsm.PrecacheModel("models/srmod/strawberry.mdl", true);
    }
}

function StartCredits(){
    EntFire("music", "PlaySound", "", 1)
    EntFire("fadein", "FadeReverse", "", 50)
    EntFire(self.GetName(), "RunScriptCode", "EndCredits()", 53.5)
    if(("smsm" in this) && smsm.GetMode() == 2){
        CelesteEnding();
    }
}

function CreditsThink(){
    if(THANKS_ZPOS==0){
        local thanks = Entities.FindByName(null,"THANKS");
        THANKS_ZPOS = thanks.GetOrigin().z;
    }

    local camera = Entities.FindByName(null,"camera");

    local cameraPos = camera.GetOrigin()
    if(cameraPos.z>THANKS_ZPOS)cameraPos.z -= 0.64;
    camera.SetAbsOrigin(cameraPos)

    return 0.01;
}

function EndCredits(){
    SendToConsole("map credits_museum")
}

function CelesteEnding(){
    local berry = Entities.CreateByClassname("prop_dynamic");
    berry.SetModel("models/srmod/strawberry.mdl");
    EntFireByHandle(berry, "AddOutput", "modelscale 0.8", 0, null, null);
    berry.SetOrigin(Vector(159, -116, -550));
    print("BERRY MODE!!!\n")
}