

dealership = {}

dealership.guns = {
  {spawncode = "royalmail", vehname = "300KG", vehdesc = "", price = 0, ""},
  {spawncode = "m3f80", vehname = "Custom BMW M3 F80", vehdesc = "", price = 0, ""},
  {spawncode = "cookiers6a", vehname = "Free RS6", vehdesc = "", price = 0, ""},
  {spawncode = "snowhawk", vehname = "Custom 125KG On Tracks", vehdesc = "", price = 0, ""},

}

dealership.guns2 = {
    {spawncode = "apex3", vehname = "VW APEX 3", vehdesc = "", price = 1},
    {spawncode = "audia4marked", vehname = "Audi A4 Marked", vehdesc = "", price = 1},
    {spawncode = "audia4unmarked", vehname = "Audi A4 Unmarked", vehdesc = "", price = 1},
    {spawncode = "polx5", vehname = "BMW X5 Marked", vehdesc = "", price = 1},
    {spawncode = "poltouring", vehname = "BMW Estate Marked", vehdesc = "", price = 1},
    {spawncode = "polm5", vehname = "BMW M5 Marked", vehdesc = "", price = 1},
    {spawncode = "polm2", vehname = "BMW M2 Marked", vehdesc = "", price = 1},
    {spawncode = "policekia", vehname = "Kia Marked", vehdesc = "", price = 1},
    {spawncode = "jagrsmarked", vehname = "Jaguar RS Marked", vehdesc = "", price = 1},
    {spawncode = "polsportland", vehname = "Range Rover Sport Marked", vehdesc = "", price = 1},
    {spawncode = "jagrsunmarked", vehname = "Jaguar RS Unmarked", vehdesc = "", price = 1},
    {spawncode = "polrange2", vehname = "Range Rover Sport Unmarked", vehdesc = "", price = 1},

}

dealership.guns3 = {
  {spawncode = "che1950ez", vehname = "Chevrolet 300KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "gazel", vehname = "Ford Transit 300KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "hilux1", vehname = "Toyota Hilux 300KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "h2010", vehname = "Toyota Hilux2 300KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "silv86", vehname = "Toyota Silverado 200KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "silv20", vehname = "Toyota Silverado2 200KG", venhdesc = "", price = 5000000, ""},
  {spawncode = "bison3", vehname = "4X4 300KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "eurocargo", vehname = "Cargo Truck 300KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "f350offroadspec", vehname = "Ford F350 6X6 300KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "speedo2", vehname = "Clown Van 300KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "camper", vehname = "Camper Van 300KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "burrito", vehname = "Atomic Van 300KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "journey", vehname = "Camper 300KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "taco", vehname = "Taco Van 300KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "pony2", vehname = "Weed Van 300KG", vehdesc = "", price = 5000000, ""},
  {spawncode = "dailypp", vehname = "300KG Police Truck", vehdesc = "", price = 5000000, ""},

}

RMenu.Add('DealershipMenu', 'main', RageUI.CreateMenu("", "Dealership Menu", 1300, 50, "dealership",  "dealership"))
RMenu.Add('DealershipMenu', 'free', RageUI.CreateMenu("", "Dealership Menu", 1300, 50, "dealership",  "dealership"))
RMenu.Add('DealershipMenu', 'grinding', RageUI.CreateMenu("", "Dealership Menu", 1300, 50, "dealership",  "dealership"))
RMenu.Add('DealershipMenu', 'police', RageUI.CreateMenu("", "Dealership Menu", 1300, 50, "dealership",  "dealership"))
RMenu.Add("DealershipMenu", "confirm", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 50)))
RMenu.Add("DealershipMenu", "confirmA", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 50)))

local hasPoliceRole = false

RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'main'), nil, function()

    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'main'), true, false, true, function()
      
            RageUI.Button('Free Vehicles', nil, { RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
 
        
                end
        
            end, RMenu:Get("DealershipMenu", "free"))
            RageUI.Button('Grinding Vehicles', nil, { RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
 
        
                end
        
            end, RMenu:Get("DealershipMenu", "grinding"))       
                if hasPoliceRole then
                RageUI.Button('Police Vehicles', nil, { RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                    
                    
                    end
                
                end, RMenu:Get("DealershipMenu", "police"))
            end
  

    end, function()
       
    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'free'), nil, function()

    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'free'), true, false, true, function()
        for i , p in pairs(dealership.guns) do 
            RageUI.Button(p.vehname, nil, { RightLabel = "£" .. getMoneyStringFormatted(p.price) .. ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    
                    cPrice = p.price
                    cHash = p.spawncode
        
                end
                if Active then 
                    TriggerEvent('returnHover', p.spawncode)
                end
            end, RMenu:Get("DealershipMenu", "confirm"))
        end

    end, function()
       
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'grinding'), nil, function()

    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'grinding'), true, false, true, function()
        for i , p in pairs(dealership.guns3) do 
            RageUI.Button(p.vehname, nil, { RightLabel = "£" .. getMoneyStringFormatted(p.price) .. ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    
                    cPrice = p.price
                    cHash = p.spawncode
        
                end
                if Active then 
                    TriggerEvent('returnHover', p.spawncode)
                end
            end, RMenu:Get("DealershipMenu", "confirm"))
        end

    end, function()
       
    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'police'), nil, function()

    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'police'), true, false, true, function()
        for i , p in pairs(dealership.guns2) do 
            RageUI.Button(p.vehname, nil, { RightLabel = "£" .. getMoneyStringFormatted(p.price) .. ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    
                    cPrice = p.price
                    cHash = p.spawncode
        
                end
                if Active then 
                    TriggerEvent('returnHover', p.spawncode)
                end
            end, RMenu:Get("DealershipMenu", "confirm"))
        end

    end, function()
       
    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get("DealershipMenu", "confirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("DealershipMenu", "confirm"), true, false, true, function()  
        RMenu:Get("DealershipMenu", "confirm"):SetSubtitle("Are you sure?")
        RageUI.Button("Test Drive" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then   
                testdrivetimer = 30
                local mhash = GetHashKey(cHash)
                local i = 0
                while not HasModelLoaded(mhash) and i < 10000 do
                    RequestModel(mhash)
                    Citizen.Wait(10)
                    i = i+1
                    if i > 10000 then 
                        tvRP.notify('~r~Model could not be loaded!')
                        break 
                    end
                end
                -- spawn car
                if HasModelLoaded(mhash) then
                    local nveh = CreateVehicle(mhash, -1047.984375,-3308.4685058594,13.944429397583+0.5, 0.0, true, false)
                    SetVehicleOnGroundProperly(nveh)
  
                    SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside

                    local nid = NetworkGetNetworkIdFromEntity(nveh)
            
                    testdriveenabled = true
                end
                if testdriveenabled then
                    if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                        SetEntityCoords(PlayerPedId(), -32.98607635498,-1102.2288818359,26.42234992981)
                    end
                end
                Wait(30000)
                if testdriveenabled then
                    testdrivetimer = 0
                    testdriveenabled = false
                    DeleteCar3(nveh)
                    SetEntityCoords(PlayerPedId(), -54.503799438477,-1110.7507324219,26.435169219971)
                end
            end
        end, RMenu:Get("DealershipMenu", "main"))
        RageUI.Button("Purchase Vehicle" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                -- [Event Here]
                TriggerServerEvent('whoIs',cHash, cPrice)
            end
        end, RMenu:Get("DealershipMenu", "main"))
       

    end)
end)

RegisterNetEvent('returnPd2')
AddEventHandler('returnPd2', function(bool)
    if bool then 
        hasPoliceRole = true 
    else
        hasPoliceRole = false
    end
end)

isInDealership = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do

            local v1 = vector3(-50.406093597412,-1111.1015625,26.435157775879)

            if isInArea(v1, 100.0) then 
                DrawMarker(36, -50.406093597412,-1111.1015625,26.435157775879 +1 - 0.98, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.2, 255, 255, 255, 155, false, true, 0, 0, 0, 0, 0)
            end
            if isInDealership == false then
            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Dealership')
                
                if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent('sendPD')
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("DealershipMenu", "main"), true)
                    isInDealership = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInDealership and k == currentAmmunition then
                TriggerEvent('returnHover', "shalean")
                RageUI.CloseAll()
                isInDealership = false
                currentAmmunition = nil
            end
       
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do 
        if IsControlPressed(1, 177) then
            TriggerEvent('returnHover', "shalean")
        end
        Citizen.Wait(1)
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


Citizen.CreateThread(function()
    blip = AddBlipForCoord(-50.406093597412,-1111.1015625,26.435157775879)
    SetBlipSprite(blip, 225)
    SetBlipScale(blip, 0.6)
    SetBlipDisplay(blip, 2)
    SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Dealership")
    EndTextCommandSetBlipName(blip)
  end)


  testdrivetimer = 0
  testdriveenabled = false
  
  Citizen.CreateThread(function()
      while true do 
          Wait(0)
          if testdriveenabled then
              DrawAdvancedTextOutline(0.605, 0.513, 0.005, 0.0028, 0.4, "Test Drive left: "..testdrivetimer.." seconds", 255, 255, 255, 255, 7, 0)
          end
      end 
  end)

  Citizen.CreateThread(function()
    while true do 
        if testdriveenabled then
            testdrivetimer = testdrivetimer - 1
        end
        Wait(1000)
    end
end) 

  
function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

function DrawAdvancedTextOutline(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

function DeleteCar3(veh)
    if veh then 
        if DoesEntityExist(veh) then 
            Hovered_Vehicles = nil
            vehname = nil
            DeleteEntity(veh)
            veh = nil
        end
    end
end

