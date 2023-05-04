clockon = {
    {group = "Special Constable"},
    {group = "Commissioner"},
    {group = "Deputy Commissioner"},
    {group = "Deputy Assistant Commissioner"},
    {group = "Commander"},
    {group = "Chief Superintendent"},
    {group = "Superintendent"},
    {group = "ChiefInspector"},
    {group = "Inspector"},
    {group = "Sergeant"},
    {group = "Senior Constable"},
    {group = "Police Constable"},
    {group = "PCSO"},
}

RMenu.Add('PDClockOn', 'main', RageUI.CreateMenu("", "~d~PD Clockon", 1300, 50, "banners", "police"))

RageUI.CreateWhile(1.0, RMenu:Get('PDClockOn', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('PDClockOn', 'main'), true, false, true, function()
        for i , p in pairs(clockon) do 
            RageUI.ButtonWithStyle(p.group, nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('AQUA:Clockon', p.group)
                    TriggerEvent('AQUA:policeRemove')
                    TriggerServerEvent("AQUA:PoliceCheckRadial")
                end
            end)
        end

        RageUI.ButtonWithStyle("~d~[Unemployed]", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent('removeGroups')
                TriggerEvent('AQUA:policeRemove')
                notify("~d~You are now Clocked Off")
            end
        end)
    end, function()
    end)
end)

RegisterNetEvent('AQUA:policeRemove')
AddEventHandler('AQUA:policeRemove', function()
    local source = source
    local id = PlayerPedId(source)
    RemoveAllPedWeapons(id, true)
    SetPedArmour(id, 0)
end)


isInClockon = false
currentAmmunition = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k, v in pairs(policelockon.clockon) do 
            if isInArea(v, 100.0) then 
                DrawMarker(27, v.x,v.y,v.z - 0.98, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 94, 255, 150, false, true, 0, 0, 0, 0, 0)
            end
            if isInClockon == false then
                if isInArea(v, 1.4) then 
                    alert('Press ~INPUT_VEH_HORN~ to access Police Clock on Menu')
                    if IsControlJustPressed(0, 51) then 
                        currentAmmunition = k
                        RageUI.Visible(RMenu:Get("PDClockOn", "main"), true)
                        isInClockon = true
                        currentAmmunition = k 
                    end
                end
            end
            if isInArea(v, 1.4) == false and isInClockon and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("PDClockOn", "main"), false)
                isInClockon = false
                currentAmmunition = nil
             end
        end
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





