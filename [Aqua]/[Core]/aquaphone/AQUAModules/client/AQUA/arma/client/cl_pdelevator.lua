local a = {
    [1] = {
        coords = vector3(-1096.1197509766, -850.44573974609, 4.8845114707947),
        name = "Floor -1",
        otherLocs = {2, 3, 4, 5, 6, 7, 8, 9},
        desc = "Holding Cells, Identification Rooms, Interrogation Rooms, Garage"
    },
    [2] = {
        coords = vector3(-1096.1131591797, -850.54858398438, 10.2770795822),
        name = "Floor -2",
        otherLocs = {1, 3, 4, 5, 6, 7, 8, 9},
        desc = "Laboratory, Evidence Rooms"
    },
    [3] = {
        coords = vector3(-1096.0910644531, -850.46240234375, 13.687476158),
        name = "Floor -3",
        otherLocs = {1, 2, 4, 5, 6, 7, 8, 9},
        desc = "Garage, Armoury"
    },
    [4] = {
        coords = vector3(-1096.3427734375, -850.41583251953, 19.001399993896),
        name = "Floor 1",
        otherLocs = {1, 2, 3, 5, 6, 7, 8, 9},
        desc = "Lobby, Paperwork, Interview Rooms, Conference Hall"
    },
    [5] = {
        coords = vector3(-1096.3331298828, -850.19696044922, 23.038097381592),
        name = "Floor 2",
        otherLocs = {1, 2, 3, 4, 6, 7, 8, 9},
        desc = "Public Space, Cafe"
    },
    [6] = {
        coords = vector3(-1096.2581787109, -850.19952392578, 26.827362060547),
        name = "Floor 3",
        otherLocs = {1, 2, 3, 4, 5, 7, 8, 9},
        desc = "Gym, Division Offices, Cloakrooms, Briefing Room"
    },
    [7] = {
        coords = vector3(-1096.2662353516, -850.17083740234, 30.756698608398),
        name = "Floor 4",
        otherLocs = {1, 2, 3, 4, 5, 6, 8, 9},
        desc = "Ops Center, Gold Command Office, Office Staff"
    },
    [8] = {
        coords = vector3(-1095.9621582031, -850.63787841797, 34.360549926758),
        name = "Floor 5",
        otherLocs = {1, 2, 3, 4, 5, 6, 7, 9},
        desc = "Silver Command Office, Captains Office, Office Staff"
    },
    [9] = {
        coords = vector3(-1096.4049072266, -849.94915771484, 38.242813110352),
        name = "Floor 6",
        otherLocs = {1, 2, 3, 4, 5, 6, 7, 8},
        desc = "Helipad, Rooftop"
    },
    [10] = {
        coords = vector3(-1065.8210449219, -834.02844238281, 5.4801788330078),
        name = "Floor -1",
        otherLocs = {11, 12, 13, 14},
        desc = "Holding Cells, Identification Rooms, Interrogation Rooms, Garage"
    },
    [11] = {
        coords = vector3(-1065.8479003906, -834.02172851563, 11.037246704102),
        name = "Floor -2",
        otherLocs = {10, 12, 13, 14},
        desc = "Laboratory, Evidence Rooms"
    },
    [12] = {
        coords = vector3(-1065.9549560547, -833.87341308594, 14.883050918579),
        name = "Floor -3",
        otherLocs = {10, 11, 13, 14},
        desc = "Garage, Armoury"
    },
    [13] = {
        coords = vector3(-1065.8916015625, -833.84100341797, 19.035511016846),
        name = "Floor 1",
        otherLocs = {10, 11, 12, 14},
        desc = "Lobby, Paperwork, Interview Rooms, Conference Hall"
    },
    [14] = {
        coords = vector3(-1065.9194335938, -833.87164306641, 27.036159515381),
        name = "Floor 3",
        otherLocs = {10, 11, 12, 13},
        desc = "Gym, Division Offices, Cloakrooms, Briefing Room"
    }
}
local b = 2
RMenu.Add("armapdelevators","main",RageUI.CreateMenu("ARMA Elevators", "~b~Vespucci PD", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight()))
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('armapdelevators', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for c = 1, #a[b].otherLocs, 1 do
                local d = a[b].otherLocs[c]
                RageUI.Button(a[d].name,a[d].desc,{RightLabel = "→→"},true,function(e, f, g)
                    if g then
                        local h = tARMA.getPlayerPed()
                        DoScreenFadeOut(500)
                        Citizen.Wait(500)
                        SetEntityCoords(h, a[d].coords)
                        SetEntityHeading(h, 35.0)
                        DoScreenFadeIn(700)
                        Citizen.Wait(500)
                    end
                end)
            end
        end)
    end
end)
AddEventHandler("ARMA:onClientSpawn",function(i, j)
    if j then
        local k = function()
            RageUI.Visible(RMenu:Get("armapdelevators", "main"), true)
        end
        local l = function()
            RageUI.Visible(RMenu:Get("armapdelevators", "main"), false)
        end
        local m = function()
            RMenu:Get("armapdelevators", "main"):SetSubtitle(string.format("~w~You are on ~b~%s", a[b].name))
        end
        for n, o in pairs(a) do
            tARMA.createArea("pdelevator_" .. n, o.coords, 1.5, 6, k, l, m)
            tARMA.addMarker(o.coords.x,o.coords.y,o.coords.z - 0.98,1.0001,1.0001,0.5001,255,255,255,200,20.0,27,true,false,false,nil,nil,0.0,0.0,0.0)
        end
    end
end)
