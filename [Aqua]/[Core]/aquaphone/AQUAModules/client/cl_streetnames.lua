streetson = false
local veh = 0;
local hash1, hash2, heading;

RegisterNetEvent("AQUA:StreetNames")
AddEventHandler("AQUA:StreetNames", function(bool)
    streetson = bool
	if streetson then
        --ShowNotification("~y~Street Names Are Now ~g~Enabled")
    else
        --ShowNotification("~y~Street Names Are Now ~d~Disabled")
    end
end)

RegisterCommand("streetnames", function()
	streetson = not streetson
	if streetson then
        --ShowNotification("~y~Street Names Are Now ~g~Enabled")
    else
        --ShowNotification("~y~Street Names Are Now ~d~Disabled")
    end
end)

function ShowNotification(u)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(u)
    DrawNotification(false, false)
end

Citizen.CreateThread(function()
	while true do
		if streetson then
			local ped = PlayerPedId();
			local veh = GetVehiclePedIsIn(ped, false);

			local coords = GetEntityCoords(PlayerPedId());
			local zone = GetNameOfZone(coords.x, coords.y, coords.z);
			local zoneLabel = GetLabelText(zone);

			if streetson == true then 
				local var1, var2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
				hash1 = GetStreetNameFromHashKey(var1);
				hash2 = GetStreetNameFromHashKey(var2);
				heading = GetEntityHeading(PlayerPedId());

				local street2;
				if (hash2 == '') then
					street2 = zoneLabel;
				else
					street2 = hash2..', '..zoneLabel;
				end
				
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.5, 0.3)
				SetTextColour(255, 255, 255, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
		
		
				AddTextComponentString("~w~".. hash1 .. " | ~d~" ..street2)
				DrawText(0.015, 0.75)
			end
		end
		Citizen.Wait(0);
	end
end)