PropType = ""
PropCords = Vector (0, 0, 0)
PropAngles = Vector (0, 0, 0)
PropModel = ""
PropOutputName = ""
LoopAmount = 0
Loop = true
MapName = game.GetMap()
CachedModels = {}
ContinueModelCache = true

LineAmount = MapName:len()
Line = ""

while (LineAmount ~= 0) do
    Line = Line.."="
    LineAmount = LineAmount - 1
end

print("//"..Line.."//")
print("//" .. MapName .. "//")
print("//"..Line.."//")
print("")

print('if (GetMapName() == "' .. MapName .. '") {')

while (Loop == true) do 

    if (LoopAmount == 0) then
        print("    if (CacheTime==true) {")
        print("        // Cache Objects")
        print("")
    end

    if (LoopAmount == 1) then
        print("")
        print("")
        print("    if (CreateTime==true) {")
        print("        // Create Objects")
        print("")
    end

    for k, prop in ipairs( ents.FindByClass( "prop_*" ) ) do
        if (!prop:CreatedByMap() && prop:GetClass() ~= "prop_effect") then
        
            -- reset varibles
            PropType = "prop_dynamic"
            PropCords = prop:GetPos()
            PropModel = prop:GetModel()
            PropAngles = prop:GetAngles()
            PropOutputName = MapName .. "_custom_prop_" .. k
            ContinueModelCache = true

            -- if the prop has physics store that
            if (prop:GetClass() == "prop_physics" && prop:GetPhysicsObject():IsMotionEnabled()) then
                PropType = "prop_physics"
            end

            -- print out generated code
            -- cache code
            -- if the current model has been cached do not continue
            if (LoopAmount == 0) then
                for k, Model in ipairs( CachedModels ) do
                    if (Model==PropModel) then
                        ContinueModelCache = false
                    end
                end
                
                -- if uncached cache model
                if (ContinueModelCache == true) then
                    table.insert(CachedModels, PropModel)
                    print('        CacheModel("' .. PropModel:sub(8) .. '")')
                    print("")
                end
            end
            --create code
            if (LoopAmount == 1) then
                print("        local " .. PropOutputName .. ' = CreateProp("' .. PropType .. '", Vector(' .. PropCords.x .. ", " .. PropCords.y .. ", " .. PropCords.z .. '), "' .. PropModel .. '", 0)')
                print("        " .. PropOutputName .. ".SetAngles(" .. PropAngles.x .. ", " .. PropAngles.y .. ", " .. PropAngles.z .. ")")
                print("        " .. PropOutputName .. '.__KeyValueFromString("solid", "6")')
                print("        " .. PropOutputName .. '.__KeyValueFromString("targetname", "genericcustomprop")')
                print("")
            end

        end
    end

    -- add end caching code
    if (LoopAmount == 0) then
        print("        DoneCacheing <- true")
    end

    -- end if looped twice
    if (LoopAmount == 1) then
        Loop = false
    end

    print ("    }")

    LoopAmount = LoopAmount + 1
end

print("}")

-- modelnumber32
-- modelnumber32.__KeyValueFromString("targetname", "genericcustomprop")
