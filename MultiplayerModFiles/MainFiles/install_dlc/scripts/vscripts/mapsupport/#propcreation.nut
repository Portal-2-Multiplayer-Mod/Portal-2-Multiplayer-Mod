// ╔═╗╦═╗╔═╗╔═╗  ╔═╗╦═╗╔═╗╔═╗╔╦╗╦╔═╗╔╗╔  ╔═╗╔═╗╔╦╗╔═╗
// ╠═╝╠╦╝║ ║╠═╝  ║  ╠╦╝║╣ ╠═╣ ║ ║║ ║║║║  ║  ║ ║ ║║║╣
// ╩  ╩╚═╚═╝╩    ╚═╝╩╚═╚═╝╩ ╩ ╩ ╩╚═╝╝╚╝  ╚═╝╚═╝═╩╝╚═╝
// ╦╔╦╗╔═╗╔═╗╦═╗╔╦╗╔═╗╔╦╗  ╔═╗╦═╗╔═╗╔╦╗  ╔═╗╔╦╗╔═╗╔╦╗
// ║║║║╠═╝║ ║╠╦╝ ║ ║╣  ║║  ╠╣ ╠╦╝║ ║║║║  ║ ╦║║║║ ║ ║║
// ╩╩ ╩╩  ╚═╝╩╚═ ╩ ╚═╝═╩╝  ╚  ╩╚═╚═╝╩ ╩  ╚═╝╩ ╩╚═╝═╩╝

