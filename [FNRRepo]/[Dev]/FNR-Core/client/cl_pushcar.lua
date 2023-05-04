PushCarConfig = {}
PushCarConfig.DamageNeeded = 200.0
PushCarConfig.MaxWidth = 5.0
PushCarConfig.MaxHeight = 5.0
PushCarConfig.MaxLength = 5.0
local a = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}
function DrawText3DTest(b, c, d, e)
    local f, g, h = GetScreenCoordFromWorldCoord(b, c, d)
    local i, j, k = table.unpack(GetFinalRenderedCamCoord())
    if f then
        SetTextScale(0.2, 0.2)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        BeginTextCommandDisplayText("STRING")
        SetTextCentre(1)
        AddTextComponentSubstringPlayerName(e)
        EndTextCommandDisplayText(g, h)
    end
end
local l = nil
local function m(n)
    local o = -GetEntityForwardVector(n)
    local p = {"wheel_lr", "wheel_rr"}
    for q, r in ipairs(p) do
        local s = GetEntityBoneIndexByName(n, r)
        local t = GetWorldPositionOfEntityBone(n, s)
        local u = t + o * 2.0
        local v = StartExpensiveSynchronousShapeTestLosProbe(t.x, t.y, t.z, u.x, u.y, u.z, -1, n, 1)
        local w, x = GetShapeTestResult(v)
        if x == 1 then
            return true
        end
    end
    return false
end
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(5)
            local y = GetPlayerPed(-1)
            Vehicle = {Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil}
            l = GetVehiclePedIsIn(GetPlayerPed(-1), true)
            if l == nil then
                l = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
            end
            if l then
                local z = GetEntityCoords(l)
                local A = GetEntityCoords(l)
                local B = GetEntityCoords(GetPlayerPed(-1))
                local C = #(A - B)
                if
                    IsVehicleSeatFree(l, -1) and GetVehicleEngineHealth(l) <= PushCarConfig.DamageNeeded and
                        not IsEntityInWater(l)
                 then
                    if C < 10 then
                        DrawText3DTest(z.x, z.y, z.z, "Press [~g~SHIFT~w~] and [~g~E~w~] to push the vehicle")
                    end
                else
                    l = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
                end
                if
                    IsControlPressed(0, a["LEFTSHIFT"]) and GetEntityHealth(GetPlayerPed(-1)) > 102 and
                        IsVehicleSeatFree(l, -1) and
                        not IsEntityAttachedToEntity(y, l) and
                        IsControlJustPressed(0, a["E"]) and
                        GetVehicleEngineHealth(l) <= PushCarConfig.DamageNeeded
                 then
                    local A = GetEntityCoords(l)
                    local B = GetEntityCoords(GetPlayerPed(-1))
                    local C = #(A - B)
                    if C < 10 and not m(l) then
                        NetworkRequestControlOfEntity(l)
                        local z = GetEntityCoords(y)
                        if
                            #(GetEntityCoords(l) + GetEntityForwardVector(l) - GetEntityCoords(y)) >
                                #(GetEntityCoords(l) + GetEntityForwardVector(l) * -1 - GetEntityCoords(y))
                         then
                            Vehicle.IsInFront = false
                        else
                            Vehicle.IsInFront = true
                        end
                        local D = vector3(0.0, 0.0, 0.0)
                        local E = vector3(5.0, 5.0, 5.0)
                        Vehicle.Dimensions = GetModelDimensions(GetEntityModel(l), D, E)
                        if Vehicle.IsInFront then
                            AttachEntityToEntity(
                                GetPlayerPed(-1),
                                l,
                                GetPedBoneIndex(6286),
                                0.0,
                                Vehicle.Dimensions.y * -1 + 0.1,
                                Vehicle.Dimensions.z + 1.0,
                                0.0,
                                0.0,
                                180.0,
                                0.0,
                                false,
                                false,
                                true,
                                false,
                                true
                            )
                        else
                            AttachEntityToEntity(
                                GetPlayerPed(-1),
                                l,
                                GetPedBoneIndex(6286),
                                0.0,
                                Vehicle.Dimensions.y - 0.3,
                                Vehicle.Dimensions.z + 1.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                false,
                                false,
                                true,
                                false,
                                true
                            )
                        end
                        dict = "missfinale_c2ig_11"
                        RequestAnimDict(dict)
                        while not HasAnimDictLoaded(dict) do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(y, "missfinale_c2ig_11", "pushcar_offcliff_m", 2.0, -8.0, -1, 35, 0, 0, 0, 0)
                        Citizen.Wait(200)
                        local F = l
                        while true do
                            Citizen.Wait(5)
                            if IsDisabledControlPressed(0, a["A"]) then
                                TaskVehicleTempAction(GetPlayerPed(-1), F, 11, 1000)
                            end
                            if IsDisabledControlPressed(0, a["D"]) then
                                TaskVehicleTempAction(GetPlayerPed(-1), F, 10, 1000)
                            end
                            if Vehicle.IsInFront then
                                SetVehicleForwardSpeed(F, -1.0)
                            else
                                SetVehicleForwardSpeed(F, 1.0)
                            end
                            if HasEntityCollidedWithAnything(F) then
                                SetVehicleOnGroundProperly(F)
                            end
                            if not IsDisabledControlPressed(0, a["E"]) or IsEntityInWater(F) then
                                DetachEntity(y, false, false)
                                StopAnimTask(y, "missfinale_c2ig_11", "pushcar_offcliff_m", 2.0)
                                FreezeEntityPosition(y, false)
                                break
                            end
                        end
                    end
                end
            end
        end
    end
)
