RMenu.Add('LicenseCentre2', 'main', RageUI.CreateMenu("", "License Center", 1300, 50, "licenses", "licenses"))
RMenu.Add("LicenseCentre2", "confirm", RageUI.CreateSubMenu(RMenu:Get('LicenseCentre2', 'main',  1300, 50)))


RageUI.CreateWhile(1.0, RMenu:Get('LicenseCentre2', 'main'), nil, function()


    RageUI.IsVisible(RMenu:Get('LicenseCentre2', 'main'), true, false, true, function()

        for i , p in pairs(license2.licenses.jobs) do 
            RageUI.Button(p.name , nil, { RightLabel = license2.currency .. tostring(p.priceshow) }, true, function(Hovered, Active, Selected)
                if Selected then

                    cPrice = p.price
                    cGroup = p.group
                    cName = p.name
                    cPriceshop = p.priceshow
                    
                end
            end, RMenu:Get("LicenseCentre2", "confirm"))
        end

    end, function()

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("LicenseCentre2", "confirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("LicenseCentre2", "confirm"), true, false, true, function()  
        RMenu:Get("LicenseCentre2", "confirm"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent('LicenseCentre2:BuyGroup', cPrice, cGroup, cName, cPriceshop)
            end
        end, RMenu:Get("LicenseCentre2", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("LicenseCentre2", "main"))
       

    end)
end)

inLicenseMenu2 = false
Citizen.CreateThread(function() 
    while true do
            local v1 = license2.coords

            if isInArea(v1, 100.0) then 
                DrawMarker(2, v1+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.4, 0.4, 0.4, 0, 222, 61, 155, true, true, 0, 0, 0, 0, 0)
            end

            DrawMarker(39, 936.82287597656,-3197.0200195312,5.9007635116577+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 255, 136, 0, 155, false, true, 0, 0, 0, 0, 0)

            if inLicenseMenu2 == false then

                if isInArea(v1, 1.4) then 
                    alert('Press ~INPUT_VEH_HORN~ to access License Centre')
                    if IsControlJustPressed(0, 51) then 
                        currentAmmunition = k
                        RageUI.Visible(RMenu:Get("LicenseCentre2", "main"), true)
                        inLicenseMenu2 = true
                    end
                end

            end
            if isInArea(v1, 1.4) == false and inLicenseMenu2 and k == currentAmmunition then

                RageUI.CloseAll()
                inLicenseMenu2 = false

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




