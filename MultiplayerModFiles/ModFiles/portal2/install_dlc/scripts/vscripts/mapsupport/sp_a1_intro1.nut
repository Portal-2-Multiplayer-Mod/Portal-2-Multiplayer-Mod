// ███╗   ███╗ █████╗ ██████╗ ███╗  ██╗ █████╗ ███╗   ███╗███████╗
// ████╗ ████║██╔══██╗██╔══██╗████╗ ██║██╔══██╗████╗ ████║██╔════╝
// ██╔████╔██║███████║██████╔╝██╔██╗██║███████║██╔████╔██║█████╗
// ██║╚██╔╝██║██╔══██║██╔═══╝ ██║╚████║██╔══██║██║╚██╔╝██║██╔══╝
// ██║ ╚═╝ ██║██║  ██║██║     ██║ ╚███║██║  ██║██║ ╚═╝ ██║███████╗
// ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚══╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝

function MapSupport(MSInstantRun, MSLoop, MSPostPlayerSpawn, MSPostMapSpawn, MSOnPlayerJoin, MSOnDeath, MSOnRespawn) {
    if (MSInstantRun==true) {
        CustomBrush1 <- false
        CustomBrush1Cache <- false
    }

    if (MSPostPlayerSpawn==true) {
        // CustomBrush1
        CustomBrush1 <- Entities.CreateByClassname("func_brush")
        CustomBrush1.SetOrigin(Vector(-5746.623046875, 1778.7027587891, 194.95379638672))
        CustomBrush1.SetSize(Vector(0, 0 ,0), Vector(87.01123046875, 136.28967285156, 51.549301147461))
        CustomBrush1.__KeyValueFromInt("Solid", 3)
        CustomBrush1.__KeyValueFromString("targetname", "CustomBrush1")
        DebugDrawBox(CustomBrush1.GetOrigin(), CustomBrush1.GetBoundingMins(), CustomBrush1.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush2
        CustomBrush2 <- Entities.CreateByClassname("func_brush")
        CustomBrush2.SetOrigin(Vector(-6042.2216796875, 1783.7899169922, 171.91059875488))
        CustomBrush2.SetSize(Vector(0, 0 ,0), Vector(550.02978515625, 266.28076171875, 48.8125))
        CustomBrush2.__KeyValueFromInt("Solid", 3)
        CustomBrush2.__KeyValueFromString("targetname", "CustomBrush2")
        DebugDrawBox(CustomBrush2.GetOrigin(), CustomBrush2.GetBoundingMins(), CustomBrush2.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush3
        CustomBrush3 <- Entities.CreateByClassname("func_brush")
        CustomBrush3.SetOrigin(Vector(-5973.8920898438, 1764.6313476562, 203.77949523926))
        CustomBrush3.SetSize(Vector(0, 0 ,0), Vector(491.03125, 50.630981445312, 153.08879089355))
        CustomBrush3.__KeyValueFromInt("Solid", 3)
        CustomBrush3.__KeyValueFromString("targetname", "CustomBrush3")
        DebugDrawBox(CustomBrush3.GetOrigin(), CustomBrush3.GetBoundingMins(), CustomBrush3.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush4
        CustomBrush4 <- Entities.CreateByClassname("func_brush")
        CustomBrush4.SetOrigin(Vector(-6003.9296875, 1777.9016113281, 346.05218505859))
        CustomBrush4.SetSize(Vector(0, 0 ,0), Vector(542.7041015625, 239.28088378906, 70.41552734375))
        CustomBrush4.__KeyValueFromInt("Solid", 3)
        CustomBrush4.__KeyValueFromString("targetname", "CustomBrush4")
        DebugDrawBox(CustomBrush4.GetOrigin(), CustomBrush4.GetBoundingMins(), CustomBrush4.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush5
        CustomBrush5 <- Entities.CreateByClassname("func_brush")
        CustomBrush5.SetOrigin(Vector(-5973.0200195312, 1791.1186523438, 193.61361694336))
        CustomBrush5.SetSize(Vector(0, 0 ,0), Vector(126.4052734375, 149.34594726562, 185.86248779297))
        CustomBrush5.__KeyValueFromInt("Solid", 3)
        CustomBrush5.__KeyValueFromString("targetname", "CustomBrush5")
        DebugDrawBox(CustomBrush5.GetOrigin(), CustomBrush5.GetBoundingMins(), CustomBrush5.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush6
        CustomBrush6 <- Entities.CreateByClassname("func_brush")
        CustomBrush6.SetOrigin(Vector(-6007.9018554688, 2011.3055419922, 195.1164855957))
        CustomBrush6.SetSize(Vector(0, 0 ,0), Vector(546.029296875, 46.874267578125, 179.13430786133))
        CustomBrush6.__KeyValueFromInt("Solid", 3)
        CustomBrush6.__KeyValueFromString("targetname", "CustomBrush6")
        CustomBrush6 <- Entities.FindByName(null, "CustomBrush6")
        DebugDrawBox(CustomBrush6.GetOrigin(), CustomBrush6.GetBoundingMins(), CustomBrush6.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush7
        CustomBrush7 <- Entities.CreateByClassname("func_brush")
        CustomBrush7.SetOrigin(Vector(-5801.7231445312, 1968.4986572266, 196.52439880371))
        CustomBrush7.SetSize(Vector(0, 0 ,0), Vector(125.62890625, 53.184814453125, 101.9672088623))
        CustomBrush7.__KeyValueFromInt("Solid", 3)
        CustomBrush7.__KeyValueFromString("targetname", "CustomBrush7")
        DebugDrawBox(CustomBrush7.GetOrigin(), CustomBrush7.GetBoundingMins(), CustomBrush7.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush8
        CustomBrush8 <- Entities.CreateByClassname("func_brush")
        CustomBrush8.SetOrigin(Vector(-6030.4404296875, 1760.5928955078, 193.29339599609))
        CustomBrush8.SetSize(Vector(0, 0 ,0), Vector(49.1484375, 259.24450683594, 192.57360839844))
        CustomBrush8.__KeyValueFromInt("Solid", 3)
        CustomBrush8.__KeyValueFromString("targetname", "CustomBrush8")
        DebugDrawBox(CustomBrush8.GetOrigin(), CustomBrush8.GetBoundingMins(), CustomBrush8.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush9
        CustomBrush9 <- Entities.CreateByClassname("func_brush")
        CustomBrush9.SetOrigin(Vector(-5580.380859375, 1943.3970947266, 186.30889892578))
        CustomBrush9.SetSize(Vector(0, 0 ,0), Vector(74.576171875, 91.832641601562, 55.819595336914))
        CustomBrush9.__KeyValueFromInt("Solid", 3)
        CustomBrush9.__KeyValueFromString("targetname", "CustomBrush9")
        DebugDrawBox(CustomBrush9.GetOrigin(), CustomBrush9.GetBoundingMins(), CustomBrush9.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush10
        CustomBrush10 <- Entities.CreateByClassname("func_brush")
        CustomBrush10.SetOrigin(Vector(-5594.9174804688, 1773.0458984375, 162.32829284668))
        CustomBrush10.SetSize(Vector(0, 0 ,0), Vector(100.14599609375, 89.349365234375, 94.880722045898))
        CustomBrush10.__KeyValueFromInt("Solid", 3)
        CustomBrush10.__KeyValueFromString("targetname", "CustomBrush10")
        DebugDrawBox(CustomBrush10.GetOrigin(), CustomBrush10.GetBoundingMins(), CustomBrush10.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush11
        CustomBrush11 <- Entities.CreateByClassname("func_brush")
        CustomBrush11.SetOrigin(Vector(-5525.6733398438, 1764.2416992188, 204.33180236816))
        CustomBrush11.SetSize(Vector(0, 0 ,0), Vector(64.3701171875, 257.22619628906, 168.0611114502))
        CustomBrush11.__KeyValueFromInt("Solid", 3)
        CustomBrush11.__KeyValueFromString("targetname", "CustomBrush11")
        DebugDrawBox(CustomBrush11.GetOrigin(), CustomBrush11.GetBoundingMins(), CustomBrush11.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)

        // CustomBrush12
        CustomBrush12 <- Entities.CreateByClassname("func_brush")
        CustomBrush12.SetOrigin(Vector(-5972.2534179688, 1785.1105957031, 181.52520751953))
        CustomBrush12.SetSize(Vector(0, 0 ,0), Vector(154.63916015625, 102.44201660156, 181.24530029297))
        CustomBrush12.__KeyValueFromInt("Solid", 3)
        CustomBrush12.__KeyValueFromString("targetname", "CustomBrush12")
        DebugDrawBox(CustomBrush12.GetOrigin(), CustomBrush12.GetBoundingMins(), CustomBrush12.GetBoundingMaxs(), 0, 255, 0, 1, 9999999)


        CustomBrush7.__KeyValueFromInt("Solid", 0)
        CustomBrush4.__KeyValueFromInt("Solid", 0)
        CustomBrush2.__KeyValueFromInt("Solid", 0)
        CustomBrush9.__KeyValueFromInt("Solid", 0)
        CustomBrush10.__KeyValueFromInt("Solid", 0)
        CustomBrush1.__KeyValueFromInt("Solid", 0)


        EntFire("CustomBrush1", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush1", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush2", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush2", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush3", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush3", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush4", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush4", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush5", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush5", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush6", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush6", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush7", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush7", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush8", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush8", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush9", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush9", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush10", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush10", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush11", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush11", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
        EntFire("CustomBrush12", "SetParent", "Actor_container_master", 0)
        EntFire("CustomBrush12", "SetParentAttachmentMaintainOffset", "vstAttachment", 0)
    }

    if (MSLoop==true) {
        if (CustomBrush1 != false) {
            if (CustomBrush1Cache == false) {
                CustomBrush1Cache <- CustomBrush1.GetOrigin()
            }
            currentCartPos <- CustomBrush1.GetOrigin()
            currentCartRot <- CustomBrush1.GetAngles()
            offsettick <- CustomBrush1.GetOrigin() - CustomBrush1Cache 
            cartrotoffset <- 100
            rotval <- 2
            cartrotoffset1 <- 100
            rotval1 <- 2
            //printl(offsettick)
            local p = null
            while (p = Entities.FindByClassname(p, "player")) {
                planepitch <- currentCartRot.x * rotval 
                planeroll <- currentCartRot.z * rotval1
                p.SetOrigin(p.GetOrigin() + Vector(offsettick.x, offsettick.y, offsettick.z))

                printl(planepitch)
                printl(planeroll)
                playermiddle <- p.GetOrigin() - CustomBrush1.GetOrigin()
                playermiddle <- Vector(((playermiddle.x / -1)/cartrotoffset)*planepitch, ((playermiddle.y)/cartrotoffset1)*planeroll, playermiddle.z)
                p.SetOrigin(Vector(p.GetOrigin().x, p.GetOrigin().y, CustomBrush1.GetOrigin().z + ((playermiddle.x + playermiddle.y) + 22)))
                p.SetVelocity(Vector(p.GetVelocity().x/1.1, p.GetVelocity().y/1.1, 0))
                printl(playermiddle)
            }
            CustomBrush1Cache <- CustomBrush1.GetOrigin()
        }
    }
}