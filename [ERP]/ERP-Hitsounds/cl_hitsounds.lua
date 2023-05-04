local function Bool(num) 
    return num == 1 or num == true
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


-- FYI you could have just asked and I would have Happily gave you this script....

local notplayingHeadshotSounds = true
AddEventHandler("gameEventTriggered", function(eventName, eventArguments)
    if not notplayingHeadshotSounds then return end
    local args = {}
    if eventName == "CEventNetworkEntityDamage" then
        local victimEntity, attackEntity, damage, _, _, fatalBool, weaponUsed, _, _, _, entityType = table.unpack(eventArguments)
        args = { victimEntity, attackEntity, fatalBool == 1, weaponUsed, entityType,
            math.floor(string.unpack("f", string.pack("i4", damage))) -- Convert ieee754 to a decimal/number
        }
        if (attackEntity == PlayerPedId()) and IsPedAPlayer(attackEntity) and IsPedAPlayer(victimEntity) and victimEntity ~= attackEntity and victimEntity ~= PlayerPedId() then
            local hit, vicBone = GetPedLastDamageBone(victimEntity)
            if headBones[vicBone] then
              SendNUIMessage({
                transactionType = "headshot",
              })
            else
              SendNUIMessage({
                transactionType = "bodyshot",
              })
            end
        end
    end
end)


RegisterNetEvent("hs:triggerSounds")
AddEventHandler("hs:triggerSounds", function()
    notplayingHeadshotSounds = not notplayingHeadshotSounds
    if notplayingHeadshotSounds then
    notify("~g~Hitsounds Enabled.")
    end
    if not notplayingHeadshotSounds then
        notify("~r~Hitsounds Disabled.")
    end
end)

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end


RegisterNetEvent("vrp:PlaySound")
AddEventHandler("vrp:PlaySound", function(soundname)

    SendNUIMessage({
        transactionType = soundname,
    })
    
end)