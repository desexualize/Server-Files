--[[------------------------------------------------------------------------------
  -- File         : /client/cl_main.lua
  -- Purpose      : Entrypoint for the script. Loads VCF XMLs and runs the main thread for all ELS vehicle.
  -- Variables    : Config - Contains the ELS configuration. VehicleConfigs - Dictionary (key: vehicle hash, value: vehicle VCF config).
--]]------------------------------------------------------------------------------

Config = {}
VehicleConfigs = nil
CurrentTime = 0
CurrentPed = 0
CurrentPosition = vector3(0.0, 0.0, 0.0)
CurrentVehicle = 0

Citizen.CreateThread(function()
	PerformInitialisation()
	while true do
		CurrentTime = GetGameTimer()
		ProcessCurrentVehicle()
		CheckVehicleStates()
		ProcessVehicleLights()
		Citizen.Wait(0)
	end
end)

function PerformInitialisation()
	local resourceName = GetCurrentResourceName()

	local config = LoadResourceFile(resourceName, "config.json")
	Config = json.decode(config)

	Config.Pattern = {}

	local primary = LoadResourceFile(resourceName, "patterns/primary.json")
	Config.Pattern[`PRIMARY`] = json.decode(primary)

	local secondary = LoadResourceFile(resourceName, "patterns/secondary.json")
	Config.Pattern[`SECONDARY`] = json.decode(secondary)

	local warning = LoadResourceFile(resourceName, "patterns/warning.json")
	Config.Pattern[`WARNING`] = json.decode(warning)

	local vcfs = LoadResourceFile(resourceName, "xmls/vcfs.json")
	vcfs = json.decode(vcfs)

	VehicleConfigs = {}

	for _, name in ipairs(vcfs) do
		local vcf = LoadResourceFile(resourceName, "xmls/vcf/" .. name .. ".xml")

		if vcf then
			local model = GetHashKey(name)
			if IsModelInCdimage(model) then
				local isSuccessful, errorMsg = pcall(function()
					local vehicleConfig, error = GetVehicleFromXML(vcf, name)
					if vehicleConfig then
						VehicleConfigs[model] = vehicleConfig
					else
						WriteLoadError(name, error)
					end
				end)

				if not isSuccessful then
					WriteLoadError(name, errorMsg)
				end
			else
				WriteLoadError(name, "Vehicle model does not exist in the game")
			end
		else
			WriteLoadError(name, "File does not exist")
		end
	end

	collectgarbage("collect")

	RequestScriptAudioBank("DLC_XSIRENS\\XSIRENS_ONE", false)
end

function WriteLoadError(name, message)
	--print(string.format("[ARMA ELS] Unable to load VCF for %s. %s.", name, message))
end

