local cfg = module("cfg/garages");
local vehcategories = cfg.garage_types
local garage_type = "car";
local selected_category = nil;
local Hovered_Vehicles = nil;
local VehiclesFetchedTable = {};
local Table_Type = nil;
local RentedVeh = false;
local SelectedCar = {spawncode = nil, name = nil, plate = nil}
local veh = nil 
local cantload = {}
local vehname = nil
local Folders = {};
local SelectedFolderName = nil;

RMenu.Add('AQUAGarages', 'main', RageUI.CreateMenu("", "~d~ Garages",1300, 50, "banners", "garages"))
RMenu.Add('AQUAGarages', 'owned_vehicles',  RageUI.CreateSubMenu(RMenu:Get("AQUAGarages", "main")))
RMenu.Add('AQUAGarages', 'rented_vehicles',  RageUI.CreateSubMenu(RMenu:Get("AQUAGarages", "main")))
RMenu.Add('AQUAGarages', 'rented_vehicles_manage',  RageUI.CreateSubMenu(RMenu:Get("AQUAGarages", "rented_vehicles")))
RMenu.Add('AQUAGarages', 'owned_vehicles_submenu',  RageUI.CreateSubMenu(RMenu:Get("AQUAGarages", "owned_vehicles")))
RMenu.Add('AQUAGarages', 'owned_vehicles_submenu_manage',  RageUI.CreateSubMenu(RMenu:Get("AQUAGarages", "owned_vehicles_submenu")))
RMenu.Add('AQUAGarages', 'scrap_vehicle_confirmation',  RageUI.CreateSubMenu(RMenu:Get("AQUAGarages", "owned_vehicles_submenu_manage")))
RMenu.Add('AQUAGarages', 'rented_vehicles_out_manage',  RageUI.CreateSubMenu(RMenu:Get("AQUAGarages", "rented_vehicles")))
RMenu.Add('AQUAGarages', 'rented_vehicles_out_manage_submenu',  RageUI.CreateSubMenu(RMenu:Get("AQUAGarages", "rented_vehicles_out_manage")))
RMenu:Get('AQUAGarages', 'owned_vehicles'):SetSubtitle("~w~Vehicle Categories")
RMenu:Get('AQUAGarages', 'scrap_vehicle_confirmation'):SetSubtitle("~w~Are you sure you want to scrap this vehicle?")
RMenu.Add('AQUAGarages', 'customfolders',  RageUI.CreateSubMenu(RMenu:Get("AQUAGarages", "owned_vehicles")))
RMenu.Add('AQUAGarages', 'customfolderscate',  RageUI.CreateSubMenu(RMenu:Get("AQUAGarages", "customfolders")))
RMenu.Add('AQUAGarages', 'removecarcustomfolders',  RageUI.CreateSubMenu(RMenu:Get("AQUAGarages", "main")))
RMenu.Add('AQUAGarages', 'addcarcustomfolders',  RageUI.CreateSubMenu(RMenu:Get("AQUAGarages", "main")))


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

