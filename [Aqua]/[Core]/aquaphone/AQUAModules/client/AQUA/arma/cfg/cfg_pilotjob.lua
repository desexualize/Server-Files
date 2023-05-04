local cfg = {}

cfg.startJobLocs = {
    {coords = vector3(-980.96545410156,-2950.3674316406,13.945841789246)},
}

cfg.previewPlaneLoc = {
    coords = vector3(-984.34069824219,-2996.5856933594,13.94507598877)
}

cfg.takeOffLocs = {
    {coords = vector3(-1619.5196533203,-2701.6325683594,13.0), landingCoords = vector3(-1506.3565673828,-2850.8522949219,13.98531627655), checkpointHeading = vector3(-1414.2139892578,-2345.8354492188,13.0), heading = 329.66287231445, name = "Heathrow Airport"},
    {coords = vector3(-2130.0776367188,2929.0222167969,31.4), landingCoords = vector3(-2328.15625,3043.3662109375,32.867321014404), checkpointHeading = vector3(-2532.1828613281,3161.5366210938,31.9), heading = 58.16, name = "Military Base"},
    {coords = vector3(1592.3601074219,3220.4965820313,39.0), landingCoords = vector3(1592.3601074219,3220.4965820313,39.0), checkpointHeading = vector3(1092.3825683594,3084.1840820313,39.0), heading = 104.82, name = "Sandy Airfield"},
    {coords = vector3(5511.6923828125,7130.1772460938,7.1087465286255), landingCoords = vector3(5318.822265625,7026.8720703125,9.1081638336182), checkpointHeading = vector3(5511.6923828125,7130.1772460938,9.1087465286255), heading = 115.82, name = "Paleto Airport"},
    -- {coords = vector3(2121.3637695313,4803.2065429688,39.195945739746), landingCoords = vector3(5318.822265625,7026.8720703125,9.1081638336182), checkpointHeading = vector3(1967.8039550781,4730.09765625,41.060207366943), heading = 105.0, name = "Grapeseed Airfield"},
    {coords = vector3(3074.2309570313,-4755.5502929688,13.261622428894), landingCoords = vector3(3074.2309570313,-4755.5502929688,15.261622428894), checkpointHeading = vector3(3003.4140625,-4603.666015625,15.261610031128), heading = 25.8, name = "Aircraft Carrier"},
}

cfg.pickupLocs = {
    --{coords = vector3(-1319.4471435547,-2712.2316894531,13.944933891296)},
    {id = 1, coords = vector3(-1424.0017089844,-2652.9189453125,13.944931983948), pedCoords = vector3(-1329.2408447266,-2634.6652832031,14.04655456543), tugCoords = vector4(-1403.3270263672,-2727.4719238281,13.373302459717,9.43), eligiblePlaneTiers = {1, 2, 3, 4, 5, 6, 7, 8}, name = "Heathrow Airport"}, -- LSIA
    {id = 2, coords = vector3(-1310.1878662109,-2538.3669433594,13.945156097412), pedCoords = vector3(-1322.8555908203,-2624.3864746094,14.046555519104), tugCoords = vector4(-1343.6022949219,-2561.75390625,13.944941520691,298.03887939453), eligiblePlaneTiers = {1, 2, 3, 4, 5, 6, 7, 8}, name = "Heathrow Airport"}, -- LSIA
    {id = 3, coords = vector3(-2109.021484375,2854.982421875,32.810386657715), pedCoords = vector3(-2132.2431640625,2828.9602050781,32.960144042969), tugCoords = vector4(-2145.4260253906,2846.2651367188,32.81033706665,303.57507324219), eligiblePlaneTiers = {1, 2, 3, 4, 5, 6, 7, 8}, name = "Military Base"}, -- Military Base
    {id = 4, coords = vector3(1691.0826416016,3246.0754394531,40.872756958008), pedCoords = vector3(1690.4389648438,3292.3564453125,41.146549224854), tugCoords = vector4(1748.578125,3236.8139648438,41.937980651855,75.463569641113), eligiblePlaneTiers = {1, 2, 3, 4, 5, 6, 7, 8}, name = "Sandy Airstrip"}, -- SANDY
    {id = 5, coords = vector3(5523.75390625,7196.94140625,9.1087369918823), pedCoords = vector3(5538.6240234375,7235.5986328125,9.108696937561), tugCoords = vector4(5477.1489257813,7205.4130859375,9.1087427139282,0.0), eligiblePlaneTiers = {1, 2, 3, 4, 5, 6, 7, 8}, name = "Paleto Airport"},
    -- {id = 6, coords = vector3(2121.3637695313,4803.2065429688,41.195945739746), pedCoords = vector3(2140.521484375,4782.8188476563,40.970283508301), tugCoords = vector4(2129.990234375,4779.6254882813,40.970283508301,0.0), eligiblePlaneTiers = {1, 2, 3, 4}, name = "Grapeseed Airfield"},
    {id = 7, coords = vector3(3067.8220214844,-4682.0341796875,15.258619308472), pedCoords = vector3(3080.8674316406,-4693.0854492188,15.262313842773), tugCoords = vector4(3072.5012207031,-4812.5791015625,15.26162147522,0.0), eligiblePlaneTiers = {1, 2, 3, 4, 5, 6, 7}, name = "Aircraft Carrier"},

}

