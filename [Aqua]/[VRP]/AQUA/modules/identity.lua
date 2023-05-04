local htmlEntities = module("lib/htmlEntities")

local cfg = module("cfg/identity")
local lang = AQUA.lang

local sanitizes = module("cfg/sanitizes")

-- this module describe the identity system

-- init sql


MySQL.createCommand("AQUA/get_user_identity","SELECT * FROM aqua_user_identities WHERE user_id = @user_id")
MySQL.createCommand("AQUA/init_user_identity","INSERT IGNORE INTO aqua_user_identities(user_id,registration,phone,firstname,name,age) VALUES(@user_id,@registration,@phone,@firstname,@name,@age)")
MySQL.createCommand("AQUA/update_user_identity","UPDATE aqua_user_identities SET firstname = @firstname, name = @name, age = @age, registration = @registration, phone = @phone WHERE user_id = @user_id")
MySQL.createCommand("AQUA/get_userbyreg","SELECT user_id FROM aqua_user_identities WHERE registration = @registration")
MySQL.createCommand("AQUA/get_userbyphone","SELECT user_id FROM aqua_user_identities WHERE phone = @phone")



-- api

-- cbreturn user identity
function AQUA.getUserIdentity(user_id, cbr)
    local task = Task(cbr)
    if cbr then 
        MySQL.query("AQUA/get_user_identity", {user_id = user_id}, function(rows, affected)
            if #rows > 0 then 
              task({rows[1]})
            else 
               task({})
            end
        end)
    else 
        print('Mis usage detected! CBR Does not exist')
    end
end

-- cbreturn user_id by registration or nil
function AQUA.getUserByRegistration(registration, cbr)
  local task = Task(cbr)

  MySQL.query("AQUA/get_userbyreg", {registration = registration or ""}, function(rows, affected)
    if #rows > 0 then
      task({rows[1].user_id})
    else
      task()
    end
  end)
end

-- cbreturn user_id by phone or nil
function AQUA.getUserByPhone(phone, cbr)
  local task = Task(cbr)

  MySQL.query("AQUA/get_userbyphone", {phone = phone or ""}, function(rows, affected)
    if #rows > 0 then
      task({rows[1].user_id})
    else
      task()
    end
  end)
end

function AQUA.generateStringNumber(format) -- (ex: DDDLLL, D => digit, L => letter)
  local abyte = string.byte("A")
  local zbyte = string.byte("0")

  local number = ""
  for i=1,#format do
    local char = string.sub(format, i,i)
    if char == "D" then number = number..string.char(zbyte+math.random(0,9))
    elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
    else number = number..char end
  end

  return number
end

-- cbreturn a unique registration number
function AQUA.generateRegistrationNumber(cbr)
  local task = Task(cbr)

  local function search()
    -- generate registration number
    local registration = AQUA.generateStringNumber("DDDLLL")
    AQUA.getUserByRegistration(registration, function(user_id)
      if user_id ~= nil then
        search() -- continue generation
      else
        task({registration})
      end
    end)
  end

  search()
end

-- cbreturn a unique phone number (0DDDDD, D => digit)
function AQUA.generatePhoneNumber(cbr)
  local task = Task(cbr)

  local function search()
    -- generate phone number
    local phone = AQUA.generateStringNumber(cfg.phone_format)
    AQUA.getUserByPhone(phone, function(user_id)
      if user_id ~= nil then
        search() -- continue generation
      else
        task({phone})
      end
    end)
  end

  search()
end

-- events, init user identity at connection
AddEventHandler("AQUA:playerJoin",function(user_id,source,name,last_login)
  AQUA.getUserIdentity(user_id, function(identity)
    if identity == nil then
      AQUA.generateRegistrationNumber(function(registration)
        AQUA.generatePhoneNumber(function(phone)
          MySQL.execute("AQUA/init_user_identity", {
            user_id = user_id,
            registration = registration,
            phone = phone,
            firstname = cfg.random_first_names[math.random(1,#cfg.random_first_names)],
            name = cfg.random_last_names[math.random(1,#cfg.random_last_names)],
            age = math.random(25,40)
          })
        end)
      end)
    end
  end)
end)

-- city hall menu

local cityhall_menu = {name=lang.cityhall.title(),css={top="75px", header_color="rgba(0,125,255,0.75)"}}

local function ch_identity(player,choice)
  local user_id = AQUA.getUserId(player)
  if user_id ~= nil then
    AQUA.prompt(player,lang.cityhall.identity.prompt_firstname(),"",function(player,firstname)
      if string.len(firstname) >= 2 and string.len(firstname) < 50 then
        firstname = sanitizeString(firstname, sanitizes.name[1], sanitizes.name[2])
        AQUA.prompt(player,lang.cityhall.identity.prompt_name(),"",function(player,name)
          if string.len(name) >= 2 and string.len(name) < 50 then
            name = sanitizeString(name, sanitizes.name[1], sanitizes.name[2])
            AQUA.prompt(player,lang.cityhall.identity.prompt_age(),"",function(player,age)
              age = parseInt(age)
              if age >= 16 and age <= 150 then
                if AQUA.tryPayment(user_id,cfg.new_identity_cost) then
                  AQUA.generateRegistrationNumber(function(registration)
                    AQUA.generatePhoneNumber(function(phone)

                      MySQL.execute("AQUA/update_user_identity", {
                        user_id = user_id,
                        firstname = firstname,
                        name = name,
                        age = age,
                        registration = registration,
                        phone = phone
                      })

                      -- update client registration
                      AQUAclient.setRegistrationNumber(player,{registration})
                      AQUAclient.notify(player,{lang.money.paid({cfg.new_identity_cost})})
                    end)
                  end)
                else
                  AQUAclient.notify(player,{lang.money.not_enough()})
                end
              else
                AQUAclient.notify(player,{lang.common.invalid_value()})
              end
            end)
          else
            AQUAclient.notify(player,{lang.common.invalid_value()})
          end
        end)
      else
        AQUAclient.notify(player,{lang.common.invalid_value()})
      end
    end)
  end
end

cityhall_menu[lang.cityhall.identity.title()] = {ch_identity,lang.cityhall.identity.description({cfg.new_identity_cost})}

local function cityhall_enter()
  local user_id = AQUA.getUserId(source)
  if user_id ~= nil then
    AQUA.openMenu(source,cityhall_menu)
  end
end

local function cityhall_leave()
  AQUA.closeMenu(source)
end


AddEventHandler("AQUA:playerSpawn",function(user_id, source, first_spawn)
  -- send registration number to client at spawn
  AQUA.getUserIdentity(user_id, function(identity)
    if identity then
      AQUAclient.setRegistrationNumber(source,{identity.registration or "000AAA"})
    end
  end)
end)