-- Did you know you can toggle most things in AQUA within the AQUA/sharedcfg/options.lua?
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('AQUAGarages', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RageUI.ButtonWithStyle("Owned Vehicles", "", {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    if Table_Type == nil or not Table_Type then 
                        Table_Type = true;
                        TriggerServerEvent('AQUA:FetchCars', true, garage_type)
                        TriggerServerEvent('AQUA:FetchFolders')
                        
                    end
                end
            end, RMenu:Get("AQUAGarages", "owned_vehicles"))
            RageUI.ButtonWithStyle("Rented Vehicles", nil, {}, true, function(Hovered, Active, Selected) end, RMenu:Get("AQUAGarages", "rented_vehicles"))
            RageUI.ButtonWithStyle("Store Vehicle", nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    tAQUA.despawnGarageVehicle(garage_type,AQUAConfig.VehicleStoreRadius)
                end
            end)
        end)
    end
    if RageUI.Visible(RMenu:Get('AQUAGarages', 'owned_vehicles')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RentedVeh = false;
            RageUI.ButtonWithStyle("~y~[Custom Vehicle Folders]", "", {}, true, function(Hovered, Active, Selected)
                if Selected then 
                    for i,v in pairs(VehiclesFetchedTable) do 
                        if garage_type == VehiclesFetchedTable[i].config.vtype or  garage_type == VehiclesFetchedTable[i].config.vtype2 or  garage_type == VehiclesFetchedTable[i].config.vtype3 then
                            selected_category = v.vehicles
                        end
                    end
                end
            end, RMenu:Get("AQUAGarages", "customfolders"))
            for i,v in pairs(VehiclesFetchedTable) do 
               if garage_type == VehiclesFetchedTable[i].config.vtype or  garage_type == VehiclesFetchedTable[i].config.vtype2 or  garage_type == VehiclesFetchedTable[i].config.vtype3 then
                    RageUI.ButtonWithStyle(i, "", {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("AQUAGarages", "owned_vehicles_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('AQUAGarages', 'customfolders')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
    
            RageUI.ButtonWithStyle("~y~[Create Vehicle Folder]" , "~y~Create a vehicle folder.", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    local FolderName = KeyboardInput("Enter Folder Name", "", 25)
            
                    if FolderName ~= nil then
                        if Folders[FolderName] == nil then
                            Folders[FolderName] = {}
                            TriggerServerEvent("AQUA:UpdateFolders", Folders)
                        else
                            Notify("~d~Folder Already Exists.")
                        end
                    end
                end
            end)
            
            
            RageUI.ButtonWithStyle("~d~[Delete Vehicle Folder]" , "~y~Delete a custom folder", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    local FolderName = KeyboardInput("Enter folder name", "", 25)
                    if FolderName ~= nil then
                        if Folders[FolderName] ~= nil then
                            local Confirmation = KeyboardInput("Are you sure you want to delete this folder (YES / NO)", "", 25)
                            if Confirmation == "YES" then
                                Folders[FolderName] = nil
                                Notify("~g~Deleted ["..FolderName.."] successfully!")
                                TriggerServerEvent("AQUA:UpdateFolders", Folders)
                            elseif Confirmation == "NO" then
            
                            end
                        end
                    end
                end
            end)
    
            for h,b in pairs(Folders) do
                RageUI.ButtonWithStyle("["..h.."]" , "", {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SelectedFolderName = h
                    end
                end, RMenu:Get("AQUAGarages", "customfolderscate"))
            end
    
        end)
    end
    
    if RageUI.Visible(RMenu:Get('AQUAGarages', 'customfolderscate')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for k,v in pairs(Folders) do
                if k == SelectedFolderName then
                    if #Folders[SelectedFolderName] < 1 then; RageUI.Separator('This folder does not contain any vehicles'); end
                    for i = 1, #Folders[SelectedFolderName] do
                        for a,b in pairs(VehiclesFetchedTable) do 
                            for c,d in pairs(b.vehicles) do
                                if c == v[i] then
                                    RageUI.ButtonWithStyle(d[1], "", {RightLabel = nil}, true, function(Hovered, Active, Selected)
                                        if Selected then
                                            SelectedCar.spawncode = v[i]
                                            SelectedCar.name = d[1]
                                        end
                                        if Active then 
                                            Hovered_Vehicles = v[i]
                                        end
                                    end,RMenu:Get("AQUAGarages", "owned_vehicles_submenu_manage")) 
                                end
                            end
                        end
                end
            end
            end
        end)
    end
    
    if RageUI.Visible(RMenu:Get('AQUAGarages', 'addcarcustomfolders')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if #Folders ~= nil then
                for h,b in pairs(Folders) do
                    RageUI.ButtonWithStyle("["..h.."]" , "", {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedFolderName = h
                            if SelectedCar.spawncode ~= nil then
                                if Folders[SelectedFolderName] ~= nil then
                                    if not table.find(Folders[SelectedFolderName], SelectedCar.spawncode) then
                                        table.insert(Folders[SelectedFolderName], SelectedCar.spawncode)
                                        Notify("~g~Added " ..SelectedCar.name.. " To Folder ["..SelectedFolderName.."]")
                                        TriggerServerEvent("AQUA:UpdateFolders", Folders)
                                    else
                                        Notify("~d~This Car Is Already In This Folder")
                                    end
                                else
                                    Notify("~d~Couldn't find folder ..["..SelectedFolderName.. "]")
                                end
                            end
                        end
                    end, RMenu:Get("AQUAGarages", "main"))
                end
            else
                RageUI.ButtonWithStyle('~y~You Have No Folders Available', "", {}, true, function(Hovered, Active, Selected)end)
            end
        end)
    end
    
    
    if RageUI.Visible(RMenu:Get('AQUAGarages', 'removecarcustomfolders')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if #Folders ~= nil then
                for h,b in pairs(Folders) do
                    RageUI.ButtonWithStyle("["..h.."]" , "", {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedFolderName = h
                            if SelectedCar.spawncode ~= nil then
                                if Folders[SelectedFolderName] ~= nil then
                                    if table.find(Folders[SelectedFolderName], SelectedCar.spawncode) then
                                        local Confirmation = KeyboardInput("Are You Sure You Want To Delete This Vehicle From The Folder "..SelectedFolderName.." (YES / NO)", "", 25)
                                        if Confirmation == "YES" then
                                            -- print(Folders[SelectedFolderName])
                                            print(Folders[SelectedFolderName][1])
                                            for i = 1, #Folders[SelectedFolderName] do
                                                if Folders[SelectedFolderName][i] == SelectedCar.spawncode then
                                                    Folders[SelectedFolderName][i] = nil
                                                    TriggerServerEvent("AQUA:UpdateFolders", Folders)
                                                end
                                            end
                                            Notify("~g~Deleted Vehicle Successfully.")
                                        elseif Confirmation == "NO" then
                
                                        end
                                    else
                                        Notify("~d~This car doesn't exist in this folder")
                                    end
                                else
                                    Notify("~d~Couldn't find folder ..["..SelectedFolderName.. "]")
                                end
                            end
                        end
                    end, RMenu:Get("AQUAGarages", "main"))
                end
            else
                RageUI.ButtonWithStyle('~y~You Have No Folders Available', "", {}, true, function(Hovered, Active, Selected)end)
            end
        end)
    end

    if RageUI.Visible(RMenu:Get('AQUAGarages', 'owned_vehicles_submenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                if RentedVeh then 
                    RageUI.ButtonWithStyle(v[1], v[2] .. " until the vehicle is returned.", {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SelectedCar.spawncode = i 
                            SelectedCar.name = v[1] -- name of the vehicle from garages.lua
                            RMenu:Get('AQUAGarages', 'owned_vehicles_submenu_manage'):SetSubtitle("~d~" .. v[1])
                        end
                        if Active then 
                            Hovered_Vehicles = i
                        end
                    end,RMenu:Get("AQUAGarages", "owned_vehicles_submenu_manage"))
                else 
                    RageUI.ButtonWithStyle(v[1], nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SelectedCar.spawncode = i 
                            SelectedCar.name = v[1] -- name of the vehicle from garages.lua
                            SelectedCar.plate = v[3] -- invdividual vehicle plate from db
                            RMenu:Get('AQUAGarages', 'owned_vehicles_submenu_manage'):SetSubtitle("~d~" .. v[1])
                        end
                        if Active then 
                            Hovered_Vehicles = i
                        end
                    end,RMenu:Get("AQUAGarages", "owned_vehicles_submenu_manage")) 
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('AQUAGarages', 'owned_vehicles_submenu_manage')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.ButtonWithStyle("~g~[Add Vehicle]" , "~y~Add current vehicle to custom folder", {}, true, function(Hovered, Active, Selected)
                if Selected then

                end
            end, RMenu:Get("AQUAGarages", "addcarcustomfolders"))

            RageUI.ButtonWithStyle("~d~[Delete Vehicle]" , "~y~Delete current vehicle from custom folder", {}, true, function(Hovered, Active, Selected)
                if Selected then

                end
            end, RMenu:Get("AQUAGarages", "removecarcustomfolders"))
            RageUI.ButtonWithStyle('Spawn Vehicle', "", {}, true, function(Hovered, Active, Selected)
                if Selected then 
                    tAQUA.spawnGarageVehicle(garage_type, SelectedCar.spawncode, GetEntityCoords(PlayerPedId()), SelectedCar.name, SelectedCar.plate)
                    print("Vehicle Spawncode: "..SelectedCar.spawncode)
                    DeleteCar(veh)
                    RageUI.ActuallyCloseAll()
                end
                if Active then 
                
                end
            end)
            if not RentedVeh then 
                RageUI.ButtonWithStyle('Scrap Vehicle', "", {}, true, function(Hovered, Active, Selected)end,RMenu:Get("AQUAGarages", "scrap_vehicle_confirmation"))
                RageUI.ButtonWithStyle('Rent out Vehicle', "", {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('AQUA:RentVehicle', SelectedCar.spawncode) 
                    end
                    if Active then 
                    
                    end
                end)
                RageUI.ButtonWithStyle('Sell Vehicle', "", {}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        TriggerServerEvent('AQUA:SellVehicle', SelectedCar.spawncode)
                    end
                    if Active then 
                    
                    end
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('AQUAGarages', 'scrap_vehicle_confirmation')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.ButtonWithStyle('Yes', "WARNING: THIS WILL DESTROY YOUR VEHICLE THIS IS NOT REVERSIBLE.", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('AQUA:ScrapVehicle', SelectedCar.spawncode) 
                    Table_Type = nil;
                    RageUI.ActuallyCloseAll()
                    RageUI.Visible(RMenu:Get('AQUAGarages', 'main'), true)  
                end
            end)
            RageUI.ButtonWithStyle('No', "", {}, true, function(Hovered, Active, Selected)end,RMenu:Get("AQUAGarages", "owned_vehicles_submenu_manage"))
        end)
    end
    if RageUI.Visible(RMenu:Get('AQUAGarages', 'rented_vehicles')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            DeleteCar(veh)
            RageUI.ButtonWithStyle('Rented Vehicles Out', "", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    Table_Type = nil;
                    TriggerServerEvent('AQUA:FetchVehiclesOut')
                end
            end,RMenu:Get("AQUAGarages", "rented_vehicles_out_manage"))
            RageUI.ButtonWithStyle('Rented Vehicles In', "", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    Table_Type = nil;
                    RentedVeh = true;
                    TriggerServerEvent('AQUA:FetchVehiclesIn')
                end
            end,RMenu:Get("AQUAGarages", "rented_vehicles_manage"))
        end)
    end
    if RageUI.Visible(RMenu:Get('AQUAGarages', 'rented_vehicles_out_manage')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            Hovered_Vehicles = nil 
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do 
               if garage_type == VehiclesFetchedTable[i].config.vtype or  garage_type == VehiclesFetchedTable[i].config.vtype2 or  garage_type == VehiclesFetchedTable[i].config.vtype3 then
                    RageUI.ButtonWithStyle(i, "", {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            RentedVeh = true; 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("AQUAGarages", "rented_vehicles_out_manage_submenu"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('AQUAGarages', 'rented_vehicles_out_manage_submenu')) then 
        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(selected_category) do 
                RageUI.ButtonWithStyle(v[1] .. ' Rented to: ' .. v[3], v[2] .. " until the vehicle is returned to you.", {}, true, function(Hovered, Active, Selected)
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('AQUAGarages', 'rented_vehicles_manage')) then 
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            Hovered_Vehicles = nil 
            DeleteCar(veh)
            for i,v in pairs(VehiclesFetchedTable) do 
               if garage_type == VehiclesFetchedTable[i].config.vtype or  garage_type == VehiclesFetchedTable[i].config.vtype2 or  garage_type == VehiclesFetchedTable[i].config.vtype3 then
                    RageUI.ButtonWithStyle(i, "", {}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            RentedVeh = true; 
                            selected_category = v.vehicles
                        end
                    end, RMenu:Get("AQUAGarages", "owned_vehicles_submenu"))
                end
            end
        end)
    end
end)


if AQUAConfig.LoadPreviews then 
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
                           tAQUA.notify('~d~Model could not be loaded!') 
                            if vehname then 
                                cantload[vehname] = true
                            end
                            break 
                        end
                    end
                    local coords = GetEntityCoords(PlayerPedId())
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
                            SetEntityHeading(veh, GetEntityHeading(veh)+1 %360)
                        end
                    end)
                end
            end
        end
    end)
end



RegisterNetEvent('AQUA:ReturnFetchedCars')
AddEventHandler('AQUA:ReturnFetchedCars', function(table)
    VehiclesFetchedTable = table;
end)

RegisterNetEvent('AQUA:ReturnFolders')
AddEventHandler('AQUA:ReturnFolders', function(Fodlers)
    Folders = Fodlers;
    print(json.encode(Folders))
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_MPM_NA', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true 
    
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() 
		Citizen.Wait(500) 
		blockinput = false 
		return result 
	else
		Citizen.Wait(500)
		blockinput = false 
		return nil 
	end
end

function table.find(table,p)
    for q,r in pairs(table)do 
        if r==p then 
            return true 
        end 
    end
    return false 
end

RegisterNetEvent('AQUA:CloseGarage')
AddEventHandler('AQUA:CloseGarage', function()
    DeleteCar(veh)
    Table_Type = nil;
    RageUI.ActuallyCloseAll()
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        for i,v in pairs(cfg.garages) do 
            local x,y,z = v[2], v[3], v[4]
            if #(PlayerCoords - vec3(x,y,z)) <= 150 then 
                local type = v[1]
                if type == "Standard" then 
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.5, 0.5, 00, 255, 00, 250, false, true, 2, false, nil, nil, false)
                elseif type == "Rebel" then 
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 00, 50, false, true, 2, true, nil, nil, false)
                elseif type == "VIP" then 
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.5, 0.5, 255, 208, 0, 150, false, true, 2, false, nil, nil, false)
                elseif type == "MET Police" then 
                    DrawMarker(36, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.5, 0.5, 0, 0, 255, 50, false, true, 2, false, nil, nil, false)
                elseif type == "Boat" then 
                    DrawMarker(35, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 50, false, true, 2, true, nil, nil, false)
                elseif type == "Heli" then 
                    DrawMarker(34, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 50, false, true, 2, true, nil, nil, false)
                elseif type == "MET Police Heli" then 
                    DrawMarker(34, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 0, 255, 50, false, true, 2, true, nil, nil, false)
                elseif type == "VIP Heli" then 
                    DrawMarker(34, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 0, 50, false, true, 2, true, nil, nil, false)
                elseif type == "Aircraft" then 
                    DrawMarker(33, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 50, false, true, 2, true, nil, nil, false)
                elseif type == "VIP Aircraft" then 
                    DrawMarker(33, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 0, 50, false, true, 2, true, nil, nil, false)
                elseif type == "MET Police Boats" then 
                    DrawMarker(35, x, y, z -1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 0, 255, 50, false, true, 2, true, nil, nil, false)
                end
            end
        end
    
    end
end)

local MenuOpen = false; 
local inMarker = false;
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(250)
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
                
            elseif garage_type == "MET Police" then 
                MenuOpen = true
                TriggerServerEvent("returnpolice")
                PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)   
                     
            elseif garage_type == "VIP Aircraft" then 
                MenuOpen = true
                TriggerServerEvent("returnVIPaircraft")
                PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)  

            elseif garage_type == "Rebel" then 
                MenuOpen = true
                TriggerServerEvent("returnRebel")
                PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)     
            else 
                MenuOpen = true
                RageUI.Visible(RMenu:Get('AQUAGarages', 'main'), true)  
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
for i,v in pairs(cfg.garages) do 
    if v[5] ~= false then 
        local x,y,z = v[2], v[3], v[4]
        local show = v[5]
        local Blip = AddBlipForCoord(x, y, z)
        SetBlipScale(Blip, 0.65)
        SetBlipDisplay(Blip, 4)
        if v[1] == "Standard" then 
            SetBlipSprite(Blip, 50)
            SetBlipColour(Blip, 2)
            SetBlipScale(Blip, 0.55)
            AddTextEntry("MAPBLIP", v[1] .. ' Garage')
        elseif v[1] == "Rebel" then 
            SetBlipSprite(Blip, 50)
            SetBlipColour(Blip, 1)
            SetBlipScale(Blip, 0.55)
            AddTextEntry("MAPBLIP", v[1] .. ' Garage')
        elseif v[1] == "Boat" then 
            SetBlipSprite(Blip, 427)
            SetBlipColour(Blip, 2)
            AddTextEntry("MAPBLIP", v[1] .. 's')
        elseif v[1] == "MET Police" then 
            SetBlipSprite(Blip, 50)
            SetBlipColour(Blip, 29)
            AddTextEntry("MAPBLIP", v[1] .. ' Garage')
        elseif v[1] == "Heli" then 
            SetBlipSprite(Blip, 43)
            SetBlipColour(Blip, 2)
            AddTextEntry("MAPBLIP", v[1] .. 'copters')
        elseif v[1] == "VIP" then 
            SetBlipSprite(Blip, 225)
            SetBlipColour(Blip, 5)
            AddTextEntry("MAPBLIP", v[1] .. ' Garage')
        elseif v[1] == "VIP Heli" then 
            SetBlipSprite(Blip, 43)
            SetBlipColour(Blip, 5)
            AddTextEntry("MAPBLIP", v[1] .. 'copters')
        elseif v[1] == "MET Police Heli" then 
            SetBlipSprite(Blip, 43)
            SetBlipColour(Blip, 29) 
            AddTextEntry("MAPBLIP", v[1] .. 'copters')
        elseif v[1] == "VIP Aircraft" then 
            SetBlipSprite(Blip, 307)
            SetBlipColour(Blip, 5) 
            AddTextEntry("MAPBLIP", v[1] .. '')
        elseif v[1] == "Aircraft" then 
            SetBlipSprite(Blip, 307)
            SetBlipColour(Blip, 2) 
            AddTextEntry("MAPBLIP", v[1] .. '')
        elseif v[1] == "MET Police Boats" then 
            SetBlipSprite(Blip, 427)
            SetBlipColour(Blip, 29)
            AddTextEntry("MAPBLIP", v[1] .. '')    
        else
            AddTextEntry("MAPBLIP", v[1] .. ' Garage')
        end
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("MAPBLIP")
        EndTextCommandSetBlipName(Blip)
        SetBlipCategory(Blip, 1)
    end
end


RegisterNetEvent("openVIP")
AddEventHandler("openVIP", function()
    RageUI.Visible(RMenu:Get('AQUAGarages', 'main'), true)   
end)


RegisterNetEvent("openVIPaircraft")
AddEventHandler("openVIPaircraft", function()
    RageUI.Visible(RMenu:Get('AQUAGarages', 'main'), true)   
end)

RegisterNetEvent("openPolice")
AddEventHandler("openPolice", function()
    RageUI.Visible(RMenu:Get('AQUAGarages', 'main'), true)  
end)



RegisterNetEvent("openRebel")
AddEventHandler("openRebel", function()
    RageUI.Visible(RMenu:Get('AQUAGarages', 'main'), true)  
end)

