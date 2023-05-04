local cfg = {}

cfg.Buttons = {
    ["Ban"] = {function(self)
    local reason = nil
    local hours = nil
    AddTextEntry('FMMC_MPM_NC', "Enter Reason for Ban Player")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        if result then 
            reason = result
        end
    end
    AddTextEntry('FMMC_MPM_NC', "Enter Hours for Ban (-1 is perm ban)")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        if result then 
            hours = tonumber(result)
        end
    end
    TriggerServerEvent('vRPAdmin:Ban', self, hours, reason)
    end, "player.ban"},

    ["Kick"] = {function(self)
    AddTextEntry('FMMC_MPM_NC', "Enter Reason to Kick Player")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        if result then 
            result = result
            TriggerServerEvent('vRPAdmin:Kick', self, result, false)
        end
    end
    end, "player.kick"},

    ["Teleport player to Admin Island"] = {function(self)
        TriggerServerEvent('vRPAdmin:AdminTP', self)
    end, "player.tpto"},

    -- ["No Warning Kick"] = {function(self)
    --     AddTextEntry('FMMC_MPM_NC', "Enter Reason to Kick Player")
    --     DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
    --     while (UpdateOnscreenKeyboard() == 0) do
    --         DisableAllControlActions(0);
    --         Wait(0);
    --     end
    --     if (GetOnscreenKeyboardResult()) then
    --         local result = GetOnscreenKeyboardResult()
    --         if result then 
    --             result = result
    --             TriggerServerEvent('vRPAdmin:Kick', self, result, true)
    --         end
    --     end
    -- end, "player.kick"},
    ["Revive"] = {function(self)
        TriggerServerEvent('vRPAdmin:Revive', self)
    end, "player.revive"},
    ["Give Health"] = {function(self)
        TriggerServerEvent('vRPAdmin:Health', self)
    end, "player.revive"},
    ["Give Armour"] = {function(self)
        TriggerServerEvent('vRPAdmin:GiveArmour', self)
    end, "player.revive"},
    ["Kill Player"] = {function(self)
        TriggerServerEvent('vRPAdmin:SlapPlayer', self)
    end, "player.slap"},
    ["Spectate"] = {function(self)
        TriggerServerEvent('vRPAdmin:SpectatePlr', self)
    end, "player.spectate"},
    
    ["Add Car"] = {function(self)
        AddTextEntry('FMMC_MPM_NC', "Enter the car spawncode")
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            if result then 
                TriggerServerEvent('vRPAdmin:AddCar', self, result)
            end
        end
    end, "player.addcar"},




    ["TP To Player"] = {function(self)
        TriggerServerEvent('vRPAdmin:TPTo', self)
    end, "player.tpto"},
    ["Bring Player"] = {function(self)
        TriggerServerEvent('vRPAdmin:Bring', self)
    end, "player.tpbring"},
    ["Add Group"] = {function(self)
        AddTextEntry('FMMC_MPM_NC', "Enter the group name")
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            if result then 
                TriggerServerEvent('vRPAdmin:AddGroup', self, result)
            end
        end
    end, "player.addGroups"},
    ["Warn Player"] = {function(self)
        userWarningMessage = getWarningUserMsg()
        if userWarningMessage then
            TriggerServerEvent("vrp:warnPlayer",self,userWarningMessage)
        else
            tvRP.notify('Please enter a warning message!')
        end
    end, "player.warn"},
    ["Show Warnings"] = {function(self)
    ExecuteCommand("showwarnings "..tostring(self))
    end, "player.warn"},

}

--vRP:RemoveWarning
cfg.MiscButtons = {
    ["Remove Warning"] = {function(self)
        AddTextEntry('FMMC_MPM_NC', "Enter the WarningID")
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            if result then 
                TriggerServerEvent('vRP:RemoveWarning', result)
            end
        end
    end, "admin.removewarning", "Removes a warning"},

    ["TP to Waypoint"] = {function(self)
        TriggerEvent("TpToWaypoint")
    end, "player.tptowaypoint", "Teleports you to a waypoint"},
    ["Noclip Toggle"] = {function(self)
        noclipActive = not noclipActive

        if IsPedInAnyVehicle(PlayerPedId(), false) then
            noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
        else
            noclipEntity = PlayerPedId()
        end
    
        SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
        FreezeEntityPosition(noclipEntity, noclipActive)
        if noclipActive then
            SetEntityAlpha(noclipEntity, 50, false)
        else
            ResetEntityAlpha(noclipEntity)
        end
                    

    end, "player.noclip", "Teleports you to a waypoint"},


}
return cfg
