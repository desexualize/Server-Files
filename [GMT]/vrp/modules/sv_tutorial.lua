RegisterNetEvent('GMT:checkTutorial')
AddEventHandler('GMT:checkTutorial', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasGroup(user_id, 'TutorialDone') then
        TriggerClientEvent('GMT:startTutorial', source)
    end
end)

RegisterNetEvent('GMT:setCompledTutorial')
AddEventHandler('GMT:setCompledTutorial', function()
    local source = source
    local user_id = vRP.getUserId(source)
    vRP.addUserGroup(user_id, 'TutorialDone')
end)