RMenu.Add("cardev","mainmenu",RageUI.CreateMenu("", "", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(), "banners", "cardev"))
RMenu:Get("cardev", "mainmenu"):SetSubtitle("~b~Car Dev Menu")
RMenu.Add("cardev","vehiclemods",RageUI.CreateSubMenu(RMenu:Get("cardev", "mainmenu"),"","~b~Vehicle Mods",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight()))
RMenu.Add("cardev","vehiclemodindexes",RageUI.CreateSubMenu(RMenu:Get("cardev", "vehiclemods"),"","~b~Vehicle Mod Indexes",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight()))
RMenu.Add("cardev","extras",RageUI.CreateSubMenu(RMenu:Get("cardev", "mainmenu"),"","~b~Extras",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight()))
RMenu.Add("cardev","colours",RageUI.CreateSubMenu(RMenu:Get("cardev", "mainmenu"),"","~b~Colours",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight()))
local a = false
local b = false
local c = {"speed", "drift", "handling", "city", "airport"}
local d = {
    vector3(2370.8, 2856.58, 40.46),
    vector3(974.58, -3006.6, 5.9),
    vector3(1894.57, 3823.71, 31.98),
    vector3(-482.63, -664.24, 32.74),
    vector3(-1728.25, -2894.99, 13.94)
}
local e = 1
function tARMA.isCarDev()
    return a
