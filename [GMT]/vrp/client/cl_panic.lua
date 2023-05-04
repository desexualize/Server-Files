local showPanicBlip = false
local panic = false
local police = false
local blipTime = 60

tvRP.hasPoliceJob = function(bool)
    police = bool
end

tvRP.PanicCL = function(player, s1, s2, name)
    if police then
        local mugshot, mugshotStr = GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(player)))

        ShowAdvancedNotification(name..' is in danger.', s2, 'Respond immediately.', mugshotStr, 4)
        UnregisterPedheadshot(mugshot)
    end
end

tvRP.BlipCL = function(tx, ty, tz)
    if police then
        local Blip = AddBlipForRadius(tx, ty, tz, 100.0)

			SetBlipRoute(Blip, true)

			Citizen.CreateThread(function()
				while Blip do
					SetBlipRouteColour(Blip, 1)
					Citizen.Wait(150)
					SetBlipRouteColour(Blip, 6)
					Citizen.Wait(150)
					SetBlipRouteColour(Blip, 35)
					Citizen.Wait(150)
					SetBlipRouteColour(Blip, 6)
				end
			end)

			SetBlipAlpha(Blip, 60)
			SetBlipColour(Blip, 3)
			SetBlipFlashes(Blip, true)
			SetBlipFlashInterval(Blip, 200)

			Citizen.Wait(blipTime * 1000)

			RemoveBlip(Blip)
			Blip = nil
            panic = false
    end
end

ShowAdvancedNotification = function(title, subject, msg, icon, iconType)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(msg)
    SetNotificationMessage(icon, icon, false, iconType, title, subject)
    DrawNotification(false, false)
end

GetPedMugshot = function(ped)
    local mugshot = RegisterPedheadshot(ped)

    while not IsPedheadshotReady(mugshot) do
        Citizen.Wait(0)
    end

    return mugshot, GetPedheadshotTxdString(mugshot)
end

Citizen.CreateThread(function()
    while true do Wait(2500)
        vRPserver.getInfo({})
    end
end)

Citizen.CreateThread(function()
    local ticks = 500
    while true do
        if showPanicBlip and police and not panic then
            ticks = 1
            showPanicBlip = false
            panic = true

            local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
            local streetA, streetB = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        
            local player = GetPlayerPed(PlayerId())

            if tostring(GetStreetNameFromHashKey(streetA)) and tostring(GetStreetNameFromHashKey(streetB)) then
        
                vRPserver.PanicSV({player,  GetStreetNameFromHashKey(streetA), GetStreetNameFromHashKey(streetB)})
                vRPserver.BlipSV({plyPos.x, plyPos.y, plyPos.z})
            else
                vRPserver.PanicSV({player,  "No street found", ""})
                vRPserver.BlipSV({plyPos.x, plyPos.y, plyPos.z})
            end
        end

        Wait(0)
        ticks = 500
    end
end)

RegisterCommand("panic", function(source, args, rawCommand)
    showPanicBlip = true
end, false)