--[[------------------------------------------------------------------------------
  -- File         : /client/cl_state.lua
  -- Purpose      : Vehicle state management. Handles network events and storage of vehicles out of scope.
  -- Variables    : SavedVehicles - Dictionary (key: vehicle netId, value: lights and siren state bag). EnabledVehicles - Dictionary(key: vehicle netId, value: entityId).
--]]------------------------------------------------------------------------------

SavedVehicles = {}
EnabledVehicles = {}

RegisterNetEvent("ARMAELS:changeStage", function(netId, stage)
	if not VehicleConfigs then return end

	local state = GetSavedVehicleState(netId)

	state.stage = stage
	Controller.OnStageChange(state)
end)

RegisterNetEvent("ARMAELS:toggleSiren", function(netId, tone)
	if not VehicleConfigs then return end

	local state = GetSavedVehicleState(netId)

	state.siren.tone = tone
	Controller.OnSirenChange(state)
end)

RegisterNetEvent("ARMAELS:toggleBullhorn", function(netId, enabled)
	if not VehicleConfigs then return end

	local state = GetSavedVehicleState(netId)
	if not state.entity or GetPedInVehicleSeat(state.entity, -1) == CurrentPed then return end

	state.bullhorn.enabled = enabled

	Controller.OnBullhornChange(state)
end)

RegisterNetEvent("ARMAELS:patternChange", function(netId, patternIndex, enabled)
	if not VehicleConfigs then return end

	local state = GetSavedVehicleState(netId)

	local pattern = GetPatternFromIndex(patternIndex)
	state.pattern[pattern].enabled = enabled
end)

RegisterNetEvent("ARMAELS:vehicleRemoved", function(netId)
	local state = SavedVehicles[netId]

	if state then VehicleLeftScope(netId, state) end

	SavedVehicles[netId] = nil
end)

RegisterNetEvent("ARMAELS:indicatorChange", function(netId, indicator, enabled)
	if not NetworkDoesNetworkIdExist(netId) then return end

	local entity = NetworkGetEntityFromNetworkId(netId)
	if entity == 0 then return end

	if indicator == 1 then
		SetVehicleIndicatorLights(entity, 0, false)
		SetVehicleIndicatorLights(entity, 1, enabled)
	elseif indicator == 2 then
		SetVehicleIndicatorLights(entity, 0, enabled)
		SetVehicleIndicatorLights(entity, 1, false)
	end
end)

function GetSavedVehicleState(netId)
	local state = SavedVehicles[netId]

	if state then return state end

	state = {}
	state.stage = 0
	state.accurateLights = false

	state.siren = {}
	state.siren.tone = 0

	state.bullhorn = {}
	state.bullhorn.enabled = false

	state.pattern = {}
	state.pattern[`PRIMARY`] = {}
	state.pattern[`PRIMARY`].enabled = false
	state.pattern[`PRIMARY`].current = 1
	state.pattern[`PRIMARY`].updated = 0
	state.pattern[`PRIMARY`].stages = Config.Pattern[`PRIMARY`]

	state.pattern[`SECONDARY`] = {}
	state.pattern[`SECONDARY`].enabled = false
	state.pattern[`SECONDARY`].current = 1
	state.pattern[`SECONDARY`].updated = 0
	state.pattern[`SECONDARY`].stages = Config.Pattern[`SECONDARY`]

	state.pattern[`WARNING`] = {}
	state.pattern[`WARNING`].enabled = false
	state.pattern[`WARNING`].current = 1
	state.pattern[`WARNING`].updated = 0
	state.pattern[`WARNING`].stages = Config.Pattern[`WARNING`]

	if NetworkDoesEntityExistWithNetworkId(netId) then
		state.entity = NetworkGetEntityFromNetworkId(netId)
		LoadConfigurationIntoState(state)
	end

	SavedVehicles[netId] = state

	return state
end

