RegisterServerEvent("DailyRewards")
AddEventHandler("DailyRewards", function(check, day, key)
  local source = source
  local user_id = AQUA.getUserId(source)
  local Money2Give = 0

  print(key, day)

  if key ~= "oy5a" then
    -- DropPlayer(source, "Don't Exploit Using Mod Menus, DUMB FUCK!")
    return
  end

  if day == "grind" then
    Money2Give = 300000
    exports['ghmattimysql']:execute("INSERT INTO aqua_user_vehicles (user_id, vehicle) VALUES(@user_id, @vehicle)", {user_id = user_id, vehicle = "sprinter2020"}, function() end)
    AQUA.addUserGroup(user_id, "Iron")
  elseif day == "day1" then
    Money2Give = 250000
  elseif day == "day2" then
    Money2Give = 500000
  elseif day == "day3" then
    Money2Give = 750000
  elseif day == "day5" then
    Money2Give = 1250000
  elseif day == "day10" then
    Money2Give = 2500000
    exports['ghmattimysql']:execute("INSERT INTO aqua_user_vehicles (user_id, vehicle) VALUES(@user_id, @vehicle)", {user_id = user_id, vehicle = "g63slammed"}, function() end)
  end

  if Money2Give > 2500000 then
    -- Ban Function Coming Soon...
    return
  else
    AQUA.giveBankMoney(user_id, Money2Give)
  end
end)


RegisterServerEvent("PlayerTime")
AddEventHandler("PlayerTime", function(check, day, key)
  local source = source
  local user_id = AQUA.getUserId(source)
  local Money2Give = 0

  print(key, day)

  if key ~= "xyAs8" then
    return
  end

  if day == "2hours" then
    Money2Give = 500000
  elseif day == "10hours" then
    Money2Give = 1000000
  elseif day == "24Hours" then
    Money2Give = 1500000
  elseif day == "72Hours" then
    Money2Give = 2500000
  elseif day == "1week" then
    Money2Give = 3250000
  end

  if Money2Give > 5000000 then
    
    return
  else
    AQUA.giveBankMoney(user_id, Money2Give)
  end
end)

