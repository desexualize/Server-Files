
function FNRcfgdrugsServer.IronGather()
  local user_id = vRP.getUserId({source})

  if user_id ~= nil and vRP.hasPermission({user_id, "iron.job"}) then
    local amount = 4
    local item = 1.00
    local new_weight = vRP.getInventoryWeight({user_id})+(item*amount)

    if new_weight > vRP.getInventoryMaxWeight({user_id}) then
      vRPclient.notify(source,{"~r~Not enough space in inventory."})
    else
      vRP.giveInventoryItem({user_id, 'ironore', 4, true})
    end

  else
    vRPclient.notify(source,{"~r~You do not have the correct license."})
  end
end

function FNRcfgdrugsServer.IronCanProcess()
  local user_id = vRP.getUserId({source})
  return vRP.hasPermission({user_id, "iron.job"}),
  vRP.getInventoryItemAmount({user_id, 'ironore'}) >= 4
end

function FNRcfgdrugsServer.IronDoneProcessing()
  local user_id = vRP.getUserId({source})
  if vRP.getInventoryItemAmount({user_id, 'ironore'}) >= 4 then
    vRP.tryGetInventoryItem({user_id, 'ironore', 4, false})
    vRP.giveInventoryItem({user_id, 'iron', 1, false})
  end
end

function FNRcfgdrugsServer.SellIronJob(amount)
 local user_id = vRP.getUserId({source})
 if vRP.tryGetInventoryItem({user_id,'iron', 1}) then
   local item = vRP.getInventoryItemAmount({user_id,'iron'})
   local amount2 = amount
   if user_id ~= nil  then
     if amount > amount2 then
       vRPclient.notify(source, {"~r~You do not have that much Iron Bars."})
       return
     end
     local price = 3000 * tonumber(amount) * 2
     vRP.giveMoney({user_id,price})
     vRPclient.notify(source, {"~g~Successfully sold " .. amount .. " Iron Bars for £" .. price})

   end
 end
end