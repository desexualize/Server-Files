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
        if vRP.hasPermission({user_id, "admin.tickets"}) then
            GroupsL["~y~[ERP Staff]"] = true;
        end
        if vRP.hasGroup({user_id, "Garbage Job"}) then
            GroupsL["Garbage Job"] = true;
        end
        if vRP.hasGroup({user_id, "Weed"}) then
            GroupsL["Weed"] = true;
        end
        if vRP.hasGroup({user_id, "Diamond"}) then
            GroupsL["Diamond"] = true;
        end
        if vRP.hasGroup({user_id, "Heroin"}) then
            GroupsL["Heroin"] = true;
        end
        if vRP.hasGroup({user_id, "LSD"}) then
            GroupsL["LSD"] = true;
        end
        if vRP.hasGroup({user_id, "Bitcoin"}) then
            GroupsL["Bitcoin"] = true;
        end
        if vRP.hasGroup({user_id, "Litecoin"}) then
            GroupsL["Litecoin"] = true;
        end
        if vRP.hasGroup({user_id, "Gang"}) then
            GroupsL["Large Arms"] = true;
        end
        if vRP.hasGroup({user_id, "Rebel"}) then
            GroupsL["Rebel"] = true;
        end
    end
    TriggerClientEvent('GroupMenu:ReturnGroups', source, GroupsL)
end)
