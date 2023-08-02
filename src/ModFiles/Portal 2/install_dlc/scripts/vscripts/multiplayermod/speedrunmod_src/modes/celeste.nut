//*****************************************************
//====Celeste%====
//Advanced movement and stuff
//*****************************************************

ModeParams <- {
    InitialValue = 0,
    MaxDashes = 1,
    MaxStamina = 2,
    DashesLeft = 3,
    StaminaLeft = 4,
    Dashing = 5,
    WarpToMoonRoom = 6,
    DisplayBerriesGot = 10,
    DisplayBerriesMax = 11,
    DisplayBerriesForce = 12,
    DisplayBerriesInLevelCount = 13,
    DisplayBerriesInLevelOffset = 20,
    BerriesOffset = 30,
};

function CelestePrecache(){
    self.PrecacheSoundScript("celeste.dash")
    self.PrecacheSoundScript("celeste.quantumberrylost")
    self.PrecacheSoundScript("celeste.quantumberrylost_distant")
    smsm.PrecacheModel("models/srmod/hintplank.mdl", true)
    smsm.PrecacheModel("models/srmod/strawberry.mdl", true)
    smsm.PrecacheModel("models/srmod/introcar.mdl", true)
    smsm.PrecacheModel("models/srmod/quantumberry.mdl", true)
    smsm.PrecacheModel("models/srmod/goldenberry.mdl", true)
    smsm.PrecacheModel("models/srmod/goldenquantumberry.mdl", true)
}

//birb code

BirbHandle <- null;
IsBirbMap <- false;
BirbInterp <- 0.0;
BirbFrame <- 0;
BirbJumpLoop <-0;
BirbKeyframes <- [
    {pos=Vector(-2159,-1351,-5112),ang=Vector(0,315,0),speed=0.1},
    {pos=Vector(-2207,-1223,-5112),ang=Vector(0,60,0),speed=0.1},
    {pos=Vector(-2128,-1111,-5112),ang=Vector(0,90,0),speed=0.1},
    {pos=Vector(-2059,-1020,-5065),ang=Vector(0,175,0),speed=0.1},
    {pos=Vector(-2129,-927,-5112),ang=Vector(0,140,0),speed=0.1},
    {pos=Vector(-2176,-799,-5112),ang=Vector(0,120,0),speed=0.1},
    {pos=Vector(-2240,-687,-5112),ang=Vector(0,130,0),speed=0.1},
    {pos=Vector(-2256,-575,-5112),ang=Vector(0,100,0),speed=0.1},
    {pos=Vector(-2335,-415,-5070),ang=Vector(0,37,0),speed=0.1},
    {pos=Vector(-2224,-272,-5112),ang=Vector(0,80,0),speed=0.1},
    {pos=Vector(-2272,-96,-5112),ang=Vector(0,100,0),speed=0.1},
    {pos=Vector(-2208,64,-5112),ang=Vector(0,60,0),speed=0.1},
    {pos=Vector(-2240,208,-5112),ang=Vector(0,90,0),speed=0.1},
    {pos=Vector(-2272,368,-5112),ang=Vector(0,-80,0),speed = 0.02},
    {pos=Vector(-2360,378,-4568),ang=Vector(0,-60,0),speed=0.1},
    {pos=Vector(-2391,574,-4568),ang=Vector(0,50,0),speed=0.1},
    {pos=Vector(-2566,553,-4568),ang=Vector(0,0,0),speed=0.1},
    {pos=Vector(-2621,547,-4440),ang=Vector(0,0,0),speed = 0.05},
    {pos=Vector(-2929,415,-4529),ang=Vector(0,0,0),speed=0.1},

];
BirbMaxKeyframes <- 19;


function UpdateBirbPos(){
    if(BirbFrame >= BirbMaxKeyframes)return;
    local prevKf = BirbKeyframes[BirbFrame];
    local nextKf = prevKf;
    if(BirbFrame<BirbMaxKeyframes-1){
        nextKf = BirbKeyframes[BirbFrame+1];
    }

    local birbPos = prevKf.pos + ((nextKf.pos - prevKf.pos) * BirbInterp);
    local birbRot = prevKf.ang + ((nextKf.ang - prevKf.ang) * BirbInterp);

    local maxJH = ((nextKf.pos-prevKf.pos).Length());
    local jumpHeight = (-BirbInterp*(BirbInterp-1))*maxJH;
    birbPos.z += jumpHeight;

    if(BirbInterp == 0){
        local smallJump = sin(BirbJumpLoop)*10;
        if(smallJump<0)smallJump = -smallJump;
        birbPos.z += smallJump;
        BirbJumpLoop += 0.5;
    }
    //BirbHandle.SetOrigin(birbPos);
    BirbHandle.SetAbsOrigin(birbPos);
    //EntFireByHandle(BirbHandle, "SetLocalOrigin", birbPos.x + " " + birbPos.y + " " + birbPos.z, 0, null, null)
    BirbHandle.SetAngles(birbRot.x,birbRot.y,birbRot.z);
}

function FindBirb(){
    BirbHandle = GetEntity("bird");
    UpdateBirbPos();
    IsBirbMap = true;
}

function UpdateBirb(){
    if(BirbInterp>0){
        local d=BirbKeyframes[BirbFrame].speed;
        BirbInterp+=d;
        //print(BirbInterp+"\n")
        if(BirbInterp>=1){
            BirbInterp = 0;
            BirbFrame++;
            BirbJumpLoop = 0;
        }
    }else if(BirbFrame < BirbMaxKeyframes){
        local kfPos = BirbKeyframes[BirbFrame].pos;
        local pPos = GetPlayer().GetOrigin();
        pPos.z += 36;
        local dist = pPos-kfPos;
        if(dist.Length() < 80){
            if(BirbFrame < BirbMaxKeyframes-1){
                BirbInterp = 0.01;
                BirbHandle.EmitSound("BirdBirdBird.Idles");
            }else{
                EntFire("bird","SetAnimation","nest_flyOff",0.0)
                EntFire("bird_idle_timer", "Kill")
                EntFire("bird", "Kill", "", 3.66)
                BirbFrame++;
            }
        }
    }
    UpdateBirbPos();
}




