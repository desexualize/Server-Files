local currentMeleeHash = nil
local currentMeleePrice = nil
local currentMeleeName = nil
local currentMeleeHash1 = nil
local currentMeleePrice1 = nil
local currentMeleeName1 = nil 




returnedMelee2 = {}
RMenu.Add('KnifeStoreMenu', 'main', RageUI.CreateMenu("", "~d~Knife Store", 1300, 50, "banners", "knife"))
RMenu.Add("KnifeStoreMenu", "sub", RageUI.CreateSubMenu(RMenu:Get("KnifeStoreMenu", "main"), "", "~d~ Knife Store", 1300, 50, "banners", "knife"))
RMenu.Add("KnifeStoreMenu", "whietlistedmelees", RageUI.CreateSubMenu(RMenu:Get("KnifeStoreMenu", "main"), "", "~d~ Knife Store", 1300, 50, "banners", "knife"))
RageUI.CreateWhile(1.0, RMenu:Get('KnifeStoreMenu', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('KnifeStoreMenu', 'main'), true, false, true, function()
        for i , p in pairs(knife.knives) do 
            RageUI.ButtonWithStyle(p.name , "~g~"..knife.currency..tostring(getMoneyStringFormatted(p.price)), { RightLabel =  "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                     currentMeleeHash = p.hash
                     currentMeleePrice = p.price
                     currentMeleeName = p.name
                end
            end, RMenu:Get("KnifeStoreMenu", "sub"))
        end
        for i , o in pairs(returnedMelee2) do 
            RageUI.ButtonWithStyle(o.name , "~g~"..knife.currency..tostring(getMoneyStringFormatted(o.price)), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    currentMeleeHash1 = o.gunhash
                    currentMeleePrice1 = o.price
                    currentMeleeName1 = o.name
                end
            end, RMenu:Get("KnifeStoreMenu", "whietlistedmelees"))
        end
    end, function()
    end)
    RageUI.IsVisible(RMenu:Get("KnifeStoreMenu", "sub"), true, false, true, function()
        RageUI.ButtonWithStyle("Purchase Weapon Body" , "Purchase "..currentMeleeName.." and Max Ammo", { RightLabel = "~g~£"..tostring(getMoneyStringFormatted(currentMeleePrice)) }, true, function(Hovered, Active, Selected)
            if Selected then
                local Ped = PlayerPedId()
                if HasPedGotWeapon(Ped, currentMeleeHash, false) then
                    notify("~d~You already have this weapon equipped.")
                else
                    TriggerServerEvent('AQUA:BuyKnife', currentMeleeHash)
                end
            end
        end)
    end, function()
    end)
    
    RageUI.IsVisible(RMenu:Get("KnifeStoreMenu", "whietlistedmelees"), true, false, true, function()
        RageUI.ButtonWithStyle("Purchase Weapon Body" , "Purchase "..currentMeleeName1.." and Max Ammo", { RightLabel = "~g~£"..tostring(getMoneyStringFormatted(currentMeleePrice1)) }, true, function(Hovered, Active, Selected)
            if Selected then
                local Ped = PlayerPedId()
                if HasPedGotWeapon(Ped, currentMeleeHash1, false) then
                    notify("~d~You already have this weapon equipped.")
                else
                    TriggerServerEvent('AQUA:BuyWLKnife', currentMeleeHash1)
                end
            end
        end)
    
     
    end, function()
    end) 
end)



RegisterNetEvent("SHANK:GUNSRETURNED")
AddEventHandler("SHANK:GUNSRETURNED", function(table)
    returnedMelee2 = table 
end)

RegisterNetEvent('AQUA:Error')
AddEventHandler('AQUA:Error', function()
    RageUI.Visible(RMenu:Get("KnifeStoreMenu", "main"))
    alert('~d~Insufficent funds')
end)

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end


isInKnife = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    for k, v in pairs(knife.shops) do
        local blip = AddBlipForCoord(v)
        SetBlipSprite(blip, 154)
        SetBlipScale(blip, 0.8)
        SetBlipDisplay(blip, 2)
        SetBlipColour(blip, 1)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Knife Shop")
        EndTextCommandSetBlipName(blip)
    end
   
    while true do
        Citizen.Wait(0)
        for k,v in pairs(knife.shops) do
            -- will work when knife store is made server side
--[[             if currentMeleeHash ~= nil or currentMeleeHash1 ~= nil then
                for k,v in pairs(weaponmodels.models) do 
                    if currentMeleeHash == v[1] or currentMeleeHash1 == v[1] then
                        model = k
                    end
                end
                local N=loadModel(model)
                local O=CreateObject(N,v.x,v.y,v.z+0.3,false,false,false)
                while currentMeleeHash ~= nil or currentMeleeHash1 ~= nil and DoesEntityExist(O)do 
                    SetEntityHeading(O,GetEntityHeading(O)+1%360)
                    Wait(0)
                end
                DeleteEntity(O)
            end ]]
            if isInArea(v, 100.0) then 
                DrawMarker(27, v.x, v.y, v.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isInKnife == false then
            if isInArea(v, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access ~d~Knife Store')
                if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent("SHANK:PULLWHITELISTEDWEAPONS")
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("KnifeStoreMenu", "main"), true)
                    isInKnife = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v, 1.4) == false and isInKnife and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("KnifeStoreMenu", "main"), false)
                RageUI.Visible(RMenu:Get("KnifeStoreMenu", "sub"), false)
                RageUI.Visible(RMenu:Get("KnifeStoreMenu", "whietlistedmelees"), false)
                isInKnife = false
                currentMeleeHash = nil
                currentMeleePrice = nil
                currentMeleeName = nil
                currentMeleeHash1 = nil
                currentMeleePrice1 = nil
                currentMeleeName1 = nil 
                currentAmmunition = nil
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



