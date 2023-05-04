
inMenu = true
local bank = 0
function setBankBalance (value)
    bank = value
    SendNUIMessage({event = 'updateBankbalance', banking = bank})
end

RegisterNetEvent("AQUA:initMoney")
AddEventHandler("AQUA:initMoney", function(bankMoney)
    setBankBalance(bankMoney)
end)

RegisterNUICallback("bank_transfer", function(data) 
    TriggerServerEvent("AQUA:bankTransfer", data.user_id, data.amount)
end)