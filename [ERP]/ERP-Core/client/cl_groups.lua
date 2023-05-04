local Groups = {}


RMenu.Add('GroupMenu', 'groups',  RageUI.CreateMenu("", "ERP Group Display", 700, 150, "group", "group"))

RageUI.CreateWhile(1.0, RMenu:Get('GroupMenu', 'groups'), nil, function()


    RageUI.IsVisible(RMenu:Get('GroupMenu', 'groups'), true, false, true, function()


        for i,v in pairs(Groups) do 
            RageUI.Button(i, nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    SelectedGroup = i;
                end
            end)
        end
   

    end)
end)

Citizen.CreateThread(function()
    while true do
        
        if IsControlJustPressed(0, 167) then 
            
            RageUI.Visible(RMenu:Get("GroupMenu", "groups"), true)
            TriggerServerEvent('GroupMenu:Groups')
        
        end
        Citizen.Wait(1)
    end
end)

RegisterNetEvent('GroupMenu:ReturnGroups')
AddEventHandler('GroupMenu:ReturnGroups', function(groups)
    Groups = groups
end)





