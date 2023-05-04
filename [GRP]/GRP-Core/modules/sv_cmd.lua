local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


RegisterCommand("a", function(source,args, rawCommand)
    user_id2 = vRP.getUserId({source})   

    local msg = rawCommand:sub(2)
    local playerName =  " ^7Staff Chat | " .. GetPlayerName(source)..": "
    local players = GetPlayers()
    for i,v in pairs(players) do 
        name = GetPlayerName(v)
        user_id = vRP.getUserId({v})   
        if vRP.hasPermission({user_id, "admin.menu"}) then

            TriggerClientEvent('chat:addMessage', v, {
                template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(0, 201, 0 , 0.4); border-radius: 4px;"><i class="fas fa-globe"></i>{0} {1}</div>',
                args = { playerName, msg }
            })
        else
            vRPclient.notify(source,{'You do not have staff.'})
        end
    end
end)