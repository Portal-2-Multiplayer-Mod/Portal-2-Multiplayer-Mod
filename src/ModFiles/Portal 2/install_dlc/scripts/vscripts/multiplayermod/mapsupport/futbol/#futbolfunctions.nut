desiredscore <- 10

futent <- null
CurrentlySpawningFutBol <- false
CanSpawnFutBol <- true
GameRunning <- false

class FutBolTeams {
    m_nBluescore = 0
    m_nRedscore = 0
}

function SpawnFutBol(targetname, position) {
    EntFire("p2mm_servercommand", "command", "sv_cheats 1; ent_create prop_glass_futbol; sv_cheats 0")
    EntFire("p2mm_servercommand", "command", "script FinishFutBolSpawn(\"" + targetname + " \", Vector(" + position.x + ", " + position.y + ", " + position.z + "))")
}

function FinishFutBolSpawn(targetname, position) {
    local ent = null
    while (ent = Entities.FindByClassname(ent, "prop_glass_futbol")) {
        if (ent.GetName() == "") {
            ent.__KeyValueFromString("targetname", targetname)
            ent.SetOrigin(position)
            printlP2MM("FinishFutBolSpawn: " + targetname + " at " + position)
        }
    }
}

function GetGoalPoint(prop) {
    return prop.GetOrigin() + prop.GetLeftVector() * 40 + prop.GetUpVector() * 10
}

function CheckFutBolGoal(team, prop, filter = "all") {
    // DebugDrawBox(Vector origin, Vector mins, Vector maxs, int r, int g, int b, int alpha, float duration)
    // Draw a debug box around the goal
    local goalpoint = GetGoalPoint(prop)
    DebugDrawBox(goalpoint, Vector(-10, -10, -10), Vector(10, 10, 10), 255, 255, 255, 255, 0.5)

    if (filter == "all") {
        if (Entities.FindByClassnameNearest("prop_glass_futbol", goalpoint, 5)) {
            printlP2MM("CheckFutBolGoal: " + team + " goal!")
            return true
        }
    } else {
        local ent = null
        while (ent = Entities.FindByClassnameWithin(ent, "prop_glass_futbol", goalpoint, 5)) {
            if (ent == filter) {
                    printlP2MM("CheckFutBolGoal: " + team + " goal!")
                    return true
            }
        }
    }

    return false
}

// TODO: rework this to not take this many args but still work globally lol
function StartGame(blue_pos_x, blue_pos_y, blue_pos_z, blue_ang_x, blue_ang_y, blue_ang_z, red_pos_x, red_pos_y, red_pos_z, red_ang_x, red_ang_y, red_ang_z) {
    GameRunning = true
    local p = null
    while (p = Entities.FindByClassname(p, "player")) {
        if (p.GetTeam() == TEAM_BLUE) {
            p.SetOrigin(Vector(blue_pos_x, blue_pos_y, blue_pos_z))
            p.SetAngles(blue_ang_x, blue_ang_y, blue_ang_z)
        } else {
            p.SetOrigin(Vector(red_pos_x, red_pos_y, red_pos_z))
            p.SetAngles(red_ang_x, red_ang_y, red_ang_z)
        }
    }
}