function CreatePropsForLevel(CacheTime, CreateTime, LoopTime) {

//=============================//
//CREATE OBJECTS FOR sp_a2_bts2//
//=============================//

if (GetMapName() == "sp_a2_bts2") {
    if (CacheTime==true) {
        // Cache Objects

        CacheModel("props_bts/hanging_walkway_128a.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local sp_a2_bts2_custom_prop_144 = CreateProp("prop_dynamic", Vector(1210.9047851562, -3591.4580078125, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_144.SetAngles(-89.999946594238, -179.99993896484, 180)
        sp_a2_bts2_custom_prop_144.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_144.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_144, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_145 = CreateProp("prop_dynamic", Vector(1210.9046630859, -3463.4580078125, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_145.SetAngles(-89.999946594238, -179.99992370605, 180)
        sp_a2_bts2_custom_prop_145.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_145.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_145, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_146 = CreateProp("prop_dynamic", Vector(1407.3646240234, -3066.5859375, 10.300641059875), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_146.SetAngles(-89.979080200195, 90.006011962891, 180)
        sp_a2_bts2_custom_prop_146.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_146.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_146, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_147 = CreateProp("prop_dynamic", Vector(1733.7668457031, -3890.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_147.SetAngles(-89.999946594238, 9.5622635853942e-05, 180)
        sp_a2_bts2_custom_prop_147.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_147.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_147, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_148 = CreateProp("prop_dynamic", Vector(1732.4794921875, -3133.6625976562, 10.172374725342), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_148.SetAngles(-89.999984741211, 8.720429832465e-06, 180)
        sp_a2_bts2_custom_prop_148.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_148.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_148, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_149 = CreateProp("prop_dynamic", Vector(1210.9049072266, -3719.4580078125, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_149.SetAngles(-89.999946594238, -179.99995422363, 180)
        sp_a2_bts2_custom_prop_149.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_149.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_149, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_150 = CreateProp("prop_dynamic", Vector(1210.9050292969, -3847.4582519531, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_150.SetAngles(-89.999946594238, -179.99996948242, 180)
        sp_a2_bts2_custom_prop_150.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_150.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_150, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_151 = CreateProp("prop_dynamic", Vector(1210.9045410156, -3335.4580078125, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_151.SetAngles(-89.999946594238, -179.99990844727, 180)
        sp_a2_bts2_custom_prop_151.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_151.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_151, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_152 = CreateProp("prop_dynamic", Vector(1210.904296875, -3207.4577636719, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_152.SetAngles(-89.999946594238, -179.99989318848, 180)
        sp_a2_bts2_custom_prop_152.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_152.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_152, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_153 = CreateProp("prop_dynamic", Vector(1210.9040527344, -3079.4577636719, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_153.SetAngles(-89.999946594238, -179.99989318848, 180)
        sp_a2_bts2_custom_prop_153.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_153.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_153, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_154 = CreateProp("prop_dynamic", Vector(1279.3647460938, -3066.5993652344, 10.300641059875), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_154.SetAngles(-89.979103088379, 90.006004333496, 180)
        sp_a2_bts2_custom_prop_154.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_154.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_154, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_155 = CreateProp("prop_dynamic", Vector(2119.7722167969, -3195.4938964844, 12.396705627441), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_155.SetAngles(-89.999946594238, 89.999984741211, 180)
        sp_a2_bts2_custom_prop_155.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_155.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_155, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_156 = CreateProp("prop_dynamic", Vector(2244.1625976562, -3520.9521484375, 13.540298461914), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_156.SetAngles(-89.911918640137, -0.34657052159309, -179.76554870605)
        sp_a2_bts2_custom_prop_156.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_156.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_156, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_157 = CreateProp("prop_dynamic", Vector(1733.7669677734, -4018.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_157.SetAngles(-89.999954223633, 5.4641506721964e-05, 180)
        sp_a2_bts2_custom_prop_157.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_157.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_157, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_158 = CreateProp("prop_dynamic", Vector(1733.7672119141, -4146.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_158.SetAngles(-89.999946594238, 9.5622635853942e-05, 180)
        sp_a2_bts2_custom_prop_158.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_158.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_158, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_159 = CreateProp("prop_dynamic", Vector(2176.3408203125, -3588.1184082031, 10.380084037781), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_159.SetAngles(-89.999984741211, -89.999992370605, 180)
        sp_a2_bts2_custom_prop_159.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_159.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_159, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_160 = CreateProp("prop_dynamic", Vector(1733.7663574219, -3634.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_160.SetAngles(-89.999946594238, 0.00010928301344393, 180)
        sp_a2_bts2_custom_prop_160.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_160.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_160, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_161 = CreateProp("prop_dynamic", Vector(2244.4130859375, -3392.9523925781, 13.541104316711), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_161.SetAngles(-89.911918640137, -0.34657019376755, -179.76554870605)
        sp_a2_bts2_custom_prop_161.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_161.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_161, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_162 = CreateProp("prop_dynamic", Vector(2247.7722167969, -3195.4938964844, 12.396705627441), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_162.SetAngles(-89.999946594238, 89.999984741211, 180)
        sp_a2_bts2_custom_prop_162.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_162.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_162, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_163 = CreateProp("prop_dynamic", Vector(1663.3646240234, -3066.5588378906, 10.300641059875), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_163.SetAngles(-89.979080200195, 90.006042480469, 180)
        sp_a2_bts2_custom_prop_163.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_163.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_163, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_164 = CreateProp("prop_dynamic", Vector(1535.3646240234, -3066.572265625, 10.300641059875), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_164.SetAngles(-89.979080200195, 90.00602722168, 180)
        sp_a2_bts2_custom_prop_164.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_164.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_164, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_165 = CreateProp("prop_dynamic", Vector(1210.9050292969, -4103.4584960938, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_165.SetAngles(-89.999984741211, 180, 180)
        sp_a2_bts2_custom_prop_165.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_165.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_165, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_166 = CreateProp("prop_dynamic", Vector(1733.7666015625, -3762.8125, 9.1990060806274), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_166.SetAngles(-89.999946594238, 0.00010928301344393, 180)
        sp_a2_bts2_custom_prop_166.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_166.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_166, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_167 = CreateProp("prop_dynamic", Vector(1863.7722167969, -3195.4938964844, 12.396701812744), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_167.SetAngles(-89.999984741211, 89.999984741211, 180)
        sp_a2_bts2_custom_prop_167.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_167.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_167, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_168 = CreateProp("prop_dynamic", Vector(1210.9050292969, -3975.4584960938, 10.96333694458), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_168.SetAngles(-89.999954223633, -179.99998474121, 180)
        sp_a2_bts2_custom_prop_168.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_168.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_168, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_169 = CreateProp("prop_dynamic", Vector(1991.7722167969, -3195.4938964844, 12.396705627441), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_169.SetAngles(-89.999954223633, 89.999984741211, 180)
        sp_a2_bts2_custom_prop_169.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_169.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_169, "disabledraw", "", 0, null, null)

        local sp_a2_bts2_custom_prop_170 = CreateProp("prop_dynamic", Vector(2244.6635742188, -3264.9526367188, 13.541909217834), "models/props_bts/hanging_walkway_128a.mdl", 0)
        sp_a2_bts2_custom_prop_170.SetAngles(-89.91194152832, -0.34656989574432, -179.76559448242)
        sp_a2_bts2_custom_prop_170.__KeyValueFromString("solid", "6")
        sp_a2_bts2_custom_prop_170.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a2_bts2_custom_prop_170, "disabledraw", "", 0, null, null)

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}
}