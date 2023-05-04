local isInRebel = false
local currentAmmunition = nil
local currentGunHash = nil
local currentGunPrice = nil
local currentGunName = nil
local currentGunHash1 = nil
local currentGunPrice1 = nil
local currentGunName1 = nil
local plateprice = nil
local plateid = nil
local hoveredArmour = false
local N
local O

RMenu.Add('RebelMenu', 'main', RageUI.CreateMenu("", "~d~ Rebel", 1300, 50, "banners", "rebel"))
RMenu.Add("RebelMenu", "sub", RageUI.CreateSubMenu(RMenu:Get("RebelMenu", "main"), "", "~d~ Rebel", 1300, 50, "banners", "rebel"))
RMenu.Add("RebelMenu", "adrebel", RageUI.CreateSubMenu(RMenu:Get("RebelMenu", "main"), "", "~d~ Rebel", 1300, 50, "banners", "rebel"))
RMenu.Add("RebelMenu", "armourplate", RageUI.CreateSubMenu(RMenu:Get("RebelMenu", "main"), "", "~d~ Rebel", 1300, 50, "banners", "rebel"))

RageUI.CreateWhile(1.0, RMenu:Get('RebelMenu', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('RebelMenu', 'main'), true, false, true, function()
        RageUI.Separator("~d~For more guns purchase Advanced Rebel.", function() end)
        for i , p in pairs(rebel.guns) do 
            RageUI.ButtonWithStyle(p.name , "~g~£"..tostring(getMoneyStringFormatted(p.price)) , { RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Active then
                    currentGunHash = nil
                    hoveredArmour = false
                end
                if Selected then
                    currentGunHash = p.hash
                    currentGunPrice = p.price
                    currentGunName = p.name
                end
            end, RMenu:Get("RebelMenu", "sub"))
        end
        if hasAids then 
            for f , a in pairs(adrebel.guns) do 
                RageUI.ButtonWithStyle(a.name , "~g~£"..tostring(getMoneyStringFormatted(a.price)) , { RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Active then
                        currentGunHash1 = nil
                        hoveredArmour = false
                    end
                    if Selected then
                        currentGunHash1 = a.hash
                        currentGunPrice1 = a.price
                        currentGunName1 = a.name
                    end
                end, RMenu:Get("RebelMenu", "adrebel"))
            end
        end
        for k,v in pairs(rebel.items) do
        RageUI.ButtonWithStyle(v.name , nil, { RightLabel = "~g~£"..tostring(getMoneyStringFormatted(v.price)) }, true, function(Hovered, Active, Selected)
            if Selected then
                plateprice = v.price
                plateid = v.itemID
            end
        end, RMenu:Get("RebelMenu", "armourplate"))
    end
        RageUI.ButtonWithStyle("Level 4 Armour [Max]" , nil, { RightLabel = "~g~£"..tostring(getMoneyStringFormatted(rebel.fullarmourprice)) }, true, function(Hovered, Active, Selected)
            if Active then
                hoveredArmour = true
            end
            if Selected then
                TriggerServerEvent('Rebel:BuyArmour')
            end
        end)
        RageUI.ButtonWithStyle("Replenish Armour" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Active then
                hoveredArmour = true
            end
            if Selected then
                TriggerServerEvent('Rebel:ReplenishArmour')
            end
        end)
    end, function()
    end)

    RageUI.IsVisible(RMenu:Get("RebelMenu", "sub"), true, false, true, function()
        RageUI.ButtonWithStyle("Purchase Weapon Body" , "Purchase "..currentGunName.." and Max Ammo", { RightLabel = "~g~£"..tostring(getMoneyStringFormatted(currentGunPrice)) }, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("Rebel:BuyWeapon", currentGunHash)
            end
        end)
        RageUI.ButtonWithStyle("Buy Max Ammo", "Purchase Max Ammo for "..currentGunName, {   RightLabel = "~g~£"..tostring(getMoneyStringFormatted(math.floor(currentGunPrice / 2)))  }, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("Rebel:BuyWeaponAmmo", currentGunHash)
            end
        end)
    end, function()
    end)

    RageUI.IsVisible(RMenu:Get("RebelMenu", "adrebel"), true, false, true, function()
        RageUI.ButtonWithStyle("Purchase Weapon Body" , "Purchase "..currentGunName1.." and Max Ammo", {   RightLabel = "~g~£"..tostring(getMoneyStringFormatted(math.floor(currentGunPrice1))) }, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("Rebel:BuyWeapon2", currentGunHash1)
            end
        end)
        RageUI.ButtonWithStyle("Buy Max Ammo", "Purchase Max Ammo for "..currentGunName1, {  RightLabel = "~g~£"..tostring(getMoneyStringFormatted(math.floor(currentGunPrice1 / 2))) }, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("Rebel:BuyWeaponAmmo2", currentGunHash1)
            end
        end)
    end, function()
    end)
    RageUI.IsVisible(RMenu:Get("RebelMenu", "armourplate"), true, false, true, function()
        RageUI.ButtonWithStyle("Purchase Armour Plate" , nil, {   RightLabel = "~g~£"..tostring(getMoneyStringFormatted(plateprice)) }, true, function(Hovered, Active, Selected)
            if Selected then
                 TriggerServerEvent("Rebel:BuyWeapon2", currentGunHash1)
                TriggerServerEvent('Rebel:BuyArmourPlate', plateid)
            end
        end)
    end, function()
    end)
end)

RegisterNetEvent("AQUA:PlaySound")
AddEventHandler("AQUA:PlaySound", function(status)
    if status == 1 then 
        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0)
    end

    if status == 2 then 
        PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0)
    end
end)


Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
        for k,v in pairs(rebel.gunshops) do
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
    for k, v in pairs(rebel.gunshops) do
        local blip = AddBlipForCoord(v)
        SetBlipSprite(blip, 310)
        SetBlipScale(blip, 0.6)
        SetBlipDisplay(blip, 2)
        SetBlipColour(blip, 1)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Rebel")
        EndTextCommandSetBlipName(blip)
    end
    while true do
        Citizen.Wait(0)
        for k, v in pairs(rebel.gunshops) do
            if isInArea(v, 100.0) then 
                DrawMarker(27, v.x, v.y, v.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isInArea(v, 1.4) and isInRebel == false then 
                alert('Press ~INPUT_VEH_HORN~ to access ~d~Rebel Store')
                if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent('sendAdRebel')
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("RebelMenu", "main"), true)
                    isInRebel = true
                    currentAmmunition = k 
                end
            end
            if isInArea(v, 1.4) == false and isInRebel and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("RebelMenu", "main"), false)
                RageUI.Visible(RMenu:Get("RebelMenu", "sub"), false)
                RageUI.Visible(RMenu:Get("RebelMenu", "adrebel"), false)
                RageUI.Visible(RMenu:Get("RebelMenu", "armourplate"), false)
                currentAmmunition = nil
                currentGunHash = nil
                currentGunPrice = nil
                currentGunName = nil
                currentGunHash1 = nil
                currentGunPrice1 = nil
                currentGunName1 = nil
                isInRebel = false
                hoveredArmour = false
                plateprice = nil
                plateid = nil
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

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

RegisterNetEvent('returnAdRebel')
AddEventHandler('returnAdRebel', function(bool)
    if bool then 
        hasAids = true 
    else
        hasAids = false
    end
end)

