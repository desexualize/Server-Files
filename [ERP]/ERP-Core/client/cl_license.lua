RMenu.Add('LicenseCentre', 'main', RageUI.CreateMenu("", "License Center", 1300, 100, "licenses", "licenses"))
RMenu.Add('LicenseCentre', 'legal', RageUI.CreateMenu("", "License Center", 1300, 100, "licenses", "licenses"))
RMenu.Add('LicenseCentre', 'ilegal', RageUI.CreateMenu("", "License Center", 1300, 100, "licenses", "licenses"))
RMenu.Add('LicenseCentre', 'crypto', RageUI.CreateMenu("", "License Center", 1300, 100, "licenses", "licenses"))
RMenu.Add('LicenseCentre', 'fragging', RageUI.CreateMenu("", "License Center", 1300, 100, "licenses", "licenses"))
RMenu.Add("LicenseCentre", "confirm", RageUI.CreateSubMenu(RMenu:Get('LicenseCentre', 'main',  1300, 100)))


RageUI.CreateWhile(1.0, RMenu:Get('LicenseCentre', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('LicenseCentre', 'main'), true, false, true, function()
        RageUI.Button("~g~[Legal Licenses]", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('LicenseCentre', 'legal'))
        RageUI.Button("~r~[Criminal Licenses]", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('LicenseCentre', 'ilegal'))
        RageUI.Button("~r~[Fragging Licenses]", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('LicenseCentre', 'fragging'))
        RageUI.Button("~b~[Crypto Licenses]", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('LicenseCentre', 'crypto'))

        --[[
        for i , p in pairs(license.licenses.legal) do 
            RageUI.Button(p.name , nil, { RightLabel = license.currency .. tostring(p.priceshow) }, true, function(Hovered, Active, Selected)
                if Selected then

                    cPrice = p.price
                    cGroup = p.group
                    cName = p.name
                    cPriceshop = p.priceshow
                    
                end
            end, RMenu:Get("LicenseCentre", "confirm"))
        end]]

    end, function()

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("LicenseCentre", "legal"), nil, function()
    RageUI.IsVisible(RMenu:Get("LicenseCentre", "legal"), true, false, true, function()  
        for i , p in pairs(license.licenses.legal) do 
            RageUI.Button(p.name , nil, { RightLabel = license.currency .. tostring(p.priceshow) }, true, function(Hovered, Active, Selected)
                if Selected then

                    cPrice = p.price
                    cGroup = p.group
                    cName = p.name
                    cPriceshop = p.priceshow
                    
                end
            end, RMenu:Get("LicenseCentre", "confirm"))
        end
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("LicenseCentre", "ilegal"), nil, function()
    RageUI.IsVisible(RMenu:Get("LicenseCentre", "ilegal"), true, false, true, function()  
        for i , p in pairs(license.licenses.ilegal) do 
            RageUI.Button(p.name , nil, { RightLabel = license.currency .. tostring(p.priceshow) }, true, function(Hovered, Active, Selected)
                if Selected then

                    cPrice = p.price
                    cGroup = p.group
                    cName = p.name
                    cPriceshop = p.priceshow
                    
                end
            end, RMenu:Get("LicenseCentre", "confirm"))
        end
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("LicenseCentre", "crypto"), nil, function()
    RageUI.IsVisible(RMenu:Get("LicenseCentre", "crypto"), true, false, true, function()  
        for i , p in pairs(license.licenses.crypto) do 
            RageUI.Button(p.name , nil, { RightLabel = license.currency .. tostring(p.priceshow) }, true, function(Hovered, Active, Selected)
                if Selected then

                    cPrice = p.price
                    cGroup = p.group
                    cName = p.name
                    cPriceshop = p.priceshow
                    
                end
            end, RMenu:Get("LicenseCentre", "confirm"))
        end

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("LicenseCentre", "fragging"), nil, function()
    RageUI.IsVisible(RMenu:Get("LicenseCentre", "fragging"), true, false, true, function()  
        for i , p in pairs(license.licenses.fragging) do 
            RageUI.Button(p.name , nil, { RightLabel = license.currency .. tostring(p.priceshow) }, true, function(Hovered, Active, Selected)
                if Selected then

                    cPrice = p.price
                    cGroup = p.group
                    cName = p.name
                    cPriceshop = p.priceshow
                    
                end
            end, RMenu:Get("LicenseCentre", "confirm"))
        end

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("LicenseCentre", "confirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("LicenseCentre", "confirm"), true, false, true, function()  
        RMenu:Get("LicenseCentre", "confirm"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent('LicenseCentre:BuyGroup', cPrice, cGroup, cName, cPriceshop)
            end
        end, RMenu:Get("LicenseCentre", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("LicenseCentre", "main"))
       

    end)
end)

inLicenseMenu2 = false
Citizen.CreateThread(function() 
    while true do
            local v1 = license.coords

            if isInArea(v1, 100.0) then 
                DrawMarker(2, v1+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.4, 0.4, 0.4, 0, 222, 61, 155, true, true, 0, 0, 0, 0, 0)
            end

            if inLicenseMenu2 == false then

                if isInArea(v1, 1.4) then 
                    alert('Press ~INPUT_VEH_HORN~ to access License Centre')
                    if IsControlJustPressed(0, 51) then 
                        currentAmmunition = k
                        RageUI.Visible(RMenu:Get("LicenseCentre", "main"), true)
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

RegisterNetEvent("ERP:PlaySound")
AddEventHandler("ERP:PlaySound", function(status)
    if status == 1 then 
        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0)
    end

    if status == 2 then 
        PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0)
    end
end)