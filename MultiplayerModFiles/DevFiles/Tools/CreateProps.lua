file.Delete("GeneratedPortal2ObjectOutput.txt")
file.Write("GeneratedPortal2ObjectOutput.txt", "")

function GenerateLine(StringDataInput)
    print(StringDataInput)
    file.Append("GeneratedPortal2ObjectOutput.txt", "\n" .. StringDataInput)
end

TeleportInputNode = "models/hunter/blocks/cube1x1x1.mdl"
TeleportOutputNode = "models/maxofs2d/hover_basic.mdl"

PropType = ""
PropCords = Vector (0, 0, 0)
PropAngles = Vector (0, 0, 0)
PropModel = ""
PropOutputName = ""
LoopAmount = 0
Loop = true
MapName = game.GetMap()
CachedModels = {}
GeneratedTriggers = {}
GeneratedBrushes = {}
ContinueModelCache = true
brushamount = 0

LineAmount = MapName:len() + 19
Line = ""

while (LineAmount ~= 0) do
    Line = Line.."="
    LineAmount = LineAmount - 1
end

GenerateLine("//"..Line.."//")
GenerateLine("//CREATE OBJECTS FOR " .. MapName .. "//")
GenerateLine("//"..Line.."//")
GenerateLine("")

GenerateLine('if (GetMapName() == "' .. MapName .. '") {')

