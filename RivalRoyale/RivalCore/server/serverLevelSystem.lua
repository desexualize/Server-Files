LEVEL_SYSTEM = {}

function LEVEL_SYSTEM:getLevel(xp)
  local lastXp = 0
  local level = 0

  for _level, requiredXp in pairs(SHARED_CONFIG.levelSystem) do
    if xp >= requiredXp then
      lastXp = requiredXp
      level = _level
    else
      break
    end
  end

  return level
end

function LEVEL_SYSTEM:getXP(level)
  return SHARED_CONFIG.levelSystem[level]
end

function LEVEL_SYSTEM:getXpForNextLevel(currentLevel)
  for _level, requiredXp in pairs(SHARED_CONFIG.levelSystem) do
    if _level > currentLevel then
      return SHARED_CONFIG.levelSystem[_level]
    end
  end
end

function LEVEL_SYSTEM:getPlayerXP(player)
  if not player then
    return
  end

  local query = ('SELECT XP FROM rival_stats WHERE UID = %s'):format(player)
  local currentXp = DATABASE:queryResult(query)[1]

  return currentXp and currentXp.XP or 0
end