function GetSavedVehicleStateUsingEntity(entity)
	local netId = NetworkGetNetworkIdFromEntity(entity)

	if netId == 0 then return nil end

	return GetSavedVehicleState(netId)
end

function DoesVehicleStateExist(netId)
	if SavedVehicles[netId] then
		return true
	else
		return false
	end
end

function DoesVehicleStateExistUsingEntity(entity)
	local netId = NetworkGetNetworkIdFromEntity(entity)

	if netId == 0 then return false end

	return DoesVehicleStateExist(netId)
end

function CheckVehicleStates()
	for k, v in pairs(EnabledVehicles) do
		if not DoesEntityExist(v) then
			VehicleLeftScope(k, SavedVehicles[k])
		end
	end

	for k, v in pairs(SavedVehicles) do
		if not EnabledVehicles[k] then
			if NetworkDoesEntityExistWithNetworkId(k) then
				VehicleEnteredScope(k, v)
			end
		end
	end
end

function VehicleEnteredScope(netId, state)
	local entity = NetworkGetEntityFromNetworkId(netId)

	if entity == 0 then return end

	EnabledVehicles[netId] = entity

	state.entity = entity

	if not state.config then
		LoadConfigurationIntoState(state)
	end

	SetVehicleAutoRepairDisabled(entity, true)
	SetVehicleHasMutedSirens(entity, true)

	for patternName, _ in pairs(Config.Pattern) do
		if state.pattern[patternName].enabled then
			SetVehicleSiren(entity, true)
		end
	end

	if state.siren.tone ~= 0 and not state.siren.handle then
		Controller.OnSirenChange(state)
	end
end

function VehicleLeftScope(netId, state)
	EnabledVehicles[netId] = nil

	if state.siren.tone ~= 0 and state.siren.handle then
		StopSound(state.siren.handle)
		ReleaseSoundId(state.siren.handle)
		state.siren.handle = nil
		state.siren.selected = nil
	end

	if state.bullhorn.enabled and state.bullhorn.handle then
		StopSound(state.bullhorn.handle)
		ReleaseSoundId(state.bullhorn.handle)
		state.bullhorn.handle = nil
		state.bullhorn.enabled = false
	end

	state.entity = nil
end

function LoadConfigurationIntoState(state)
	state.config = VehicleConfigs[GetEntityModel(state.entity)]

	local primary = state.config.pattern[`PRIMARY`]
	if primary then
		state.pattern[`PRIMARY`].stages = primary
	end

	local secondary = state.config.pattern[`SECONDARY`]
	if secondary then
		state.pattern[`SECONDARY`].stages = secondary
	end

	local warning = state.config.pattern[`WARNING`]
	if warning then
		state.pattern[`WARNING`].stages = warning
	end
end

function GetIndexFromPattern(pattern)
	if pattern == `PRIMARY` then
		return 1
	elseif pattern == `SECONDARY` then
		return 2
	elseif pattern == `WARNING` then
		return 3
	end
end

function GetPatternFromIndex(index)
	if index == 1 then
		return `PRIMARY`
	elseif index == 2 then
		return `SECONDARY`
	elseif index == 3 then
		return `WARNING`
	end
end

function GetPatternNameFromPattern(hash)
	if hash == `PRIMARY` then
		return "PRIMARY"
	elseif hash == `SECONDARY` then
		return "SECONDARY"
	elseif hash == `WARNING` then
		return "WARNING"
	end
end

exports("DoesVehicleHaveLightsEnabled", function(vehicle)
	if DoesVehicleStateExistUsingEntity(vehicle) then
		local state = GetSavedVehicleStateUsingEntity(vehicle)
		if state then
			for _, pattern in pairs(state.pattern) do
				if pattern.enabled then
					return true
				end
			end
		end
	end
	return false
end)

exports("DoesVehicleHaveConfig", function(vehicle)
	local model = GetEntityModel(vehicle)
	if VehicleConfigs[model] then
		return true
	else
		return false
	end
end)