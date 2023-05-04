local a = false
local b = 10.0
local c = false
AddTextEntry("WT_GNADE_FLSH", "Flashbang")
RegisterNetEvent("ARMA:flashbangExplode",function(coords)
    if #(coords - tARMA.getPlayerCoords()) <= b then
        explodeFlashbang(coords)
    end
end)
function explodeFlashbang(coords)
    AddExplosion(coords, 25, 0.0, 1.0, nil, true, true)
    playFlashbangParticles(coords)
    AnimpostfxPlay("Dont_tazeme_bro", 0, true)
    ShakeGameplayCam("HAND_SHAKE", 7.5)
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do
        Citizen.Wait(0)
    end
    TaskPlayAnim(tARMA.getPlayerPed(),"anim@heists@ornate_bank@thermal_charge","cover_eyes_intro",-8.0,-8.0,1000,50,8.0,0,0,0)
    RemoveAnimDict("anim@heists@ornate_bank@thermal_charge")
    Citizen.Wait(6000)
    AnimpostfxStop("Dont_tazeme_bro")
    StopGameplayCamShaking()
end
function playFlashbangParticles(coords)
    RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do
        Citizen.Wait(0)
    end
    UseParticleFxAsset("core")
    StartParticleFxLoopedAtCoord("ent_anim_paparazzi_flash",coords.x,coords.y,coords.z,0.0,0.0,0.0,25.0,false,false,        false,false)
    RemoveNamedPtfxAsset("core")
end
function func_checkForFlashbang()
    if not a then
        if GetSelectedPedWeapon(tARMA.getPlayerPed()) == GetHashKey("WEAPON_FLASHBANG") then
            a = true
        else
            a = false
        end
    else
        if IsPedShooting(tARMA.getPlayerPed()) and not c then
            c = true
            Citizen.CreateThread(function()
                Wait(100)
                local d = tARMA.getPlayerCoords()
                local e = GetClosestObjectOfType(d.x, d.y, d.z, b, "w_ex_flashbang", false, false, false)
                if e ~= 0 then
                    Wait(2500)
                    local f = GetEntityCoords(e)
                    AddExplosion(coords, 25, 0.0, 1.0, nil, true, true)
                    TriggerServerEvent("ARMA:flashbangThrown", f)
                end
            end)
            SetTimeout(5000,function()
                c = false
            end)
            a = false
        end
    end
end
tARMA.createThreadOnTick(func_checkForFlashbang)
