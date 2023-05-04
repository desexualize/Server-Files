local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end,
}

EnumerateEntities = function(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end

    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)

    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next

    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

EnumerateObjects = function()
  return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

EnumeratePeds = function()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

EnumerateVehicles = function()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

EnumeratePickups = function()
  return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end
