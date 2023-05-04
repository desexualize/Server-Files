local function Bool(num) 
    return num == 1 or num == true
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
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

RegisterCommand("hs", function()
    playHeadshotSounds = not playHeadshotSounds
    if playHeadshotSounds then
    notify("~w~Rust hitsounds are ~g~Enabled~w~.")
    end
    if not playHeadshotSounds then
        notify("~w~Rust hitsounds are ~r~Disabled~w~.")
    end
end)

Citizen.CreateThread(function ()
    while true do
        if playHeadshotSounds then
            local targeted, entity = GetEntityPlayerIsFreeAimingAt(GetPlayerIndex(), 0)
            if targeted then
                if IsPedShooting(PlayerPedId()) then
                    local hit, bone = GetPedLastDamageBone(entity)
                    hit = Bool(hit)
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
                        Wait(100)
                    end
                end
            end
        end
		Wait(0)
	end
end)