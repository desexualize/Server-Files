RegisterNetEvent('AQUA:checkTutorial')
AddEventHandler('AQUA:checkTutorial', function()
    local source = source
    local user_id = AQUA.getUserId(source)
    if not AQUA.hasGroup(user_id, 'TutorialCompleted') then
        print("Not Completed")
        TriggerClientEvent('AQUA:startTutorial', source)
    else
        
    end
end)

RegisterNetEvent('AQUA:setCompletedTutorial')
AddEventHandler('AQUA:setCompletedTutorial', function()
    local source = source
    local user_id = AQUA.getUserId(source)
    if not AQUA.hasGroup(user_id, 'TutorialCompleted') then
        AQUA.addUserGroup(user_id,'TutorialCompleted')
    end
end)