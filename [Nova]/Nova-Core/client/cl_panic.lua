local panic_cooldown = false

RegisterCommand(
    "panic",
    function()
        if panic_cooldown == true then
            notify("~r~ Panic button can only be pressed every minute.")
            return
        end
        TriggerServerEvent("Nova:PANIC", GetEntityCoords(PlayerPedId()))
        panic_cooldown = true
    end
)

RegisterNetEvent("Nova:PANICBUTTON")
AddEventHandler(
    "Nova:PANICBUTTON",
    function(coords, paniccolor)
        print(coords)
        local panicblip = AddBlipForRadius(coords.x, coords.y, coords.z, 75.0)
        SetBlipRoute(panicblip, true)
        SetBlipRouteColour(panicblip, 1)
        TriggerServerEvent("Nova:PlayWithinDistance", 3.0, "panic", 1, GetEntityCoords(PlayerPedId()))
        for i = 1, 60 do
            Wait(500)
            SetBlipColour(panicblip, tonumber(paniccolor))
            SetBlipAlpha(panicblip, 180)
            Wait(500)
            SetBlipAlpha(panicblip, 0)
        end
        SetBlipRoute(panicblip, false)
        RemoveBlip(panicblip)
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(60000)
            panic_cooldown = false
        end
    end
)

function notify(msg)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandThefeedPostTicker(true, false)
end
