local NearLootBag = false; 
local LootBagID = nil;
local LootBagIDNew = nil;
local LootBagCoords = nil;
local PlayerInComa = false;
local ItemsInLootBag = {}
local model = GetHashKey('prop_arena_bag_01')
local MoneyBag = false;

RMenu.Add('AQUALootBags', 'main', RageUI.CreateMenu("Lootbag", "~d~Lootbag Menu",GetRageUIMenuWidth(),GetRageUIMenuHeight()))

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Citizen.Wait(1.5)
    end
end

RegisterNetEvent('AQUA:LootAnim')
AddEventHandler('AQUA:LootAnim', function()
    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    LoadAnimDict('amb@medic@standing@kneel@base')
    LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
    TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
    TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
end)

RegisterNetEvent('AQUA:OpenLootBag')
AddEventHandler('AQUA:OpenLootBag', function(table)
    RageUI.Visible(RMenu:Get('AQUALootBags', 'main'), true)  
    ItemsInLootBag = table
    TriggerEvent('AQUA:LootAnim')
end)

RegisterNetEvent('AQUA:UpdateLootBag')
AddEventHandler('AQUA:UpdateLootBag', function(table)
    ItemsInLootBag = table
end)

RegisterNetEvent('AQUA:CloseLootBag')
AddEventHandler('AQUA:CloseLootBag', function()
    ItemsInLootBag = {}
    RageUI.Visible(RMenu:Get('AQUALootBags', 'main'), false)  
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('AQUALootBags', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for i,v in pairs(ItemsInLootBag) do    
                RageUI.ButtonWithStyle(i, "Amount: " .. v[2] .. ' KG: ' .. v[1], {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        if tonumber(v[2]) > 0 then 
                            AddTextEntry('FMMC_MPM_NC', "Enter amount to take of: " .. i .. ' | Max you can take: ' .. v[2])
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0);
                                Wait(0);
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then 
                                    result = result
                                    AQUA_server_callback('AQUA:LootBagTakeItem', LootBagIDNew, result, v[3])
                                end
                            end  
                        end
                    end
                end)
            end
        end)
    end
end)

AddEventHandler('AQUA:IsInComa', function(coma)
    PlayerInComa = coma;
    if coma then
        LootBagCoords = false;
        NearLootBag = false; 
        LootBagID = nil;
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(500)
        if not PlayerInComa then
            local coords = GetEntityCoords(PlayerPedId())
            if DoesObjectOfTypeExistAtCoords(coords, 1.5, model, true) then
                if not NearLootBag then
                    NearLootBag = true;
                    LootBagID = GetClosestObjectOfType(coords, 1.5, model, false, false, false)
                    LootBagIDNew = ObjToNet(LootBagID)
                    LootBagCoords = GetEntityCoords(LootBagID)
                end
            else 
                LootBagCoords = false;
                NearLootBag = false; 
                LootBagID = nil;
            end
        end
    end
end)