function RIVAL:loadPtfx(ptfxAsset)
  if not HasNamedPtfxAssetLoaded(ptfxAsset) then
    RequestNamedPtfxAsset(ptfxAsset)
    while not HasNamedPtfxAssetLoaded(ptfxAsset) do
      Wait(0)
    end
  end

  UseParticleFxAsset(ptfxAsset)
end

function RIVAL:loadModel(modelName)
  local modelHash
  if type(modelName) ~= 'string' then
    modelHash = modelName
  else
    modelHash = GetHashKey(modelName)
  end
  if IsModelInCdimage(modelHash) then
    if not HasModelLoaded(modelHash) then
      RequestModel(modelHash)
      while not HasModelLoaded(modelHash) do
        Wait(0)
      end
    end
    return modelHash
  else
    return nil
  end

  SetModelAsNoLongerNeeded(modelHash)
end

function RIVAL:loadCutscene(cut, flag1, flag2)
  if not flag1 then
    RequestCutscene(cut, 8)
  else
    RequestCutsceneEx(cut, flag1, flag2)
  end

  while not HasThisCutsceneLoaded(cut) do
    Wait(0)
  end
end

function RIVAL:loadAnimationSet(animSet)
  if not HasAnimSetLoaded(animSet) then
    RequestAnimSet(animSet)

    while not HasAnimSetLoaded(animSet) do
      Wait(0)
    end
  end

  return animSet
end

function RIVAL:loadAnimDict(animDict)
  if not HasAnimDictLoaded(animDict) then
    RequestAnimDict(animDict)

    while not HasAnimDictLoaded(animDict) do
      Wait(100)
    end
  end

  return animDict
end
