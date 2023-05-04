local disPlayerNames = 10
local playerDistances = {}
local faridsenabled = false
local idshidden = false

local function DrawText3D(position, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(position.x,position.y,position.z+1)
    local dist = #(GetGameplayCamCoords()-position)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        if not faridsenabled then
            SetTextScale(0.0*scale, 0.55*scale)
        elseif faridsenabled then
            SetTextScale(0.0*scale, 0.6)
        end
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
	Wait(250)
    while true do
        if not idshidden then
            for _, id in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(id)
                if targetPed ~= PlayerPedId() then
                    if playerDistances[id] then
                        if playerDistances[id] < disPlayerNames then
                            local targetPedCords = GetEntityCoords(targetPed)
                            if NetworkIsPlayerTalking(id) then
                                DrawText3D(targetPedCords, GetPlayerServerId(id), 0,179,255)
                            else
                                DrawText3D(targetPedCords, GetPlayerServerId(id), 255,255,255)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
	Wait(250)
    while true do
        if faridsenabled then
            drawNativeText("~d~You currently have Far ID's on.", 255, 0, 0, 255, true)
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for _, id in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(id)
            if targetPed ~= playerPed then
                local distance = #(playerCoords-GetEntityCoords(targetPed))
				playerDistances[id] = distance
            end
        end
        Wait(1000)
    end
end)

RegisterCommand("farids", function()
    if faridsenabled then
        TriggerServerEvent("AQUA:IDsAboveHead", true)
    else
        TriggerServerEvent("AQUA:IDsAboveHead", false)
    end
end)

RegisterCommand("hideids", function()
    idshidden = true
    notify('~d~IDs Disabled')
end)

RegisterCommand("showids", function()
    idshidden = false
    notify('~g~IDs Enabled')
end)

RegisterCommand("hidechat", function()
    TriggerEvent('AQUA:toggleChat', true)
    notify('~g~Chat Hidden')
end)

RegisterCommand("showchat", function()
    TriggerEvent('AQUA:toggleChat', false)
    notify('~g~Chat Shown')
end)

RegisterNetEvent("AQUA:ChangeIDs")
AddEventHandler("AQUA:ChangeIDs", function(status)
    if status then
        disPlayerNames = 10
        notify("~d~Disabled Far IDs")
        faridsenabled = false
    elseif not status then
        disPlayerNames = 100
        notify("~g~Enabled Far IDs")
        faridsenabled = true
    end
end)

function drawNativeText(V)
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(V)
    EndTextCommandPrint(100, 1)
end