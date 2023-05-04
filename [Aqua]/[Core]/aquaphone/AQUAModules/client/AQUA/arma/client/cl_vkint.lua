local a = {
    [1] = {id = 1, position = vector3(344.96, -586.44, 28.8), name = "Lower Reception", destination = {2, 3}},
    [2] = {id = 2, position = vector3(332.0, -595.61, 43.28), name = "Main Floor", destination = {1, 3}},
    [3] = {
        id = 3,
        position = vector3(340.75866699218, -585.24932861328, 74.165649414062),
        name = "Helipad",
        destination = {1, 2}
    },
    [59] = {
        id = 59,
        position = vector3(470.19061279296, -984.85455322266, 30.689586639404),
        name = "PD Main Floor",
        destination = {69, 68, 72},
        permission = "police"
    },
    [68] = {
        id = 68,
        position = vector3(-1964.76953125, 3031.8662109375, 32.810302734375),
        name = "SCO19 Training Grounds",
        destination = {59},
        permission = "police"
    },
    [69] = {
        id = 69,
        position = vector3(405.72525024414, -996.65222167968, -99.004089355468),
        name = "Photo Room",
        destination = {59},
        permission = "police"
    },
    [72] = {
        id = 72,
        position = vector3(1851.3275146484, 3697.2602539063, 34.286640167236),
        name = "Sandy PD",
        destination = {59},
        permission = "police"
    },
    [74] = {
        id = 74,
        position = vector3(-2173.7785644531, 5142.5498046875, 2.8199977874756),
        name = "VIP Island",
        destination = {75}
    },
    [75] = {
        id = 75,
        position = vector3(-2335.204, 266.0559, 169.602),
        name = "Kortz Center",
        destination = {74}
    },
    [95] = {
        id = 95,
        position = vector3(-1946.8928222656, -12.381518363953, 91.674758911133),
        name = "Enter Church",
        destination = {96}
    },
    [96] = {
        id = 96,
        position = vector3(-1685.0211181641, -291.7692565918, 51.891021728516),
        name = "Exit Church",
        destination = {95}
    },
    [99] = {
        id = 99,
        position = vector3(2027.53515625, 2981.8500976563, -61.901752471924),
        name = "Bunker",
        destination = {100}
    },
    [100] = {
        id = 100,
        position = vector3(-1118.0910644531, -824.70050048828, -42.869873046875),
        name = "Conference Room",
        destination = {99}
    },
    [103] = {
        id = 103,
        position = vector3(363.03964233398, -588.39758300781, 17.756856918335),
        name = "Under NHS",
        destination = {1}
    },
    [106] = {
        id = 106,
        position = vector3(1138.0489501953, -3198.6245117188, -39.665672302246),
        name = "Black Market Dealer",
        destination = {107}
    },
    [107] = {
        id = 107,
        position = vector3(1417.0650634766, 6339.5825195313, 24.393590927124),
        name = "Rebel Area",
        destination = {106}
    },
    [112] = {
        id = 112,
        position = vector3(897.85614013672, -3246.0866699219, -98.161605834961),
        name = "Weapons Bunker",
        destination = {113}
    },
    [113] = {
        id = 113,
        position = vector3(893.94293212891, -3246.3696289063, -98.262252807617),
        name = "Weapons Bunker",
        destination = {112}
    },
    [114] = {
        id = 114,
        position = vector3(-44.856662750244, -1289.9702148438, 29.16810798645),
        name = "Exit",
        destination = {115}
    },
    [115] = {
        id = 115,
        position = vector3(-47.275672912598, -1290.0, 29.599639892578),
        name = "Boxing Gym",
        destination = {114}
    },
    [116] = {
        id = 116,
        position = vector3(1088.580078125, -3188.4384765625, -38.993461608886),
        name = "Cocaine",
        destination = {117}
    },
    [117] = {
        id = 117,
        position = vector3(346.27151489258, 3406.7160644532, 36.521125793458),
        name = "Cocaine",
        destination = {116}
    },
    [118] = {
        id = 118,
        position = vector3(1551.8762207032, 2154.5729980468, 78.911338806152),
        name = "Meth",
        destination = {119}
    },
    [119] = {
        id = 119,
        position = vector3(997.95867919922, -3200.9221191406, -36.39362335205),
        name = "Meth",
        destination = {118}
    },
    [120] = {
        id = 120,
        position = vector3(1065.2957763672, -3183.2448730468, -39.163402557374),
        name = "Weed",
        destination = {121}
    },
    [121] = {
        id = 121,
        position = vector3(2847.7001953125, 4450.0654296875, 48.514518737792),
        name = "Weed",
        destination = {120}
    },
    [122] = {
        id = 122,
        position = vector3(-754.46405029297, 5578.9555664063, 36.709617614746),
        name = "Poseidon Casino",
        destination = {123}
    },
    [123] = {
        id = 123,
        position = vector3(-10.592629432678, 6726.248046875, -101.74806213379),
        name = "Poseidon Casino",
        destination = {122}
    },
    [124] = {
        id = 124,
        position = vector3(-2360.6904296875, 3249.7653808594, 32.810707092285),
        name = "Tower Ground Floor",
        destination = {125}
    },
    [125] = {id = 125, position = vector3(-2360.697, 3249.581, 92.90363), name = "Tower Top Floor", destination = {124}},
    [126] = {
        id = 126,
        position = vector3(2521.0390625, -279.24157714844, -58.72301864624),
        name = "Level 3",
        destination = {127, 128}
    },
    [127] = {
        id = 127,
        position = vector3(2518.3649902344, -278.87112426758, -64.722877502441),
        name = "Level 2",
        destination = {126, 128}
    },
    [128] = {
        id = 128,
        position = vector3(2521.0788574219, -279.22937011719, -70.722679138184),
        name = "Level 1",
        destination = {126, 127}
    },
    [129] = {
        id = 129,
        position = vector3(-304.40200805664, 6286.8256835938, 31.492467880249),
        name = "Hut",
        destination = {130}
    },
    [130] = {
        id = 130,
        position = vector3(-302.76281738281, 6288.3940429688, 31.644655227661),
        name = "Hut",
        destination = {129}
    },
    [131] = {
        id = 131,
        position = vector3(272.0016784668, -646.15026855469, -16.6628074646),
        name = "Integrity Apartments",
        destination = {132}
    },
    [132] = {
        id = 132,
        position = vector3(287.44244384766, -645.05639648438, 42.01859664917),
        name = "Integrity Lobby",
        destination = {131}
    },
}

