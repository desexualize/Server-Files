local cfg = module("cfg/garages")
local vehcategories = cfg.garage_types
local garage_type = "car";
local selected_category = nil;
local Hovered_Vehicles = nil;
local VehiclesFetchedTable = {};
local Table_Type = nil;
local RentedVeh = false;
local SelectedCar = {spawncode = nil, name = nil}
local veh = nil 
local cantload = {}
local vehname = nil 
--Created by JamesUK#6793 :)
RMenu.Add('vRPGarages', 'main', RageUI.CreateMenu("", "~w~Galaxy Garage Menu",1300, 50, "garages", "garages"))
RMenu.Add('vRPGarages', 'owned_vehicles',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "main")))
RMenu.Add('vRPGarages', 'rented_vehicles',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "main")))
RMenu.Add('vRPGarages', 'rented_vehicles_manage',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "rented_vehicles")))
RMenu.Add('vRPGarages', 'buy_vehicles',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "main")))
RMenu.Add('vRPGarages', 'buy_vehicles_submenu',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "buy_vehicles")))
RMenu.Add('vRPGarages', 'buy_vehicles_submenu_manage',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "buy_vehicles_submenu")))
RMenu.Add('vRPGarages', 'owned_vehicles_submenu',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "owned_vehicles")))
RMenu.Add('vRPGarages', 'owned_vehicles_submenu_manage',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "owned_vehicles_submenu")))
RMenu.Add('vRPGarages', 'scrap_vehicle_confirmation',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "owned_vehicles_submenu_manage")))
RMenu.Add('vRPGarages', 'rented_vehicles_out_manage',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "rented_vehicles")))
RMenu.Add('vRPGarages', 'rented_vehicles_out_manage_submenu',  RageUI.CreateSubMenu(RMenu:Get("vRPGarages", "rented_vehicles_out_manage")))
RMenu:Get('vRPGarages', 'owned_vehicles'):SetSubtitle("~w~Vehicle Categories")
RMenu:Get('vRPGarages', 'scrap_vehicle_confirmation'):SetSubtitle("~w~Are you sure you want to scrap this vehicle?")
--Created by JamesUK#6793 :)

function DeleteCar(veh)
    if veh then 
        if DoesEntityExist(veh) then 
            Hovered_Vehicles = nil
            vehname = nil
            DeleteEntity(veh)
            veh = nil
        end
    end
end