cfg.dropOffLocs = {
    {coords = vector3(1679.24609375,3245.3537597656,40.767498016357), tugCoords = vector4(1508.9929199219,3088.0297851563,40.562507629395,61.94665145874), eligiblePlaneTiers = {1, 2, 3, 4, 5, 6, 7, 8}, name = "Sandy Airstrip"}, -- SANDY
    {coords = vector3(-2109.021484375,2854.982421875,32.810386657715), tugCoords = vector4(-2147.1364746094,2846.0161132813,32.810367584229,283.71343994141), eligiblePlaneTiers = {1, 2, 3, 4, 5, 6, 7, 8}, name = "Military Base"}, -- Military Base
    {coords = vector3(-1266.5324707031,-2585.4875488281,13.512182998657), tugCoords = vector4(-1233.7281494141,-2538.7387695313,13.945145606995,153.55944824219), eligiblePlaneTiers = {1, 2, 3, 4, 5, 6, 7, 8}, name = "Heathrow Airport"}, -- Heathrow
    {coords = vector3(-1184.2729492188,-2543.6335449219,13.527958679199), tugCoords = vector4(-1175.8402099609,-2580.1262207031,13.944935798645,14.457969665527), eligiblePlaneTiers = {1, 2, 3, 4, 5, 6, 7, 8}, name = "Heathrow Airport"}, -- Heathrow
    {coords = vector3(-1194.2227783203,-2611.5764160156,13.537434387207), tugCoords = vector4(-1157.443359375,-2574.5275878906,13.944944381714,113.03276824951), eligiblePlaneTiers = {1, 2, 3, 4, 5, 6, 7, 8}, name = "Heathrow Airport"}, -- Heathrow
    {coords = vector3(5523.75390625,7196.94140625,9.1087369918823), tugCoords = vector4(5477.1489257813,7205.4130859375,9.1087427139282,0.0), eligiblePlaneTiers = {1, 2, 3, 4, 5, 6, 7, 8}, name = "Paleto Airport"},
    -- {coords = vector3(2121.3637695313,4803.2065429688,41.195945739746), tugCoords = vector4(2129.990234375,4779.6254882813,40.970283508301,0.0), eligiblePlaneTiers = {1, 2, 3, 4}, name = "Grapeseed Airfield"},
    {coords = vector3(3092.8095703125,-4795.8076171875,15.261622428894), tugCoords = vector4(3072.5012207031,-4812.5791015625,15.26162147522,0.0), eligiblePlaneTiers = {1, 2, 3, 4, 5, 6, 7}, name = "Aircraft Carrier"}
}

cfg.planeSpawnLocs = {
    {coords = vector3(-1266.5324707031,-2585.4875488281,13.512182998657), h = 150.0}, -- Heathrow
    {coords = vector3(-1184.2729492188,-2543.6335449219,13.527958679199), h = 328.0}, -- Heathrow
    {coords = vector3(-1194.2227783203,-2611.5764160156,13.537434387207), h = 150.0}, -- Heathrow
    {coords = vector3(-1236.7086181641,-2607.1279296875,13.944931030273), h = 150.0}, -- Heathrow
}

