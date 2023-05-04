RegisterNetEvent('ERP:checkTutorial')
AddEventHandler('ERP:checkTutorial', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasGroup(user_id, 'TutorialDone') then
        TriggerClientEvent('ERP:startTutorial', source)
    end
end)

RegisterNetEvent('ERP:setCompledTutorial')
AddEventHandler('ERP:setCompledTutorial', function()
    local source = source
    local user_id = vRP.getUserId(source)
    vRP.addUserGroup(user_id, 'TutorialDone')
end)