RMenu.Add('ERPMenus', 'main', RageUI.CreateMenu("", "~y~VIP Island Store", 1300, 100, "vip", "vip"))
RMenu.Add("ERPMenus", "confirm", RageUI.CreateSubMenu(RMenu:Get('ERPMenus', 'main',  1300, 100)))
RMenu.Add("ERPMenus", "confirmA", RageUI.CreateSubMenu(RMenu:Get('ERPMenus', 'main',  1300, 100)))

local isToggle = false
RageUI.CreateWhile(1.0, RMenu:Get('ERPMenus', 'main'), nil, function()

    RageUI.IsVisible(RMenu:Get('ERPMenus', 'main'), true, false, true, function()
        for i , p in pairs(vip.guns) do 
            RageUI.Button(p.name , nil, { RightLabel = "£" .. getMoneyStringFormatted(p.price) .. ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    
                    cPrice = p.price
                    cHash = p.hash
        
                end
            end, RMenu:Get("ERPMenus", "confirm"))
        end
        RageUI.Button("Level 4 Armour ~y~[100%]" , nil, {RightLabel = "£100,000"}, true, function(Hovered, Active, Selected)
            if Selected then
      
            end
        end, RMenu:Get("ERPMenus", "confirmA"))

    end, function()
       
    end)
end)

RegisterNetEvent('isToggleT')
AddEventHandler('isToggleT', function(bool2)
        isToggle = bool2
end)

vRPclient = Proxy.getInterface("vRP")
RegisterNetEvent("VIP:givegun")
AddEventHandler("VIP:givegun", function(hash)
    local coords = GetEntityCoords(PlayerPedId())
    local comparison = vector3(1544.7969970703, 6331.2475585938, 24.077945709229)
    local shopname = "VIP"
        GiveWeaponToPed(PlayerPedId(), hash, 250, false, false, 0)
    end)

RageUI.CreateWhile(1.0, RMenu:Get("ERPMenus", "confirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("ERPMenus", "confirm"), true, false, true, function()  
        RMenu:Get("ERPMenus", "confirm"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent('ERPVIP:BuyGun', cPrice, cHash, isToggle)
            end
        end, RMenu:Get("ERPMenus", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("ERPMenus", "main"))
       

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("ERPMenus", "confirmA"), nil, function()
    RageUI.IsVisible(RMenu:Get("ERPMenus", "confirmA"), true, false, true, function()  
        RMenu:Get("ERPMenus", "confirmA"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
             if GetPedArmour(PlayerPedId()) <= 90 then
                TriggerServerEvent('ERPVIP:BuyArmour', isToggle)
             else
                notify('~r~You already have Max armour.')
             end
            end
        end, RMenu:Get("ERPMenus", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("ERPMenus", "main"))
       

    end)
end)



onvip = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(vip.gunshops) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)

            if isInArea(v1, 100.0) then 
                DrawMarker(27, -2167.0510253906,5198.416015625,15.880374908447, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 255, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if onvip == false then
            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access VIP')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("ERPMenus", "main"), true)
                    onvip = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and onvip and k == currentAmmunition then

                RageUI.CloseAll()
                onvip = false
                currentAmmunition = nil
            end
        end
        Citizen.Wait(0)
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
  
function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end


