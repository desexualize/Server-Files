
-- Credit to jud#8976 for making this for FNR.

local cfg = module("FNR-Core", "cfg/cfg_licenses")
local currentLicense = nil
local currentLicensePrice = nil
local currentType = nil
local inMenu = false

RMenu.Add("FNR:LicenseStore", "main", RageUI.CreateMenu("", "~b~License Store", 1350, 50,"banners","licenses"))
RMenu.Add("FNR:LicenseStore", "sub", RageUI.CreateSubMenu(RMenu:Get("FNR:LicenseStore", "main"), "", "~b~License Store", 1350, 50))
RMenu.Add("FNR:LicenseStore", "confirm", RageUI.CreateSubMenu(RMenu:Get("FNR:LicenseStore", "sub"), "", "~b~Confirm License Purchase", 1350, 50))

RageUI.CreateWhile(1.0, RMenu:Get("FNR:LicenseStore", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("FNR:LicenseStore", "main"), true, false, true, function()

        RageUI.Button("~g~Grinding Licenses", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                currentType = "grinding"
            end
        end, RMenu:Get("FNR:LicenseStore", "sub", true))

        RageUI.Button("~r~Illegal Licenses", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                currentType = "other"
            end
        end, RMenu:Get("FNR:LicenseStore", "sub", true))

    end, function() 
    end)

    RageUI.IsVisible(RMenu:Get("FNR:LicenseStore", "sub"), true, false, true, function()

        for k, v in pairs(cfg.licenses) do
            if v.type == currentType then
                RageUI.Button(v.name, nil, {RightLabel = "~g~£"..getMoneyStringFormatted(v.price)}, true, function(Hovered, Active, Selected)
                    if Selected then
                        currentLicense = v.name
                        currentLicensePrice = v.price
                        RMenu:Get("FNR:LicenseStore", "confirm"):SetSubtitle("~b~Are you sure you want to buy "..v.name.."?")
                    end
                end, RMenu:Get("FNR:LicenseStore", "confirm", true))
            end
        end

    end, function() 
    end)

    RageUI.IsVisible(RMenu:Get("FNR:LicenseStore", "confirm"), true, false, true, function()

        RageUI.Separator("You are buying "..currentLicense.." for ~g~£"..getMoneyStringFormatted(currentLicensePrice))
        RageUI.Separator("")

        RageUI.Button("~g~Confirm Purchase", nil, {RightLabel = "~g~£"..getMoneyStringFormatted(currentLicensePrice)}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("FNR:BuyLicense", currentLicense)
            end
        end, RMenu:Get("FNR:LicenseStore", "main", true))

        RageUI.Button("~r~Cancel", nil, {}, true, function(Hovered, Active, Selected)
        end, RMenu:Get("FNR:LicenseStore", "main", true))

    end, function() 
    end)
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(cfg.licenseShopLocation)
    SetBlipSprite(blip, 525)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 2)
    SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("License Store")
    EndTextCommandSetBlipName(blip)
    while true do
        Citizen.Wait(0)

        if isInArea(cfg.licenseShopLocation, 100.0) then
            DrawMarker(27, cfg.licenseShopLocation.x, cfg.licenseShopLocation.y, cfg.licenseShopLocation.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 0, 255, 0, 60, false, false, 2, false)
        end

        if isInArea(cfg.licenseShopLocation, 1.0) and inMenu == false then
            alert('Press ~INPUT_VEH_HORN~ to open the License Store!')
            if IsControlJustPressed(0, 51) then 
                inMenu = true
                RageUI.Visible(RMenu:Get("FNR:LicenseStore", "main"), true)
            end
        end

        if isInArea(cfg.licenseShopLocation, 1.0) == false and inMenu then
            inMenu = false
            RageUI.CloseAll()
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