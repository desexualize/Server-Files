local isInWHITELISTEDGANGS = false
local currentAmmunition = nil
local currentGunHash = nil
local currentGunPrice = nil
local currentGunName = nil
local returnedGuns2 = {}

RMenu.Add("WHITELISTEDGANGS", "main", RageUI.CreateMenu("", "Gun Shop", 1300, 50, "banners", "gunshop"))
RMenu.Add("WHITELISTEDGANGS", "sub", RageUI.CreateSubMenu(RMenu:Get("WHITELISTEDGANGS", "main"), "", "Gun Shop", 1300, 50, "banners", "gunshop"))

RageUI.CreateWhile(1.0, RMenu:Get("WHITELISTEDGANGS", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("WHITELISTEDGANGS", "main"), true, false, true, function()
        for i , p in pairs(returnedGuns2) do 
            RageUI.Button(p.name , nil, { RightLabel =  "~g~£"..getMoneyStringFormatted(p.price)}, true, function(Hovered, Active, Selected)
                if Selected then
                    currentGunHash = p.gunhash
                    currentGunPrice = p.price
                    currentGunName = p.name
                end
            end, RMenu:Get("WHITELISTEDGANGS", "sub"))
        end

    end, function()
    end)

RageUI.IsVisible(RMenu:Get("WHITELISTEDGANGS", "sub"), true, false, true, function()
    RageUI.Button("Purchase Weapon Body" , "Purchase "..currentGunName.." and Max Ammo", { RightLabel = "~g~£"..tostring(getMoneyStringFormatted(currentGunPrice)) }, true, function(Hovered, Active, Selected)
        if Selected then
            TriggerServerEvent("WHITELISTEDGANGS:BuyWeapon", currentGunHash)
        end
    end)
    if not currentGunHash == "WEAPON_PEAKYHAT" then
        RageUI.Button("Buy Max Ammo", "Purchase Max Ammo for "..currentGunName, {  RightLabel = "~g~£"..tostring(getMoneyStringFormatted(math.floor(currentGunPrice / 2)))}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("WHITELISTEDGANGS:BuyWeaponAmmo", currentGunHash)
            end
        end)
    end

    end, function()
    end)
end)



Citizen.CreateThread(function() 
    TriggerServerEvent("sendWhitelistedgang")

    while true do
        Citizen.Wait(0)
        for k,v in pairs(WHITELISTEDGANGS.gunshops) do
            if isInArea(v, 100.0) then 
                if hasPermsLad then
                    DrawMarker(27,v.x,v.y,v.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 250, 0, 0, 2, 0, 0, 0, false)
                end
            end

            if isInArea(v, 1.4) and isInWHITELISTEDGANGS == false then 
                if hasPermsLad then
                    alert("Press ~INPUT_VEH_HORN~ to access Gun Store")
                    if IsControlJustPressed(0, 51) then 
                        TriggerServerEvent("WHITELISTEDGANGS:PULLWHITELISTEDWEAPONS")
                        currentAmmunition = k
                        RageUI.Visible(RMenu:Get("WHITELISTEDGANGS", "main"), true)
                        isInWHITELISTEDGANGS = true
                        currentAmmunition = k
                    end
                end
            end

            if isInArea(v, 1.4) == false and isInWHITELISTEDGANGS and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("WHITELISTEDGANGS", "main"), false)
                RageUI.Visible(RMenu:Get("WHITELISTEDGANGS", "sub"), false)
                isInWHITELISTEDGANGS = false
                currentAmmunition = nil
                currentGunHash = nil
                currentGunPrice = nil
                currentGunName = nil
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

RegisterNetEvent("WHITELISTEDGANGS:GUNSRETURNED")
AddEventHandler("WHITELISTEDGANGS:GUNSRETURNED", function(table)
    returnedGuns2 = table 
end)

RegisterNetEvent('returnsendWhitelistedgang')
AddEventHandler('returnsendWhitelistedgang', function(bool)
    if bool then 
        hasPermsLad = true 
    else
        hasPermsLad = false
    end
end)