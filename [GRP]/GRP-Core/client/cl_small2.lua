RMenu.Add('SmallArmsMenuV2', 'main', RageUI.CreateMenu("", "~r~Galaxy Small Arms", 1300, 50, "small", "small"))
RMenu.Add("SmallArmsMenuV2", "confirm", RageUI.CreateSubMenu(RMenu:Get('SmallArmsMenuV2', 'main',  1300, 50)))
RMenu.Add("SmallArmsMenuV2", "confirmA", RageUI.CreateSubMenu(RMenu:Get('SmallArmsMenuV2', 'main',  1300, 50)))

-- RageUI.CreateWhile(wait, menu, key, closure)
local isToggle = false
RageUI.CreateWhile(1.0, RMenu:Get('SmallArmsMenuV2', 'main'), nil, function()

 -- RageUI.IsVisible(menu, header, glare, instructional, items, panels)
    RageUI.IsVisible(RMenu:Get('SmallArmsMenuV2', 'main'), true, false, true, function()
        for i , p in pairs(smallarms.guns.smallarms) do 
            RageUI.Button(p.name , nil, { RightLabel = smallarms.currency..tostring(getMoneyStringFormatted(p.price)) }, true, function(Hovered, Active, Selected)
                if Selected then
                    cPrice = p.price
                    cHash = p.hash
                end
            end, RMenu:Get("SmallArmsMenuV2", "confirm"))
        end
        RageUI.Button("Level 1 Armour ~r~[25%]" , nil, {RightLabel = "£25,000"}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("SmallArmsMenuV2", "confirmA"))
    end, function()
        ---Panels
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("SmallArmsMenuV2", "confirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("SmallArmsMenuV2", "confirm"), true, false, true, function()  
        RMenu:Get("SmallArmsMenuV2", "confirm"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent('SmallArms2:BuyWeapon', cPrice, cHash, isToggle)
            end
        end, RMenu:Get("SmallArmsMenuV2", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("SmallArmsMenuV2", "main"))
       

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("SmallArmsMenuV2", "confirmA"), nil, function()
    RageUI.IsVisible(RMenu:Get("SmallArmsMenuV2", "confirmA"), true, false, true, function()  
        RMenu:Get("SmallArmsMenuV2", "confirmA"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
             
                TriggerServerEvent('SmallArms2:BuyArmour', isToggle)
            end
        end, RMenu:Get("SmallArmsMenuV2", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("SmallArmsMenuV2", "main"))
       

    end)
end)



RegisterNetEvent('SmallArms:Error')
AddEventHandler('SmallArms:Error', function()
    RageUI.Visible(RMenu:Get("SmallArmsMenuV2", "main"))
    alert('~r~Insufficent funds')
end)


function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

isInSmall2 = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(small2.gunshops) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)
            if small2.blipsenabled then 
                local temp2 = AddBlipForCoord(x,y,z)
                SetBlipSprite(temp2, 110)
            end
            if isInArea(v1, 500.0) then 
                DrawMarker(27, 1539.0395507812,3594.9516601562,38.766529083252- 0.899999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 222, 22, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isInSmall2 == false then
            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Small Arms')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("SmallArmsMenuV2", "main"), true)
                    isInSmall2 = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInSmall2 and k == currentAmmunition then
               --  RageUI.Visible(RMenu:Get("SmallArmsMenuV2", "main"), false)
               RageUI.CloseAll()
                isInSmall2 = false
                currentAmmunition = nil
            end
        end
        Citizen.Wait(0)
    end
end)

vRPclient = Proxy.getInterface("vRP")
RegisterNetEvent("small2:givegun")
AddEventHandler("small2:givegun", function(hash)
    local coords = GetEntityCoords(PlayerPedId())
    local comparison = vector3(1539.0395507812,3594.9516601562,38.766529083252)
    local shopname = "Small 2"
    print(coords)
    if #(coords - comparison) > 10 then

        Wait(5000)
        TriggerServerEvent("GRP:anticheatBan", "Cheating/ Triggering Events")
        return
    else
        vRPclient.allowWeapon({hash, "-1"})
        GiveWeaponToPed(PlayerPedId(), hash, 250, false, false, 0)
    end
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
   blip = AddBlipForCoord(1539.0395507812,3594.9516601562,38.766529083252)
   SetBlipSprite(blip, 567)
   SetBlipScale(blip, 0.7)
   SetBlipDisplay(blip, 2)
   SetBlipColour(blip, 1)
   SetBlipAsShortRange(blip, true)
   BeginTextCommandSetBlipName("STRING")
   AddTextComponentString("Sandy Small Arms")
   EndTextCommandSetBlipName(blip)
 end)

