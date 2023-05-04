local a = {}
a.Cooldown = 15
a.DisableAllMessages = false
a.ChatSuggestions = true
a.Reminder = true
a.Message = "Attention all units, MET officer in distress!"
local b = {}
b.Cooling = 0
b.Tuned = true
function getHeadshot(c)
    local handle = RegisterPedheadshot(c)
    if not IsPedheadshotValid(handle) then
        return "CHAR_BLOCKED"
    end
    local d = GetGameTimer()
    while not IsPedheadshotReady(handle) do
        if GetGameTimer() - d > 2500 then
            UnregisterPedheadshot(handle)
            return "CHAR_BLOCKED"
        end
        Wait(0)
    end
    local e = GetPedheadshotTxdString(handle)
    return e, handle
end
RegisterCommand("panic",function()
    if globalOnPoliceDuty or globalNHSOnDuty or globalOnPrisonDuty or globalLFBOnDuty then
        if b.Cooling == 0 then
            local f = {}
            f.Player = tARMA.getPlayerId()
            f.Ped = tARMA.getPlayerPed()
            f.Name = GetPlayerName(f.Player)
            f.Coords = GetEntityCoords(f.Ped)
            f.Location = {}
            f.Location.Street, f.Location.CrossStreet = GetStreetNameAtCoord(f.Coords.x, f.Coords.y, f.Coords.z)
            f.Location.Street = GetStreetNameFromHashKey(f.Location.Street)
            if f.Location.CrossStreet ~= 0 then
                f.Location.CrossStreet = GetStreetNameFromHashKey(f.Location.CrossStreet)
                f.Location = f.Location.Street .. " X " .. f.Location.CrossStreet
            else
                f.Location = f.Location.Street
            end
            if globalOnPoliceDuty then
                TriggerServerEvent("ARMA:newPanic", f, 3)
            elseif globalNHSOnDuty then
                TriggerServerEvent("ARMA:newPanic", f, 2)
            elseif globalOnPrisonDuty then
                TriggerServerEvent("ARMA:newPanic", f, 4)
            elseif globalLFBOnDuty then
                TriggerServerEvent("ARMA:newPanic", f, 5)
            end
            b.Cooling = a.Cooldown
        else
            NewNoti("~r~Panic Button still cooling down.", true)
        end
    else
        NewNoti("~r~You are not whitelisted for this command.", true)
    end
end)
RegisterNetEvent("ARMA:returnPanic",function(g, f, h)
    if globalOnPoliceDuty or globalNHSOnDuty or globalOnPrisonDuty or globalLFBOnDuty and h == 5 then
        SendNUIMessage({PayloadType = "Panic", Payload = g})
        f.Headshot, handle = getHeadshot(GetPlayerPed(GetPlayerFromServerId(f.Source)))
        if h == 2 then
            tARMA.notifyPicture2(f.Headshot,2,string.format("NHS - %s", f.Name),false,"~r~NHS Paramedic in distress! - " .. f.Location)
        elseif h == 3 then
            tARMA.notifyPicture2(f.Headshot,2,string.format("MET Police - %s", f.Name),false,"~r~Officer in distress! - " .. f.Location)
        elseif h == 4 then
            tARMA.notifyPicture2(f.Headshot,2,string.format("HM Prison - %s", f.Name),false,"~r~Prison Guard in distress! - " .. f.Location)
        elseif h == 5 then
            tARMA.notifyPicture2(f.Headshot,2,string.format("LFB - %s", f.Name),false,"~r~LFB Panic Alarm Activated! - " .. f.Location)
        end
        if handle ~= nil then
            UnregisterPedheadshot(handle)
        end
        Citizen.CreateThread(function()
            local i = AddBlipForRadius(f.Coords.x, f.Coords.y, f.Coords.z, 100.0)
            SetBlipRoute(i, true)
            Citizen.CreateThread(function()
                while i do
                    SetBlipRouteColour(i, 1)
                    Citizen.Wait(150)
                    SetBlipRouteColour(i, 6)
                    Citizen.Wait(150)
                    SetBlipRouteColour(i, 35)
                    Citizen.Wait(150)
                    SetBlipRouteColour(i, 6)
                end
            end)
            SetBlipColour(i, h)
            SetBlipAlpha(i, 60)
            SetBlipFlashes(i, true)
            SetBlipFlashInterval(i, 200)
            Citizen.Wait(90000)
            RemoveBlip(i)
            i = nil
        end)
        local j = GetSoundId()
        PlaySoundFrontend(j, "police_notification", "DLC_AS_VNT_Sounds", true)
        ReleaseSoundId(j)
    end
end)
function NewNoti(k, l)
    if not a.DisableAllMessages then
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(k)
        EndTextCommandThefeedPostTicker(l, true)
    end
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if b.Cooling ~= 0 then
            b.Cooling = b.Cooling - 1
            Citizen.Wait(1000)
        end
    end
end)
