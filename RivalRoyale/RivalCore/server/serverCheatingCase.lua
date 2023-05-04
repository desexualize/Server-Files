CHEATING_CASE = {}
CHEATING_CASE.cases = {}
CHEATING_CASE.alreadyReported = {}
CHEATING_CASE.activeReports = {}

function CHEATING_CASE:fetchCases(source)
  local player = RIVAL:getPlayer(source)
  local p = promise.new()

  -- Fetch all cases
  local query = ('SELECT * FROM rival_cases WHERE UID = %s'):format(player)
  local rows = DATABASE:queryResult(query)
  local leftCases = {}

  for _, caseData in pairs(rows) do
    -- Check if the player has already reviewed the case
    if CHEATING_CASE.cases[caseData.id] then
      if not CHEATING_CASE.cases[caseData.id][source] then
        leftCases[#leftCases + 1] = caseData
      end
    else
      leftCases[#leftCases + 1] = caseData
    end
  end

  -- Resolves the promise

  return leftCases
end

RegisterNetEvent('RIVAL::cheatingCase', function(suspect, reason)
  local source = source
  local currentReport = CHEATING_CASE.activeReports[suspect]

  if CHEATING_CASE.alreadyReported[suspect] then
    return
  end

  CHEATING_CASE.activeReports[suspect] = currentReport and currentReport + 1 or 1

  if CHEATING_CASE.activeReports[suspect] >= 3 then
    CHEATING_CASE.activeReports[suspect] = nil
    CHEATING_CASE.alreadyReported[suspect] = true

    -- Todo add a watch list if the player is offline
    local playerSource = RIVAL:getPlayerSource(suspect)

    -- Player is online
    if playerSource then
      TriggerClientEvent('RIVAL::captureStream', playerSource, {
        name = GetPlayerName(suspect),
        uid = suspect,
        reason = reason,
        reportedBy = GetPlayerName(source),
      })
    end
  end
end)

RegisterServerEvent('RIVAL::verifyOpinion', function(id, cheating)
  local source = source
  local player = RIVAL:getPlayer(source)
  local admin = RIVAL:getAdminLevel(player)

  if admin == 0 then
    return ANTICHEAT:banClient(player, 'Native Injection', 'Triggered event RIVAL::verifyOpinion without perms')
  end

  local currentCases = CHEATING_CASE.cases[id] or {}
  currentCases[source] = true
  CHEATING_CASE.cases[id] = currentCases

  if not ADMIN.recordings[id] then
    if cheating then
      ADMIN.recordings[id] = {evidence = 1, no_evidence = 0}
    else
      ADMIN.recordings[id] = {evidence = 0, no_evidence = 1}
    end
  else
    local currentResults = ADMIN.recordings[id]

    if cheating then
      ADMIN.recordings[id] = {evidence = currentResults.evidence + 1, no_evidence = currentResults.no_evidence}
    else
      ADMIN.recordings[id] = {evidence = currentResults.evidence, no_evidence = currentResults.no_evidence + 1}
    end

    local updatedResults = ADMIN.recordings[id]

    -- Bans the suspect
    if updatedResults.evidence >= 3 then
      -- Deletes the recording
      ADMIN.recordings[id] = nil

      -- Todo, ban the player
    end

    -- Suspect seems to be legit
    if updatedResults.no_evidence >= 3 then
      -- Deletes the recording
      ADMIN.recordings[id] = nil
    end
  end

  local fetchedCases = CHEATING_CASE:fetchCases(source)
  TriggerClientEvent('RIVAL::refreshVideoList', source, fetchedCases)
end)

RegisterServerCallback('RIVAL::fetchCases', function(source)
  local fetchedCases = CHEATING_CASE:fetchCases(source)
  return fetchedCases
end)

CreateThread(function()
  while true do
    Wait(3600 * 1000) -- 1 hour

    -- Clear reports after x time
    CHEATING_CASE.activeReports = {}
    CHEATING_CASE.alreadyReported = {}
  end
end)
