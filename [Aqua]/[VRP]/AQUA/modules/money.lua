local lang = AQUA.lang

-- Money module, wallet/bank API
-- The money is managed with direct SQL requests to prevent most potential value corruptions
-- the wallet empty itself when respawning (after death)



MySQL.createCommand("AQUA/money_init_user","INSERT IGNORE INTO aqua_user_moneys(user_id,wallet,bank) VALUES(@user_id,@wallet,@bank)")
MySQL.createCommand("AQUA/get_money","SELECT wallet,bank FROM aqua_user_moneys WHERE user_id = @user_id")
MySQL.createCommand("AQUA/set_money","UPDATE aqua_user_moneys SET wallet = @wallet, bank = @bank WHERE user_id = @user_id")


-- load config
local cfg = module("cfg/money")

-- API

-- get money
-- cbreturn nil if error
function AQUA.getMoney(user_id)
  local tmp = AQUA.getUserTmpTable(user_id)
  if tmp then
    return tmp.wallet or 0
  else
    return 0
  end
end

-- set money
function AQUA.setMoney(user_id,value)
  local tmp = AQUA.getUserTmpTable(user_id)
  if tmp then
    tmp.wallet = value
  end

  -- update client display
  local source = AQUA.getUserSource(user_id)
  if source ~= nil then
    AQUAclient.setDivContent(source,{"money",lang.money.display({Comma(AQUA.getMoney(user_id))})})
  end
end

-- try a payment
-- return true or false (debited if true)
function AQUA.tryPayment(user_id,amount)
  local money = AQUA.getMoney(user_id)
  if amount >= 0 and money >= amount then
    AQUA.setMoney(user_id,money-amount)
    return true
  else
    return false
  end
end

function AQUA.tryBankPayment(user_id,amount)
  local bank = AQUA.getBankMoney(user_id)
  if amount >= 0 and bank >= amount then
    AQUA.setBankMoney(user_id,bank-amount)
    return true
  else
    return false
  end
end

-- give money
function AQUA.giveMoney(user_id,amount)
  local money = AQUA.getMoney(user_id)
  AQUA.setMoney(user_id,money+amount)
end

-- Give money with rad

RegisterServerEvent("AQUA:GiveMoney")
AddEventHandler("AQUA:GiveMoney", function()
  local player = source
  local user_id = AQUA.getUserId(player)
  if user_id ~= nil then
    AQUAclient.getNearestPlayer(player,{10},function(nplayer)
      if nplayer ~= nil then
        local nuser_id = AQUA.getUserId(nplayer)
        if nuser_id ~= nil then
          -- prompt number
          AQUA.prompt(player,lang.money.give.prompt(),"",function(player,amount)
            local amount = parseInt(amount)
            if amount > 0 and AQUA.tryPayment(user_id,amount) then
              AQUA.giveMoney(nuser_id,amount)
              AQUAclient.notify(player,{lang.money.given({amount})})
              AQUAclient.notify(nplayer,{lang.money.received({amount})})
              webhook = "https://discord.com/api/webhooks/1059085008037482496/dtSN5bO4HJJxnFWmRdtXm_3J_Lf3MbvQRt284nikhLnvC3wPm2cjDa9miLOuOY9Ep3Lm"
       
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "AQUA", embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Cash Given",
                            ["description"] = "**Sender Name: **" .. GetPlayerName(source) .. "** \nUser ID: **" .. user_id.. "** \nGave: **£" .. amount .. '**\nReciever ID: **' ..nuser_id,
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                    }
                }}), { ["Content-Type"] = "application/json" })
            else
              AQUAclient.notify(player,{lang.money.not_enough()})
            end
          end)
        else
          AQUAclient.notify(player,{lang.common.no_player_near()})
        end
      else
        AQUAclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end)

-- get bank money
function AQUA.getBankMoney(user_id)
  local tmp = AQUA.getUserTmpTable(user_id)
  if tmp then
    return tmp.bank or 0
  else
    return 0
  end
end

-- set bank money
function AQUA.setBankMoney(user_id,value)
  local tmp = AQUA.getUserTmpTable(user_id)
  if tmp then
    tmp.bank = value
  end
  local source = AQUA.getUserSource(user_id)
  if source ~= nil then
    AQUAclient.setDivContent(source,{"bmoney",lang.money.bdisplay({Comma(AQUA.getBankMoney(user_id))})})
  end
end