//berries
BERRIES <- {};
//okay, look, i know you think "yaya me me smart" but 
//at least try to not spoil berries location for yourself
BERRIES["sp_a1_intro1"] <- [
    {name="First Steps",pos=Vector(-1075, 4348, 2739)},
];
BERRIES["sp_a1_intro2"] <- [
    {name="Sever The Skyline",pos=Vector(-230, 190, 580)},
];
BERRIES["sp_a1_intro3"] <- [
    {name="Where You Suppose To Go",pos=Vector(-512, 1200, 1160)},
    {name="Up Where You Shouldn't Go",pos=Vector(-1278, 3390, 400)},
];
BERRIES["sp_a1_intro4"] <- [
    {name="Lab Observator",pos=Vector(848, -704, 340)},
];
BERRIES["sp_a1_intro5"] <- [
    {name="intro car",pos=Vector(-345, -876, 710)},
];
BERRIES["sp_a1_intro6"] <- [
    {name="Following Faulty Momentum",pos=Vector(444, -256, 600)},
    {name="Empty Spaces",pos=Vector(1245, 394, 720)},
    {name="Golden Seam Shooter",pos=Vector(1664, -472, 630), golden=1},
];
BERRIES["sp_a1_intro7"] <- [
    {name="Covered By Old Technology",pos=Vector(0, -448, 1280)},
    {name="Thinking Without Portals",pos=Vector(-588, -609, 1490), quantum=1},
];
BERRIES["sp_a1_wakeup"] <- [
    {name="The One You Probably Missed",pos=Vector(6974, 840, 620)},
    {name="In The Mess",pos=Vector(9790, 1440, 464)},
    {name="In The Darkness",pos=Vector(10320, 1375, -300)},
];
BERRIES["sp_a2_intro"] <- [
    {name="You Take Me Even Higher",pos=Vector(-2230, 600, -9868)},
    {name="Chilling On A Metal Rod",pos=Vector(412, 520, -10288)},
];
BERRIES["sp_a2_laser_intro"] <- [
    {name="The Hole In A Wall",pos=Vector(224, 280, 42)},
];
BERRIES["sp_a2_laser_stairs"] <- [
    {name="Climbing The Pipe Ladder",pos=Vector(-665, -420, 828)},
    {name="Navigating The Pipe Maze",pos=Vector(665, -41, 128)},
];
BERRIES["sp_a2_dual_lasers"] <- [
    {name="Golden Clip Executor",pos=Vector(-221, 215, 1408), golden=1},
    {name="I'm Just Hopping",pos=Vector(303, -704, 1104)},
];
BERRIES["sp_a2_laser_over_goo"] <- [
    {name="Thinking With Wavedashing",pos=Vector(3004, -923, 102), quantum=1},
];
BERRIES["sp_a2_catapult_intro"] <- [
    {name="Golden Cube Jumper",pos=Vector(-512, -351, 608), golden=1},
];
BERRIES["sp_a2_trust_fling"] <- [
    {name="Watching Catapults Through A Pipe",pos=Vector(-992, -640, -320)},
    {name="Hoopy Companion",pos=Vector(2035, -57, 258)},
    {name="Thinking With Dashing",pos=Vector(-1152, 1442, 64), quantum=1},
];
BERRIES["sp_a2_pit_flings"] <- [
    {name="One Of These In A Ceiling",pos=Vector(608, 194, 528)},
    {name="Thinking With Climbing",pos=Vector(-672, -352, 64), quantum=1},
];
BERRIES["sp_a2_fizzler_intro"] <- [
    {name="Another One Of These In A Ceiling",pos=Vector(164, -352, 544)},
];
BERRIES["sp_a2_sphere_peek"] <- [
    {name="Comfy Box Of Steel",pos=Vector(-1824, 1824, 264)},
    {name="Bumping Into A Lab",pos=Vector(-1408, 1184, 512)},
    {name="Glorious Room Of Heavens",pos=Vector(-1416, 2336, 800)},
];
BERRIES["sp_a2_ricochet"] <- [
    {name="Casual Wall Climber",pos=Vector(2269, 1152, 262)},
    {name="Golden Wall Climber",pos=Vector(3232, 1344, 480), golden=1},
];
BERRIES["sp_a2_bridge_intro"] <- [
    {name="Golden Least Portal Thinker",pos=Vector(-104, 1116, -80), quantum=1, golden=1},
];
BERRIES["sp_a2_bridge_the_gap"] <- [
    {name="Another One You Probably Missed",pos=Vector(-1123, -595, 1495)},
    {name="Barely Anyone Knows This Place",pos=Vector(-128, -256, 1752)},
];
BERRIES["sp_a2_turret_intro"] <- [
    {name="Thinking With Turrets",pos=Vector(700, 256, -192), quantum=1},
    {name="Golden Trigger Observer",pos=Vector(-475, 391, -192), golden=1},
];
BERRIES["sp_a2_turret_blocker"] <- [
    {name="Thinking With Turret Guardians",pos=Vector(64, 1376, 64), quantum=1},
];
BERRIES["sp_a2_laser_vs_turret"] <- [
    {name="Serenade Listener",pos=Vector(864, -448, 360)},
];
BERRIES["sp_a2_pull_the_rug"] <- [
    {name="Thinking With Secret Rooms",pos=Vector(128, -1104, 550), quantum=1},
];
BERRIES["sp_a2_column_blocker"] <- [
    {name="Surprise Provider",pos=Vector(32, -912, 660)},
    {name="Guarded By A Turret",pos=Vector(-192, 1060, 86)},
];
BERRIES["sp_a2_laser_chaining"] <- [
    {name="Hanging By Fingers From A Moutain",pos=Vector(448, 64, 704)},
    {name="Hidden Yet Exposed",pos=Vector(-432, -860, 704)},
];
BERRIES["sp_a2_triple_laser"] <- [
    {name="Surrounded By Arms",pos=Vector(8231, -5915, 64)},
    //TODO: allow triple laser oob in leaderboards
    {name="Golden OOB Explorer",pos=Vector(7420, -5732, 100), golden=1}, 
];
BERRIES["sp_a2_bts1"] <- [
    {name="Part Of Non-Existing Test",pos=Vector(-9118, -890, 638)},
    {name="Basically On Our Way",pos=Vector(-1216, -992, 400)},
    {name="Practically On Our Way",pos=Vector(848, -1742, -384)},
];
BERRIES["sp_a2_bts2"] <- [
    {name="The Path Of A Least Portaler",pos=Vector(1034, -2888, 176)},
];
BERRIES["sp_a2_bts3"] <- [
    {name="On Wheatley's Way",pos=Vector(4574, 1410, 420)},
    {name="Technically On Our Way",pos=Vector(5234, -510, 352)},
    {name="Wait, that's not a turret!",pos=Vector(6142, 760, -64)},
    {name="Where Panels Come From",pos=Vector(6532, 3008, -192)},
    {name="Secret Room Near Pipes",pos=Vector(9920, 3934, -384)},
    {name="Above The Construction Noise",pos=Vector(7744, 5440, -64)},
    {name="Above The Fall",pos=Vector(6720, 4672, 300)},
];
BERRIES["sp_a2_bts4"] <- [
    {name="Golden Pancake Shooter",pos=Vector(1072, -2656, 7232), golden=1},
    {name="Turret Redemption Observer",pos=Vector(1938, -3200, 7744)},
    {name="Guarded By The Test Doll",pos=Vector(2896, -5120, 6688)},
    {name="Not Stepping On Children's Projects",pos=Vector(-1664, -7360, 6720)},
];
BERRIES["sp_a2_core"] <- [
    {name="Corridor From A Near Past",pos=Vector(168, 2118, -40)},
    {name="Where's My Turkey?",pos=Vector(-1648, 0, 320)},
    {name="Thinking With Big Jumps",pos=Vector(0, 308, -180), quantum=1},
];
BERRIES["sp_a3_01"] <- [
    {name="Golden Reactions Possessor",pos=Vector(-528, -1363, 2451), golden=1},
    {name="Lurking From A Darkness",pos=Vector(-1880, -2760, 396)},
    {name="Swimming Below A Pipe",pos=Vector(-1090, 194, 69)},
    {name="Hiding Behind The Barrier",pos=Vector(-7, 2786, 512)},
    {name="Thinking With Underground Maze",pos=Vector(4878, 4402, -480), quantum=1},
];
BERRIES["sp_a3_03"] <- [
    {name="Admiring The Underestimated Power",pos=Vector(-5416, -1808, -4928)},
    {name="Olympian",pos=Vector(-9232, 644, -4664)},
    {name="Phone Call From A Past",pos=Vector(-7040, 1216, -4672)},
    {name="Appreciating The High Ground",pos=Vector(-5062, 1024, -2244)},
];
BERRIES["sp_a3_jump_intro"] <- [
    {name="The Casual Wall",pos=Vector(-1136, 704, 580)},
    {name="Jumpless Office",pos=Vector(-1790, 598, 1004)},
];
BERRIES["sp_a3_bomb_flings"] <- [
    {name="Exploring The Ruins",pos=Vector(-1220, 996, -876)},
    {name="Hiding On The Edge",pos=Vector(598, 330, 400)},
    {name="Thinking With Ladder",pos=Vector(288, 2080, 804), quantum=1},
];
BERRIES["sp_a3_crazy_box"] <- [
    {name="Waiting For Time Travel",pos=Vector(2080,-1436,240)},
    {name="Thinking With The Crazy Box",pos=Vector(642,8,2144), quantum=1},
];
BERRIES["sp_a3_transition01"] <- [
    {name="Golden Crouching Stander",pos=Vector(-2496, 704, -4832), golden=1},
    {name="Admiring Borealis",pos=Vector(-5054,721,-3998)},
];
BERRIES["sp_a3_speed_ramp"] <- [
    {name="Useless Cube Companion",pos=Vector(-1218, 1664, 0)},
    {name="Familiar Faces",pos=Vector(-640, 3, 600)},
    {name="Tower Climber",pos=Vector(-160, -640, 1592)},
    {name="Golden Solidity Researcher",pos=Vector(1140, -702, 1800), golden=1},
];
BERRIES["sp_a3_speed_flings"] <- [
    {name="I'm Sorry Daniel",pos=Vector(2304, 896, 790)},
    {name="A Sign To Quit",pos=Vector(455, 1237, 502)},
];
BERRIES["sp_a3_portal_intro"] <- [
    {name="First Fizzler Companion",pos=Vector(2448, -1096, -2495)},
    {name="DANGER KEEPOUT",pos=Vector(784, 1712, -1594)},
    {name="Observing Conversion",pos=Vector(-768, -256, 1024)},
    {name="Protecting The Entrance",pos=Vector(2944, -192, 748)},
    {name="Thinking With Reaching The Summit",pos=Vector(3600, 32, 5696), quantum=1},
];
BERRIES["sp_a3_end"] <- [
    {name="Behind The Red Pipe",pos=Vector(-2096, -758, -2690)},
    {name="Watching White Paint Dry",pos=Vector(-246, 256, -2008)},
    {name="The Summit",pos=Vector(-1730, 190, 3980)},
];
BERRIES["sp_a4_intro"] <- [
    {name="Hidden Behind Screens",pos=Vector(1470, -192, 1052)},
];
BERRIES["sp_a4_tb_trust_drop"] <- [
    {name="Dropped With Trust",pos=Vector(-128, 608, 374)},
    {name="Blessed By Wheatley",pos=Vector(-798, 1086, 947)},
];
BERRIES["sp_a4_tb_wall_button"] <- [
    {name="WHY ISN'T THIS SOLID?!",pos=Vector(-448, 576, 20)},
    {name="Chilling On A Lamp",pos=Vector(-656, 1408, 332)},
];
BERRIES["sp_a4_tb_polarity"] <- [
    {name="Unnecessarily Guarded By A Turret",pos=Vector(128, 2672, 256)},
];
BERRIES["sp_a4_tb_catch"] <- [
    {name="PORTAL CUUT!",pos=Vector(444, 800, 250)},
];
BERRIES["sp_a4_stop_the_box"] <- [
    {name="Catapult Not For You",pos=Vector(-774, 318, 874)},
    {name="Moving Chamber Is A Lie",pos=Vector(-32, -496, 1488)},
    {name="My Secret Room",pos=Vector(-386, -629, 668)},
];
BERRIES["sp_a4_laser_catapult"] <- [
    {name="The Casual Cube",pos=Vector(1124, 126, 192)},
];

