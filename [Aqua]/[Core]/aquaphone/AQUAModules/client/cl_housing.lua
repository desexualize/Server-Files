tAQUA = Proxy.getInterface("AQUA")

local Housing = module("AQUAModules", "cfg/cfg_homes")

local inHome = false
local isInMenu = false
local isInLeaveMenu = false
local isInWardrobeMenu = false
local currentHome = nil
local currentOutfit = nil
local currentHousePrice = 0
local owned = false
wardrobe = {}
ownedHouses = {}

RMenu.Add("JudHousing", "main", RageUI.CreateMenu("", "", GetRageUIMenuWidth(),GetRageUIMenuHeight(),"banners","homes"))
RMenu.Add("JudHousing", "leave", RageUI.CreateMenu("", "", GetRageUIMenuWidth(),GetRageUIMenuHeight(),"banners","homes"))
RMenu.Add("JudHousing", "wardrobe", RageUI.CreateMenu("", "~d~Wardrobe", GetRageUIMenuWidth(),GetRageUIMenuHeight(),"hobannersme","homes"))
RMenu.Add("JudHousing", "wardrobesub", RageUI.CreateSubMenu(RMenu:Get("JudHousing", "wardrobe"), "", "~d~Wardrobe", GetRageUIMenuWidth(),GetRageUIMenuHeight(),"banners","homes"))

RageUI.CreateWhile(1.0, RMenu:Get("JudHousing", "main"), nil, function()

    --Enter Menu
    maxKG = Housing.chestsize[currentHome] or 500
    RageUI.IsVisible(RMenu:Get("JudHousing", "main"), true, false, true, function()
        RageUI.Separator('Price: ~g~£'..getMoneyStringFormatted(currentHousePrice))
        RageUI.Separator('Storage: ~g~'..maxKG..'kg')
        RageUI.ButtonWithStyle("Enter Home/Doorbell", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("JudHousing:Enter", currentHome)
            end
        end)
        if owned ~= true then
            RageUI.ButtonWithStyle("~g~Buy Home", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("JudHousing:Buy", currentHome)
                end
            end)
        end

        RageUI.ButtonWithStyle("~d~Sell Home", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("JudHousing:Sell", currentHome)
            end
        end)

    end, function()
    end)

    --Leave Menu

    RageUI.IsVisible(RMenu:Get("JudHousing", "leave"), true, false, true, function()

        RageUI.ButtonWithStyle("Leave Home", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("JudHousing:Leave", currentHome)
            end
        end)

    end, function()
    end)

    --Wardrobe Main Menu

    RageUI.IsVisible(RMenu:Get("JudHousing", "wardrobe"), true, false, true, function()

        for k, v in pairs(wardrobe) do
            RageUI.ButtonWithStyle(k, nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    currentOutfit = k
                    savedArmour = GetPedArmour(PlayerPedId())
                end
            end, RMenu:Get("JudHousing", "wardrobesub"))
        end

        RageUI.ButtonWithStyle("~g~Save Outfit", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                AddTextEntry("FMMC_MPM_NC", "Outfit Name")
                DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0);
                    Wait(0);
                end
                if (GetOnscreenKeyboardResult()) then
                    local result = GetOnscreenKeyboardResult()
                    if result then
                        TriggerServerEvent("JudHousing:SaveOutfit", result)
                    end
                end
            end
        end)

    end, function()
    end)

    --Wardrobe Sub Menu

    RageUI.IsVisible(RMenu:Get("JudHousing", "wardrobesub"), true, false, true, function()

        RageUI.ButtonWithStyle("~g~Equip Outfit", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                for k, v in pairs(wardrobe) do
                    if k == currentOutfit then
                        tAQUA.setCustomization({v})
                        
                        SetTimeout(50, function()
                            SetPedArmour(PlayerPedId(), savedArmour)
                            TriggerServerEvent('AQUA:changeHairStyle')
                        end)
                    end
                end
            end
        end, RMenu:Get("JudHousing", "wardrobe"))

        RageUI.ButtonWithStyle("~d~Remove Outfit", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("JudHousing:RemoveOutfit", currentOutfit)
            end
        end, RMenu:Get("JudHousing", "wardrobe"))

    end, function()
    end)
