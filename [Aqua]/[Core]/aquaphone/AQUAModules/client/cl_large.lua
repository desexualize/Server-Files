local isInLarge = false
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

returnedGuns2 = {}


RMenu.Add('LargeArmsMenu', 'main', RageUI.CreateMenu("", "~d~Large Arms", 1300, 50, "banners", "large"))
RMenu.Add("LargeArmsMenu", "sub", RageUI.CreateSubMenu(RMenu:Get("LargeArmsMenu", "main"), "", "~d~Large Arms Gun Store", 1300, 50, "banners", "large"))
RMenu.Add("LargeArmsMenu", "whitelistedguns", RageUI.CreateSubMenu(RMenu:Get("LargeArmsMenu", "main"), "", "~d~Large Arms Gun Store", 1300, 50, "banners", "large"))
-- RageUI.CreateWhile(wait, menu, key, closure)
RageUI.CreateWhile(1.0, RMenu:Get('LargeArmsMenu', 'main'), nil, function()

    RageUI.IsVisible(RMenu:Get('LargeArmsMenu', 'main'), true, false, true, function()
        RageUI.Separator('~g~You are required to have ~d~Gang', function() end)
        RageUI.Separator('~g~License to purchase guns from here.', function() end)
        for i , p in pairs(large.guns) do 
            RageUI.ButtonWithStyle(""..p.name , '~g~'..large.currency..tostring(getMoneyStringFormatted(p.price)), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Active then
                    currentGunHash = nil
                    hoveredArmour = false
                end
                if Selected then
                    currentGunHash = p.hash
                    currentGunPrice = p.price
                    currentGunName = p.name
                end
            end, RMenu:Get("LargeArmsMenu", "sub"))
        end
        for i , o in pairs(returnedGuns2) do 
        RageUI.ButtonWithStyle(o.name , '~g~'..large.currency..tostring(getMoneyStringFormatted(o.price)), {RightLabel = '→→→'}, true, function(Hovered, Active, Selected)
            if Active then
                currentGunHash1 = nil
                hoveredArmour = false
            end
            if Selected then
                currentGunHash1 = o.gunhash
                currentGunPrice1 = o.price
                currentGunName1 = o.name
            end
        end, RMenu:Get("LargeArmsMenu", "whitelistedguns"))
    end
        RageUI.ButtonWithStyle("Level 2 Armour [50%]" , "~g~£0", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Active then
                hoveredArmour = true
            end
            if Selected then
                TriggerServerEvent('AQUA:BuyArmour', 0, 50)
            end
        end)
     
     
    end, function()
        ---Panels
    end)
    RageUI.IsVisible(RMenu:Get("LargeArmsMenu", "sub"), true, false, true, function()
        RageUI.ButtonWithStyle("Purchase Weapon Body" , "Purchase "..currentGunName.." and Max Ammo", { RightLabel = "~g~£"..tostring(getMoneyStringFormatted(currentGunPrice)) }, true, function(Hovered, Active, Selected)
            if Selected then
                local Ped = PlayerPedId()
                if HasPedGotWeapon(Ped, currentGunHash, false) then
                    notify("~d~You already have this weapon equipped.")
                else
                TriggerServerEvent("AQUA:BuyGun", currentGunHash)
                end
            end
        end)
    
        RageUI.ButtonWithStyle("Buy Max Ammo", "Purchase Max Ammo for "..currentGunName, {  RightLabel = "~g~£"..tostring(getMoneyStringFormatted(math.floor(currentGunPrice / 2))) }, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("LargeArms:BuyWeaponAmmo", currentGunHash)
            end
        end)
    end, function()
    end)

    RageUI.IsVisible(RMenu:Get("LargeArmsMenu", "whitelistedguns"), true, false, true, function()
        RageUI.ButtonWithStyle("Purchase Weapon Body" , "Purchase  and Max Ammo", {  RightLabel = "~g~£"..tostring(getMoneyStringFormatted(currentGunPrice1)) }, true, function(Hovered, Active, Selected)
            if Selected then
                local Ped = PlayerPedId()
                if HasPedGotWeapon(Ped, currentGunHash1, false) then
                    notify("~d~You already have this weapon equipped.")
                else
                TriggerServerEvent("LargeArms:BuyWLGun", currentGunHash1)
                end
            end
        end)
    
        RageUI.ButtonWithStyle("Buy Max Ammo", "Purchase Max Ammo for "..currentGunName1, {  RightLabel = "~g~£"..tostring(getMoneyStringFormatted(currentGunPrice1 / 2)) }, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("LargeArms:BuyWeaponAmmo2", currentGunHash1)
            end
        end)
    end, function()
    end)
    

end)


RegisterNetEvent("largearms:GUNSRETURNED")
AddEventHandler("largearms:GUNSRETURNED", function(table)
returnedGuns2 = table 
end)

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
        for k,v in pairs(large.gunshops) do
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
    for k,v in pairs(large.gunshops) do
    local blip = AddBlipForCoord(v)
    SetBlipSprite(blip, 150)
    SetBlipScale(blip, 0.6)
    SetBlipDisplay(blip, 2)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Large Arms Dealer")
    EndTextCommandSetBlipName(blip)
    end
    while true do
        Citizen.Wait(0)
        for k, v in pairs(large.gunshops) do
            if isInArea(v, 100.0) then 
                DrawMarker(27,v.x,v.y,v.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isInArea(v, 1.4) and isInLarge == false then 
                alert('Press ~INPUT_VEH_HORN~ to access Large Arms')
                if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent("largearms:PULLWHITELISTEDWEAPONS")
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("LargeArmsMenu", "main"), true)
                    isInLarge = true
                    currentAmmunition = k 
                end
            end
            if isInArea(v, 1.4) == false and isInLarge and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("LargeArmsMenu", "main"), false)
                RageUI.Visible(RMenu:Get("LargeArmsMenu", "sub"), false)
                RageUI.Visible(RMenu:Get("LargeArmsMenu", "whitelistedguns"), false)
                currentAmmunition = nil
                currentGunHash = nil
                currentGunPrice = nil
                currentGunName = nil
                currentGunHash1 = nil
                currentGunPrice1 = nil
                currentGunName1 = nil
                isInLarge = false
                hoveredArmour = false
                DeleteObject(O)
            end
        end
    end
end)

RegisterNetEvent('Large:SendCommision')
AddEventHandler('Large:SendCommision', function(com)
   CurrentCommsion = com
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