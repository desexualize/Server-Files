local Housing = module("FNR-Core", "cfg/cfg_homes")

hasPD = false
local inCam = false
local hasRebel = false
local hasVIP = false
local housetable = {}
spawn = {}
spawn.position = nil



RegisterNetEvent("FNR:PolicePerms")
AddEventHandler("FNR:PolicePerms",function(pd)
    hasPD = pd
end)
RegisterNetEvent("FNR:RebelPerms")
AddEventHandler("FNR:RebelPerms",function(rebel)
    hasRebel = rebel
end)
RegisterNetEvent("FNR:VIPPerms")
AddEventHandler("FNR:VIPPerms",function(vip)
    hasVIP = vip
end)

RMenu.Add('RespawnMenu', 'main', RageUI.CreateMenu("", "Respawn Menu", 1350, 50, "banners", "respawn"))

RageUI.CreateWhile(1.0, RMenu:Get('RespawnMenu', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('RespawnMenu', 'main'), true, false, true, function()
        if respawn.freeze == true then
            SetPlayerControl(PlayerId(), 0, 0)
        end 
        for a , b in pairs(respawn.hospitals) do 
            RageUI.Button(a, nil, "", true, function(Hovered, Active, Selected)
                if Selected then
                    spawn.position = b.location
                    TriggerEvent('spawn:teleport')
                end
            end)
        end
        if hasVIP then
            for c , d in pairs(respawn.vip) do 
            RageUI.Button(c, nil, "", true, function(Hovered, Active, Selected)
                if Selected then
                    spawn.position = d.location
                    TriggerEvent('spawn:teleport')
                end
             end)
          end
        end
        if hasRebel then
            for e,f in pairs(respawn.rebel) do
                RageUI.Button(e, nil, "", true,function(Hovered, Active, Selected)
                    if Selected then
                        spawn.position = f.location
                        TriggerEvent('spawn:teleport')
                    end
                end)
            end
        end
        if hasPD then
            for g,h in pairs(respawn.pd) do
                RageUI.Button(g, nil, "", true,function(Hovered, Active, Selected)
                    if Selected then
                        spawn.position = h.location
                        TriggerEvent('spawn:teleport')
                    end
                end)
            end
        end
        if hasPD then
            for g,h in pairs(respawn.pd1) do
                RageUI.Button(g, nil, "", true,function(Hovered, Active, Selected)
                    if Selected then
                        spawn.position = h.location
                        TriggerEvent('spawn:teleport')
                    end
                end)
            end
        end
        if hasPD then
            for g,h in pairs(respawn.pd2) do
                RageUI.Button(g, nil, "", true,function(Hovered, Active, Selected)
                    if Selected then
                        spawn.position = h.location
                        TriggerEvent('spawn:teleport')
                    end
                end)
            end
        end
        for i,j in pairs(Housing.homes) do
            if table.includes(housetable, i) then
                RageUI.Button(""..i, nil, "", true,function(Hovered, Active, Selected)
                    if Selected then
                        spawn.position = j.entry_point
                        Wait(100)
                        TriggerEvent('spawn:teleport')
                        Wait(100)
                        RageUI.CloseAll()
                    end
                end)
            end
        end
    end, function()

    end)
end)


isInMenu = false
Citizen.CreateThread(function() 
    while true do
        local v1 = respawn.coords 
        if not isInMenu then
            if isInArea(v1, 1.4) then 
                ped = GetPlayerPed(-1)
                RageUI.Visible(RMenu:Get("RespawnMenu", "main"), true)
                isInMenu = true
            end
        end
        if not isInArea(v1, 1.4) and isInMenu then
            RageUI.Visible(RMenu:Get("RespawnMenu", "main"), false)
            isInMenu = false
            if respawn.freeze then
                SetPlayerControl(PlayerId(), 1, 1)
            end
        end
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if inMenu then
            inRedZone = false
            RageUI.Visible(RMenu:Get("RespawnMenu", "main"), true)
        end
    end
end)

local function isInArea(v, dis) 
    if #(GetEntityCoords(PlayerPedId()) - v) <= dis then  
        return true
    else 
        return false
    end
end

RegisterNetEvent("FNR:StartRespawnCam")
AddEventHandler("FNR:StartRespawnCam",function()
    inRedZone = false
    
    inCam = true
    inMenu = true
    DoScreenFadeIn(500)
    ExecuteCommand('hideui')
    SetFocusPosAndVel(675.57568359375,1107.1724853516,375.29666137695)
    c = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",675.57568359375,1107.1724853516,375.29666137695, 0.0, 0.0, 0.0, 65.0, 0, 2)
    SetCamActive(c, true)
    RenderScriptCams(true, true, 0, 1, 0, 0)
    d = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",-1024.6506347656,-2712.0234375,79.889106750488, 0.0, 0.0, 0.0, 65.0, 0, 2)
    SetCamActiveWithInterp(d, c, 250000, 5, 5)
    SetPlayerControl(PlayerId(), 0, 0)
end)

RegisterNetEvent('spawn:teleport')
AddEventHandler('spawn:teleport', function()
    FreezeEntityPosition(PlayerPedId(), false)
    inCam = false
    inMenu = false
    RageUI.CloseAll()
    inRedZone = false
    local pos = spawn.position
    RequestCollisionAtCoord(pos.x, pos.y, pos.z)
    Wait(460)
    DoScreenFadeOut(250)
    Wait(250)
    DoScreenFadeIn(100)
    if not false then
        SetFocusPosAndVel(675.57568359375, 1107.1724853516, 375.29666137695)
        c = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",675.57568359375,1107.1724853516,375.29666137695,0.0,0.0,0.0,65.0,0,2)
        SetCamActive(c, true)
        RenderScriptCams(true, true, 0, 1, 0, 0)
        d = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 65.0, 0, 2)
        SetCamActiveWithInterp(d, c, 2500, 5, 5)
        Wait(1500)
        ClearFocus()
        Wait(1000)
        DestroyCam(c)
        DestroyCam(d)
        RenderScriptCams(false, true, 3000, 1, 0, 0)
    end
    SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z + 1.5)
    SetPlayerControl(PlayerId(), 1, 1)
    ExecuteCommand('showui')
end)

function table.includes(table,p)
    for q,r in pairs(table)do 
        if r==p then 
            return true 
        end 
    end
    return false 
end

RegisterNetEvent("FNR:HousingTable")
AddEventHandler("FNR:HousingTable",function(houses)
    housetable = houses
end)