BERRIES["sp_a4_laser_platform"] <- [
    {name="Living In A Crack",pos=Vector(-20, -1142, 750)},
    {name="Observing The Funnel",pos=Vector(-172, -720, 352)},
];

BERRIES["sp_a4_speed_tb_catch"] <- [
    {name="Appretiating The Chamber's Height",pos=Vector(448, 1192, 898)},
    {name="A Catwalk To Nowhere",pos=Vector(-2688, 2080, 72)},
    {name="Thinking With P-Body",pos=Vector(-2400, 496, 64), quantum=1},
];
BERRIES["sp_a4_jump_polarity"] <- [
    {name="Hidden In A Gel Pipe",pos=Vector(-570, -60, 420)},
    {name="Burning On Catwalks",pos=Vector(-494, 2113, 977)},
    {name="(teleports behind you)",pos=Vector(2560, -4192, 432)},
];
BERRIES["sp_a4_finale1"] <- [
    {name="Actually Solving The Test",pos=Vector(-3712, -7424, 182)},
    {name="Watching The Part Where He Kills You",pos=Vector(-8594, -1535, 412)},
    {name="On A Lamp",pos=Vector(-13020, -2270, 760)},
];
BERRIES["sp_a4_finale2"] <- [
    {name="Holmes Vs Moriarty",pos=Vector(400, -2186, -448)},
    {name="Living In The Trash",pos=Vector(-2075, 0, -331)},
];
BERRIES["sp_a4_finale3"] <- [
    {name="Deep Inside The Pipe",pos=Vector(448, -1664, 304)},
    {name="On A Pipe",pos=Vector(-480, 1890, 480)},
    {name="Golden Berry Finder",pos=Vector(60, 5053, 589), golden=1},
];

BERRIES["celeste_moonroom"] <- [
    {name="Grand Red Berry",pos=Vector(-272, 260, -816)},
    {name="Grand Quantum Berry",pos=Vector(-160, 260, -816), quantum=1},
    {name="Grand Golden Berry",pos=Vector(-48, 260, -816), golden=1},
];



BERRIES_counter <- 0;
BERRIES_max <- 0;
BERRIES_initialized <- false;

BERRIES_count_red <- 0;
BERRIES_count_quantum <- 0;
BERRIES_count_golden <- 0;

BERRIES_count_red_collected <- 0;
BERRIES_count_quantum_collected <- 0;
BERRIES_count_golden_collected <- 0;

function PrintBerriesCount(){
    modlog("Number of berries total: "+BERRIES_max);
    modlog("Number of red berries: "+BERRIES_count_red);
    modlog("Number of quantum berries: "+BERRIES_count_quantum);
    modlog("Number of golden berries: "+BERRIES_count_golden);
}

function CreateBerries(){
    //assigning ID to every berry, and check if its collected already
    foreach( mapname, berryset in BERRIES){
        foreach(index, berry in berryset){
            berry.id <- BERRIES_max;
            berry.collected <- false;
            if(!("quantum" in berry))berry.quantum <- 0;
            if(!("golden" in berry))berry.golden <- 0;
            if(smsm.GetModeParam(ModeParams.BerriesOffset+BERRIES_max)>0){
                berry.collected = true;
            }
            BERRIES_max++;
            
            if(mapname=="celeste_moonroom")continue;

            //counting berries
            if(berry.golden){
                BERRIES_count_golden++;
                if(berry.collected)BERRIES_count_golden_collected++;
            }else if(berry.quantum){
                BERRIES_count_quantum++;
                if(berry.collected)BERRIES_count_quantum_collected++;
            }else{
                BERRIES_count_red++;
                if(berry.collected)BERRIES_count_red_collected++;
            }
        }
    }

    //spawning uncollected berries
    if(GetMapName() in BERRIES){
        foreach( index, berry in BERRIES[GetMapName()] ) if(!berry.collected){
            local berryEnt = Entities.CreateByClassname("prop_dynamic_override");
            EntFireByHandle(berryEnt, "AddOutput", "targetname berry_"+index, 0, null, null);
            EntFireByHandle(berryEnt, "SetAnimation", "idle", 0, null, null);
            if(berry.golden && berry.quantum)berryEnt.SetModel("models/srmod/goldenquantumberry.mdl");
            else if(berry.quantum)berryEnt.SetModel("models/srmod/quantumberry.mdl");
            else if(berry.golden)berryEnt.SetModel("models/srmod/goldenberry.mdl");
            else berryEnt.SetModel("models/srmod/strawberry.mdl");
            if(GetMapName()=="celeste_moonroom"){
                EntFireByHandle(berryEnt, "AddOutput", "modelscale 1.5", 0, null, null);
            }
            berryEnt.SetOrigin(berry.pos);
            berry.entity <- berryEnt;
        }
        //prepare portal detection system
        CheckPortals(true);
    }

    UpdateBerryCounter();

    BERRIES_initialized = true;
}

