local a = {}
a.initialized = true
local b = {}
local c = {}
Citizen.CreateThread(function()
	while a == nil or a.initialized == nil do
		Citizen.Wait(0)
	end
	c.stanceChangeCooldownRunning = false
	c.actionmode = false
	c.forcedActionmode = false
	c.timer = 0
	c.stanceChangeCooldown = function(d)
		c.stanceChangeCooldownRunning = true
		c.timer = d
	end
	c.initialized = true
	while true do
		if c.stanceChangeCooldownRunning then
			Citizen.Wait(c.timer)
			c.stanceChangeCooldownRunning = false
		else
			Citizen.Wait(0)
		end
	end
end)
Citizen.CreateThread(function()
	local e = tARMA.getPlayerPed()
	local f = GetPlayerIndex()
	local g = 3
	local h = 3
	local i = 1
	while a == nil or a.initialized == nil or c == nil or c.initialized == nil or b == nil or b.initialized == nil do
		Citizen.Wait(0)
	end
	local j = false
	local k = false
	local l = true
	local m = 500
	local n = true
	local o = false
	local p = 10.0
	local q = 0.2
	local r = 0.2
	local s = 0.35
	local t = false
	local u = true
	local v = false
	local w = 0.2
	local x = 0.0
	local y = 0.0
	local z = 0.5
	local A = 10.0
	local B = 10.0
	local C = false
	local D = false
	local E = 10.0
	local F = 10.0
	local function G(H)
		BeginTextCommandDisplayHelp("STRING")
		AddTextComponentSubstringPlayerName(H)
		EndTextCommandDisplayHelp(0, 0, 1, -1)
	end
	local function I()
		e = tARMA.getPlayerPed()
		f = GetPlayerIndex()
	end
	local function J(K)
		SetPedStealthMovement(e, K, "DEFAULT_ACTION")
		b.on = K
	end
	local function L(K)
		b.forced = K
	end
	local function M(K)
		SetPedUsingActionMode(e, K, -1, "DEFAULT_ACTION")
		c.actionmode = K
	end
	local function N(K)
		c.forcedActionmode = K
	end
	local function O()
		ResetPedMovementClipset(e, 0.55)
		ResetPedStrafeClipset(e)
		SetPedCanPlayAmbientAnims(e, true)
		SetPedCanPlayAmbientBaseAnims(e, true)
		ResetPedWeaponMovementClipset(e)
		J(false)
		L(true)
		M(false)
		N(true)
		if not u and g == 0 then
			g = 1
		end
		if not o and g == 1 then
			if C then
				g = 2
			else
				g = 3
			end
		end
		if not D and g == 2 then
			g = 3
		end
	end
	local function P()
		return IsDisabledControlJustReleased(0, 36)
	end
	local function Q(d)
		c.stanceChangeCooldown(d)
	end
	local function R()
		return c.stanceChangeCooldownRunning
	end
	local function S()
		if g == 0 or g == 2 then
			if g == 0 then
				i = 0
			else
				h = 2
			end
			g = g + 1
			return g
		else
			if g == 1 then
				i = g
				if C then
					g = 2
					return g
				else
					g = 3
					return g
				end
			else
				return g
			end
		end
	end
	local function T()
		if g == 2 then
			h = g
			g = 1
			return g
		else
			if g == 1 then
				if t then
					i = g
					g = 0
					return g
				else
					return g
				end
			else
				if g == 3 then
					h = g
					if C then
						g = 2
						return g
					end
					g = 1
					return g
				else
					return g
				end
			end
		end
	end
	local function U()
		if g == 1 then
			i = g
			g = h
			return g
		else
			if not g == 0 then
				h = g
				g = 1
				return g
			else
				i = g
				g = 1
				return g
			end
		end
	end
	local function V()
		O()
		J(false)
		L(true)
	end
	local function W()
		if IsPlayerFreeAiming(f) then
			SetPedMaxMoveBlendRatio(e, B)
			if l then
				J(true)
				L(true)
			else
				J(false)
				L(true)
			end
		else
			J(false)
			L(true)
			if IsAimCamActive() or IsAimCamThirdPersonActive() then
				SetPedMaxMoveBlendRatio(e, A)
			end
		end
	end
	local function X()
		J(true)
		L(true)
	end
	local function Y()
		if IsPlayerFreeAiming(f) then
			SetPedMaxMoveBlendRatio(e, F)
		else
			if IsAimCamActive() or IsAimCamThirdPersonActive() then
				SetPedMaxMoveBlendRatio(e, E)
			end
		end
	end
	local function Z()
		RequestAnimSet("move_ped_crouched")
		J(false)
		L(true)
		M(false)
		N(true)
		SetPedCanPlayAmbientAnims(e, false)
		SetPedCanPlayAmbientBaseAnims(e, false)
		while not HasAnimSetLoaded("move_ped_crouched") do
			Citizen.Wait(0)
			RequestAnimSet("move_ped_crouched")
		end
		SetPedMovementClipset(e, "move_ped_crouched", s)
		SetPedStrafeClipset(e, "move_ped_crouched_strafing")
		SetWeaponAnimationOverride(e, "Ballistic")
		RemoveAnimSet("move_ped_crouched")
	end
	local function _()
		if IsPlayerFreeAiming(f) then
			SetPedMaxMoveBlendRatio(e, q)
		else
			if IsAimCamActive() or IsAimCamThirdPersonActive() then
				SetPedMaxMoveBlendRatio(e, r)
			else
				SetPedMaxMoveBlendRatio(e, p)
			end
		end
	end
	local function a0()
		G("PLAYER PRONE")
	end
	local function a1()
		Citizen.Wait(G("PLAYER STILL PRONE"))
	end
	local function a2()
		if g == 3 then
			V()
		end
		if g == 2 then
			X()
		end
		if g == 1 then
			Z()
		end
		if g == 0 then
			a0()
		end
	end
	local function a3()
		if g == 3 then
			W()
		end
		if g == 2 then
			Y()
		end
		if g == 1 then
			_()
		end
		if g == 0 then
			a1()
		end
	end
	SetGameplayCamRelativeHeading(180.0)
	while true do
		SetPedDucking(e, true)
		Citizen.Wait(0)
		I()
		if n and P() and not noclipActive then
			if IsPedOnFoot(e) and not IsPedJumping(e) and not IsPedFalling(e) and not IsPlayerDead(f) then
				if not R() then
					Q(m)
					U()
					a2()
				else
					DisableControlAction(2, 36, true)
				end
				a3()
			else
				O()
			end
		end
	end
end)
Citizen.CreateThread(function()
	b.on = false
	b.forced = false
	b.initialized = true
	local e = tARMA.getPlayerPed()
	while a == nil or a.initialized == nil or c == nil or c.initialized == nil do
		Citizen.Wait(0)
	end
	while true do
		Citizen.Wait(0)
		if b.forced then
			SetPedStealthMovement(e, b.on, "DEFAULT_ACTION")
		end
		if c.forcedActionmode then
			SetPedUsingActionMode(e, c.actionmode, -1, "DEFAULT_ACTION")
		end
	end
end)
