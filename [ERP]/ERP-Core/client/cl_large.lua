RMenu.Add('BronzeMenu', 'main', RageUI.CreateMenu("", "~r~Large Arms Trader", 1300, 100, "large", "large"))
RMenu.Add("BronzeMenu", "confirm", RageUI.CreateSubMenu(RMenu:Get('BronzeMenu', 'main',  1300, 100)))
RMenu.Add("BronzeMenu", "confirmA", RageUI.CreateSubMenu(RMenu:Get('BronzeMenu', 'main',  1300, 100)))
RMenu.Add("BronzeMenu", "confirmP", RageUI.CreateSubMenu(RMenu:Get('BronzeMenu', 'main',  1300, 100)))
currentTurf = 0
local isToggle = false
RageUI.CreateWhile(1.0, RMenu:Get('BronzeMenu', 'main'), nil, function()

    RageUI.IsVisible(RMenu:Get('BronzeMenu', 'main'), true, false, true, function()
        for i , p in pairs(bronze.guns) do 

                RageUI.Button(p.name, nil, { RightLabel = "£" .. getMoneyStringFormatted(p.price + (p.price * (currentTurf / 100))) .. "" }, true, function(Hovered, Active, Selected)
                    if Selected then
    
                        cPrice = p.price
                        cHash = p.hash
                    
                    end
                end, RMenu:Get("BronzeMenu", "confirm"))
           
        end
        RageUI.Button("Level 2 Armour Plate" , nil, {RightLabel = "£50,000"}, true, function(Hovered, Active, Selected)
            if Selected then

            end
        end, RMenu:Get("BronzeMenu", "confirmP"))
        RageUI.Button("Level 2 Armour ~r~[50%]" , nil, {RightLabel = "£50,000"}, true, function(Hovered, Active, Selected)
            if Selected then

            end
        end, RMenu:Get("BronzeMenu", "confirmA"))

        RageUI.Button("" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
           
            end
        end)

        RageUI.Button("Current Commision - " .. currentTurf .. "%" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then

            end
        end)

    end, function()
       
    end)
end)

vRPclient = Proxy.getInterface("vRP")
RegisterNetEvent("large:givegun")
AddEventHandler("large:givegun", function(hash)
    local coords = GetEntityCoords(PlayerPedId())
    local comparison = vector3(-1111.2421875,4937.345703125,218.38659667969)
    local shopname = "Large Arms"
        GiveWeaponToPed(PlayerPedId(), hash, 250, false, false, 0)
    end)

RageUI.CreateWhile(1.0, RMenu:Get("BronzeMenu", "confirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("BronzeMenu", "confirm"), true, false, true, function()  
        RMenu:Get("BronzeMenu", "confirm"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent('Bronze:BuyGun', cPrice, cHash, isToggle)
            end
        end, RMenu:Get("BronzeMenu", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("BronzeMenu", "main"))
       

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("BronzeMenu", "confirmA"), nil, function()
    RageUI.IsVisible(RMenu:Get("BronzeMenu", "confirmA"), true, false, true, function()  
        RMenu:Get("BronzeMenu", "confirmA"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
             

                TriggerServerEvent('Bronze:BuyArmour', isToggle)
            end
        end, RMenu:Get("BronzeMenu", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("BronzeMenu", "main"))
       

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("BronzeMenu", "confirmP"), nil, function()
    RageUI.IsVisible(RMenu:Get("BronzeMenu", "confirmP"), true, false, true, function()  
        RMenu:Get("BronzeMenu", "confirmP"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
             

                TriggerServerEvent('Large:BuyArmourPlate')
            end
        end, RMenu:Get("BronzeMenu", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("BronzeMenu", "main"))
       

    end)
end)

RegisterNetEvent("currentTurf")
AddEventHandler("currentTurf", function(turf)
    currentTurf = turf 
end)

RegisterNetEvent('isToggleL')
AddEventHandler('isToggleL', function(bool2)
        isToggle = bool2
     
end)


isInbronze = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(bronze.gunshops) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)

            if isInArea(v1, 100.0) then 
                DrawMarker(27, -1111.2548828125,4937.345703125,218.38697814941- 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 250, 0, 0, 2, 0, 0, 0, false) 
            end
            if isInbronze == false then
            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Large Arms')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("BronzeMenu", "main"), true)
                    isInbronze = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInbronze and k == currentAmmunition then
                --RageUI.Visible(RMenu:Get("BronzeMenu", "main"), false)
                RageUI.CloseAll()
                isInbronze = false
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


Citizen.CreateThread(function()
    blip = AddBlipForCoord(-1111.2548828125,4937.345703125,218.38697814941)
    SetBlipSprite(blip, 150)
    SetBlipScale(blip, 0.6)
    SetBlipDisplay(blip, 2)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Large Arms Dealer")
    EndTextCommandSetBlipName(blip)
  end)

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end


