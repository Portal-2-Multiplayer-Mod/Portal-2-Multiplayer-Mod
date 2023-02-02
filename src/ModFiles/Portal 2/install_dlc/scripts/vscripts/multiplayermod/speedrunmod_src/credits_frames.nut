function Precache(){
    smsm.PrecacheModel("models/srmod/donorframe.mdl", true)
}

FramesData <- [
    {id=6, pos=Vector(-0.5,-120,70), size=2}, // bread
    {id=4, pos=Vector(-0.5,0,70), size=2}, // zackary
    {id=9, pos=Vector(-0.5,120,70), size=2}, // bait

    {id=11, pos=Vector(-0.5,-150,-30), size=1.5}, // that dude i do not tolerate for some reason
    {id=5, pos=Vector(-0.5,-75,-30), size=1.5}, // smegman
    {id=10, pos=Vector(-0.5,0,-30), size=1.5}, // chris
    {id=3, pos=Vector(-0.5,75,-30), size=1.5}, // beer guy
    {id=2, pos=Vector(-0.5,150,-30), size=1.5}, // the man that begged me to revive wiki for like a year

    {id=8, pos=Vector(-0.5,-120,-100), size=1}, // cube man
    {id=7, pos=Vector(-0.5,-60,-100), size=1}, // jerrystan or sth idk i dont do east countries
    {id=12, pos=Vector(-0.5,0,-100), size=1}, // funky lad
    {id=1, pos=Vector(-0.5,60,-100), size=1}, // lmao
    {id=0, pos=Vector(-0.5,120,-100), size=1}, // LOL
];

function SpawnFrames(){
    local FRAME_COUNT = 13;
    foreach(i, framedata in FramesData){
        local frame = CreateProp("prop_physics", Vector(-400, -930, 668), "models/srmod/donorframe.mdl", 1);
        EntFireByHandle(frame, "AddOutput", "solid 6", 0, null, null);
        EntFireByHandle(frame, "AddOutput", "skin "+framedata.id, 0, null, null);
        EntFireByHandle(frame, "AddOutput", "modelscale "+framedata.size, 0, null, null);
        frame.SetAngles(90,0,180);
        local origin = self.GetOrigin() + framedata.pos;
        frame.SetOrigin(origin);
    }
}