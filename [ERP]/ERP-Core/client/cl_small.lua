RMenu.Add('SmallArmsMenu', 'main', RageUI.CreateMenu("", "~r~ERP Small Arms", 1300, 100, "small", "small"))
RMenu.Add("SmallArmsMenu", "confirm", RageUI.CreateSubMenu(RMenu:Get('SmallArmsMenu', 'main',  1300, 100)))
RMenu.Add("SmallArmsMenu", "confirmA", RageUI.CreateSubMenu(RMenu:Get('SmallArmsMenu', 'main',  1300, 100)))
RMenu.Add("SmallArmsMenu", "confirmP", RageUI.CreateSubMenu(RMenu:Get('SmallArmsMenu', 'main',  1300, 100)))
local isToggle = false
RageUI.CreateWhile(1.0, RMenu:Get('SmallArmsMenu', 'main'), nil, function()

 -- RageUI.IsVisible(menu, header, glare, instructional, items, panels)
    RageUI.IsVisible(RMenu:Get('SmallArmsMenu', 'main'), true, false, true, function()
        for i , p in pairs(smallarms.guns.smallarms) do 
            RageUI.Button(p.name , nil, { RightLabel = smallarms.currency..tostring(getMoneyStringFormatted(p.price)) }, true, function(Hovered, Active, Selected)
                if Selected then
        
                    cPrice = p.price
                    cHash = p.hash
                end
            end, RMenu:Get("SmallArmsMenu", "confirm"))
        end
        RageUI.Button("Level 1 Armour Plate" , nil, {RightLabel = "£25,000"}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("SmallArmsMenu", "confirmP"))
        RageUI.Button("Level 1 Armour ~r~[25%]" , nil, {RightLabel = "£25,000"}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("SmallArmsMenu", "confirmA"))

    end, function()
        ---Panels
    end)
end)

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end


RegisterNetEvent('isToggleS')
AddEventHandler('isToggleS', function(bool2)
        isToggle = bool2
end)


RageUI.CreateWhile(1.0, RMenu:Get("SmallArmsMenu", "confirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("SmallArmsMenu", "confirm"), true, false, true, function()  
        RMenu:Get("SmallArmsMenu", "confirm"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent('SmallArms:BuyWeapon', cPrice, cHash, isToggle)
            end
        end, RMenu:Get("SmallArmsMenu", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("SmallArmsMenu", "main"))
       

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("SmallArmsMenu", "confirmA"), nil, function()
    RageUI.IsVisible(RMenu:Get("SmallArmsMenu", "confirmA"), true, false, true, function()  
        RMenu:Get("SmallArmsMenu", "confirmA"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
             
                TriggerServerEvent('SmallArms:BuyArmour', isToggle)
            end
        end, RMenu:Get("SmallArmsMenu", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("SmallArmsMenu", "main"))
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("SmallArmsMenu", "confirmP"), nil, function()
    RageUI.IsVisible(RMenu:Get("SmallArmsMenu", "confirmP"), true, false, true, function()  
        RMenu:Get("SmallArmsMenu", "confirmP"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
             
                TriggerServerEvent('SmallArms:BuyArmourPlate')
            end
        end, RMenu:Get("SmallArmsMenu", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("SmallArmsMenu", "main"))
    end)
end)



vRPclient = Proxy.getInterface("vRP")
RegisterNetEvent("small:givegun")
AddEventHandler("small:givegun", function(hash)
    local coords = GetEntityCoords(PlayerPedId())
    local comparison = vector3(1242.8059082031,-426.96542358398,68.91535949707)
    local shopname = "Small"
        GiveWeaponToPed(PlayerPedId(), hash, 250, false, false, 0)
    end)

RegisterNetEvent('SmallArms:Error')
AddEventHandler('SmallArms:Error', function()
    RageUI.Visible(RMenu:Get("SmallArmsMenu", "main"))
    alert('~r~Insufficent funds')
end)


function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

isInSmallarms = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(smallarms.gunshops) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)
            if smallarms.blipsenabled then 
                local temp2 = AddBlipForCoord(x,y,z)
                SetBlipSprite(temp2, 110)
            end
            if isInArea(v1, 500.0) then 
                DrawMarker(27, 1242.8059082031,-426.96542358398,68.91535949707 - 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 222, 22, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isInSmallarms == false then
            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Small Arms')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("SmallArmsMenu", "main"), true)
                    isInSmallarms = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInSmallarms and k == currentAmmunition then
                --RageUI.Visible(RMenu:Get("SmallArmsMenu", "main"), false)
                RageUI.CloseAll()
                isInSmallarms = false
                currentAmmunition = nil
            end
        end
        Citizen.Wait(0)
    end
end)



vRPclient = Proxy.getInterface("vRP")

RegisterNetEvent("SmallArms:GiveWeapon")
AddEventHandler("SmallArms:GiveWeapon", function(hash)
    GiveWeaponToPed(PlayerPedId(), hash, 250, false, false, 0)
end)

RegisterNetEvent("SmallArms:GiveArmour")
AddEventHandler("SmallArms:GiveArmour", function(level) 
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

Citizen.CreateThread(function()
   blip = AddBlipForCoord(1242.8059082031,-426.96542358398,68.91535949707)
   SetBlipSprite(blip, 567)
   SetBlipScale(blip, 0.7)
   SetBlipDisplay(blip, 2)
   SetBlipColour(blip, 1)
   SetBlipAsShortRange(blip, true)
   BeginTextCommandSetBlipName("STRING")
   AddTextComponentString("Small Arms")
   EndTextCommandSetBlipName(blip)
 end)

 
 