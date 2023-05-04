local cfg = {}

cfg.DebugMode = false
cfg.HideRadar = true

cfg.Locations = {
    {
        camBox = {label = "Prison", position=vector3(1781.6635742188,2592.0603027344,50.549640655518), distance = 100},
        cameras = {
            {label = "Main Gate", x = 1828.9827880859,y=2605.8652343754, z = 46.780555725098, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
            {label = "Main Cell Area", x = 1772.7540283203, y = 2570.7924804688, z = 52.968448638916, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
            {label = "CourtYard", x = 1665.5668945313,y =2502.8210449219, z = 59.570770263672, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
            {label = "Gym", x = 1774.4464111328,y = 2590.798828125,z=47.150611877441, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
            {label = "Main Entrance", x = 1790.2834472656, y = 2598.4201660156, z =47.785297393799, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
            {label = "Belmarsh Reception", x = 1838.2687988281, y = 2584.3134765625,z = 47.72306060791, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
            {label = "Hallway #1", x = 1826.9315185547, y = 2586.0783691406, z =47.656944274902, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
            {label = "Hallway #2", x = 1828.7459716797, y = 2595.7124023438, z = 47.514507293701, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
            {label = "Guard Tower #8", x = 1774.7644042969,y = 2758.8286132813, z = 60.806247711182, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
            {label = "Guard Tower #7", x = 1651.6750488281, y = 2754.5285644531, z = 60.762157440186, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
            {label = "Guard Tower #6", x = 1572.3323974609, y = 2677.1850585938, z = 60.340915679932, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
            {label = "Guard Tower #3", x = 1655.8879394531, y = 2397.7983398438, z = 60.270748138428, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
        },
        allowedModels = {}
    },
    {
        camBox = {label = "Pacific Standard Bank", position=vector3(283.67,264.41, 105.80), distance = 100},
        cameras = {
            {label = "Camera 1", x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false},
            {label = "Camera 2", x = 269.66, y = 223.67, z = 113.23, r = {x = -30.0, y = 0.0, z = 111.29}, canRotate = false},
            {label = "Camera 3", x = 241.64, y = 233.83, z = 111.48, r = {x = -35.0, y = 0.0, z = 120.46}, canRotate = false},
            {label = "Camera 4", x = 232.86, y = 221.46, z = 107.83, r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = false},
            {label = "Camera 5", x = 261.50, y = 218.08, z = 107.95, r = {x = -25.0, y = 0.0, z = -149.49}, canRotate = false},
            {label = "Camera 6", x = 261.98, y = 217.92, z = 113.25, r = {x = -40.0, y = 0.0, z = -159.49}, canRotate = false},
            {label = "Camera 7", x = 258.44, y = 204.97, z = 113.25, r = {x = -30.0, y = 0.0, z = 10.50}, canRotate = false},
            {label = "Camera 8", x = 235.53, y = 227.37, z = 113.23, r = {x = -35.0, y = 0.0, z = -160.29}, canRotate = false},
            {label = "Camera 9", x = 254.72, y = 206.06, z = 113.28, r = {x = -35.0, y = 0.0, z = 44.70}, canRotate = false},
            {label = "Camera 10", x = 269.89, y = 223.76, z = 106.48, r = {x = -35.0, y = 0.0, z = 112.62}, canRotate = false},
            {label = "Camera 11", x = 252.27, y = 225.52, z = 103.99, r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false},
            {label = "Camera 12", x = 251.65, y = 218.66, z = 104.5, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true}
        },
        allowedModels = {}
    },
    {
        camBox = {label = "Underground Facility", position=vector3(330.32455444336, 4830.6352539063, -59.401977539063), distance = 100},
        cameras = {
            {label = "Sandy Shores", x = 1804.9689941406, y = 3284.3071289063, z = 53.587226867676, r = {x = 0.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Heroin Trader 1", x = 3437.0341796875, y = 3673.2058105469, z = 44.301898956299, r = {x = -30.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Heroin Gather 1", x = 459.78875732422, y = 6458.5859375, z = 32.739002227783, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Meth Trader", x = -635.58178710938, y = 5260.1630859375, z = 88.018966674805, r = {x = -25.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Strip Club 1", x = 154.2278137207, y = -1346.3109130859, z = 37.716087341309, r = {x = -25.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Strip Club 2", x = 37.888538360596, y = -1272.5404052734,z = 37.649688720703, r = {x = -40.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Legion 1", x = 102.69011688232,y = -966.15393066406,z = 40.180961608887, r = {x = -30.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Grove Street", x = 47.152168273926,y = -1882.3848876953,z = 31.7063331604, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Bank of England", x = 180.1768951416,y = 181.05235290527,z = 123.0782699585, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Meth Processor", x = 1534.7780761719,y = 2141.1943359375,z = 90.358840942383, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Gold Processor", x = 2669.1564941406,y = 1496.5772705078,z = 40.426258087158, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Highway", x = 748.57244873047,y = -40.046051025391,z = 85.78377532959, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Highway", x = 1303.0772705078, y = 3501.4509277344,z = 53.816635131836, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Madrazo's Ranch",x = 1395.1883544922, y = 1114.4820556641, z = 122.53203582764, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Rebel #1",x = 1421.4866943359, y = 6342.6225585938, z = 28.707288742065, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Rebel #2",x = 1526.1177978516, y = 6329.12890625, z = 28.07043838501, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "LSD #1",x = 1331.9489746094, y = 4327.5849609375, z = 46.629688262939, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "LSD #2",x = 1382.0235595703, y = 4306.0395507812, z = 47.513107299805, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "LargeArms",x = 1-1147.4809570312, y = 4943.2944335938, z = 230.04696655273, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
        },
        allowedModels = {}
    },
    {
        camBox = {label = "Avon Hertz Mt.Chilliad Bunker", position=vector3(555.69934082031,5952.515625,-157.98817443848), distance = 100},
        cameras = {
            {label = "Sandy Shores", x = 1804.9689941406, y = 3284.3071289063, z = 53.587226867676, r = {x = 0.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Heroin Trader 1", x = 3437.0341796875, y = 3673.2058105469, z = 44.301898956299, r = {x = -30.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Heroin Gather 1", x = 459.78875732422, y = 6458.5859375, z = 32.739002227783, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Meth Trader", x = -635.58178710938, y = 5260.1630859375, z = 88.018966674805, r = {x = -25.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Strip Club 1", x = 154.2278137207, y = -1346.3109130859, z = 37.716087341309, r = {x = -25.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Strip Club 2", x = 37.888538360596, y = -1272.5404052734,z = 37.649688720703, r = {x = -40.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Legion 1", x = 102.69011688232,y = -966.15393066406,z = 40.180961608887, r = {x = -30.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Grove Street", x = 47.152168273926,y = -1882.3848876953,z = 31.7063331604, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Bank of England", x = 180.1768951416,y = 181.05235290527,z = 123.0782699585, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Meth Processor", x = 1534.7780761719,y = 2141.1943359375,z = 90.358840942383, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Gold Processor", x = 2669.1564941406,y = 1496.5772705078,z = 40.426258087158, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Highway", x = 748.57244873047,y = -40.046051025391,z = 85.78377532959, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Highway", x = 1303.0772705078, y = 3501.4509277344,z = 53.816635131836, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Madrazo's Ranch",x = 1395.1883544922, y = 1114.4820556641, z = 122.53203582764, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Madrazo's Ranch",x = 1395.1883544922, y = 1114.4820556641, z = 122.53203582764, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Rebel #1",x = 1421.4866943359, y = 6342.6225585938, z = 28.707288742065, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Rebel #2",x = 1526.1177978516, y = 6329.12890625, z = 28.07043838501, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "LSD #1",x = 1331.9489746094, y = 4327.5849609375, z = 46.629688262939, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "LSD #2",x = 1382.0235595703, y = 4306.0395507812, z = 47.513107299805, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "LargeArms",x = 1-1147.4809570312, y = 4943.2944335938, z = 230.04696655273, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
        },
        allowedModels = {}
    },
    {
        camBox = {label = "IAA Facility", position=vector3(2067.8063964844,2993.572265625,-63.501808166504), distance = 100},
        cameras = {
            {label = "Sandy Shores", x = 1804.9689941406, y = 3284.3071289063, z = 53.587226867676, r = {x = 0.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Heroin Trader 1", x = 3437.0341796875, y = 3673.2058105469, z = 44.301898956299, r = {x = -30.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Heroin Gather 1", x = 459.78875732422, y = 6458.5859375, z = 32.739002227783, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Meth Trader", x = -635.58178710938, y = 5260.1630859375, z = 88.018966674805, r = {x = -25.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Strip Club 1", x = 154.2278137207, y = -1346.3109130859, z = 37.716087341309, r = {x = -25.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Strip Club 2", x = 37.888538360596, y = -1272.5404052734,z = 37.649688720703, r = {x = -40.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Legion 1", x = 102.69011688232,y = -966.15393066406,z = 40.180961608887, r = {x = -30.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Grove Street", x = 47.152168273926,y = -1882.3848876953,z = 31.7063331604, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Bank of England", x = 180.1768951416,y = 181.05235290527,z = 123.0782699585, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Meth Processor", x = 1534.7780761719,y = 2141.1943359375,z = 90.358840942383, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Gold Processor", x = 2669.1564941406,y = 1496.5772705078,z = 40.426258087158, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Highway", x = 748.57244873047,y = -40.046051025391,z = 85.78377532959, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Highway", x = 1303.0772705078, y = 3501.4509277344,z = 53.816635131836, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Madrazo's Ranch",x = 1395.1883544922, y = 1114.4820556641, z = 122.53203582764, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Madrazo's Ranch",x = 1395.1883544922, y = 1114.4820556641, z = 122.53203582764, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Rebel #1",x = 1421.4866943359, y = 6342.6225585938, z = 28.707288742065, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Rebel #2",x = 1526.1177978516, y = 6329.12890625, z = 28.07043838501, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "LSD #1",x = 1331.9489746094, y = 4327.5849609375, z = 46.629688262939, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "LSD #2",x = 1382.0235595703, y = 4306.0395507812, z = 47.513107299805, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "LargeArms",x = 1-1147.4809570312, y = 4943.2944335938, z = 230.04696655273, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
        },
        allowedModels = {}
    },
    {
        camBox = {label = "Server Room", position=vector3(2173.8017578125,2915.1379394531,-81.101417541504), distance = 100},
        cameras = {
            {label = "Sandy Shores", x = 1804.9689941406, y = 3284.3071289063, z = 53.587226867676, r = {x = 0.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Heroin Trader 1", x = 3437.0341796875, y = 3673.2058105469, z = 44.301898956299, r = {x = -30.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Heroin Gather 1", x = 459.78875732422, y = 6458.5859375, z = 32.739002227783, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Meth Trader", x = -635.58178710938, y = 5260.1630859375, z = 88.018966674805, r = {x = -25.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Strip Club 1", x = 154.2278137207, y = -1346.3109130859, z = 37.716087341309, r = {x = -25.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Strip Club 2", x = 37.888538360596, y = -1272.5404052734,z = 37.649688720703, r = {x = -40.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Legion 1", x = 102.69011688232,y = -966.15393066406,z = 40.180961608887, r = {x = -30.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Grove Street", x = 47.152168273926,y = -1882.3848876953,z = 31.7063331604, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Bank of England", x = 180.1768951416,y = 181.05235290527,z = 123.0782699585, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Meth Processor", x = 1534.7780761719,y = 2141.1943359375,z = 90.358840942383, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Gold Processor", x = 2669.1564941406,y = 1496.5772705078,z = 40.426258087158, r = {x = -35.0, y = 0.0, z = 0.0,}, canRotate = true},
            {label = "Highway", x = 748.57244873047,y = -40.046051025391,z = 85.78377532959, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Highway", x = 1303.0772705078, y = 3501.4509277344,z = 53.816635131836, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Madrazo's Ranch",x = 1395.1883544922, y = 1114.4820556641, z = 122.53203582764, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Madrazo's Ranch",x = 1395.1883544922, y = 1114.4820556641, z = 122.53203582764, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Rebel #1",x = 1421.4866943359, y = 6342.6225585938, z = 28.707288742065, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "Rebel #2",x = 1526.1177978516, y = 6329.12890625, z = 28.07043838501, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "LSD #1",x = 1331.9489746094, y = 4327.5849609375, z = 46.629688262939, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "LSD #2",x = 1382.0235595703, y = 4306.0395507812, z = 47.513107299805, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
            {label = "LargeArms",x = 1-1147.4809570312, y = 4943.2944335938, z = 230.04696655273, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true},
        },
        allowedModels = {}
    },
    {
        camBox = {label = "Asda", position=vector3(29.249979019165, -1338.5229492188,29.521314239502), distance = 100},
        cameras = {
            {label = "Camera 1", x = 34.24, y = -1349.66,z = 35.45, r = {x = 0.0, y = 0.0, z = 130.77}, canRotate = true},
            {label = "Camera 2", x = 23.39, y = -1349.86,z = 35.44, r = {x = 0.0, y = 0.0, z = -170.74}, canRotate = true},
            {label = "Camera 3", x = 24.20, y = -1342.64,z = 31.22, r = {x = 0.0, y = 0.0, z = -126.0}, canRotate = true},
            {label = "Camera 4", x = 34.46, y = -1348.33,z = 31.22, r = {x = 0.0, y = 0.0, z = 70.0}, canRotate = true},
        },
        allowedModels = {}
    },
    {
        camBox = {label = "Twenty Four Seven. (Paleto Bay)", position=vector3(1735.6752929688,  6420.7436523438,35.21533203125), distance = 100},
        cameras = {
            {label = "Camera 1", x = 1729.31, y = 6419.67, z = 36.75, r = {x = 0.0, y = 0.0, z = -142.77}, canRotate = true},
            {label = "Camera 2", x = 1736.32, y = 6409.85, z = 37.01, r = {x = 0.0, y = 0.0, z = 37.74}, canRotate = true},
            {label = "Camera 3", x = 1740.05, y = 6406.33, z = 38.11, r = {x = 0.0, y = 0.0, z = 37.0}, canRotate = true},
            {label = "Camera 4", x = 1720.65, y = 6413.33, z = 38.41, r = {x = 0.0, y = 0.0, z = -147.0}, canRotate = true},
        },
        allowedModels = {}
    },
    {
        camBox = {label = "Twenty Four Seven. (Little Seoul)", position=vector3(-710.2, -905.9, 19.3), distance = 100},
        cameras = {
            {label = "Camera 1", x = -705.77, y = -909.22, z = 21.29, r = {x = 0.0, y = 0.0, z = 143.77}, canRotate = true},
            {label = "Camera 2", x = -718.47, y = -915.42, z = 21.64, r = {x = 0.0, y = 0.0, z = -65.74}, canRotate = true},
            {label = "Camera 3", x = -697.77, y = -917.22, z = 23.7, r = {x = 0.0, y = 0.0, z = -123.0}, canRotate = true},
            {label = "Camera 4", x = -721.20, y = -917.01, z = 23.54, r = {x = 0.0, y = 0.0, z = 118.0}, canRotate = true},
        },
        allowedModels = {}
    },
    {
        camBox = {label = "Twenty Four Seven. (South Los Santos)", position=vector3(-44.991291046143,-1749.3002929688,29.765663146973), distance = 100},
        cameras = {
            {label = "Camera 1", x = -43.34, y = -1755.22, z = 31.12, r = {x = 0.0, y = 0.0, z = 87.77}, canRotate = true},
            {label = "Camera 2", x = -57.18, y = -1752.11, z = 31.66, r = {x = 0.0, y = 0.0, z = -99.74}, canRotate = true},
            {label = "Camera 3", x = -48.18, y = -1762.11, z = 32.06, r = {x = 0.0, y = 0.0, z = 109.0}, canRotate = true},
        },
        allowedModels = {}
    },
    {
        camBox = {label = "Twenty Four Seven. (Vinewood)", position=vector3(378.25091552734, 333.32968139648,103.56633758545), distance = 100},
        cameras = {
            {label = "Camera 1", x = 373.77, y = 330.22, z = 105.29, r = {x = 0.0, y = 0.0, z = -133.77}, canRotate = true},
            {label = "Camera 2", x = 381.57, y = 322.92, z = 105.29, r = {x = 0.0, y = 0.0, z = 51.74}, canRotate = true},
            {label = "Camera 3", x = 368.77, y = 324.22, z = 106.29, r = {x = 0.0, y = 0.0, z = -156.0}, canRotate = true},
        },
        allowedModels = {}
    },
    {
        camBox = {label = "Twenty Four Seven. (Sandy Shores)", position=vector3(2673.0263671875,3286.85546875,55.241115570068), distance = 100},
        cameras = {
            {label = "Camera 1", x = 2674.17, y = 3281.22, z = 57.29, r = {x = 0.0, y = 0.0, z = -65.77}, canRotate = true},
            {label = "Camera 2", x = 2682.17, y = 3286.22, z = 57.00, r = {x = 0.0, y = 0.0, z = 121.74}, canRotate = true},
            {label = "Camera 3", x = 2687.17, y = 3288.22, z = 58.29, r = {x = 0.0, y = 0.0, z = -176.0}, canRotate = true},
        },
        allowedModels = {}
    },
    {
        camBox = {label = "Limited LTD Gas Stop. (East Los Santos)", position=vector3(1159.5865478516, -316.55865478516,69.205039978027), distance = 100},
        cameras = {
            {label = "Camera 1", x = 1164.77, y = -319.22, z = 70.29, r = {x = 0.0, y = 0.0, z = 136.77}, canRotate = true},
            {label = "Camera 2", x = 1153.77, y = -326.22, z = 71.29, r = {x = 0.0, y = 0.0, z = -52.74}, canRotate = true},
            {label = "Camera 3", x = 1167.77, y = -325.22, z = 72.29, r = {x = 0.0, y = 0.0, z = 155.0}, canRotate = true},
        },
        allowedModels = {}
    },
}

return cfg