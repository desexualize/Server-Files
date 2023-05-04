purge = false
local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

RegisterCommand("purge", function(source,args,rawCommand)
    purge = not purge
    print(purge)
    TriggerServerEvent('AQUA:activatePurgeSV', purge)
end)

RegisterCommand("testgun", function(source,args,rawCommand)
    if purge then
        TriggerServerEvent('AQUA:purgeRespawn')
    end
end)


weapons = 
{ 
    "WEAPON_MOSIN",
    "WEAPON_HAWK",
    "WEAPON_PYTHON",
    "WEAPON_BERETTA",
    "WEAPON_M4A1",
    "WEAPON_M16A1",
    "WEAPON_PYTHON",
    "WEAPON_TEC9",
    "WEAPON_PP",
    "WEAPON_UMP45",
    "WEAPON_SAIGA",
    "WEAPON_SVD",
    "WEAPON_BORA",
    "WEAPON_GLOCK",
    "WEAPON_M13",
    "WEAPON_MP5",
    "WEAPON_REMINGTON870",
    "WEAPON_GOLDENDEAGLE",
    "WEAPON_MAC10",
    "WEAPON_OLYMPIA",
    "WEAPON_USPS",
    "WEAPON_AKM",
    "WEAPON_AKS74U",
    "WEAPON_MP7",
    "WEAPON_MP40",
    "WEAPON_VESPER",
    "WEAPON_WINCHESTER",
    "WEAPON_BROOM",
    "WEAPON_DILDO",
    "WEAPON_SHANK",
    "WEAPON_TOILETBRUSH",
    "WEAPON_AK200",
    "WEAPON_GOLDAK",
    "WEAPON_SPAR16",
    "WEAPON_MK1EMR",
    "WEAPON_MXM",
}

coords = 
{ 
    vector3(709.2013, -7.781747, 83.97376),
    vector3(774.7108, -47.44154, 80.686),
    vector3(819.0474, -15.83586, 80.63681),
    vector3(695.882, 22.82958, 84.19416),
    vector3(430.2242, 112.7517, 100.2736),
    vector3(230.2792, 176.0709, 105.284),
}


RegisterNetEvent("AQUA:activatePurge")
AddEventHandler("AQUA:activatePurge", function()
    purgeActivatingAnnounce = true
    TriggerEvent("AQUA:PlaySound", "purge")
    Wait(10000)
    purgeActivatingAnnounce = false
    purgeActivateAnnounce = true
    Wait(5000)
    purgeActivateAnnounce = false
    purgeActivated = true
end)




Citizen.CreateThread(function()
    while true do 
       if purgeActivatingAnnounce then
            PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
            BeginTextComponent("STRING")
            AddTextComponentString("~d~Purge is being activated!")
            EndTextComponent()
            PopScaleformMovieFunctionVoid()
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
            SetEntityInvincible(GetPlayerPed(-1), true)
            SetPlayerInvincible(PlayerId(), true)
            ClearPedBloodDamage(GetPlayerPed(-1))            
            ResetPedVisibleDamage(GetPlayerPed(-1))
            ClearPedLastWeaponDamage(GetPlayerPed(-1))
            SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
            SetEntityCanBeDamaged(GetPlayerPed(-1), false)
            SetPedCanRagdoll(GetPlayerPed(-1), true)
            SetEntityHealth(GetPlayerPed(-1), 200)
       elseif purgeActivateAnnounce then
            PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
            BeginTextComponent("STRING")
            AddTextComponentString("~d~Purge is now active!")
            EndTextComponent()
            PopScaleformMovieFunctionVoid()
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
       elseif purgeActivated then
            SetEntityInvincible(GetPlayerPed(-1), false)
            SetPlayerInvincible(PlayerId(), false)
            SetPedCanRagdoll(GetPlayerPed(-1), true)
            ClearPedLastWeaponDamage(GetPlayerPed(-1))
            SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
            SetEntityCanBeDamaged(GetPlayerPed(-1), true)
       end
       Citizen.Wait(0)
    end
end)





function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end 