function ResetBerries(){
    for(local i=0;i<BERRIES_max;i++){
        smsm.SetModeParam(ModeParams.BerriesOffset+i,0);
    }
    UpdateBerryCounter();
}

function CollectAllBerriesBeforeThisMap(){
    foreach( index, map in MapPlayOrder ){
        if(map == GetMapName()) break;
        if(map in BERRIES)foreach( index, berry in BERRIES[map] ){
            smsm.SetModeParam(ModeParams.BerriesOffset+berry.id,1);
        }
    }
    UpdateBerryCounter();
}

function ResetAllBerriesInThisLevel(){
    if(GetMapName() in BERRIES)foreach( index, berry in BERRIES[GetMapName()] ){
        smsm.SetModeParam(ModeParams.BerriesOffset+berry.id,0);
    }
    UpdateBerryCounter();
}

function UpdateBerryCounter(){
    local berriesCollected = 0;
    for(local i=0;i<BERRIES_max;i++){
        if(smsm.GetModeParam(ModeParams.BerriesOffset+i)>0)berriesCollected++;
    }
    smsm.SetModeParam(ModeParams.DisplayBerriesGot, berriesCollected);
    BERRIES_counter = berriesCollected;

    local inLevelBerriesCount = 0;
    if(GetMapName() in BERRIES)foreach( index, berry in BERRIES[GetMapName()] ){
        if(index>=10)break;
        local berryType = 0;
        if(berry.quantum)berryType+=2;
        if(berry.golden)berryType+=4;
        if(berry.collected) berryType++;
        smsm.SetModeParam(ModeParams.DisplayBerriesInLevelOffset + index, berryType);
        inLevelBerriesCount++;
    }
    smsm.SetModeParam(ModeParams.DisplayBerriesInLevelCount, inLevelBerriesCount);

}

BERRIES_portal_init <- 0;
BERRIES_quantum_removed <- false;

//not reliable!
//apparently sometimes portals appear in the level even if they're not placed,
//and sometimes it's not (0,0,0), so it's dumb solution, but it works in most cases
function CheckPortals(checkInitial){
    if(!BERRIES_quantum_removed){
        local portalCount = 0;
        local portal = null;
        while(portal = Entities.FindByClassname(portal, "prop_portal")){
            if(portal.GetOrigin().Length() > 0)portalCount++;
        }
        if(checkInitial){
            BERRIES_portal_init = portalCount
        }else if(BERRIES_portal_init != portalCount){
            RemovePortalBerries();
        }
    }
}

function RemovePortalBerries(){
    if(!BERRIES_quantum_removed){
        modlog("Portal placement detected, destroying quantum berries!")

        local emitDistant = true;

        if(GetMapName() in BERRIES)foreach( index, berry in BERRIES[GetMapName()] ){
            if(berry.quantum && !berry.collected && berry.entity){
                local berryFizzle = Entities.CreateByClassname("prop_weighted_cube");
                if(berry.golden)berryFizzle.SetModel("models/srmod/goldenquantumberry.mdl");
                else berryFizzle.SetModel("models/srmod/quantumberry.mdl");
                berryFizzle.SetOrigin(berry.pos);
                EntFireByHandle(berryFizzle, "Dissolve", "", 0, null, null);
                EntFireByHandle(berry.entity, "Skin", "2", 0, null, null);
                EntFireByHandle(berry.entity, "DisableDraw", "", 0, null, null)
                EntFireByHandle(berry.entity, "EnableDraw", "", 2, null, null)
                berry.entity = null;

                local dist = (berry.pos - GetPlayer().GetOrigin()).Length();
                if(dist<1000){
                    emitDistant = false;
                    berryFizzle.EmitSound("celeste.quantumberrylost");
                }
            }
        }

        if(emitDistant)GetPlayer().EmitSound("celeste.quantumberrylost_distant");

        BERRIES_quantum_removed = true;
    }
}

function UpdateBerries(){
    if(!BERRIES_initialized)return;
    local pmin = GetPlayer().GetOrigin()+GetPlayer().GetBoundingMins();
    local pmax = GetPlayer().GetOrigin()+GetPlayer().GetBoundingMaxs();
    local quantumCount = 0;
    if(GetMapName() in BERRIES)foreach( index, berry in BERRIES[GetMapName()] ){
        if(!berry.collected && berry.entity){
            if(berry.quantum)quantumCount++;
            local bsize = 16;
            local bmin = berry.entity.GetOrigin() - Vector(bsize,bsize,bsize);
            local bmax = berry.entity.GetOrigin() + Vector(bsize,bsize,bsize);
            //if player bbox overlaps berry bbox
            if(pmax.x > bmin.x && pmin.x < bmax.x && pmax.y > bmin.y && pmin.y < bmax.y && pmax.z > bmin.z && pmin.z < bmax.z){
                berry.collected = true;
                //berry.entity.EmitSound("celeste.berryget");
                EntFireByHandle(berry.entity, "Kill", "", 2, null, null);
                EntFireByHandle(berry.entity, "Skin", "1", 0.01, null, null);
                EntFireByHandle(berry.entity, "SetAnimation", "collect", 0, null, null);
                smsm.SetModeParam(ModeParams.BerriesOffset+berry.id,1);
                UpdateBerryCounter();
            }
        }
    }
    if(quantumCount>0)CheckPortals(false);
}

//main code

function CelestePostSpawn(){
    //FOG_CONTROL_VALUES = {r=0.8, g=0.4, b=1.3};
    FIRST_MAP_WITH_POTATO_GUN = "sp_a3_speed_ramp"
}

FIRST_MAP_WITH_1_DASH <- "sp_a1_intro4"
FIRST_MAP_WITH_2_DASHES <- "sp_a3_speed_ramp"