RMenu.Add("vkint","mainmenu",RageUI.CreateMenu("Teleporter", "Main Menu", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight()))
local b = nil
local function c(d)
    if tARMA.getPlayerCombatTimer() > 0 then
        tARMA.notify("~r~You can not teleport whilst you have a combat timer.")
        return
    end
    local e = tARMA.getPlayerPed()
    NetworkFadeOutEntity(e, true, false)
    DoScreenFadeOut(500)
    Citizen.Wait(500)
    SetEntityCoords(e, d.position.x, d.position.y, d.position.z, 1, 0, 0, 1)
    SetEntityHeading(e, d.h)
    NetworkFadeInEntity(e, 0)
    Citizen.Wait(500)
    DoScreenFadeIn(500)
end

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('vkint', 'mainmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if b then
                for f, g in pairs(b.destination) do
                    local h = a[g]
                    RageUI.Button(h.name,"",{},true,function(i, j, k)
                        if k then
                            c(h)
                        end
                    end)
                end
            end
       end)
    end
end)

local function l(d)
    if d.permission == "police" and not globalOnPoliceDuty then
        return
    end
    b = d
    RageUI.Visible(RMenu:Get("vkint", "mainmenu"), true)
    RMenu:Get("vkint", "mainmenu"):SetTitle(d.name)
end
local function m()
    b = nil
    RageUI.Visible(RMenu:Get("vkint", "mainmenu"), false)
end
Citizen.CreateThread(function()
    for f, d in pairs(a) do
        tARMA.addMarker(d.position.x, d.position.y, d.position.z - 1, 1.0, 1.0, 1.0, 255, 255, 255, 170, 50, 27)
        tARMA.createArea("vkint_" .. d.id,d.position,2.0,10.0,l,m,function()end,d)
    end
end)
