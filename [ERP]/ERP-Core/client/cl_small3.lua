RMenu.Add('SmallArmsMenuV3', 'main', RageUI.CreateMenu("", "~r~ERP Small Arms", 1300, 100, "small", "small"))
RMenu.Add("SmallArmsMenuV3", "confirm", RageUI.CreateSubMenu(RMenu:Get('SmallArmsMenuV3', 'main',  1300, 100)))
RMenu.Add("SmallArmsMenuV3", "confirmA", RageUI.CreateSubMenu(RMenu:Get('SmallArmsMenuV3', 'main',  1300, 100)))
RMenu.Add("SmallArmsMenuV3", "confirmP", RageUI.CreateSubMenu(RMenu:Get('SmallArmsMenuV3', 'main',  1300, 100)))
-- RageUI.CreateWhile(wait, menu, key, closure)
local isToggle = false
RageUI.CreateWhile(1.0, RMenu:Get('SmallArmsMenuV3', 'main'), nil, function()

 -- RageUI.IsVisible(menu, header, glare, instructional, items, panels)
    RageUI.IsVisible(RMenu:Get('SmallArmsMenuV3', 'main'), true, false, true, function()
        for i , p in pairs(smallarms.guns.smallarms) do 
            RageUI.Button(p.name , nil, { RightLabel = smallarms.currency..tostring(getMoneyStringFormatted(p.price)) }, true, function(Hovered, Active, Selected)
                if Selected then
                    cPrice = p.price
                    cHash = p.hash
                end
            end, RMenu:Get("SmallArmsMenuV3", "confirm"))
        end
        RageUI.Button("Level 1 Armour Plate" , nil, {RightLabel = "£25,000"}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("SmallArmsMenuV3", "confirmP"))
        RageUI.Button("Level 1 Armour ~r~[25%]" , nil, {RightLabel = "£25,000"}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("SmallArmsMenuV3", "confirmA"))
    end, function()
        ---Panels
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("SmallArmsMenuV3", "confirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("SmallArmsMenuV3", "confirm"), true, false, true, function()  
        RMenu:Get("SmallArmsMenuV3", "confirm"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent('SmallArms3:BuyWeapon', cPrice, cHash, isToggle)
            end
        end, RMenu:Get("SmallArmsMenuV3", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("SmallArmsMenuV3", "main"))
       

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("SmallArmsMenuV3", "confirmA"), nil, function()
    RageUI.IsVisible(RMenu:Get("SmallArmsMenuV3", "confirmA"), true, false, true, function()  
        RMenu:Get("SmallArmsMenuV3", "confirmA"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
             
                TriggerServerEvent('SmallArms3:BuyArmour', isToggle)
            end
        end, RMenu:Get("SmallArmsMenuV3", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("SmallArmsMenuV3", "main"))
       

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("SmallArmsMenuV3", "confirmP"), nil, function()
    RageUI.IsVisible(RMenu:Get("SmallArmsMenuV3", "confirmP"), true, false, true, function()  
        RMenu:Get("SmallArmsMenuV3", "confirmP"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
             
                TriggerServerEvent('SmallArms3:BuyArmourPlate')
            end
        end, RMenu:Get("SmallArmsMenuV3", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("SmallArmsMenuV3", "main"))
       

    end)
end)



RegisterNetEvent('SmallArms:Error')
AddEventHandler('SmallArms:Error', function()
    RageUI.Visible(RMenu:Get("SmallArmsMenuV3", "main"))
    alert('~r~Insufficent funds')
end)


function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

isInSmall3 = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(small3.gunshops) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)
            if small3.blipsenabled then 
                local temp2 = AddBlipForCoord(x,y,z)
                SetBlipSprite(temp2, 110)
            end
            if isInArea(v1, 500.0) then 
                DrawMarker(27, -1500.0544433594,-216.84588623047,47.889381408691-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 222, 22, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isInSmall3 == false then
            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Small Arms')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("SmallArmsMenuV3", "main"), true)
                    isInSmall3 = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInSmall3 and k == currentAmmunition then
               --  RageUI.Visible(RMenu:Get("SmallArmsMenuV3", "main"), false)
               RageUI.CloseAll()
                isInSmall3 = false
                currentAmmunition = nil
            end
        end
        Citizen.Wait(0)
    end
end)

vRPclient = Proxy.getInterface("vRP")
RegisterNetEvent("small3:givegun")
AddEventHandler("small3:givegun", function(hash)
    local coords = GetEntityCoords(PlayerPedId())
    local comparison = vector3(-1500.0544433594,-216.84588623047,47.889381408691)
    local shopname = "Small 3"
    print(coords)
        GiveWeaponToPed(PlayerPedId(), hash, 250, false, false, 0)
    end)


RegisterNetEvent('isToggleS2')
AddEventHandler('isToggleS2', function(bool2)
        isToggle = bool2
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
   blip = AddBlipForCoord(-1500.0544433594,-216.84588623047,47.889381408691)
   SetBlipSprite(blip, 567)
   SetBlipScale(blip, 0.7)
   SetBlipDisplay(blip, 2)
   SetBlipColour(blip, 1)
   SetBlipAsShortRange(blip, true)
   BeginTextCommandSetBlipName("STRING")
   AddTextComponentString("Small Arms")
   EndTextCommandSetBlipName(blip)
 end)

