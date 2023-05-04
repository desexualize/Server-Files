local cfg = {}

-- 3836.7431640625,3672.8798828125,-22.289041519165 (h tunnel)

cfg.locations = {
    {
        name = "Heroin Tunnel",
        position = vector3(3943.03125,3850.2263183594,0.58977919816971),
        blipId = 308,
        blipColour = 0,
        dinghySpawnPositions = {
            vector3(1538.7004394531,-3421.6411132813,1.3161823749542),
            vector3(1470.7769775391,-3310.1687011719,1.5306334495544),
            vector3(1472.1015625,-3249.5734863281,1.53884851932526),
            vector3(1501.5749511719,-3244.3562011719,1.5176248550415),
            vector3(1583.3776855469,-3240.3781738281,1.2071734815836),
            vector3(1580.5513916016,-3212.4206542969,1.14681793749332),
            vector3(1574.1225585938,-3159.5563964844,1.7404614686966),
        },
        dinghySpawnHeading = 270.0,
        rewardObjects = {
            {
                objectModel = `prop_ld_gold_chest`,
                objectPosition = vector3(3919.6118164063,3822.9753417969,-27.75155807495),
                objectRotation = 0.0,
            },
            {
                objectModel = `sarcophagus`,
                objectPosition = vector3(3834.227, 3668.916, -24.63729),
                objectRotation = 330.49807739258,
            },
            {
                objectModel = `crate`,
                objectPosition = vector3(3950.958, 3937.384, -22.88795),
                objectRotation = 30.89896774292,
            },
            {
                objectModel = `cashbox`,
                objectPosition = vector3(4132.818, 3888.698, -43.1686),
                objectRotation = 359.49996948242,
            },
            {
                objectModel = `prop_cash_crate_01`,
                objectPosition = vector3(3959.058, 3775.094, -11.53899),
                objectRotation = 0.0,
            },
            {
                objectModel = `ba_prop_battle_crate_m_bones`,
                objectPosition = vector3(4048.725, 4028.445, -23.68146),
                objectRotation = 348.69931030273,
            },
        }
    },
    {
        name = "Boat Crash",
        position = vector3(3148.1945800781,-410.68237304688,0.55738359689713),
        blipId = 308,
        blipColour = 0,
        dinghySpawnPositions = {
            vector3(1538.7004394531,-3421.6411132813,1.3161823749542),
            vector3(1470.7769775391,-3310.1687011719,1.5306334495544),
            vector3(1472.1015625,-3249.5734863281,1.53884851932526),
            vector3(1501.5749511719,-3244.3562011719,1.5176248550415),
            vector3(1583.3776855469,-3240.3781738281,1.2071734815836),
            vector3(1580.5513916016,-3212.4206542969,1.14681793749332),
            vector3(1574.1225585938,-3159.5563964844,1.7404614686966),
        },
        dinghySpawnHeading = 270.0,
        rewardObjects = {
            {
                objectModel = `ex_prop_crate_clothing_sc`,
                objectPosition = vector3(3123.189, -216.6044, -26.0675),
                objectRotation = 0.0,
            },
            {
                objectModel = `ex_prop_crate_oegg`,
                objectPosition = vector3(3156.793, -311.0932, -28.94106),
                objectRotation = 0.0,
            },
            {
                objectModel = `sm_prop_smug_crate_l_bones`,
                objectPosition = vector3(3199.266, -378.1059, -34.97596),
                objectRotation = 51.398975372314,
            },
            {
                objectModel = `prop_air_cargo_04a`,
                objectPosition = vector3(3220.976, -432.7551, -41.5532),
                objectRotation = 0.0,
            },
            {
                objectModel = `prop_cash_crate_01`,
                objectPosition = vector3(3120.559, -343.6702, -25.6883),
                objectRotation = 6.0999722480774,
            },
            {
                objectModel = `prop_mb_crate_01a`,
                objectPosition = vector3(3297.567, -405.8094, -124.4407),
                objectRotation = 356.7998046875,
            },
        }
    },
    {
        name = "Plane Crash",
        position = vector3(-3245.240234375,3680.9965820313,2.8097310066223),
        blipId = 308,
        blipColour = 0,
        dinghySpawnPositions = {
            vector3(-2489.2529296875,-448.02554321289,2.1954853534698),
            vector3(-2516.1293945313,-422.66180419922,1.65920442342758),
            vector3(-2531.1633300781,-431.18478393555,1.09173234552145),
            vector3(-2525.3356933594,-454.18215942383,1.11437081545591),
            vector3(-2512.6689453125,-500.13671875,1.15058591961861),
            vector3(-2521.671875,-531.48205566406,1.43900012969971),
            vector3(-2546.8256835938,-515.99792480469,1.97740536928177),
        },
        dinghySpawnHeading = 270.0,
        rewardObjects = {
            {
                objectModel = `ex_prop_crate_clothing_sc`,
                objectPosition = vector3(-3278.955, 3721.978, -97.86664),
                objectRotation = 316.99700927734,
            },
            {
                objectModel = `ex_prop_crate_oegg`,
                objectPosition = vector3(-3354.209, 3552.785, -60.67598),
                objectRotation = 349.19934082031,
            },
            {
                objectModel = `sm_prop_smug_crate_l_bones`,
                objectPosition = vector3(-3248.666, 3538.611, -27.94324),
                objectRotation = 36.999568939209,
            },
            {
                objectModel = `prop_air_cargo_04a`,
                objectPosition = vector3(-3131.491, 3743.83, -41.89578),
                objectRotation = 0.0,
            },
            {
                objectModel = `prop_cash_crate_01`,
                objectPosition = vector3(-3251.485, 3672.058, -34.67615),
                objectRotation = 0.0,
            },
            {
                objectModel = `prop_mb_crate_01a`,
                objectPosition = vector3(-3236.375, 3673.126, -40.67204),
                objectRotation = 0.0,
            },
        }
    },
}

cfg.jobPosition = vector3(-2195.6926269531,-394.82040405273,13.313161849976)
cfg.jobPedModel = `mp_m_freemode_01`
cfg.jobPedPosition = vector3(-2197.0366210938,-393.71792602539,12.313159942627)
cfg.jobPedHeading = 230.0
cfg.payPerItemMin = 15000
cfg.payPerItemMax = 25000

return cfg