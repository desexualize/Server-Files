RMenu.Add('PoliceMenu', 'main', RageUI.CreateMenu("", "~b~Galaxy Police Armoury", 1300, 50, "police", "police"))
RMenu.Add("PoliceMenu", "confirm", RageUI.CreateSubMenu(RMenu:Get('PoliceMenu', 'main',  1300, 50)))
RMenu.Add("PoliceMenu", "confirmA", RageUI.CreateSubMenu(RMenu:Get('PoliceMenu', 'main',  1300, 50)))

police = {}

police.guns = {
    {name = "Tazer", price = 0, hash = "WEAPON_stungun"},
    {name = "Nightstick", price = 0, hash = "WEAPON_nightstick"},
    {name = "Glock-17", price = 0, hash = "WEAPON_glock17"},
    {name = "M4A1", price = 0, hash = "WEAPON_m4a1"},
    {name = "MP5", price = 0, hash = "WEAPON_mp5"},
    {name = "MCX", price = 0, hash = "WEAPON_mcx"},
    {name = "G36K", price = 0, hash = "WEAPON_g36k"},
}

RageUI.CreateWhile(1.0, RMenu:Get('PoliceMenu', 'main'), nil, function()

    RageUI.IsVisible(RMenu:Get('PoliceMenu', 'main'), true, false, true, function()
        for i , p in pairs(police.guns) do 
            RageUI.Button(p.name , nil, { RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    
                    cPrice = p.price
                    cHash = p.hash
        
                end
            end, RMenu:Get("PoliceMenu", "confirm"))
        end
        RageUI.Button("Level 4 Armour ~b~[100%]" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
      
            end
        end, RMenu:Get("PoliceMenu", "confirmA"))

    end, function()
       
    end)
end)

vRPclient = Proxy.getInterface("vRP")
RegisterNetEvent("police:givegun")
AddEventHandler("police:givegun", function(hash)
    local coords = GetEntityCoords(PlayerPedId())
    local comparison = vector3(438.66287231445,-987.72296142578,34.297355651855)
    local shopname = "Police"
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

RageUI.CreateWhile(1.0, RMenu:Get("PoliceMenu", "confirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("PoliceMenu", "confirm"), true, false, true, function()  
        RMenu:Get("PoliceMenu", "confirm"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent('Police:BuyGun', cHash)
            end
        end, RMenu:Get("PoliceMenu", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("PoliceMenu", "main"))
       

    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("PoliceMenu", "confirmA"), nil, function()
    RageUI.IsVisible(RMenu:Get("PoliceMenu", "confirmA"), true, false, true, function()  
        RMenu:Get("PoliceMenu", "confirmA"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
             if GetPedArmour(PlayerPedId()) <= 90 then
                TriggerServerEvent('Police:BuyArmour')
             else
                notify('~r~You already have Max armour.')
             end
            end
        end, RMenu:Get("PoliceMenu", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("PoliceMenu", "main"))
       

    end)
end)



isInPolice = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
     
    
            local v1 = vector3(438.66287231445,-987.72296142578,34.297355651855)

            if isInArea(v1, 100.0) then 
                DrawMarker(27, 438.66287231445,-987.72296142578,34.297355651855 - 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 0, 170, 255, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isInPolice == false then
            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access PD Armoury')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("PoliceMenu", "main"), true)
                    isInPolice = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInPolice and k == currentAmmunition then

                RageUI.CloseAll()
                isInPolice = false
                currentAmmunition = nil
            end
      
        Citizen.Wait(0)
    end
end)



