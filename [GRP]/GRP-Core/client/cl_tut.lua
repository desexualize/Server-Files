RMenu.Add('TutorialMenu', 'main', RageUI.CreateMenu("", "~w~Where would you like to spawn?", 700, 150, "respawn", "respawn"))

RageUI.CreateWhile(1.0, RMenu:Get('TutorialMenu', 'main'), nil, function()

    RageUI.IsVisible(RMenu:Get('TutorialMenu', 'main'), true, false, true, function()
      
            FreezeEntityPosition(PlayerPedId(), true)
       

       
            RageUI.Button('Sandy Shores License Centre' , nil, "", true, function(Hovered, Active, Selected)

                if Selected then

                    SetEntityCoords(PlayerPedId(), 1706.8607177734,3776.0646972656,34.549934387207)

    

                end
            end)

            RageUI.Button('City License Centre' , nil, "", true, function(Hovered, Active, Selected)

                if Selected then

                    SetEntityCoords(PlayerPedId(), -542.07586669922,-209.76263427734,37.649757385254)

    

                end
            end)
      



        -- RageUI.Button("~r~[Attraction Zone Spawn]", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
     -- 
        --     if Selected then
        --         SetEntityCoords(PlayerPedId(), 2754.7666015625,3470.4040527344,55.745849609375)
        --     end
        -- end)


        
    end, function()

    end)
end)

inSpawnMenu2 = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
        local v1 = vector3(3094.8723144531,-4703.50390625,24.261253356934)
        if inSpawnMenu2 == false then
            if isInArea(v1, 1.4) then

                currentAmmunition = k
                RageUI.Visible(RMenu:Get("TutorialMenu", "main"), true)
                inSpawnMenu2 = true
                currentAmmunition = k 
            end
        end
   
            if isInArea(v1, 100.0) then 
                DrawMarker(2, v1+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 155, true, true, 0, 0, 0, 0, 0) 
            end
     
        if isInArea(v1, 1.4) == false and inSpawnMenu2 and k == currentAmmunition then
            RageUI.Visible(RMenu:Get("TutorialMenu", "main"), false)
            inSpawnMenu2 = false
            currentAmmunition = nil
           
                FreezeEntityPosition(PlayerPedId(), false)
           
        end
        Citizen.Wait(0)
    end
end)

if spawn.close == false then
    Citizen.CreateThread(function()
    	while true do
    		Citizen.Wait(0)
    		if inSpawnMenu2 then
                RageUI.Visible(RMenu:Get("TutorialMenu", "main"), true)
    		else
    			FreezeEntityPosition(PlayerPedId(), false)
    			Citizen.Wait(500)
    		end
    	end
    end)
end

RegisterNetEvent('Galaxy:BronzeChecked')
AddEventHandler('Galaxy:BronzeChecked', function(allowed)
    if allowed then
        Bronzelicense = true
    elseif not allowed then
        Bronzelicense = false
    end
end)

RegisterNetEvent('Galaxy:GalaxyRPChecked')
AddEventHandler('Galaxy:GalaxyRPChecked', function(allowed)
    if allowed then
        GalaxyRPlicense = true
    elseif not allowed then
        GalaxyRPlicense = false
    end
end)


RegisterNetEvent('Galaxy:SilverChecked')
AddEventHandler('Galaxy:SilverChecked', function(allowed)
    if allowed then
        Silverlicense = true
    elseif not allowed then
        Silverlicense = false
    end
end)

RegisterNetEvent('GalaxyRPGoldChecked')
AddEventHandler('Galaxy:GoldChecked', function(allowed)
    if allowed then
        Goldlicense = true
    elseif not allowed then
        Goldlicense = false
    end
end)

RegisterNetEvent('Galaxy:DiamondChecked')
AddEventHandler('Galaxy:DiamondChecked', function(allowed)
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






