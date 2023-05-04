local isInVIP = false
local currentAmmunition = nil
local currentGunHash = nil
local currentGunPrice = nil
local currentGunName = nil
local currentGunHash1 = nil
local currentGunPrice1 = nil
local currentGunName1 = nil
local hoveredArmour = false
local N
local O
local returnedGuns2 = {}

RMenu.Add("VIPMenu", "main", RageUI.CreateMenu("", "~y~VIP Gun Store", 1300, 50, "banners", "vip"))
RMenu.Add("VIPMenu", "sub", RageUI.CreateSubMenu(RMenu:Get("VIPMenu", "main"), "", "~r~VIP Gun Store", 1300, 50, "banners", "vip"))
RMenu.Add("VIPMenu", "whitelistedguns", RageUI.CreateSubMenu(RMenu:Get("VIPMenu", "main"), "", "~r~VIP Gun Store", 1300, 50, "banners", "vip"))

RageUI.CreateWhile(1.0, RMenu:Get("VIPMenu", "main"), nil, function()

    RageUI.IsVisible(RMenu:Get("VIPMenu", "main"), true, false, true, function()
        RageUI.Separator("~g~You are required to have ~y~VIP", function() end)
        RageUI.Separator("~g~to purchase guns from here.", function() end)
        for i , p in pairs(VIP.guns) do 
            RageUI.Button(p.name , "~g~£"..getMoneyStringFormatted(p.price), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Active then
                    currentGunHash = nil
                    hoveredArmour = false
                end
                if Selected then
                    currentGunHash = p.hash
                    currentGunPrice = p.price
                    currentGunName = p.name
                end
            end, RMenu:Get("VIPMenu", "sub"))
        end
        for i , o in pairs(returnedGuns2) do 
            RageUI.Button(o.name , "~g~£" .. o.price, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Active then
                    currentGunHash1 = nil
                    hoveredArmour = false
        
                end
                if Selected then
                    currentGunHash1 = o.gunhash
                    currentGunPrice1 = o.price
                    currentGunName1 = o.name
                end
            end, RMenu:Get("VIPMenu", "whitelistedguns"))
        end

        RageUI.Button("Level 4 Armour [Max]" , "~g~£"..getMoneyStringFormatted(VIP.maxArmourPrice), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Active then
                hoveredArmour = true
            end
            if Selected then
                TriggerServerEvent("VIP:BuyArmour")
            end
        end)

        RageUI.Button("Replenish Armour" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("VIP:ReplenishArmour")
            end
        end)

    end, function()
    end)

RageUI.IsVisible(RMenu:Get("VIPMenu", "sub"), true, false, true, function()
    RageUI.Button("Purchase Weapon Body" , "Purchase "..currentGunName.." and Max Ammo", { RightLabel = "~g~£"..tostring(getMoneyStringFormatted(currentGunPrice)) }, true, function(Hovered, Active, Selected)
        if Selected then
            local Ped = PlayerPedId()
                if HasPedGotWeapon(Ped, currentGunHash, false) then
                    notify("~r~You already have this weapon equipped.")
                else
            TriggerServerEvent("VIP:BuyWeapon", currentGunHash)
                end
        end
    end)

    RageUI.Button("Buy Max Ammo", "Purchase Max Ammo for "..currentGunName, {  RightLabel = "~g~£"..tostring(getMoneyStringFormatted(math.floor(currentGunPrice / 2)))}, true, function(Hovered, Active, Selected)
        if Selected then
            TriggerServerEvent("VIP:BuyWeaponAmmo", currentGunHash)
        end
    end)
end, function()
end)

RageUI.IsVisible(RMenu:Get("VIPMenu", "whitelistedguns"), true, false, true, function()
    RageUI.Button("Purchase Weapon Body" , "Purchase "..currentGunName1.." and Max Ammo", { RightLabel = "~g~£"..tostring(getMoneyStringFormatted(currentGunPrice1)) }, true, function(Hovered, Active, Selected)
        if Selected then
            local Ped = PlayerPedId()
                if HasPedGotWeapon(Ped, currentGunHasH1, false) then
                    notify("~r~You already have this weapon equipped.")
                else
            TriggerServerEvent("VIP:BuyWLWeapon", currentGunHash1)
                end
        end
    end)

    RageUI.Button("Buy Max Ammo", "Purchase Max Ammo for "..currentGunName1, {  RightLabel = "~g~£"..tostring(getMoneyStringFormatted(math.floor(currentGunPrice1 / 2)))}, true, function(Hovered, Active, Selected)
        if Selected then
            TriggerServerEvent("VIP:BuyWeaponAmmo2", currentGunHash1)
        end
    end)
end, function()
end)
end)

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
        for k,v in pairs(VIP.gunshops) do
            if currentGunHash ~= nil or currentGunHash1 ~= nil or hoveredArmour then
                for k,v in pairs(weaponmodels.models) do 
                    if currentGunHash == v[1] or currentGunHash1 == v[1] then
                        model = k
                    end
                end
                if hoveredArmour then
                    N=loadModel('prop_bodyarmour_03')
                else
                    N=loadModel(model)
                end
                O=CreateObject(N,v.x,v.y,v.z+0.1,false,false,false)
                while currentGunHash ~= nil or currentGunHash1 ~= nil or hoveredArmour == true and DoesEntityExist(O) do 
                    SetEntityHeading(O,GetEntityHeading(O)+1%360)
                    FreezeEntityPosition(O,true)
                    SetEntityInvincible(O,true)
                    SetModelAsNoLongerNeeded(model)
                    SetEntityCollision(O, false, false)
                    Wait(0)
                end
                DeleteObject(O)
            end
        end
    end
end)

Citizen.CreateThread(function() 
    for k,v in pairs(VIP.gunshops) do
        local blip = AddBlipForCoord(v)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 0.8)
        SetBlipDisplay(blip, 5)
        SetBlipColour(blip, 1)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("VIP Gun Store")
        EndTextCommandSetBlipName(blip) 
    end
    while true do
        Citizen.Wait(0)
        for k,v in pairs(VIP.gunshops) do
            if isInArea(v, 100.0) then 
                DrawMarker(27,v.x,v.y,v.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 247, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isInArea(v, 1.4) and isInVIP == false then 
                alert("Press ~INPUT_VEH_HORN~ to access ~y~VIP Store")
                if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent("VIP:PULLWHITELISTEDWEAPONS")
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("VIPMenu", "main"), true)
                    isInVIP = true
                    currentAmmunition = k 
                end
            end
            if isInArea(v, 1.4) == false and isInVIP and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("VIPMenu", "main"), false)
                RageUI.Visible(RMenu:Get("VIPMenu", "sub"), false)
                RageUI.Visible(RMenu:Get("VIPMenu", "whitelistedguns"), false)
                currentAmmunition = nil
                currentGunHash = nil
                currentGunPrice = nil
                currentGunName = nil
                currentGunHash1 = nil
                currentGunPrice1 = nil
                currentGunName1 = nil
                isInVIP = false
                hoveredArmour = false
                DeleteObject(O)
            end
        end
    end
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


function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
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

RegisterNetEvent("VIP:GUNSRETURNED")
AddEventHandler("VIP:GUNSRETURNED", function(table)
returnedGuns2 = table 
end)