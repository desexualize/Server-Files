
RegisterNetEvent('__pmc_callback:client')
AddEventHandler('__pmc_callback:client', function(eventName, ...)
	local p = promise.new()

	TriggerEvent(('c__pmc_callback:%s'):format(eventName), function(...)
		p:resolve({...})
	end, ...)
	local result = Citizen.Await(p)
	TriggerServerEvent(('__pmc_callback:server:%s'):format(eventName), table.unpack(result))
end)

_G.TriggerServerCallback = function(eventName, ...)
	assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got '..type(eventName))
	local p = promise.new()
	local ticket = math.random(200) .. GetGameTimer() .. math.random(600)
	RegisterNetEvent(('__pmc_callback:client:%s:%s'):format(eventName, ticket))
	local e = AddEventHandler(('__pmc_callback:client:%s:%s'):format(eventName, ticket), function(...)
		p:resolve({...})
	end)
	TriggerServerEvent('__pmc_callback:server', eventName, ticket, ...)
	local result = Citizen.Await(p)
	repeat Wait(0) until result
	RemoveEventHandler(e)
	return table.unpack(result)
end

_G.RegisterClientCallback = function(eventName, fn)
	assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got '..type(eventName))
	assert(type(fn) == 'function', 'Invalid Lua type at argument #2, expected function, got '..type(fn))

	AddEventHandler(('c__pmc_callback:%s'):format(eventName), function(cb, ...)
		local results = fn(...)
		repeat Wait(0) until results ~= nil
		cb(results)
	end)
end
