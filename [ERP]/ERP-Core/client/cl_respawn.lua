RMenu.Add('RespawnMenu', 'main', RageUI.CreateMenu("", "~w~ERP Respawn Menu", 1300, 100, "respawn", "respawn"))

Bronzelicense = false
Silverlicense = false
Goldlicense = false
Diamondlicense = false
RageUI.CreateWhile(1.0, RMenu:Get('RespawnMenu', 'main'), nil, function()

    RageUI.IsVisible(RMenu:Get('RespawnMenu', 'main'), true, false, true, function()
        if spawn.freeze == true then
            FreezeEntityPosition(PlayerPedId(), true)
        end 

        for i , p in pairs(spawn.options) do 
            RageUI.Button(p.name , nil, "", true, function(Hovered, Active, Selected)

                if Selected then

                    SetEntityCoords(PlayerPedId(), p.location)

                    if spawn.chatmessage == true then 
                       
                    end

                end
            end)
        end



        -- RageUI.Button("~r~[Attraction Zone Spawn]", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
     -- 
        --     if Selected then
        --         SetEntityCoords(PlayerPedId(), 2754.7666015625,3470.4040527344,55.745849609375)
        --     end
        -- end)


        
    end, function()

    end)
end)

inSpawnMenu = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
        local v1 = spawn.coords 
        if inSpawnMenu == false then
            if isInArea(v1, 1.4) then

                currentAmmunition = k
                RageUI.Visible(RMenu:Get("RespawnMenu", "main"), true)
                inSpawnMenu = true
                currentAmmunition = k 
            end
        end
        if spawn.marker == true then
            if isInArea(v1, 100.0) then 
                DrawMarker(2, v1+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 155, true, true, 0, 0, 0, 0, 0) 
            end
        end
        if isInArea(v1, 1.4) == false and inSpawnMenu and k == currentAmmunition then
            RageUI.Visible(RMenu:Get("RespawnMenu", "main"), false)
            inSpawnMenu = false
            currentAmmunition = nil
            if spawn.freeze == true then
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
        Citizen.Wait(0)
    end
end)

if spawn.close == false then
    Citizen.CreateThread(function()
    	while true do
    		Citizen.Wait(0)
    		if inSpawnMenu then
                RageUI.Visible(RMenu:Get("RespawnMenu", "main"), true)
    		else
    			FreezeEntityPosition(PlayerPedId(), false)
    			Citizen.Wait(500)
    		end
    	end
    end)
end

RegisterNetEvent('ERP:BronzeChecked')
AddEventHandler('ERP:BronzeChecked', function(allowed)
    if allowed then
        Bronzelicense = true
    elseif not allowed then
        Bronzelicense = false
    end
end)

RegisterNetEvent('ERP:ERPChecked')
AddEventHandler('ERP:ERPChecked', function(allowed)
    if allowed then
        ERPlicense = true
    elseif not allowed then
        ERPlicense = false
    end
end)


RegisterNetEvent('ERP:SilverChecked')
AddEventHandler('ERP:SilverChecked', function(allowed)
    if allowed then
        Silverlicense = true
    elseif not allowed then
        Silverlicense = false
    end
end)

RegisterNetEvent('ERPGoldChecked')
AddEventHandler('ERP:GoldChecked', function(allowed)
    if allowed then
        Goldlicense = true
    elseif not allowed then
        Goldlicense = false
    end
end)

RegisterNetEvent('ERP:DiamondChecked')
AddEventHandler('ERP:DiamondChecked', function(allowed)
    if allowed then
        Diamondlicense = true
    elseif not allowed then
        Diamondlicense = false
    end
end)

function isInArea(v, dis) 
    
    if #(GetEntityCoords(PlayerPedId()) - v) <= dis then  
        return true
    else 
        return false
    end
end






