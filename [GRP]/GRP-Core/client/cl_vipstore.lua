local gunid = nil

RMenu.Add('VIPMenu', 'main', RageUI.CreateMenu("", "~y~Galaxy VIP Store", 1300, 50, "vip", "vip"))

-- RageUI.CreateWhile(wait, menu, key, closure)
RageUI.CreateWhile(1.0, RMenu:Get('VIPMenu', 'main'), nil, function()

 -- RageUI.IsVisible(menu, header, glare, instructional, items, panels)
    RageUI.IsVisible(RMenu:Get('VIPMenu', 'main'), true, false, true, function()

        RageUI.Button("Enter Weapon Whitelist Code." , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                getAmount()
                TriggerServerEvent('GRP:Whitelist', gunid)
            end
        end)

    end, function()
        ---Panels
    end)
end)

RegisterNetEvent('Galaxy:Error')
AddEventHandler('Galaxy:Error', function()
    RageUI.Visible(RMenu:Get("VIPMenu", "main"))
    alert('~r~Insufficent funds')
end)


isInVIP = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
            local v1 = vector3(VIP.coords)
            if isInArea(v1, 100.0) then 
                DrawMarker(27, VIP.marker, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 247, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isInVIP == false then
            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access ~y~VIP Store')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("VIPMenu", "main"), true)
                    isInVIP = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInVIP and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("VIPMenu", "main"), false)
                isInVIP = false
                currentAmmunition = nil
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

Citizen.CreateThread(function(v1)
    blip = AddBlipForCoord(VIP.marker)
    SetBlipSprite(blip, 439)
    SetBlipScale(blip, 0.8)
    SetBlipDisplay(blip, 2)
    SetBlipColour(blip, 46)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("VIP Store")
    EndTextCommandSetBlipName(blip)
  end)

  function getAmount()
    
	AddTextEntry('FMMC_KEY_TIP8', "Enter the Custom Import ID:")
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "Enter Amount (Blank to Cancel)", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
		if result then
            gunid = result
			return result
		end
    end
	return false

end


function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end



