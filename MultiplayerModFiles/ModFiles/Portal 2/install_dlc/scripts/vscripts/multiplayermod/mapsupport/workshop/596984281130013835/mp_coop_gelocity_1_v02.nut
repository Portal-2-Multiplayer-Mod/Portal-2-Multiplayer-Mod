// ███╗   ███╗ █████╗ ██████╗ ███╗  ██╗ █████╗ ███╗   ███╗███████╗
// ████╗ ████║██╔══██╗██╔══██╗████╗ ██║██╔══██╗████╗ ████║██╔════╝
// ██╔████╔██║███████║██████╔╝██╔██╗██║███████║██╔████╔██║█████╗
// ██║╚██╔╝██║██╔══██║██╔═══╝ ██║╚████║██╔══██║██║╚██╔╝██║██╔══╝
// ██║ ╚═╝ ██║██║  ██║██║     ██║ ╚███║██║  ██║██║ ╚═╝ ██║███████╗
// ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚══╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝

moveplayer <- false
movespeed <- 6
ourvec <- Vector(0, 0, 0)
pointdistanceapart <- 0
angdistance <- 0

TrackPoints <- [
    
]

TrackAngles <- [
    
]

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        Entities.CreateByClassname("point_viewcontrol").__KeyValueFromString("targetname", "spectatorcammpmod")
        Entities.FindByName(null, "spectatorcammpmod").__KeyValueFromString("target_team", "-1")
        Entities.FindByName(null, "spectatorcammpmod").__KeyValueFromString("fov", "100")
    }

    if (MSPostPlayerSpawn==true) {

    }

    if (MSLoop==true) {
        if (moveplayer == true) {
            if (Entities.FindByName(null, "red")) {
                    
                local output = MoveEntityOnTrack(Entities.FindByName(null, "red"), TrackPoints, movespeed)
                
                local p = Entities.FindByName(null, "red")
                if (output != false) {
                    if (output != true) {
                        ourvec = TrackAngles[output + 1]
                        pointdistanceapart = GetDistanceScore(TrackPoints[output], TrackPoints[output + 1])
                        angdistance = GetDistanceScore(p.GetAngles(), TrackAngles[output + 1])
                    } else {
                        ourvec = TrackAngles[0]
                        pointdistanceapart = GetDistanceScore(TrackPoints[0], TrackPoints[1])
                        angdistance = GetDistanceScore(p.GetAngles(), TrackAngles[0])
                    }
                }
                local newangoffset = GetDirectionalOffset(p.GetAngles(), ourvec)
                newangoffset = MultiplyVector(newangoffset, (((movespeed) * (angdistance / 180)) / (pointdistanceapart / 180)))
                printl(newangoffset)
                printl(GetDistanceScore(p.GetAngles(), ourvec))
                if (GetDistanceScore(p.GetAngles(), ourvec) > (movespeed / 6) * 1.6) {
                    p.SetAngles(p.GetAngles().x - newangoffset.x, p.GetAngles().y - newangoffset.y, p.GetAngles().z - newangoffset.z)
                }
            }
        }
    }
}