-- give bank money
function AQUA.giveBankMoney(user_id,amount)
  if amount > 0 then
    local money = AQUA.getBankMoney(user_id)
    AQUA.setBankMoney(user_id,money+amount)
  end
end

-- try a withdraw
-- return true or false (withdrawn if true)
function AQUA.tryWithdraw(user_id,amount)
  local money = AQUA.getBankMoney(user_id)
  if amount > 0 and money >= amount then
    AQUA.setBankMoney(user_id,money-amount)
    AQUA.giveMoney(user_id,amount)
    return true
  else
    return false
  end
end

-- try a deposit
-- return true or false (deposited if true)
function AQUA.tryDeposit(user_id,amount)
  if amount > 0 and AQUA.tryPayment(user_id,amount) then
    AQUA.giveBankMoney(user_id,amount)
    return true
  else
    return false
  end
end

-- try full payment (wallet + bank to complete payment)
-- return true or false (debited if true)
function AQUA.tryFullPayment(user_id,amount)
  local money = AQUA.getMoney(user_id)
  if money >= amount then -- enough, simple payment
    return AQUA.tryPayment(user_id, amount)
  else  -- not enough, withdraw -> payment
    if AQUA.tryWithdraw(user_id, amount-money) then -- withdraw to complete amount
      return AQUA.tryPayment(user_id, amount)
    end
  end

  return false
end

-- events, init user account if doesn't exist at connection
AddEventHandler("AQUA:playerJoin",function(user_id,source,name,last_login)
  MySQL.query("AQUA/money_init_user", {user_id = user_id, wallet = cfg.open_wallet, bank = cfg.open_bank}, function(affected)
    local tmp = AQUA.getUserTmpTable(user_id)
    if tmp then
      MySQL.query("AQUA/get_money", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then
          tmp.bank = rows[1].bank
          tmp.wallet = rows[1].wallet
        end
      end)
    end
  end)
end)

-- save money on leave
AddEventHandler("AQUA:playerLeave",function(user_id,source)
  -- (wallet,bank)
  local tmp = AQUA.getUserTmpTable(user_id)
  if tmp and tmp.wallet ~= nil and tmp.bank ~= nil then
    MySQL.execute("AQUA/set_money", {user_id = user_id, wallet = tmp.wallet, bank = tmp.bank})
  end
end)

-- save money (at same time that save datatables)
AddEventHandler("AQUA:save", function()
  for k,v in pairs(AQUA.user_tmp_tables) do
    if v.wallet ~= nil and v.bank ~= nil then
      MySQL.execute("AQUA/set_money", {user_id = k, wallet = v.wallet, bank = v.bank})
    end
  end
end)

-- money hud
AddEventHandler("AQUA:playerSpawn",function(user_id, source, first_spawn)
  Wait(500)
  if first_spawn and AQUAConfig.MoneyUiEnabled then
    -- add money display
    AQUAclient.setDiv(source,{"money",cfg.display_css,lang.money.display({Comma(AQUA.getMoney(user_id))})})
    AQUAclient.setDiv(source,{"bmoney",cfg.display_css,lang.money.bdisplay({Comma(AQUA.getBankMoney(user_id))})})
  end
end)

local function ch_give(player,choice)
  -- get nearest player
  local user_id = AQUA.getUserId(player)
  if user_id ~= nil then
    AQUAclient.getNearestPlayer(player,{10},function(nplayer)
      if nplayer ~= nil then
        local nuser_id = AQUA.getUserId(nplayer)
        if nuser_id ~= nil then
          -- prompt number
          AQUA.prompt(player,lang.money.give.prompt(),"",function(player,amount)
            local amount = parseInt(amount)
            if amount > 0 and AQUA.tryPayment(user_id,amount) then
              AQUA.giveMoney(nuser_id,amount)
              AQUAclient.notify(player,{lang.money.given({amount})})
              AQUAclient.notify(nplayer,{lang.money.received({amount})})
            else
              AQUAclient.notify(player,{lang.money.not_enough()})
            end
          end)
        else
          AQUAclient.notify(player,{lang.common.no_player_near()})
        end
      else
        AQUAclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end

-- add player give money to main menu
AQUA.registerMenuBuilder("main", function(add, data)
  local user_id = AQUA.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}
    choices[lang.money.give.title()] = {ch_give, lang.money.give.description()}

    add(choices)
  end
end)

function Comma(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end
