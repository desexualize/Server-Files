local _Server = IsDuplicityVersion
local Register_Net_Event = RegisterNetEvent
local Add_Event_Handler = AddEventHandler
local Trigger_Server_Event = TriggerServerEvent
local Trigger_Event = TriggerEvent

if _Server() then
  _G.RegisterServerCallback = function(eventName, fn)
    assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got ' .. type(eventName))
    assert(type(fn) == 'function', 'Invalid Lua type at argument #2, expected function, got ' .. type(fn))

    Add_Event_Handler(('s__RIVAL_callback:%s'):format(eventName), function(cb, s, ...)
      local result = {fn(s, ...)}
      cb(table.unpack(result))
    end)
  end

  _G.TriggerClientCallback = function(eventName, src, ...)
    assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got ' .. type(eventName))
    assert(type(src) == 'number', 'Invalid Lua type at argument #2, expected number, got ' .. type(src))

    local p = promise.new()

    RegisterNetEvent('__RIVAL_callback:server:' .. eventName)
    local e = Add_Event_Handler('__RIVAL_callback:server:' .. eventName, function(...)
      local s = source
      if src == s then
        p:resolve({...})
      end
    end)

    TriggerClientEvent('__RIVAL_callback:client', src, eventName, ...)

    local result = Citizen.Await(p)
    RemoveEventHandler(e)
    return table.unpack(result)
  end

  RegisterNetEvent('__RIVAL_callback:server')
  Add_Event_Handler('__RIVAL_callback:server', function(eventName, ticket, ...)
    local s = source
    local p = promise.new()

    Trigger_Event('s__RIVAL_callback:' .. eventName, function(...)
      p:resolve({...})
    end, s, ...)

    local result = Citizen.Await(p)
    TriggerClientEvent(('__RIVAL_callback:client:%s:%s'):format(eventName, ticket), s, table.unpack(result))
  end)
else
  _G.TriggerServerCallback = function(eventName, ...)
    assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got ' .. type(eventName))

    local p = promise.new()
    local ticket = GetGameTimer()

    Register_Net_Event(('__RIVAL_callback:client:%s:%s'):format(eventName, ticket))
    local e = Add_Event_Handler(('__RIVAL_callback:client:%s:%s'):format(eventName, ticket), function(...)
      p:resolve({...})
    end)

    Trigger_Server_Event('__RIVAL_callback:server', eventName, ticket, ...)

    local result = Citizen.Await(p)
    RemoveEventHandler(e)

    return table.unpack(result)
  end

  _G.RegisterClientCallback = function(eventName, fn)
    assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got ' .. type(eventName))
    assert(type(fn) == 'function', 'Invalid Lua type at argument #2, expected function, got ' .. type(fn))

    Add_Event_Handler(('c__RIVAL_callback:%s'):format(eventName), function(cb, ...)
      cb(fn(...))
    end)
  end

  Register_Net_Event('__RIVAL_callback:client')
  Add_Event_Handler('__RIVAL_callback:client', function(eventName, ...)
    local p = promise.new()

    Trigger_Event(('c__RIVAL_callback:%s'):format(eventName), function(...)
      p:resolve({...})
    end, ...)

    local result = Citizen.Await(p)
    Trigger_Server_Event(('__RIVAL_callback:server:%s'):format(eventName), table.unpack(result))
  end)
end