end
local f = {
    [0] = "VMT_SPOILER",
    [1] = "VMT_BUMPER_F",
    [2] = "VMT_BUMPER_R",
    [3] = "VMT_SKIRT",
    [4] = "VMT_EXHAUST",
    [5] = "VMT_CHASSIS",
    [6] = "VMT_GRILL",
    [7] = "VMT_BONNET",
    [8] = "VMT_WING_L",
    [9] = "VMT_WING_R",
    [10] = "VMT_ROOF",
    [11] = "VMT_ENGINE",
    [12] = "VMT_BRAKES",
    [13] = "VMT_GEARBOX",
    [14] = "VMT_HORN",
    [15] = "VMT_SUSPENSION",
    [16] = "VMT_ARMOUR",
    [17] = "VMT_NITROUS",
    [18] = "VMT_TURBO",
    [19] = "VMT_SUBWOOFER",
    [20] = "VMT_TYRE_SMOKE",
    [21] = "VMT_HYDRAULICS",
    [22] = "VMT_XENON_LIGHTS",
    [23] = "VMT_WHEELS",
    [24] = "VMT_WHEELS_REAR_OR_HYDRAULICS",
    [25] = "VMT_PLTHOLDER",
    [26] = "VMT_PLTVANITY",
    [27] = "VMT_INTERIOR1",
    [28] = "VMT_INTERIOR2",
    [29] = "VMT_INTERIOR3",
    [30] = "VMT_INTERIOR4",
    [31] = "VMT_INTERIOR5",
    [32] = "VMT_SEATS",
    [33] = "VMT_STEERING",
    [34] = "VMT_KNOB",
    [35] = "VMT_PLAQUE",
    [36] = "VMT_ICE",
    [37] = "VMT_TRUNK",
    [38] = "VMT_HYDRO",
    [39] = "VMT_ENGINEBAY1",
    [40] = "VMT_ENGINEBAY2",
    [41] = "VMT_ENGINEBAY3",
    [42] = "VMT_CHASSIS2",
    [43] = "VMT_CHASSIS3",
    [44] = "VMT_CHASSIS4",
    [45] = "VMT_CHASSIS5",
    [46] = "VMT_DOOR_L",
    [47] = "VMT_DOOR_R",
    [48] = "VMT_LIVERY_MOD",
    [49] = "VMT_LIGHTBAR"
}
local g = {
    {name = "Black", colorindex = 0},
    {name = "White", colorindex = 112},
    {name = "Red", colorindex = 27},
    {name = "Orange", colorindex = 38},
    {name = "Yellow", colorindex = 88},
    {name = "Green", colorindex = 92},
    {name = "Blue", colorindex = 64},
    {name = "Pink", colorindex = 135},
    {name = "Purple", colorindex = 142}
}
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('cardev', 'mainmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if b and tARMA.getPlayerBucket() == 333 then
                RageUI.ButtonWithStyle("Spawn Vehicle (No Mods)","",{RightLabel = "→→→"},true,function(h, i, j)
                    if j then
                        tARMA.clientPrompt("Spawncode:","",function(k)
                            if k ~= "" and tARMA.getPlayerBucket() == 333 then
                                local l = tARMA.loadModel(k)
                                TriggerServerEvent("ARMA:logVehicleSpawn", k, "/cardev")
                                local m = tARMA.getPlayerCoords()
                                local n = tARMA.spawnVehicle(l,m.x,m.y,m.z,GetEntityHeading(tARMA.getPlayerPed()),true,true,true)
                                DecorSetInt(n, "ARMAACVeh", 955)
                                SetVehicleOnGroundProperly(n)
                                SetEntityInvincible(n, false)
                                SetPedIntoVehicle(tARMA.getPlayerPed(), n, -1)
                                SetModelAsNoLongerNeeded(l)
                                SetVehRadioStation(n, "OFF")
                                Wait(500)
                                SetVehRadioStation(n, "OFF")
                            end
                        end)
                    end
                end)
                RageUI.ButtonWithStyle("Spawn Vehicle (Full Mods)","",{RightLabel = "→→→"},true,function(h, i, j)
                    if j then
                        tARMA.clientPrompt("Spawncode:","",function(k)
                            if k ~= "" and tARMA.getPlayerBucket() == 333 then
                                local l = tARMA.loadModel(k)
                                TriggerServerEvent("ARMA:logVehicleSpawn", k, "/cardev")
                                local m = tARMA.getPlayerCoords()
                                local n = tARMA.spawnVehicle(l,m.x,m.y,m.z,GetEntityHeading(tARMA.getPlayerPed()),true,true,true)
                                DecorSetInt(n, "ARMAACVeh", 955)
                                SetVehicleOnGroundProperly(n)
                                SetEntityInvincible(n, false)
                                SetVehicleModKit(n, 0)
                                SetVehicleMod(n, 11, 2, false)
                                SetVehicleMod(n, 13, 2, false)
                                SetVehicleMod(n, 12, 2, false)
                                SetVehicleMod(n, 15, 3, false)
                                ToggleVehicleMod(n, 18, true)
                                SetPedIntoVehicle(tARMA.getPlayerPed(), n, -1)
                                SetModelAsNoLongerNeeded(l)
                                SetVehRadioStation(n, "OFF")
                                Wait(500)
                                SetVehRadioStation(n, "OFF")
                            end
                        end)
                    end
                end)
                RageUI.ButtonWithStyle("Delete Vehicle","",{RightLabel = "→→→"},true,function(h, i, j)
                    if j then
                        local o = GetVehiclePedIsIn(tARMA.getPlayerPed(), false)
                        if NetworkGetEntityIsNetworked(o) then
                            local p = NetworkGetNetworkIdFromEntity(o)
                            if p ~= 0 then
                                DeleteEntity(aT)
                                --TriggerServerEvent("ARMA:cardevDeleteVehicle", p)
                            end
                        else
                            DeleteEntity(o)
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Fix Vehicle","",{RightLabel = "→→→"},true,function(h, i, j)
                    if j then
                        local q = tARMA.getPlayerPed()
                        if IsPedInAnyVehicle(q) then
                            local r = GetVehiclePedIsIn(q)
                            SetVehicleEngineHealth(r, 9999)
                            SetVehiclePetrolTankHealth(r, 9999)
                            SetVehicleFixed(r)
                        end
                    end
                end)
                RageUI.List("Teleport",c,e,nil,{},true,function(h, i, j, s)
                    e = s
                    if j then
                        tARMA.teleport2(d[e], true)
                    end
                end,function()end)
                RageUI.ButtonWithStyle("Cycle through seats","",{RightLabel = "→→→"},true,function(h, i, j)
                    if j then
                        local q = tARMA.getPlayerPed()
                        if IsPedInAnyVehicle(q) then
                            local t = GetVehiclePedIsIn(q)
                            local u = GetVehicleModelNumberOfSeats(GetEntityModel(t))
                            for v = -1, u - 2 do
                                if IsVehicleSeatFree(t, v) then
                                    TaskWarpPedIntoVehicle(q, t, v)
                                    Wait(2000)
                                end
                            end
                        else
                            tAQUA.notify("~r~Not in a vehicle.")
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Vehicle Mods","",{RightLabel = "→→→"},true,function(h, i, j)
                    if j then
                        local q = tARMA.getPlayerPed()
                        if IsPedInAnyVehicle(q) then
                            local t = GetVehiclePedIsIn(q)
                        else
                            tAQUA.notify("~r~Not in a vehicle.")
                        end
                    end
                end,RMenu:Get("cardev", "vehiclemods"))
                RageUI.ButtonWithStyle("Vehicle Extras","",{RightLabel = "→→→"},true,function()
                end,RMenu:Get("cardev", "extras"))
                RageUI.ButtonWithStyle("Vehicle Colours","",{RightLabel = "→→→"},true,function()
                end,RMenu:Get("cardev", "colours"))
                RageUI.Checkbox("Return to normal Universe","",b,{},function()
                end,function()
                    b = true
                    TriggerServerEvent("ARMA:setCarDevMode", b)
                end,function()
                    b = false
                    TriggerServerEvent("ARMA:setCarDevMode", b)
                end)
            else
                RageUI.Checkbox("Teleport to Car Dev Universe","",b,{},function()end,
                function()
                    b = true
                    TriggerServerEvent("ARMA:setCarDevMode", b)
                end,function()
                    b = false
                    TriggerServerEvent("ARMA:setCarDevMode", b)
                end)
                RageUI.Separator("~g~Enter the Car Dev Universe to see more menu options.")
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('cardev', 'vehiclemods')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for w, x in pairs(f) do
                if GetNumVehicleMods(tARMA.getPlayerVehicle(), w) > 0 then
                    RageUI.ButtonWithStyle(x,"",{RightLabel = "→→→"},true,function(h, i, j)
                        if j then
                            selectedModType = w
                        end
                    end,RMenu:Get("cardev", "vehiclemodindexes"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('cardev', 'vehiclemodindexes')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if GetNumVehicleMods(tARMA.getPlayerVehicle(), selectedModType) == 0 then
                RageUI.Text({message = "~r~No available mod indexes for this mod type for this vehicle."})
            else
                for w = 0, GetNumVehicleMods(tARMA.getPlayerVehicle(), selectedModType) do
                    RageUI.ButtonWithStyle("Mod " .. w,"",{RightLabel = "→→→"},true,function(h, i, j)
                        if j then
                            SetVehicleModKit(tARMA.getPlayerVehicle(), 0)
                            SetVehicleMod(tARMA.getPlayerVehicle(), selectedModType, w)
                        end
                    end,RMenu:Get("cardev", "vehiclemodindexes"))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('cardev', 'extras')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            local r = tARMA.getPlayerVehicle()
            local y = false
            if r ~= 0 then
                for w = 1, 12 do
                    if DoesExtraExist(r, w) then
                        y = true
                        if IsVehicleExtraTurnedOn(r, w) then
                            RageUI.Button("Disable Extra " .. w,nil,{RightLabel = tostring(w)},true,function(h, i, j)
                                if j then
                                    SetVehicleExtra(r, w, true)
                                end
                            end)
                        else
                            RageUI.Button("Enable Extra " .. w,nil,{RightLabel = tostring(w)},true,function(h, i, j)
                                if j then
                                    SetVehicleExtra(r, w, false)
                                    TriggerEvent("ARMA:staffFixVehicle")
                                end
                            end)
                        end
                    end
                end
            end
            if not y then
                RageUI.Text({message = "~r~No available extras for this vehicle."})
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('cardev', 'colours')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for z, A in pairs(g) do
                RageUI.Button(A.name,nil,{},true,function(h, i, j)
                    if j then
                        SetVehicleColours(tARMA.getPlayerVehicle(), A.colorindex, A.colorindex)
                    end
                end)
            end
        end)
    end
end)

local function B()
    RageUI.Visible(RMenu:Get("cardev", "mainmenu"), not RageUI.Visible(RMenu:Get("cardev", "mainmenu")))
end
RegisterCommand("cardev",function(C)
    if a and not tARMA.isPurge() then
        B()
    end
end)
RegisterNetEvent("ARMA:setCarDev",function()
    a = true
end)
RegisterNetEvent("ARMA:setBucket",function(D)
    if b and D ~= 333 then
        RageUI.ActuallyCloseAll()
        b = false
    end
end)
local E = {
    {name = "fMass", type = "float"},
    {name = "fInitialDragCoeff", type = "float"},
    {name = "fDownforceModifier", type = "float"},
    {name = "fPercentSubmerged", type = "float"},
    {name = "vecCentreOfMassOffset", type = "vector"},
    {name = "vecInertiaMultiplier", type = "vector"},
    {name = "fDriveBiasFront", type = "float"},
    {name = "nInitialDriveGears", type = "integer"},
    {name = "fInitialDriveForce", type = "float"},
    {name = "fDriveInertia", type = "float"},
    {name = "fClutchChangeRateScaleUpShift", type = "float"},
    {name = "fClutchChangeRateScaleDownShift", type = "float"},
    {name = "fInitialDriveMaxFlatVel", type = "float"},
    {name = "fBrakeForce", type = "float"},
    {name = "fBrakeBiasFront", type = "float"},
    {name = "fHandBrakeForce", type = "float"},
    {name = "fSteeringLock", type = "float"},
    {name = "fTractionCurveMax", type = "float"},
    {name = "fTractionCurveMin", type = "float"},
    {name = "fTractionCurveLateral", type = "float"},
    {name = "fTractionSpringDeltaMax", type = "float"},
    {name = "fLowSpeedTractionLossMult", type = "float"},
    {name = "fCamberStiffnesss", type = "float"},
    {name = "fTractionBiasFront", type = "float"},
    {name = "fTractionLossMult", type = "float"},
    {name = "fSuspensionForce", type = "float"},
    {name = "fSuspensionCompDamp", type = "float"},
    {name = "fSuspensionReboundDamp", type = "float"},
    {name = "fSuspensionUpperLimit", type = "float"},
    {name = "fSuspensionLowerLimit", type = "float"},
    {name = "fSuspensionRaise", type = "float"},
    {name = "fSuspensionBiasFront", type = "float"},
    {name = "fAntiRollBarForce", type = "float"},
    {name = "fAntiRollBarBiasFront", type = "float"},
    {name = "fRollCentreHeightFront", type = "float"},
    {name = "fRollCentreHeightRear", type = "float"},
    {name = "fCollisionDamageMult", type = "float"},
    {name = "fWeaponDamageMult", type = "float"},
    {name = "fDeformationDamageMult", type = "float"},
    {name = "fEngineDamageMult", type = "float"},
    {name = "fPetrolTankVolume", type = "float"},
    {name = "fOilVolume", type = "float"},
    {name = "fSeatOffsetDistX", type = "float"},
    {name = "fSeatOffsetDistY", type = "float"},
    {name = "fSeatOffsetDistZ", type = "float"},
    {name = "nMonetaryValue", type = "integer"}
}
local F = {
    ["CCarHandlingData"] = {
        {name = "fBackEndPopUpCarImpulseMult", type = "float"},
        {name = "fBackEndPopUpBuildingImpulseMult", type = "float"},
        {name = "fBackEndPopUpMaxDeltaSpeed", type = "float"},
        {name = "fToeFront", type = "float"},
        {name = "fToeRear", type = "float"},
        {name = "fCamberFront", type = "float"},
        {name = "fCamberRear", type = "float"},
        {name = "fCastor", type = "float"},
        {name = "fEngineResistance", type = "float"},
        {name = "fMaxDriveBiasTransfer", type = "float"},
        {name = "fJumpForceScale", type = "float"},
        {name = "fIncreasedRammingForceScale", type = "float"}
    },
    ["CTrailerHandlingData"] = {
        {name = "fAttachLimitPitch", type = "float"},
        {name = "fAttachLimitRoll", type = "float"},
        {name = "fAttachLimitYaw", type = "float"},
        {name = "fUprightSpringConstant", type = "float"},
        {name = "fUprightDampingConstant", type = "float"},
        {name = "fAttachedMaxDistance", type = "float"},
        {name = "fAttachedMaxPenetration", type = "float"},
        {name = "fAttachRaiseZ", type = "float"},
        {name = "fPosConstraintMassRatio", type = "float"}
    },
    ["CBoatHandlingData"] = {
        {name = "fBoxFrontMult", type = "float"},
        {name = "fBoxRearMult", type = "float"},
        {name = "fBoxSideMult", type = "float"},
        {name = "fSampleTop", type = "float"},
        {name = "fSampleBottom", type = "float"},
        {name = "fSampleBottomTestCorrection", type = "float"},
        {name = "fAquaplaneForce", type = "float"},
        {name = "fAquaplanePushWaterMult", type = "float"},
        {name = "fAquaplanePushWaterCap", type = "float"},
        {name = "fAquaplanePushWaterApply", type = "float"},
        {name = "fRudderForce", type = "float"},
        {name = "fRudderOffsetSubmerge", type = "float"},
        {name = "fRudderOffsetForce", type = "float"},
        {name = "fRudderOffsetForceZMult", type = "float"},
        {name = "fWaveAudioMult", type = "float"},
        {name = "vecMoveResistance", type = "vector"},
        {name = "vecTurnResistance", type = "vector"},
        {name = "fLook_L_R_CamHeight", type = "float"},
        {name = "fDragCoefficient", type = "float"},
        {name = "fKeelSphereSize", type = "float"},
        {name = "fPropRadius", type = "float"},
        {name = "fLowLodAngOffset", type = "float"},
        {name = "fLowLodDraughtOffset", type = "float"},
        {name = "fImpellerOffset", type = "float"},
        {name = "fImpellerForceMult", type = "float"},
        {name = "fDinghySphereBuoyConst", type = "float"},
        {name = "fProwRaiseMult", type = "float"},
        {name = "fDeepWaterSampleBuoyancyMult", type = "float"},
        {name = "fTransmissionMultiplier", type = "float"},
        {name = "fTractionMultiplier", type = "float"}
    },
    ["CBikeHandlingData"] = {
        {name = "fLeanFwdCOMMult", type = "float"},
        {name = "fLeanFwdForceMult", type = "float"},
        {name = "fLeanBakCOMMult", type = "float"},
        {name = "fLeanBakForceMult", type = "float"},
        {name = "fMaxBankAngle", type = "float"},
        {name = "fFullAnimAngle", type = "float"},
        {name = "fDesLeanReturnFrac", type = "float"},
        {name = "fStickLeanMult", type = "float"},
        {name = "fBrakingStabilityMult", type = "float"},
        {name = "fInAirSteerMult", type = "float"},
        {name = "fWheelieBalancePoint", type = "float"},
        {name = "fStoppieBalancePoint", type = "float"},
        {name = "fWheelieSteerMult", type = "float"},
        {name = "fRearBalanceMult", type = "float"},
        {name = "fFrontBalanceMult", type = "float"},
        {name = "fBikeGroundSideFrictionMult", type = "float"},
        {name = "fBikeWheelGroundSideFrictionMult", type = "float"},
        {name = "fBikeOnStandLeanAngle", type = "float"},
        {name = "fBikeOnStandSteerAngle", type = "float"},
        {name = "fJumpForce", type = "float"}
    },
    ["CSubmarineHandlingData"] = {
        {name = "vTurnRes", type = "vector"},
        {name = "fMoveResXY", type = "float"},
        {name = "fMoveResZ", type = "float"},
        {name = "fPitchMult", type = "float"},
        {name = "fPitchAngle", type = "float"},
        {name = "fYawMult", type = "float"},
        {name = "fDiveSpeed", type = "float"},
        {name = "fRollMult", type = "float"},
        {name = "fRollStab", type = "float"}
    },
    ["CSpecialFlightHandlingData"] = {
        {name = "vecAngularDamping", type = "vector"},
        {name = "vecAngularDampingMin", type = "vector"},
        {name = "vecLinearDamping", type = "vector"},
        {name = "vecLinearDampingMin", type = "vector"},
        {name = "fLiftCoefficient", type = "float"},
        {name = "fCriticalLiftAngle", type = "float"},
        {name = "fInitialLiftAngle", type = "float"},
        {name = "fMaxLiftAngle", type = "float"},
        {name = "fDragCoefficient", type = "float"},
        {name = "fBrakingDrag", type = "float"},
        {name = "fMaxLiftVelocity", type = "float"},
        {name = "fMinLiftVelocity", type = "float"},
        {name = "fRollTorqueScale", type = "float"},
        {name = "fMaxTorqueVelocity", type = "float"},
        {name = "fMinTorqueVelocity", type = "float"},
        {name = "fYawTorqueScale", type = "float"},
        {name = "fSelfLevelingPitchTorqueScale", type = "float"},
        {name = "fInitalOverheadAssist", type = "float"},
        {name = "fMaxPitchTorque", type = "float"},
        {name = "fMaxSteeringRollTorque", type = "float"},
        {name = "fPitchTorqueScale", type = "float"},
        {name = "fSteeringTorqueScale", type = "float"},
        {name = "fMaxThrust", type = "float"},
        {name = "fTransitionDuration", type = "float"},
        {name = "fHoverVelocityScale", type = "float"},
        {name = "fStabilityAssist", type = "float"},
        {name = "fMinSpeedForThrustFalloff", type = "float"},
        {name = "fBrakingThrustScale", type = "float"},
        {name = "mode", type = "integer"}
    },
    ["CFlyingHandlingData"] = {
        {name = "fThrust", type = "float"},
        {name = "fThrustFallOff", type = "float"},
        {name = "fThrustVectoring", type = "float"},
        {name = "fInitialThrust", type = "float"},
        {name = "fInitialThrustFallOff", type = "float"},
        {name = "fYawMult", type = "float"},
        {name = "fYawStabilise", type = "float"},
        {name = "fSideSlipMult", type = "float"},
        {name = "fInitialYawMult", type = "float"},
        {name = "fRollMult", type = "float"},
        {name = "fRollStabilise", type = "float"},
        {name = "fInitialRollMult", type = "float"},
        {name = "fPitchMult", type = "float"},
        {name = "fPitchStabilise", type = "float"},
        {name = "fFormLiftMult", type = "float"},
        {name = "fAttackLiftMult", type = "float"},
        {name = "fAttackDiveMult", type = "float"},
        {name = "fGearDownDragV", type = "float"},
        {name = "fGearDownLiftMult", type = "float"},
        {name = "fWindMult", type = "float"},
        {name = "fMoveRes", type = "float"},
        {name = "vecTurnRes", type = "vector"},
        {name = "vecSpeedRes", type = "vector"},
        {name = "fGearDoorFrontOpen", type = "float"},
        {name = "fGearDoorRearOpen", type = "float"},
        {name = "fGearDoorRearOpen2", type = "float"},
        {name = "fGearDoorRearMOpen", type = "float"},
        {name = "fTurublenceMagnitudeMax", type = "float"},
        {name = "fTurublenceForceMulti", type = "float"},
        {name = "fTurublenceRollTorqueMulti", type = "float"},
        {name = "fTurublencePitchTorqueMulti", type = "float"},
        {name = "fBodyDamageControlEffectMult", type = "float"},
        {name = "fInputSensitivityForDifficulty", type = "float"},
        {name = "fOnGroundYawBoostSpeedPeak", type = "float"},
        {name = "fOnGroundYawBoostSpeedCap", type = "float"},
        {name = "fEngineOffGlideMulti", type = "float"},
        {name = "fAfterburnerEffectRadius", type = "float"},
        {name = "fAfterburnerEffectDistance", type = "float"},
        {name = "fAfterburnerEffectForceMulti", type = "float"},
        {name = "fSubmergeLevelToPullHeliUnderwater", type = "float"},
        {name = "fExtraLiftWithRoll", type = "float"}
    },
    ["CSeaPlaneHandlingData"] = {
        {name = "fLeftPontoonComponentId", type = "integer"},
        {name = "fRightPontoonComponentId", type = "integer"},
        {name = "fPontoonBuoyConst", type = "float"},
        {name = "fPontoonSampleSizeFront", type = "float"},
        {name = "fPontoonSampleSizeMiddle", type = "float"},
        {name = "fPontoonSampleSizeRear", type = "float"},
        {name = "fPontoonLengthFractionForSamples", type = "float"},
        {name = "fPontoonDragCoefficient", type = "float"},
        {name = "fPontoonVerticalDampingCoefficientUp", type = "float"},
        {name = "fPontoonVerticalDampingCoefficientDown", type = "float"},
        {name = "fKeelSphereSize", type = "float"}
    }
}
local G = E
local H = "CHandlingData"
local function I()
    return {
        speedBuffer = {},
        speed = 0.0,
        speedDisplay = 0.0,
        accel = 0.0,
        accelDisplay = 0.0,
        decel = 0.0,
        decelDisplay = 0.0
    }
end
local J = false
local K = I()
local function L()
    local r = tARMA.getPlayerVehicle()
    local M = GetEntitySpeed(r)
    table.insert(K.speedBuffer, M)
    if #K.speedBuffer > 100 then
        table.remove(K.speedBuffer, 1)
    end
    local N = 0.0
    local O = 0.0
    local P = 0
    local Q = 0
    for R, S in ipairs(K.speedBuffer) do
        if R > 1 then
            local T = S - K.speedBuffer[R - 1]
            if T > 0.0 then
                N = N + T
                P = P + 1
            else
                O = N + T
                Q = Q + 1
            end
        end
    end
    N = N / P
    O = O / Q
    K.speed = math.max(K.speed, M)
    K.speedDisplay = K.speed * 2.236936
    K.accel = math.max(K.accel, N)
    K.accelDisplay = K.accel * 60.0 * 2.236936
    K.decel = math.min(K.decel, O)
    K.decelDisplay = math.abs(K.decel) * 60.0 * 2.236936
end
local function U(V)
    local r = tARMA.getPlayerVehicle()
    if r == 0 then
        return "0.0"
    end
    if V.type == "float" then
        local W = GetVehicleHandlingFloat(r, H, V.name)
        return string.format("%.5f", W)
    elseif V.type == "integer" then
        local X = GetVehicleHandlingInt(r, H, V.name)
        return tostring(X)
    elseif V.type == "vector" then
        local Y = GetVehicleHandlingVector(r, H, V.name)
        return string.format("%.3f %.3f %.3f", Y.x, Y.y, Y.z)
    end
    return "INVALID"
end
local function Z()
    AddTextEntry("FMMC_MPM_NA", "Enter Value")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Value", "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(0)
    end
    if GetOnscreenKeyboardResult() then
        local _ = GetOnscreenKeyboardResult()
        if _ then
            return _
        end
    end
    return false
end
local function a0(V)
    local a1 = Z()
    if not a1 then
        notify("~r~Input cancelled.")
        return
    end
    local r = tARMA.getPlayerVehicle()
    if V.type == "float" then
        local a2 = tonumber(a1)
        if a2 then
            SetVehicleHandlingFloat(r, H, V.name, a2 + 0.0)
        else
            notify("~r~Can not parse float.")
        end
    elseif V.type == "integer" then
        local a2 = tonumber(a1)
        if a2 then
            SetVehicleHandlingInt(r, H, V.name, math.floor(a2))
        else
            notify("~r~Can not parse integer.")
        end
    elseif V.type == "vector" then
        local a3 = stringsplit(a1, " ")
        if a3 and #a3 >= 3 then
            local a4 = tonumber(a3[1])
            local a5 = tonumber(a3[2])
            local a6 = tonumber(a3[3])
            if a4 and a5 and a6 then
                SetVehicleHandlingVector(r, H, V.name, vector3(a4 + 0.0, a5 + 0.0, a6 + 0.0))
            else
                notify("~r~Can not parse vector.")
            end
        else
            notify("~r~Expected 3 floats.")
        end
    end
    ModifyVehicleTopSpeed(r, 1.0)
end
local function a7(a2)
    a2 = a2 * 10000.0
    return (a2 % 1.0 > 0.5 and math.ceil(a2) or math.floor(a2)) / 10000.0
end
local function a8()
    local a9 = ""
    local function aa(ab)
        if a9 ~= "" then
            a9 = a9 .. "\n\t\t\t"
        end
        a9 = a9 .. ab
    end
    local r = tARMA.getPlayerVehicle()
    for z, V in pairs(G) do
        if V.type == "float" then
            local a2 = GetVehicleHandlingFloat(r, H, V.name)
            aa(string.format('<%s value="%s" />', V.name, a7(a2)))
        elseif V.type == "integer" then
            local a2 = GetVehicleHandlingInt(r, H, V.name)
            aa(string.format('<%s value="%s" />', V.name, a2))
        elseif V.type == "vector" then
            local a2 = GetVehicleHandlingVector(r, H, V.name)
            aa(string.format('<%s x="%s" y="%s" z="%s" />', V.name, a2.x, a2.y, a2.z))
        end
    end
    tARMA.clientPrompt(
        "Output (CTRL+A, CTRL+C)",
        a9,
        function()
        end
    )
end
local function ac(ad)
    J = ad
    setCursor(ad and 1 or 0)
    inGUIARMA = ad
end
local function ae()
    if not b or tARMA.getPlayerBucket() ~= 333 then
        if J then
            ac(false)
        end
        return
    end
    L()
    local af = tARMA.getFontId("Akrobat-ExtraBold")
    local ag = J and 0.345 or 0.505
    DrawAdvancedTextNoOutline(ag,0.055,0.005,0.02,0.35,string.format("Top Speed: %.5f", K.speedDisplay),255,255,255,255,af,1)
    DrawAdvancedTextNoOutline(ag,0.075,0.005,0.02,0.35,string.format("Top Acceleration: %.5f", K.accelDisplay),255,255,255,255,af,1)
    DrawAdvancedTextNoOutline(ag,0.095,0.005,0.02,0.35,string.format("Top Deacceleration: %.5f", K.decelDisplay),255,255,255,255,af,1)
    local t = tARMA.getPlayerVehicle()
    DisableControlAction(0, 19, true)
    if t ~= 0 and IsDisabledControlJustPressed(0, 19) then
        ac(not J)
    end
    if not J then
        return
    elseif t == 0 then
        ac(false)
    end
    for R, V in pairs(G) do
        local ah = R > 23 and 1 or 0
        local ai = 0.14 + (R - ah * 23) * 0.0215
        local aj = CursorInArea(0.25 + ah * 0.27, 0.5 + ah * 0.27, ai, ai + 0.0215)
        local ak = aj and 100 or 255
        DrawAdvancedTextNoOutline(0.345 + ah * 0.27, ai, 0.005, 0.02, 0.35, V.name, ak, ak, 255, 255, af, 1)
        DrawAdvancedTextNoOutline(0.516 + ah * 0.231, ai + 0.001, 0.005, 0.02, 0.35, U(V), ak, ak, 255, 255, af, 1)
        if aj and IsDisabledControlJustPressed(0, 24) then
            Citizen.CreateThreadNow(function()
                a0(V)
            end)
        end
    end
    DrawRect(0.465, 0.415, 0.09, 0.495, 0, 0, 0, 100)
    DrawRect(0.695, 0.415, 0.09, 0.495, 0, 0, 0, 100)
    DrawRect(0.278, 0.14, 0.055, 0.02, 255, 255, 255, 230)
    DrawAdvancedTextNoOutline(0.346, 0.129, 0.005, 0.02, 0.24, "Copy Handling", 0, 0, 0, 255, 0, 1)
    if CursorInArea(0.25, 0.31, 0.12, 0.15) and IsDisabledControlJustPressed(0, 24) then
        a8()
    end
    DrawRect(0.338, 0.14, 0.055, 0.02, 255, 255, 255, 230)
    DrawAdvancedTextNoOutline(0.41, 0.129, 0.005, 0.02, 0.24, "Reset Stats", 0, 0, 0, 255, 0, 1)
    if CursorInArea(0.31, 0.37, 0.12, 0.15) and IsDisabledControlJustPressed(0, 24) then
        K = I()
        G = E
        H = "CHandlingData"
    end
    local R = 0
    for al, am in pairs(F) do
        local ah = R >= 4 and 1 or 0
        local ai = (R - ah * 4) * 0.125
        DrawRect(0.308 + ai, 0.685 + 0.05 * ah, 0.115, 0.02, 255, 255, 255, 230)
        DrawAdvancedTextNoOutline(0.403 + ai, 0.675 + 0.05 * ah, 0.005, 0.02, 0.24, al, 0, 0, 0, 255, 0, 0)
        if CursorInArea(0.2505 + ai, 0.3655 + ai, 0.665 + ah * 0.05, 0.705 + ah * 0.05) and IsDisabledControlJustPressed(0, 24) then
            G = am
            H = al
        end
        R = R + 1
    end
end
tARMA.createThreadOnTick(ae)
