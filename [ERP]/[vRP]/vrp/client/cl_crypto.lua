local cfg = module("vrp", "cfg/cfg_crypto")
local selected_system = nil
local selected_managed_system = nil
local cryptoprice = 10000
local machines_owned = {}

RMenu.Add('CryptoMiner', 'main', RageUI.CreateMenu("", "Crypto Systems",1300,100, "crypto", "crypto"))
RMenu.Add('CryptoMiner', 'buy_systems',  RageUI.CreateSubMenu(RMenu:Get("CryptoMiner", "main")))
RMenu.Add('CryptoMiner', 'buy_systems_manage',  RageUI.CreateSubMenu(RMenu:Get("CryptoMiner", "buy_systems")))
RMenu.Add('CryptoMiner', 'manage_systems',  RageUI.CreateSubMenu(RMenu:Get("CryptoMiner", "main")))
RMenu.Add('CryptoMiner', 'manage_systems_sub',  RageUI.CreateSubMenu(RMenu:Get("CryptoMiner", "manage_systems")))


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('CryptoMiner', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Buy Systems", "", {}, true, function(Hovered, Active, Selected) 
                if Selected then end
            end, RMenu:Get("CryptoMiner", "buy_systems"))

            RageUI.Button("Manage Systems", "", {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    TriggerServerEvent("ERPCrypto:BTC:ReceiveMiners")
                end
            end, RMenu:Get("CryptoMiner", "manage_systems"))
        end)
    end
    if RageUI.Visible(RMenu:Get('CryptoMiner', 'buy_systems')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i=1, #cfg.systems do
                RageUI.Button(cfg.systems[i].name, "", {}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        selected_system = cfg.systems[i]
                    end
                end, RMenu:Get("CryptoMiner", "buy_systems_manage"))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('CryptoMiner', 'buy_systems_manage')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Separator("GPU: "..selected_system.gpu, function() end)
            RageUI.Separator("CPU: "..selected_system.cpu, function() end)
            RageUI.Separator("Amount Per Minute(BTC) "..selected_system.stringedFormat, function() end)
            RageUI.Button("Buy", '£'..GetMoneyString2(selected_system.price), {}, true, function(Hovered, Active, Selected)
                if Selected then 
                    TriggerServerEvent('ERPCrypto:buy_crypto_system', selected_system)
                end
            end, RMenu:Get("CryptoMiner", "main"))
        end)
    end
    if RageUI.Visible(RMenu:Get('CryptoMiner', 'manage_systems')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i=1, #machines_owned do
                RageUI.Button('Machine Id: '..machines_owned[i].machineid, cfg.systems[machines_owned[i].pc_id].name, {}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        selected_managed_system = machines_owned[i]
                    end
                end, RMenu:Get("CryptoMiner", "manage_systems_sub"))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('CryptoMiner', 'manage_systems_sub')) then
        RageUI.DrawContent({ header = false, glare = false, instructionalButton = false}, function()
            RageUI.Separator("CPU: "..cfg.systems[selected_managed_system.pc_id].cpu, function() end)
            RageUI.Separator("GPU: "..cfg.systems[selected_managed_system.pc_id].gpu, function() end)
            RageUI.Separator("Amount Per Minute "..cfg.systems[selected_managed_system.pc_id].stringedFormat, function() end)
            local amount_mined_string = noScience(tostring(selected_managed_system.amountmined))
            RageUI.Separator("Current Balance(BTC): "..amount_mined_string, function() end)
            RageUI.Button("Withdraw BTC", '£'..roundToWholeNumber((selected_managed_system.amountmined) * cryptoprice), {}, true, function(Hovered, Active, Selected)
                if Selected then 
                    TriggerServerEvent('ERPCrypto:Withdraw:Crypto', selected_managed_system)
                end
            end, RMenu:Get("CryptoMiner", "main"))
            RageUI.Button("Sell Machine","Amount Refunded: £".. roundToWholeNumber(cfg.systems[selected_managed_system.pc_id].price / 4), {}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('ERPCrypto:Sell:System', selected_managed_system)
                end
            end, RMenu:Get("CryptoMiner", "main"))
            RageUI.Separator("~r~[WARNING]", function() end)
            RageUI.Separator("~r~If You Sell Your Machine", function() end)
            RageUI.Separator("~r~All Bitcoin Will Be Lost", function() end)
            RageUI.Separator("~r~Selling Machine = 25% Of Buy Price", function() end)


        end)
    end
end)

function roundToWholeNumber(num)
    return math.floor(num + 0.5)
end



function noScience(num)
    return string.format("%f", num)
end


function GetMoneyString2(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end


RegisterNetEvent('ERPCryptocore:setCryptoPrice', function(price)
    cryptoprice = price
end)

RegisterNetEvent('ERPCrypto:BTC:SetMiners', function(miners)
    machines_owned = miners
end)










Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        TriggerServerEvent('ERPCryptocore:getCryptoPrice')
    end
end)

Citizen.CreateThread(function()
    local v3 = vector3(1087.5161132812,-3101.2182617188,-38.205493927002)
    while true do
        if isInArea(v3, 50.0) then 
            Draw3DText(1087.5161132812,-3101.2182617188,-38.205493927002, 0.5, '~o~BTC: ~w~'..cryptoprice)
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() 
    isCryptoMenu = false
    while true do
        local x,y,z = table.unpack(cfg.coords)
        local cfgcoords = vector3(x,y,z)
        if isInArea(cfgcoords, 100.0) then 
            DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 255,255,255, 150, 0, 0, 0, 0, 0, 0, 0)
        end
        if isCryptoMenu == false then
            if isInArea(cfgcoords, 1.4) then 
                alert('Press ~INPUT_CONTEXT~ to buy or manage your systems.')
                if IsControlJustPressed(0, 51) then 
                    RageUI.Visible(RMenu:Get("CryptoMiner", "main"), true)
                    isCryptoMenu = true
                end
            end
        end
        if isInArea(cfgcoords, 1.4) == false and isCryptoMenu then
            RageUI.ActuallyCloseAll()
            RageUI.Visible(RMenu:Get("CryptoMiner", "main"), false)
            isCryptoMenu = false
        end
        Citizen.Wait(0)
    end
end)

function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end