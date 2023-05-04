RMenu.Add('KnifeStoreMenu', 'main', RageUI.CreateMenu("", "~r~ERP Kinife Store", 1300, 100, "knife", "knife"))
RMenu.Add('KnifeStoreMenu', "confirm", RageUI.CreateSubMenu(RMenu:Get('KnifeStoreMenu', 'main',  1300, 100)))

RageUI.CreateWhile(1.0, RMenu:Get('KnifeStoreMenu', 'main'), nil, function()

    RageUI.IsVisible(RMenu:Get('KnifeStoreMenu', 'main'), true, false, true, function()
        for i , p in pairs(knife.knives) do 
            RageUI.Button(p.name , nil, { RightLabel = knife.currency..tostring(p.price) }, true, function(Hovered, Active, Selected)
                if Selected then
                    cPrice = p.price
                    cHash = p.hash
                end
            end, RMenu:Get("KnifeStoreMenu", "confirm"))
        end

    end, function()
        ---Panels
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("KnifeStoreMenu", "confirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("KnifeStoreMenu", "confirm"), true, false, true, function()  
        RMenu:Get("KnifeStoreMenu", "confirm"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent('ERP:BuyKnife', cPrice, cHash)
            end
        end, RMenu:Get("KnifeStoreMenu", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("KnifeStoreMenu", "main"))
       

    end)
end)




RegisterNetEvent('ERP:Error')
AddEventHandler('ERP:Error', function()
    RageUI.Visible(RMenu:Get("KnifeStoreMenu", "main"))
    alert('~r~Insufficent funds')
end)


isInKnife = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
            local v1 = vector3(knife.coords)
            if isInArea(v1, 100.0) then 
                DrawMarker(27, knife.marker, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isInKnife == false then
            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access ~r~Knife Store')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("KnifeStoreMenu", "main"), true)
                    isInKnife = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInKnife and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("KnifeStoreMenu", "main"), false)
                isInKnife = false
                currentAmmunition = nil
            end
        Citizen.Wait(0)
    end
end)

vRPclient = Proxy.getInterface("vRP")

RegisterNetEvent("ERP:GiveKnife")
AddEventHandler("ERP:GiveKnife", function(hash)
    GiveWeaponToPed(PlayerPedId(), hash, 150, false, false, 0)
end)

RegisterNetEvent("ERP:SetArmour")
AddEventHandler("ERP:SetArmour", function(level) 
    SetPedArmour(PlayerPedId(), level)
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


Citizen.CreateThread(function(v1)
    blip = AddBlipForCoord(knife.marker)
    SetBlipSprite(blip, 154)
    SetBlipScale(blip, 0.8)
    SetBlipDisplay(blip, 2)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Knife Shop")
    EndTextCommandSetBlipName(blip)
  end)


function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end