cfg.tugSpawnLocs = {
    {coords = vector3(-947.40179443359,-2971.6042480469,13.945073127747), h = 93.825065612793},
    {coords = vector3(-955.42315673828,-2953.4167480469,13.945070266724), h = 86.82},
    {coords = vector3(-943.13372802734,-2967.4543457031,13.945075035095), h = 65.3},
    {coords = vector3(-941.86877441406,-2983.0695800781,13.945071220398), h = 66.1}
}

cfg.fuelStations = {
    {coords = vector3(-1339.6809082031,-2726.0158691406,14.481002807617), pedCoords = vector3(-1246.0992431641,-2709.0805664063,13.944944381714), h = 98.5}, -- Heathrow
    {coords = vector3(-1299.7957763672,-2796.939453125,13.944939613342), pedCoords = vector3(-1252.1097412109,-2828.5417480469,13.948987007141), h = 65.0}, -- Heathrow
    {coords = vector3(1524.4921875,3128.7705078125,40.531646728516), pedCoords = vector3(1609.2357177734,3181.1682128906,40.879089355469), h = 93.73}, -- Sandy
    {coords = vector3(-2479.6962890625,3259.4794921875,32.828010559082), pedCoords = vector3(-2429.4401855469,3243.1027832031,32.8284034729), h = 71.04}, -- Military Base
    {coords = vector3(5420.5830078125,7169.658203125,9.1087627410889), pedCoords = vector3(5350.1108398438,7138.6328125,9.1086711883545), h = 285.0}, -- Paleto
    -- {coords = vector3(2101.9418945313,4767.1596679688,41.195892333984), pedCoords = vector3(2102.2299804688,4751.4204101563,41.166568756104), h = 253.59}, -- Grapeseed
    {coords = vector3(3043.8625488281,-4611.0170898438,15.261431694031), pedCoords = vector3(3040.4719238281,-4579.494140625,15.261423110962), h = 44.57}, -- Aircraft Carrier
}

cfg.planeRepairStations = {
    {coords = vector3(-1231.6726074219,-2264.7431640625,13.944527626038)}, -- Heathrow
    {coords = vector3(1465.9222412109,3120.4052734375,40.534152984619)}, -- Sandy
    {coords = vector3(-2359.3637695313,3184.8823242188,32.826721191406)}, -- Mil base
    {coords = vector3(5314.8203125,7114.3544921875,9.1087436676025)}, -- Paleto Airport
}

--£150 * 50 =

cfg.planeTiers = {
    [1] = {
        tier = 1,
        level = 0,
        planeName = 'Embraer Phenom 100',
        spawnName = 'emb100',
        fuelOffsetX = 9,
        fuelOffsetY = -3,
        fuelOffsetZ = 0,
        maximumCapacity = 50,
        doorsToToggle = {0, 1, 5},
        speedToBoard = 500,
        seatPedSitsIn = 0,
        landedZ = 4,
    },
    [2] = {
        tier = 2,
        level = 10,
        planeName = 'Piaggio P.180 Avanti',
        spawnName = 'p180',
        fuelOffsetX = 9,
        fuelOffsetY = -3,
        fuelOffsetZ = 0,
        maximumCapacity = 75,
        doorsToToggle = {0, 1, 5},
        speedToBoard = 500,
        seatPedSitsIn = 0,
        landedZ = 4,
    },
    [3] = {
        tier = 3,
        level = 24,
        planeName = 'Embraer EMB 120',
        spawnName = 'emb120',
        fuelOffsetX = 9,
        fuelOffsetY = -3,
        fuelOffsetZ = 0,
        maximumCapacity = 100,
        doorsToToggle = {0, 1, 5},
        speedToBoard = 500,
        seatPedSitsIn = 0,
        landedZ = 4,
    },
    [4] = {
        tier = 4,
        level = 38,
        planeName = 'Bombardier CRJ 900',
        spawnName = 'crj900',
        fuelOffsetX = 9,
        fuelOffsetY = -15,
        fuelOffsetZ = 0,
        maximumCapacity = 200,
        doorsToToggle = {0, 1, 5},
        speedToBoard = 500,
        seatPedSitsIn = 0,
        landedZ = 6,
    },
    [5] = {
        tier = 5,
        level = 53,
        planeName = 'Bombardier Dash 8 Q400 ',
        spawnName = 'q400',
        fuelOffsetX = 9,
        fuelOffsetY = -3,
        fuelOffsetZ = 0,
        maximumCapacity = 300,
        doorsToToggle = {0, 1, 5},
        speedToBoard = 500,
        seatPedSitsIn = 0,
        landedZ = 6,
    },
    [6] = {
        tier = 6,
        level = 67,
        planeName = 'Airbus A320',
        spawnName = 'a320',
        fuelOffsetX = 9,
        fuelOffsetY = -3,
        fuelOffsetZ = 0,
        maximumCapacity = 400,
        doorsToToggle = {0, 1, 5},
        speedToBoard = 500,
        seatPedSitsIn = 0,
        landedZ = 4,
    },
    [7] = {
        tier = 7,
        level = 82,
        planeName = 'Boeing 737',
        spawnName = '737max9',
        fuelOffsetX = 9,
        fuelOffsetY = -15,
        fuelOffsetZ = 0,
        maximumCapacity = 450,
        doorsToToggle = {0, 1, 5},
        speedToBoard = 500,
        seatPedSitsIn = 0,
        landedZ = 4,
    },
    [8] = {
        tier = 8,
        level = 100,
        planeName = 'Boeing 777x9',
        spawnName = '779x',
        fuelOffsetX = 9,
        fuelOffsetY = -3,
        fuelOffsetZ = 0,
        maximumCapacity = 500,
        doorsToToggle = {0, 1, 5},
        speedToBoard = 500,
        seatPedSitsIn = 0,
        landedZ = 11,
    },
}

