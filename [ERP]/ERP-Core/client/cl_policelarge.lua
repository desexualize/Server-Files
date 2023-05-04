local currentAmmunition = nil
local currentGunHash = nil
local currentGunPrice = nil
local currentGunName = nil
local currentGunHash1 = nil
local currentGunPrice1 = nil
local currentGunName1 = nil
returnedPDGuns2 = {}

RMenu.Add('policelarge', 'main', RageUI.CreateMenu("", "~b~ERP Police Armoury", 1300, 100, "policemenu", "policemenu"))
RMenu.Add("policelarge", "sub", RageUI.CreateSubMenu(RMenu:Get("policelarge", "main"), "", "~b~ERP Police Armoury", 1300, 100, "policemenu", "policemenu"))
RMenu.Add("policelarge", "whitelistedguns", RageUI.CreateSubMenu(RMenu:Get("policelarge", "main"), "", "~b~ERP Police Armoury", 1300, 100, "policemenu", "policemenu"))
RageUI.CreateWhile(1.0, RMenu:Get('policelarge', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('policelarge', 'main'), true, false, true, function()
        for i , p in pairs(policelarge.guns) do 
            RageUI.Button(p.name , nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Active then
                    currentGunHash = nil
                end
                if Selected then
                    currentGunHash = p.hash
                    currentGunPrice = p.price
                    currentGunName = p.name
                end
            end, RMenu:Get("policelarge", "sub"))  
        end
        for i , w in pairs(returnedPDGuns2) do 
            RageUI.Button(w.name , nil, {RightLabel = '→→→'}, true, function(Hovered, Active, Selected)
                if Active then
                    currentGunHash1 = nil
                end
                if Selected then
                    currentGunHash1 = w.gunhash
                    currentGunPrice1 = w.price
                    currentGunName1 = w.name
                end
            end, RMenu:Get("policelarge", "whitelistedguns"))
        end
    end, function()
    end)
    RageUI.IsVisible(RMenu:Get("policelarge", "sub"), true, false, true, function()
        RageUI.Button("Purchase Weapon Body" , "Purchase "..currentGunName.." and Max Ammo", { RightLabel = "~g~£"..tostring(getMoneyStringFormatted(currentGunPrice)) }, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("policelarge:BuyWeapon", currentGunHash)
            end
        end)
    
        RageUI.Button("Buy Max Ammo", "Purchase Max Ammo for "..currentGunName, {  RightLabel = "~g~£"..tostring(getMoneyStringFormatted(math.floor(currentGunPrice / 2))) }, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("policelarge:BuyWeaponAmmo", currentGunHash)
            end
        end)
    end, function()
    end)
    
    RageUI.IsVisible(RMenu:Get("policelarge", "whitelistedguns"), true, false, true, function()
        RageUI.Button("Purchase Weapon Body" , "Purchase "..currentGunName1.." and Max Ammo", {  RightLabel = "~g~£"..tostring(getMoneyStringFormatted(math.floor(currentGunPrice1))) }, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("policelarge:BuyWLWeapon", currentGunHash1)
            end
        end)
    
        RageUI.Button("Buy Max Ammo", "Purchase Max Ammo for "..currentGunName1, {  RightLabel = "~g~£"..tostring(getMoneyStringFormatted(math.floor(currentGunPrice1 / 2))) }, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("policelarge:BuyWLWeaponAmmo", currentGunHash1)
                 end
             end)
        end, function()
    end)
end)

RegisterNetEvent("PDLARGE:GUNSRETURNED")
AddEventHandler("PDLARGE:GUNSRETURNED", function(table)
    returnedPDGuns2 = table 
end)

RegisterNetEvent('policelarge:Error')
AddEventHandler('policelarge:Error', function()
    RageUI.Visible(RMenu:Get("policelarge", "main"))
    alert('~r~Insufficent funds')
end)


function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

isInpolicelarge = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
        for k, v in pairs(policelarge.gunshops) do 
            if currentGunHash ~= nil or currentGunHash1 ~= nil then
                for k,v in pairs(weaponmodels.models) do 
                    if currentGunHash == v[1] or currentGunHash1 == v[1] then
                        model = k
                    end
                end
                local N=loadModel(model)
                local O=CreateObject(N,v.x,v.y,v.z+0.1,false,false,false)
                while currentGunHash ~= nil or currentGunHash1 ~= nil and DoesEntityExist(O)do 
                    SetEntityHeading(O,GetEntityHeading(O)+1%360)
                    Wait(0)
                end
                DeleteEntity(O)
            end
            if isInArea(v, 500.0) then
                DrawMarker(27, v.x,v.y,v.z- 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 0, 170, 255, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isInpolicelarge == false then
            if isInArea(v, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Police Large Arms Armoury')
                if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent("PDLARGE:PULLWHITELISTEDWEAPONS")
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("policelarge", "main"), true)
                    isInpolicelarge = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v, 1.4) == false and isInpolicelarge and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("policelarge", "main"), false)
                RageUI.Visible(RMenu:Get("policelarge", "sub"), false)
                RageUI.Visible(RMenu:Get("policelarge", "whitelistedguns"), false)
                isInpolicelarge = false
                currentAmmunition = nil
            end
        end
    end
end)

RegisterNetEvent("policelarge:GiveWeapon")
AddEventHandler("policelarge:GiveWeapon", function(hash)
    GiveWeaponToPed(PlayerPedId(), hash, 250, false, false, 0)
end)

RegisterNetEvent("policelarge:GiveArmour")
AddEventHandler("policelarge:GiveArmour", function(level) 
    SetPedArmour(PlayerPedId(), level)
end)

function isInArea(v, dis) 
    if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
        return true
    else 
        return false
    end
end

function alert(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function loadModel(r)
    local s
    if type(r)~="string"then 
        s=r 
    else 
        s=GetHashKey(r)
    end
    if IsModelInCdimage(s)then 
        if not HasModelLoaded(s)then 
            RequestModel(s)
            while not HasModelLoaded(s)do 
                Wait(0)
            end 
        end
        return s 
    else 
        return nil 
    end 
end