end)

--Thread






Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if not HasStreamedTextureDictLoaded("clothing") then
            RequestStreamedTextureDict("clothing", true)
            while not HasStreamedTextureDictLoaded("clothing") do
                Wait(1)
            end
        end

        for k, v in pairs(cfghomes.homes) do
            --Enter Home

            -- for a,b in pairs(ownedHouses) do


            if isInArea(v.entry_point, 100) then
                DrawMarker(20, v.entry_point, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 25, 100, false, true, 2, false)
            end

            if isInArea(v.entry_point, 0.8) and isInMenu == false then 
                currentHome = k
                currentHousePrice = v.buy_price
                RMenu:Get("JudHousing", "main"):SetSubtitle("~d~" .. currentHome)
                RageUI.Visible(RMenu:Get("JudHousing", "main"), true)
                isInMenu = true
            end

            if isInArea(v.entry_point, 0.8) == false and isInMenu and currentHome == k then
                RageUI.Visible(RMenu:Get("JudHousing", "main"), false)
                isInMenu = false
            end

            if currentHome == k then

                --Chest

                if inHome then
                    DrawMarker(9, v.chest_point, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 0.8, 0.8, 0.8, 224, 224, 244, 1.0, false, false, 2, true, "dp_clothing", "bag", false)
                end

                if isInArea(v.chest_point, 0.8) and inHome then
                    alert("~y~Press ~INPUT_VEH_HORN~ To Open House Chest!")
                    if IsControlJustPressed(0, 51) then
                        TriggerServerEvent("JudHousing:OpenChest", currentHome)
                    end
                end

                --Wardrobe

                if inHome then
                    DrawMarker(9, v.wardrobe_point, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 255, 60, false, true, 2, false, "clothing", "clothing", false)
                end

                if isInArea(v.wardrobe_point, 0.8) and isInWardrobeMenu == false and inHome then
                    TriggerServerEvent("JudHousing:LoadWardrobe")
                    currentHome = k
                    RageUI.Visible(RMenu:Get("JudHousing", "wardrobe"), true)
                    isInWardrobeMenu = true
                end

                if isInArea(v.wardrobe_point, 0.8) == false and isInWardrobeMenu and currentHome == k and inHome then
                    RageUI.Visible(RMenu:Get("JudHousing", "wardrobe"), false)
                    isInWardrobeMenu = false
                end

                --Leave Home

                if inHome then
                    DrawMarker(20, v.leave_point, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 25, 100, false, true, 2, false)
                end

                if isInArea(v.leave_point, 0.8) and isInLeaveMenu == false and inHome then
                    currentHome = k
                    RMenu:Get("JudHousing", "leave"):SetSubtitle("~d~" .. currentHome)
                    RageUI.Visible(RMenu:Get("JudHousing", "leave"), true)
                    isInLeaveMenu = true
                end

                if isInArea(v.leave_point, 0.8) == false and isInLeaveMenu and currentHome == k and inHome then
                    RageUI.Visible(RMenu:Get("JudHousing", "leave"), false)
                    isInLeaveMenu = false
                   
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
     if inHome then
         NetworkConcealPlayer(GetPlayerPed(-1), true, false)
    else 
         NetworkConcealPlayer(GetPlayerPed(-1), false, false)
      end
   end
end)


RegisterNetEvent("JudHousing:UpdateInHome")
AddEventHandler("JudHousing:UpdateInHome", function(inTheHome)
    inHome = inTheHome
end)

RegisterNetEvent("JudHousing:UpdateWardrobe")
AddEventHandler("JudHousing:UpdateWardrobe", function(newWardrobe)
    wardrobe = newWardrobe
end)

-- RegisterNetEvent("printownedhouses")
-- AddEventHandler("printownedhouses", function(test)
--     ownedHouses = test
--     for k,v in pairs(ownedHouses) do
--     print(k)
--     end
-- end)


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

function isInArea(v, dis) 
    if #(GetEntityCoords(PlayerPedId()) - v) <= dis then  
        return true
    else 
        return false
    end
end