function FinishFutBolSpawn(targetname, position) {
    local ent = null
    while (ent = Entities.FindByClassname(ent, "prop_glass_futbol")) {
        if (ent.GetName() == "") {
            ent.__KeyValueFromString("targetname", targetname)
            ent.SetOrigin(position)
            printl("FinishFutBolSpawn: " + targetname + " at " + position)
        }
    }
}

function SpawnFutBol(targetname, position) {
    SendToConsoleP232("sv_cheats 1; ent_create prop_glass_futbol; sv_cheats 0")
    SendToConsoleP232("script FinishFutBolSpawn(\"" + targetname + " \", Vector(" + position.x + ", " + position.y + ", " + position.z + "))")
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
            printl("CheckFutBolGoal: " + team + " goal!")
            return true
        }
    } else {
        local ent = null
        while (ent = Entities.FindByClassnameWithin(ent, "prop_glass_futbol", goalpoint, 5)) {
            if (ent == filter) {
                    printl("CheckFutBolGoal: " + team + " goal!")
                    return true
            }
        }
    }

    return false
}