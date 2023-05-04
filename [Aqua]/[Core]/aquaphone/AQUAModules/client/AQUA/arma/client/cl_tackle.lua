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
local b = false
local c = false
local d = "missmic2ig_11"
local e = "mic_2_ig_11_intro_goon"
local f = "mic_2_ig_11_intro_p_one"
local g = 0
local h = false
RegisterNetEvent("ARMA:setPoliceOnDuty",function(i)
    globalOnPoliceDuty = i
end)
RegisterNetEvent("ARMA:getTackled",function(k)
    c = true
    TriggerEvent("ARMA:startCombatTimer", false)
    local l = tARMA.getPlayerPed()
    local m = GetPlayerPed(GetPlayerFromServerId(k))
    RequestAnimDict(d)
    while not HasAnimDictLoaded(d) do
        Citizen.Wait(10)
    end
    AttachEntityToEntity(tARMA.getPlayerPed(),m,11816,0.25,0.5,0.0,0.5,0.5,180.0,false,false,false,false,2,false)
    TaskPlayAnim(l, d, f, 8.0, -8.0, 3000, 0, 0, false, false, false)
    RemoveAnimDict(d)
    Citizen.Wait(3000)
    DetachEntity(tARMA.getPlayerPed(), true, false)
    h = true
    Citizen.Wait(3000)
    h = false
    c = false
end)
function tARMA.isPedBeingTackled()
    return h
end
RegisterNetEvent("ARMA:playTackle",function()
    local l = tARMA.getPlayerPed()
    RequestAnimDict(d)
    while not HasAnimDictLoaded(d) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(l, d, e, 8.0, -8.0, 3000, 0, 0, false, false, false)
    RemoveAnimDict(d)
    Citizen.Wait(3000)
    b = false
end)
local function n()
    local o = 3.0
    local p = nil
    for q, r in ipairs(GetActivePlayers()) do
        if r ~= PlayerId() then
            local s = GetPlayerServerId(r)
            local t = tARMA.clientGetUserIdFromSource(s)
            local u = tARMA.getJobType(t)
            if u ~= "metpd" and u ~= "hmp" and u ~= "npas" then
                local v = GetEntityCoords(GetPlayerPed(r), true)
                local w = #(v - tARMA.getPlayerCoords())
                if w < o then
                    o = w
                    p = s
                end
            end
        end
    end
    return p
end
local function x()
    if globalOnCasinoDuty then
        return IsEntityInArea(PlayerPedId(),820.3699,-95.55496,69.97881,1009.161,88.39021,125.1955,false,false,0) or tARMA.getPlayerBucket() == 777
    else
        return false
    end
end
function func_tackleManagement()
    if h then
        SetPedToRagdoll(tARMA.getPlayerPed(), 1000, 1000, 0, 0, 0, 0)
    end
    if globalOnPoliceDuty or x() or tARMA.isStaffedOn() or globalOnPrisonDuty and globalPlayerInPrisonZone then
        if IsControlPressed(0, a["LEFTSHIFT"]) and IsControlPressed(0, a["G"]) then
            if not b and GetGameTimer() - g > 10 * 1000 and GetEntityHealth(PlayerPedId()) > 102 and not tARMA.isKnockedOut() then
                local y = n()
                if y then
                    if not b and not c and not IsPedInAnyVehicle(tARMA.getPlayerPed()) and not IsPedInAnyVehicle(GetPlayerPed(y)) then
                        b = true
                        g = GetGameTimer()
                        TriggerServerEvent("ARMA:tryTackle", y)
                    end
                end
            end
        end
    end
end
tARMA.createThreadOnTick(func_tackleManagement)
