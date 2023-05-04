local NearMoneydrop = false; 
local MoneydropID = nil;
local MoneydropIDNew = nil;
local MoneydropCoords = nil;
local PlayerInMoneyComa = false;
local ItemsInMoneydrop = {}
local model = GetHashKey('prop_poly_bag_money')
local MoneyBag = false;

RegisterNetEvent('ERP:MoneyNotInBag')
AddEventHandler('ERP:MoneyNotInBag', function()
    MoneyBag = false
end)

AddEventHandler('vRP:IsInMoneyComa', function(coma)
    PlayerInMoneyComa = coma;
    if coma then
        MoneydropCoords = false;
        NearMoneydrop = false; 
        MoneydropID = nil;
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(250)
        if not PlayerInMoneyComa then
            local coords = GetEntityCoords(PlayerPedId())
            if DoesObjectOfTypeExistAtCoords(coords, 10.5, model, true) then
                if not NearMoneydrop then
                    NearMoneydrop = true;
                    MoneydropID = GetClosestObjectOfType(coords, 10.5, model, false, false, false)
                    MoneydropIDNew = ObjToNet(MoneydropID)
                    MoneydropCoords = GetEntityCoords(MoneydropID)
                end
            else 
                MoneydropCoords = false;
                NearMoneydrop = false; 
                MoneydropID = nil;
            end
        end
    end
end)

RegisterNetEvent('checkAmmo')
AddEventHandler('checkAmmo', function()
    if IsPedArmed(PlayerPedId(), 4) then 
        TriggerServerEvent('sendAmmo', true)
    else
        TriggerServerEvent('sendAmmo', false)
    end
end)