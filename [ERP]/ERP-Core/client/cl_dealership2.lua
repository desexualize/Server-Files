dealership = {}

dealership.simeons = {
    {spawncode = "r820", vehname = "Audi R8", vehdesc = "", price = 1},
    {spawncode = "m977hl", vehname = "M977", vehdesc = "", price = 500000},
    {spawncode = "a45", vehname = "Mercedes-Benz A45", vehdesc = "Compact", price = 30000},
    {spawncode = "ast", vehname = "Aston Martan", vehdesc = "Sport", price = 100000},
    {spawncode = "R6", vehname = "R6", vehdesc = "Motorcycles", price = 20000},
    {spawncode = "x6m", vehname = "BMW X6M", vehdesc = "SUV", price = 40000},
    {spawncode = "pm19", vehname = "Porsche Macan", vehdesc = "SUV", price = 25000},
    {spawncode = "F4090", vehname = "Ferrari F40", vehdesc = "Super", price = 120000},
    {spawncode = "rs6", vehname = "Audi RS6", vehdesc = "Sport", price = 75000},
    {spawncode = "rs5", vehname = "Audi RS5", vehdesc = "Sport", price = 90000},
    {spawncode = "pturismo", vehname = "Porsche Panamera", vehdesc = "Sport", price = 100000},
    {spawncode = "m3e46", vehname = "BMW M3", vehdesc = "", price = 60000},
    {spawncode = "bmwe65", vehname = "BMW E65", vehdesc = "", price = 40000},
    {spawncode = "boxster", vehname = "Porsche Boxster", vehdesc = "", price = 130000},
}

dealership.police = {
    {spawncode = "apex3", vehname = "VW APEX 3", vehdesc = "", price = 1},
    {spawncode = "audia4marked", vehname = "Audi A4 Marked", vehdesc = "", price = 1},
    {spawncode = "audia4unmarked", vehname = "Audi A4 Unmarked", vehdesc = "", price = 1},
    {spawncode = "polf150", vehname = "Offroad F150", vehdesc = "", price = 1},
    {spawncode = "pddirtbike", vehname = "PD Dirtbike", vehdesc = "", price = 1},
    {spawncode = "pbmw540i", vehname = "BMW 540i", vehdesc = "", price = 1},
    {spawncode = "pdbmwm5", vehname = "BMW M5", vehdesc = "", price = 1},
    {spawncode = "pdjagsuv", vehname = "Jaguar SUV", vehdesc = "", price = 1},
    {spawncode = "pdjagxfr", vehname = "Jaguar XFR", vehdesc = "", price = 1},
    {spawncode = "pdmarkedfocus", vehname = "Ford Focus", vehdesc = "", price = 1},
    {spawncode = "pdnissangtr", vehname = "Nissan GTR Unmarked", vehdesc = "", price = 1},
    {spawncode = "pdprior", vehname = "Audi Prior Unmarked", vehdesc = "", price = 1},
    {spawncode = "wf20", vehname = "Armed Van", vehdesc = "", price = 1},
}

dealership.vip = {
    {spawncode = "bmwe65", vehname = "BMW E65", vehdesc = "", price = 40000},
}

RMenu.Add('DealershipMenu', 'main', RageUI.CreateMenu("", "Dealership Menu", 1300, 100, "dealership",  "dealership"))
RMenu.Add('DealershipMenu', 'sim', RageUI.CreateMenu("", "Dealership Menu", 1300, 100, "dealership",  "dealership"))
RMenu.Add('DealershipMenu', 'police', RageUI.CreateMenu("", "Dealership Menu", 1300, 100, "dealership",  "dealership"))
RMenu.Add('DealershipMenu', 'vip', RageUI.CreateMenu("", "Dealership Menu", 1300, 100, "dealership",  "dealership"))
RMenu.Add("DealershipMenu", "simconfirm", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 100)))
RMenu.Add("DealershipMenu", "vipconfirm", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 100)))
RMenu.Add("DealershipMenu", "policeonfirm", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 100)))
RMenu.Add("DealershipMenu", "simconfirmA", RageUI.CreateSubMenu(RMenu:Get('DealershipMenu', 'main',  1300, 100)))

local hasPoliceRole = false
local hasVIPRole = false

RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'main'), true, false, true, function()
      
            RageUI.Button('Standard Vehicles', nil, { RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
 
        
                end
        
            end, RMenu:Get("DealershipMenu", "sim"))
            if hasVIPRole then
                RageUI.Button('VIP Vehicles', nil, { RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                    
                    
                    end
                
                end, RMenu:Get("DealershipMenu", "vip"))
            end
            if hasPoliceRole then
                RageUI.Button('Police Vehicles', nil, { RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                    
                    
                    end
                
                end, RMenu:Get("DealershipMenu", "police"))
            end
  

    end, function()
       
    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'sim'), nil, function()

    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'sim'), true, false, true, function()
        for i , p in pairs(dealership.simeons) do 
            RageUI.Button(p.vehname, nil, { RightLabel = "£" .. getMoneyStringFormatted(p.price) .. ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    
                    cPrice = p.price
                    cHash = p.spawncode
        
                end
                if Active then 
                    TriggerEvent('returnHover', p.spawncode)
                end
            end, RMenu:Get("DealershipMenu", "simconfirm"))
        end

    end, function()
       
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'vip'), nil, function()
    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'vip'), true, false, true, function()
        for i , p in pairs(dealership.vip) do 
            RageUI.Button(p.vehname, nil, { RightLabel = "£" .. getMoneyStringFormatted(p.price) .. ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    
                    cPrice = p.price
                    cHash = p.spawncode
        
                end
                if Active then 
                    TriggerEvent('returnHover', p.spawncode)
                end
            end, RMenu:Get("DealershipMenu", "vipconfirm"))
        end

    end, function()
       
    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('DealershipMenu', 'police'), nil, function()

    RageUI.IsVisible(RMenu:Get('DealershipMenu', 'police'), true, false, true, function()
        for i , p in pairs(dealership.police) do 
            RageUI.Button(p.vehname, nil, { RightLabel = "£" .. getMoneyStringFormatted(p.price) .. ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    
                    cPrice = p.price
                    cHash = p.spawncode
        
                end
                if Active then 
                    TriggerEvent('returnHover', p.spawncode)
                end
            end, RMenu:Get("DealershipMenu", "polconfirm"))
        end

    end, function()
       
    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get("DealershipMenu", "simconfirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("DealershipMenu", "simconfirm"), true, false, true, function()  
        RMenu:Get("DealershipMenu", "simconfirm"):SetSubtitle("Are you sure?")
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
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
                    DoScreenFadeIn(1000)
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
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    SetEntityCoords(PlayerPedId(), -33.133804321289,-1102.1640625,26.422357559204)
                    DoScreenFadeIn(1000)
                end
            end
        end, RMenu:Get("DealershipMenu", "main"))
        RageUI.Button("Purchase Vehicle" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                -- [Event Here]
                TriggerServerEvent('ERP:DealerShipBuy',cHash, cPrice)
            end
        end, RMenu:Get("DealershipMenu", "main"))
       

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("DealershipMenu", "vipconfirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("DealershipMenu", "vipconfirm"), true, false, true, function()  
        RMenu:Get("DealershipMenu", "vipconfirm"):SetSubtitle("Are you sure?")
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
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
                    DoScreenFadeIn(1000)
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
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    SetEntityCoords(PlayerPedId(), -33.133804321289,-1102.1640625,26.422357559204)
                    DoScreenFadeIn(1000)
                end
            end
        end, RMenu:Get("DealershipMenu", "main"))
        RageUI.Button("Purchase Vehicle" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                -- [Event Here]
                TriggerServerEvent('ERP:VIPDealerShipBuy',cHash, cPrice)
            end
        end, RMenu:Get("DealershipMenu", "main"))
       

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("DealershipMenu", "policeonfirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("DealershipMenu", "policeonfirm"), true, false, true, function()  
        RMenu:Get("DealershipMenu", "policeonfirm"):SetSubtitle("Are you sure?")
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
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
                    DoScreenFadeIn(1000)
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
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    SetEntityCoords(PlayerPedId(), -33.133804321289,-1102.1640625,26.422357559204)
                    DoScreenFadeIn(1000)
                end
            end
        end, RMenu:Get("DealershipMenu", "main"))
        RageUI.Button("Purchase Vehicle" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                -- [Event Here]
                TriggerServerEvent('ERP:PoliceDealerShipBuy',cHash, cPrice)
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

RegisterNetEvent('returnvip2')
AddEventHandler('returnvip2', function(bool)
    if bool then 
        hasVIPRole = true 
    else
        hasVIPRole = false
    end
end)

isInDealership = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do

            local v1 = vector3(-37.878005981445,-1100.1635742188,26.42236328125)

            if isInArea(v1, 100.0) then 
                DrawMarker(36, -37.878005981445,-1100.1635742188,26.42236328125 +1 - 0.98, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.2, 255, 255, 255, 155, false, true, 0, 0, 0, 0, 0)
            end
            if isInDealership == false then
            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Dealership')
                
                if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent('sendPD')
                    TriggerServerEvent('sendVIP')
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
    blip = AddBlipForCoord(-37.878005981445,-1100.1635742188,26.42236328125)
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
              DrawAdvancedTextOutline(0.605, 0.8, 0.005, 0.0028, 0.4, "Test Drive left: "..testdrivetimer.." seconds", 255, 255, 255, 255, 7, 0)
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

