local a = "anim@amb@office@seating@male@var_b@base@"
local b = 1
local c = 11
local d = {
    [1] = {"anim@amb@office@seating@male@var_a@base@", "base"},
    [2] = {"anim@amb@office@seating@male@var_b@base@", "base"},
    [3] = {"anim@amb@office@seating@male@var_c@base@", "base"},
    [4] = {"anim@amb@office@seating@male@var_d@base@", "base"},
    [5] = {"anim@amb@office@seating@male@var_e@base@", "base"},
    [6] = {"anim@amb@clubhouse@seating@female@var_a@base@", "base"},
    [7] = {"anim@amb@clubhouse@seating@female@var_b@base@", "base"},
    [8] = {"anim@amb@clubhouse@seating@female@var_c@base@", "base"},
    [9] = {"anim@amb@clubhouse@seating@male@var_a@base@", "base"},
    [10] = {"anim@amb@clubhouse@seating@male@var_b@base@", "base"},
    [11] = {"anim@amb@clubhouse@seating@male@var_c@base@", "base"}
}
local e = false
local f = nil
local g = {
    [0] = {vector3(1120.862, 212.423, -50.4401), vector3(0.0, 0.0, -124.25), 0},
    [1] = {vector3(1120.2, 211.123, -50.4401), vector3(0.0, 0.0, -115.25), 0},
    [2] = {vector3(1120.862, 212.423, -50.4401), vector3(0.0, 0.0, -124.25), 0},
    [3] = {vector3(1120.2, 211.123, -50.4401), vector3(0.0, 0.0, -115.25), 0},
    [4] = {vector3(1119.816, 209.848, -50.4401), vector3(0.0, 0.0, -106.5), 0},
    [5] = {vector3(1119.618, 208.511, -50.4401), vector3(0.0, 0.0, -96.25), 0},
    [6] = {vector3(1119.54, 207.185, -50.4401), vector3(0.0, 0.0, -99.5), 0},
    [7] = {vector3(1118.818, 204.723, -50.4401), vector3(0.0, 0.0, -117.25), 0},
    [8] = {vector3(1118.193, 203.635, -50.4401), vector3(0.0, 0.0, -127.75), 0},
    [9] = {vector3(1117.355, 202.623, -50.4401), vector3(0.0, 0.0, -137.25), 0},
    [10] = {vector3(1116.384, 201.823, -50.4401), vector3(0.0, 0.0, -147.5), 0},
    [11] = {vector3(1115.254, 201.136, -50.4401), vector3(0.0, 0.0, -157.75), 0},
    [12] = {vector3(1114.046, 200.698, -50.4401), vector3(0.0, 0.0, -167.75), 0},
    [13] = {vector3(1112.791, 200.235, -50.4401), vector3(0.0, 0.0, -158.0), 0},
    [14] = {vector3(1111.561, 199.51, -50.4401), vector3(0.0, 0.0, -148.0), 0},
    [15] = {vector3(1130.482, 239.144, -51.0408), vector3(0.0, 0.0, 152.93), 0},
    [16] = {vector3(1129.412, 239.844, -51.0408), vector3(0.0, 0.0, 130.68), 0},
    [17] = {vector3(1128.693, 240.931, -51.0408), vector3(0.0, 0.0, 109.18), 0},
    [18] = {vector3(1128.732, 243.531, -51.0408), vector3(0.0, 0.0, 66.43), 0},
    [19] = {vector3(1129.494, 244.656, -51.0408), vector3(0.0, 0.0, 44.43), 0},
    [20] = {vector3(1130.592, 245.344, -51.0408), vector3(0.0, 0.0, 20.43), 0},
    [21] = {vector3(1133.189, 245.344, -51.0408), vector3(0.0, 0.0, -25.32), 0},
    [22] = {vector3(1134.295, 244.606, -51.0408), vector3(0.0, 0.0, -48.07), 0},
    [23] = {vector3(1135.011, 243.469, -51.0408), vector3(0.0, 0.0, -68.32), 0},
    [24] = {vector3(1125.608, 252.885, -51.0408), vector3(0.0, 0.0, -27.82), 0},
    [25] = {vector3(1126.656, 252.185, -51.0408), vector3(0.0, 0.0, -48.32), 0},
    [26] = {vector3(1127.391, 251.06, -51.0408), vector3(0.0, 0.0, -69.57), 0},
    [27] = {vector3(1127.354, 248.448, -51.0408), vector3(0.0, 0.0, -116.07), 0},
    [28] = {vector3(1126.609, 247.36, -51.0408), vector3(0.0, 0.0, -136.82), 0},
    [29] = {vector3(1125.499, 246.623, -51.0408), vector3(0.0, 0.0, -159.32), 0},
    [30] = {vector3(1122.905, 246.673, -51.0408), vector3(0.0, 0.0, 153.5), 0},
    [31] = {vector3(1121.809, 247.398, -51.0408), vector3(0.0, 0.0, 131.75), 0},
    [32] = {vector3(1121.087, 248.548, -51.0408), vector3(0.0, 0.0, 111.75), 0},
    [33] = {vector3(1120.862, 212.423, -50.4401), vector3(0.0, 0.0, -124.25), 0},
    [34] = {vector3(1120.2, 211.123, -50.4401), vector3(0.0, 0.0, -115.25), 0},
    [35] = {vector3(1119.816, 209.848, -50.4401), vector3(0.0, 0.0, -106.5), 0},
    [36] = {vector3(1119.618, 208.511, -50.4401), vector3(0.0, 0.0, -96.25), 0},
    [37] = {vector3(1119.54, 207.185, -50.4401), vector3(0.0, 0.0, -99.5), 0},
    [38] = {vector3(1118.818, 204.723, -50.4401), vector3(0.0, 0.0, -117.25), 0},
    [39] = {vector3(1118.193, 203.635, -50.4401), vector3(0.0, 0.0, -127.75), 0},
    [40] = {vector3(1117.355, 202.623, -50.4401), vector3(0.0, 0.0, -137.25), 0},
    [41] = {vector3(1116.384, 201.823, -50.4401), vector3(0.0, 0.0, -147.5), 0},
    [42] = {vector3(1115.254, 201.136, -50.4401), vector3(0.0, 0.0, -157.75), 0},
    [43] = {vector3(1114.046, 200.698, -50.4401), vector3(0.0, 0.0, -167.75), 0},
    [44] = {vector3(1112.791, 200.235, -50.4401), vector3(0.0, 0.0, -158.0), 0},
    [45] = {vector3(1111.561, 199.51, -50.4401), vector3(0.0, 0.0, -148.0), 0},
    [46] = {vector3(1130.482, 239.144, -51.0408), vector3(0.0, 0.0, 152.93), 0},
    [47] = {vector3(1129.412, 239.844, -51.0408), vector3(0.0, 0.0, 130.68), 0},
    [48] = {vector3(1128.693, 240.931, -51.0408), vector3(0.0, 0.0, 109.18), 0},
    [49] = {vector3(1128.732, 243.531, -51.0408), vector3(0.0, 0.0, 66.43), 0},
    [50] = {vector3(1129.494, 244.656, -51.0408), vector3(0.0, 0.0, 44.43), 0},
    [51] = {vector3(1130.592, 245.344, -51.0408), vector3(0.0, 0.0, 20.43), 0},
    [52] = {vector3(1133.189, 245.344, -51.0408), vector3(0.0, 0.0, -25.32), 0},
    [53] = {vector3(1134.295, 244.606, -51.0408), vector3(0.0, 0.0, -48.07), 0},
    [54] = {vector3(1135.011, 243.469, -51.0408), vector3(0.0, 0.0, -68.32), 0},
    [55] = {vector3(1125.608, 252.885, -51.0408), vector3(0.0, 0.0, -27.82), 0},
    [56] = {vector3(1126.656, 252.185, -51.0408), vector3(0.0, 0.0, -48.32), 0},
    [57] = {vector3(1127.391, 251.06, -51.0408), vector3(0.0, 0.0, -69.57), 0},
    [58] = {vector3(1127.354, 248.448, -51.0408), vector3(0.0, 0.0, -116.07), 0},
    [59] = {vector3(1126.609, 247.36, -51.0408), vector3(0.0, 0.0, -136.82), 0},
    [60] = {vector3(1125.499, 246.623, -51.0408), vector3(0.0, 0.0, -159.32), 0},
    [61] = {vector3(1122.905, 246.673, -51.0408), vector3(0.0, 0.0, 153.5), 0},
    [62] = {vector3(1121.809, 247.398, -51.0408), vector3(0.0, 0.0, 131.75), 0},
    [63] = {vector3(1121.087, 248.548, -51.0408), vector3(0.0, 0.0, 111.75), 0}
}
Citizen.CreateThread(function()
    while true do
        if not e then
            local h = GetEntityCoords(tARMA.getPlayerPed())
            for i, j in pairs(g) do
                local k = #(h - j[1])
                g[i][3] = k
            end
        end
        if f ~= nil then
            local h = GetEntityCoords(tARMA.getPlayerPed())
            closestVectors = g[f]
            local k = #(h - closestVectors[1])
            if k > 2 then
                f = nil
                ClearHelp(true)
            end
        end
        Wait(50)
    end
end)
function sitDownAtBar(l)
    local m, n = table.unpack(g[l])
    e = true
    a, animName = table.unpack(d[b])
    tARMA.loadAnimDict(a)
    followMachineVector = m
    followMachineRotation = n
    TaskGoStraightToCoord(tARMA.getPlayerPed(),followMachineVector.x,followMachineVector.y,followMachineVector.z,1.0,50000,312.2,10.0)
    local h = GetEntityCoords(tARMA.getPlayerPed())
    while #(h - followMachineVector) >= 1.25 do
        h = GetEntityCoords(tARMA.getPlayerPed())
        Wait(100)
    end
    if GetCamViewModeForContext(0) == 1 or GetCamViewModeForContext(0) == 2 then
        SetCamViewModeForContext(0, 0)
    end
    if GetCamViewModeForContext(0) == 4 then
        Citizen.InvokeNative(0x79C0E43EB9B944E2, 518572876)
    end
    createSitAtBarScene(m, n)
