CHALLENGES = {}
CHALLENGES.playerProgress = {}
CHALLENGES.list = {
  ['KILL 30 PEOPLE'] = {max = 30, reward = 2000},
  ['DIE 75 TIMES'] = {max = 75, reward = 2000},
  ['GET 10 HEADSHOTS'] = {max = 10, reward = 2000},
}

function CHALLENGES:getChallenges(source)
  local dailyChallenges = {}

  for title, challenge in pairs(CHALLENGES.list) do
    dailyChallenges[#dailyChallenges + 1] = {
      title = title,
      progress = CHALLENGES.playerProgress[source][title][1] or 0,
      maxProgress = challenge.max,
      rewardAmount = challenge.reward,
    }
  end

  return dailyChallenges
end

function CHALLENGES:rewardPlayer(source, rewardAmount)
  local player = RIVAL:getPlayer(source)
  local query = ('UPDATE rival_stats SET XP = XP + %s WHERE UID = %s'):format(rewardAmount, player)

  DATABASE:queryAsync(query)
end

function CHALLENGES:checkForCompletion(source, challenge)
  local challengeData = CHALLENGES.playerProgress[source][challenge]
  local selectChallenge = CHALLENGES.list[challenge]

  if not challengeData[2] and challengeData[1] >= selectChallenge.max then
    CHALLENGES.playerProgress[source][challenge][2] = true
    CHALLENGES:rewardPlayer(source, selectChallenge.reward)
  end
end

function CHALLENGES:registerKill(source)
  local challenge = 'KILL 30 PEOPLE'
  local currentProgress = CHALLENGES.playerProgress[source][challenge]

  -- Check so challenge hasnt been completed
  if not currentProgress[2] then
    CHALLENGES.playerProgress[source][challenge] = {currentProgress[1] + 1, false}
    CHALLENGES:checkForCompletion(source, challenge)
  end
end

function CHALLENGES:initPlayer(source)
  CHALLENGES.playerProgress[source] = {}

  for title, challenge in pairs(CHALLENGES.list) do
    CHALLENGES.playerProgress[source][title] = {0, false}
  end
end
