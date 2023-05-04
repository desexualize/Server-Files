local cfg = {}

cfg.test = {
    reception = vector3(215.644, -1398.422, 30.57727),
    finishTestTpCoords = vector3(215.644, -1398.422, 30.57727),
    parkingSpaces = {
        {
            coords = vector3(214.3121, -1363.24, 30.39197),
            inUse = false,
            heading = 229.14,
        },
        {
            coords = vector3(216.7253, -1360.431, 30.39197),
            inUse = false,
            heading = 229.14,
        },
        {
            coords = vector3(218.756, -1357.661, 30.39197),
            inUse = false,
            heading = 229.14,
        },
    },
    price = 20000,
    modelName = `police2`,
    examinerModel = `s_m_y_airworker`,
    routes = {
        { -- test route 1 (bay park manoeuvre)
            { -- traffic light junction 4 way
                coords = vector3(176.2418, -1400.413, 29.33044),
                limit = 30.0,
                action = function()
                    currentTest.subtitle = "We will be going ~y~straight over ~w~at this junction"
                    Wait(2000)
                    operateHeadlights()
                end
            },
            { -- entering bypass
                coords = vector3(68.38681, -1279.873, 29.26306),
                limit = 30.0,
                action = function()
                    TriggerEvent("arma:PlaySound", "motorwayExplained")
                    currentTest.subtitle = "We are approaching the ~y~motorway~w~, a key element of the test"
                    Wait(3000)
                    currentTest.subtitle = "It is important to ~y~build up ~w~your speed ~y~appropriately"
                end
            },
            {
                coords = vector3(182.4, -1238.374, 38.12598),
                limit = 70.0,
                action = function()
                    Wait(2000)
                    policeChase()
                end
            },
            { -- bypass driving, hence high speed limit
                coords = vector3(725.6967, -1248.013, 31.97583),
                limit = 70.0,
                action = function()
                    TriggerEvent("arma:PlaySound", "leavingMotorwayTurningRight")
                    currentTest.subtitle = "We are now ~y~leaving the motorway~w~, turning ~y~right"
                    Wait(2000)
                end
            },
            {
                coords = vector3(780.1583, -1245.455, 26.56702),
                limit = 70.0,
                action = function()
                    currentTest.subtitle = "Please remember the speed limit will be changing for the ~y~residential area"
                    Wait(3000)
                    local crashScene = {
                        vehicleModel = `mule3`,
                        pedModel = `s_m_y_construct_02`,
                        startCoords = vector3(775.2923, -1318.457, 26.4491),
                        startHeading = 268.64,
                        endCoords = vector3(843.3231, -1326.382, 26.39856),
                    }
                    makeVehicleCrash(crashScene.vehicleModel, crashScene.pedModel, crashScene.startCoords, crashScene.endCoords, crashScene.startHeading)
                end
            },
            {
                coords = vector3(788.9934, -1400.532, 27.13989),
                limit = 30.0,
                action = function()
                    TriggerEvent("arma:PlaySound", "turningRightJunction")
                    currentTest.subtitle = "We are turning ~y~right ~w~at this junction"
                    Wait(2000)
                end
            },
            {
                coords = vector3(730.0088, -1429.121, 31.18384),
                limit = 40.0,
                action = function()
                    pullUpOnRight()
                end
            },
            {
                coords = vector3(572.0835, -1561.727, 28.72375),
                limit = 30.0,
                action = function()
                    TriggerEvent("arma:PlaySound", "turningRightJunction")
                    currentTest.subtitle = "We are turning ~y~right ~w~at the next junction"
                    local crashScene = {
                        vehicleModel = `forklift`,
                        pedModel = `s_m_y_construct_02`,
                        startCoords = vector3(585.4813, -1588.233, 27.22412),
                        startHeading = 303.33,
                        endCoords = vector3(573.2835, -1554.145, 28.92603),
                    }
                    makeVehicleCrash(crashScene.vehicleModel, crashScene.pedModel, crashScene.startCoords, crashScene.endCoords, crashScene.startHeading)
                end
            },
            {
                coords = vector3(500.2418, -1730.387, 29.16187),
                limit = 30.0,
                action = function()
                end
            },
            {
                coords = vector3(485.3275, -1800.475, 28.45422),
                limit = 30.0,
                action = function()
                    stopSignDetection()
                end
            },
            {
                coords = vector3(496.2725, -1875.31, 26.26379),
                limit = 30.0,
                action = function()
                    TriggerEvent("arma:PlaySound", "turningRightJunction")
                    currentTest.subtitle = "We are turning ~y~right ~w~at this junction"
                    stopSignDetection()
                end
            },
            {
                coords = vector3(496.6549, -1903.754, 25.35388),
                limit = 30.0,
                action = function()
                    Wait(500)
                    local crashScene = {
                        vehicleModel = `biff`,
                        pedModel = `s_m_y_construct_02`,
                        startCoords = vector3(465.7451, -1904.611, 25.2865),
                        startHeading = 204.42,
                        endCoords = vector3(396.1714, -2003.011, 23.34875),
                    }
                    makeVehicleCrash(crashScene.vehicleModel, crashScene.pedModel, crashScene.startCoords, crashScene.endCoords, crashScene.startHeading)
                end
            },
            { -- Stop sign
                coords = vector3(430.9451, -1935.02, 24.3429),
                limit = 30.0,
                action = function()
                    stopSignDetection()
                end
            },
            { -- Residential area
                coords = vector3(281.1692, -2015.67, 19.67542),
                limit = 30.0,
                action = function()
                    TriggerEvent("arma:PlaySound", "turningRightJunction")
                    currentTest.subtitle = "We are turning ~y~right ~w~at this junction"
                    local crashScene = {
                        vehicleModel = `mower`,
                        pedModel = `s_m_y_airworker`,
                        startCoords = vector3(261.0857, -2068.55, 16.81104),
                        startHeading = 41.5,
                        endCoords = vector3(245.5121, -2049.521, 17.51868),
                    }
                    makeVehicleCrash(crashScene.vehicleModel, crashScene.pedModel, crashScene.startCoords, crashScene.endCoords, crashScene.startHeading)
                    stopSignDetection()
                end
            },
            {
                coords = vector3(182.3736, -2036.255, 18.22632),
                limit = 30.0,
                action = function()
                    TriggerEvent("arma:PlaySound", "turningRightJunction")
                    currentTest.subtitle = "We are turning ~y~right ~w~at this junction"
                    local crashScene = {
                        vehicleModel = `scorcher`,
                        pedModel = `ig_claypain`,
                        startCoords = vector3(173.6308, -2018.809, 17.8894),
                        startHeading = 165.99,
                        endCoords = vector3(172.5626, -2081.42, 17.58606)
                        ,
                    }
                    makeVehicleCrash(crashScene.vehicleModel, crashScene.pedModel, crashScene.startCoords, crashScene.endCoords, crashScene.startHeading)
                end
            },
            {
                coords = vector3(204.1846, -1788.976, 28.92603),
                limit = 30.0,
                action = function()
                   local crashScene = {
                    vehicleModel = `bus`,
                    pedModel = `a_f_y_business_02`,
                    startCoords = vector3(201.6264, -1748.189, 28.82495),
                    startHeading = 123.83,
                    endCoords = vector3(122.6506, -1826.637, 26.55017),
                }
                Wait(2000)
                makeVehicleCrash(crashScene.vehicleModel, crashScene.pedModel, crashScene.startCoords, crashScene.endCoords, crashScene.startHeading)
                end
            },
            {
                coords = vector3(258.2637, -1698.778, 29.09448),
                limit = 30.0,
                action = function()
                    stopSignDetection()
                end
            },
            {
                coords = vector3(347.8154, -1705.82, 30.39197),
                limit = 30.0,
                action = function()
                    TriggerEvent("arma:PlaySound", "driveToTopFloor")
                    tARMA.notifyPicture(cfg.images.dict, cfg.images.govLarge, "Listen carefully for directions, drive to the top floor of the car park", "Reverse Park", "DVSA")
                    currentTest.subtitle = "Drive to the ~y~top floor ~w~of the car park"
                    drawNativeNotification("Drive to the ~y~top floor")
                end
            },
            {
                coords = vector3(361.7538, -1682.308, 47.37659),
                limit = 30.0,
                action = function()
                    TriggerEvent("arma:PlaySound", "nowReversePark")
                    PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
                    tARMA.notifyPicture(cfg.images.dict, cfg.images.govLarge, "Once at the top, you must reverse park in the marked bay.", "Reverse Park", "DVSA")
                    currentTest.subtitle = "Drive round to top and round to ~y~the right"
                    currentTest.subtitle = "~y~Reverse ~w~park in the marked bay, within the white lines"
                end
            },
            {
                coords = vector3(361.9121, -1673.248, 48.2865),
                limit = 30.0,
                action = function(currentTest)
                    local finished = false
                    local seriousIssued = false
                    SetTimeout(20000, function()
                        finished = true
                    end)
                    if not GetEntitySpeed(currentTest.vehicle) == 0.0 then
                        currentTest.subtitle = "Once you are finished, ~b~stop ~w~the vehicle"
                    end
                    while true do
                        if GetEntitySpeed(currentTest.vehicle) == 0.0 then
                            Wait(2000)
                            if GetEntitySpeed(currentTest.vehicle) == 0.0 then
                                break
                            end
                        end
                        if finished then
                            seriousIssued = true
                            issueSerious("Reverse Park - Serious")
                            break
                        end
                        Wait(0)
                    end
                    if not seriousIssued then
                        local heading = GetEntityHeading(vehicle)
                        local difference = math.abs(heading - 50.19)
                        local issueHeadingMinor = false
                        local issueHeadingSerious = false
                        if difference > 40.0 then
                            issueHeadingMinor = true
                            if difference > 60.0 then
                                issueHeadingMinor = true
                                if difference > 70.0 then
                                    issueHeadingMinor = true
                                    if difference > 90.0 then
                                        issueHeadingMinor = false
                                        issueHeadingSerious = true
                                    end
                                end
                            end
                        end
                        if issueHeadingMinor then issueMinor("Reverse Park - Heading") end
                        if issueHeadingSerious then issueSerious("Reverse Park - Heading") end
                        local coordsDifference = math.abs(#(tARMA.getPlayerCoords() - vector3(361.9121, -1673.248, 48.2865)))
                        if coordsDifference > 1.0 then
                            issueMinor("Reverse Park - Positioning")
                            if coordsDifference > 4.0 then
                                if not issueHeadingSerious then issueSerious("Reverse Park - Positioning") end  
                            end
                        end
                    end

                    tARMA.notifyPicture(cfg.images.dict, cfg.images.govLarge, "The reverse park exercise is now completed", "Reverse Park", "DVSA")
                    TriggerEvent("arma:PlaySound", "reverseParkComplete")
                    currentTest.subtitle = "Thank you, please ~y~drive down ~w~to the ~y~bottom ~w~of the car park"
                    Wait(5000)
                    currentTest.subtitle = "Follow the ~y~sat nav"
                    local crashScene = {
                        vehicleModel = `bison`,
                        pedModel = `a_f_y_business_02`,
                        startCoords = vector3(363.6396, -1696.47, 32.06006),
                        startHeading = 309.88,
                        endCoords = vector3(387.3231, -1679.143, 42.57434),
                    }
                     Wait(2000)
                     makeVehicleCrash(crashScene.vehicleModel, crashScene.pedModel, crashScene.startCoords, crashScene.endCoords, crashScene.startHeading)
                end
            },
            {
                coords = vector3(343.3451, -1704.224, 30.08862), -- Bottom level of car park, on ramp
                limit = 30.0,
                action = function()
                    TriggerEvent("arma:PlaySound", "turningRightJunction")
                    tARMA.notifyPicture(cfg.images.dict, cfg.images.govLarge, "We are turning right", "DVSA", "Directions")
                end
            },
            {
                coords = vector3(295.9912, -1681.846, 29.27991),
                limit = 30.0,
                action = function()
                    stopSignDetection()
                end
            },
            {
                coords = vector3(231.1121, -1721.354, 29.0271),
                limit = 30.0,
                action = function()
                    local crashScene = {
                        vehicleModel = `handler`,
                        pedModel = `a_m_y_indian_01`,
                        startCoords = vector3(183.8769, -1731.758, 29.27991),
                        startHeading = 209.91,
                        endCoords = vector3(205.3978, -1755.587, 29.14502),
                    }
                    makeVehicleCrash(crashScene.vehicleModel, crashScene.pedModel, crashScene.startCoords, crashScene.endCoords, crashScene.startHeading)
                    currentTest.subtitle = "We are turning ~y~right ~w~at the next junction"
                    TriggerEvent("arma:PlaySound", "turningRightJunction")
                end
            },
            {
                coords = vector3(143.3802, -1732.919, 29.12817),
                limit = 30.0,
                action = function()
                    pullUpOnRight()
                end
            },
            {
                coords = vector3(3.771429, -1690.787, 29.33044),
                limit = 30.0,
                action = function()
                    local crashScene = {
                        vehicleModel = `dump`,
                        pedModel = `s_m_y_construct_01`,
                        startCoords = vector3(-36.07912, -1685.921, 29.75171),
                        startHeading = 215.04,
                        endCoords = vector3(-4.246151, -1744.418, 29.6842),
                    }
                    makeVehicleCrash(crashScene.vehicleModel, crashScene.pedModel, crashScene.startCoords, crashScene.endCoords, crashScene.startHeading)
                    Citizen.SetTimeout(50, function()
                        TriggerEvent("arma:PlaySound", "closeCall")
                        currentTest.subtitle = "Once again, that was a ~y~close call~w~, be very careful for other vehicles"
                    end)
                end
            },
            {
                coords = vector3(-47.8945, -1705.622, 29.22925),
                limit = 30.0,
                action = function()
                    currentTest.subtitle = "We are turning ~y~right~w~ here"
                    stopSignDetection()
                end
            },
            {
                coords = vector3(-44.61099, -1647.191, 29.26306),
                limit = 30.0,
                action = function()
                    currentTest.subtitle = "We are going ~y~straight over~w~ at this junction"   
                    stopSignDetection()
                    Wait(3000)
                    local crashScene = {
                        vehicleModel = `rocoto`,
                        pedModel = `ig_claypain`,
                        startCoords = vector3(-8.149448, -1636.681, 29.33044),
                        startHeading = 50.9,
                        endCoords = vector3(-64.50989, -1633.134, 29.14502),
                    }
                    makeVehicleCrash(crashScene.vehicleModel, crashScene.pedModel, crashScene.startCoords, crashScene.endCoords, crashScene.startHeading)
                end
            },
            {
                coords = vector3(98.71649, -1478.255, 29.2124),
                limit = 30.0,
                action = function()
                    emergencyStop()
                end
            },
        },
    },
}

cfg.peds = {
    receptionist = {
        coords = vector3(214.2725, -1400.545, 30.577),
        heading = 318.42,
        model = `a_f_y_business_01`,
        eup = false,
    },
    maleReceptionist = {
        coords = vector3(215.5912, -1401.165, 30.57727),
        heading = 331.89,
        model = `a_m_y_business_02`,
        eup = false,
    },
    security1 = {
        coords = vector3(219.0198, -1392.277, 30.57727),
        heading = 318.06,
        model = `s_m_y_airworker`,
        eup = false,
    },
    security2 = {
        coords = vector3(215.1561, -1388.703, 30.57727),
        heading = 318.06,
        model = `s_m_y_airworker`,
        eup = false,
    }
}

cfg.notifications = {
    lPlatesAdded = "We've added ~r~L plates ~w~onto your vehicle. Use ~b~/dl ~w~to check your licence.",
    lPlatesAdded2 = "To apply for a licence and take a test, use /dl",
    testStartMessages = {
        "The test will last approximately ~b~10-15 ~w~minutes",
        "You will carry out both ~b~independent driving ~w~and ~b~following a sat nav",
        "You should ~b~follow all traffic signals~w~, signs and abide by ~b~speed limits",
        "This includes ~r~stop signs~w~, ~r~pedestrian crossings ~w~and other ~r~legal requirements",
        "You'll see the ~b~speed limit ~w~on your ~b~dashboard~w~",
        "You may see me using my ~b~tablet ~w~to record your ~b~test progress",
        "You may be asked to carry out an ~r~emergency stop~w~, depending on ~b~conditions",
        "You must have 0 ~r~serious ~w~faults to pass",
        "You can receive up to 15 ~y~minor ~w~faults to pass",
        "You will not be notified during the test if you make a fault",
        "We will start with ~b~following the sat nav~w~, followed by ~b~independent driving",
        "Once you are ~b~ready~w~, the test will ~b~begin",
    },
}

cfg.drivingOffences = {
    {
        name = "Driving without due care or attention",
        points = 1,
    },
    {
        name = "Driving without reasonable consideration for other road users",
        points = 1,
    },
    {
        name = "Dangerous driving",
        points = 1,
    },
    {
        name = "Causing death by driving dangerously",
        points = 6,
    },
    {
        name = "Causing serious injury by dangerous driving",
        points = 2,
    },
    {
        name = "Using a vehicle with defective tyre(s)",
        points = 1,
    },
    {
        name = "Using a mobile phone while driving",
        points = 1,
    },
    {
        name = "Driving an unsuitable vehicle, creating danger",
        points = 1,
    },
    {
        name = "Driving whilst above the alcohol limit",
        points = 1,
    },
    {
        name = "Failed to provide a specimen of breath",
        points = 1,
    },
    {
        name = "Leaving a vehicle in a dangerous position",
        points = 1,
    },
    {
        name = "Speeding",
        points = 1,
    },
    {
        name = "Aggravated taking of a vehicle",
        points = 1,
    },
}

cfg.images = {
    dict = "notification_images",
    govLarge = "gov_uk_large",
    lPlate = "lplate",
    motorway = "motorwaySign",
    dvsaLogo = "dvsa",
    endOf30 = "end_of_30",
    speed30 = "30sign",
    speed40 = "30sign",
    speed60 = "70sign",
    speed70 = "70sign",
}

cfg.buckets = {}

cfg.models = {
    camera = `speed_camera_prop`,
}

cfg.cameraSettings = {
    distance = 15.0,
    fineAmount = 5000,
}

cfg.cameras = {
	{coords = vector3(-313.09335327148, 6365.4794921875, 29.504558563232), heading = 142.21492004395, limit = 100.0},
	{coords = vector3(247.72929382324, 6582.1489257812, 30.221849441528), heading = 108.56179046631, limit = 100.0},
	{coords = vector3(246.58082580566, 6551.072265625, 30.281326293945), heading = 282.34973144531, limit = 100.0},
	{coords = vector3(-200.01051330566, 6191.9897460938, 30.260534286499), heading = 136.86869812012, limit = 100.0},
	{coords = vector3(-576.06536865234, 138.85461425781, 61.129287719727), heading = 96.358291625977, limit = 100.0},
	{coords = vector3(-76.805694580078, 243.7516784668, 100.45316314697), heading = 287.14041137695, limit = 100.0},
	{coords = vector3(-355.5266418457, 229.6459197998, 84.127494812012), heading = 292.1455078125, limit = 100.0},
	{coords = vector3(-768.63531494141, -140.49792480469, 36.833698272705), heading = 221.21095275879, limit = 100.0},
	{coords = vector3(-1294.37890625, -78.885444641113, 45.856925964355), heading = 252.89001464844, limit = 100.0},
	{coords = vector3(-1602.2126464844, -197.05024719238, 54.201755523682), heading = 154.97099304199, limit = 100.0},
	{coords = vector3(-1599.828125, -268.44033813477, 52.21167755127), heading = 357.01428222656, limit = 100.0},
	{coords = vector3(-1884.064453125, -212.4528503418, 36.709308624268), heading = 215.92694091797, limit = 100.0},
	{coords = vector3(-2007.6447753906, -396.74975585938, 10.68297290802), heading = 245.2056427002, limit = 100.0},
	{coords = vector3(-1249.7056884766, -1031.3985595703, 7.8246278762817), heading = 20.308921813965, limit = 100.0},
	{coords = vector3(-221.49765014648, -1826.2357177734, 29.058860778809), heading = 306.75637817383, limit = 100.0},
	{coords = vector3(308.73739624023, -1849.3585205078, 25.816951751709), heading = 326.54376220703, limit = 100.0},
	{coords = vector3(193.44645690918, -1927.7094726562, 21.023500442505), heading = 145.61103820801, limit = 100.0},
	{coords = vector3(307.92343139648, -2126.5124511719, 14.183793067932), heading = 52.834205627441, limit = 100.0},
	{coords = vector3(749.13873291016, -2875.9213867188, 4.7642545700073), heading = 5.5272784233093, limit = 100.0},
	{coords = vector3(764.40460205078, -2418.0314941406, 19.281719207764), heading = 2.9995336532593, limit = 100.0},
	{coords = vector3(847.4619140625, -1722.8662109375, 28.324590682983), heading = 1.374678850174, limit = 100.0},
	{coords = vector3(809.82263183594, -1391.9821777344, 26.096584320068), heading = 3.3276734352112, limit = 100.0},
	{coords = vector3(723.62268066406, -468.73403930664, 36.526546478271), heading = 235.42779541016, limit = 100.0},
	{coords = vector3(981.23883056641, -307.29656982422, 66.262893676758), heading = 244.27026367188, limit = 100.0},
	{coords = vector3(1066.974609375, -340.97689819336, 66.197937011719), heading = 65.468162536621, limit = 100.0},
	{coords = vector3(788.94177246094, -570.01666259766, 30.408819198608), heading = 6.4618906974792, limit = 100.0},
	{coords = vector3(380.86297607422, -413.78436279297, 45.325019836426), heading = 298.9801940918, limit = 100.0},
	{coords = vector3(287.38446044922, -362.38772583008, 44.222026824951), heading = 76.496238708496, limit = 100.0},
	{coords = vector3(128.24053955078, -555.38055419922, 42.453594207764), heading = 344.76092529297, limit = 100.0},
	{coords = vector3(-60.829818725586, -922.36578369141, 28.385320663452), heading = 75.734222412109, limit = 100.0},
	{coords = vector3(-523.95220947266, -1050.0533447266, 21.665824890137), heading = 11.666840553284, limit = 100.0},
	{coords = vector3(-549.78094482422, -983.91241455078, 22.354423522949), heading = 186.62350463867, limit = 100.0},
	{coords = vector3(-867.02227783203, -680.73162841797, 26.87633895874), heading = 187.39016723633, limit = 100.0},
	{coords = vector3(-290.79510498047, -1165.4747314453, 22.103891372681), heading = 184.63510131836, limit = 100.0},
	{coords = vector3(-535.66741943359, -2167.9870605469, 5.4900684356689), heading = 142.91114807129, limit = 100.0},
	{coords = vector3(1667.3176269531, 3574.6506347656, 34.435134887695), heading = 36.179054260254, limit = 100.0},
	{coords = vector3(1837.9466552734, 3796.958984375, 32.224563598633), heading = 305.12908935547, limit = 100.0},
    {coords = vector3(1424.6750488281, 3702.6884765625, 32.839839935303), heading = 113.06931304932, limit = 100.0},
	{coords = vector3(435.84646606445, 3477.4052734375, 33.567272186279), heading = 284.21960449219, limit = 100.0},
}

return cfg