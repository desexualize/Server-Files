local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "GroupMenu")
Groups = module("cfg/groups")


RegisterNetEvent('GroupMenu:Groups')
AddEventHandler('GroupMenu:Groups', function()
    local source = source
    local user_id = vRP.getUserId({source})
    local GroupsL = {}
 
    for i,v in pairs(Groups.groups) do 
        if vRP.hasGroup({user_id, "Scrap Job"}) then
            GroupsL["Scrap Job"] = true;
        end
        if vRP.hasGroup({user_id, "Tobaco"}) then
            GroupsL["Tobaco"] = true;
        end
        if vRP.hasGroup({user_id, "Weed"}) then
            GroupsL["Weed"] = true;
        end
        if vRP.hasGroup({user_id, "Gunsmith"}) then
            GroupsL["Gunsmith"] = true;
        end
        if vRP.hasGroup({user_id, "Heroin"}) then
            GroupsL["Heroin"] = true;
        end
        if vRP.hasGroup({user_id, "LSD"}) then
            GroupsL["LSD"] = true;
        end


        if vRP.hasPermission({user_id, "admin.tickets"}) then
            GroupsL["~y~[Galaxy Staff]"] = true;
        end




    end
    TriggerClientEvent('GroupMenu:ReturnGroups', source, GroupsL)
end)
