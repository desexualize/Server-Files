local currentPlayerInfo = {}

RegisterNetEvent("ARMA:receiveCurrentPlayerInfo")
AddEventHandler("ARMA:receiveCurrentPlayerInfo",function(playerInfo)
    currentPlayerInfo = playerInfo
end)

function tARMA.getCurrentPlayerInfo(z)
    for k,v in pairs(currentPlayerInfo) do
        if k == z then
            return v
        end
    end
end