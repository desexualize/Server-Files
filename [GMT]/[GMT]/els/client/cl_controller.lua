--[[------------------------------------------------------------------------------
  -- File         : /client/cl_controller.lua
  -- Purpose      : Contains the functions for sirens, bullhorns and lights.
--]]------------------------------------------------------------------------------

local glm = require("glm")

Controller = {}

function Controller.CheckPatterns(state)
	local isAnyPatternEnabled = false

	if state.accurateLights then
		for i in pairs(state.config.extras) do
			SetVehicleExtra(state.entity, i, true)
		end
	end

	for _, pattern in pairs(state.pattern) do
		if pattern.enabled then
			isAnyPatternEnabled = true

			local currentStage = pattern.stages[pattern.current]

			if state.accurateLights then
				for i = 1, #currentStage.Extras do
					SetVehicleExtra(state.entity, currentStage.Extras[i], false)
				end
			end

			if CurrentTime - pattern.updated > currentStage.Milliseconds then
				pattern.current = pattern.current + 1
				if pattern.current > #pattern.stages then pattern.current = 1 end

				local nextStage = pattern.stages[pattern.current]
				Controller.MoveToPattern(state.entity, currentStage, nextStage)
				currentStage = nextStage

				pattern.updated = CurrentTime
			end

			if state.config.version == 1 then
				Controller.DrawGlobalLighting(state, currentStage)
			else
				Controller.DrawDirectionalLighting(state, currentStage)
			end
		end
	end

	if isAnyPatternEnabled then
		SetVehicleEngineOn(state.entity, true, true, false)
	end
end

function Controller.MoveToPattern(entity, last, new)
	for i = 1, #last.Extras do
		SetVehicleExtra(entity, last.Extras[i], true)
	end

	for i = 1, #new.Extras do
		SetVehicleExtra(entity, new.Extras[i], false)
	end
end

function Controller.DrawGlobalLighting(state, stage)
	for _, extra in ipairs(stage.Extras) do
		local config = state.config.extras[extra]
		local offset = GetOffsetFromEntityInWorldCoords(state.entity, config.offset.x, config.offset.y, config.offset.z)
		if config.colour == "red" then
			DrawLightWithRangeAndShadow(offset.x, offset.y, offset.z, 255, 0, 0, 50.0, 0.26, 1.0)
		elseif config.colour == "blue" then
			DrawLightWithRangeAndShadow(offset.x, offset.y, offset.z, 0, 15, 255, 50.0, 0.26, 1.0)
		elseif config.colour == "green" then
			DrawLightWithRangeAndShadow(offset.x, offset.y, offset.z, 0, 255, 0, 50.0, 0.26, 1.0)
		elseif config.colour == "amber" then
			DrawLightWithRangeAndShadow(offset.x, offset.y, offset.z, 255, 194, 0, 50.0, 0.26, 1.0)
		elseif config.colour == "white" then
			DrawLightWithRangeAndShadow(offset.x, offset.y, offset.z, 255, 255, 255, 50.0, 0.26, 1.0)
		end
		--DrawMarker(28, offset.x, offset.y, offset.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 0, 0, 255, false, false, 2, false, nil, nil, false)
	end
end

function Controller.DrawDirectionalLighting(state, stage)
	local forward, right, up, position = GetEntityMatrix(state.entity)
	local matrix = mat3x3(forward, right, up)
	for _, extra in ipairs(stage.Extras) do
		local lights = state.config.extras[extra]
		for _, light in ipairs(lights) do
			local offset = position + (right * light.offset.x) + (forward * light.offset.y) + (up * light.offset.z)
			local direction = glm.rotate(matrix, light.direction, up)[1]
			if light.colour == "red" then
				DrawSpotLight(offset.x, offset.y, offset.z, direction.x, direction.y, direction.z, 255, 0, 0, 60.0, 1.0, 0.0, 45.0, 100.0)
			elseif light.colour == "blue" then
				DrawSpotLight(offset.x, offset.y, offset.z, direction.x, direction.y, direction.z, 0, 15, 255, 60.0, 1.0, 0.0, 45.0, 100.0)
			elseif light.colour == "green" then
				DrawSpotLight(offset.x, offset.y, offset.z, direction.x, direction.y, direction.z, 0, 255, 0, 60.0, 1.0, 0.0, 45.0, 100.0)
			elseif light.colour == "amber" then
				DrawSpotLight(offset.x, offset.y, offset.z, direction.x, direction.y, direction.z, 255, 194, 0, 60.0, 1.0, 0.0, 45.0, 100.0)
			elseif light.colour == "white" then
				DrawSpotLight(offset.x, offset.y, offset.z, direction.x, direction.y, direction.z, 255, 255, 255, 60.0, 1.0, 0.0, 45.0, 100.0)
			end
			--DrawMarker(28, offset.x, offset.y, offset.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 0, 0, 255, false, false, 2, false, nil, nil, false)
		end
	end
