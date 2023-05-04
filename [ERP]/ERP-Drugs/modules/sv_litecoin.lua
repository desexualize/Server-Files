--[[Gather]]

function ElementDrugsSV.LitecoinGather()
    local user_id = vRP.getUserId({source})
    if user_id ~= nil and vRP.hasPermission({user_id, "LiteCoin.job"}) then
      local amount = 5
      local item = 1.0
      local new_weight = vRP.getInventoryWeight({user_id})+(item*amount)
      if new_weight > vRP.getInventoryMaxWeight({user_id}) then
        vRPclient.notify(source,{"~r~Not enough space in inventory."})
      else
        vRP.giveInventoryItem({user_id, 'litecoin', 1, true})
      end
    else
      vRPclient.notify(source,{"~r~You do not have the correct license."})
    end
end

function ElementDrugsSV.BitcoinGather()
  local user_id = vRP.getUserId({source})
  if user_id ~= nil and vRP.hasPermission({user_id, "Bitcoin.job"}) then
    local amount = 5.0
    local item = 1.0
    local new_weight = vRP.getInventoryWeight({user_id})+(item*amount)
    if new_weight > vRP.getInventoryMaxWeight({user_id}) then
      vRPclient.notify(source,{"~r~Not enough space in inventory."})
    else
      vRP.giveInventoryItem({user_id, 'Bitcoin', 1, true})
    end
  else
    vRPclient.notify(source,{"~r~You do not have the correct license."})
  end
end

--[[Sell]]

function ElementDrugsSV.SellLitecoin(amount)
  local user_id = vRP.getUserId({source})
  if vRP.tryGetInventoryItem({user_id,'litecoin', 1}) then

    local item = vRP.getInventoryItemAmount({user_id,'litecoin'})
    local amount2 = amount

    if user_id ~= nil then
      if amount > amount2 then
        vRPclient.notify(source, {"~r~You do not have that much Litecoin."})
        return
      end
      
      local price = 25000 * tonumber(amount)

      vRP.giveBankMoney({user_id,price})

      vRPclient.notify(source, {"~g~Successfully sold " .. amount .. " Litecoin for £" .. price})


    end
  else
   vRPclient.notify(source, {"~r~You do not have any Litecoin."})
  end
end

function ElementDrugsSV.SellBitcoin(amount)
local user_id = vRP.getUserId({source})
if vRP.tryGetInventoryItem({user_id,'Bitcoin', 1}) then

  local item = vRP.getInventoryItemAmount({user_id,'Bitcoin'})
  local amount2 = amount

  if user_id ~= nil then
    if amount > amount2 then
      vRPclient.notify(source, {"~r~You do not have that much Bitcoin."})
      return
    end
    
    local price = 30000 * tonumber(amount)
    vRP.giveBankMoney({user_id,price})
    vRPclient.notify(source, {"~g~Successfully sold " .. amount .. " Bitcoin for £" .. price})
  end
else
 vRPclient.notify(source, {"~r~You do not have any Bitcoin."})
end
end