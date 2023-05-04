vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP") 

staffgroups = {
    {name = 'trialstaff', id = '975479944220143676'}, 
    {name = 'supportteam', id = '987027147103281272'}, 
    {name = 'moderator', id = '975480022670393406'}, 
    {name = 'srmoderator', id = '975480116257894481'},
    {name = 'administrator', id = '975480166316925000'},
    {name = 'senioradmin', id = '977244874963292181'},
    {name = 'headadmin', id = '977245256741421096'},
    {name = 'staffmanager', id = '987027508111228948'},
    {name = 'commanager', id = '987027308449759343'},
    {name = 'operationsmanager', id = '994724669880025138'},
    {name = 'dev', id = '975214629762515004'},
    {name = 'leaddev', id = '997386472866983946'},
    {name = 'founder', id = '975209143692570625'}}

RegisterServerEvent('GroupAI:staffperms')
AddEventHandler('GroupAI:staffperms', function(group)
    local source = source
    local user_id = vRP.getUserId({source})
    for k,v in pairs(staffgroups) do
        if v.name == group then
            exports["discord-roles2"]:isRolePresent(source,{v.id},function(hasRole)
                if hasRole == true then 
                    vRP.addUserGroup({user_id, v.name})
                    TriggerClientEvent("GMT:PlaySound", source, 1)
                    vRPclient.notify(source, {'~y~[Groups AI] ~g~Success, given groups'})
                else
                    TriggerClientEvent("GMT:PlaySound", source, 2)
                    vRPclient.notify(source, {'~r~[Groups AI] ~r~You are not this rank in discord.io/gmtuk'})
                end
            end)
        end
    end
end)