-- Did you know you can toggle most things in vRP within the vrp/sharedcfg/options.lua?
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('vRPGarages', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            if IsPedInAnyVehicle(PlayerPedId(), false) then 

            else
                if vRPConfig.EnableBuyVehicles then
                    RageUI.Button("Buy Vehicles", nil, {}, true, function(Hovered, Active, Selected) 
                        if Selected then 
                            if Table_Type == nil or Table_Type then 
                                TriggerServerEvent('vRP:FetchCars', false, garage_type)
                                Table_Type = false;
                            end
                        end
                    end, RMenu:Get("vRPGarages", "buy_vehicles"))
                end

                RageUI.Button("Owned Vehicles", nil, {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        if Table_Type == nil or not Table_Type then 
                            Table_Type = true;
                            TriggerServerEvent('vRP:FetchCars', true, garage_type)
                        end
                    end
                end, RMenu:Get("vRPGarages", "owned_vehicles"))
            

                RageUI.Button("Rented Vehicles", nil, {}, true, function(Hovered, Active, Selected) end, RMenu:Get("vRPGarages", "rented_vehicles"))
            end
            RageUI.Button("Store Vehicle", nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    TriggerEvent( "wk:deleteVehicle" )
                end
            end)
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'buy_vehicles')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("vRPGarages", "buy_vehicles_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'buy_vehicles_submenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                RageUI.Button(v[1], nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        SelectedCar.spawncode = i 
                        SelectedCar.name = v[1]
                        RMenu:Get('vRPGarages', 'buy_vehicles_submenu_manage'):SetSubtitle("~w~" .. v[1] .. ' Price: $' .. v[2])
                    end
                    if Active then 
                        Hovered_Vehicles = i
                    end
                end,RMenu:Get("vRPGarages", "buy_vehicles_submenu_manage")) 
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'buy_vehicles_submenu_manage')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Buy Vehicle", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then 
                    TriggerServerEvent('vRP:BuyVehicle', SelectedCar.spawncode)
                    RageUI.ActuallyCloseAll()
                    RageUI.Visible(RMenu:Get('vRPGarages', 'main'), true)  
                end
            end) 
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'owned_vehicles')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RentedVeh = false;
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("vRPGarages", "owned_vehicles_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'owned_vehicles_submenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                if RentedVeh then 
                    RageUI.Button(v[1], v[2] .. " until the vehicle is returned.", {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SelectedCar.spawncode = i 
                            SelectedCar.name = v[1]
                            RMenu:Get('vRPGarages', 'owned_vehicles_submenu_manage'):SetSubtitle("~w~" .. v[1])
                        end
                        if Active then 
                            Hovered_Vehicles = i
                        end
                    end,RMenu:Get("vRPGarages", "owned_vehicles_submenu_manage"))
                else 
                    RageUI.Button(v[1], nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SelectedCar.spawncode = i 
                            SelectedCar.name = v[1]
                            RMenu:Get('vRPGarages', 'owned_vehicles_submenu_manage'):SetSubtitle("~w~" .. v[1])
                        end
                        if Active then 
                            Hovered_Vehicles = i
                        end
                    end,RMenu:Get("vRPGarages", "owned_vehicles_submenu_manage")) 
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'owned_vehicles_submenu_manage')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button('Spawn Vehicle', nil, {}, true, function(Hovered, Active, Selected)
                if Selected then 
                    tvRP.spawnGarageVehicle(garage_type, SelectedCar.spawncode, GetEntityCoords(PlayerPedId()))
                    DeleteCar(veh)
                    RageUI.ActuallyCloseAll()
                end
                if Active then 
                
                end
            end)
            if not RentedVeh then 
                RageUI.Button('Rent out Vehicle', nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('vRP:RentVehicle', SelectedCar.spawncode) 
                    end
                    if Active then 
                    
                    end
                end)
                RageUI.Button('Scrap Vehicle', nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        AddTextEntry('FMMC_MPM_NC', "Type 'Yes' to delete vehicle!")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                            Wait(0);
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if string.upper(result) == "YES" then 
                                TriggerServerEvent('vRP:ScrapVehicle', SelectedCar.spawncode) 
                                notify("~g~You vehicle has been deleted!")
                            else
                                notify("~r~You did not type 'Yes', so process was cancelled!")
                            end
                        end
                    end
                end)
                RageUI.Button('Sell Vehicle', nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        TriggerServerEvent('vRP:SellVehicle', SelectedCar.spawncode)
                    end
                    if Active then 
                    
                    end
                end)
            end
        end)
    end

    if RageUI.Visible(RMenu:Get('vRPGarages', 'rented_vehicles')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RageUI.Button('Rented Vehicles Out', nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    Table_Type = nil;
                    TriggerServerEvent('vRP:FetchVehiclesOut')
                end
            end,RMenu:Get("vRPGarages", "rented_vehicles_out_manage"))
            RageUI.Button('Rented Vehicles In', nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    Table_Type = nil;
                    RentedVeh = true;
                    TriggerServerEvent('vRP:FetchVehiclesIn')
                end
            end,RMenu:Get("vRPGarages", "rented_vehicles_manage"))
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'rented_vehicles_out_manage')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            Hovered_Vehicles = nil 
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            RentedVeh = true; 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("vRPGarages", "rented_vehicles_out_manage_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'rented_vehicles_out_manage_submenu')) then 
        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                RageUI.Button(v[1] .. ' Rented to: ' .. v[3], v[2] .. " until the vehicle is returned to you.", {}, true, function(Hovered, Active, Selected)
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPGarages', 'rented_vehicles_manage')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            Hovered_Vehicles = nil 
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do 
                if garage_type == VehiclesFetchedTable[i].config.vtype then 
                    RageUI.Button(i, nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            RentedVeh = true; 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("vRPGarages", "owned_vehicles_submenu"))
                end
            end
        end)
    end
end)


RegisterNetEvent("returnHover")
AddEventHandler("returnHover", function(veh)
    Hovered_Vehicles = veh
end)

RegisterNetEvent("returnCan")
AddEventHandler("returnCan", function(veh)
    isHovering = false
end)

