local announceTables = {
    {permission = 'admin.managecommunitypot', info = {name = "Server Announcement", desc = "Make a Government announcement!"}, image = 'https://i.imgur.com/FZMys0F.png'},
    {permission = 'police.announce', info = {name = "PD Announcement", desc = "Make a Public PD Announcement"}, image = 'https://i.imgur.com/I7c5LsN.png'},
    {permission = 'hmp.announce', info = {name = "HMP Announcement", desc = "Make a Public HMP Announcement"}, image = 'https://i.imgur.com/MKcTwMq.png'},
    {permission = 'nhs.announce', info = {name = "NHS Announcement", desc = "Make a Public NHS Announcement"}, image = 'https://i.imgur.com/Jzu1TPS.png'},
    {permission = 'lfb.announce', info = {name = "LFB Announcement", desc = "Make a Public LFB Announcement"}, image = 'https://i.imgur.com/LWg6k2z.png'},
}

local function Has_Management_Permissions(user_id)
    if vRP.hasGroup(user_id, 'founder') then
        return true
    end

    if vRP.hasGroup(user_id, 'cofounder') then
        return true
    end
     
    if vRP.hasGroup(user_id, 'developer') then
        return true
    end
    
    if vRP.hasGroup(user_id, 'staffmanager') then
        return true
    end
    
    if vRP.hasGroup(user_id, 'commanager') then
        return true
    end
    
    return false
end

RegisterServerEvent("Nova:getAnnounceMenu")
AddEventHandler("Nova:getAnnounceMenu", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local hasPermsFor = {}
    for k, v in pairs(announceTables) do
        if vRP.hasPermission(user_id, v.permission) or Has_Management_Permissions(user_id) then
            table.insert(hasPermsFor, v.info)
        end
    end
    TriggerClientEvent('Nova:buildAnnounceMenu', source, hasPermsFor)
end)

RegisterServerEvent("Nova:serviceAnnounce")
AddEventHandler("Nova:serviceAnnounce", function(announceType)
    local source = source
    local user_id = vRP.getUserId(source)

    for k, v in pairs(announceTables) do
        local announce_name = v.info.name
        if announce_name == announceType then
            if vRP.hasPermission(user_id, v.permission) or Has_Management_Permissions(user_id) then
                vRP.prompt(source, "Input text to announce", "", function(source, data) 
                    vRPclient.announce(-1, {v.image, data}) 
                        vRPclient.notify(source, {"~g~Sending a " .. announce_name .. " with content ~b~" .. data})
                end)
            else
                -- ac ban
            end
        end
    end
end)