function CelesteLoad(){
    //give player only viewmodel of portalgun, to for dashing indicator
    local dashes = 0;
    foreach( index, map in MapPlayOrder ){
        if(map == FIRST_MAP_WITH_1_DASH) dashes = 1;
        if(map == FIRST_MAP_WITH_2_DASHES) dashes = 2;
        if(map == GetMapName()) break;
    }
    if(GetMapName() == "celeste_moonroom") dashes = 1337;

    //ensure that is turned on
    if(GetMapName()=="sp_a1_intro1" || GetMapName()=="sp_a1_intro3"){
        SendToConsole("gameinstructor_enable 1")
    }

    switch(GetMapName()){
    case "sp_a1_intro1":

        //build a wall-climb force-learn environment or something idk
        local containerWall1 = Entities.FindByClassnameNearest("func_door", Vector(-5818, 1327, 285), 10)
        EntFireByHandle(containerWall1, "SetLocalOrigin", "-1403.22 4404.75 2733.44", 0, null, null)
        EntFireByHandle(containerWall1, "SetLocalAngles", "0 90 98", 0, null, null)
        //normal wall. slanted one confused lots of peples
        local containerWall2 = Entities.FindByClassnameNearest("func_door", Vector(-5477, 1400, 285), 10)
        EntFireByHandle(containerWall2, "SetLocalOrigin", "-1210 4602 2745", 0, null, null)
        EntFireByHandle(containerWall2, "SetLocalAngles", "0 0 5", 0, null, null)

        local sign = Entities.CreateByClassname("prop_dynamic_override");
        sign.SetModel("models/srmod/hintplank.mdl");
        EntFireByHandle(sign, "AddOutput", "targetname climb_sign", 0, null, null)
        sign.SetOrigin(Vector(-1405, 4374, 2740));
        sign.SetAngles(85,0,90)

        local hint = Entities.CreateByClassname("env_instructor_hint");
        EntFireByHandle(hint, "AddOutput", "targetname climb_hint", 0, null, null)
        EntFireByHandle(hint, "AddOutput", "hint_target climb_sign", 0, null, null)
        EntFireByHandle(hint, "AddOutput", "hint_binding +use", 0, null, null)
        EntFireByHandle(hint, "AddOutput", "hint_caption Wallclimb", 0, null, null)
        EntFireByHandle(hint, "AddOutput", "hint_color 255 255 255", 0, null, null)
        EntFireByHandle(hint, "AddOutput", "hint_icon_onscreen use_binding", 0, null, null)

        break;
    case "sp_a1_intro2":
        EntFire("block_boxes", "Kill")

        local button1 = GetEntity("blue_1_portal_button");
        button1.SetOrigin(Vector(-532, 192, -62))
        EntFireByHandle(button1, "SetLocalAngles", "-12 180 0", 0, null, null)
        local button2 = GetEntity("blue_3_portal_button");
        button2.SetOrigin(Vector(-110, 134, -64))
        EntFireByHandle(button2, "SetLocalAngles", "-10 11 4", 0, null, null)

        local box = GetEntity("box");
        box.SetOrigin(Vector(0, 160, -16))

        break;
    case "sp_a1_intro3":
        EntFire("pickup_portalgun_rl", "AddOutput", "OnTrigger "+self.GetName()+":RunScriptCode:UpgradeDashes(1):0:1")
        EntFire("emitter_orange_2", "Kill")
        EntFire("portal_orange_2", "Kill")
        EntFire("portal_orange_mtg", "Kill")
        EntFire("emitter_orange_mtg", "Kill")
        EntFire("prop_physics", "Kill")

        local sign1 = Entities.CreateByClassname("prop_dynamic_override");
        sign1.SetModel("models/srmod/hintplank.mdl");
        sign1.SetOrigin(Vector(-131, 1995, -296));
        sign1.SetAngles(79,338,24);
        EntFireByHandle(sign1, "skin", "1", 0, null, null)

        local hint = Entities.CreateByClassname("env_instructor_hint");
        EntFireByHandle(hint, "AddOutput", "targetname dash_hint", 0, null, null)
        EntFireByHandle(hint, "AddOutput", "hint_binding +dash", 0, null, null)
        EntFireByHandle(hint, "AddOutput", "hint_caption Dash", 0, null, null)
        EntFireByHandle(hint, "AddOutput", "hint_color 255 255 255", 0, null, null)
        EntFireByHandle(hint, "AddOutput", "hint_icon_onscreen use_binding", 0, null, null)
        break;
    case "sp_a1_intro4":
        EntFire("portal_emitter_a_lvl3", "Kill")
        EntFire("portal_a_lvl3", "Kill")
        EntFire("section_2_portal_a1_rm3a", "Kill")
        EntFire("section_2_portal_emitter_a1_rm3a", "Kill")
        EntFire("section_2_portal_a2_rm3a", "Kill")
        EntFire("section_2_portal_emitter_a2_rm3a", "Kill")

        EntFire("glass_pane_1_door_1", "KillHierarchy")
        EntFire("glass_pane_1_door_1_blocker", "Kill")
        EntFire("glass_shard", "Kill")
        EntFire("aud_ramp_break_glass", "Kill")

        EntFire("logic_drop_box", "Trigger")
        EntFire("trigger_dropbox", "Kill")
        break;
    case "sp_a3_transition01":
        FindBirb();
        EntFire("potatos_prop", "AddOutput", "targetname potato_powerup_prop");
        EntFire("sphere_entrance_potatos_button", "Unlock", "", 1)
        EntFire("sphere_entrance_potatos_button", "AddOutput", "OnPressed potato_powerup_prop:Kill::0:1")
        EntFire("sphere_entrance_potatos_button", "AddOutput", "OnPressed aud_alarm_beep_sm:StopSound::4:-1")
        EntFire("sphere_entrance_potatos_button", "AddOutput", "OnPressed "+self.GetName()+":RunScriptCode:UpgradeDashes(2):0:1")
        EntFire("timer_potato_particles", "Enable")
        EntFire("timer_potato_particles", "AddOutput", "OnTimer timer_potato_particles:SubtractFromTimer:1:0.01:-1")

        /*
        local eletrigger = Entities.FindByClassnameNearest("trigger_once", Vector(-2026,-128,-4088), 10)
        EntFireByHandle(eletrigger, "AddOutput", "targetname eletrigger", 0, null, null)
        EntFire("eletrigger", "Disable", "", 1);
        EntFire("sphere_entrance_potatos_button", "AddOutput", "OnPressed eletrigger:Enable::1:-1")
        */

        EntFire("exit_lift_doortop_movelinear", "SetPosition", 0.01, 1);
        EntFire("exit_lift_doorbottom_movelinear", "SetPosition", 0.01, 1);
        local eletrigger = Entities.FindByClassnameNearest("trigger_once", Vector(-2200,-128,-4088), 10)
        EntFireByHandle(eletrigger, "Kill", "", 0, null, null)
        EntFire("sphere_entrance_potatos_button", "AddOutput", "OnPressed exit_lift_doortop_movelinear:Open::1:-1")
        EntFire("sphere_entrance_potatos_button", "AddOutput", "OnPressed exit_lift_doorbottom_movelinear:Open::1:-1")
        EntFire("sphere_entrance_potatos_button", "AddOutput", "OnPressed blocking_hintsign:Kill::0:-1")

        //level up text
        EntFire( "@chapter_subtitle_text", "SetTextColor2", "210 210 210 255", 0.0 )
        EntFire( "@chapter_subtitle_text", "SetTextColor", "200 200 80 255", 0.0 )
        EntFire( "@chapter_subtitle_text", "SetPosY", "0.35", 0.0 )
        EntFire( "@chapter_subtitle_text", "settext", "LEVEL UP!", 0.0 )
        EntFire("sphere_entrance_potatos_button", "AddOutput", "OnPressed @chapter_subtitle_text:display::0:-1")

        //sign to block the intentional doors
        for(local i=0;i<2;i++){
            local sign = Entities.CreateByClassname("prop_dynamic_override");
            sign.SetModel("models/srmod/hintplank.mdl");
            sign.SetOrigin(Vector(-3276, 576, -4550 + i*100));
            sign.SetAngles(90,0,0);
            EntFireByHandle(sign, "AddOutput", "targetname blocking_hintsign", 0, null, null)
        }

        EntFire("celeste_window_fix", "Kill")

        //sing for idiots
        local sign1 = Entities.CreateByClassname("prop_dynamic_override");
        sign1.SetModel("models/srmod/hintplank.mdl");
        sign1.SetOrigin(Vector(-2160, -130, -4159));
        sign1.SetAngles(0,170,0);
        EntFireByHandle(sign1, "skin", "3", 0, null, null)
        EntFireByHandle(sign1, "AddOutput", "targetname blocking_hintsign", 0, null, null)

        break;
    case "sp_a1_intro5":
        local introcar = CreateProp("prop_physics", Vector(-400, -930, 668), "models/srmod/introcar.mdl", 1);
        EntFireByHandle(introcar, "AddOutput", "targetname introcar", 0, null, null)
        EntFireByHandle(introcar, "AddOutput", "solid 6", 0, null, null)
        introcar.SetAngles(0,225,0)
        print("INTRO CAAAR\n")
        break;
    case "sp_a2_bts1":
        local fakeBerryPos = Vector(352,-64,0);
        local fakeBerry = Entities.CreateByClassname("prop_dynamic_override");
        EntFireByHandle(fakeBerry, "AddOutput", "targetname jebaited", 0, null, null);
        EntFireByHandle(fakeBerry, "SetAnimation", "idle", 0, null, null);
        fakeBerry.SetModel("models/srmod/goldenberry.mdl");
        fakeBerry.SetOrigin(fakeBerryPos);
        local fakeBerry2 = Entities.CreateByClassname("prop_weighted_cube");
        fakeBerry2.SetModel("models/srmod/goldenberry.mdl");
        fakeBerry2.SetOrigin(fakeBerryPos);
        EntFireByHandle(fakeBerry2, "AddOutput", "targetname jebaited2", 0, null, null)
        EntFireByHandle(fakeBerry2, "DisableDraw", "", 0.5, null, null)
        EntFire("pre_solved_chamber-toxin_reveal_rl", "AddOutput", "OnTrigger jebaited:Disable::0:-1");
        EntFire("pre_solved_chamber-toxin_reveal_rl", "AddOutput", "OnTrigger jebaited2:EnableDraw::0:-1");
        EntFire("pre_solved_chamber-toxin_reveal_rl", "AddOutput", "OnTrigger jebaited2:Dissolve::0.01:-1");

        EntFire("jailbreak_chamber_lit-jailbreak_trigger", "AddOutput", "OnTrigger "+self.GetName()+":RunScriptCode:hintState++:0:1");
        break;
    case "sp_a2_triple_laser":
        //dirty hack for golden
        local camera = Entities.CreateByClassname("npc_security_camera")
        EntFireByHandle(camera, "AddOutput", "targetname security_camera",0,null,null)
        camera.SetModel("models/props/security_camera.mdl");
        camera.SetOrigin(Vector(7420-20, -5732-12, 100+20));
        EntFire("berry_1", "SetParent", "security_camera", 0.01)
        EntFire("security_camera", "Enable")
        EntFire("security_camera", "DisableDraw", "", 0.01)
        EntFire("security_camera", "Disable", "", 0.01)
        break;
    case "sp_a2_core":
        EntFire("death_fade", "Kill");
        break;
    case "sp_a4_finale4":
        EntFire("ending_suction_relay", "AddOutput", "OnTrigger "+self.GetName()+":RunScriptCode:ForceBerryDisplay(1):10:1")
        EntFire("ending_suction_relay", "AddOutput", "OnTrigger "+self.GetName()+":RunScriptCode:ForceBerryDisplay(0):15:1")
        EntFire("ending_suction_relay", "AddOutput", "OnTrigger @command:Command:changelevel celeste_moonroom:15.5:1")
        break;
    }

    UpgradeDashes(dashes);
    CreateBerries();

    if(smsm.GetModeParam(ModeParams.WarpToMoonRoom)){
        MapPlayOrder = ["", GetMapName(), "celeste_moonroom"];
    }
}

