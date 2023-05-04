local isInSmallarms = false
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

returnedSMALLGuns2 = {}

RMenu.Add("SmallArmsMenu", "main", RageUI.CreateMenu("", "~d~ Small Arms", 1300, 50, "banners", "small"))
RMenu.Add("SmallArmsMenu", "sub", RageUI.CreateSubMenu(RMenu:Get("SmallArmsMenu", "main"), "", "~d~ Small Arms", 1300, 50, "banners", "small"))
RMenu.Add("SmallArmsMenu", "whitelisted", RageUI.CreateSubMenu(RMenu:Get("SmallArmsMenu", "main"), "", "~d~ Small Arms", 1300, 50, "banners", "small"))
RageUI.CreateWhile(1.0, RMenu:Get("SmallArmsMenu", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("SmallArmsMenu", "main"), true, false, true, function()
        for i, p in pairs(smallarms.guns) do 
            RageUI.ButtonWithStyle(p.name , "~g~£"..getMoneyStringFormatted(p.price), { RightLabel =  "→→→"}, true, function(Hovered, Active, Selected)
                if Active then
                    currentGunHash = nil
                    hoveredArmour = false
                end
                if Selected then
                    currentGunHash = p.hash
                    currentGunPrice = p.price
                    currentGunName = p.name
                end
            end, RMenu:Get("SmallArmsMenu", "sub"))
        end
        for f , a in pairs(returnedSMALLGuns2) do 
            RageUI.ButtonWithStyle(a.name , "~g~£"..getMoneyStringFormatted(a.price), {RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Active then
                    currentGunHash1 = nil
                    hoveredArmour = false
                end
                if Selected then
                    currentGunHash1 = a.gunhash
                    currentGunPrice1 = a.price
                    currentGunName1 = a.name
        
                end
            end, RMenu:Get("SmallArmsMenu", "whitelisted"))
        end
        RageUI.ButtonWithStyle("Level 1 Armour [25%]" , "~g~£"..getMoneyStringFormatted(smallarms.armourprice), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Active then
                hoveredArmour = true
            end
            if Selected then
                TriggerServerEvent("SmallArms:BuyArmour")
            end
        end)
    end, function()
    end)

    RageUI.IsVisible(RMenu:Get("SmallArmsMenu", "sub"), true, false, true, function()
        RageUI.ButtonWithStyle("Purchase Weapon Body" , "Purchase "..currentGunName.." and Max Ammo", { RightLabel = "~g~£"..getMoneyStringFormatted(currentGunPrice) }, true, function(Hovered, Active, Selected)
            if Selected then
                local Ped = PlayerPedId()
                if HasPedGotWeapon(Ped, currentGunHash, false) then
                    notify("~d~You already have this weapon equipped.")
                else
                TriggerServerEvent("SMALLARMS:BuyWeapon", currentGunHash)
                end
            end
        end)

        RageUI.ButtonWithStyle("Buy Max Ammo", "Purchase Max Ammo for "..currentGunName, { RightLabel = "~g~£"..getMoneyStringFormatted(math.floor(currentGunPrice / 2)) }, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("SMALLARMS:BuyWeaponAmmo", currentGunHash)
            end
        end)
    end, function()
    end)

    RageUI.IsVisible(RMenu:Get("SmallArmsMenu", "whitelisted"), true, false, true, function()
        RageUI.ButtonWithStyle("Purchase Weapon Body" , "Purchase "..currentGunName1.." and Max Ammo", { RightLabel = "~g~£"..getMoneyStringFormatted(currentGunPrice1) }, true, function(Hovered, Active, Selected)
            if Selected then
                local Ped = PlayerPedId()
                if HasPedGotWeapon(Ped, currentGunHash1, false) then
                notify("~d~You already have this weapon equipped.")
                else
                TriggerServerEvent("SMALLARMS:BuyWeapon2", currentGunHash1)
                end
            end
        end)

        RageUI.ButtonWithStyle("Buy Max Ammo", "Purchase Max Ammo for "..currentGunName1, { RightLabel = "~g~£"..getMoneyStringFormatted(currentGunPrice1 / 2) }, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("SMALLARMS:BuyWeaponAmmo2", currentGunHash1)
            end
        end)
    end, function()
    end)
end)

RegisterNetEvent("SMALL:GUNSRETURNED")
AddEventHandler("SMALL:GUNSRETURNED", function(table)

    returnedSMALLGuns2 = table 
end)


RegisterNetEvent("SmallArms:Error")
AddEventHandler("SmallArms:Error", function()
    RageUI.Visible(RMenu:Get("SmallArmsMenu", "main"))
end)


Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
        for k,v in pairs(smallarms.gunshops) do
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
    for k, v in pairs(smallarms.gunshops) do
        local blip = AddBlipForCoord(v)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 0.7)
        SetBlipDisplay(blip, 2)
        SetBlipColour(blip, 1)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Small Arms Dealer")
        EndTextCommandSetBlipName(blip)
    end
    while true do
        Citizen.Wait(0)
        for k, v in pairs(smallarms.gunshops) do
            if isInArea(v, 100.0) then 
                DrawMarker(27,v.x,v.y,v.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isInArea(v, 1.4) and isInSmallarms == false then 
                alert("Press ~INPUT_VEH_HORN~ to access ~d~Small Arms")
                if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent("SMALL:PULLWHITELISTEDWEAPONS")
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("SmallArmsMenu", "main"), true)
                    isInSmallarms = true
                    currentAmmunition = k 
                end
            end
            if isInArea(v, 1.4) == false and isInSmallarms and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("SmallArmsMenu", "main"), false)
                RageUI.Visible(RMenu:Get("SmallArmsMenu", "sub"), false)
                RageUI.Visible(RMenu:Get("SmallArmsMenu", "whitelisted"), false)
                currentAmmunition = nil
                currentGunHash = nil
                currentGunPrice = nil
                currentGunName = nil
                currentGunHash1 = nil
                currentGunPrice1 = nil
                currentGunName1 = nil
                isInSmallarms = false
                hoveredArmour = false
                DeleteObject(O)
            end
        end
    end
end)

function isInArea(v, dis) 
    if #(GetEntityCoords(PlayerPedId()) - v) <= dis then  
        return true
    else 
        return false
    end
end

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
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