MAP = {}

-- Toggles the island, when enabled it will hide the main map.
function MAP:toggleIsland(value)
  SetIslandHopperEnabled('HeistIsland', value)
  SetToggleMinimapHeistIsland(value)

  -- misc natives
  SetAiGlobalPathNodesType(value)
  SetScenarioGroupEnabled('Heist_Island_Peds', value)

  -- audio stuff
  SetAudioFlag('PlayerOnDLCHeist4Island', value)
  SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', value, value)
  SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', value, value)
end
