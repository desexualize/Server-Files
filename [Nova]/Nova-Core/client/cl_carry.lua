local carry = {
	InProgress = false,
	targetSrc = -1,
	type = "",

	personCarrying = {
		animDict = "missfinale_c2mcs_1",
		anim = "fin_c2_mcs_1_camman",
		flag = 49
	},

	personCarried = {
		animDict = "nm",
		anim = "firemans_carry",
		attachX = 0.27,
		attachY = 0.15,
		attachZ = 0.63,
		flag = 33
	}
}
exports('IsCarrying', function()
    if carry.InProgress then
        return carry.targetSrc
    else
        return false
    end
end)


RegisterCommand("carry", function(source, args)
	if carry.InProgress then
		carry.InProgress = false

		local client_ped = PlayerPedId()
		ClearPedSecondaryTask(client_ped)
		DetachEntity(client_ped, true, false)

		TriggerServerEvent("CarryPeople:stop", carry.targetSrc)
		carry.targetSrc = 0
	else
		local closest_player = Get_Closest_Player(3)
		if closest_player == nil then
			exports['vrp']:notify("~r~No one nearby to carry")
		else
			local target_source = GetPlayerServerId(closest_player)
			if target_source == -1 or target_source == 0 then
				exports['vrp']:notify("~r~No one nearby to carry")
			else
				TriggerServerEvent("Nova:CarryRequest", target_source)
			end
		end
	end
end)

function Get_Closest_Player(radius)
	local client_ped = PlayerPedId()
	local client_coords = GetEntityCoords(client_ped)

	local closest_distance = nil
	local closest_player = nil

	for _, player_id in pairs(GetActivePlayers()) do
		local target_ped = GetPlayerPed(player_id)
		if target_ped ~= client_ped then
			local target_coords = GetEntityCoords(target_ped)
			local target_distance = #(client_coords - target_coords)
			if closest_distance then
				if target_distance < closest_distance then
					closest_distance = target_distance
				end
			else
				if target_distance <= radius then
					closest_distance = target_distance
					closest_player = player_id
				end
			end
		end
	end

	if closest_distance and closest_player then
		return closest_player
	else
		return nil
	end
end

function ensureAnimDict(animDict)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(0)
		end
	end
	return animDict
end

RegisterNetEvent("CarryPeople:syncTarget")
AddEventHandler("CarryPeople:syncTarget", function(targetSrc)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	carry.InProgress = true
	ensureAnimDict(carry.personCarried.animDict)
	AttachEntityToEntity(
		PlayerPedId(),
		targetPed,
		0,
		carry.personCarried.attachX,
		carry.personCarried.attachY,
		carry.personCarried.attachZ,
		0.5,
		0.5,
		180,
		false,
		false,
		false,
		false,
		2,
		false
	)
	carry.type = "beingcarried"
end)

RegisterNetEvent("CarryPeople:cl_stop")
AddEventHandler("CarryPeople:cl_stop", function()
	carry.InProgress = false

	local client_ped = PlayerPedId()
	ClearPedSecondaryTask(client_ped)
	DetachEntity(client_ped, true, false)
end)

Citizen.CreateThread(function()
	while true do
		if carry.InProgress then
			if carry.type == "beingcarried" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 3) then
					TaskPlayAnim(
						PlayerPedId(),
						carry.personCarried.animDict,
						carry.personCarried.anim,
						8.0,
						-8.0,
						100000,
						carry.personCarried.flag,
						0,
						false,
						false,
						false
					)
				end
			elseif carry.type == "carrying" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
					TaskPlayAnim(
						PlayerPedId(),
						carry.personCarrying.animDict,
						carry.personCarrying.anim,
						8.0,
						-8.0,
						100000,
						carry.personCarrying.flag,
						0,
						false,
						false,
						false
					)
				end
			end
		end

		Citizen.Wait(0)
	end
end)

senderSrc = nil

RegisterNetEvent("Nova:StartCarry")
AddEventHandler("Nova:StartCarry", function(targetSrc)
	local targetSrc = targetSrc
	carry.InProgress = true
	carry.targetSrc = targetSrc
	TriggerServerEvent("CarryPeople:sync", targetSrc)
	ensureAnimDict(carry.personCarrying.animDict)
	carry.type = "carrying"
end)

RegisterNetEvent("Nova:CarryTargetAsk")
AddEventHandler("Nova:CarryTargetAsk", function(senderSrc)
	carryrequest = true
	Citizen.CreateThread(function()
		while carryrequest do
			if IsControlJustPressed(1, 83) then
				TriggerServerEvent("Nova:CarryAccepted", senderSrc)
				carryrequest = false
			elseif IsControlJustPressed(1, 84) then
				TriggerServerEvent("Nova:CarryDeclined", senderSrc)
				carryrequest = false
			end
			Citizen.Wait(0)
		end
	end)
end)
