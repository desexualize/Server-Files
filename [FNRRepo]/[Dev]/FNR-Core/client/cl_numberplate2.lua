local isInMenu = false
local currentPlate = nil

local carstable = {}

local location = vector3(-532.82318115234,-192.98789978027,38.222385406494)
local m = module("FNRCars", "cfg/cfg_garages")
m=m.garage_types

RMenu.Add('PlateShop', 'main', RageUI.CreateMenu("Number Plate", "~b~Number Plate", 1350, 50))
RMenu.Add("PlateShop", "sub", RageUI.CreateSubMenu(RMenu:Get("PlateShop", "main"), "Number Plate", "~b~Number Plate", 1350, 50))

RageUI.CreateWhile(1.0, RMenu:Get("PlateShop", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("PlateShop", "main"), true, false, true, function()
        if next(carstable) == nil then
            RageUI.Separator('~r~You do not own any vehicles.')
        else
            for i,j in pairs(carstable) do
                for k,v in pairs(m) do
                    for a,l in pairs(v) do
                        if a ~= "_config" then
                            if a == j[1] then
                                RageUI.Button(""..l[1], '~g~Spawncode: ~w~'..j[1]..' - ~g~Current Plate ~w~'..j[2], "", true,function(Hovered, Active, Selected)
                                    if Selected then
                                        selectedCar = j[1]
                                        selectedCarName = l[1]
                                    end
                                end, RMenu:Get("PlateShop", "sub"))
                            end
                        end
                    end
                end
            end
        end
        
    end, function() 
    end)

    RageUI.IsVisible(RMenu:Get("PlateShop", "sub"), true, false, true, function()
        RageUI.Button("Change Number Plate", "~g~Changing plate of "..selectedCarName, {RightLabel = "~g~£50,000"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("FNR:ChangeNumberPlate", selectedCar)
            end
        end)

    end, function() 
    end)

end)


Citizen.CreateThread(function()

    local blip = AddBlipForCoord(location)
	SetBlipSprite(blip, 521)
	SetBlipScale(blip, 0.7)
	SetBlipColour(blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Plate Shop")
	EndTextCommandSetBlipName(blip)

    while true do
        Citizen.Wait(0)

        if isInArea(location, 100.0) then 
            DrawMarker(20, location+1 - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 60, false, true, 2, true)
        end
 
        if isInArea(location, 1.4) and isInMenu == false then 
            alert('Press ~INPUT_VEH_HORN~ to Change your Number plate!')
            if IsControlJustPressed(0, 51) then 
                TriggerServerEvent('FNR:getCars')
                RageUI.Visible(RMenu:Get("PlateShop", "main"), true)
                isInMenu = true
            end
        end

        if isInArea(location, 1.4) == false and isInMenu then
            RageUI.Visible(RMenu:Get("PlateShop", "main"), false)
            RageUI.Visible(RMenu:Get("PlateShop", "sub"), false)
            isInMenu = false
        end
    end
end)

RegisterNetEvent("FNR:RecieveNumberPlate")
AddEventHandler("FNR:RecieveNumberPlate", function(numplate)
    currentPlate = numplate
end)

function isInArea(v, dis) 
    if #(GetEntityCoords(PlayerPedId()) - v) <= dis then  
        return true
    else 
        return false
    end
end

RegisterNetEvent("FNR:carsTable")
AddEventHandler("FNR:carsTable",function(cars)
    carstable = cars
end)

function alert(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end