while (Loop == true) do

    if (LoopAmount == 0) then
        GenerateLine("    if (CacheTime==true) {")
        GenerateLine("        // Cache Objects")
        GenerateLine("")
    end

    if (LoopAmount == 1) then
        GenerateLine("")
        GenerateLine("")
        GenerateLine("    if (CreateTime==true) {")
        GenerateLine("        // Create Objects")
        GenerateLine("")
    end

    if (LoopAmount == 2) then
        GenerateLine("")
        GenerateLine("")
        GenerateLine("    if (LoopTime==true) {")
        GenerateLine("        // Generated Teleports")
        GenerateLine("")
    end

    for k, prop in ipairs(ents.FindByClass("prop_*")) do
        if (!prop:CreatedByMap() && prop:GetClass() ~= "prop_effect" && prop:GetMaterial() ~= "phoenix_storms/stripes") or (prop:GetClass() == "animprop_generic_physmodel") then

            -- reset varibles
            PropType = "prop_dynamic"
            PropCords = prop:GetPos()
            PropModel = prop:GetModel()
            PropAngles = prop:GetAngles()
            PropOutputName = MapName .. "_custom_prop_" .. k
            ContinueModelCache = true
            PropCollisionNumber = 6
            PropEnableDraw = true
            AvragedScale = 1
            AvragingOperation1 = 1
            OutputScale = 1
            PropColor = tostring(prop:GetColor())

            -- store the size of the prop
            for i=0, prop:GetBoneCount() do
                AvragingOperation1 = prop:GetManipulateBoneScale(i).x + prop:GetManipulateBoneScale(i).y + prop:GetManipulateBoneScale(i).z
                AvragedScale = AvragingOperation1 / 3
                OutputScale = AvragedScale
            end

            -- if the prop has no collision store that
            if (prop:GetCollisionGroup() == 20) then
                PropCollisionNumber = 0
            end

            -- if the prop is no drawed store that
            if(prop:GetMaterial() == "models/wireframe") then
                PropEnableDraw = false
            end

            -- if the prop has physics store that
            if (prop:GetClass() == "prop_physics" && prop:GetPhysicsObject():IsMotionEnabled()) then
                PropType = "prop_physics"
            end

            --models/maxofs2d/hover_classic.mdl

            -- print out generated code
            if (PropModel~=TeleportInputNode && PropModel~=TeleportOutputNode) then
                -- cache code
                -- if the current model has been cached do not continue
                if (LoopAmount == 0 && prop:GetModel() ~= "models/hunter/blocks/cube025x025x025.mdl") then
                    for k, Model in ipairs(CachedModels) do
                        if (Model==PropModel) then
                            ContinueModelCache = false
                        end
                    end

                    -- if uncached cache model
                    if (ContinueModelCache == true) then
                        table.insert(CachedModels, PropModel)
                        GenerateLine('        CacheModel("' .. PropModel:sub(8) .. '")')
                        GenerateLine("")
                    end
                end
                --create code
                if (LoopAmount == 1 && prop:GetModel() ~= "models/hunter/blocks/cube025x025x025.mdl") then
                    if (prop:GetModel() ~= "models/maxofs2d/hover_classic.mdl") then
                        GenerateLine("        local " .. PropOutputName .. ' = CreateProp("' .. PropType .. '", Vector(' .. PropCords.x .. ", " .. PropCords.y .. ", " .. PropCords.z .. '), "' .. PropModel .. '", 0)')
                        GenerateLine("        " .. PropOutputName .. ".SetAngles(" .. PropAngles.x .. ", " .. PropAngles.y .. ", " .. PropAngles.z .. ")")
                        GenerateLine("        " .. PropOutputName .. '.__KeyValueFromString("solid", "'..PropCollisionNumber..'")')
                        GenerateLine("        " .. PropOutputName .. '.__KeyValueFromString("targetname", "genericcustomprop")')
                        -- if the prop is not drawed disable it
                        if (PropEnableDraw == false) then
                            GenerateLine("        " .. "EntFireByHandle(" .. PropOutputName .. ', "disabledraw", "", 0, null, null)')
                        end
                        -- if the prop has a scale then scale it
                        if (OutputScale ~= 1) then
                            GenerateLine("        " .. "EntFireByHandle(" .. PropOutputName .. ', "addoutput", "modelscale ' .. OutputScale * 1.1 .. '", 0, null, null)')
                        end
                        -- if the prop has a stored color then apply it
                        if (PropColor ~= "255 255 255 255") then
                            GenerateLine("        " .. "EntFireByHandle(" .. PropOutputName .. ', "color", "' .. PropColor .. '", 0, null, null)')
                        end
                        GenerateLine("")
                    end


                    if (prop:GetModel() == "models/maxofs2d/hover_classic.mdl") then
                        for inx, CurBrush in ipairs( ents.FindByModel( "models/maxofs2d/hover_classic.mdl" ) ) do
                            ContinueGENBRUSH = true
                            for k, Thing in ipairs(GeneratedBrushes) do
                                if (Thing == CurBrush) then
                                    ContinueGENBRUSH = false
                                end
                            end
        
                            if (ContinueGENBRUSH == true) then
                                brushamount = brushamount + 1
                                curcol = CurBrush:GetColor()
                                for inx, CurBrush2 in ipairs( ents.FindByModel( "models/maxofs2d/hover_classic.mdl" ) ) do
                                    if (CurBrush2 ~= CurBrush) then
                                        if (CurBrush2:GetColor() == curcol) then
                                            table.insert(GeneratedBrushes, CurBrush)
                                            table.insert(GeneratedBrushes, CurBrush2)

                                            oursizebrush = CurBrush:GetPos()-CurBrush2:GetPos()
                                            ournegx = 0
                                            ournegy = 0
                                            ournegz = 0
                                            offsety = 0
                                            if (oursizebrush.x < 0) then
                                                ournegx = oursizebrush.x
                                                oursizebrush.x = oursizebrush.x * -1
                                            end

                                            if (oursizebrush.y < 0) then
                                                ournegy = oursizebrush.y
                                                oursizebrush.y = oursizebrush.y * -1
                                            end

                                            if (oursizebrush.z < 0) then
                                                ournegz = oursizebrush.z
                                                oursizebrush.z = oursizebrush.z * -1
                                            end

                                            GenerateLine("        CustomBrush"..brushamount.."<- Entities.CreateByClassname(\"func_brush\")")
                                            GenerateLine("        CustomBrush"..brushamount..".SetOrigin(Vector("..CurBrush:GetPos().x-oursizebrush.x-ournegx..", "..(CurBrush:GetPos().y-oursizebrush.y-ournegy)+offsety..", "..CurBrush:GetPos().z-oursizebrush.z-ournegz.."))")
                                            GenerateLine("        CustomBrush"..brushamount..".SetSize(Vector(0, 0 ,0), Vector("..oursizebrush.x..", "..oursizebrush.y..", "..oursizebrush.z.."))")
                                            GenerateLine("        CustomBrush"..brushamount..".__KeyValueFromInt(\"Solid\", 3)")
                                            GenerateLine("        DebugDrawBox(CustomBrush"..brushamount..".GetOrigin(), CustomBrush"..brushamount..".GetBoundingMins(), CustomBrush"..brushamount..".GetBoundingMaxs(), 0, 255, 0, 15, 9999999)")
                                            --prop3:GetPos()-prop2:GetPos()) - (prop3:GetPos()-prop2:GetPos()
                                            -- brushattempt <- Entities.CreateByClassname("func_brush")
                                            -- brushattempt.SetOrigin(Vector(5124, 3721, -338))
                                            -- brushattempt.SetSize(Vector(0, 0, 0), Vector(100, 100, 100))
                                            -- brushattempt.__KeyValueFromInt("Solid", 3)
                                            -- DebugDrawBox(brushattempt.GetOrigin(),brushattempt.GetBoundingMins(), brushattempt.GetBoundingMaxs(), 0, 255, 0, 15, 150)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if (LoopAmount == 2) then
                for _, prop31 in ipairs( ents.FindByClass( "prop_physics" ) ) do
                    propmodel21 = prop31:GetModel()
                    if (propmodel21==TeleportInputNode2) then
                        -- create teleport node if model is a teleport node
                        for k, prop21 in ipairs(ents.FindByModel(TeleportInputNode2)) do
                            if (prop21 ~= prop31) then
                                if (prop31:GetColor() == prop21:GetColor()) then
                                    GenerateTriggerNext = true
                                    if (GeneratedTriggers ~= {}) then
                                        for k, Thing in ipairs(GeneratedTriggers) do
                                            if (Thing == prop21) || (Thing == prop31) then
                                                GenerateTriggerNext = false
                                            end
                                        end
                                    end
                                    if (GenerateTriggerNext==true) then
                                        outputct = "nothingatall"
                                        for indct, cubetool in ipairs( ents.FindByModel("models/maxofs2d/cube_tool.mdl") ) do
                                            if (cubetool:GetColor() == prop31:GetColor()) then
                                                outputct = cubetool:GetAngles() / 180
                                                print(outputct)
                                            end
                                        end
                                            GenerateLine("     foreach (p in CreateTrigger(null, "..prop31:GetPos().x..", "..prop31:GetPos().y..", "..prop31:GetPos().z..", "..prop21:GetPos().x..", "..prop21:GetPos().y..", "..prop21:GetPos().z..")) {")
                                            if (outputct ~= "nothingatall") then
                                                GenerateLine("         p.SetVelocity(Vector("..outputct.x..","..outputct.y..","..outputct.z.."))")
                                            else
                                                GenerateLine("         printl(p)")
                                            end
                                            GenerateLine("     }")
                                            table.insert(GeneratedTriggers, prop31)
                                            table.insert(GeneratedTriggers, prop21)
                                    end
                                end
                            end
                        end
                    end
                end

                -- make teleport nodes and output nodes
                if (PropModel==TeleportInputNode) then
                    -- create teleport node if model is a teleport node
                    for k, prop2 in ipairs(ents.FindByModel(TeleportOutputNode)) do
                        if (prop:GetColor() == prop2:GetColor()) then
                            -- write out mixed premade code with teleport node properties
                            GenerateLine("     local p = null")
                            GenerateLine('     while (p = Entities.FindByClassnameWithin(p, "player", Vector(' .. PropCords.x .. ", " .. PropCords.y .. ", " .. PropCords.z .. '), ' .. OutputScale * 20 .. ')) {')
                            GenerateLine("         p.SetOrigin(Vector(" .. prop2:GetPos().x .. ", " .. prop2:GetPos().y .. ", " .. prop2:GetPos().z .. "))")
                            GenerateLine("     }")
                        end
                    end
                end
            end
        end
    end

    -- add end caching code
    if (LoopAmount == 0) then
        GenerateLine("        DoneCacheing <- true")
    end

    -- end if looped twice
    if (LoopAmount == 2) then
        Loop = false
    end

    GenerateLine("  }")

    LoopAmount = LoopAmount + 1
end

GenerateLine("}")


TeleportInputNode2 = "models/hunter/blocks/cube025x025x025.mdl"
TeleportInputNode36 = "models/maxofs2d/hover_classic.mdl"


-- models/maxofs2d/hover_classic.mdl

-- Add a tick hook
function DrawBox()
    for _, prop3 in ipairs( ents.FindByClass( "prop_physics" ) ) do
        propmodel2 = prop3:GetModel()
        if (propmodel2==TeleportInputNode36 or propmodel2==TeleportInputNode2) then
            -- create teleport node if model is a teleport node
            for k, prop2 in ipairs(ents.FindByModel(TeleportInputNode2)) do
                if (prop2 ~= prop3) then
                    if (prop3:GetColor() == prop2:GetColor()) then
                        -- write out mixed premade code with teleport node properties
                        debugoverlay.Box( (prop3:GetPos()-prop2:GetPos()) - (prop3:GetPos()-prop2:GetPos()), prop3:GetPos(), prop2:GetPos(), 0, Color( 255, 100, 8, 20) )
                        debugoverlay.Axis( prop3:GetPos(), prop3:GetAngles(), 40, 0, false )
                        prop3:SetMaterial("models/wireframe")
                        prop2:SetMaterial("models/wireframe")
                        prop2:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
                        prop3:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
                        boxsize = 1
                        debugoverlay.Box(prop2:GetPos(), Vector(boxsize * -1, boxsize * -1, boxsize * -1), Vector(boxsize, boxsize, boxsize), 0, Color( prop2:GetColor().r, prop2:GetColor().g, prop2:GetColor().b, 100) )
                        debugoverlay.Box(prop3:GetPos(), Vector(boxsize * -1, boxsize * -1, boxsize * -1), Vector(boxsize, boxsize, boxsize), 0, Color( prop2:GetColor().r, prop2:GetColor().g, prop2:GetColor().b, 100) )
                    end
                end
            end
            -- create teleport node if model is a teleport node
            for k, prop2 in ipairs(ents.FindByModel(TeleportInputNode36)) do
                if (prop2 ~= prop3) then
                    if (prop3:GetColor() == prop2:GetColor()) then
                        -- write out mixed premade code with teleport node properties
                        debugoverlay.Box( (prop3:GetPos()-prop2:GetPos()) - (prop3:GetPos()-prop2:GetPos()), prop3:GetPos(), prop2:GetPos(), 0, Color( 100, 255, 8, 20) )
                        debugoverlay.Axis( prop3:GetPos(), prop3:GetAngles(), 40, 0, false )
                        prop3:SetMaterial("models/wireframe")
                        prop2:SetMaterial("models/wireframe")
                        prop2:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
                        prop3:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
                        boxsize = 1
                        debugoverlay.Box(prop2:GetPos(), Vector(boxsize * -1, boxsize * -1, boxsize * -1), Vector(boxsize, boxsize, boxsize), 0, Color( prop2:GetColor().r, prop2:GetColor().g, prop2:GetColor().b, 100) )
                        debugoverlay.Box(prop3:GetPos(), Vector(boxsize * -1, boxsize * -1, boxsize * -1), Vector(boxsize, boxsize, boxsize), 0, Color( prop2:GetColor().r, prop2:GetColor().g, prop2:GetColor().b, 100) )
                    end
                end
            end
        end
    end

    // Draw a box

end
hook.Add( "Tick", "BoxDrawForPropCreation", DrawBox )