end

function Controller.OnStageChange(state)
	if state.stage == 0 then
		state.pattern[`PRIMARY`].enabled = false
		Controller.OnPatternDisable(state, `PRIMARY`)

		state.pattern[`SECONDARY`].enabled = false
		Controller.OnPatternDisable(state, `SECONDARY`)

		state.pattern[`WARNING`].enabled = false
		Controller.OnPatternDisable(state, `WARNING`)

		state.siren.tone = 0
		Controller.OnSirenChange(state)

		SetVehicleSiren(state.entity, false)
	elseif state.stage == 1 then
		state.pattern[`PRIMARY`].enabled = true
		SetVehicleSiren(state.entity, true)
	end
end

function Controller.OnPatternDisable(state, patternName)
	local pattern = state.pattern[patternName]
	if not pattern.enabled then
		local disabled = {}
		for _, v in pairs(pattern.stages) do
			for i = 1, #v.Extras do
				local extra = v.Extras[i]
				if not disabled[extra] then
					SetVehicleExtra(state.entity, extra, true)
					disabled[extra] = true
				end
			end
		end
	end
end

function Controller.OnBullhornChange(state)
	if not state.entity then return end

	if state.bullhorn.enabled then
		if state.bullhorn.handle == nil then
			local soundName = state.config.sounds.mainHorn.audioString

			state.bullhorn.handle = GetSoundId()
			if IsCustomSound(soundName) then
				PlaySoundFromEntity(state.bullhorn.handle, soundName, state.entity, "DLC_XSIRENS_SOUNDSET", 0, 0)
			else
				PlaySoundFromEntity(state.bullhorn.handle, soundName, state.entity, 0, 0, 0)
			end
		end
	else
		if state.bullhorn.handle ~= nil then
			StopSound(state.bullhorn.handle)
			ReleaseSoundId(state.bullhorn.handle)
			state.bullhorn.handle = nil
		end
	end
end

function Controller.OnSirenChange(state)
	if not state.entity then return end

	if state.siren.tone ~= 0 then
		if state.siren.selected ~= state.siren.tone then
			if state.siren.handle ~= nil then
				StopSound(state.siren.handle)
				ReleaseSoundId(state.siren.handle)
			end

			local soundName = GetSirenNameFromIndex(state, state.siren.tone)

			state.siren.handle = GetSoundId()
			if IsCustomSound(soundName) then
				PlaySoundFromEntity(state.siren.handle, soundName, state.entity, "DLC_XSIRENS_SOUNDSET", 0, 0)
			else
				PlaySoundFromEntity(state.siren.handle, soundName, state.entity, 0, 0, 0)
			end
		end
	else
		if state.siren.handle ~= nil then
			StopSound(state.siren.handle)
			ReleaseSoundId(state.siren.handle)
			state.siren.handle = nil
		end
	end

	state.siren.selected = state.siren.tone
end

function GetSirenNameFromIndex(state, index)
	if index == 1 then
		return state.config.sounds.srnTone1.audioString
	elseif index == 2 then
		return state.config.sounds.srnTone2.audioString
	elseif index == 3 then
		return state.config.sounds.srnTone3.audioString
	elseif index == 4 then
		return state.config.sounds.srnTone4.audioString
	end
	return nil
end

function IsCustomSound(name)
	return string.match(name, "siren_met") or IsAmbulanceSound(name)
end

function IsAmbulanceSound(name)
	return string.match(name, "siren_nhs")
end