rainbowColorState <- 0;
previousDashing <- 0;
staminaAnimTimer <- 0;
hintState <- 0

function CelesteUpdate(){
    
    UpdateIndicatorDiode();
    UpdateStaminaCover();

    local dashing = smsm.GetModeParam(ModeParams.Dashing);

    local makeSound = dashing>previousDashing;
    if(makeSound){
        self.EmitSound("celeste.dash")
    } 
    previousDashing=dashing;

    if(IsBirbMap)UpdateBirb();

    UpdateBerries();

    UpdateHints();
}

function UpdateHints(){
    if(GetMapName()=="sp_a1_intro1" && hintState < 2){
        local o = GetPlayer().GetOrigin();
        if(hintState==0 && o.y < 4200 && o.x > -1348 && o.z < 2900){
            EntFire("climb_hint", "ShowHint");
            hintState++;
        }else if(hintState==1 && o.y > 4360 && o.x < -1348){
            hintState++;
            EntFire("climb_hint", "EndHint")
        }
    }
    if(GetMapName()=="sp_a1_intro3" && hintState < 2){
        if(hintState==0 && smsm.GetModeParam(ModeParams.MaxDashes)>0){
            EntFire("dash_hint", "ShowHint");
            hintState++;
        }else if(hintState==1 && smsm.GetModeParam(ModeParams.Dashing)>0){
            hintState++;
            EntFire("dash_hint", "EndHint")
        }
    }

    //not really a hint, but I'm gonna use this system anyway lmao
    if(GetMapName()=="sp_a2_dual_lasers" && hintState < 2){
        if(hintState==0 && BERRIES["sp_a2_dual_lasers"][0].collected){
            if(!("entity" in BERRIES["sp_a2_dual_lasers"][0])){
                hintState+=2;
            }else{
                SendToConsole("portal_place 1 0 92 64 1288 -90 -180 0; portal_place 1 1 92 64 1280 90 0 0")
                hintState++;
                modlog("Secret unlocked. Created helping portals.")
            }
        }else if(hintState==1){
            local po = GetPlayer().GetOrigin();
            local vec = Vector(92,64,1280);
            po.z += GetPlayer().GetBoundingMaxs().z / 2;
            if(po.z<1280 && (po-vec).Length()<128){
                local portal = null;
                while(portal = Entities.FindByClassnameWithin(portal, "prop_portal", vec, 10)){
                    EntFireByHandle(portal, "Kill", "", 0, null, null)
                }
                hintState++;
                modlog("Killing helping portals.")
            }
        }
    }
    if(GetMapName()=="sp_a2_bts1" && hintState == 1){
        if(!BERRIES["sp_a2_bts1"][0].collected){
            BERRIES["sp_a2_bts1"][0].pos.x = -3360;
            BERRIES["sp_a2_bts1"][0].entity.SetOrigin(BERRIES["sp_a2_bts1"][0].pos);
        }
        hintState=2;
    }
}


function UpdateStaminaCover(){
    local stamina = smsm.GetModeParam(ModeParams.StaminaLeft);
    local colorAlpha = 0;
    if(stamina<50){
        local animSpeed = 0.4
        if(stamina<=0) animSpeed = 1.2;
        staminaAnimTimer = staminaAnimTimer+animSpeed;

        colorAlpha = (50-stamina)/50 * 130 * ((cos(staminaAnimTimer)+1.0)/2.0)
    }
    smsm.SetScreenCoverColor(80,20,20,colorAlpha);
    //print("Stamina:"+stamina+"\n");
}

function UpdateIndicatorDiode(){
    local color = Vector(1,1,1);
    local dashesLeft = smsm.GetModeParam(ModeParams.DashesLeft);
    if(dashesLeft>2){
        rainbowColorState += 10;
        local r = (rainbowColorState%765)
        local g = ((rainbowColorState+255)%765)
        local b = ((rainbowColorState+510)%765)
        if(r>255)r = 510-r; if(g>255)g = 510-g; if(b>255)b = 510-b;
        if(r<0)r = 0; if(g<0)g = 0; if(b<0)b = 0;
        color = Vector(r,g,b);
    }else if(dashesLeft==2){
        color = Vector(150,75,255)
    }else if(dashesLeft==1){
        color = Vector(255,40,0)
    }
    
    smsm.SetPortalGunIndicatorColor(color);
}

function UpgradeDashes(dashes){
    smsm.SetModeParam(ModeParams.MaxDashes, dashes);
}

function ForceBerryDisplay(force){
    smsm.SetModeParam(ModeParams.DisplayBerriesForce, force)
}











///////////////////////////////////
//moved from celeste_moonroom.nut//
///////////////////////////////////

//i really need to refactor this code in the future