end
function createSitAtBarScene(o, p)
    local q = NetworkCreateSynchronisedScene(o.x, o.y, o.z, p.x, p.y, p.z, 2, 1, 0, 1065353216, 0, 1.12)
    NetworkAddPedToSynchronisedScene(tARMA.getPlayerPed(), q, a, animName, 2.0, -1000, 9, 0, 1148846080, 0)
    NetworkStartSynchronisedScene(q)
    return q
end
function getAnimOffsetRotation(m, n, r)
    local s = GetAnimInitialOffsetRotation(a, r, m.x, m.y, m.z, n.x, n.y, n.z, 0.0, 2)
    return s
end
function getAnimOffsetPosition(m, n, r)
    local s = GetAnimInitialOffsetPosition(a, r, m.x, m.y, m.z, n.x, n.y, n.z, 0, 2)
    return s
end
Citizen.CreateThread(function()
    while true do
        if insideDiamondCasino then
            if e then
                SetPedCapsule(tARMA.getPlayerPed(), 0.13)
                if IsControlJustPressed(0, 202) then
                    tARMA.loadAnimDict("anim@amb@office@seating@male@var_a@base@")
                    TaskPlayAnim(tARMA.getPlayerPed(),"anim@amb@office@seating@male@var_a@base@","exit",1.0,1.0,-1,0)
                    RemoveAnimDict("anim@amb@office@seating@male@var_a@base@")
                    e = false
                end
                if IsControlJustPressed(0, 63) then
                    if b == 1 then
                        b = c
                    else
                        b = b - 1
                    end
                    local m, n = table.unpack(g[f])
                    a, animName = table.unpack(d[b])
                    createSitAtBarScene(m, n)
                end
                if IsControlJustPressed(0, 64) then
                    if b == 11 then
                        b = 1
                    else
                        b = b + 1
                    end
                    local m, n = table.unpack(g[f])
                    a, animName = table.unpack(d[b])
                    createSitAtBarScene(m, n)
                end
            end
            if f ~= nil then
                if IsControlJustPressed(0, 38) then
                    sitDownAtBar(f)
                    drawNativeNotification("Press ~INPUT_VEH_MOVE_LEFT_ONLY~ or ~INPUT_VEH_MOVE_RIGHT_ONLY~ to switch pose.")
                end
            end
            if not e then
                for i, j in pairs(g) do
                    local k = j[3]
                    if k < 1.5 then
                        if f == nil then
                            drawNativeNotification("Press ~INPUT_PICKUP~ to take a seat")
                        end
                        f = i
                    end
                end
            end
        end
        Wait(0)
    end
end)
