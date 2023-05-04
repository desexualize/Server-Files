local shield = {
    active = false,
    id = 0,
    prop = 0,
    inVehicle = false,
}

local shieldTypes = ""
Citizen.CreateThread(function()
    for k, v in pairs(shields) do
        if shieldTypes == "" then
            shieldTypes = v.name
        else
            shieldTypes = shieldTypes..", "..v.name
        end
    end
    TriggerEvent('chat:addSuggestion', "/"..main.commandName, main.commandChatSuggestion, {
        { name=main.parameterType, help=tostring(shieldTypes) },
    })
    while true do
        if shield.active then
            local ped = PlayerPedId()
            
            if IsPedInAnyVehicle(ped, true) then
                if not shield.inVehicle then
                    SetEntityCollision(shield.prop, false, true)
                    shield.inVehicle = true
                end
            else
                if shield.inVehicle then
                    SetEntityCollision(shield.prop, shields[shield.id].collision, true)
                    shield.inVehicle = false
                end
            end
            if not shield.inVehicle then
                if shields[shield.id] ~= nil and shields[shield.id].animDict ~= nil and shields[shield.id].animName ~= nil then
                    if not IsEntityPlayingAnim(ped, shields[shield.id].animDict, shields[shield.id].animName, 3) then
                        TaskPlayAnim(ped, shields[shield.id].animDict, shields[shield.id].animName, 8.0, -8.0, -1, 50, 0.0, 0, 0, 0)
                    end
                end
                
            end
        end
        Wait(0)
    end
end)

function showNotification(message)
    message = message.."."
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end

RegisterNetEvent('Client:toggleShield')
AddEventHandler('Client:toggleShield', function(type)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle ~= 0 and vehicle ~= nil then
        showNotification(translations.outsideVehicle) return
    end
    if shield.active then
        if type == nil then removeShield(true) return end
        createShield(type)
    else
        if type == nil then showNotification(translations.noArguments) return end
        createShield(type)
    end
end)

function removeShield(notify)
    if DoesEntityExist(shield.prop) then
        local ped = PlayerPedId()
        DetachEntity(shield.prop)
        DeleteEntity(shield.prop)
        shield.id = 0
        shield.active = false
        ClearPedTasks(ped)
        ClearPedTasksImmediately(ped)
        SetWeaponAnimationOverride(ped, GetHashKey("Default"))
        if notify then
            showNotification(translations.shieldRemoved)
        end
    end
end

function createShield(type)
    local found = false
    local id = 0
    for k, v in pairs(shields) do
        if v.name == type then
            found = true
            id = k
            break
        end
    end
    if not found then
        showNotification(translations.invalidShieldType) return
    end
    shield.id = id
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    if shield.active then removeShield(false) end
    RequestModel(shields[id].model)
    while not HasModelLoaded(shields[id].model) do Wait(0) end
    shield.prop = CreateObject(shields[id].model, coords.x, coords.y, coords.z, true, true, true)
    while not DoesEntityExist(shield.prop) do Wait(0) end
    if not shields[id].collision then
        SetEntityCollision(shield.prop, false, true)
    end
    SetWeaponAnimationOverride(ped, GetHashKey("Gang1H"))
    SetEnableHandcuffs(ped, false)
    RequestAnimDict(shields[id].animDict)
    while not HasAnimDictLoaded(shields[id].animDict) do Wait(0) end
    TaskPlayAnim(ped, shields[id].animDict, shields[id].animName, 8.0, -8.0, -1, 50, 0.0, 0, 0, 0)
    local bone = GetPedBoneIndex(ped, shields[id].boneIndex)
    AttachEntityToEntity(shield.prop, ped, bone, shields[id].offSet[1], shields[id].offSet[2], shields[id].offSet[3], shields[id].rotation[1], shields[id].rotation[2], shields[id].rotation[3], true, true, shields[id].collision, false, 1, true)
    shield.active = true
end