local isHovering = true
if vRPConfig.LoadPreviews then 
    Citizen.CreateThread(function()
        while true do 
            Wait(0)
            if Hovered_Vehicles then 
                if vehname and vehname ~= Hovered_Vehicles then 
                    DeleteEntity(veh)
                    vehname = Hovered_Vehicles
                end
                local hash = GetHashKey(Hovered_Vehicles)
                if not DoesEntityExist(veh) and not IsPedInAnyVehicle(PlayerPedId(), false) and not cantload[Hovered_Vehicles] and Hovered_Vehicles then
                    local i = 0
                    while not HasModelLoaded(hash) do
                        RequestModel(hash)
                        i = i + 1
                        Citizen.Wait(10)
                        if i > 30 then
             
                            if vehname then 
                                cantload[vehname] = true
                            end
                            break 
                        end
                    end
                    local coords = GetEntityCoords(PlayerPedId())
                    local ped = PlayerPedId()
                    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y-7, coords.z + 1.5, 350.00,0.00,0.00, 50.00, false, 0)
                    vehname = Hovered_Vehicles
                    veh = CreateVehicle(hash,coords.x, coords.y, coords.z + 1, 0.0,false,false)
                    FreezeEntityPosition(veh,true)
                    SetEntityInvincible(veh,true)
                    SetVehicleDoorsLocked(veh,4)
                    SetModelAsNoLongerNeeded(hash)
                    for i = 0,24 do
                        SetVehicleModKit(veh,0)
                        RemoveVehicleMod(veh,i)
                    end
                    SetEntityCollision(veh, false, false)
                    Citizen.CreateThread(function()
                        while DoesEntityExist(veh) do
                            Citizen.Wait(25)
                            SetEntityHeading(veh, GetEntityHeading(veh)+1.0 %360)
                            FreezeEntityPosition(ped,true)
                            SetCamActive(cam, true)
                            RenderScriptCams(true, false, 1, true, true)
                            SetEntityVisible(ped, false, false)
                        end
                        FreezeEntityPosition(ped,false)
                        RenderScriptCams(false, true, 500, true, true)
                        SetEntityVisible(ped, true, false)
                        SetCamActive(cam, false)
                        DestroyCam(cam, true)
                        SetEntityVisible(ped, true, false)
                    end)
                end
            end
        end
    end)
end








RegisterNetEvent('vRP:ReturnFetchedCars')
AddEventHandler('vRP:ReturnFetchedCars', function(table)
    VehiclesFetchedTable = table;
end)

RegisterNetEvent('vRP:CloseGarage')
AddEventHandler('vRP:CloseGarage', function()
    DeleteCar(veh)
    Table_Type = nil;
    RageUI.ActuallyCloseAll()
end)

local type = nil
Citizen.CreateThread(function()
    while true do 
        Wait(0)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        for i,v in pairs(cfg.garages) do 
            local x,y,z = v[2], v[3], v[4]
            if #(PlayerCoords - vec3(x,y,z)) <= 150 then 
                type = v[1]
                if type == "Car" then 
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 150, false, true, 2, true, nil, nil, false)
                elseif type == "Boat" then 
                    DrawMarker(35, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 150, false, true, 2, true, nil, nil, false)
                elseif type == "Heli" then 
                    DrawMarker(34, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 150, false, true, 2, true, nil, nil, false)
                elseif type == "VIP" then 
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 208, 0, 150, false, true, 2, true, nil, nil, false)
                end
            end
        end
    end
end)

local MenuOpen = false; 
local inMarker = false;
Citizen.CreateThread(function()
    while true do 
        Wait(5)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        inMarker = false;
        for i,v in pairs(cfg.garages) do 
            local x,y,z = v[2], v[3], v[4]
            if #(PlayerCoords - vec3(x,y,z)) <= 3.0 then 
                inMarker = true 
                garage_type = v[1]
                break
            end
        end
        if not MenuOpen and inMarker then
            

                if garage_type == "VIP" then 
           
          
                        MenuOpen = true
                        TriggerServerEvent("returnVIP")
                        PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)
                   
                else
    
                   
                        MenuOpen = true
                        RageUI.Visible(RMenu:Get('vRPGarages', 'main'), true)  
                        PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)
                end
    
        end
        if not inMarker and MenuOpen then
            DeleteCar(veh)
            Table_Type = nil;
            RageUI.ActuallyCloseAll()
            MenuOpen = false
        end
    end
end)

RegisterNetEvent("openVIP")
AddEventHandler("openVIP", function()
    RageUI.Visible(RMenu:Get('vRPGarages', 'main'), true)  
    
end)



for i,v in pairs(cfg.garages) do 
    local x,y,z = v[2], v[3], v[4]
    local Blip = AddBlipForCoord(x, y, z)
    if v[1] == "Car" then 
        SetBlipSprite(Blip, 50)
        SetBlipColour(Blip, 2)
        SetBlipScale(Blip, 0.4)
    elseif v[1] == "Boat" then 
        SetBlipSprite(Blip, 427)
        SetBlipColour(Blip, 2)
        SetBlipScale(Blip, 0.5)
    elseif v[1] == "Heli" then 
        SetBlipSprite(Blip, 43)
        SetBlipColour(Blip, 2)
        SetBlipScale(Blip, 0.5)
    elseif v[1] == "VIP" then 
        SetBlipSprite(Blip, 225)
        SetBlipColour(Blip, 5)
        SetBlipScale(Blip, 0.65)
    end
    SetBlipDisplay(Blip, 4)
    
  
    SetBlipAsShortRange(Blip, true)
 
    AddTextEntry("MAPBLIP", v[1] .. ' Garage')
    BeginTextCommandSetBlipName("MAPBLIP")
    EndTextCommandSetBlipName(Blip)
    SetBlipCategory(Blip, 1)
end

