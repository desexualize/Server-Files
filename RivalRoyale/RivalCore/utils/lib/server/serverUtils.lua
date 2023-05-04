local offset = GetHashKey('CREATE_AUTOMOBILE')

function createVehicleFromServer(vehModel, coords, heading)
  if type(vehModel) ~= 'number' then
    vehModel = GetHashKey(vehModel)
  end

  return Citizen.InvokeNative(offset, vehModel, coords, heading)
end
