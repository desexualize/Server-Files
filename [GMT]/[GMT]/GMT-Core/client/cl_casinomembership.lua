local a = {
    {
        pedPosition = vector3(1088.0207519531, 221.13066101074, -49.200397491455),
        pedHeading = 175.0,
    }
}
local cfg = module("GMT-Core", "cfg/cfg_licenses")
local currentLicense = nil
local currentLicensePrice = nil
local currentType = nil
local inMenu = false

local function LoadModel(modelName)
    local modelHash
    if type(modelName) ~= "string" then
        modelHash = modelName
    else
        modelHash = GetHashKey(modelName)
    end
    if IsModelInCdimage(modelHash) then
        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Wait(0)
            end
        end
        return modelHash
    else
        return nil
    end
end

Citizen.CreateThread(function()
    local f = "mini@strip_club@idles@bouncer@base"
    RequestAnimDict(f)
    while not HasAnimDictLoaded(f) do
        RequestAnimDict(f)
        Wait(0)
    end
    for g, h in pairs(a) do
        local i = LoadModel("u_f_m_casinocash_01")
        local j = CreatePed(26, i, h.pedPosition.x, h.pedPosition.y, h.pedPosition.z, 175.0, false, true)
        SetModelAsNoLongerNeeded(i)
        SetEntityCanBeDamaged(j, 0)
        SetPedAsEnemy(j, 0)
        SetBlockingOfNonTemporaryEvents(j, 1)
        SetPedResetFlag(j, 249, 1)
        SetPedConfigFlag(j, 185, true)
        SetPedConfigFlag(j, 108, true)
        SetPedCanEvasiveDive(j, 0)
        SetPedCanRagdollFromPlayerImpact(j, 0)
        SetPedConfigFlag(j, 208, true)
        SetEntityCoordsNoOffset(j, h.pedPosition.x, h.pedPosition.y, h.pedPosition.z, 175.0, 0, 0, 1)
        SetEntityHeading(j, h.pedHeading)
        FreezeEntityPosition(j, true)
        TaskPlayAnim(j, f, "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        RemoveAnimDict(f)
    end
end)

RMenu.Add("GMT:CasinoLicenseStore", "main", RageUI.CreateMenu("", "~b~Casino License Store", 1350, 50,"banners","blackjack"))
RMenu.Add("GMT:CasinoLicenseStore", "sub", RageUI.CreateSubMenu(RMenu:Get("GMT:CasinoLicenseStore", "main"), "", "~b~License Store", 1350, 50))
RMenu.Add("GMT:CasinoLicenseStore", "remove", RageUI.CreateSubMenu(RMenu:Get("GMT:CasinoLicenseStore", "main"), "", "~b~Confirm Remove License", 1350, 50))
RMenu.Add("GMT:CasinoLicenseStore", "confirm", RageUI.CreateSubMenu(RMenu:Get("GMT:CasinoLicenseStore", "sub"), "", "~b~Confirm License Purchase", 1350, 50))

RageUI.CreateWhile(1.0, RMenu:Get("GMT:CasinoLicenseStore", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("GMT:CasinoLicenseStore", "main"), true, false, true, function()

        RageUI.Button("Casino Licenses", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                currentType = "casino"
            end
        end, RMenu:Get("GMT:CasinoLicenseStore", "sub", true))

    end, function() 
    end)

    RageUI.IsVisible(RMenu:Get("GMT:CasinoLicenseStore", "sub"), true, false, true, function()

        for k, v in pairs(cfg.licenses) do
            if v.type == currentType then
                RageUI.Button(v.name, nil, {RightLabel = "~g~£"..getMoneyStringFormatted(v.price)}, true, function(Hovered, Active, Selected)
                    if Selected then
                        currentLicense = v.name
                        currentLicensePrice = v.price
                        RMenu:Get("GMT:CasinoLicenseStore", "confirm"):SetSubtitle("~b~Are you sure you want to buy "..v.name.."?")
                    end
                end, RMenu:Get("GMT:CasinoLicenseStore", "confirm", true))
            end
        end

        RageUI.Button("Remove High Roller License", nil, {RightLabel = "~g~£0"}, true, function(Hovered, Active, Selected)
            if Selected then
                currentLicense = 'High Roller'
            end
        end, RMenu:Get("GMT:CasinoLicenseStore", "remove", true))

    end, function() 
    end)

    RageUI.IsVisible(RMenu:Get("GMT:CasinoLicenseStore", "confirm"), true, false, true, function()

        RageUI.Separator("You are buying "..currentLicense.." for ~g~£"..getMoneyStringFormatted(currentLicensePrice))
        RageUI.Separator("")

        RageUI.Button("~g~Confirm Purchase", nil, {RightLabel = "~g~£"..getMoneyStringFormatted(currentLicensePrice)}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("GMT:BuyLicense", currentLicense)
            end
        end, RMenu:Get("GMT:CasinoLicenseStore", "main", true))

        RageUI.Button("~r~Cancel", nil, {}, true, function(Hovered, Active, Selected)
        end, RMenu:Get("GMT:CasinoLicenseStore", "main", true))

    end, function() 
    end)

    RageUI.IsVisible(RMenu:Get("GMT:CasinoLicenseStore", "remove"), true, false, true, function()

        RageUI.Separator("You are removing "..currentLicense)
        RageUI.Separator("This is final and will not be refunded.")

        RageUI.Button("~g~Confirm Removal", nil, {RightLabel = "~g~£0"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("GMT:RemoveLicense", currentLicense)
            end
        end, RMenu:Get("GMT:CasinoLicenseStore", "main", true))

        RageUI.Button("~r~Cancel", nil, {}, true, function(Hovered, Active, Selected)
        end, RMenu:Get("GMT:CasinoLicenseStore", "main", true))

    end, function() 
    end)

end)


Citizen.CreateThread(function()

    while true do
        Citizen.Wait(0)

        if isInArea(cfg.casinolicenseShopLocation, 100.0) then
            DrawMarker(25, cfg.casinolicenseShopLocation.x, cfg.casinolicenseShopLocation.y, cfg.casinolicenseShopLocation.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, 0, 0, 255, 60, false, false, 2, false)
        end

        if isInArea(cfg.casinolicenseShopLocation, 1.0) and inMenu == false then
            alert('Press ~INPUT_VEH_HORN~ to open the Casino Menu!')
            if IsControlJustPressed(0, 51) then 
                inMenu = true
                RageUI.Visible(RMenu:Get("GMT:CasinoLicenseStore", "main"), true)
            end
        end

        if isInArea(cfg.casinolicenseShopLocation, 1.0) == false and inMenu then
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