function ProcessCurrentVehicle()
	CurrentPed = PlayerPedId()
	CurrentPosition = GetEntityCoords(CurrentPed, true)
	CurrentVehicle = GetVehiclePedIsIn(CurrentPed, false)

	if CurrentVehicle == 0 then return end

	if not NetworkGetEntityIsNetworked(CurrentVehicle) then return end

	local isDriver = GetPedInVehicleSeat(CurrentVehicle, -1) == CurrentPed

	ProcessCivilianVehicle(isDriver)

	local model = GetEntityModel(CurrentVehicle)
	if not VehicleConfigs[model] then return end

	if isDriver then
		if IsEntityInWater(CurrentVehicle) and not IsThisModelABoat(model) then
			DisableCurrentVehicle()
			return
		end
	elseif GetPedInVehicleSeat(CurrentVehicle, 0) ~= CurrentPed then
		return
	end

	DisableControlAction(0, 81, true)
	DisableControlAction(0, 82, true)
	DisableControlAction(0, 83, true)
	DisableControlAction(0, 84, true)
	DisableControlAction(0, 85, true)

	SetVehRadioStation(CurrentVehicle, "OFF")
	SetVehicleRadioEnabled(CurrentVehicle, false)
	SetVehicleHasMutedSirens(CurrentVehicle, true)

	if GetLastInputMethod(0) then
		DisableControlAction(0, Config.Keyboard.StageChange, true)
		DisableControlAction(0, Config.Keyboard.Bullhorn, true)
		DisableControlAction(0, Config.Keyboard.Siren.ToneOne, true)
		DisableControlAction(0, Config.Keyboard.Siren.ToneTwo, true)
		DisableControlAction(0, Config.Keyboard.Siren.ToneThree, true)
		DisableControlAction(0, Config.Keyboard.Pattern.Primary, true)
		DisableControlAction(0, Config.Keyboard.Pattern.Secondary, true)
		DisableControlAction(0, Config.Keyboard.Pattern.Warning, true)

		if IsDisabledControlJustPressed(0, Config.Keyboard.StageChange) then
			OnKeyStageChange()
		end

		if IsDisabledControlJustPressed(0, Config.Keyboard.Bullhorn) and isDriver then
			OnKeyBullhorn(true)
		end

		if IsDisabledControlJustReleased(0, Config.Keyboard.Bullhorn) and isDriver then
			OnKeyBullhorn(false)
		end

		if IsDisabledControlJustPressed(0, Config.Keyboard.Siren.ToneOne) then
			OnKeySiren(1, true)
		end

		if IsDisabledControlJustReleased(0, Config.Keyboard.Siren.ToneOne) then
			OnKeySiren(0, false)
		end

		if IsDisabledControlJustPressed(0, Config.Keyboard.Siren.ToneTwo) then
			OnKeySiren(2, true)
		end

		if IsDisabledControlJustReleased(0, Config.Keyboard.Siren.ToneTwo) then
			OnKeySiren(0, false)
		end

		if IsDisabledControlJustPressed(0, Config.Keyboard.Siren.ToneThree) then
			OnKeySiren(3, true)
		end

		if IsDisabledControlJustReleased(0, Config.Keyboard.Siren.ToneThree) then
			OnKeySiren(0, false)
		end

		if IsDisabledControlJustPressed(0, Config.Keyboard.Siren.ToneFour) then
			OnKeySiren(4, true)
		end

		if IsDisabledControlJustReleased(0, Config.Keyboard.Siren.ToneFour) then
			OnKeySiren(0, false)
		end

		if IsDisabledControlJustPressed(0, Config.Keyboard.Pattern.Primary) then
			OnKeyPattern(`PRIMARY`)
		end

		if IsDisabledControlJustPressed(0, Config.Keyboard.Pattern.Secondary) then
			OnKeyPattern(`SECONDARY`)
		end

		if IsDisabledControlJustPressed(0, Config.Keyboard.Pattern.Warning) then
			OnKeyPattern(`WARNING`)
		end

	else
		DisableControlAction(0, Config.Controller.StageChange, true)
		DisableControlAction(0, Config.Controller.Bullhorn, true)
		DisableControlAction(0, Config.Controller.Siren.ToneOne, true)
		DisableControlAction(0, Config.Controller.Siren.ToneTwo, true)
		DisableControlAction(0, Config.Controller.Siren.ToneThree, true)

		if IsDisabledControlJustPressed(0, Config.Controller.StageChange) then
			OnKeyStageChange()
		end

		if IsDisabledControlJustPressed(0, Config.Controller.Bullhorn) and isDriver then
			OnKeyBullhorn(true)
		end

		if IsDisabledControlJustReleased(0, Config.Controller.Bullhorn) and isDriver then
			OnKeyBullhorn(false)
		end

		if IsDisabledControlJustPressed(0, Config.Controller.Siren.ToneOne) then
			OnKeySiren(1, true)
		end

		if IsDisabledControlJustReleased(0, Config.Controller.Siren.ToneOne) then
			OnKeySiren(0, false)
		end

		if IsDisabledControlJustPressed(0, Config.Controller.Siren.ToneTwo) then
			OnKeySiren(2, true)
		end

		if IsDisabledControlJustReleased(0, Config.Controller.Siren.ToneTwo) then
			OnKeySiren(0, false)
		end

		if IsDisabledControlJustPressed(0, Config.Controller.Siren.ToneThree) then
			OnKeySiren(3, true)
		end

		if IsDisabledControlJustReleased(0, Config.Controller.Siren.ToneThree) then
			OnKeySiren(0, false)
		end
	end
end

