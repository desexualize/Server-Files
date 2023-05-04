
inMenu = true
local bank = 0
function setBankBalance (value)
    bank = value
    SendNUIMessage({event = 'updateBankbalance', banking = bank})
end

RegisterNetEvent("ARMA:initMoney")
AddEventHandler("ARMA:initMoney", function(bankMoney)
    setBankBalance(bankMoney)
end)

RegisterNUICallback("bank_transfer", function(data) 
    TriggerServerEvent("ARMA:bankTransfer", data.user_id, data.amount)
end)