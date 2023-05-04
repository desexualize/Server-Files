function tARMA.loadPtfx(u)
    if not HasNamedPtfxAssetLoaded(u) then
        RequestNamedPtfxAsset(u)
        while not HasNamedPtfxAssetLoaded(u) do
            Wait(0)
        end
    end
    UseParticleFxAsset(u)
end
function tARMA.getStreetNameAtCoord(v, w, H)
    return GetStreetNameFromHashKey(GetStreetNameAtCoord(v, w, H))
end
Citizen.CreateThread(
    function()
        if not HasStreamedTextureDictLoaded("timerbars") then
            RequestStreamedTextureDict("timerbars")
            while not HasStreamedTextureDictLoaded("timerbars") do
                Wait(0)
            end
        end
    end
)
function DrawGTAText(A, v, w, aa, ab, ac)
    SetTextFont(0)
    SetTextScale(aa, aa)
    SetTextColour(254, 254, 254, 255)
    if ab then
        SetTextWrap(v - ac, v)
        SetTextRightJustify(true)
    end
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(A)
    EndTextCommandDisplayText(v, w)
end
function DrawGTATimerBar(ad, A, ae)
    local ac = 0.17
    local af = -0.01
    local ag = 0.038
    local ah = 0.008
    local ai = 0.005
    local aj = 0.32
    local ak = -0.04
    local al = 0.014
    local am = GetSafeZoneSize()
    local an = al + am - ac + ac / 2
    local ao = ak + am - ag + ag / 2 - (ae - 1) * (ag + ai)
    DrawSprite("timerbars", "all_black_bg", an, ao, ac, 0.038, 0, 0, 0, 0, 128)
    DrawGTAText(ad, am - ac + 0.06, ao - ah, aj)
    DrawGTAText(string.upper(A), am - af, ao - 0.0175, 0.5, true, ac / 2)
end
function GetPlayers()
    local a7 = {}
    for o, j in ipairs(GetActivePlayers()) do
        table.insert(a7, j)
    end
    return a7
end
function GetClosestPlayer(ap)
    local a7 = GetPlayers()
    local aq = -1
    local ar = -1
    local as = PlayerPedId()
    local at = GetEntityCoords(as, 0)
    for o, c in ipairs(a7) do
        local au = GetPlayerPed(c)
        if au ~= as then
            local av = GetEntityCoords(GetPlayerPed(c), 0)
            local aw = #(av - at)
            if aq == -1 or aq > aw then
                ar = c
                aq = aw
            end
        end
    end
    if aq <= ap then
        return ar
    else
        return nil
    end
end
function tARMA.randomNum(d, e)
    math.randomseed(GetGameTimer() * math.random() * 2)
    return math.random(d, e)
end
soundEventCode = 0
TriggerServerEvent("ARMA:soundCodeServer")
RegisterNetEvent("ARMA:soundCode",function(aH)
    soundEventCode = aH
end)
RegisterNetEvent("ARMA:playClientNuiSound",function(aI, aJ, ap) -- use for cuffing and other sounds in areas
    local ax = tARMA.getPlayerCoords()
    if #(ax - aI) <= ap then
        SendNUIMessage({transactionType = aJ})
    end
end)
function tARMA.getNetId(aW, aX)
    if aX == nil then
        aX = ""
    end
    local aY = 0
    local aZ = DoesEntityExist(aW)
    if not aZ then
        print(string.format("no such entity %s", aX))
    else
        aY = NetworkGetNetworkIdFromEntity(aW)
        if aY == aW then
            print(string.format("no such networked entity %s", aX))
        end
    end
    return aY
end
local b2 = {}
Citizen.CreateThread(function()
    local a = module("arma-vehicles", "garages")
    for b3, V in pairs(a.garages) do
        for b4, b5 in pairs(V) do
            if b3 ~= "_config" then
                local b6 = b5[1]
                local b7 = string.lower(b4)
                if not b2[b7] then
                    b2[b7] = {name = b6, garageType = b3}
                end
            end
        end
    end
end)

function tARMA.getVehicleNameFromId(b7)
    if b2[string.lower(b7)] then
        return b2[string.lower(b7)].name
    end
    return ""
end
function tARMA.getGarageNameFromId(b7)
    return b2[string.lower(b7)].garageType
end
