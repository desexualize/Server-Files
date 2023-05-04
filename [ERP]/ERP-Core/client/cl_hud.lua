local hudToggle = true

Citizen.CreateThread(function ()
    while true do
        if hudToggle then

           C_Hud()
     
        end
		Wait(0)
	end
end)



Citizen.CreateThread(function()
    while true do
        if hideUi then
            TriggerEvent("chat:clear")
        end
        Wait(0)
    end
  end)
  
RegisterNetEvent('doit')
AddEventHandler('doit', function()
    ExecuteCommand('storeweapons')
end)
-- [Functions]

function C_Hud()
    local userid = PlayerPedId()
    local UI = GetMinimapAnchor()
    local health = (GetEntityHealth(userid) - 100) / 100.0
    if health < 0 then health = 0.0 end
    if health == 0.98 then health = 1.0 end
    local armor = GetPedArmour(userid) / 100.0
    if armor == 95 / 100.0 then armor = 100 / 100.0 end

    drawRct(UI.Left_x, UI.Bottom_y - 0.017, UI.Width, 0.028, 0, 0, 0, 50) -- [Transparent Backround]
    drawRct(UI.Left_x + 0.001 , UI.Bottom_y - 0.015, (UI.Width -0.002) * health , 0.009, 15, 252, 3 , 250) -- [Health Bat]
    drawRct(UI.Left_x + 0.001 , UI.Bottom_y - 0.002, (UI.Width - 0.002) * armor , 0.009, 0, 183, 255, 250) -- [Armour Bar]

end

function GetMinimapAnchor()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.Width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.Left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.Bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.Left_x + Minimap.Width
    Minimap.top_y = Minimap.Bottom_y - Minimap.height
    Minimap.x = Minimap.Left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end

function drawRct(x,y,Width,height,r,g,b,a)
    DrawRect(x+Width/2,y+height/2,Width,height,r,g,b,a,0)
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

  
  




RegisterCommand(
    "hideui",
    function()
        TriggerEvent("ERP-Client:UI:Toggle", false)
    end
)
RegisterCommand(
    "showui",
    function()
        TriggerEvent("ERP-Client:UI:Toggle", true)
    end
)

RegisterCommand(
    "hidecasinoui",
    function()
        TriggerEvent("ERP-Client:UI2:Toggle", false)
    end
)

RegisterCommand(
    "showcasinoui",
    function()
        TriggerEvent("ERP-Client:UI2:Toggle", true)
    end
)



AddEventHandler("playerSpawned", function()
    TriggerEvent("ERP-Client:UI2:Toggle", false)
end)
