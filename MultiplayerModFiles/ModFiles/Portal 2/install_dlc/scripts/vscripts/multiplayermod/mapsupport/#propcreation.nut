// ╔═╗╦═╗╔═╗╔═╗  ╔═╗╦═╗╔═╗╔═╗╔╦╗╦╔═╗╔╗╔  ╔═╗╔═╗╔╦╗╔═╗
// ╠═╝╠╦╝║ ║╠═╝  ║  ╠╦╝║╣ ╠═╣ ║ ║║ ║║║║  ║  ║ ║ ║║║╣
// ╩  ╩╚═╚═╝╩    ╚═╝╩╚═╚═╝╩ ╩ ╩ ╩╚═╝╝╚╝  ╚═╝╚═╝═╩╝╚═╝
// ╦╔╦╗╔═╗╔═╗╦═╗╔╦╗╔═╗╔╦╗  ╔═╗╦═╗╔═╗╔╦╗  ╔═╗╔╦╗╔═╗╔╦╗
// ║║║║╠═╝║ ║╠╦╝ ║ ║╣  ║║  ╠╣ ╠╦╝║ ║║║║  ║ ╦║║║║ ║ ║║
// ╩╩ ╩╩  ╚═╝╩╚═ ╩ ╚═╝═╩╝  ╚  ╩╚═╚═╝╩ ╩  ╚═╝╩ ╩╚═╝═╩╝

