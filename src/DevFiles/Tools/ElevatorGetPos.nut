vecx <- Entities.FindByName(null, "blue").GetOrigin().x
vecy <- Entities.FindByName(null, "blue").GetOrigin().y
vecz <- Entities.FindByName(null, "blue").GetOrigin().z + 100

printl("            // Elevator changelevel")
printl("            local p = null")
printl("            while(p = Entities.FindByClassnameWithin(p, \"player\", Vector(" + vecx + ", " + vecy + ", " + vecz + "), 50)) {")
printl("                SendToConsole(\"commentary 1\")")
printl("                SendToConsole(\"changelevel LEVELNAME\")")
printl("            }")