cfg.xp = {
    [1] = 500,
    [2] = 1500,
    [3] = 2500,
    [4] = 3500,
    [5] = 4500,
    [6] = 5500,
    [7] = 6500,
    [8] = 7500,
    [9] = 8500,
    [10] = 9500,
    [11] = 10500,
    [12] = 11500,
    [13] = 12500,
    [14] = 13500,
    [15] = 14500,
    [16] = 15500,
    [17] = 16500,
    [18] = 17500,
    [19] = 18500,
    [20] = 19500,
    [21] = 20500,
    [22] = 21500,
    [23] = 22500,
    [24] = 23500,
    [25] = 24500,
    [26] = 25500,
    [27] = 26500,
    [28] = 27500,
    [29] = 28500,
    [30] = 29500,
    [31] = 30500,
    [32] = 31500,
    [33] = 32500,
    [34] = 33500,
    [35] = 34500,
    [36] = 35500,
    [37] = 36500,
    [38] = 37500,
    [39] = 38500,
    [40] = 39500,
    [41] = 40500,
    [42] = 41500,
    [43] = 42500,
    [44] = 43500,
    [45] = 44500,
    [46] = 45500,
    [47] = 46500,
    [48] = 47500,
    [49] = 48500,
    [50] = 49500,
    [51] = 50500,
    [52] = 51500,
    [53] = 52500,
    [54] = 53500,
    [55] = 54500,
    [56] = 55500,
    [57] = 56500,
    [58] = 57500,
    [59] = 58500,
    [60] = 59500,
    [61] = 60500,
    [62] = 61500,
    [63] = 62500,
    [64] = 63500,
    [65] = 64500,
    [66] = 65500,
    [67] = 66500,
    [68] = 67500,
    [69] = 68500,
    [70] = 69500,
    [71] = 70500,
    [72] = 71500,
    [73] = 72500,
    [74] = 73500,
    [75] = 74500,
    [76] = 75500,
    [77] = 76500,
    [78] = 77500,
    [79] = 78500,
    [80] = 79500,
    [81] = 80500,
    [82] = 81500,
    [83] = 82500,
    [84] = 83500,
    [85] = 84500,
    [86] = 85500,
    [87] = 86500,
    [88] = 87500,
    [89] = 88500,
    [90] = 89500,
    [91] = 90500,
    [92] = 91500,
    [93] = 92500,
    [94] = 93500,
    [95] = 94500,
    [96] = 95500,
    [97] = 96500,
    [98] = 97500,
    [99] = 98500,
    [100] = 99500,
}

return cfg