function CreatePropsForLevel(CacheTime, CreateTime, LoopTime) {

//========================================//
//CREATE OBJECTS FOR mp_coop_community_hub//
//========================================//

if (GetMapName() == "mp_coop_community_hub") {
    if (CacheTime==true) {
        // Cache Objects

        PrecacheModel("props/switch001.mdl")

        PrecacheModel("info_character/info_character_bendy.mdl")

        PrecacheModel("handles_map_editor/rotationgrip.mdl")

        PrecacheModel("handles_map_editor/handle_grip_arrow.mdl")

        PrecacheModel("handles_map_editor/handle4waygrip.mdl")

        PrecacheModel("handles_map_editor/handle_grip_sphere.mdl")

        PrecacheModel("props_animsigns/signage_num00.mdl")

        PrecacheModel("props_ingame/faith_plate_128bevel.mdl")

        PrecacheModel("props_underground/stasis_chamber_dead.mdl")

        PrecacheModel("props_underground/stasis_chamber_body_cheap.mdl")

        PrecacheModel("props_underground/stasis_chamber_body_02_cheap.mdl")

        PrecacheModel("props_underground/pressure_door_blown.mdl")

        PrecacheModel("props_unique/wooden_barricade_break2.mdl")

        PrecacheModel("props_urban/oil_drum001.mdl")

        PrecacheModel("props_urban/telephone_pole002.mdl")

        PrecacheModel("props_wasteland/prison_switchbox001a.mdl")

        PrecacheModel("stars/startype_2.mdl")

        PrecacheModel("stars/allstars.mdl")

        PrecacheModel("props_destruction/box_frame.mdl")

        PrecacheModel("props_destruction/debris_dest_phys_02_blacktiles.mdl")

        PrecacheModel("a4_destruction/arm_exthalfres_withpanels.mdl")

        PrecacheModel("extras/info_speech.mdl")

        PrecacheModel("props/pincher_cable.mdl")

        PrecacheModel("props_bts/rocket.mdl")

        PrecacheModel("props_map_editor/destination_arrow.mdl")

        PrecacheModel("effects/urban_puddle_model02a.mdl")

        PrecacheModel("props/futbol_dispenser.mdl")

        PrecacheModel("props/futbol_gib02.mdl")

        PrecacheModel("props/futbol_gib04.mdl")

        PrecacheModel("props/futbol_gib03.mdl")

        PrecacheModel("props/futbol_gib01.mdl")

        PrecacheModel("props/door_01_frame_wide_reference.mdl")

        PrecacheModel("car_int_dest/car_int_dest.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local mp_coop_community_hub_custom_prop_4 = CreateProp("prop_dynamic", Vector(-58.731231689453, 195.79721069336, 285.69476318359), "models/info_character/info_character_bendy.mdl", 0)
        mp_coop_community_hub_custom_prop_4.SetAngles(-37.688098907471, -107.09071350098, -158.98446655273)
        mp_coop_community_hub_custom_prop_4.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_4.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_6 = CreateProp("prop_dynamic", Vector(183.81561279297, -144.82272338867, 135.88780212402), "models/info_character/info_character_bendy.mdl", 0)
        mp_coop_community_hub_custom_prop_6.SetAngles(-57.954753875732, 113.57312774658, -90.105072021484)
        mp_coop_community_hub_custom_prop_6.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_6.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_8 = CreateProp("prop_dynamic", Vector(-267.38681030273, -236.86878967285, 347.02340698242), "models/info_character/info_character_bendy.mdl", 0)
        mp_coop_community_hub_custom_prop_8.SetAngles(38.864807128906, 91.988922119141, 69.754531860352)
        mp_coop_community_hub_custom_prop_8.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_8.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_10 = CreateProp("prop_dynamic", Vector(305.75369262695, 275.23693847656, 252.99482727051), "models/info_character/info_character_bendy.mdl", 0)
        mp_coop_community_hub_custom_prop_10.SetAngles(39.191024780273, 137.49644470215, -44.360229492188)
        mp_coop_community_hub_custom_prop_10.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_10.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_12 = CreateProp("prop_dynamic", Vector(-101.82276916504, 210.06312561035, 63.820220947266), "models/info_character/info_character_bendy.mdl", 0)
        mp_coop_community_hub_custom_prop_12.SetAngles(-16.213136672974, -98.673240661621, 39.567840576172)
        mp_coop_community_hub_custom_prop_12.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_12.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_14 = CreateProp("prop_dynamic", Vector(-150.74435424805, -191.04629516602, 111.30498504639), "models/info_character/info_character_bendy.mdl", 0)
        mp_coop_community_hub_custom_prop_14.SetAngles(31.192373275757, 126.00482177734, 56.697059631348)
        mp_coop_community_hub_custom_prop_14.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_14.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_16 = CreateProp("prop_dynamic", Vector(235.96055603027, 27.619022369385, 264.5559387207), "models/info_character/info_character_bendy.mdl", 0)
        mp_coop_community_hub_custom_prop_16.SetAngles(14.627272605896, 76.658714294434, -52.578948974609)
        mp_coop_community_hub_custom_prop_16.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_16.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_18 = CreateProp("prop_dynamic", Vector(183.84214782715, 260.56005859375, 150.52374267578), "models/info_character/info_character_bendy.mdl", 0)
        mp_coop_community_hub_custom_prop_18.SetAngles(-22.944257736206, -27.069187164307, -126.81803894043)
        mp_coop_community_hub_custom_prop_18.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_18.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_20 = CreateProp("prop_dynamic", Vector(334.72286987305, -239.64474487305, 159.44416809082), "models/info_character/info_character_bendy.mdl", 0)
        mp_coop_community_hub_custom_prop_20.SetAngles(22.01308631897, -148.10885620117, 44.986465454102)
        mp_coop_community_hub_custom_prop_20.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_20.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_22 = CreateProp("prop_dynamic", Vector(-0.13824604451656, 3.9262297153473, 237.17892456055), "models/info_character/info_character_bendy.mdl", 0)
        mp_coop_community_hub_custom_prop_22.SetAngles(16.751987457275, 109.91907501221, 56.121383666992)
        mp_coop_community_hub_custom_prop_22.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_22.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_24 = CreateProp("prop_dynamic", Vector(-50.069583892822, -238.67546081543, 208.79376220703), "models/handles_map_editor/rotationgrip.mdl", 0)
        mp_coop_community_hub_custom_prop_24.SetAngles(61.713138580322, 172.25129699707, 57.697166442871)
        mp_coop_community_hub_custom_prop_24.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_24.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_26 = CreateProp("prop_dynamic", Vector(43.030292510986, 205.29223632812, 139.73246765137), "models/handles_map_editor/handle_grip_arrow.mdl", 0)
        mp_coop_community_hub_custom_prop_26.SetAngles(-66.808059692383, -45.559089660645, 10.866897583008)
        mp_coop_community_hub_custom_prop_26.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_26.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_28 = CreateProp("prop_dynamic", Vector(226.02737426758, -29.712993621826, 441.13098144531), "models/handles_map_editor/handle4waygrip.mdl", 0)
        mp_coop_community_hub_custom_prop_28.SetAngles(-51.724338531494, -178.10205078125, -3.5521240234375)
        mp_coop_community_hub_custom_prop_28.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_28.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_30 = CreateProp("prop_dynamic", Vector(-263.71200561523, 16.853876113892, 340.29605102539), "models/handles_map_editor/handle_grip_sphere.mdl", 0)
        mp_coop_community_hub_custom_prop_30.SetAngles(2.9473826418364e-15, -14.025360107422, 1.52587890625e-05)
        mp_coop_community_hub_custom_prop_30.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_30.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_32 = CreateProp("prop_dynamic", Vector(-191.75440979004, -19.380878448486, 116.84470367432), "models/handles_map_editor/rotationgrip.mdl", 0)
        mp_coop_community_hub_custom_prop_32.SetAngles(-3.234824532683e-07, 58.344539642334, -45)
        mp_coop_community_hub_custom_prop_32.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_32.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_33 = CreateProp("prop_dynamic", Vector(-215.02108764648, 17.974704742432, 301.19055175781), "models/props_animsigns/signage_num00.mdl", 0)
        mp_coop_community_hub_custom_prop_33.SetAngles(45, 1.6848629229571e-06, 1.52587890625e-05)
        mp_coop_community_hub_custom_prop_33.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_33.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_35 = CreateProp("prop_dynamic", Vector(10.116161346436, -313.10177612305, 6.595142364502), "models/props_ingame/faith_plate_128bevel.mdl", 0)
        mp_coop_community_hub_custom_prop_35.SetAngles(-6.2460609213225e-28, -0.088999167084694, 0)
        mp_coop_community_hub_custom_prop_35.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_35.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_37 = CreateProp("prop_dynamic", Vector(67.446784973145, 15.899125099182, 57.548881530762), "models/props_underground/stasis_chamber_dead.mdl", 0)
        mp_coop_community_hub_custom_prop_37.SetAngles(-6.2044689047927e-15, -2.5447812080383, 1.52587890625e-05)
        mp_coop_community_hub_custom_prop_37.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_37.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_39 = CreateProp("prop_dynamic", Vector(94.835182189941, -76.359176635742, 128.44342041016), "models/props_underground/stasis_chamber_body_cheap.mdl", 0)
        mp_coop_community_hub_custom_prop_39.SetAngles(38.830318450928, 54.084251403809, 1.864501953125)
        mp_coop_community_hub_custom_prop_39.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_39.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_41 = CreateProp("prop_dynamic", Vector(30.063936233521, 163.8740234375, 212.01268005371), "models/props_underground/stasis_chamber_body_02_cheap.mdl", 0)
        mp_coop_community_hub_custom_prop_41.SetAngles(52.055461883545, -41.397960662842, -0.5338134765625)
        mp_coop_community_hub_custom_prop_41.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_41.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_42 = CreateProp("prop_dynamic", Vector(13.477213859558, 178.63676452637, 170.96273803711), "models/props_underground/pressure_door_blown.mdl", 0)
        mp_coop_community_hub_custom_prop_42.SetAngles(20.290468215942, -38.609062194824, -2.5534362792969)
        mp_coop_community_hub_custom_prop_42.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_42.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_43 = CreateProp("prop_dynamic", Vector(-310.3935546875, 330.53561401367, 1.5885629653931), "models/props_unique/wooden_barricade_break2.mdl", 0)
        mp_coop_community_hub_custom_prop_43.SetAngles(-0.035208445042372, -150.06106567383, 0.25309753417969)
        mp_coop_community_hub_custom_prop_43.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_43.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_44 = CreateProp("prop_dynamic", Vector(-230.46865844727, 267.98684692383, 0.35983654856682), "models/props_urban/oil_drum001.mdl", 0)
        mp_coop_community_hub_custom_prop_44.SetAngles(0.01534549985081, -93.706275939941, 0.006378173828125)
        mp_coop_community_hub_custom_prop_44.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_44.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_45 = CreateProp("prop_dynamic", Vector(-267.58630371094, 160.10818481445, 0.36376368999481), "models/props_urban/telephone_pole002.mdl", 0)
        mp_coop_community_hub_custom_prop_45.SetAngles(-0.2135715931654, -45, 0)
        mp_coop_community_hub_custom_prop_45.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_45.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_46 = CreateProp("prop_dynamic", Vector(-260.94439697266, 156.97311401367, 190.97843933105), "models/props_wasteland/prison_switchbox001a.mdl", 0)
        mp_coop_community_hub_custom_prop_46.SetAngles(-0.50833058357239, -21.308174133301, 1.306640625)
        mp_coop_community_hub_custom_prop_46.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_46.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_48 = CreateProp("prop_dynamic", Vector(-6709.7875976562, 810.16711425781, 315.81408691406), "models/stars/startype_2.mdl", 0)
        mp_coop_community_hub_custom_prop_48.SetAngles(2.6715495586395, -8.5294761657715, -12.305908203125)
        mp_coop_community_hub_custom_prop_48.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_48.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_50 = CreateProp("prop_dynamic", Vector(72.601791381836, 49.398593902588, 122.3581161499), "models/stars/allstars.mdl", 0)
        mp_coop_community_hub_custom_prop_50.SetAngles(0, 85.09846496582, 0)
        mp_coop_community_hub_custom_prop_50.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_50.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_51 = CreateProp("prop_dynamic", Vector(-16.473085403442, -124.63014984131, 196.9942779541), "models/props_destruction/box_frame.mdl", 0)
        mp_coop_community_hub_custom_prop_51.SetAngles(3.0417654514313, -45.061946868896, 8.3908996582031)
        mp_coop_community_hub_custom_prop_51.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_51.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_52 = CreateProp("prop_dynamic", Vector(-228.08628845215, -224.24795532227, 0.49980095028877), "models/props_destruction/debris_dest_phys_02_blacktiles.mdl", 0)
        mp_coop_community_hub_custom_prop_52.SetAngles(-8.8709093688522e-06, 28.232706069946, 1.52587890625e-05)
        mp_coop_community_hub_custom_prop_52.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_52.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_54 = CreateProp("prop_dynamic", Vector(323.89636230469, -24.752475738525, 153.0139465332), "models/a4_destruction/arm_exthalfres_withpanels.mdl", 0)
        mp_coop_community_hub_custom_prop_54.SetAngles(68.973121643066, 85.288566589355, -100.56643676758)
        mp_coop_community_hub_custom_prop_54.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_54.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_55 = CreateProp("prop_dynamic", Vector(104.61391448975, 17.25347328186, 23.798500061035), "models/extras/info_speech.mdl", 0)
        mp_coop_community_hub_custom_prop_55.SetAngles(1.9539013464964e-06, 5.1082142817904e-06, 0)
        mp_coop_community_hub_custom_prop_55.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_55.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_57 = CreateProp("prop_dynamic", Vector(85.828132629395, 17.490839004517, 431.99960327148), "models/props/pincher_cable.mdl", 0)
        mp_coop_community_hub_custom_prop_57.SetAngles(1.5770947102509e-14, 2.6457033157349, 1.52587890625e-05)
        mp_coop_community_hub_custom_prop_57.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_57.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_58 = CreateProp("prop_dynamic", Vector(31.15185546875, 16.245506286621, 73.305328369141), "models/props/switch001.mdl", 0)
        mp_coop_community_hub_custom_prop_58.SetAngles(45, 2.061636905637e-06, 0)
        mp_coop_community_hub_custom_prop_58.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_58.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_59 = CreateProp("prop_dynamic", Vector(96.78491973877, -56.500396728516, 76.919792175293), "models/props/switch001.mdl", 0)
        mp_coop_community_hub_custom_prop_59.SetAngles(45, 90.591361999512, 1.52587890625e-05)
        mp_coop_community_hub_custom_prop_59.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_59.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_60 = CreateProp("prop_dynamic", Vector(99.467979431152, 16.612070083618, 170.07618713379), "models/props/switch001.mdl", 0)
        mp_coop_community_hub_custom_prop_60.SetAngles(1.8827417846978e-08, 0.0022967134136707, -179.99998474121)
        mp_coop_community_hub_custom_prop_60.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_60.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_61 = CreateProp("prop_dynamic", Vector(97.770637512207, 86.912101745605, 72.10400390625), "models/props/switch001.mdl", 0)
        mp_coop_community_hub_custom_prop_61.SetAngles(45, -89.999961853027, 3.0517578125e-05)
        mp_coop_community_hub_custom_prop_61.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_61.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_62 = CreateProp("prop_dynamic", Vector(90.064735412598, 14.953147888184, 96.176620483398), "models/props_bts/rocket.mdl", 0)
        mp_coop_community_hub_custom_prop_62.SetAngles(89.999938964844, 167.15007019043, 180)
        mp_coop_community_hub_custom_prop_62.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_62.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_64 = CreateProp("prop_dynamic", Vector(95.502853393555, 16.242263793945, 54.728626251221), "models/props_map_editor/destination_arrow.mdl", 0)
        mp_coop_community_hub_custom_prop_64.SetAngles(0.00024931263760664, 172.67756652832, 180)
        mp_coop_community_hub_custom_prop_64.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_64.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_65 = CreateProp("prop_dynamic", Vector(102.31185150146, 16.049180984497, 0.48675751686096), "models/effects/urban_puddle_model02a.mdl", 0)
        mp_coop_community_hub_custom_prop_65.SetAngles(0.012155358679593, 20.596862792969, 0.020751953125)
        mp_coop_community_hub_custom_prop_65.__KeyValueFromString("solid", "0")
        mp_coop_community_hub_custom_prop_65.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_66 = CreateProp("prop_dynamic", Vector(99.262046813965, 383.85397338867, 91.519775390625), "models/props/futbol_dispenser.mdl", 0)
        mp_coop_community_hub_custom_prop_66.SetAngles(-0.50859606266022, -2.0214777123329e-06, 0)
        mp_coop_community_hub_custom_prop_66.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_66.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_67 = CreateProp("prop_dynamic", Vector(194.28642272949, 260.60430908203, 3.5583488941193), "models/props/futbol_gib02.mdl", 0)
        mp_coop_community_hub_custom_prop_67.SetAngles(17.496908187866, 10.398177146912, 54.57763671875)
        mp_coop_community_hub_custom_prop_67.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_67.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_68 = CreateProp("prop_dynamic", Vector(173.43843078613, 356.43585205078, 7.9653162956238), "models/props/futbol_gib04.mdl", 0)
        mp_coop_community_hub_custom_prop_68.SetAngles(42.67427444458, -78.450233459473, 71.577278137207)
        mp_coop_community_hub_custom_prop_68.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_68.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_69 = CreateProp("prop_dynamic", Vector(98.457366943359, 248.62010192871, 14.279579162598), "models/props/futbol_gib03.mdl", 0)
        mp_coop_community_hub_custom_prop_69.SetAngles(42.072757720947, 8.8567686080933, 44.268753051758)
        mp_coop_community_hub_custom_prop_69.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_69.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_70 = CreateProp("prop_dynamic", Vector(100.50720977783, 345.38958740234, 91.680801391602), "models/props/futbol_gib03.mdl", 0)
        mp_coop_community_hub_custom_prop_70.SetAngles(74.569198608398, 166.31315612793, -40.338928222656)
        mp_coop_community_hub_custom_prop_70.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_70.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_71 = CreateProp("prop_dynamic", Vector(56.546161651611, 209.95248413086, 10.428175926208), "models/props/futbol_gib01.mdl", 0)
        mp_coop_community_hub_custom_prop_71.SetAngles(4.0553035736084, -173.15980529785, -139.80966186523)
        mp_coop_community_hub_custom_prop_71.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_71.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_72 = CreateProp("prop_dynamic", Vector(155.79811096191, 15.048536300659, 0.48015946149826), "models/props/door_01_frame_wide_reference.mdl", 0)
        mp_coop_community_hub_custom_prop_72.SetAngles(-0.087614670395851, -0.016160571947694, -0.0030517578125)
        mp_coop_community_hub_custom_prop_72.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_72.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_community_hub_custom_prop_74 = CreateProp("prop_dynamic", Vector(292.12142944336, 227.99667358398, 246.53610229492), "models/car_int_dest/car_int_dest.mdl", 0)
        mp_coop_community_hub_custom_prop_74.SetAngles(-47.493316650391, -57.93102645874, 3.6938781738281)
        mp_coop_community_hub_custom_prop_74.__KeyValueFromString("solid", "6")
        mp_coop_community_hub_custom_prop_74.__KeyValueFromString("targetname", "genericcustomprop")

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}

//===================================//
//CREATE OBJECTS FOR mp_coop_rat_maze//
//===================================//

if (GetMapName() == "mp_coop_rat_maze") {
    if (CacheTime==true) {
        // Cache Objects

        PrecacheModel("props/reflection_cube.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local mp_coop_rat_maze_custom_prop_48 = CreateProp("prop_physics", Vector(-177.24385070801, 83.552711486816, -621.53527832031), "models/props/reflection_cube.mdl", 0)
        mp_coop_rat_maze_custom_prop_48.SetAngles(-0.073955573141575, 75.476417541504, 179.88249206543)
        mp_coop_rat_maze_custom_prop_48.__KeyValueFromString("solid", "6")
        mp_coop_rat_maze_custom_prop_48.__KeyValueFromString("targetname", "genericcustomprop")

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}


//==================================//
//CREATE OBJECTS FOR sp_a3_crazy_box//
//==================================//

if (GetMapName() == "sp_a3_crazy_box") {
    if (CacheTime==true) {
        // Cache Objects

        PrecacheModel("props_bts/vactube_128_straight.mdl")

        PrecacheModel("props_underground/underground_boxdropper.mdl")

        PrecacheModel("props_underground/underground_boxdropper_cage.mdl")

        PrecacheModel("props_factory/factory_panel_metal_chopped_top_128x128.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local sp_a3_crazy_box_custom_prop_9 = CreateProp("prop_dynamic", Vector(878.75024414062, -1112.2896728516, 2054.7436523438), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a3_crazy_box_custom_prop_9.SetAngles(2.7340308861312e-07, -179.99995422363, 90.000022888184)
        sp_a3_crazy_box_custom_prop_9.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_9.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_10 = CreateProp("prop_dynamic", Vector(878.75024414062, -1112.2896728516, 2566.7436523438), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a3_crazy_box_custom_prop_10.SetAngles(2.7340277597432e-07, -179.99989318848, 90.000030517578)
        sp_a3_crazy_box_custom_prop_10.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_10.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_11 = CreateProp("prop_dynamic", Vector(878.75024414062, -1112.2896728516, 2694.7436523438), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a3_crazy_box_custom_prop_11.SetAngles(2.7340274755261e-07, -179.99989318848, 90.000030517578)
        sp_a3_crazy_box_custom_prop_11.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_11.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_12 = CreateProp("prop_dynamic", Vector(878.75024414062, -1112.2896728516, 2182.7436523438), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a3_crazy_box_custom_prop_12.SetAngles(2.7340297492628e-07, -179.99989318848, 90.000030517578)
        sp_a3_crazy_box_custom_prop_12.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_12.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_13 = CreateProp("prop_dynamic", Vector(878.75024414062, -1112.2896728516, 2310.7436523438), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a3_crazy_box_custom_prop_13.SetAngles(2.7340294650458e-07, -179.99989318848, 90.000030517578)
        sp_a3_crazy_box_custom_prop_13.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_13.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_14 = CreateProp("prop_dynamic", Vector(878.75024414062, -1112.2896728516, 2438.7436523438), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a3_crazy_box_custom_prop_14.SetAngles(2.7340283281774e-07, -179.99989318848, 90.000030517578)
        sp_a3_crazy_box_custom_prop_14.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_14.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_15 = CreateProp("prop_dynamic", Vector(877.98041992188, -1112.2999023438, 1952.1126708984), "models/props_underground/underground_boxdropper.mdl", 0)
        sp_a3_crazy_box_custom_prop_15.SetAngles(0, 90, 0)
        sp_a3_crazy_box_custom_prop_15.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_15.__KeyValueFromString("targetname", "genericcustomprop_maindropper")

        local sp_a3_crazy_box_custom_prop_16 = CreateProp("prop_dynamic", Vector(877.94549560547, -1111.8862304688, 1951.9709472656), "models/props_underground/underground_boxdropper_cage.mdl", 0)
        sp_a3_crazy_box_custom_prop_16.SetAngles(-7.4231045998841e-20, 89.99989318848, 1.52587890625e-05)
        sp_a3_crazy_box_custom_prop_16.__KeyValueFromString("solid", "6")
        sp_a3_crazy_box_custom_prop_16.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a3_crazy_box_custom_prop_17 = CreateProp("prop_dynamic", Vector(878.23785400391, -1111.7216796875, 2049.7453613281), "models/props_factory/factory_panel_metal_chopped_top_128x128.mdl", 0)
        sp_a3_crazy_box_custom_prop_17.SetAngles(89.999992370605, 90, 180)
        sp_a3_crazy_box_custom_prop_17.__KeyValueFromString("solid", "0")
        sp_a3_crazy_box_custom_prop_17.__KeyValueFromString("targetname", "genericcustomprop")
        EntFireByHandle(sp_a3_crazy_box_custom_prop_17, "addoutput", "modelscale 0.8910000026226", 0, null, null)
        EntFireByHandle(sp_a3_crazy_box_custom_prop_17, "color", "0 0 0 255", 0, null, null)

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}

//==================================//
//CREATE OBJECTS FOR mp_coop_lobby_3//
//==================================//

if (GetMapName() == "mp_coop_lobby_3") {
    if (CacheTime==true) {
        // Cache Objects

        PrecacheModel("car_int_dest/car_int_dest.mdl")

        PrecacheModel("props_bts/truss_1024.mdl")

        PrecacheModel("props_bts/hanging_walkway_32a.mdl")

        PrecacheModel("props_bts/hanging_walkway_64a.mdl")

        PrecacheModel("props_gameplay/push_button.mdl")

        PrecacheModel("a4_destruction/wallpanel_256_cdest.mdl")

        PrecacheModel("props_bts/lab_pod_b.mdl")

        PrecacheModel("props_bts/hanging_walkway_128c.mdl")

        PrecacheModel("props_gameplay/push_button_mp.mdl")

        PrecacheModel("anim_wp/tv_wallpanel.mdl")

        PrecacheModel("props_bts/hanging_walkway_512a.mdl")

        PrecacheModel("props_bts/push_button_stand.mdl")

        PrecacheModel("props_gameplay/industrial_elevator_a.mdl")

        PrecacheModel("props_bts/hanging_walkway_l.mdl")

        PrecacheModel("props_bts/hanging_walkway_end_a.mdl")

        PrecacheModel("props_bts/hanging_walkway_128a.mdl")

        PrecacheModel("a4_destruction/fin3_fgwallsmash_stat.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local mp_coop_lobby_3_custom_prop_255 = CreateProp("prop_dynamic", Vector(2866.7993164062, 4066.0083007812, 218.56544494629), "models/car_int_dest/car_int_dest.mdl", 0)
        mp_coop_lobby_3_custom_prop_255.SetAngles(-4.9654488975648e-05, 90.007270812988, 0.00033569333027117)
        mp_coop_lobby_3_custom_prop_255.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_255.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_256 = CreateProp("prop_dynamic", Vector(4487.02734375, 3194.7600097656, 1002.3007202148), "models/props_bts/truss_1024.mdl", 0)
        mp_coop_lobby_3_custom_prop_256.SetAngles(-0.004768980666995, 90.00993347168, -89.979858398438)
        mp_coop_lobby_3_custom_prop_256.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_256.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_257 = CreateProp("prop_dynamic", Vector(4309.6845703125, 3848.9709472656, 934.87152099609), "models/props_bts/hanging_walkway_32a.mdl", 0)
        mp_coop_lobby_3_custom_prop_257.SetAngles(9.4053681943401e-13, -179.96661376953, 0)
        mp_coop_lobby_3_custom_prop_257.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_257.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_258 = CreateProp("prop_dynamic", Vector(4309.6938476562, 3801.0825195312, 934.97210693359), "models/props_bts/hanging_walkway_64a.mdl", 0)
        mp_coop_lobby_3_custom_prop_258.SetAngles(-4.9318552713951e-12, 0.0096746860072017, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_258.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_258.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_260 = CreateProp("prop_dynamic", Vector(4341.2495117188, 3275.2766113281, -466.67553710938), "models/props_gameplay/push_button.mdl", 0)
        mp_coop_lobby_3_custom_prop_260.SetAngles(-1.7990032796789e-09, 179.97850036621, 1.5258788153005e-05)
        mp_coop_lobby_3_custom_prop_260.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_260.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_262 = CreateProp("prop_dynamic", Vector(4128.7666015625, 2912.6416015625, 415.11779785156), "models/a4_destruction/wallpanel_256_cdest.mdl", 0)
        mp_coop_lobby_3_custom_prop_262.SetAngles(-2.2409263777945e-08, 0.016794171184301, 45)
        mp_coop_lobby_3_custom_prop_262.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_262.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_263 = CreateProp("prop_dynamic", Vector(4486.3046875, 3194.9309082031, -1043.6989746094), "models/props_bts/truss_1024.mdl", 0)
        mp_coop_lobby_3_custom_prop_263.SetAngles(-0.0047962991520762, 90.00993347168, -89.979858398438)
        mp_coop_lobby_3_custom_prop_263.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_263.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_264 = CreateProp("prop_dynamic", Vector(2872.2102050781, 3923.1462402344, 7.1514129638672), "models/props_bts/lab_pod_b.mdl", 0)
        mp_coop_lobby_3_custom_prop_264.SetAngles(1.9663194683606e-12, -179.99996948242, -0.019866943359375)
        mp_coop_lobby_3_custom_prop_264.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_264.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_265 = CreateProp("prop_dynamic", Vector(4485.943359375, 3195.0163574219, -2066.6987304688), "models/props_bts/truss_1024.mdl", 0)
        mp_coop_lobby_3_custom_prop_265.SetAngles(-0.0047826394438744, 90.00993347168, -89.979858398438)
        mp_coop_lobby_3_custom_prop_265.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_265.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_266 = CreateProp("prop_dynamic", Vector(4310.0439453125, 3193.6982421875, 934.97027587891), "models/props_bts/hanging_walkway_128c.mdl", 0)
        mp_coop_lobby_3_custom_prop_266.SetAngles(0.00072680559242144, -0.017055712640285, -0.00103759765625)
        mp_coop_lobby_3_custom_prop_266.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_266.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_268 = CreateProp("prop_dynamic", Vector(4465.8095703125, 3194.2890625, -443.65258789062), "models/props_gameplay/push_button_mp.mdl", 0)
        mp_coop_lobby_3_custom_prop_268.SetAngles(-2.4264730917362e-14, 178.69076538086, 1.5258788153005e-05)
        mp_coop_lobby_3_custom_prop_268.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_268.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_270 = CreateProp("prop_dynamic", Vector(4128.7666015625, 2912.6416015625, 415.11779785156), "models/a4_destruction/wallpanel_256_cdest.mdl", 0)
        mp_coop_lobby_3_custom_prop_270.SetAngles(-2.3135738658198e-08, 0.016794174909592, 45)
        mp_coop_lobby_3_custom_prop_270.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_270.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_272 = CreateProp("prop_dynamic", Vector(4471.2680664062, 3994.3344726562, 999.09948730469), "models/anim_wp/tv_wallpanel.mdl", 0)
        mp_coop_lobby_3_custom_prop_272.SetAngles(-1.5076302428696e-09, 179.9821472168, 1.5258788153005e-05)
        mp_coop_lobby_3_custom_prop_272.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_272.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_273 = CreateProp("prop_dynamic", Vector(4437.2983398438, 3928.9345703125, 934.95794677734), "models/props_bts/hanging_walkway_512a.mdl", 0)
        mp_coop_lobby_3_custom_prop_273.SetAngles(-2.4592139880042e-07, -89.970275878906, -0.000244140625)
        mp_coop_lobby_3_custom_prop_273.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_273.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_274 = CreateProp("prop_dynamic", Vector(4341.0341796875, 3275.1962890625, -512.59912109375), "models/props_bts/push_button_stand.mdl", 0)
        mp_coop_lobby_3_custom_prop_274.SetAngles(-6.5250097830771e-16, 179.99348449707, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_274.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_274.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_276 = CreateProp("prop_dynamic", Vector(4922.2041015625, 3995.0947265625, 999.88549804688), "models/anim_wp/tv_wallpanel.mdl", 0)
        mp_coop_lobby_3_custom_prop_276.SetAngles(-4.6967172243951e-16, -179.97393798828, 1.5258788153005e-05)
        mp_coop_lobby_3_custom_prop_276.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_276.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_277 = CreateProp("prop_dynamic", Vector(4486.666015625, 3194.8452148438, -20.699096679688), "models/props_bts/truss_1024.mdl", 0)
        mp_coop_lobby_3_custom_prop_277.SetAngles(-0.0047826394438744, 90.00993347168, -89.979858398438)
        mp_coop_lobby_3_custom_prop_277.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_277.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_278 = CreateProp("prop_dynamic", Vector(4410.1215820312, 3194.8745117188, 934.97875976562), "models/props_gameplay/industrial_elevator_a.mdl", 0)
        mp_coop_lobby_3_custom_prop_278.SetAngles(-1.8416527609588e-06, 179.9944152832, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_278.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_278.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_279 = CreateProp("prop_dynamic", Vector(4309.6748046875, 3928.8771972656, 934.99975585938), "models/props_bts/hanging_walkway_l.mdl", 0)
        mp_coop_lobby_3_custom_prop_279.SetAngles(-9.3401462508257e-14, 0.016114430502057, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_279.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_279.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_280 = CreateProp("prop_dynamic", Vector(5028.5341796875, 3929.1916503906, 934.89105224609), "models/props_bts/hanging_walkway_end_a.mdl", 0)
        mp_coop_lobby_3_custom_prop_280.SetAngles(4.0706882851495e-13, -90.013732910156, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_280.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_280.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_282 = CreateProp("prop_dynamic", Vector(4703.1455078125, 3995.3076171875, 999.20190429688), "models/anim_wp/tv_wallpanel.mdl", 0)
        mp_coop_lobby_3_custom_prop_282.SetAngles(-1.5956304751725e-16, 179.9702911377, 1.5258786334016e-05)
        mp_coop_lobby_3_custom_prop_282.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_282.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_283 = CreateProp("prop_dynamic", Vector(4340.9370117188, 3255.1354980469, 935.63037109375), "models/props_bts/push_button_stand.mdl", 0)
        mp_coop_lobby_3_custom_prop_283.SetAngles(-6.0280481413847e-16, 179.99348449707, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_283.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_283.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_284 = CreateProp("prop_dynamic", Vector(4309.9541015625, 3114.1899414062, 934.91418457031), "models/props_bts/hanging_walkway_end_a.mdl", 0)
        mp_coop_lobby_3_custom_prop_284.SetAngles(1.7533270693093e-06, 179.98181152344, -9.1552734375e-05)
        mp_coop_lobby_3_custom_prop_284.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_284.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_286 = CreateProp("prop_dynamic", Vector(4341.15234375, 3255.2158203125, 981.55395507812), "models/props_gameplay/push_button.mdl", 0)
        mp_coop_lobby_3_custom_prop_286.SetAngles(-1.7990031686566e-09, 179.97850036621, 1.5258788153005e-05)
        mp_coop_lobby_3_custom_prop_286.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_286.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_288 = CreateProp("prop_dynamic", Vector(4383.4516601562, 2913.0661621094, 415.83325195312), "models/a4_destruction/wallpanel_256_cdest.mdl", 0)
        mp_coop_lobby_3_custom_prop_288.SetAngles(4.8113383854798e-07, -0.019677247852087, 45.008220672607)
        mp_coop_lobby_3_custom_prop_288.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_288.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_289 = CreateProp("prop_dynamic", Vector(4409.509765625, 3194.5515136719, -511.90698242188), "models/props_gameplay/industrial_elevator_a.mdl", 0)
        mp_coop_lobby_3_custom_prop_289.SetAngles(0.00018374632054474, 179.98631286621, 0.0001220703125)
        mp_coop_lobby_3_custom_prop_289.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_289.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_290 = CreateProp("prop_dynamic", Vector(4948.9604492188, 3929.2145996094, 934.90234375), "models/props_bts/hanging_walkway_128a.mdl", 0)
        mp_coop_lobby_3_custom_prop_290.SetAngles(-4.0711238633723e-13, -89.999526977539, 1.52587890625e-05)
        mp_coop_lobby_3_custom_prop_290.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_290.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_292 = CreateProp("prop_dynamic", Vector(4383.4516601562, 2913.0661621094, 415.83325195312), "models/a4_destruction/wallpanel_256_cdest.mdl", 0)
        mp_coop_lobby_3_custom_prop_292.SetAngles(4.824202051168e-07, -0.019677247852087, 45.008220672607)
        mp_coop_lobby_3_custom_prop_292.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_292.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_294 = CreateProp("prop_dynamic", Vector(5058.416015625, 2553.0270996094, 235.8556060791), "models/a4_destruction/fin3_fgwallsmash_stat.mdl", 0)
        mp_coop_lobby_3_custom_prop_294.SetAngles(-4.1252001210523e-06, 179.90237426758, 90.019119262695)
        mp_coop_lobby_3_custom_prop_294.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_294.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_295 = CreateProp("prop_dynamic", Vector(4309.7124023438, 3705.7543945312, 934.62231445312), "models/props_bts/hanging_walkway_512a.mdl", 0)
        mp_coop_lobby_3_custom_prop_295.SetAngles(1.0406551176345e-08, -179.99993896484, -0.05859375)
        mp_coop_lobby_3_custom_prop_295.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_295.__KeyValueFromString("targetname", "genericcustomprop")

        local mp_coop_lobby_3_custom_prop_296 = CreateProp("prop_dynamic", Vector(2858.8579101562, 4243.7465820312, 7.7672576904297), "models/props_bts/lab_pod_b.mdl", 0)
        mp_coop_lobby_3_custom_prop_296.SetAngles(0.019562942907214, -0.00087143632117659, 0.10287475585938)
        mp_coop_lobby_3_custom_prop_296.__KeyValueFromString("solid", "6")
        mp_coop_lobby_3_custom_prop_296.__KeyValueFromString("targetname", "genericcustomprop")

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}

//=============================//
//CREATE OBJECTS FOR sp_a2_bts2//
//=============================//

if (GetMapName() == "sp_a2_bts2") {
    if (CacheTime==true) {
        // Cache Objects

        PrecacheModel("props_bts/hanging_walkway_128a.mdl")

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

//==============================//
//CREATE OBJECTS FOR sp_a4_intro//
//==============================//

if (GetMapName() == "sp_a4_intro") {
    if (CacheTime==true) {
        // Cache Objects

        PrecacheModel("props_backstage/vacum_flange_a.mdl")

        PrecacheModel("props_bts/vactube_90deg_04.mdl")

        PrecacheModel("props_bts/vactube_connector.mdl")

        PrecacheModel("props_bts/vactube_90deg_03.mdl")

        PrecacheModel("props_bts/vactube_128_straight.mdl")

        PrecacheModel("props_bts/vactube_90deg_06.mdl")

        DoneCacheing <- true
  }


    if (CreateTime==true) {
        // Create Objects

        local sp_a4_intro_custom_prop_85 = CreateProp("prop_dynamic", Vector(-495.125, -642.375, 1143.5625), "models/props_backstage/vacum_flange_a.mdl", 0)
        sp_a4_intro_custom_prop_85.SetAngles(59.6875, 60.718757629395, 111.28124237061)
        sp_a4_intro_custom_prop_85.__KeyValueFromString("solid", "0")
        sp_a4_intro_custom_prop_85.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_86 = CreateProp("prop_dynamic", Vector(-774.5625, -253.6876373291, 1026.40625), "models/props_bts/vactube_90deg_04.mdl", 0)
        sp_a4_intro_custom_prop_86.SetAngles(63.843761444092, -159.71875, 66.0625)
        sp_a4_intro_custom_prop_86.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_86.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_88 = CreateProp("prop_dynamic", Vector(-339.96875, -349.03125, 616.875), "models/props_bts/vactube_connector.mdl", 0)
        sp_a4_intro_custom_prop_88.SetAngles(-5.25093264514e-06, -20.968757629395, 119.24993896484)
        sp_a4_intro_custom_prop_88.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_88.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_89 = CreateProp("prop_dynamic", Vector(-320.39205932617, -297.9621887207, 518.37902832031), "models/props_backstage/vacum_flange_a.mdl", 0)
        sp_a4_intro_custom_prop_89.SetAngles(0.162034496665, -21.449562072754, -60.187835693359)
        sp_a4_intro_custom_prop_89.__KeyValueFromString("solid", "0")
        sp_a4_intro_custom_prop_89.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_90 = CreateProp("prop_dynamic", Vector(-762.59375, -616.3125, 1082.21875), "models/props_backstage/vacum_flange_a.mdl", 0)
        sp_a4_intro_custom_prop_90.SetAngles(58.374984741211, 59.843753814697, -159.5)
        sp_a4_intro_custom_prop_90.__KeyValueFromString("solid", "0")
        sp_a4_intro_custom_prop_90.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_92 = CreateProp("prop_dynamic", Vector(-782.25, -262.78125, 1031.75), "models/props_bts/vactube_connector.mdl", 0)
        sp_a4_intro_custom_prop_92.SetAngles(63.312507629395, -159.18748474121, 65.53125)
        sp_a4_intro_custom_prop_92.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_92.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_95 = CreateProp("prop_dynamic", Vector(-536.125, -270.625, 897.96875), "models/props_bts/vactube_90deg_03.mdl", 0)
        sp_a4_intro_custom_prop_95.SetAngles(61.15625, -171.15625, 146.25)
        sp_a4_intro_custom_prop_95.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_95.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_97 = CreateProp("prop_dynamic", Vector(-825.71868896484, -508.4375, 1093.5), "models/props_bts/vactube_connector.mdl", 0)
        sp_a4_intro_custom_prop_97.SetAngles(-61.281230926514, 21.156240463257, 172.25)
        sp_a4_intro_custom_prop_97.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_97.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_98 = CreateProp("prop_dynamic", Vector(-315.875, -286.06256103516, 495.71878051758), "models/props_bts/vactube_128_straight.mdl", 0)
        sp_a4_intro_custom_prop_98.SetAngles(0, -21, 119.28125)
        sp_a4_intro_custom_prop_98.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_98.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_99 = CreateProp("prop_dynamic", Vector(-504.5, -649.34381103516, 1137.59375), "models/props_bts/vactube_90deg_06.mdl", 0)
        sp_a4_intro_custom_prop_99.SetAngles(59.968746185303, 61.000003814697, 111.5625)
        sp_a4_intro_custom_prop_99.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_99.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_100 = CreateProp("prop_dynamic", Vector(-338.125, -344.03137207031, 606.37512207031), "models/props_bts/vactube_90deg_04.mdl", 0)
        sp_a4_intro_custom_prop_100.SetAngles(-23.937503814697, 32.062507629395, 107.03125)
        sp_a4_intro_custom_prop_100.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_100.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_101 = CreateProp("prop_dynamic", Vector(-534.65625, -272.0625, 897.93743896484), "models/props_backstage/vacum_flange_a.mdl", 0)
        sp_a4_intro_custom_prop_101.SetAngles(60.71875, -170.71875, 146.25)
        sp_a4_intro_custom_prop_101.__KeyValueFromString("solid", "0")
        sp_a4_intro_custom_prop_101.__KeyValueFromString("targetname", "genericcustomprop")

        local sp_a4_intro_custom_prop_102 = CreateProp("prop_dynamic", Vector(-767.5, -610.53131103516, 1084), "models/props_bts/vactube_90deg_03.mdl", 0)
        sp_a4_intro_custom_prop_102.SetAngles(60.0625, 61.093719482422, -158.37501525879)
        sp_a4_intro_custom_prop_102.__KeyValueFromString("solid", "6")
        sp_a4_intro_custom_prop_102.__KeyValueFromString("targetname", "genericcustomprop")

  }


    if (LoopTime==true) {
        // Generated Teleports

  }
}


if (CacheTime == true) {
  PrecacheModel("models/props/metal_box.mdl")
  DoneCacheing <- true
}

}