if(GetMapName()=="celeste_moonroom"){
    OriginalCelesteUpdate <- CelesteUpdate;
    function CelesteUpdate(){
        OriginalCelesteUpdate();
        if(!WowDisplayed && BERRIES_counter == BERRIES_max && BERRIES_max!=0){
            DisplayWow();
            print(BERRIES_counter + "," +BERRIES_max+"\n")
        }
    }


    //word display functions
    LETTERS <- [];

    FONT <- " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.'/()-_+=?,:[]{}*#";
    FONT_LOOKUP <- {};
    foreach(i,fontLetter in FONT){
        FONT_LOOKUP[fontLetter] <- i;
    }
    FONT_W <- [0.7,1,1,1,1,0.8,0.8,1,1,0.5,0.5,1,0.9,1.1,1,1,1,1,1,0.9,0.8,1,1,1.1,0.9,0.9,1, //uppercase letters
               0.9,0.8,0.9,0.9,0.9,0.7,1,1,0.5,0.5,0.9,0.6,1.1,0.8,0.9,0.85,1,0.7,0.8,0.7,0.9,0.9,1.1,0.8,0.9,0.9, //lowercase letters
               0.9,0.7,0.9,0.9,0.9,0.9,0.9,0.9,0.9,0.9, //numbers
               0.5,0.5,0.5,0.5,0.5,1,1,1,1,0.7,0.5,0.5, //characters
               1,1,1,1,1,1]; //berries

    LETTER_MAKER <- EntityGroup[0];

    function DisplayClear(){
        local ent = null;
        while(ent = Entities.FindByName(ent, "letter_brush*"))EntFireByHandle(ent,"Kill","",0,null,null);
        ent = null;
        while(ent = Entities.FindByName(ent, "letter_toggle*"))EntFireByHandle(ent,"Kill","",0,null,null);
    }

    function DisplayUpdateLetter(id, x,y,z,letter,r,g,b){
        local letterEnt = Entities.FindByNameNearest("letter_brush*", Vector(x,y,z), 16);
        local letterSuffix = id;
        local letterToggle = Entities.FindByNameNearest("letter_toggle*", Vector(x,y,z), 16);
        EntFireByHandle(letterEnt,"Color",floor(r*255)+" "+floor(g*255)+" "+floor(b*255),0,null,null);
        //EntFireByHandle(letterToggle,"AddOutput","targetname letter_toggle"+letterSuffix,0,null,null);
        //EntFireByHandle(letterToggle, "AddOutput", "target letter"+letterSuffix,0,null,null);
        EntFireByHandle(letterToggle, "SetTextureIndex", letter+"",0,null,null);
    }

    function DisplayWord(x, y, z, word, color=Vector(1,1,1), scale=1.0){
        local xpos = x;
        foreach(i,letter in word){
            local f = 0;
            if(letter in FONT_LOOKUP)f = FONT_LOOKUP[letter];
            local letterPos = LETTER_MAKER.GetOrigin()+Vector(xpos*16,-y*16,z);
            LETTER_MAKER.SpawnEntityAtLocation(letterPos, Vector(0,0,0));
            EntFireByHandle(self, "RunScriptCode", "DisplayUpdateLetter("+i+","+letterPos.x+","+letterPos.y+","+letterPos.z+","+f+","+color.x+","+color.y+","+color.z+")", 0.00, null, null);
            xpos += FONT_W[f] * scale;
        }
    }



    //screen display functions

    MAPS <- [
        {filename="sp_a1_intro1",name="Container Ride"},
        {filename="sp_a1_intro2",name="Portal Carousel"},
        {filename="sp_a1_intro3",name="Portal Gun"},
        {filename="sp_a1_intro4",name="Smooth Jazz"},
        {filename="sp_a1_intro5",name="Cube Momentum"},
        {filename="sp_a1_intro6",name="Future Starter"},
        {filename="sp_a1_intro7",name="Secret Panel"},
        {filename="sp_a1_wakeup",name="Wakeup"},
        {filename="sp_a2_intro",name="Incinerator"},
        {filename="sp_a2_laser_intro",name="Laser Intro"},
        {filename="sp_a2_laser_stairs",name="Laser Stairs"},
        {filename="sp_a2_dual_lasers",name="Dual Lasers"},
        {filename="sp_a2_laser_over_goo",name="Laser Over Goo"},
        {filename="sp_a2_catapult_intro",name="Catapult Intro"},
        {filename="sp_a2_trust_fling",name="Trust Fling"},
        {filename="sp_a2_pit_flings",name="Pit Flings"},
        {filename="sp_a2_fizzler_intro",name="Fizzler Intro"},
        {filename="sp_a2_sphere_peek",name="Ceiling Catapult"},
        {filename="sp_a2_ricochet",name="Ricochet"},
        {filename="sp_a2_bridge_intro",name="Bridge Intro"},
        {filename="sp_a2_bridge_the_gap",name="Bridge The Gap"},
        {filename="sp_a2_turret_intro",name="Turret Intro"},
        {filename="sp_a2_laser_relays",name="Laser Relays"},
        {filename="sp_a2_turret_blocker",name="Turret Blocker"},
        {filename="sp_a2_laser_vs_turret",name="Laser Vs Turret"},
        {filename="sp_a2_pull_the_rug",name="Pull The Rug"},
        {filename="sp_a2_column_blocker",name="Column Blocker"},
        {filename="sp_a2_laser_chaining",name="Laser Chaining"},
        {filename="sp_a2_triple_laser",name="Triple Laser"},
        {filename="sp_a2_bts1",name="Jailbreak"},
        {filename="sp_a2_bts2",name="Escape"},
        {filename="sp_a2_bts3",name="Turret Factory"},
        {filename="sp_a2_bts4",name="Turret Sabotage"},
        {filename="sp_a2_bts5",name="Neurotoxin Sabotage"},
        {filename="sp_a2_core",name="Core"},
        {filename="sp_a3_01",name="Underground"},
        {filename="sp_a3_03",name="Cave Johnson"},
        {filename="sp_a3_jump_intro",name="Repulsion Intro"},
        {filename="sp_a3_bomb_flings",name="Bomb Flings"},
        {filename="sp_a3_crazy_box",name="Crazy Box"},
        {filename="sp_a3_transition01",name="PotatOS"},
        {filename="sp_a3_speed_ramp",name="Propulsion Intro"},
        {filename="sp_a3_speed_flings",name="Propulsion Flings"},
        {filename="sp_a3_portal_intro",name="Conversion Intro"},
        {filename="sp_a3_end",name="Three Gels"},
        {filename="sp_a4_intro",name="Test"},
        {filename="sp_a4_tb_intro",name="Funnel Intro"},
        {filename="sp_a4_tb_trust_drop",name="Ceiling Button"},
        {filename="sp_a4_tb_wall_button",name="Wall Button"},
        {filename="sp_a4_tb_polarity",name="Polarity"},
        {filename="sp_a4_tb_catch",name="Funnel Catch"},
        {filename="sp_a4_stop_the_box",name="Stop The Box"},
        {filename="sp_a4_laser_catapult",name="Laser Catapult"},
        {filename="sp_a4_laser_platform",name="Laser Platform"},
        {filename="sp_a4_speed_tb_catch",name="Propulsion Catch"},
        {filename="sp_a4_jump_polarity",name="Repulsion Polarity"},
        {filename="sp_a4_finale1",name="Finale 1"},
        {filename="sp_a4_finale2",name="Finale 2"},
        {filename="sp_a4_finale3",name="Finale 3"},
        {filename="sp_a4_finale4",name="Finale 4"},
        {filename="celeste_moonroom",name="Moon Room"},
    ];


    CURRENT_MAP <- -1;

    function DisplayBerryList(mapID){
        DisplayClear();
        local map = {filename="???",name="(undefined)"};
        if(mapID>=0 && mapID<MAPS.len())map = MAPS[mapID];
        DisplayWord(-11,-5.3,50,(map.name+":"));
        if(map.filename in BERRIES){
            foreach(i,berry in BERRIES[map.filename]){
            local color = Vector(1,1,0.6);
            if(!berry.collected)color = Vector(0.5,0.5,0.5);
            local scale = 1;
            if(berry.name.len()>25)scale=0.9;
            DisplayWord(-11.5,-4.5+i*1.6,0,berry.name, color, scale);
            //[]{}*#
            local berryChar = "[";
            if(berry.collected){
                if(berry.golden)berryChar = "#";
                else if(berry.quantum)berryChar = "}";
                else berryChar = "]";
            }else{
                if(berry.golden)berryChar = "*";
                else if(berry.quantum)berryChar = "{";
            }
            DisplayWord(-9.8,-3.6+i*1.2,60,berryChar);
            }
        }else{
            DisplayWord(-11.5,-4.5,0,"(no berries detected)", Vector(0.5, 0.5, 0.5));
        }
        CURRENT_MAP = mapID;
    }

    BerryScanningInProgress <- false;

    function DisplayPrevBerryList(){
        if(BerryScanningInProgress)return;
        CURRENT_MAP--;
        if(CURRENT_MAP<0)CURRENT_MAP=0;
        DisplayBerryList(CURRENT_MAP);
    }

    function DisplayNextBerryList(){
        if(BerryScanningInProgress)return;
        CURRENT_MAP++;
        if(CURRENT_MAP>=MAPS.len())CURRENT_MAP=MAPS.len()-1;
        DisplayBerryList(CURRENT_MAP);
    }

    function DisplayTestScreen(){
        DisplayClear();
        DisplayWord(-13,-4,0,"ABCDEFGHIJKLMNOPQRSTUVWXYZ");
        DisplayWord(-13,-2,0,"abcdefghijklmnopqrstuvwxyz");
        DisplayWord(-13,0,0,"0123456789");
        DisplayWord(-13,2,0,".'/()-_+=?,:");
        DisplayWord(-13,4,0,"[]{}*#");
    }

    function DisplayBerryOSLogo(){
        DisplayClear();
        DisplayWord(-3.8,-1.5,150,"Berry",Vector(1,0.2,0.2));
        DisplayWord(0.4,-1.5,150,"OS");
        DisplayWord(1.5,-1.2,190,"]");
        DisplayWord(-13.1,3,0,"Your Personal Berry Collection Assistant",Vector(1,1,1), 0.85);
    }

    function DisplayUnlockProgress(state){
        if(WowDisplayed)return;
        DisplayClear();
        BerryScanningInProgress = (state != 7);
        local texts = [
            "Initiating berry count...",
            "Counting red berries...",
            "Red berries counted.",
            "Counting quantum berries...",
            "Quantum berries counted.",
            "Counting golden berries...",
            "Golden berries counted.",
            "Counting completed."
        ];
        DisplayWord(-10,-5,50,texts[state]);

        if(state>=1){
            DisplayWord(-3,-1.5,140,"]");
            if(state>=2){
            local countText = "x "+BERRIES_count_red_collected+" / "+BERRIES_count_red;
            local color = Vector(1,1,1);
            if(state>=3){
                if(BERRIES_count_red_collected==BERRIES_count_red)color=Vector(0.5,1,0.5);
                else color=Vector(1,0.5,0.5);
            }
            DisplayWord(-3,-2.2,50,countText,color);
            }
        }
        if(state>=3){
            DisplayWord(-3,-0.1,140,"}");
            if(state>=4){
            local countText = "x "+BERRIES_count_quantum_collected+" / "+BERRIES_count_quantum;
            local color = Vector(1,1,1);
            if(state>=5){
                if(BERRIES_count_quantum_collected==BERRIES_count_quantum)color=Vector(0.5,1,0.5);
                else color=Vector(1,0.5,0.5);
            }
            DisplayWord(-3,0.4,50,countText,color);
            }
        } 
        if(state>=5){
            DisplayWord(-3,1.3,140,"#");
            if(state>=6){
            local countText = "x "+BERRIES_count_golden_collected+" / "+BERRIES_count_golden;
            local color = Vector(1,1,1);
            if(state>=7){
                if(BERRIES_count_golden_collected==BERRIES_count_golden)color=Vector(0.5,1,0.5);
                else color=Vector(1,0.5,0.5);
            }
            DisplayWord(-3,3.2,50,countText,color);
            }
        }
        UnlockChambers(state);
    }

    AlreadyUnlocked <- false;

    function UnlockChambers(state){
        local entToCall = null;
        local sound = 0;
        if(state==3){
            entToCall = "chamber1_";
            if(BERRIES_count_red_collected==BERRIES_count_red)entToCall += "success";
            else entToCall += "failure";
        }
        if(state==5){
            entToCall = "chamber2_";
            if(BERRIES_count_quantum_collected==BERRIES_count_quantum)entToCall += "success";
            else entToCall += "failure";
        }
        if(state==7){
            entToCall = "chamber3_";
            if(BERRIES_count_golden_collected==BERRIES_count_golden)entToCall += "success";
            else entToCall += "failure";
        }
        if(entToCall && !AlreadyUnlocked)EntFire(entToCall, "Trigger");
        else EntFire("computer_count", "PlaySound");
        
        if(state==7)AlreadyUnlocked = true;
    }

    WowDisplayed <- false;
    function DisplayWow(){
        DisplayClear();
        DisplayWord(-1.5,-0.8,200,"W",Vector(1,0.5,0));
        DisplayWord(-0.3,-0.8,210,"]");
        DisplayWord(0.9,-0.8,200,"W",Vector(0,0.5,1));
        WowDisplayed = true;
        BerryScanningInProgress = true;
        EntFire("computer_wee", "PlaySound");
    }

    //DisplayUnlockProgress(7);
    //DisplayTestScreen();
    DisplayBerryOSLogo();
    //DisplayWow();


    //warping functions
    WARPING_MAP <- "";

    function DisplayWarpLocation(){
        DisplayClear();
        if(WARPING_MAP != ""){
            DisplayWord(-7.2,-3.5,100,"Warper activated.");
            local mapname = "";
            foreach(i,m in MAPS){
                if(m.filename==WARPING_MAP){
                    mapname = m.name;
                    break;
                }
            }
            DisplayWord(-10,-2,50,"Location: ");
            DisplayWord(-2.5,-2,50,mapname,Vector(1,1,0.5));

            //drawing berries
            foreach(i, berry in BERRIES[WARPING_MAP]){
                local berryChar = "[";
                if(berry.collected){
                    if(berry.golden)berryChar = "#";
                    else if(berry.quantum)berryChar = "}";
                    else berryChar = "]";
                }else{
                    if(berry.golden)berryChar = "*";
                    else if(berry.quantum)berryChar = "{";
                }
                DisplayWord(-4.5+i,0.5,150,berryChar);
            }
            

        }else{
            DisplayWord(-10.5,-2,50,"Warper cannot be activated.", Vector(1,0.5,0.5));
            DisplayWord(-14,0,0,"Berry Search Exeption: All berries found.", Vector(1,0.6,0.6), 0.9);
        }
        
    }

    function CheckWarperEntry(){
        if(smsm.GetModeParam(ModeParams.WarpToMoonRoom)){
            EntFire("end_warp", "Trigger");

            local introcar = CreateProp("prop_physics", Vector(-200, -264, -880), "models/srmod/introcar.mdl", 1);
            EntFireByHandle(introcar, "AddOutput", "targetname introcar", 0, null, null)
            EntFireByHandle(introcar, "AddOutput", "solid 6", 0, null, null)
            introcar.SetAngles(5,225,-5)
        }
        //from now on, always fix map list to allow returning to moon room
        smsm.SetModeParam(ModeParams.WarpToMoonRoom, 1);
    }

    function RequestLevelWarp(){
        if(BerryScanningInProgress)return;
        local unfinishedMaps = {};
        local mapCount = 0;
        local currentMap = -1;
        foreach( i, map in MAPS){
            if(map.filename!="celeste_moonroom" && map.filename in BERRIES)foreach(index, berry in BERRIES[map.filename]){
                if(!berry.collected){
                    unfinishedMaps[mapCount] <- map.filename;
                    if(map.filename==WARPING_MAP)currentMap = mapCount;
                    mapCount++;
                    break;
                }
            }
        }
        if(currentMap>=mapCount-1)currentMap = -1;
        if(mapCount > 0){
            WARPING_MAP = unfinishedMaps[currentMap+1];
            EntFire("warper_prepare", "Trigger");
        }

        DisplayWarpLocation();
    }

    function WarpToLevel(){
        SendToConsole("changelevel "+WARPING_MAP);
    }
}



AddModeFunctions("celeste", CelestePostSpawn, CelesteLoad, CelesteUpdate, CelestePrecache)