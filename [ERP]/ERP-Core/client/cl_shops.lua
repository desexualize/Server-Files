local cfg = module("ERP-Core", "cfg/cfg_stores")
local inMenu = false
local currentShop = nil
local currentItemID = nil
local currentItemPrice = nil
local currentItemName = nil
local maxAmount = {}
local amount = 1

for i = 1, 100 do
    table.insert(maxAmount, i)
end

RMenu.Add("ERP:Shops", "main", RageUI.CreateMenu("Shop", "~b~Shop", 1350, 50))
RMenu.Add("ERP:Shops", "sub", RageUI.CreateSubMenu(RMenu:Get("ERP:Shops", "main"), "Shop", "~b~Confirm Purchase", 1350, 50))

RageUI.CreateWhile(1.0, RMenu:Get("ERP:Shops", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("ERP:Shops", "main"), true, false, true, function()
        for k, v in pairs(cfg.items) do
            if v.type == 'store' then
                RageUI.Button(v.name, "£"..getMoneyStringFormatted(v.price), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        currentItemID = v.itemID
                        currentItemPrice = v.price
                        currentItemName = v.name
                    end
                end, RMenu:Get("ERP:Shops", "sub", true))
            end
        end

    end, function() 
    end)

    RageUI.IsVisible(RMenu:Get("ERP:Shops", "sub"), true, false, true, function()
        RageUI.List("Amount", maxAmount, amount, nil, {}, true, function(Hovered, Active, Selected, Index)
            amount = Index
        end)
        RageUI.Button("~g~Confirm Purchase",nil,  {RightLabel = "£"..getMoneyStringFormatted(currentItemPrice * amount)}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("ERP:BuyShopItem", currentItemID, amount)
            end
        end, RMenu:Get("ERP:Shops", "main", true))

    end, function()
    end)
end)

Citizen.CreateThread(function()

    for k, v in pairs(cfg.shops) do
        local blip = AddBlipForCoord(v)
        SetBlipSprite(blip, 52)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Shop")
        EndTextCommandSetBlipName(blip)
    end

    for k,v in pairs(cfg.peds) do
        if cfg.ped == true then
            local shopPed = GetHashKey("mp_m_shopkeep_01")
            RequestModel(shopPed)
            while not HasModelLoaded(shopPed) do
                Wait(0)
            end
    
            local pedx,pedy,pedz,pedh = table.unpack(v) --ped x, ped y, ped z, ped heading
            local shopEntity = CreatePed(26,shopPed,pedx,pedy,pedz,pedh,false,true)
            SetModelAsNoLongerNeeded(shopPed)     
            SetEntityCanBeDamaged(shopEntity, 0)
            SetPedAsEnemy(shopEntity, 0)   
            SetBlockingOfNonTemporaryEvents(shopEntity, 1)
            SetPedResetFlag(shopEntity, 249, 1)
            SetPedConfigFlag(shopEntity, 185, true)
            SetPedConfigFlag(shopEntity, 108, true)
            SetEntityInvincible(shopEntity, true)
            SetEntityCanBeDamaged(shopEntity, false)
            SetPedCanEvasiveDive(shopEntity, 0)
            SetPedCanRagdollFromPlayerImpact(shopEntity, 0)
            SetPedConfigFlag(shopEntity, 208, true)       
            FreezeEntityPosition(shopEntity, true)
        end
    end
    
    while true do
        Citizen.Wait(0)

        for k, v in pairs(cfg.shops) do
            if isInArea(v, 100.0) then
                DrawMarker(29, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 255, 60, false, true, 2, true)
            end

            if isInArea(v, 1.0) and inMenu == false then
                alert('Press ~INPUT_VEH_HORN~ to open the Store!')
                if IsControlJustPressed(0, 51) then 
                    inMenu = true
                    currentShop = k
                    RageUI.Visible(RMenu:Get("ERP:Shops", "main"), true)
                end
            end

            if isInArea(v, 1.0) == false and inMenu and k == currentShop then
                inMenu = false
                currentShop = nil
                currentItemID = nil
                currentItemPrice = nil
                currentItemName = nil
                RageUI.CloseAll()
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
