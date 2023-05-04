local registration_number = "000AAA"

function tvRP.setRegistrationNumber(registration)
  registration_number = registration
end

function tvRP.getRegistrationNumber()
  return registration_number
end

-- function tvRP.getUserID()
--   local player = GetPlayerServerId(-1)
--   return player
-- end
