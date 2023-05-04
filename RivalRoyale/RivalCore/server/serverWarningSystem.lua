WARNING_SYSTEM = {}

function WARNING_SYSTEM:insertWarning(player, warningType, warningAdmin, warningReason)
  if not player or not warningType or not warningAdmin or not warningReason then -- lol
    return
  end

  local warningDate = os.date('%Y/%m/%d')
  local query =
    ('INSERT INTO RIVAL_WARNINGS (UID, WarningType, WarningAdmin, WarningDate, WarningReason) VALUES (%s, "%s", "%s", "%s", "%s")'):format(
      player, warningType, warningReason, warningDate, warningAdmin)

  DATABASE:queryAsync(query)
end

function WARNING_SYSTEM:deleteWarning(player, warningId)
  if not player or not warningId then
    return
  end

  local query = ('DELETE FROM RIVAL_WARNINGS WHERE WHERE UID = %s AND ID = %s'):format(player, warningId)
  DATABASE:queryAsync(query)
end

function WARNING_SYSTEM:getWarnings(player)
  if not player then
    return
  end

  local query = ('SELECT * FROM RIVAL_WARNINGS WHERE UID = %s'):format(player)
  local warnings = DATABASE:queryResult(query)

  for warningId, warningData in pairs(warnings) do
    warningData.WarningDate = os.date('%Y-%m-%d', warningData.WarningDate)
  end

  return warnings
end

RegisterServerCallback('RIVAL::getWarnings', function(source)
  local player = RIVAL:getPlayer(source)
  local warnings = WARNING_SYSTEM:getWarnings(player)

  return warnings
end)
