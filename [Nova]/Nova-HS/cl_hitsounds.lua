local function Bool(num) 
    return num == 1 or num == true
end

function notify(string)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(string)
    EndTextCommandThefeedPostTicker(true, false)
end


local headBones = {
    [31086] = true --Head
}

local bodyBones = {
    [40269] = true, --Right Shoulder
    [28252] = true, --Right Arm
    [24818] = true, --Right Arm
    [45509] = true, --Left Shoulder
    [61163] = true, --Left Arm
    [10706] = true, --Left Arm
    [65245] = true, --Foot
    [63931] = true, --Leg
    [57597] = true, --Leg
    [58271] = true, --Leg
    [51826] = true, --Leg
    [36864] = true, --Leg
    [24816] = true, --Chest
    [24817] = true, --Chest
    [24819] = true, --Chest
    [14201] = true, --Foot
    [52301] = true, --Foot
    [18905] = true, --Hand
    [57005] = true, --Hand
    [39317] = true, --Neck
    [64729] = true, --Neck
}

local playHeadshotSounds = false
local function Head_Shot_Sounds_Enabled_Thread()
    Citizen.CreateThread(function()
        while playHeadshotSounds do
            local targeted, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
            if targeted then
                if IsPedShooting(PlayerPedId()) then
                    local hit, bone = GetPedLastDamageBone(entity)
                    if hit then
                        if headBones[bone] then
                            SendNUIMessage({
                                transactionType = "headshot",
                            })

                        elseif bodyBones[bone] then
                            SendNUIMessage({
                                transactionType = "bodyshot",
                            })
                        end

                        Citizen.Wait(100)
                    end
                end
            end
    
            Citizen.Wait(0)
        end
    end)
end

RegisterCommand("hs", function()
    playHeadshotSounds = not playHeadshotSounds
    TriggerEvent('Nova:SetHitSounds', playHeadshotSounds)
end)

RegisterNetEvent('Nova:SetHitSounds', function(bool_value)
    playHeadshotSounds = bool_value
    if playHeadshotSounds then
        notify("~w~Rust hitsounds are ~g~Enabled~w~")
        Head_Shot_Sounds_Enabled_Thread()
    else
        notify("~w~Rust hitsounds are ~r~Disabled~w~")
    end
end)

exports('Are_Hit_Sounds_Enabled', function()
    return playHeadshotSounds
end)

RegisterNetEvent("Nova:PlaySound")
AddEventHandler("Nova:PlaySound", function(sound_name)
    SendNUIMessage({
        type = 'play',
        transactionType = sound_name,
    })
end)