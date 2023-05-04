local distanceToCasinoEntrance = 1000
local distanceToCasinoExit = 1000
local casinoEntranceVector = vector3(925,47.01,81.11)
local casinoExitVector = vector3(1089.64,206.91,-49.0)

RMenu.Add('casino_enter', 'casino', RageUI.CreateMenu("", "",0,100,"shopui_title_casino", "shopui_title_casino"))
RMenu:Get('casino_enter', 'casino'):SetSubtitle("~b~ENTER")
RMenu.Add('casino_exit', 'casino', RageUI.CreateMenu("", "",0,100,"shopui_title_casino", "shopui_title_casino"))
RMenu:Get('casino_exit', 'casino'):SetSubtitle("~b~EXIT")

function showCasinoEnter(flag)
    RageUI.Visible(RMenu:Get('casino_enter', 'casino'), flag)
end

function showCasinoExit(flag)
    RageUI.Visible(RMenu:Get('casino_exit', 'casino'), flag)
end


RageUI.CreateWhile(1.0, RMenu:Get('casino_exit', 'casino'), nil, function()
    RageUI.IsVisible(RMenu:Get('casino_exit', 'casino'), true, false, true, function()

        RageUI.ButtonWithStyle("Exit Diamond Casino", nil,{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if (Hovered) then

            end
            if (Active) then

            end
            if (Selected) then
                SetEntityCoords(PlayerPedId(),casinoEntranceVector.x,casinoEntranceVector.y,casinoEntranceVector.z)
                for k,v in pairs(cardObjects) do
                    for _,obj in pairs(v) do
                        DeleteObject(obj)
                    end
                end	
            end
        end)

    end)
end)


RageUI.CreateWhile(1.0, RMenu:Get('casino_enter', 'casino'), nil, function()
    RageUI.IsVisible(RMenu:Get('casino_enter', 'casino'), true, false, true, function()

        RageUI.ButtonWithStyle("Enter Diamond Casino", nil,{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if (Hovered) then

            end
            if (Active) then

            end
            if (Selected) then
                SetEntityCoords(PlayerPedId(),casinoExitVector.x,casinoExitVector.y,casinoExitVector.z)
            end
        end)

    end)
end)



Citizen.CreateThread(function()
    while true do 
        if distanceToCasinoEntrance < 1.5  then 
            showCasinoEnter(true)
        elseif distanceToCasinoEntrance < 2.5 then 
            showCasinoEnter(false)
        end
        if distanceToCasinoExit < 1.5  then 
            showCasinoExit(true)
        elseif distanceToCasinoExit < 2.5 then 
            showCasinoExit(false)
        end
        DrawMarker(27, casinoEntranceVector.x, casinoEntranceVector.y, casinoEntranceVector.z-1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 255,255,255, 200, 0, 0, 0, 0)
        DrawMarker(27, casinoExitVector.x, casinoExitVector.y, casinoExitVector.z-1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 255,255,255, 200, 0, 0, 0, 0)
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do 
        local playerCoords = GetEntityCoords(PlayerPedId())

        distanceToCasinoEntrance = #(playerCoords-casinoEntranceVector)
        distanceToCasinoExit = #(playerCoords-casinoExitVector)
        Wait(100)
    end
end)