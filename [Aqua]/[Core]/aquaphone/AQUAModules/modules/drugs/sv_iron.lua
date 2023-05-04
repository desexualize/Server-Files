
function AQUAcfgdrugsServer.IronGather()
  local user_id = AQUA.getUserId({source})

  if user_id ~= nil and AQUA.hasPermission({user_id, "iron.job"}) then
    local amount = 4
    local item = 1.00
    local new_weight = AQUA.getInventoryWeight({user_id})+(item*amount)

    if new_weight > AQUA.getInventoryMaxWeight({user_id}) then
      AQUAclient.notify(source,{"~d~Not enough space in inventory."})
    else
      AQUA.giveInventoryItem({user_id, 'ironore', 4, true})
    end

  else
    AQUAclient.notify(source,{"~d~You do not have the correct license."})
  end
end

function AQUAcfgdrugsServer.IronCanProcess()
  local user_id = AQUA.getUserId({source})
  return AQUA.hasPermission({user_id, "iron.job"}),
  AQUA.getInventoryItemAmount({user_id, 'ironore'}) >= 4
end

function AQUAcfgdrugsServer.IronDoneProcessing()
  local user_id = AQUA.getUserId({source})
  if AQUA.getInventoryItemAmount({user_id, 'ironore'}) >= 4 then
    AQUA.tryGetInventoryItem({user_id, 'ironore', 4, false})
    AQUA.giveInventoryItem({user_id, 'iron', 1, false})
  end
end

function AQUAcfgdrugsServer.SellIronJob(amount)
 local user_id = AQUA.getUserId({source})
 if AQUA.tryGetInventoryItem({user_id,'iron', 1}) then
   local item = AQUA.getInventoryItemAmount({user_id,'iron'})
   local amount2 = amount
   if user_id ~= nil  then
     if amount > amount2 then
       AQUAclient.notify(source, {"~d~You do not have that much Iron Bars."})
       return
     end
     local price = 1500 * tonumber(amount) * 2
     AQUA.giveMoney({user_id,price})
     AQUAclient.notify(source, {"~g~Successfully sold " .. amount .. " Iron Bars for £" .. price})

   end
 end
end