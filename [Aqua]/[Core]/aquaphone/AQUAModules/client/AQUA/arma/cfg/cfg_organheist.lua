local cfg = {}

cfg.locations = {
    { -- Top Floor
        safePositions = {
            vector3(247.13032531738, -1371.6429443359, 39.534332275391),
            vector3(243.35469055176, -1376.2249755859, 39.534332275391)
        },
        pastGate = vector3(253.64044189453, -1363.8403320312, 39.534366607666),
        gunStores = {
            ["police"] = {
                { "Organ Heist Small Arms", "policeSmallArms", vector3(229.17727661133, -1368.5501708984, 38.534297943115) },
                { "Organ Heist Large Arms", "policeLargeArms", vector3(253.12821960449, -1387.9049072266, 38.534397125244) }
            },
            ["civ"] = {
                { "Organ Heist Large Arms", "LargeArmsDealer", vector3(253.12821960449, -1387.9049072266, 38.534397125244) }
            }
        },
        atmLocation = vector3(246.65653991699, -1384.5322265625, 39.534397125244)
    },
    { -- Bottom Floor
        safePositions = {
            vector3(279.53131103516, -1336.73046875, 24.53777885437),
            vector3(292.75506591797,-1349.1447753906,24.537817001343)
        },
        pastGate = vector3(243.51522827148, -1366.9970703125, 24.537815093994),
        gunStores = {
            ["police"] = {
                { "Organ Heist Small Arms", "policeSmallArms", vector3(295.27334594727, -1351.6274414062, 23.534603118896) },
                { "Organ Heist Large Arms", "policeLargeArms", vector3(285.91827392578, -1351.0128173828, 23.534603118896) }
            },
            ["civ"] = {
                { "Organ Heist Large Arms", "LargeArmsDealer", vector3(285.91827392578, -1351.0128173828, 23.534603118896) }
            }
        },
        atmLocation = vector3(294.95745849609, -1347.8728027344, 24.534603118896)
    }
}

return cfg