function ProcessCivilianVehicle(isDriver)
	if not GetLastInputMethod(0) or not isDriver then return end

	if IsControlJustPressed(0, Config.Keyboard.IndicatorLeft) then
		local indicator = GetVehicleIndicatorLights(CurrentVehicle)
		local enabled = not (indicator == 1)
		TriggerServerEvent("ARMAELS:indicatorChange", 1, enabled)
	end

	if IsControlJustPressed(0, Config.Keyboard.IndicatorRight) then
		local indicator = GetVehicleIndicatorLights(CurrentVehicle)
		local enabled = not (indicator == 2)
		TriggerServerEvent("ARMAELS:indicatorChange", 2, enabled)
	end
end

function ProcessVehicleLights()
	for k, v in pairs(EnabledVehicles) do
		local state = SavedVehicles[k]

		if #(GetEntityCoords(state.entity, true) - CurrentPosition) < 50.0 then
			state.accurateLights = true
		else
			state.accurateLights = false
		end

		SetVehicleAutoRepairDisabled(state.entity, true)
		SetVehicleHasMutedSirens(state.entity, true)

		Controller.CheckPatterns(state)
	end
end

function OnKeyStageChange()
	local state = GetSavedVehicleStateUsingEntity(CurrentVehicle)

	state.stage = state.stage + 1
	if state.stage == 3 then state.stage = 0 end

	Controller.OnStageChange(state)

	PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

	TriggerServerEvent("ARMAELS:changeStage", state.stage)

	if state.stage == 1 and IsAmbulanceSound(state.config.sounds.srnTone1.audioString) then
		Citizen.CreateThreadNow(PlayNineNineModeSound)
	end
end

function OnKeyBullhorn(enable)
	local state = GetSavedVehicleStateUsingEntity(CurrentVehicle)

	if not state.config.sounds.mainHorn or state.config.sounds.mainHorn.audioString == "" then return end

	if state.bullhorn.enabled == enable then return end

	state.bullhorn.enabled = enable

	Controller.OnBullhornChange(state)

	TriggerServerEvent("ARMAELS:toggleBullhorn", enable)
end

function OnKeySiren(tone, pressed)
	local state = GetSavedVehicleStateUsingEntity(CurrentVehicle)

	if state.stage == 0 then return end

	if GetSirenNameFromIndex(state, tone) == "UNUSED" then return end

	if not pressed and state.stage ~= 2 then return end

	if state.siren.tone == tone then tone = 0 end

	state.siren.tone = tone

	Controller.OnSirenChange(state)

	TriggerServerEvent("ARMAELS:toggleSiren", tone)

	if state.siren.tone ~= 0 then
		Citizen.CreateThreadNow(PlaySirenSwitchSound)
	end
end

function OnKeyPattern(patternName)
	local state = GetSavedVehicleStateUsingEntity(CurrentVehicle)

	local pattern = state.pattern[patternName]
	pattern.enabled = not pattern.enabled
	if not pattern.enabled then 
		Controller.OnPatternDisable(state, patternName)
	end

	PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

	local patternIndex = GetIndexFromPattern(patternName)
	TriggerServerEvent("ARMAELS:patternChange", patternIndex, pattern.enabled)
end

function DisableCurrentVehicle()
	local state = GetSavedVehicleStateUsingEntity(CurrentVehicle)

	if state.bullhorn.enabled then
		state.bullhorn.enabled = false
		Controller.OnBullhornChange(state)
		TriggerServerEvent("ARMAELS:toggleBullhorn", false)
	end

	if state.siren.tone ~= 0 or state.stage ~= 0 then
		state.stage = 0
		Controller.OnStageChange(state)
		TriggerServerEvent("ARMAELS:changeStage", 0)
	end
end

function PlayNineNineModeSound()
	while not RequestScriptAudioBank("DLC_ELSAUDIO\\ELSAUDIO_ONE") do
		Citizen.Wait(0)
	end

	PlaySoundFrontend(-1, "999sound", "dlc_elsaudio_sounds", false)
	Citizen.Wait(1000)

	ReleaseNamedScriptAudioBank("DLC_ELSAUDIO\\ELSAUDIO_ONE")
end

function PlaySirenSwitchSound()
	while not RequestScriptAudioBank("DLC_ELSAUDIO\\ELSAUDIO_ONE") do
		Citizen.Wait(0)
	end

	PlaySoundFrontend(-1, "sirenswitch", "dlc_elsaudio_sounds", false)
	Citizen.Wait(500)

	ReleaseNamedScriptAudioBank("DLC_ELSAUDIO\\ELSAUDIO_ONE")
end